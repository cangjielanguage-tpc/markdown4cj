import { image } from "@kit.ImageKit"
import { resourceColorToNumber, LINK_ICON_TYPE_CIRCLE, LINK_ICON_TYPE_RECT, COLOR_TRANSPARENT,
  COLOR_FF4A90E2,
  COLOR_FF191919,
  COLOR_FF808080,
  COLOR_WHITE,
  COLOR_FFF5F2F0} from "../base/Constants"
import { latexStringToImage, LatexMathColorFormat } from "@cangjie-tpc/formula_hybrid"
import { CellWidthTracker } from "../model/CellWidthTracker"
import { LatexParseQueue } from "../model/LatexParseQueue"
import { NodeView } from "../model/NodeView"
import { MarkdownExposureEvent } from "../model/MarkdownExposureEvent"
import {
  computeLinkRanges,
  computeLinkBoxes,
  evaluateLinkExposure,
  ExposureRectSnapshot,
  ParagraphViewport
} from "../utils/MarkdownExposureUtils"
import display from "@ohos.display"
import { text } from "@kit.ArkGraphics2D"
import { PromptAction } from "@kit.ArkUI"
import { MarkdownVisibleRectHolder, MarkdownVisibleRectSnapshot } from "../model/MarkdownVisibleRectHolder"
import { MarkdownExposureAttributeModifier } from "../utils/MarkdownExposureAttributeModifier"
import { TableScrollState } from "../model/TableScrollState"
import { BlockQuoteTheme } from "../theme/BlockQuoteTheme"
import { BoldTheme } from "../theme/BoldTheme"
import { DefinitionListTheme } from "../theme/DefinitionListTheme"
import { FootnoteRefTheme } from "../theme/FootnoteRefTheme"
import { GlobalTheme } from "../theme/GlobalTheme"
import { HeadingTheme } from "../theme/HeadingTheme"
import { HighlightTheme } from "../theme/HighlightTheme"
import { HtmlUnderlineTheme } from "../theme/HtmlUnderlineTheme"
import { ImageTheme } from "../theme/ImageTheme"
import { InlineCodeTheme } from "../theme/InlineCodeTheme"
import { ItalicTheme } from "../theme/ItalicTheme"
import { LatexMathTheme } from "../theme/LatexMathTheme"
import { LinkTheme } from "../theme/LinkTheme"
import { ParagraphTheme } from "../theme/ParagraphTheme"
import { StrikethroughTheme } from "../theme/StrikethroughTheme"
import { SubTheme } from "../theme/SubTheme"
import { SupTheme } from "../theme/SupTheme"
import { TableTheme } from "../theme/TableTheme"
import {
  buildInlineItemKey,
  imageUrlHandle, imageWidthAndHeight, lengthToVpNumber,
  safeString,
  spanSoftLineBreak
} from "../utils/MarkdownUtils"
import {
  generateLinkIconPixelMap, computeLinkIconInfo, LinkIconResult
} from "../utils/MarkdownLinkIconGenerator"
import {
  spanBackgroundColor,
  spanBaselineOffset,
  spanDecoration,
  spanFontColor,
  spanFontFamily,
  spanFontSize,
  spanFontStyle,
  spanFontWeight,
  spanLetterSpacing,
  spanLineHeight,
  tableCellBackgroundColor
} from "../utils/MarkdownThemeUtils"
import { MarkdownHighlightParagraph } from "../configs/MarkdownHighlightParagraph"
import { pasteboard } from "@kit.BasicServicesKit"

/**
 * 表格格子控件
 */
@Component
export struct MarkdownTableCell {
  @Consume placeholderPixelMap: PixelMap | undefined // 图片占位图
  @ObjectLink @Watch('refreshData') node: NodeView // 表格格子自身节点数据
  @ObjectLink headingTheme: HeadingTheme // 标题样式
  @ObjectLink globalTheme: GlobalTheme // 整体样式
  @ObjectLink blockQuoteTheme: BlockQuoteTheme // 块引用样式
  @ObjectLink subTheme: SubTheme // 下标样式
  @ObjectLink supTheme: SupTheme // 上标样式
  @ObjectLink inlineCodeTheme: InlineCodeTheme // 内联代码样式
  @ObjectLink boldTheme: BoldTheme // 加粗样式
  @ObjectLink italicTheme: ItalicTheme // 斜体样式
  @ObjectLink strikethroughTheme: StrikethroughTheme // 删除线样式
  @ObjectLink highlightTheme: HighlightTheme // 高亮样式
  @ObjectLink htmlUnderlineTheme: HtmlUnderlineTheme // 下划线样式
  @ObjectLink linkTheme: LinkTheme // 链接样式
  @ObjectLink footnoteRefTheme: FootnoteRefTheme // 内联脚注样式
  @ObjectLink tableTheme: TableTheme // 表格样式
  @ObjectLink paragraphTheme: ParagraphTheme // 段落样式
  @ObjectLink definitionListTheme: DefinitionListTheme // 定义列表样式
  @ObjectLink imageTheme: ImageTheme // 图片样式
  @ObjectLink latexMathTheme: LatexMathTheme // 数学公式样式
  @ObjectLink markdownHighlightParagraph: MarkdownHighlightParagraph // 段落高亮配置
  @Prop componentWidth: number = 0.0 // 父布局控件宽度
  textCopyCallback?: (text: string) => void // 文本复制的点击事件
  footnoteCallback?: (index: string) => void // 脚注点击事件
  tocCallback?: (index: number) => void // TOC/标题ID点击事件
  linkCallback?: (url: string) => void // 链接点击事件
  imageCallback?: (url: string) => void // 图片点击事件
  imageDownloadCallback?: (url: string) => void // 图片下载事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> // 图片替换回调
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  customLongPressCallback?: (str: string) => void = undefined // 自定义长按事件
  @Prop tableBlockCellRow: number // 表格的第几行
  @Prop tableBlockCellCell: number // 表格的第几条
  @Prop tableBlockCellCellSize: number // 表格总共有几列
  @Prop tableBlockCellRowSize: number // 表格总共有几行
  @Consume('tableColumnWidths') columnWidths: number[] // 各列宽度快照（@Consume从MarkdownTable同步）
  @Consume cellWidthTracker: CellWidthTracker // 列宽跟踪器（非@Observed，onSizeChange只写不触发重渲染）
  @Consume isLatexMathEnabled: boolean // 数学公式插件是否启用
  // 表格横向body Scroll容器页面矩形快照（MarkdownTable 的容器 onAreaChange 逐帧推送，@Consume 同步）。
  // cell 滚出容器水平范围 = 被表格横向clip = 不可见。只读 left/width（水平裁剪用）。
  @Consume('mdTableContainerSnap') tableContainerSnap: ExposureRectSnapshot
  // 表格横滚偏移共享（MarkdownTable 的 body Scroll onScroll 逐帧更新+广播，@Consume 同步引用）。
  // 非@Observed：引用恒定不触发重渲染；横滚感知走监听器（aboutToAppear 注册）。
  @Consume('mdTableScrollState') tableScrollState: TableScrollState
  // CJMarkdown 根节点可见矩形（页面坐标系 px）。垂直裁剪窗口=cell全局rect与该矩形求交，
  // 替代整屏高度——避免 cell 被标题栏/面板/系统栏遮挡时仍判可见（过报）。与 MarkdownParagraph 对称。
  @Consume('mdVisibleRectHolder') visibleRectHolder: MarkdownVisibleRectHolder
  @State @Watch('onListChanged') list: NodeView[] = [] // 表格格子子节点数据源
  private isAlive: boolean = true // 组件是否存活
  // —— 曝光统计（照搬 MarkdownParagraph） ——
  elementExposureCallback?: (event: MarkdownExposureEvent) => void // 元素曝光回调（透传）
  exposureThreshold: number = 0.5 // 曝光阈值（透传）
  private textController: TextController = new TextController() // 用于getRectsForRange取链接渲染矩形
  private httpLinks: NodeView[] = [] // 本段落内的http链接节点
  private httpLinksDirty: boolean = true // httpLinks 是否需重算（首次/config同步后/refreshData后置脏）
  private linkBoxes: Array<Array<text.TextBox>> = [] // 与httpLinks一一对应的链接渲染矩形（滚动期复用，不重算）
  private linkBoxesDirty: boolean = true // linkBoxes 是否需重算（内容/尺寸变化才置脏）
  private rectSnap: ExposureRectSnapshot = new ExposureRectSnapshot() // 格内Text在窗口中的布局快照（低频采样：仅内容变化时查询一次，滚动中由 estimateTop 平推，评估只读快照）
  private cellId: string = '' // 格内Text组件id：低频位置采样查询（getRectangleById 按 id 定位）用
  private rectBaseDirty: boolean = true // 布局base是否需重采样（首次/尺寸变化/ratio校验发现漂移时置脏，评估入口采样一次）
  private pendingRatio: number = -1 // onVisibleAreaChange 最近一次真实可见比例（-1=无），供评估时校验平推位置是否漂移
  private contLeftAtSample: number = Number.NaN // 采样base时容器的窗口left（NaN=未就绪）：整表平移修正用，cell相对容器的水平偏移在无重排时恒定
  private contScrollXAtSample: number = 0 // 采样base时容器横滚偏移（vp）：横滚平推基准，cell相对滚动内容的水平偏移在横滚中恒定
  private exposureTimerId: number = -1 // 曝光评估节流定时器
  @State exposureModifier: MarkdownExposureAttributeModifier = new MarkdownExposureAttributeModifier() // 曝光回调条件注册（未启用曝光零注册零税）
  private exposureRegistered: boolean = false // modifier 当前是否已按"启用"注册（翻转检测用）
  private screenHeightPx: number = 0 // 屏幕高度(px，兜底用：visibleRectHolder未就绪时退化裁剪窗口)
  private screenWidthPx: number = 0 // 屏幕宽度(px，兜底用：容器快照未就绪时水平右边界退化)
  // CJMarkdown根可见矩形变化监听器（滚动/根尺寸变化时重算曝光）。aboutToAppear注册/aboutToDisappear注销。
  private visibleRectListener: (r: MarkdownVisibleRectSnapshot) => void = () => {}
  // 表格横滚变化监听器（横滚逐帧广播触发重评，感知链接水平进出）。aboutToAppear注册/aboutToDisappear注销。
  private tableScrollListener: () => void = () => {}
  private prevTextLength: number = 0 // 上次list的文本总长度，用于检测内容缩短时清除列宽（如原始markdown→渲染后的链接）

  @State textBackgroundColor: ResourceColor = COLOR_TRANSPARENT // 被长按段落实时背景颜色
  @State selectBackgroundColor: ResourceColor = COLOR_FF4A90E2 // 选中文本的背景颜色
  @State selectStart: number = 0 // 选中文本的开始位置
  @State selectEnd: number = 0 // 选中文本的结束位置
  private promptAction: PromptAction = this.getUIContext().getPromptAction()
  private delayTime: number = 300 // 自定义菜单关闭延时时间（毫秒）
  private timerId: number = -1 // 自定义菜单关闭延时定时器 ID
  @State @Watch('onParamChange') needHideMenu: boolean = false // 需要监听的条件参数
  @BuilderParam blockImageCardComponent: (desc:string, imageSrc:string, title:string) => void
  @BuilderParam blockLinkCardComponent: (desc:string, link:string, title:string) => void


  // 是否启用元素曝光统计：仅当 elementExposureCallback 已设置时为 true。
  // 未设回调时短路掉 computeLinkRanges/getRectsForRange/监听器/onVisibleAreaChange 等，省 CPU。
  // 用普通方法而非 getter：规避 @Component struct 内 private get 在模板字符串/条件判断中的 quirks。
  private isExposureEnabled(): boolean {
    return this.elementExposureCallback !== undefined
  }

  aboutToAppear(): void {
    this.cellId = 'md-c-' + this.node.nodeHash // 组件id：供 getRectangleById 低频位置采样定位
    for (const child of this.node.children) {
      if (child.nodeType === "LatexMathNode" && child.latexPixelMap === undefined && child.latexIsLoading) {
        child.latexIsLoading = false
      }
    }
    this.refreshData() // 首次加载（refreshData设置list，onListChanged内调用tryReplaceImages/tryGenerateLinkIcons）
    // 监听器无条件注册：aboutToAppear 时刻 config 可能尚未与父组件同步（详情页在自身 aboutToAppear
    // 才给 markdownConfiguration 赋带回调的新对象），此刻 elementExposureCallback 可能是 undefined。
    // 若在此一次性门控会永久判 false。改为无条件注册，由 scheduleExposure/回调内部按运行时
    // exposureEnabled 短路。与 MarkdownParagraph 对称。
    this.visibleRectListener = (_r) => {
      this.scheduleExposure()
    }
    this.visibleRectHolder.addListener(this.visibleRectListener)
    // 横滚监听器无条件注册（同上时序考虑）：onScroll 广播每帧触发，由 scheduleExposure
    // 的曝光开关门控+防抖合并；未启用曝光时 Table 侧已短路不广播，这里是双保险。
    this.tableScrollListener = () => {
      this.scheduleExposure()
    }
    this.tableScrollState.addListener(this.tableScrollListener)
  }

  aboutToDisappear(): void {
    this.isAlive = false
    // 监听器在 aboutToAppear 无条件注册，故此处无条件移除（removeListener 对未注册者是 no-op，安全）
    this.visibleRectHolder.removeListener(this.visibleRectListener)
    this.tableScrollState.removeListener(this.tableScrollListener)
    if (this.exposureTimerId !== -1) {
      clearTimeout(this.exposureTimerId)
      this.exposureTimerId = -1
    }
    if (this.timerId !== -1) {
      clearTimeout(this.timerId)
      this.timerId = -1
    }
    // 组件回收时，对当前可见的链接补发一次 visible=false（保证显示/消失成对），再重置标志。
    // 按运行时 exposureEnabled 门控：没回调则 httpLinks 恒空、无可见链接，跳过。
    if (this.isExposureEnabled()) {
      for (const link of this.httpLinks) {
        if (link.isLinkVisible()) {
          link.markLinkHidden()
          this.elementExposureCallback?.({ eventType: 'link', visible: false, data: link.linkUrl ?? '' })
        }
      }
    }
  }

  /**
   * 拿屏幕高度（px）。display.getDefaultDisplaySync 在 aboutToAppear 之前可能拿不到，
   * 故每次评估前兜底取一次。拿到后缓存。快照坐标经 vp2px 转换后也是 px，单位一致。
   */
  private ensureScreenHeight(): void {
    if (this.screenHeightPx > 0) {
      return
    }
    try {
      const d = display.getDefaultDisplaySync()
      this.screenHeightPx = d.height
    } catch (e) {
      // ignore，下次再取
    }
  }

  /**
   * 拿屏幕宽度（px）。表格横向滚动时，cell 滚出屏幕右边界用此判定不可见。
   */
  private ensureScreenWidth(): void {
    if (this.screenWidthPx > 0) {
      return
    }
    try {
      const d = display.getDefaultDisplaySync()
      this.screenWidthPx = d.width
    } catch (e) {
      // ignore，下次再取
    }
  }

  /**
   * 曝光注册状态同步：曝光开关翻转时重建 modifier（@State 引用变化触发 build 重跑，
   * applyNormalAttribute 按新状态挂/卸 onSizeChange/onVisibleAreaChange）。
   * 未启用曝光的接入方恒 false、永不翻转，Text 上零注册，引擎可见性遍历税为零。
   */
  private syncExposureRegistration(): void {
    const enabledNow: boolean = this.isExposureEnabled()
    if (enabledNow === this.exposureRegistered) {
      return
    }
    this.exposureRegistered = enabledNow
    const mod: MarkdownExposureAttributeModifier = new MarkdownExposureAttributeModifier()
    mod.setEnabled(enabledNow)
    mod.setSizeCallback(() => {
      this.onExposureSizeChanged()
    })
    mod.setVisibleRatioCallback((ratio: number) => {
      this.onExposureVisibleRatio(ratio)
    })
    this.exposureModifier = mod
  }

  /**
   * modifier 分发的 onVisibleAreaChange 回调（已按曝光开关条件注册，但关曝光后已注册的
   * 无法撤销，此处仍按运行时开关门控兜底）。仅作触发用，不用 isVisible 布尔门控可见性
   * （实测滑动中会翻转竞态导致漏报）。真正的可见性由 evaluateLinkExposure 的
   * 「链接rect ∩ 格在屏可见视口」判定。
   */
  private onExposureVisibleRatio(ratio: number): void {
    if (!this.isAlive || !this.isExposureEnabled()) {
      return
    }
    this.pendingRatio = ratio // 存下供评估时校验平推位置是否漂移（前序内容重排/吸顶位移自愈）
    this.scheduleExposure()
  }

  /**
   * modifier 分发的 onSizeChange 回调：尺寸变化会改变文本布局与自身高度，链接矩形缓存失效。
   * 窗口位置不在滚动期逐帧获取，由评估入口的 sampleRectBase 低频采样 + 平推。
   */
  private onExposureSizeChanged(): void {
    if (!this.isAlive || !this.isExposureEnabled()) {
      return
    }
    this.linkBoxesDirty = true
    this.rectBaseDirty = true // 尺寸变化=内容重排，布局base需要重新采样
    this.scheduleExposure()
  }

  /**
    * 防抖触发曝光评估。合并连续的 onSizeChange/onVisibleAreaChange/holder矩形移动通知/refreshData 触发。
   * 评估后对「本次显示」的链接回调 visible=true，「本次消失」的回调 visible=false。
   *
   * 位置来源（对应性能方案「缺陷1/3」）：不做逐帧 onAreaChange 推送——注册即常驻，滚动中所有挂载
   * 组件每帧触发框架侧 Area 对比+对象构造+跨层分发，未启用曝光的使用方也被迫交税。改为
   * 「内容变化才低频采样（sampleRectBase，getRectangleById 单次≈423µs，频率=内容变化频率，滚动零查询）
   * + 滚动平推（estimateTop：滚动是刚性的，cell 相对根的垂直偏移在内容不变时恒定；
   * 横向滚动同理，cell 相对容器的水平偏移恒定，用采样时记录的容器 left 平推）」，
   * 平推位置漂移由 onVisibleAreaChange 的真实 ratio 校验发现并自愈。
   * 链接矩形走 linkBoxes 缓存，只有内容/尺寸变化才重算 getRectsForRange（缺陷4）。
   */
  private scheduleExposure(): void {
    if (!this.isAlive) {
      return
    }
    this.syncExposureRegistration()
    // 未设曝光回调时直接短路（兜底：holder通知 仍会触发本方法；modifier 回调内部也有门控）
    if (!this.isExposureEnabled()) {
      return
    }
    // 懒补算：aboutToAppear→refreshData 首跑时 config 可能尚未同步（exposureEnabled=false 跳过了 computeLinkRanges），
    // config 同步后 holder 通知/事件触发本方法，此处 httpLinks 仍为脏（dirty=true）。检测到 dirty 则补算一次（cell 无脚注前缀），
    // 算完置 clean，避免无链接 cell 每次 scheduleExposure 都重算。
    if (this.httpLinksDirty && this.list.length > 0) {
      this.httpLinks = computeLinkRanges(this.list, this.globalTheme.isLineBreak, 0)
      this.httpLinksDirty = false
      this.linkBoxesDirty = true
    }
    // 仍无http链接的cell不参与曝光评估（省性能）
    if (this.httpLinks.length === 0) {
      return
    }
    if (this.exposureTimerId !== -1) {
      // 已有 pending 评估：本次触发合并掉（省 clearTimeout/setTimeout；滚动期每帧多次触发只开一个 timer，
      // timer 回调读到的快照/holder 都是最新值，不丢状态）
      return
    }
    this.exposureTimerId = setTimeout(() => {
      this.exposureTimerId = -1
      this.evaluateExposure()
    }, 0)
  }

  /**
   * 低频采样格内Text窗口矩形 base（仅 rectBaseDirty 时由评估入口调用）。
   * getRectangleById 底层是 Inspector 全树查找（单次≈423µs），只在内容变化（首帧/尺寸变化/漂移自愈）
   * 时调用，滚动全程零查询；采样时的 rootTop 一并存入快照，滚动中由 estimateTop(rootTop) 平推，
   * 采样时的容器 left 存入 contLeftAtSample，横滚中由「容器left + 相对水平偏移」平推。
   */
  private sampleRectBase(): void {
    this.rectBaseDirty = false
    try {
      const rect = this.getUIContext().getComponentUtils().getRectangleById(this.cellId)
      if (!rect || !rect.windowOffset || !rect.size) {
        this.rectBaseDirty = true // 组件尚未挂载完成，下次评估再试
        return
      }
      this.rectSnap.capture(rect.windowOffset.x, rect.windowOffset.y,
        rect.size.width, rect.size.height, this.visibleRectHolder.rectTop)
      this.contLeftAtSample = this.tableContainerSnap.valid() ? this.tableContainerSnap.left : Number.NaN
      this.contScrollXAtSample = this.tableScrollState.x // 横滚平推基准（与estimateTop的rootTop对称）
    } catch (e) {
      this.rectBaseDirty = true // 查询异常（组件销毁等），下次评估再试
    }
  }

  /**
   * 执行一次曝光评估（防抖后调用）：解算格内Text与表格容器的页面矩形 → 求交得可见视口 → 评估链接翻转。
   */
  private evaluateExposure(): void {
    if (!this.isAlive || !this.isExposureEnabled()) {
      return
    }
    this.ensureScreenHeight()
    if (this.screenHeightPx <= 0) {
      return
    }
    this.ensureScreenWidth() // 兜底用：容器快照未就绪时用屏幕宽做水平右边界
    // 位置解算（最多两遍）：base 脏则低频采样，否则读快照平推；第一遍算完用真实 ratio 校验平推
    // 是否漂移（前序内容重排/吸顶位移移动了本 cell，base 过期），漂移则重采样再算一遍。
    for (let attempt = 0; attempt < 2; attempt++) {
      if (this.rectBaseDirty) {
        this.sampleRectBase()
        if (!this.rectSnap.valid()) {
          // 首次采样未成功（组件尚未挂载），本次跳过，等下次评估
          return
        }
      }
      const rootTop: number = this.visibleRectHolder.rectTop
      // 格内Text相对窗口的矩形（px）：垂直平推（estimateTop：滚动刚性，相对根偏移恒定）
      const cellTop: number = Number.isNaN(rootTop) ? this.rectSnap.top : this.rectSnap.estimateTop(rootTop)
      const cellBottom: number = cellTop + this.rectSnap.height
      // 水平平推（两级正交修正）：
      // 1. 横滚平推：cell相对滚动内容的水平偏移在横滚中恒定（Scroll内容左移=cell页面x减小），
      //    cellLeft -= 当前横滚偏移 − 采样时偏移（vp差值经vp2px转px）
      // 2. 整表平移修正：cell相对容器的水平偏移在无重排时恒定（窗口resize等整表页面平移），
      //    cellLeft = 容器当前left + (cellLeft修正后 − 采样时容器left)
      // 容器未就绪时退化为采样值。
      let cellLeft: number = this.rectSnap.left - vp2px(this.tableScrollState.x - this.contScrollXAtSample)
      if (!Number.isNaN(this.contLeftAtSample) && this.tableContainerSnap.valid()) {
        cellLeft = this.tableContainerSnap.left + (cellLeft - this.contLeftAtSample)
      }
      const cellRight: number = cellLeft + this.rectSnap.width
      const useVis: boolean = this.visibleRectHolder.visReady
      // ratio 校验（仅跨阈值触发时 pendingRatio 有效）：引擎真实可见比例（面积口径，含横滚水平裁剪）
      // vs 平推位置的理论可见比例。校验窗口必须用真实窗口 [0, screenH]（与引擎 onVisibleAreaChange
      // 的可见口径一致），不能用 vis 估算窗口——vis 是估算（整文高×ratio 推算），误差可达可见高度
      // 级别，会把「无漂移」误判成漂移，导致滚动/横滚期每次跨阈值都重采样查询（423µs/次），
      // 击穿滚动零查询。水平用容器区间（引擎对容器 clip 外的部分同样不算可见）。
      if (attempt === 0 && this.pendingRatio >= 0 && !Number.isNaN(rootTop)
        && this.rectSnap.height > 0 && this.rectSnap.width > 0) {
        let chkContLeft: number = 0
        let chkContRight: number = this.screenWidthPx
        if (this.tableContainerSnap.valid()) {
          chkContLeft = this.tableContainerSnap.left
          chkContRight = chkContLeft + this.tableContainerSnap.width
        }
        const chkClipH: number = Math.max(0, Math.min(this.screenHeightPx, cellBottom)
          - Math.max(0, cellTop)) // 垂直可见高（∩真实窗口）
        const chkClipW: number = Math.max(0, Math.min(cellRight, chkContRight)
          - Math.max(cellLeft, chkContLeft)) // 水平可见宽（∩容器，max(0)兜住完全滚出容器的负值）
        const theoryRatio: number = (chkClipH * chkClipW) / (this.rectSnap.height * this.rectSnap.width)
        if (Math.abs(theoryRatio - this.pendingRatio) > 0.02) {
          // 平推位置漂移：base 过期，重采样自愈（第二遍重算位置）
          this.pendingRatio = -1
          this.rectBaseDirty = true
          continue
        }
      }
      this.pendingRatio = -1 // 用完清掉：holder 广播/onSizeChange 触发时无真实 ratio，不做校验
      if (!Number.isNaN(rootTop)) {
        // 回填订阅边界：holder 广播时可直接跳过视口外单元格（缺陷2）
        this.visibleRectHolder.updateBounds(this.visibleRectListener, cellTop - rootTop, this.rectSnap.height)
      }
      // 表格横向body Scroll容器全局水平范围（px）：cell 滚出容器右边界 = 被表格横向clip = 不可见
      // 快照由 MarkdownTable 的容器 onAreaChange 推送；未就绪（header分支无容器等）时退化为屏幕宽兜底
      let contLeft: number = 0
      let contRight: number = this.screenWidthPx
      if (this.tableContainerSnap.valid()) {
        contLeft = this.tableContainerSnap.left
        contRight = contLeft + this.tableContainerSnap.width
      }
      // 水平可见：cell 全局水平区间与容器水平区间求交（cell 横滚出容器可见区被裁剪）
      const hIntersectLeft: number = Math.max(cellLeft, contLeft)
      const hIntersectRight: number = Math.min(cellRight, contRight)
      const hVisible: boolean = hIntersectRight > hIntersectLeft
      // 垂直裁剪窗口 = holder 推算的可见区域 [visTop, visBottom]（页面 px，见 MarkdownVisibleRectHolder 算法），
      // holder.visReady=false（ratio 首次>0 前）退化用整屏 [0, screenH]，避免漏报。
      const vpTop: number = useVis ? this.visibleRectHolder.visTop : 0
      const vpBottom: number = useVis ? this.visibleRectHolder.visBottom : this.screenHeightPx
      // 格在屏可见视口（相对Text内容区原点，px）：
      // 垂直=全局区间与根可见矩形求交后平移；水平=cell与容器水平交集平移到Text原点
      const clipTopPx: number = Math.max(vpTop, Math.min(vpBottom, cellTop))
      const clipBottomPx: number = Math.min(vpBottom, Math.max(vpTop, cellBottom))
      const clipLeftPx: number = Math.max(0, hIntersectLeft - cellLeft)
      const clipRightPx: number = Math.max(0, hIntersectRight - cellLeft)
      const viewport: ParagraphViewport = {
        ready: hVisible && clipBottomPx > clipTopPx && clipRightPx > clipLeftPx && this.rectSnap.width > 0,
        clipTopPx: clipTopPx - cellTop,
        clipBottomPx: clipBottomPx - cellTop,
        clipLeftPx: clipLeftPx,
        clipRightPx: clipRightPx,
        widthPx: this.rectSnap.width
      }
      // 链接矩形：缓存命中则直接求交；置脏（内容/尺寸变化）时重算一次
      if (this.linkBoxesDirty) {
        const boxes: Array<Array<text.TextBox>> | null = computeLinkBoxes(this.textController, this.httpLinks)
        if (boxes === null) {
          // 文本尚未完成布局：保持脏标记，本次不做翻转（避免用空矩形把链接误判为不可见）
          return
        }
        this.linkBoxes = boxes
        this.linkBoxesDirty = false
      }
      const result = evaluateLinkExposure(viewport, this.exposureThreshold, this.httpLinks, this.linkBoxes)
      for (const link of result.becameVisible) {
        this.elementExposureCallback?.({ eventType: 'link', visible: true, data: link.linkUrl ?? '' })
      }
      for (const link of result.becameHidden) {
        this.elementExposureCallback?.({ eventType: 'link', visible: false, data: link.linkUrl ?? '' })
      }
      return
    }
  }



  //判断节点里有没有TableCellPart或者CustomCardImage或者CustomCardLink 如果没有走原来逻辑
  isBlockLogic(nodeViewList: NodeView[]):boolean{
      for (let i = 0; i < nodeViewList.length; i++) {
        let nodeView = nodeViewList[i]
        if(nodeView.nodeType == "TableCellPart" || nodeView.nodeType == "CustomCardImage" || nodeView.nodeType == "CustomCardLink"){
            return true
        }
      }
      return false
    }

  isGrandchildInList(item: NodeView): boolean {
    for (const parent of this.list) {
      if (parent.children && parent.children.indexOf(item) >= 0) {
        return true
      }
    }
    return false
  }

  collectAllDescendants(): NodeView[] {
    const result: NodeView[] = []
    for (const child of this.list) {
      result.push(child)
      if (child.children) {
        for (const grandChild of child.children) {
          result.push(grandChild)
        }
      }
    }
    return result
  }




  build() {
    Column() {
      if(this.isBlockLogic(this.list)){
        this.tableBlockCellCustomComponent()
      }else{
        this.tableCellColumn()
      }

    }
    .alignItems(this.node.tableAlignment)
    .justifyContent(FlexAlign.Center)
    .alignSelf(ItemAlign.Stretch)
    .padding({
      top: this.tableTheme.tableCellPaddingTop,
      right: this.tableTheme.tableCellPaddingRight,
      bottom: this.tableTheme.tableCellPaddingBottom,
      left: this.tableTheme.tableCellPaddingLeft
    })
    .backgroundColor(tableCellBackgroundColor(this.node, this.blockQuoteTheme, this.tableTheme, this.node.isQuote, this.tableBlockCellRow))
    .borderWidth({
      left: this.leftWidths(),
      right: this.rightWidths(),
      top: this.topWidths(),
      bottom: this.bottomWidths()
    })
    .borderStyle(this.tableTheme.tableBorderStyle)
    .borderColor(this.tableTheme.tableBorderColor)
    .constraintSize({
      minWidth: Math.max(this.columnWidths[this.tableBlockCellCell] ?? 0, lengthToVpNumber(this.tableTheme.tableMinCellWidth) ?? 0),
      maxWidth: this.tableTheme.tableMaxCellWidth
    })
    .onSizeChange((oldValue, newValue) => {
      let newWidth: number = 0
      if (typeof newValue.width === 'number') {
        newWidth = newValue.width
      }
      if (newWidth > 0) {
        const minWidth = Math.max(this.columnWidths[this.tableBlockCellCell] ?? 0, lengthToVpNumber(this.tableTheme.tableMinCellWidth) ?? 0)
        this.cellWidthTracker.updateCellWidth(this.tableBlockCellRow, this.tableBlockCellCell, newWidth, minWidth)
      }
    })
  }

  /**
   * 段落文本数据循环
   * 注意：顶层ForEach直接引用this.list(@State)，不通过@Builder参数传递
   * 因为@Builder参数会创建本地副本，导致@State变化无法同步到ForEach
   */
  @Builder
  tableCellColumn() {
    Text(undefined, { controller: this.textController }) {
      ForEach(
        this.list,
        (item: NodeView, index: number) => {
          this.tableCellInlineItem(item, index)
        },
        (item: NodeView, index: number) => {
          // 纯函数key：不在keygen里做textContent累加等副作用。文本内容改为使用点惰性计算buildTextContent()
          // key改用共享位打包编码（MarkdownUtils.buildInlineItemKey）：字段信息与原20+字段模板等价
          return buildInlineItemKey(index, item, true,
            this.linkTheme.linkCircleIconMargin, this.linkTheme.linkRectIconMargin, this.linkTheme.linkRectToolIconMargin)
        }
      )
    }
    .textAlign(TextAlign.Start)
    .copyOption(
      this.globalTheme.isOnCopy ? CopyOptions.LocalDevice : CopyOptions.None
    )
    .onCopy((str) => {
      this.textCopyCallback?.(str)
    })
    .id(this.cellId)
    // 曝光回调条件注册（onSizeChange/onVisibleAreaChange）：未启用曝光的接入方零注册、
    // 零引擎可见性遍历税。翻转时重建 modifier（@State 引用变化触发 build 重跑重新应用）。
    .attributeModifier(this.exposureModifier)
    .backgroundColor(this.textBackgroundColor)
    .selectedBackgroundColor(this.selectBackgroundColor)
    .selection(this.selectStart, this.selectEnd)
    .onTextSelectionChange((selectionStart: number, selectionEnd: number): void => {
      this.selectStart = selectionStart
      this.selectEnd = selectionEnd
      this.textBackgroundColor = COLOR_TRANSPARENT
      this.selectBackgroundColor = this.markdownHighlightParagraph.selectedParagraphBackgroundColor
    })
    .parallelGesture(
      LongPressGesture({ repeat: false, duration: 400})
        .onAction((event: GestureEvent) => {
          this.textBackgroundColor = this.markdownHighlightParagraph.beforeSelectedParagraphBackgroundColor
        })
        .onActionEnd((event: GestureEvent) => {
          if (!this.globalTheme.isOnCopy) { // 不启用长按复制时使用自定义方法
            this.textBackgroundColor = COLOR_TRANSPARENT
            this.customLongPressCallback?.(this.buildTextContent()) // 调用用户自定义长按回调方法
          }
        })
    )
    .bindSelectionMenu(TextSpanType.TEXT, this.CustomMenu, TextResponseType.LONG_PRESS, {
      onMenuShow: () => {
        this.needHideMenu = false
      },
      onMenuHide: () => {
        this.needHideMenu = true
      }
    })
    .bindSelectionMenu(TextSpanType.IMAGE, this.NullMenu(), TextResponseType.LONG_PRESS, {
      onMenuShow: () => {
        this.needHideMenu = false
      },
      onMenuHide: () => {
        this.needHideMenu = true
      }
    })
    .bindSelectionMenu(TextSpanType.MIXED, this.CustomMenu, TextResponseType.LONG_PRESS, {
      onMenuShow: () => {
        this.needHideMenu = false
      },
      onMenuHide: () => {
        this.needHideMenu = true
      }
    })
  }


  @Builder
  tableBlockCellCustomComponent() {
    Column() {
      ForEach(
        this.list,
        (item: NodeView, idx: number) => {
          if (item.nodeType == "CustomCardImage") {
            // 自定义卡片图片
            this.blockImageCardComponent(
              safeString(item.imageAltText),
              safeString(item.imageUrl),
              safeString(item.imageTitle),
            )
          } else if (item.nodeType == "CustomCardLink") {
            this.blockLinkCardComponent(
              safeString(item.nodeText),
              safeString(item.linkUrl),
              safeString(item.linkTitle),
            )
          } else if (item.nodeType == "TableCellPart") {
            Text(undefined, { controller: this.textController }) {
              ForEach(
                item.children,
                (itemNodeView: NodeView, index: number) => {
                  this.tableCellInlineItem(itemNodeView, index)
                },
                (itemNodeView: NodeView, index: number) => {
                  // 纯函数key：不在keygen里做textContent累加等副作用
                  // 嵌套格keygen不含8个样式flag（withStyleFlags=false），其余字段与原模板等价
                  return buildInlineItemKey(index, itemNodeView, false,
                    this.linkTheme.linkCircleIconMargin, this.linkTheme.linkRectIconMargin, this.linkTheme.linkRectToolIconMargin)
                }
              )
            }
            .textAlign(TextAlign.Start)
            .copyOption(
              this.globalTheme.isOnCopy ? CopyOptions.LocalDevice : CopyOptions.None
            )
          }
        },
        (item: NodeView, idx: number) => {
          let childKey = ''
          if (item.children) {
            for (const child of item.children) {
              childKey += `-${child.nodeHash}-${child.imageWidth}-${child.imageHeight}-${child.imageReplacePixelMap !== undefined}-${child.latexPixelMap !== undefined}`
            }
          }
          return `${idx}-${item.nodeHash}-${item.nodeType}${childKey}`
        }
      )
    }
}






  /**
   * 渲染单个内联节点（文本/代码/链接/加粗等）
   *
   * @param item 节点视图
   * @param index 索引
   */
  @Builder
  tableCellInlineItem(item: NodeView, index: number) {
    if ((item.nodeType === "Text" || item.nodeType === "Code" || item.nodeType === "Footnote") && (item.isSupNode || item.isSubNode)) {
      // 上下标：使用baselineOffset，不使用lineHeight（两者不能混用）
      Span(item.nodeText)
        .fontColor(spanFontColor(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .fontSize(spanFontSize(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .fontStyle(spanFontStyle(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme,
          this.definitionListTheme
        ))
        .fontWeight(spanFontWeight(
          item,
          this.tableBlockCellCell === 0 && this.tableTheme.tableFirstColumnIsBold,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme,
          this.definitionListTheme
        ))
        .fontFamily(spanFontFamily(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .letterSpacing(spanLetterSpacing(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .decoration(spanDecoration(
          item,
          this.strikethroughTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme
        ))
        .textBackgroundStyle(spanBackgroundColor(
          item,
          this.inlineCodeTheme,
          this.highlightTheme,
          this.linkTheme,
          this.footnoteRefTheme
        ))
        .baselineOffset(spanBaselineOffset(
          item,
          this.subTheme,
          this.supTheme
        ))
        .onClick(() => {
          if (item.footnoteID !== undefined) {
            this.footnoteCallback?.(item.footnoteID)
            return
          }
          if (item.headLinkIndex !== undefined) {
            this.tocCallback?.(item.headLinkIndex)
            return
          }
          if (item.linkUrl !== undefined) {
            this.linkCallback?.(item.linkUrl)
            return
          }
        })
    } else if (item.nodeType === "Text" || item.nodeType === "Code" || item.nodeType === "Footnote") {
      // 普通文本/内联代码/内联脚注：使用lineHeight，不使用baselineOffset
      Span(item.nodeText)
        .fontColor(spanFontColor(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .fontSize(spanFontSize(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .fontStyle(spanFontStyle(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme,
          this.definitionListTheme
        ))
        .fontWeight(spanFontWeight(
          item,
          this.tableBlockCellCell === 0 && this.tableTheme.tableFirstColumnIsBold,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme,
          this.definitionListTheme
        ))
        .fontFamily(spanFontFamily(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .letterSpacing(spanLetterSpacing(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .decoration(spanDecoration(
          item,
          this.strikethroughTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme
        ))
        .textBackgroundStyle(spanBackgroundColor(
          item,
          this.inlineCodeTheme,
          this.highlightTheme,
          this.linkTheme,
          this.footnoteRefTheme
        ))
        .lineHeight(spanLineHeight(
          item,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .onClick(() => {
          if (item.footnoteID !== undefined) {
            this.footnoteCallback?.(item.footnoteID)
            return
          }
          if (item.headLinkIndex !== undefined) {
            this.tocCallback?.(item.headLinkIndex)
            return
          }
          if (item.linkUrl !== undefined) {
            this.linkCallback?.(item.linkUrl)
            return
          }
        })
    } else if (item.nodeType === "SoftLineBreak") {
      // 软换行
      Span(spanSoftLineBreak(this.globalTheme.isLineBreak))
    } else if (item.nodeType === "HardLineBreak") {
      // 硬换行
      Span("\n")
    } else if (item.nodeType === "Image" || item.nodeType === "StyleImage" || item.nodeType === "ImageHtmlNode") {
      // 图片/图片Style/HTML图片
      if (item.imageReplacePixelMap !== undefined || item.imageUrl !== undefined) {
        ImageSpan(item.imageReplacePixelMap ?? imageUrlHandle(item.imageUrl))
          .alt(this.placeholderPixelMap)
          .margin({
            top: this.imageTheme.imageMarginTop,
            right: this.imageTheme.imageMarginRight,
            bottom: this.imageTheme.imageMarginBottom,
            left: this.imageTheme.imageMarginLeft
          })
          .borderRadius({
            topLeft: item.imageRadius ?? this.imageTheme.imageRadiusTopLeft,
            topRight: item.imageRadius ?? this.imageTheme.imageRadiusTopRight,
            bottomLeft: item.imageRadius ?? this.imageTheme.imageRadiusBottomLeft,
            bottomRight: item.imageRadius ?? this.imageTheme.imageRadiusBottomRight
          })
          .borderWidth(this.imageTheme.imageBorderWidth)
          .borderColor(this.imageTheme.imageBorderColor)
          .borderStyle(this.imageTheme.imageBorderStyle)
          .width(item.imageWidth ?? 0)
          .height(item.imageHeight ?? 0)
          .objectFit(this.imageTheme.imageFitType)
          .verticalAlign(ImageSpanAlignment.CENTER)
          .constraintSize({
            maxWidth: this.tableTheme.tableMaxCellWidth,
            maxHeight: this.imageTheme.imageMaxHeight
          })
          .onClick(() => {
            if (item.isLink) {
              this.linkCallback?.(item.linkUrl ?? "")
            } else {
              this.imageCallback?.(item.imageUrl ?? "")
            }
          })
          .onComplete((imageLoadResult) => {
            if (imageLoadResult === undefined || imageLoadResult === null) {
              return
            }
            item.imageNaturalWidth = imageLoadResult.width
            item.imageNaturalHeight = imageLoadResult.height
            // 优先 tableMaxCellWidth，其次父布局宽度，都没有时 fallback 到图片自然宽度
            const cellMaxWidth: number = lengthToVpNumber(this.tableTheme.tableMaxCellWidth)
              ?? (this.componentWidth > 0 ? this.componentWidth : px2vp(imageLoadResult.width))
            if (cellMaxWidth <= 0) {
              return
            }
            const l = imageWidthAndHeight(
              cellMaxWidth,
              imageLoadResult.width,
              imageLoadResult.height,
              (item.imageStyleWidth !== undefined ? vp2px(item.imageStyleWidth) : undefined) ??
              (this.imageTheme.imageWidth !== undefined ? vp2px(this.imageTheme.imageWidth) : undefined),
              (item.imageStyleHeight !== undefined ? vp2px(item.imageStyleHeight) : undefined) ??
              (this.imageTheme.imageHeight !== undefined ? vp2px(this.imageTheme.imageHeight) : undefined),
              this.imageTheme.imageMaxWidth,
              this.imageTheme.imageMaxHeight,
              this.imageTheme.imageFixedRatioWidth,
              this.imageTheme.imageMaximumWidth
            )
            if (l[0] > 0 && l[1] > 0) {
              item.imageWidth = px2vp(l[0])
              item.imageHeight = px2vp(l[1])
              this.cellWidthTracker.setFallback(this.tableBlockCellRow, this.tableBlockCellCell, item.imageWidth)
              if (this.list.indexOf(item) >= 0 || this.isGrandchildInList(item)) {
                this.list = [...this.list]
              }
            }
          })
      }
    } else if (item.nodeType === "Link" || item.nodeType === "HeadLink") {
      if ((item.isBulletList || item.isOrderedList || item.isQuote || item.isDescList) && this.isSingleLinkNode() && !this.linkTheme.linkListIsIcon) {
        Span(item.nodeText)
          .fontColor(this.linkTheme.linkTextFontColor)
          .fontSize(this.paragraphTheme.paragraphTextFontSize)
          .decoration(spanDecoration(
            item,
            this.strikethroughTheme,
            this.htmlUnderlineTheme,
            this.linkTheme,
            this.footnoteRefTheme
          ))
          .onClick(() => {
            if (item.linkUrl !== undefined) {
              this.linkCallback?.(item.linkUrl)
            }
          })
      } else {
        if (item.linkIconPixelMap !== undefined && item.linkIconWidth > 0 && item.linkIconHeight > 0) {
          ImageSpan(item.linkIconPixelMap)
            .width(px2vp(item.linkIconWidth))
            .height(px2vp(item.linkIconHeight))
            .verticalAlign(ImageSpanAlignment.CENTER)
            .margin({
              left: this.getLinkIconMargin(item),
              right: this.getLinkIconMargin(item)
            })
            .onClick(() => {
              if (item.linkUrl !== undefined) {
                this.linkCallback?.(item.linkUrl)
              }
            })
        } else {
          Span(item.nodeText)
            .fontColor(this.linkTheme.linkTextFontColor)
            .fontSize(this.paragraphTheme.paragraphTextFontSize)
            .decoration(spanDecoration(
              item,
              this.strikethroughTheme,
              this.htmlUnderlineTheme,
              this.linkTheme,
              this.footnoteRefTheme
            ))
            .onClick(() => {
              if (item.linkUrl !== undefined) {
                this.linkCallback?.(item.linkUrl)
              }
            })
        }
      }
    } else if (item.nodeType === "LatexMathNode") {
      // 数学公式行内 - 和图片一样直接用ImageSpan
      if (this.isLatexMathEnabled && item.latexPixelMap !== undefined && item.latexImageWidth > 0 && item.latexImageHeight > 0) {
        ImageSpan(item.latexPixelMap)
          .height(this.latexSpanHeight(item))
          .width(this.latexSpanWidth(item))
          .objectFit(ImageFit.Contain)
          .verticalAlign(ImageSpanAlignment.CENTER)
          .constraintSize({ maxWidth: this.tableTheme.tableMaxCellWidth })
          .onClick(() => {
            if (this.latexImageCallback !== undefined && item.latexImageData !== undefined) {
              this.latexImageCallback(item.latexImageData, item.latexImageHeight, item.latexImageWidth)
            }
          })
      } else {
        Span(item.nodeText)
      }
    } else {
      // 其它
    }
  }

  /**
   * 自定义菜单
   */
  @Builder
  CustomMenu() {
    Row() {
      // 菜单项：复制
      Column() {
        Text('复制')
          .fontSize(14)
          .fontColor(COLOR_FF191919)
      }
      .padding({ left: 10, right: 10, top: 8, bottom: 8 })
      .onClick(() => {
        // 获取选中文本并复制到剪贴板
        let selectedText = this.buildTextContent().substring(this.selectStart, this.selectEnd)
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, selectedText)
        pasteboard.getSystemPasteboard().setData(pasteData)
        this.textCopyCallback?.(selectedText)
        this.textController.closeSelectionMenu()
      })
    }
    .backgroundColor(COLOR_WHITE)
    .borderWidth(1)
    .borderColor(COLOR_FFF5F2F0)
    .borderRadius(5)
    .shadow(ShadowStyle.OUTER_DEFAULT_LG) // 阴影
  }

  /**
   * 自定义空白菜单
   */
  @Builder
  NullMenu() {}

  /**
   * 表格左部边框宽度
   */
  leftWidths(): Length {
    return 0
  }

  /**
   * 表格右部边框宽度
   */
  rightWidths(): Length {
    return this.tableBlockCellCell === this.tableBlockCellCellSize - 1 ? 0 : this.tableTheme.tableBorderWidth
  }

  /**
   * 表格顶部边框宽度
   */
  topWidths(): Length {
    return 0
  }

  /**
   * 表格底部边框宽度
   */
  bottomWidths(): Length {
    return this.tableBlockCellRow === this.tableBlockCellRowSize - 1 ? 0 : this.tableTheme.tableBorderWidth
  }

  /**
   * 刷新数据
   */
  refreshData() {
    const children = this.node.children
    if (children.length === 0) {
      for (const old of this.list) {
        old.releaseOwnPixelMaps()
      }
      this.list = []
      this.httpLinks = []
      this.httpLinksDirty = true
      return
    }
    // 图片尺寸保留仅当旧列表（含grandChild层）有图片子节点时才有意义（无图时恢复循环本就是
    // 空转）——纯文本单元格（占绝大多数）跳过3个Map的分配与填充
    let hasImageChildren = false
    for (const oldChild of this.list) {
      if (oldChild.imageUrl !== undefined) {
        hasImageChildren = true
        break
      }
      if (oldChild.children) {
        for (const grandChild of oldChild.children) {
          if (grandChild.imageUrl !== undefined) {
            hasImageChildren = true
            break
          }
        }
        if (hasImageChildren) {
          break
        }
      }
    }
    if (hasImageChildren) {
      const oldImageSizes: Map<string, number[]> = new Map()
      const oldImageNaturalSizes: Map<string, number[]> = new Map()
      const oldImageStyles: Map<string, string> = new Map()
      for (const oldChild of this.list) {
        if (oldChild.imageUrl !== undefined) {
          if (oldChild.imageWidth !== undefined && oldChild.imageWidth > 0 && oldChild.imageHeight !== undefined) {
            oldImageSizes.set(oldChild.imageUrl, [oldChild.imageWidth, oldChild.imageHeight])
          }
          if (oldChild.imageNaturalWidth !== undefined && oldChild.imageNaturalHeight !== undefined) {
            oldImageNaturalSizes.set(oldChild.imageUrl, [oldChild.imageNaturalWidth, oldChild.imageNaturalHeight])
          }
          oldImageStyles.set(oldChild.imageUrl,
            `${oldChild.imageStyleWidth ?? ''}|${oldChild.imageStyleHeight ?? ''}|${oldChild.imageRadius ?? ''}`)
        }
        if (oldChild.children) {
          for (const grandChild of oldChild.children) {
            if (grandChild.imageUrl !== undefined) {
              if (grandChild.imageWidth !== undefined && grandChild.imageWidth > 0 && grandChild.imageHeight !== undefined) {
                oldImageSizes.set(grandChild.imageUrl, [grandChild.imageWidth, grandChild.imageHeight])
              }
              if (grandChild.imageNaturalWidth !== undefined && grandChild.imageNaturalHeight !== undefined) {
                oldImageNaturalSizes.set(grandChild.imageUrl, [grandChild.imageNaturalWidth, grandChild.imageNaturalHeight])
              }
              oldImageStyles.set(grandChild.imageUrl,
                `${grandChild.imageStyleWidth ?? ''}|${grandChild.imageStyleHeight ?? ''}|${grandChild.imageRadius ?? ''}`)
            }
          }
        }
      }
      for (const newChild of children) {
        if (newChild.imageUrl !== undefined) {
          const oldNaturalSize = oldImageNaturalSizes.get(newChild.imageUrl)
          if (oldNaturalSize) {
            newChild.imageNaturalWidth = oldNaturalSize[0]
            newChild.imageNaturalHeight = oldNaturalSize[1]
          }
          const oldStyleKey = oldImageStyles.get(newChild.imageUrl)
          const newStyleKey = `${newChild.imageStyleWidth ?? ''}|${newChild.imageStyleHeight ?? ''}|${newChild.imageRadius ?? ''}`
          if (oldStyleKey === newStyleKey) {
            const oldSize = oldImageSizes.get(newChild.imageUrl)
            if (oldSize) {
              newChild.imageWidth = oldSize[0]
              newChild.imageHeight = oldSize[1]
            }
          }
        }
        if (newChild.children) {
          for (const grandChild of newChild.children) {
            if (grandChild.imageUrl !== undefined) {
              const oldNaturalSize = oldImageNaturalSizes.get(grandChild.imageUrl)
              if (oldNaturalSize) {
                grandChild.imageNaturalWidth = oldNaturalSize[0]
                grandChild.imageNaturalHeight = oldNaturalSize[1]
              }
              const oldStyleKey = oldImageStyles.get(grandChild.imageUrl)
              const newStyleKey = `${grandChild.imageStyleWidth ?? ''}|${grandChild.imageStyleHeight ?? ''}|${grandChild.imageRadius ?? ''}`
              if (oldStyleKey === newStyleKey) {
                const oldSize = oldImageSizes.get(grandChild.imageUrl)
                if (oldSize) {
                  grandChild.imageWidth = oldSize[0]
                  grandChild.imageHeight = oldSize[1]
                }
              }
            }
          }
        }
      }
    }
    const oldList = this.list
    this.list = [...children]
    if (oldList.length > 0) {
      const newSet: Set<NodeView> = new Set<NodeView>(children)
      for (const old of oldList) {
        if (!newSet.has(old)) {
          old.releaseOwnPixelMaps()
        }
      }
    }
    this.tryEnqueueLatexLoading()
    // 标记 httpLinks 脏：list 变了偏移必变。dirty=true 后：已启用→下面立即重算；未启用（config
    // 尚未同步）→跳过，dirty 留 true，待 config 同步后 scheduleExposure 懒补算。
    this.httpLinksDirty = true
    this.linkBoxesDirty = true // 内容变了：链接字符偏移与渲染矩形都要重算
    this.rectBaseDirty = true // 内容变了：cell 高度/相对位置可能变，布局base需要重新采样
    // 仅在启用曝光时重算http链接字符偏移并触发评估；未设回调时跳过（省遍历开销）
    if (this.isExposureEnabled()) {
      this.httpLinks = computeLinkRanges(this.list, this.globalTheme.isLineBreak, 0)
      this.httpLinksDirty = false
      this.scheduleExposure()
    }
  }

  /**
   * 行内数学公式ImageSpan显示宽度上限（vp）
   * 取表格单元格最大宽度与父布局宽度中较小者，确保公式不超出表格
   */
  private latexSpanMaxWidth(): number {
    const maxCellWidth: number = lengthToVpNumber(this.tableTheme.tableMaxCellWidth) ?? 300
    if (this.componentWidth > 0 && this.componentWidth < maxCellWidth) {
      return this.componentWidth
    }
    return maxCellWidth
  }

  /**
   * 行内数学公式ImageSpan显示宽度（vp）
   * 按位图实际尺寸显示；宽度超过单元格可用宽度时等比缩小
   */
  private latexSpanWidth(item: NodeView): number {
    const imgWidth: number = px2vp(item.latexImageWidth)
    const maxWidth: number = this.latexSpanMaxWidth()
    if (imgWidth > 0 && maxWidth > 0 && imgWidth > maxWidth) {
      return maxWidth
    }
    return imgWidth
  }

  /**
   * 行内数学公式ImageSpan显示高度（vp）
   * 与latexSpanWidth保持同一等比缩放比例，避免宽高比失真
   */
  private latexSpanHeight(item: NodeView): number {
    const imgWidth: number = px2vp(item.latexImageWidth)
    const imgHeight: number = px2vp(item.latexImageHeight)
    const maxWidth: number = this.latexSpanMaxWidth()
    if (imgWidth > 0 && maxWidth > 0 && imgWidth > maxWidth) {
      return imgHeight * (maxWidth / imgWidth)
    }
    return imgHeight
  }

  /**
   * 数学公式异步加载入队（从onListChanged提取，refreshData直接调用，不依赖@Watch链）
   * task 返回 Promise<void>：LatexParseQueue.processNext 会自动挂 .then/.catch，
   * 即便 task 内部 promise 链丢 rejection 也能兜底推进队列，避免永久卡死。
   */
  private tryEnqueueLatexLoading(): void {
    if (!this.isLatexMathEnabled) {
      return
    }
    const allItems: NodeView[] = this.collectAllDescendants()
    for (const child of allItems) {
      if (child.nodeType === "LatexMathNode" && !child.latexIsLoading && child.latexPixelMap === undefined) {
        child.latexIsLoading = true
        LatexParseQueue.enqueue((): Promise<void> => {
          if (this.isAlive) {
            return this.loadLatexImage(child)
          } else {
            child.latexIsLoading = false
            return Promise.resolve()
          }
        })
      }
    }
  }

  /**
    * list变化时触发异步加载（从refreshData移出tryReplaceImages/tryGenerateLinkIcons，避免每次this.list=[...this.list]都重跑；
    * 各方法内置tried守卫，重复触发仅遍历检查不会重跑）
    * 内容缩短检测：流式输出时原始markdown文本（如[百度](https://...）很长，补全后渲染成短文本（如"百度"）。
    * minWidth卡在旧值→onSizeChange不触发→tracker有stale值→列宽不收缩。
    * 通过比较文本总长度检测缩短，缩短时clearCellWidth清除列宽测量值→cell收缩→onSizeChange→重测→列收缩。
    */
  onListChanged() {
    // 检测内容是否缩短（如原始markdown→渲染后的链接，文本变短）
    let totalTextLength = 0
    for (const item of this.list) {
      totalTextLength += item.nodeText.length
    }
    if (totalTextLength < this.prevTextLength) {
      this.cellWidthTracker.clearCellWidth(this.tableBlockCellRow, this.tableBlockCellCell)
    }
    this.prevTextLength = totalTextLength
    this.tryReplaceImages()
    this.tryGenerateLinkIcons()
    this.tryEnqueueLatexLoading()
  }

  /**
   * 异步替换图片：调用imageReplaceCallback获取原始字节→转为PixelMap→更新ImageSpan渲染
   */
  private tryReplaceImages(): void {
    if (this.imageReplaceCallback === undefined) {
      return
    }
    const allItems: NodeView[] = this.collectAllDescendants()
    for (const child of allItems) {
      if (child.imageUrl !== undefined && !child.imageReplaceTried) {
        child.imageReplaceTried = true
        this.imageReplaceCallback(child.imageUrl).then((buffer: ArrayBuffer | undefined) => {
          if (!this.isAlive || buffer === undefined) {
            return
          }
          if (this.list.indexOf(child) < 0 && !this.isGrandchildInList(child)) {
            return
          }
          const imageSource: image.ImageSource = image.createImageSource(buffer)
          imageSource.createPixelMap().then((pm: PixelMap) => {
            try {
              imageSource.release()
            } catch (e) {
              console.error('TableCell imageSource release failed: ' + (e instanceof Error ? e.stack : String(e)))
            }
            if (!this.isAlive || (this.list.indexOf(child) < 0 && !this.isGrandchildInList(child))) {
              try {
                pm.release()
              } catch (e) {
                console.error('TableCell PixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
              }
              return
            }
            child.imageReplacePixelMap = pm
            this.list = [...this.list]
          }).catch((e: Error) => {
            console.error('TableCell imageReplace failed: ' + (e instanceof Error ? e.stack : String(e)))
            try {
              imageSource.release()
            } catch (err) {
              console.error('TableCell imageSource release in catch failed: ' + (err instanceof Error ? err.stack : String(err)))
            }
          })
        }).catch((e: Error) => {
          console.error('TableCell imageReplace failed: ' + (e instanceof Error ? e.stack : String(e)))
        })
      }
    }
  }

  /**
   * 判断当前list是否仅含一个Link节点（用于列表上下文是否图片化判断）
   */
  private isSingleLinkNode(): boolean {
    if (this.list.length !== 1) {
      return false
    }
    const node = this.list[0]
    return node.nodeType === "Link" || node.nodeType === "HeadLink"
  }

  /**
   * 根据链接URL和文本计算图标外边距
   */
  private getLinkIconMargin(item: NodeView): number {
    const iconType = item.linkIconType
    if (iconType === LINK_ICON_TYPE_CIRCLE) {
      return this.linkTheme.linkCircleIconMargin
    } else if (iconType === LINK_ICON_TYPE_RECT) {
      return this.linkTheme.linkRectIconMargin
    } else {
      return this.linkTheme.linkRectToolIconMargin
    }
  }

  /**
   * 异步生成链接图标PixelMap（通过C++原生绘图）
   */
  private tryGenerateLinkIcons(): void {
    const allItems: NodeView[] = this.collectAllDescendants()
    for (const child of allItems) {
      if ((child.nodeType === "Link" || child.nodeType === "HeadLink") && child.isLinkStyle && !child.linkIconTried) {
        child.linkIconTried = true
        child.linkIconText = child.nodeText
        child.linkIconType = computeLinkIconInfo(child.linkUrl ?? "", child.nodeText).iconType
        generateLinkIconPixelMap(child.nodeText, child.linkUrl ?? "", this.linkTheme)
          .then((result: LinkIconResult | undefined) => {
            if (!this.isAlive || result === undefined) {
              if (result !== undefined) {
                try {
                  result.pixelMap.release()
                } catch (e) {
                  console.error('TableCell linkIcon pixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
                }
              }
              return
            }
            if (this.list.indexOf(child) < 0 && !this.isGrandchildInList(child)) {
              try {
                result.pixelMap.release()
              } catch (e) {
                console.error('TableCell linkIcon pixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
              }
              return
            }
            if (child.linkIconText !== child.nodeText) {
              try {
                result.pixelMap.release()
              } catch (e) {
                console.error('TableCell linkIcon pixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
              }
              return
            }
            if (child.linkIconPixelMap !== undefined) {
              try {
                child.linkIconPixelMap.release()
              } catch (e) {
                console.error('linkIconPixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
              }
            }
            child.linkIconPixelMap = result.pixelMap
            child.linkIconWidth = result.width
            child.linkIconHeight = result.height
            this.list = [...this.list]
          })
          .catch((e: Error) => {
            console.error('TableCell linkIcon generation failed: ' + (e instanceof Error ? e.stack : String(e)))
          })
      }
    }
  }

  /**
   * 异步加载数学公式图片（通过全局队列串行调用latexStringToImage）
   * 流式输出时latex文本可能增长，需捕获调用时的文本，回调中校验是否已过期，
   * 避免旧文本的图片覆盖新状态（旧图片闪烁/内存泄漏）。
   * 返回 Promise<void>：让 processNext 自动接管 .then/.catch，确保任何异步 rejection 都能推进队列。
   *
   * @param item 节点视图
   */
  private loadLatexImage(item: NodeView): Promise<void> {
    try {
      const capturedNodeText: string = item.nodeText
      const strLatexMath: string = this.latexStrCallback(capturedNodeText)
      const textSize: number = vp2px(this.latexMathTheme.latexMathTextSize)
      const textColor: number = resourceColorToNumber(this.latexMathTheme.latexMathTextColor)
      const bgColor: number = resourceColorToNumber(this.latexMathTheme.latexMathBackgroundColor)
      const colorFormat: LatexMathColorFormat = this.latexMathTheme.latexMathColorFormat === 0
        ? LatexMathColorFormat.COLOR_FORMAT_RGB_565
        : LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
      const resPath: string | undefined = this.latexMathTheme.latexMathResPath

      return latexStringToImage(strLatexMath, textSize, textColor, bgColor, colorFormat, resPath)
        .then((buffer: ArrayBuffer) => {
          if (!this.isAlive) {
            item.latexIsLoading = false
            LatexParseQueue.notifyDone()
            return
          }
          const imageSource: image.ImageSource = image.createImageSource(buffer)
          return imageSource.createPixelMap().then((pm: PixelMap) => {
            try {
              imageSource.release()
            } catch (e) {
              console.error('TableCell ImageSource release failed: ' + (e instanceof Error ? e.stack : String(e)))
            }
            if (!this.isAlive) {
              try {
                pm.release()
              } catch (e) {
                console.error('TableCell PixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
              }
              item.latexIsLoading = false
              LatexParseQueue.notifyDone()
              return
            }
            return pm.getImageInfo().then((info: image.ImageInfo) => {
              if (!this.isAlive) {
                try {
                  pm.release()
                } catch (e) {
                  console.error('TableCell PixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
                }
                item.latexIsLoading = false
                LatexParseQueue.notifyDone()
                return
              }
              // 流式输出中文本可能已变化，丢弃过期结果
              // 重新触发onListChanged检查是否需要为新文本重新入队加载
              if (item.nodeText !== capturedNodeText) {
                try {
                  pm.release()
                } catch (e) {
                  console.error('TableCell PixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
                }
                LatexParseQueue.notifyDone()
                this.list = [...this.list]
                return
              }
              // 释放旧PixelMap（防御性：理论上此处应为undefined）
              if (item.latexPixelMap !== undefined) {
                try {
                  item.latexPixelMap.release()
                } catch (e) {
                  console.error('TableCell latexPixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
                }
              }
              item.latexPixelMap = pm
              item.latexImageData = buffer
              item.latexImageWidth = info.size.width
              item.latexImageHeight = info.size.height
              item.latexIsLoading = false
              this.cellWidthTracker.clearCellWidth(this.tableBlockCellRow, this.tableBlockCellCell)
              this.cellWidthTracker.setFallback(this.tableBlockCellRow, this.tableBlockCellCell, this.latexSpanWidth(item))
              this.list = [...this.list] // 触发重渲染
              LatexParseQueue.notifyDone()
            }).catch((e: Error) => {
              console.error('TableCell loadLatexImage getImageInfo failed: '
                + (e instanceof Error ? e.stack : String(e)))
              try {
                pm.release()
              } catch (err) {
                console.error('TableCell PixelMap release failed: ' + (err instanceof Error ? err.stack : String(err)))
              }
              // 仅当文本未变化时才重置loading，避免覆盖新一轮加载的loading状态
              if (item.nodeText === capturedNodeText) {
                item.latexIsLoading = false
              }
              LatexParseQueue.notifyDone()
            })
          }).catch((e: Error) => {
            console.error('TableCell loadLatexImage createPixelMap failed: '
              + (e instanceof Error ? e.stack : String(e)))
            try {
              imageSource.release()
            } catch (err) {
              console.error('TableCell ImageSource release failed: ' + (err instanceof Error ? err.stack : String(err)))
            }
            if (item.nodeText === capturedNodeText) {
              item.latexIsLoading = false
            }
            LatexParseQueue.notifyDone()
          })
        })
        .catch((e: Error) => {
          console.error('TableCell loadLatexImage latexStringToImage failed: '
            + (e instanceof Error ? e.stack : String(e)))
          if (item.nodeText === capturedNodeText) {
            item.latexIsLoading = false
          }
          LatexParseQueue.notifyDone()
        })
    } catch (e) {
      console.error('TableCell loadLatexImage sync error: ' + (e instanceof Error ? e.stack : String(e)))
      item.latexIsLoading = false
      LatexParseQueue.notifyDone()
      return Promise.resolve()
    }
  }

  // 更新文本内容
  /**
   * 惰性计算单元格纯文本内容（长按复制/自定义菜单使用）
   * 之前在ForEach keygen中用 string += 逐段累加：框架每次diff重跑keygen导致
   * 文本重复累加（本组件有主列表与TableCellPart嵌套两个keygen交叉累加）和
   * O(n²)字符串拷贝。改为使用点单次计算（parts数组 + join）。
   *
   * @return 单元格文本内容
   */
  private buildTextContent(): string {
    const parts: string[] = []
    this.appendTextContentList(this.list, parts)
    return parts.join("")
  }

  /**
   * 遍历列表追加文本；TableCellPart（与自定义卡片共存时解析器包裹的文本段）递归其children
   */
  private appendTextContentList(list: Array<NodeView>, parts: string[]): void {
    for (const item of list) {
      this.appendTextContent(item, parts)
      if (item.nodeType === "TableCellPart") {
        this.appendTextContentList(item.children, parts)
      }
    }
  }

  /**
   * 按节点类型将单个内联节点的文本追加到parts
   */
  private appendTextContent(item: NodeView, parts: string[]): void {
    if (item.nodeType === "Text" || item.nodeType === "Code" || item.nodeType === "Footnote") {
      parts.push(item.nodeText)
    } else if (item.nodeType === "SoftLineBreak") {
      // 软换行
      parts.push(spanSoftLineBreak(this.globalTheme.isLineBreak))
    } else if (item.nodeType === "HardLineBreak") {
      // 硬换行
      parts.push("\n")
    } else if (item.nodeType === "Link" || item.nodeType === "HeadLink" || item.nodeType === "LatexMathNode" ||
      item.nodeType === "Image" || item.nodeType === "StyleImage" || item.nodeType === "ImageHtmlNode") {
      // 非文本节点，不处理
    } else {
      parts.push(item.nodeText)
    }
  }

  // 参数变化时的回调
  onParamChange(): void {
    if (this.needHideMenu) {
      this.startDelay() // 参数变为 true：启动延时
    } else {
      this.cancelDelay() // 参数变为 false：取消延时
    }
  }

  // 启动弹窗关闭判断延时
  private startDelay(): void {
    this.cancelDelay() // 先清除之前的定时器，防止重复
    this.timerId = setTimeout(() => {
      this.timerId = -1
      if (!this.isAlive) {
        return
      }
      // 延时到期，再次检查参数状态，参数仍为 true，关闭长按菜单
      if (this.needHideMenu) {
        this.selectStart = -1
        this.selectEnd = -1
        this.textController.closeSelectionMenu()
      }
    }, this.delayTime)
  }

  // 取消弹窗关闭判断延时
  private cancelDelay(): void {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId)
      this.timerId = -1
    }
  }
}
