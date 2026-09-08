import { requireCJLib } from 'libark_interop_loader.so'
import { CustomLib, CJMarkdownScrollController } from 'libark_interop_api_markdown_hybrid.so'
import { global_customLib } from '../pages/CJMarkDown'

/**
 * 外层滚动控制器
 *
 * 不固定高度模式下，页面通过此控制器将外层Scroll的滚动Y传递给MarkdownComponent，
 * 实现表格吸顶功能。固定高度模式下无需设置。
 */
export class MarkdownScrollController {
  private scrollController: CJMarkdownScrollController | undefined = undefined

  /**
   * 构造函数
   */
  constructor() {
    let lib = global_customLib
    if (lib === undefined) {
      lib = requireCJLib("libmarkdown_hybrid.so") as CustomLib
    }
    this.scrollController = new lib.CJMarkdownScrollController()
  }

  /**
   * 设置外层滚动Y偏移量
   *
   * @param y 滚动Y偏移量
   */
  setScrollY(y: number): void {
    this.scrollController?.setScrollY(y)
  }

  /**
   * 获取内部CJMarkdownScrollController实例
   *
   * @returns CJMarkdownScrollController实例
   */
  getCJScrollController(): CJMarkdownScrollController | undefined {
    return this.scrollController
  }
}
