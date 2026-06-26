/**
 * 表格列宽度跟踪器（非@Observed，不触发重渲染）
 * onSizeChange写入tracker → refreshData批量读取到@State → 一次性应用
 * 打破反馈循环：onSizeChange → tracker更新（无重渲染）→ 下次refreshData才应用
 */
export class CellWidthTracker {
  widths: number[] = []

  constructor(size: number = 0) {
    this.resize(size)
  }

  updateIfWider(index: number, width: number): void {
    if (index >= 0 && index < this.widths.length) {
      if (width > this.widths[index]) {
        this.widths[index] = width
      }
    }
  }

  getWidth(index: number): number {
    if (index >= 0 && index < this.widths.length) {
      return this.widths[index]
    }
    return 0
  }

  getWidths(): number[] {
    return this.widths
  }

  resize(size: number): void {
    if (size !== this.widths.length) {
      this.widths = new Array(size).fill(0)
    }
  }
}
