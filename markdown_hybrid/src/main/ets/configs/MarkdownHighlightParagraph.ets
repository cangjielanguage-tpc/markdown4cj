import { ArrayList } from "@kit.ArkTS"
import { COLOR_FF4A90E2, COLOR_FFE0E0E0, COLOR_TRANSPARENT } from "../base/Constants"

/**
 * markdown 段落高亮配置
 */
@Observed
export class MarkdownHighlightParagraph {
  private allParagraphItems: ArrayList<string> = new ArrayList<string>() // 所有可以设置高亮的段落nodeHash集合
  private selectedParagraphItems: ArrayList<string> = new ArrayList<string>() // 当前高亮显示的段落集合
  selectedParagraphItem: string = "" // 当前高亮显示的段落的nodeHash
  selectedParagraphItemColor: ResourceColor = "" // 当前高亮显示的段落的背景色
  beforeSelectedParagraphBackgroundColor: ResourceColor = COLOR_FFE0E0E0 // 当前长按未触发弹窗时段落前的背景色，默认透明
  selectedParagraphBackgroundColor: ResourceColor = COLOR_FF4A90E2 // 当前长按放手后选中文字的背景色，默认蓝色
  customLongPressCallback?: () => void = undefined // 自定义长按事件

  /**
   * (markdown解析后自动调用)设置所有可以设置高亮的段落nodeHash集合
   * @param itemNodeHashList 段落nodeHash集合
   */
  setAllParagraphItems(itemNodeHashList: ArrayList<string>): void {
    // 去重，保留第一次出现的位置
    itemNodeHashList.forEach(item => {
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
  getSelectedParagraphItems(): ArrayList<string> {
    return this.selectedParagraphItems
  }

  /**
   * 设置指定段落高亮显示
   * @param nodeHash 段落nodeHash
   * @param color 段落高亮颜色
   *
   * @return 是否设置成功 false表示已经设置过或设置失败
   */
  setParagraphHighlight(nodeHash: string, color: ResourceColor): boolean {
    this.selectedParagraphItem = nodeHash
    this.selectedParagraphItemColor = color
    if (this.selectedParagraphItems.has(nodeHash)) {
      return false
    } else {
      return this.selectedParagraphItems.add(nodeHash)
    }
  }

  /**
   * 取消指定段落的高亮
   * @param nodeHash 段落nodeHash
   *
   * @return 是否取消成功 false表示该段落没有高亮
   */
  clearParagraphHighlight(nodeHash: string): boolean {
    this.selectedParagraphItem = ""
    return this.selectedParagraphItems.remove(nodeHash)
  }

  /**
   * 取消所有段落高亮
   */
  clearAllParagraphHighlights(): void {
    this.selectedParagraphItem = ""
    this.selectedParagraphItemColor = ""
    this.selectedParagraphItems.clear()
  }

  /**
   * 设置当前长按未触发弹窗时段落前的背景色
   * @param backgroundColor 段落背景色
   */
  setBeforeSelectedParagraphBackgroundColor(backgroundColor: ResourceColor): void {
    this.beforeSelectedParagraphBackgroundColor = backgroundColor
  }

  /**
   * 设置当前长按放手后选中文字的背景色
   * @param backgroundColor 选中文字的背景色
   */
  setSelectedParagraphBackgroundColor(backgroundColor: ResourceColor): void {
    this.selectedParagraphBackgroundColor = backgroundColor
  }

  /**
   * 自定义长按事件
   *
   * @param cb 自定义长按事件
   */
  setLongCallback(cb: () => void): void {
    this.customLongPressCallback = cb
  }
}