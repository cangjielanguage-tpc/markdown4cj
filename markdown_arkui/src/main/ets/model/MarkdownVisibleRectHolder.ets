/**
 * CJMarkdown 根节点可见矩形持有者（页面坐标系 px）。
 *
 * 算法（消费方=MarkdownParagraph/MarkdownHeading/MarkdownTableCell 用 visTop/visBottom 作垂直裁剪窗口）：
 *   - CJMarkdown 用根 List 的 onAreaChange 拿「矩形区域」= 根 List 的窗口 rect [rectTop, rectBottom]
 *     （rectHeight=bottom-top，滚动/尺寸变化时框架逐帧推送），ratio 取 onVisibleAreaChange 最近一次值
 *     （CJMarkdown 缓存 lastRatio；ratio 变化时用缓存矩形补喂）。
 *   - 初始可见区域 = 矩形区域 × ratio（顶部对齐、静止：visTop=rectTop, visHeight=rectHeight×ratio）。
 *   - 每次喂入按「矩形区域移动方向」+「ratio 变化」更新可见区域：
 *       一 向上滑（rectTop 减小）：
 *         1 ratio 不变：ratio==1 → 可见区域=矩形区域；否则可见区域不变（静止）。
 *         2 ratio 变小：被遮挡，visHeight 减去 (prevRatio-curRatio)×rectHeight，底部收缩。
 *         3 ratio 变大：不考虑（保持不变，偏漏报，避免过报）。
 *       二 向下移（rectTop 增大）：
 *         1 ratio 不变：ratio==1 → 可见区域=矩形区域；否则不变。
 *         2 ratio 变小：visHeight 减去 (prevRatio-curRatio)×rectHeight，顶部收缩。
 *       （ratio 变大同上不考虑。）
 *   - 可见区域静止（视口本身不动），仅随 ratio 收缩；visHeight≥0 兜底。
 *
 * 说明：在 Scroll{Column{CJMarkdown}} 无界容器下，rectHeight=整文高，故 visHeight=ratio×整文高
 *   仅是视口的「估算」，有误差（用户确认可接受）。
 */
@Observed
export class MarkdownVisibleRectHolder {
  // 矩形区域（onAreaChange 来源，窗口 px）——applyRect 每次更新
  rectTop: number = 0
  rectBottom: number = 0
  rectHeight: number = 0
  // ratio（onVisibleAreaChange 来源，CJMarkdown 缓存后传入）
  ratio: number = 0
  // 可见区域（算法输出，窗口 px，静止）——paragraph/cell 用作垂直裁剪窗口
  visTop: number = 0
  visBottom: number = 0
  visHeight: number = 0
  ready: boolean = false // 已拿到过 rect（applyRect 至少调过一次）
  visReady: boolean = false // vis 已完成初始化（ratio 首次>0 后）；消费方据此决定用 vis 还是退化兜底
  // tick 快照
  private inited: boolean = false
  private prevRectTop: number = Number.NaN
  private prevRatio: number = Number.NaN
  // 订阅者 → 其相对根矩形的边界（用于 notify 前过滤视口外订阅者，避免整篇文档全量广播）
  private listeners: Map<(r: MarkdownVisibleRectSnapshot) => void, MarkdownVisibleRectBounds> =
    new Map<(r: MarkdownVisibleRectSnapshot) => void, MarkdownVisibleRectBounds>()

  addListener(fn: (r: MarkdownVisibleRectSnapshot) => void): void {
    if (!this.listeners.has(fn)) {
      const bounds: MarkdownVisibleRectBounds = { topInRoot: Number.NaN, height: 0 }
      this.listeners.set(fn, bounds)
    }
  }

  removeListener(fn: (r: MarkdownVisibleRectSnapshot) => void): void {
    this.listeners.delete(fn)
  }

  /**
   * 订阅者拿到自己的真实页面矩形后回填边界，供 notify 做视口外过滤。
   * topInRoot 为 NaN 或 height <= 0 表示未知 → 该订阅者不被过滤，全量通知。
   * 注意 topInRoot 可以为负（块已滚到根矩形顶之上），属正常值，照常参与过滤。
   *
   * @param fn 订阅时注册的同一个监听器引用
   * @param topInRoot 订阅者窗口顶相对根矩形顶的偏移（px）
   * @param height 订阅者高度（px）
   */
  updateBounds(fn: (r: MarkdownVisibleRectSnapshot) => void, topInRoot: number, height: number): void {
    const bounds: MarkdownVisibleRectBounds | undefined = this.listeners.get(fn)
    if (bounds === undefined) {
      return
    }
    if (Number.isNaN(topInRoot) || height <= 0) {
      bounds.topInRoot = Number.NaN
      bounds.height = 0
      return
    }
    bounds.topInRoot = topInRoot
    bounds.height = height
  }

  /**
   * 由 CJMarkdown 定期调用：传入最新矩形（页面 px）+ ratio，运行算法更新可见区域。
   * 首次调用=初始化（visHeight=rectHeight×ratio）。后续按方向/ratio 变化收缩。
   * vis变化或矩形移动（滚动）时通知监听者。
   */
  applyRect(rectTop: number, rectBottom: number, ratio: number): void {
    this.rectTop = rectTop
    this.rectBottom = rectBottom
    this.rectHeight = Math.max(0, rectBottom - rectTop)
    this.ratio = ratio
    this.ready = true
    // ratio 还没回调过（首帧 lastRatio=0）→ 不初始化 vis，等 onVisibleAreaChange 给真实 ratio 再 init
    // 否则 visHeight=rectH×0=0 永久卡死（ratio 变大走"不考虑"分支不会扩大）
    if (!this.inited) {
      if (ratio <= 0) {
        return
      }
      // 初始可见区域 = 矩形区域 × ratio（顶部对齐，静止）
      const h: number = this.rectHeight * ratio
      this.visHeight = h
      this.visTop = rectTop
      this.visBottom = rectTop + h
      this.visReady = true
      this.inited = true
      this.prevRectTop = rectTop
      this.prevRatio = ratio
      this.notify()
      return
    }
    const prevTop: number = this.prevRectTop
    const prevRatio: number = this.prevRatio
    // ratio 从 ≤0 回到 >0（onVisibleAreaChange 延迟首次回调，或根重新进入可见区）→ 重新初始化，
    // 不走"ratio 变大不考虑"分支（否则 vis 永久卡在 0）
    if (prevRatio <= 0 && ratio > 0) {
      const h: number = this.rectHeight * ratio
      this.visHeight = h
      this.visTop = rectTop
      this.visBottom = rectTop + h
      this.visReady = true
      this.prevRectTop = rectTop
      this.prevRatio = ratio
      this.notify()
      return
    }
    const movedUp: boolean = rectTop < prevTop - 0.5
    const movedDown: boolean = rectTop > prevTop + 0.5
    const ratioEq: boolean = Math.abs(ratio - prevRatio) < 1e-4
    const ratioDown: boolean = ratio < prevRatio - 1e-4
    let changed: boolean = false
    if (movedUp || movedDown) {
      if (ratioEq) {
        if (Math.abs(ratio - 1) < 1e-4) {
          // ratio==1 → 可见区域=矩形区域
          const h: number = this.rectHeight
          this.visHeight = h
          this.visTop = rectTop
          this.visBottom = rectTop + h
          changed = true
        }
        // ratio 不变且 ≠1 → 可见区域不变（静止）
      } else if (ratioDown) {
        // ratio 变小 → 被遮挡，visHeight 减去 (prevRatio-curRatio)×rectHeight
        const shrink: number = (prevRatio - ratio) * this.rectHeight
        this.visHeight = Math.max(0, this.visHeight - shrink)
        // 收缩端：向上滑→底部遮挡（visBottom 上移）；向下移→顶部遮挡（visTop 下移）
        if (movedUp) {
          this.visBottom = this.visTop + this.visHeight
        } else {
          this.visTop = this.visBottom - this.visHeight
        }
        changed = true
      }
      // ratio 变大 → 不考虑（保持不变）
    }
    // else 未移动 → 可见区域不变
    this.prevRectTop = rectTop
    this.prevRatio = ratio
    // 通知条件：vis变化（changed）或 矩形移动（movedUp/movedDown）。
    // rect移动补偿：滚动期曝光评估由本通知驱动——rectTop每次喂入变化即通知消费方，
    // 消费方用 onAreaChange 推送的新鲜布局快照重算「链接rect ∩ 可见窗口」，
    // 否则ratio稳定的慢速滚动期间链接进出裁剪窗口会漏报。vis未变也通知的成本=
    // 消费方一次防抖后的快照平推评估（纯算术），远低于主动查询全树的开销。
    if (changed || movedUp || movedDown) {
      this.notify()
    }
  }

  /**
   * 广播可见窗口变化。
   *
   * 过滤（对应性能方案「缺陷2：广播不做可见性过滤」）：先用订阅者回填的边界做「视口外」判定，
   * 视口外订阅者连回调都不进。余量取半个可见高度，用于吸收边界快照的滞后（内容高度变化、
   * 表格吸顶等导致的非刚性位移）——真正跨越视口边界时，订阅者自身 onVisibleAreaChange
   * 仍会独立触发一次真实评估，因此过滤不会造成漏报。
   * vis 尚未就绪或订阅者边界未知时不过滤（保守全量通知）。
   */
  private notify(): void {
    const info: MarkdownVisibleRectSnapshot = {
      visTop: this.visTop,
      visBottom: this.visBottom,
      visHeight: this.visHeight,
      ratio: this.ratio,
      rectTop: this.rectTop,
      ready: this.ready,
      visReady: this.visReady
    }
    const filterable: boolean = this.visReady && this.visHeight > 0
    const margin: number = this.visHeight * 0.5
    this.listeners.forEach((bounds: MarkdownVisibleRectBounds, fn: (r: MarkdownVisibleRectSnapshot) => void) => {
      if (filterable && !Number.isNaN(bounds.topInRoot) && bounds.height > 0) {
        const estTop: number = this.rectTop + bounds.topInRoot
        const estBottom: number = estTop + bounds.height
        if (estBottom < this.visTop - margin || estTop > this.visBottom + margin) {
          return
        }
      }
      try {
        fn(info)
      } catch (e) {
        console.error('MarkdownVisibleRectHolder.notify listener error: ' + (e instanceof Error ? e.stack : String(e)))
      }
    })
  }
}

/**
 * 订阅者边界（相对根矩形顶的偏移 + 高度，px），供 notify 做视口外过滤。
 */
export interface MarkdownVisibleRectBounds {
  topInRoot: number
  height: number
}

/**
 * 监听者收到的可见区域快照（页面 px）。
 */
export interface MarkdownVisibleRectSnapshot {
  visTop: number
  visBottom: number
  visHeight: number
  ratio: number
  rectTop: number
  ready: boolean
  visReady: boolean
}
