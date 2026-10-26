import { requireCJLib } from 'libark_interop_loader.so'
import { CustomLib, CJMarkdownHighlightParagraph } from 'libark_interop_api_markdown_hybrid.so'
import { global_customLib } from '../pages/CJMarkDown'

/**
 * 段落高亮配置
 *
 * 用于对Markdown段落进行高亮/取消高亮操作
 */
export class MarkdownHighlightParagraph {
  private cjHighlightParagraph: CJMarkdownHighlightParagraph | undefined = undefined
  // 当前高亮段落的nodeHash（对齐ArkUI原版公开字段，由本类维护：set记录、clear置空）
  private selectedParagraphItem: string = ''
  // 当前高亮段落的背景色（对齐ArkUI原版公开字段，由本类维护）
  private selectedParagraphItemColor: number | undefined = undefined
  // 长按前段落默认背景色（对齐ArkUI原版公开字段，由本类维护）
  private beforeSelectedParagraphBackgroundColor: number | undefined = undefined
  // 长按选中段落的背景色（对齐ArkUI原版公开字段，由本类维护）
  private selectedParagraphBackgroundColor: number | undefined = undefined

  /**
   * 构造函数
   */
  constructor() {
    let lib = global_customLib
    if (lib === undefined) {
      lib = requireCJLib("libmarkdown_hybrid.so") as CustomLib
    }
    this.cjHighlightParagraph = new lib.CJMarkdownHighlightParagraph()
  }

  /**
   * 获取所有段落的nodeHash集合
   *
   * @returns 段落nodeHash集合
   */
  getAllParagraphItems(): Array<string> {
    return this.cjHighlightParagraph?.getAllParagraphItems() ?? []
  }

  /**
   * 获取当前高亮显示的段落nodeHash集合
   *
   * @returns 当前高亮的段落nodeHash集合
   */
  getSelectedParagraphItems(): Array<string> {
    return this.cjHighlightParagraph?.getSelectedParagraphItems() ?? []
  }

  /**
   * 获取当前高亮段落的nodeHash
   *
   * @returns 当前高亮段落的nodeHash，无高亮时为空字符串
   */
  getSelectedParagraphItem(): string {
    return this.selectedParagraphItem
  }

  /**
   * 获取当前高亮段落的背景色
   *
   * @returns 当前高亮段落的背景色（ARGB值），无高亮时为undefined
   */
  getSelectedParagraphItemColor(): number | undefined {
    return this.selectedParagraphItemColor
  }

  /**
   * 获取长按前段落默认背景色
   *
   * @returns 长按前段落默认背景色（ARGB值），未设置时为undefined
   */
  getBeforeSelectedParagraphBackgroundColor(): number | undefined {
    return this.beforeSelectedParagraphBackgroundColor
  }

  /**
   * 获取长按选中段落的背景色
   *
   * @returns 长按选中段落的背景色（ARGB值），未设置时为undefined
   */
  getSelectedParagraphBackgroundColor(): number | undefined {
    return this.selectedParagraphBackgroundColor
  }

  /**
   * 设置段落高亮
   * 已高亮的段落重复设置返回false（幂等），不同段落可同时保持高亮
   *
   * @param nodeHash 段落的nodeHash
   * @param color 高亮颜色（ARGB值，如0xFFFA8072）
   * @returns 是否设置成功 false表示已经设置过或设置失败（未找到nodeHash）
   */
  setParagraphHighlight(nodeHash: string, color: number): boolean {
    this.selectedParagraphItem = nodeHash
    this.selectedParagraphItemColor = color
    return this.cjHighlightParagraph?.setParagraphHighlight(nodeHash, color) ?? false
  }

  /**
   * 设置当前长按未触发弹窗时段落前的背景色
   *
   * @param color 段落背景色（ARGB值，如0xFFE0E0E0）
   */
  setBeforeSelectedParagraphBackgroundColor(color: number): void {
    this.beforeSelectedParagraphBackgroundColor = color
    this.cjHighlightParagraph?.setBeforeSelectedParagraphBackgroundColor(color)
  }

  /**
   * 设置当前长按放手后选中文字的背景色
   *
   * @param color 选中文字的背景色（ARGB值，如0xFF4A90E2）
   */
  setSelectedParagraphBackgroundColor(color: number): void {
    this.selectedParagraphBackgroundColor = color
    this.cjHighlightParagraph?.setSelectedParagraphBackgroundColor(color)
  }

  /**
   * 清除指定段落的高亮
   *
   * @param nodeHash 段落的nodeHash
   * @returns 是否取消成功 false表示该段落没有高亮或者未找到nodeHash
   */
  clearParagraphHighlight(nodeHash: string): boolean {
    this.selectedParagraphItem = ''
    return this.cjHighlightParagraph?.clearParagraphHighlight(nodeHash) ?? false
  }

  /**
   * 清除所有段落的高亮
   */
  clearAllParagraphHighlights(): void {
    this.selectedParagraphItem = ''
    this.selectedParagraphItemColor = undefined
    this.cjHighlightParagraph?.clearAllParagraphHighlights()
  }

  /**
   * 获取内部CJMarkdownHighlightParagraph实例
   *
   * @returns CJMarkdownHighlightParagraph实例
   */
  getCJHighlightParagraph(): CJMarkdownHighlightParagraph | undefined {
    return this.cjHighlightParagraph
  }
}
