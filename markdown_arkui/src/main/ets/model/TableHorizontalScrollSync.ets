/**
 * 表格横向滚动同步器（非@Observed，不触发重渲染）
 *
 * 用于 sticky 表头模式下，header Scroll 与 body Scroll 的横向滚动同步。
 * 任意一端滚动时，通过 currentOffset 读取绝对偏移，再 scrollTo 到另一端，
 * 实现标题行与内容行的横向联动。
 *
 * 防抖策略：
 * - isSyncing 标志位防止 scrollTo 触发的 onDidScroll 回调递归
 * - scrollState 过滤掉程序触发的 Idle 状态，仅同步用户手势触发的滚动
 */
export class TableHorizontalScrollSync {
  /** header 端 Scroller */
  private headerScroller: Scroller | null = null
  /** body 端 Scroller */
  private bodyScroller: Scroller | null = null
  /** 当前同步的横向偏移（vp） */
  private offset: number = 0
  /** 是否正在程序化同步中（防止递归） */
  private isSyncing: boolean = false

  /**
   * 注册 header 端 Scroller
   *
   * @param scroller header Scroll 的控制器
   */
  registerHeader(scroller: Scroller): void {
    this.headerScroller = scroller
    // 应用当前偏移，确保新挂载的 header 与 body 对齐
    this.applyOffsetTo(scroller)
  }

  /**
   * 注册 body 端 Scroller
   *
   * @param scroller body Scroll 的控制器
   */
  registerBody(scroller: Scroller): void {
    this.bodyScroller = scroller
    this.applyOffsetTo(scroller)
  }

  /**
   * 注销 header 端 Scroller
   */
  unregisterHeader(): void {
    this.headerScroller = null
  }

  /**
   * 注销 body 端 Scroller
   */
  unregisterBody(): void {
    this.bodyScroller = null
  }

  /**
   * 通知 header 端发生了用户手势滚动
   *
   * @param xOffset header 当前绝对横向偏移
   */
  onHeaderScrolled(xOffset: number): void {
    if (this.isSyncing) {
      return
    }
    this.offset = xOffset
    this.syncToBody(xOffset)
  }

  /**
   * 通知 body 端发生了用户手势滚动
   *
   * @param xOffset body 当前绝对横向偏移
   */
  onBodyScrolled(xOffset: number): void {
    if (this.isSyncing) {
      return
    }
    this.offset = xOffset
    this.syncToHeader(xOffset)
  }

  /**
   * 获取当前横向偏移
   *
   * @return 当前横向偏移（vp）
   */
  getOffset(): number {
    return this.offset
  }

  /**
   * 重置偏移（表格销毁/数据清空时调用）
   */
  reset(): void {
    this.offset = 0
  }

  /**
   * 将当前偏移应用到指定 Scroller（新挂载时对齐用）
   *
   * @param scroller 目标 Scroller
   */
  private applyOffsetTo(scroller: Scroller | null): void {
    if (scroller === null || this.offset === 0) {
      return
    }
    this.isSyncing = true
    try {
      scroller.scrollTo({ xOffset: this.offset, yOffset: 0, animation: false })
    } catch (e) {
      console.error('TableHorizontalScrollSync applyOffsetTo failed: ' + (e instanceof Error ? e.stack : String(e)))
    }
    this.isSyncing = false
  }

  /**
   * 同步偏移到 body
   *
   * @param xOffset 目标横向偏移
   */
  private syncToBody(xOffset: number): void {
    if (this.bodyScroller === null) {
      return
    }
    this.isSyncing = true
    try {
      this.bodyScroller.scrollTo({ xOffset: xOffset, yOffset: 0, animation: false })
    } catch (e) {
      console.error('TableHorizontalScrollSync syncToBody failed: ' + (e instanceof Error ? e.stack : String(e)))
    }
    this.isSyncing = false
  }

  /**
   * 同步偏移到 header
   *
   * @param xOffset 目标横向偏移
   */
  private syncToHeader(xOffset: number): void {
    if (this.headerScroller === null) {
      return
    }
    this.isSyncing = true
    try {
      this.headerScroller.scrollTo({ xOffset: xOffset, yOffset: 0, animation: false })
    } catch (e) {
      console.error('TableHorizontalScrollSync syncToHeader failed: ' + (e instanceof Error ? e.stack : String(e)))
    }
    this.isSyncing = false
  }
}
