/**
 * 外层滚动控制器
 *
 * 不固定高度模式下，页面通过此控制器将外层 Scroll 的滚动Y传递给 CJMarkdown，
 * CJMarkdown 再通过 @Provide 分发给表格组件，实现 offset sticky 吸顶。
 *
 * 用法：
 * 1. 页面创建控制器：private mdScrollController = new MarkdownScrollController()
 * 2. 传给 CJMarkdown：CJMarkdown({ scrollController: this.mdScrollController, ... })
 * 3. 外层 Scroll 的 onScrollFrameBegin 中调用：this.mdScrollController.notifyScrollY(newY)
 */
export class MarkdownScrollController {
  private scrollYListener: ((yOffset: number) => void) | null = null

  /**
   * 注册滚动Y监听（由 CJMarkdown 内部调用）
   */
  setListener(listener: ((yOffset: number) => void) | null): void {
    this.scrollYListener = listener
  }

  /**
   * 通知滚动Y变化（由页面在外层 Scroll.onScrollFrameBegin 中调用）
   */
  notifyScrollY(yOffset: number): void {
    this.scrollYListener?.(yOffset)
  }
}
