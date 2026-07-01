/**
 * 表格列宽度跟踪器（非@Observed，不触发重渲染）
 * onSizeChange写入tracker → refreshData批量读取到@State → 一次性应用
 * 打破反馈循环：onSizeChange → tracker更新（无重渲染）→ 下次refreshData才应用
 */
export class CellWidthTracker {
  widths: number[] = []
  onWidthUpdated?: () => void // 列宽更新回调（在MarkdownTable中设置，触发scheduleApplyColumnWidths）

  constructor(size: number = 0) {
    this.resize(size)
  }

  /**
   * 更新指定列的最大宽度（仅在更宽时更新）
   *
   * @param index 列索引
   * @param width 列宽度
   */
  updateIfWider(index: number, width: number): void {
    if (index >= 0 && index < this.widths.length) {
      if (width > this.widths[index]) {
        this.widths[index] = width
      }
    }
  }

  /**
   * 获取指定列的宽度
   *
   * @param index 列索引
   * @return 列宽度，索引越界时返回0
   */
  getWidth(index: number): number {
    if (index >= 0 && index < this.widths.length) {
      return this.widths[index]
    }
    return 0
  }

  /**
   * 获取所有列宽快照
   *
   * @return 列宽数组
   */
  getWidths(): number[] {
    return this.widths
  }

  /**
   * 调整列数，重置所有列宽为0
   *
   * @param size 新的列数
   */
  resize(size: number): void {
    if (size !== this.widths.length) {
      this.widths = new Array(size).fill(0)
    }
  }
}
