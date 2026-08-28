/**
 * CJMarkdown 根节点可见矩形持有者（窗口坐标系 px）。
 *
 * 算法（消费方=MarkdownParagraph/MarkdownTableCell 用 visTop/visBottom 作垂直裁剪窗口）：
 *   - CJMarkdown 每 50ms 用 componentUtils 拿「矩形区域」= 根 List 的窗口 rect [rectTop, rectBottom]
 *     （rectHeight=bottom-top），ratio 取 onVisibleAreaChange 最近一次值（CJMarkdown 缓存 lastRatio）。
 *   - 初始可见区域 = 矩形区域 × ratio（顶部对齐、静止：visTop=rectTop, visHeight=rectHeight×ratio）。
 *   - 每 50ms tick 一次，按「矩形区域移动方向」+「ratio 变化」更新可见区域：
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
  // 矩形区域（componentUtils 来源，窗口 px）——applyRect 每次更新
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
  private listeners: Set<(r: MarkdownVisibleRectSnapshot) => void> = new Set()

  addListener(fn: (r: MarkdownVisibleRectSnapshot) => void): void {
    this.listeners.add(fn)
  }

  removeListener(fn: (r: MarkdownVisibleRectSnapshot) => void): void {
    this.listeners.delete(fn)
  }

  /**
   * 每 50ms 由 CJMarkdown 调用：传入最新矩形（窗口 px）+ ratio，运行算法更新可见区域。
   * 首次调用=初始化（visHeight=rectHeight×ratio）。后续按方向/ratio 变化收缩。
   * 变化时通知监听者。
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
    if (changed) {
      this.notify()
    }
  }

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
    for (const fn of this.listeners) {
      try {
        fn(info)
      } catch (e) {
        console.error('MarkdownVisibleRectHolder.notify listener error: ' + (e instanceof Error ? e.stack : String(e)))
      }
    }
  }
}

/**
 * 监听者收到的可见区域快照（窗口 px）。
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
