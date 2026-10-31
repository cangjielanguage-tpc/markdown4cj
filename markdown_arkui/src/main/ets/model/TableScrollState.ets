/**
 * 表格横滚偏移共享对象（非@Observed，onScroll只写不触发重渲染）。
 * 横滚时 Scroll 组件自身页面矩形不变、onAreaChange 不触发，cell 由此感知横滚：
 * MarkdownTable 的 body Scroll onScroll 逐帧更新 x 并广播，TableCell 注册监听器触发重评
 * （cell evaluateExposure 直读实时窗口矩形，天然含横滚后的真实位置，无需任何平推修正）。
 */
export class TableScrollState {
  x: number = 0 // 当前横向滚动偏移（vp，onScroll 逐帧更新；vp 单位，cell 侧 vp2px 换算后使用）
  private listeners: Set<() => void> = new Set()

  addListener(fn: () => void): void {
    this.listeners.add(fn)
  }

  removeListener(fn: () => void): void {
    this.listeners.delete(fn)
  }

  notify(): void {
    this.listeners.forEach((fn: () => void) => {
      try {
        fn()
      } catch (e) {
        console.error('TableScrollState.notify listener error: ' + (e instanceof Error ? e.stack : String(e)))
      }
    })
  }
}
