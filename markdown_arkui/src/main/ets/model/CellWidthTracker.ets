/**
 * 表格列宽度跟踪器（非@Observed，不触发重渲染）
 * 按单元格(row,col)跟踪最新宽度，列宽=该列所有行的最大值
 * onSizeChange写入tracker → scheduleApplyColumnWidths批量读取到@State → 一次性应用
 *
 * 三级宽度存储（优先级从高到低）：
 * 1. cellWidths：onSizeChange报告的实际宽度（每次重渲染后更新，最准确）
 * 2. imageFallback：setFallback设置的图片实际宽度（onComplete/loadLatexImage时设置，
 *    仅图片/LaTeX cell有值，clearWidths不清除，确保图片cell列宽不收缩到图片宽度以下）
 * 3. fallback：updateCellWidth在width>minWidth时记录的内容宽度（宽cell的contentWidth，
 *    clearWidths清除，避免text cell stale fallback阻止列收缩）
 *
 * recalcColumnMax优先级：cellWidths > imageFallback > fallback
 * - cellWidths>0：已重测，用最新值
 * - cellWidths==0且imageFallback>0：图片cell未重测，用图片实际宽度（安全）
 * - cellWidths==0且imageFallback==0且fallback>0：宽text cell未重测，用contentWidth
 * - 全为0：窄cell或未测cell，不贡献列宽
 */
export class CellWidthTracker {
  widths: number[] = []
  onWidthUpdated?: () => void
  private cellWidths: Map<number, number[]> = new Map()
  private fallbackCellWidths: Map<number, number[]> = new Map()
  private imageFallbackCellWidths: Map<number, number[]> = new Map()

  constructor(size: number = 0) {
    this.resize(size)
  }

  /**
    * 更新指定单元格的宽度，并重算该列最大宽度
    * 如果width>minWidth，说明cell内容宽度>minWidth约束，width=contentWidth，存为fallback。
    * 如果width==minWidth，说明cell内容宽度<=minWidth，width是minWidth而非contentWidth，清除fallback（stale）。
    * 注意：imageFallback不受updateCellWidth影响，setFallback设置的值始终保留。
    *
    * @param row 行索引
    * @param col 列索引
    * @param width 单元格宽度（onSizeChange报告的实际宽度）
    * @param minWidth 当前cell的minWidth约束值（=columnWidths[col]与tableMinCellWidth的max）
    */
  updateCellWidth(row: number, col: number, width: number, minWidth: number): void {
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
    // 宽cell（width>minWidth）：width=contentWidth，存为fallback（未重测时仍可用）
    // 窄cell（width==minWidth）：清除fallback（stale值不用），imageFallback不受影响
    let fws = this.fallbackCellWidths.get(row)
    if (fws === undefined) {
      fws = new Array(this.widths.length).fill(0)
      this.fallbackCellWidths.set(row, fws)
    }
    fws[col] = width > minWidth ? width : 0
    const oldMax = this.widths[col]
    const newMax = this.recalcColumnMax(col)
    if (newMax !== oldMax) {
      this.widths[col] = newMax
      this.onWidthUpdated?.()
    }
  }

  /**
    * 重算指定列的最大宽度（取所有行该列的最大值）
    * 优先级：cellWidths > imageFallback > fallback
    * - cellWidths>0：已重测，用最新值
    * - cellWidths==0且imageFallback>0：图片cell未重测，用图片实际宽度
    * - cellWidths==0且imageFallback==0且fallback>0：宽text cell未重测，用contentWidth
    *
    * @param col 列索引
    * @return 列最大宽度
    */
  private recalcColumnMax(col: number): number {
    let newMax = 0
    this.cellWidths.forEach((rws: number[], row: number) => {
      const cw = rws[col]
      const imgFw = this.imageFallbackCellWidths.get(row)?.[col] ?? 0
      const fw = this.fallbackCellWidths.get(row)?.[col] ?? 0
      const w = cw > 0 ? cw : (imgFw > 0 ? imgFw : fw)
      if (w > newMax) {
        newMax = w
      }
    })
    return newMax
  }

  /**
    * 清除指定行的所有单元格宽度记录（行删除时调用）
    *
    * @param row 行索引
    */
  clearRow(row: number): void {
    this.fallbackCellWidths.delete(row)
    this.imageFallbackCellWidths.delete(row)
    if (!this.cellWidths.delete(row)) {
      return
    }
    let changed = false
    for (let col = 0; col < this.widths.length; col++) {
      const oldMax = this.widths[col]
      const newMax = this.recalcColumnMax(col)
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
    * 清零cellWidths，保留fallback和imageFallback。
    * 容器宽度变化（evenWidth缩小）时调用，允许窄cell重新测量。
    * - 宽cell（fallback>0或imageFallback>0）：列宽不变→cell不变→onSizeChange不触发→fallback仍可用
    * - 窄cell（fallback=0且imageFallback=0）：cellWidths清零→widths=0→columnWidths=evenWidth
    *   → cell收缩→onSizeChange触发→tracker更新
    * 不触发onWidthUpdated，由调用方负责后续applyColumnWidths
    */
  saveFallbackAndClear(): void {
    this.cellWidths.forEach((rws: number[]) => {
      for (let i = 0; i < rws.length; i++) {
        rws[i] = 0
      }
    })
    for (let col = 0; col < this.widths.length; col++) {
      this.widths[col] = this.recalcColumnMax(col)
    }
  }

  /**
    * 清除指定列所有单元格的cellWidths + 指定单元格的fallback和imageFallback（LaTeX图片加载完成时调用）
    *
    * LaTeX未加载时显示原始文本（可能很宽），加载后显示图片（可能更窄）。
    * - LaTeX原始文本使列变宽（columnWidths=300），其他cell的minWidth也=300
    * - 其他cell是窄cell（content<300），onSizeChange报告width=300（=minWidth），cellWidths=300（stale）
    * - 必须清整列所有cellWidths，让recalcColumnMax用fallback/imageFallback
    *
    * 清除后：
    * - cellWidths[*][col]全清零（移除stale minWidth值）
    * - fallback[row][col]清零（移除stale原始文本宽度，仅此cell）
    * - imageFallback[row][col]清零（移除stale值，仅此cell，setFallback会重新设置）
    * - 其他cell的fallback和imageFallback保留（图片cell的imageFallback=contentWidth，正确保留）
    * - recalcColumnMax用fallback/imageFallback重算：窄text cell→0（列收缩），图片cell→imageFallback
    *
    * @param row 行索引（LaTeX所在行，仅清此行fallback/imageFallback）
    * @param col 列索引（清此列所有cellWidths）
    */
  clearCellWidth(row: number, col: number): void {
    if (col < 0 || col >= this.widths.length) {
      return
    }
    // 清整列所有cellWidths（移除stale minWidth值）
    this.cellWidths.forEach((rws: number[]) => {
      rws[col] = 0
    })
    // 清此cell的fallback（移除stale原始文本宽度）
    const fws = this.fallbackCellWidths.get(row)
    if (fws !== undefined) {
      fws[col] = 0
    }
    // 清此cell的imageFallback（setFallback会重新设置）
    const imgFws = this.imageFallbackCellWidths.get(row)
    if (imgFws !== undefined) {
      imgFws[col] = 0
    }
    const oldMax = this.widths[col]
    const newMax = this.recalcColumnMax(col)
    if (newMax !== oldMax) {
      this.widths[col] = newMax
      this.onWidthUpdated?.()
    }
  }

  /**
    * 直接设置单元格的imageFallback宽度（图片加载完成时调用）
    * 图片onComplete/LaTeX加载完成后，已知实际内容宽度，直接存为imageFallback。
    * imageFallback不受updateCellWidth影响（不会被清除），确保clearWidths/clearCellWidth后
    * recalcColumnMax仍能用图片实际宽度，防止图片cell列宽收缩到图片宽度以下。
    *
    * @param row 行索引
    * @param col 列索引
    * @param width 实际内容宽度（如imageWidth或LaTeX图片显示宽度）
    */
  setFallback(row: number, col: number, width: number): void {
    if (col < 0 || col >= this.widths.length) {
      return
    }
    let imgFws = this.imageFallbackCellWidths.get(row)
    if (imgFws === undefined) {
      imgFws = new Array(this.widths.length).fill(0)
      this.imageFallbackCellWidths.set(row, imgFws)
    }
    if (imgFws[col] === width) {
      return
    }
    imgFws[col] = width
    const oldMax = this.widths[col]
    const newMax = this.recalcColumnMax(col)
    if (newMax !== oldMax) {
      this.widths[col] = newMax
      this.onWidthUpdated?.()
    }
  }

  /**
    * 清除所有列宽测量值和fallback，保留imageFallback和行/列结构。
    * 流式输出内容变化（如原始markdown→渲染后的链接，内容缩短）时调用，允许所有cell重新测量。
    * - cellWidths清零→widths=0→columnWidths=evenWidth→所有cell收缩→onSizeChange触发→重测
    * - fallback清零→移除text cell的stale contentWidth（内容已缩短但fallback仍是旧值）
    * - imageFallback保留→图片cell未重测时仍用图片实际宽度（防止图片cell列宽过度收缩→bounce）
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
    this.fallbackCellWidths.forEach((fws: number[]) => {
      for (let i = 0; i < fws.length; i++) {
        fws[i] = 0
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
      this.fallbackCellWidths.forEach((fws: number[], row: number) => {
        if (fws.length > size) {
          this.fallbackCellWidths.set(row, fws.slice(0, size))
        } else if (fws.length < size) {
          const newFws: number[] = new Array(size).fill(0)
          for (let i = 0; i < fws.length; i++) {
            newFws[i] = fws[i]
          }
          this.fallbackCellWidths.set(row, newFws)
        }
      })
      this.imageFallbackCellWidths.forEach((imgFws: number[], row: number) => {
        if (imgFws.length > size) {
          this.imageFallbackCellWidths.set(row, imgFws.slice(0, size))
        } else if (imgFws.length < size) {
          const newImgFws: number[] = new Array(size).fill(0)
          for (let i = 0; i < imgFws.length; i++) {
            newImgFws[i] = imgFws[i]
          }
          this.imageFallbackCellWidths.set(row, newImgFws)
        }
      })
    }
  }
}
