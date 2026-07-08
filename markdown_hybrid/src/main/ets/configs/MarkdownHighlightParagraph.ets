import { ArrayList } from "@kit.ArkTS"

/**
 * markdown XC需求相关配置
 */
@Observed
export class MarkdownHighlightParagraph {
  private allParagraphItems: ArrayList<string> = new ArrayList<string>() // 所有可以设置高亮的段落nodeHash集合
  private selectedParagraphItemList: ArrayList<string> = new ArrayList<string>() // 当前高亮显示的段落集合

  selectedParagraphItem: string = "" // 当前高亮显示的段落的nodeHash
  selectedParagraphItemColor: ResourceColor = "" // 当前高亮显示的段落的背景色

  /**
   * 设置所有可以设置高亮的段落nodeHash集合
   * @param itemIndexList 段落nodeHash集合
   */
  setAllParagraphItems(itemIndexList: ArrayList<string>): void {
    // 去重，保留第一次出现的位置
    itemIndexList.forEach(item => {
      if (item !== undefined && !this.allParagraphItems.has(item)) {
        this.allParagraphItems.add(item)
      }
    })
  }

  /**
   * 获取所有可以设置高亮的段落的nodeHash集合
   * @return 段落nodeHash集合
   */
  getAllParagraphItems(): Array<string> {
    return this.allParagraphItems.convertToArray()
  }

  /**
   * 获取当前高亮显示的段落nodeHash集合
   * @return 段落nodeHash集合
   */
  getSelectedParagraphItemList(): ArrayList<string> {
    return this.selectedParagraphItemList
  }

  /**
   * 设置指定段落高亮显示
   * @param index 段落nodeHash
   * @param color 段落高亮颜色
   *
   * @return 是否设置成功 false表示已经设置过
   */
  highlightParagraph(index: string, color: ResourceColor): boolean {
    this.selectedParagraphItem = index
    this.selectedParagraphItemColor = color
    if (this.selectedParagraphItemList.has(index)) {
      return false
    } else {
      return this.selectedParagraphItemList.add(index)
    }
  }

  /**
   * 取消指定段落的高亮
   * @param index 段落nodeHash
   *
   * @return 是否取消成功 false表示该段落没有高亮
   */
  clearParagraphHighlight(index: string): boolean {
    this.selectedParagraphItem = ""
    return this.selectedParagraphItemList.remove(index)
  }

  /**
   * 取消所有段落高亮
   */
  clearAllParagraphHighlights(): void {
    this.selectedParagraphItem = ""
    this.selectedParagraphItemColor = ""
    this.selectedParagraphItemList.clear()
  }
}