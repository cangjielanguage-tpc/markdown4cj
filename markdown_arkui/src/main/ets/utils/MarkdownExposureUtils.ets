import { text } from '@kit.ArkGraphics2D'
import { NodeView } from '../model/NodeView'
import { spanSoftLineBreak } from './MarkdownUtils'

/**
 * 段落http链接曝光工具（显示/消失双向回调）
 *
 * 思路：段落Text挂TextController后，可用 controller.getLayoutManager().getRectsForRange(start, end)
 * 拿到任意字符区间在Text内的渲染矩形。我们按list渲染顺序手动累加字符偏移，记录每个http链接的
 * [rangeStart, rangeEnd)，再用getRectsForRange拿其矩形，与「段落在屏可见视口」求交 + 阈值判定，
 * 决定链接显示/消失，分别回调 visible=true/false。
 *
 * 曝光语义：链接 false→true 回调显示；true→false 回调消失。持续停留不重复；滚出后再滚入成对触发。
 * 不计次数、不计时长，由消费方按需累加。
 *
 * 注意：保留原生Span/ImageSpan渲染模型，本工具仅负责「算偏移 + 求交 + 翻转判定」，不改渲染。
 * 依赖 getRectsForRange（API 15+，工程 compatibleSdkVersion 已提到 5.0.1(15)）。
 */

/**
 * 判断url是否为http/https链接（仅这类链接参与曝光统计）
 *
 * @param url 链接url
 * @return 是否http/https
 */
export function isHttpLink(url?: string): boolean {
  if (url === undefined || url.length === 0) {
    return false
  }
  return url.startsWith('http://') || url.startsWith('https://')
}

/**
 * 按段落list渲染顺序累加字符偏移，按 linkUrl 聚合 http 链接的 [rangeStart, rangeEnd)。
 * 必须与 MarkdownParagraph.paragraphInlineItem 的渲染顺序一致，否则偏移对不上。
 *
 * 【两种链接渲染模式】
 *  1) 块状化（isLinkStyle=true）：Link 节点自身在 list 里，nodeType='Link'/'HeadLink'，
 *     nodeText=整段链接文本，linkUrl 在自身。→ 单节点即一个链接区间。
 *  2) 平铺（isLinkStyle=false，默认）：Link 节点不在 list，其子节点（Text/Code/Image...）
 *     被平铺进 list，共享同一个 linkUrl（经 copyStyleFrom 继承）。→ 连续多个子节点
 *     属于同一链接，需聚合成一个区间，只计一次曝光。
 *
 * 聚合规则：遍历 list，遇到带 http linkUrl 的子节点，若与「当前聚合中的链接」url 相同，
 * 则并入当前区间（更新 rangeEnd）；否则闭合旧区间、开启新区间。代表节点取区间内第一个
 * 子节点（_linkVisible 挂其上）。
 *
 * 字符增量规则（与渲染端一一对应，任何带 linkUrl 的子节点都按其自身渲染占位计长）：
 *   Text/Code/Footnote/Link/HeadLink → nodeText.length
 *   SoftLineBreak            → spanSoftLineBreak(isLineBreak).length（1）
 *   HardLineBreak            → 1（"\n"）
 *   Image/StyleImage/ImageHtmlNode → 1（ImageSpan按占1字符位U+FFFC）
 *   LatexMathNode            → 有PixelMap时1，无图降级nodeText.length
 *
 * @param children 段落子节点（this.list）
 * @param isLineBreak 全局isLineBreak设置（影响SoftLineBreak渲染）
 * @param footnotePrefixLen 段落开头脚注前缀[^id]: 的字符数（无脚注时传0）
 * @return http链接代表节点列表（含已写回的rangeStart/rangeEnd，按聚合区间）
 */
export function computeLinkRanges(
  children: NodeView[],
  isLineBreak: boolean,
  footnotePrefixLen: number
): NodeView[] {
  const httpLinks: NodeView[] = []
  let offset: number = footnotePrefixLen
  // 当前聚合中的 http 链接：代表节点 + url，用于判定后续子节点是否并入
  let curRep: NodeView | null = null
  let curUrl: string = ''
  const flushCurrent = (): void => {
    if (curRep !== null) {
      httpLinks.push(curRep)
      curRep = null
      curUrl = ''
    }
  }
  for (const child of children) {
    const nt: string = child.nodeType
    // 先算本子节点占的字符长度（与渲染端 Span/ImageSpan 占位一致）
    let len: number
    if (nt === 'SoftLineBreak') {
      len = spanSoftLineBreak(isLineBreak).length
    } else if (nt === 'HardLineBreak') {
      len = 1
    } else if (nt === 'Image' || nt === 'StyleImage' || nt === 'ImageHtmlNode') {
      len = 1
    } else if (nt === 'LatexMathNode') {
      if (child.latexPixelMap !== undefined && child.latexImageWidth > 0 && child.latexImageHeight > 0) {
        len = 1
      } else {
        len = child.nodeText.length
      }
    } else {
      // Text/Code/Footnote/Link/HeadLink 及其它：按 nodeText 长度
      len = child.nodeText.length
    }
    // 处理 linkUrl 聚合（块状 Link 节点自身带 linkUrl 也命中）
    const childUrl: string = isHttpLink(child.linkUrl) ? (child.linkUrl ?? '') : ''
    if (childUrl.length > 0) {
      if (curRep !== null && childUrl === curUrl) {
        // 同一链接的后续子节点：并入区间（rangeEnd 延伸到本子节点结束）
        curRep.rangeEnd = offset + len
      } else {
        // 新链接：先闭合旧区间，再开启新区间，代表节点=本子节点
        flushCurrent()
        curRep = child
        curUrl = childUrl
        child.rangeStart = offset
        child.rangeEnd = offset + len
      }
    } else {
      // 非链接子节点：打断聚合（同一链接的子节点必连续，遇到非链接即闭合）
      flushCurrent()
    }
    offset += len
  }
  flushCurrent()
  return httpLinks
}

/**
 * 段落可见视口（相对 Text 内容区原点，单位 px）。
 * 由调用方用「Text 全局坐标 + 屏幕高度 + 水平容器范围」求交后填入。
 */
export interface ParagraphViewport {
  /** 是否已拿到有效视口（globalPosition + 屏幕高度都已就绪） */
  ready: boolean
  /** 可见区上边界（相对Text内容区原点，px） */
  clipTopPx: number
  /** 可见区下边界（相对Text内容区原点，px，exclusive） */
  clipBottomPx: number
  /** 可见区左边界（相对Text内容区原点，px）。段落Text不横滚，恒为0；表格cell横滚时为cell在容器可见区的水平偏移 */
  clipLeftPx: number
  /** 可见区右边界（相对Text内容区原点，px，exclusive）。段落Text不横滚，恒=widthPx；表格cell横滚时为cell左偏移+可见宽 */
  clipRightPx: number
  /** 可见区宽度（px，兼容旧字段，=clipRightPx-clipLeftPx） */
  widthPx: number
}

/**
 * 曝光评估结果：本次发生翻转的链接。
 */
export interface ExposureEvalResult {
  /** 从不可见→可见的链接（调用方报 visible=true） */
  becameVisible: NodeView[]
  /** 从可见→不可见的链接（调用方报 visible=false） */
  becameHidden: NodeView[]
}

/**
 * 单个组件的布局快照（窗口坐标系 px）。
 *
 * 当前唯一用途：表格横向 body Scroll 容器的页面矩形（MarkdownTable @Provide
 * 'mdTableContainerSnap'，容器 onAreaChange 逐帧推送刷新，TableCell @Consume 消费），
 * 供链接曝光评估做水平求交裁剪。
 *
 * 说明：块级矩形既不逐帧推送也不按 id 主动查询（componentUtils/UIContext 版底层都是
 * Inspector::GetInspectorByKey 全窗口组件树线性查找 + 构建 Inspector JSON，单次≈423µs，
 * 不能放进逐帧曝光链路）——块自身矩形已改由 MarkdownNodeRectReader 句柄直读，
 * 不再走本快照的「低频采样 + 刚性平推」机制。
 */
export class ExposureRectSnapshot {
  /** 组件窗口左边界（px） */
  left: number = Number.NaN
  /** 组件窗口上边界（px） */
  top: number = Number.NaN
  /** 组件宽度（px） */
  width: number = 0
  /** 组件高度（px） */
  height: number = 0
  /** 记录快照时的根矩形窗口顶（px）；表格容器快照不用垂直信息固定传 0 */
  rootTop: number = Number.NaN

  capture(left: number, top: number, width: number, height: number, rootTop: number): void {
    this.left = left
    this.top = top
    this.width = width
    this.height = height
    this.rootTop = rootTop
  }

  /** 快照是否可用于评估（已被 onAreaChange 捕获过、坐标有效） */
  valid(): boolean {
    return !Number.isNaN(this.top) && !Number.isNaN(this.rootTop)
  }
}

/**
 * 预算每个链接在 Text 内的渲染矩形并缓存（与 httpLinks 一一对应）。
 *
 * 链接 TextBox 只与「文本内容/宽度/字号」有关，与滚动无关，因此同一份布局下滚动期间不必重算。
 * 调用方在 onSizeChange / 内容变更时置脏重算即可。
 *
 * @param controller 段落Text的TextController
 * @param httpLinks 参与曝光的链接列表（含rangeStart/rangeEnd）
 * @return 与 httpLinks 一一对应的TextBox数组；null 表示文本尚未完成布局（调用方保持脏标记，下次再算）
 */
export function computeLinkBoxes(
  controller: TextController,
  httpLinks: NodeView[]
): Array<Array<text.TextBox>> | null {
  const lm: LayoutManager | null = controller.getLayoutManager()
  if (lm === null || lm === undefined) {
    return null
  }
  const result: Array<Array<text.TextBox>> = []
  let hasRange: boolean = false
  let hasBox: boolean = false
  for (const link of httpLinks) {
    const start: number = link.rangeStart
    const end: number = link.rangeEnd
    if (end > start) {
      hasRange = true
    }
    let boxes: Array<text.TextBox> = []
    try {
      boxes = lm.getRectsForRange(
        { start: start, end: end },
        text.RectWidthStyle.TIGHT, text.RectHeightStyle.TIGHT
      )
    } catch (e) {
      return null
    }
    if (boxes.length > 0) {
      hasBox = true
    }
    result.push(boxes)
  }
  // 存在有效区间却一个矩形都拿不到 → 文本尚未完成布局，缓存空结果会导致链接永远判不可见，故不缓存
  if (hasRange && !hasBox) {
    return null
  }
  return result
}

/**
 * 评估当前http链接的可见性，与「段落在屏可见视口」求交 + 阈值判定。
 * - 不可见→可见翻转 → markLinkVisible，进 becameVisible（调用方报 visible=true）
 * - 可见→不可见翻转 → markLinkHidden，进 becameHidden（调用方报 visible=false）
 *
 * 可见判定：链接所有 TextBox 与视口的交集面积之和 / 链接所有 TextBox 面积之和 ≥ threshold。
 * threshold=0 退化为「任意像素相交即可见」（对齐 HTML thresholdPercent=0）。
 *
 * @param viewport 段落在屏可见视口
 * @param threshold 可见阈值（0~1）
 * @param httpLinks 参与曝光的链接列表（含rangeStart/rangeEnd）
 * @param boxes 与 httpLinks 一一对应的链接矩形（computeLinkBoxes 预算并缓存；视口无效时可传空数组）
 * @return 本次发生翻转的链接：becameVisible（需报visible=true）、becameHidden（需报visible=false）
 */
export function evaluateLinkExposure(
  viewport: ParagraphViewport,
  threshold: number,
  httpLinks: NodeView[],
  boxes: Array<Array<text.TextBox>>
): ExposureEvalResult {
  const becameVisible: NodeView[] = []
  const becameHidden: NodeView[] = []
  // 水平可见区：优先用 clipLeftPx/clipRightPx，旧调用方未填时退化为 [0, widthPx]
  const vLeft: number = viewport.clipRightPx > viewport.clipLeftPx ? viewport.clipLeftPx : 0
  const vRight: number = viewport.clipRightPx > viewport.clipLeftPx ? viewport.clipRightPx : viewport.widthPx
  const vTop: number = viewport.clipTopPx
  const vBottom: number = viewport.clipBottomPx
  if (!viewport.ready || vBottom <= vTop || vRight <= vLeft) {
    // 视口无效（未拿到全局坐标 / 整段在屏外 / 水平无可见区）→ 所有链接判为不可见
    for (const link of httpLinks) {
      if (link.markLinkHidden()) {
        becameHidden.push(link)
      }
    }
    const result: ExposureEvalResult = { becameVisible: becameVisible, becameHidden: becameHidden }
    return result
  }
  for (let i = 0; i < httpLinks.length; i++) {
    const link: NodeView = httpLinks[i]
    // 用缓存好的链接矩形（滚动期间不重算文本布局）
    const linkBoxes: Array<text.TextBox> = i < boxes.length ? boxes[i] : []
    // 汇总：链接总面积 + 与视口交集面积（多行链接有多个 TextBox）
    let linkArea: number = 0
    let interArea: number = 0
    for (const box of linkBoxes) {
      const r = box.rect
      const bw: number = r.right - r.left
      const bh: number = r.bottom - r.top
      if (bw <= 0 || bh <= 0) {
        continue
      }
      linkArea += bw * bh
      // 矩形相交
      const ix1: number = Math.max(r.left, vLeft)
      const iy1: number = Math.max(r.top, vTop)
      const ix2: number = Math.min(r.right, vRight)
      const iy2: number = Math.min(r.bottom, vBottom)
      if (ix2 > ix1 && iy2 > iy1) {
        interArea += (ix2 - ix1) * (iy2 - iy1)
      }
    }
    // 可见：交集占比 ≥ 阈值（linkArea=0 视为不可见，避免除零）
    // threshold=0 语义为「露出任意像素即可见」，因此要求 interArea > 0；
    // 若仍用 >=0 会导致完全未进入视口的链接也被判为可见，初始化即全部标记，后续不再触发曝光。
    let visible: boolean
    if (threshold <= 0 || Number.isNaN(threshold)) {
      visible = linkArea > 0 && interArea > 0
    } else {
      visible = linkArea > 0 && (interArea / linkArea) >= threshold
    }
    if (visible) {
      if (link.markLinkVisible()) {
        becameVisible.push(link)
      }
    } else {
      if (link.markLinkHidden()) {
        becameHidden.push(link)
      }
    }
  }
  const result: ExposureEvalResult = { becameVisible: becameVisible, becameHidden: becameHidden }
  return result
}
