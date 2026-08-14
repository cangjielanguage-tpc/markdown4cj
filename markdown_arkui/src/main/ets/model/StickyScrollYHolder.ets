/**
 * 外层滚动Y持有者（@Observed + 监听器模式）
 *
 * 通过 @Provide/@Consume 传递对象引用（引用不变，不触发 build()）
 * 通过监听器模式通知 MarkdownTable 更新 StickyOffsetHolder（只触发 StickyOffsetApplier 重渲染）
 */
@Observed
export class StickyScrollYHolder {
  y: number = -1 // 当前滚动Y
  enabled: boolean = false // 是否启用 offset sticky 模式（页面传入 scrollController 时为 true）
  private listeners: Set<(y: number) => void> = new Set()

  setY(y: number): void {
    if (this.y === y) {
      return
    } // 去重，避免相同值重复触发监听器
    this.y = y
    this.listeners.forEach((l) => l(y))
  }

  addListener(l: (y: number) => void): void {
    this.listeners.add(l)
  }

  removeListener(l: (y: number) => void): void {
    this.listeners.delete(l)
  }
}

/**
 * 吸顶偏移量持有者（@Observed）
 *
 * @ObjectLink 检测 offset 变化，只触发 StickyOffsetApplier 重渲染（极轻量 build()）
 * 不触发 MarkdownTable build()，避免 800+ 行 build() 延迟
 */
@Observed
export class StickyOffsetHolder {
  offset: number = 0 // header 吸顶偏移量
}
