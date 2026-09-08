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
   * 设置段落高亮
   *
   * @param nodeHash 段落的nodeHash
   * @param color 高亮颜色
   */
  setParagraphHighlight(nodeHash: string, color: number): void {
    this.cjHighlightParagraph?.setParagraphHighlight(nodeHash, color)
  }

  /**
   * 清除指定段落的高亮
   *
   * @param nodeHash 段落的nodeHash
   */
  clearParagraphHighlight(nodeHash: string): void {
    this.cjHighlightParagraph?.clearParagraphHighlight(nodeHash)
  }

  /**
   * 清除所有段落的高亮
   */
  clearAllParagraphHighlights(): void {
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
