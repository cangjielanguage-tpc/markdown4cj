/**
 * 表格列宽度跟踪器（非@Observed，不触发重渲染）
 * 按单元格(row,col)跟踪最新宽度，列宽=该列所有行的最大值
 * onSizeChange写入tracker → scheduleApplyColumnWidths批量读取到@State → 一次性应用
 */
export class CellWidthTracker {
  widths: number[] = []
  onWidthUpdated?: () => void
  private cellWidths: Map<number, number[]> = new Map()

  constructor(size: number = 0) {
    this.resize(size)
  }

  /**
   * 更新指定单元格的宽度，并重算该列最大宽度
   *
   * @param row 行索引
   * @param col 列索引
   * @param width 单元格宽度
   */
  updateCellWidth(row: number, col: number, width: number): void {
    if (col < 0 || col >= this.widths.length) {
      return
    }
    let rowWidths = this.cellWidths.get(row)
    if (rowWidths === undefined) {
      rowWidths = new Array(this.widths.length).fill(0)
      this.cellWidths.set(row, rowWidths)
    }
    if (rowWidths[col] === width) {
      return
    }
    rowWidths[col] = width
    const oldMax = this.widths[col]
    let newMax = 0
    this.cellWidths.forEach((rws: number[]) => {
      if (rws[col] > newMax) {
        newMax = rws[col]
      }
    })
    if (newMax !== oldMax) {
      this.widths[col] = newMax
      this.onWidthUpdated?.()
    }
  }

  /**
   * 清除指定行的所有单元格宽度记录（行删除时调用）
   *
   * @param row 行索引
   */
  clearRow(row: number): void {
    if (!this.cellWidths.delete(row)) {
      return
    }
    let changed = false
    for (let col = 0; col < this.widths.length; col++) {
      const oldMax = this.widths[col]
      let newMax = 0
      this.cellWidths.forEach((rws: number[]) => {
        if (rws[col] > newMax) {
          newMax = rws[col]
        }
      })
      if (newMax !== oldMax) {
        this.widths[col] = newMax
        changed = true
      }
    }
    if (changed) {
      this.onWidthUpdated?.()
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
    return [...this.widths]
  }

  /**
   * 清除所有列宽测量值（保留行/列结构）
   * 用于refreshData时重置宽度，允许单元格重新测量（内容缩短时可以收缩）
   * 不触发onWidthUpdated，由调用方负责后续applyColumnWidths
   */
  clearWidths(): void {
    for (let i = 0; i < this.widths.length; i++) {
      this.widths[i] = 0
    }
    this.cellWidths.forEach((rws: number[]) => {
      for (let i = 0; i < rws.length; i++) {
        rws[i] = 0
      }
    })
  }

  /**
   * 调整列数，保留已有列的宽度数据（流式输出时列数可能增长，清零会导致已测量的宽度丢失）
   *
   * @param size 新的列数
   */
  resize(size: number): void {
    if (size !== this.widths.length) {
      const oldWidths = this.widths
      this.widths = new Array(size).fill(0)
      for (let i = 0; i < Math.min(oldWidths.length, size); i++) {
        this.widths[i] = oldWidths[i]
      }
      this.cellWidths.forEach((rws: number[], row: number) => {
        if (rws.length > size) {
          this.cellWidths.set(row, rws.slice(0, size))
        } else if (rws.length < size) {
          const newRws: number[] = new Array(size).fill(0)
          for (let i = 0; i < rws.length; i++) {
            newRws[i] = rws[i]
          }
          this.cellWidths.set(row, newRws)
        }
      })
    }
  }
}
