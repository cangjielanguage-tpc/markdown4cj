package markdown.components

import ohos.state_macro_manage.*

/**
 * 吸顶偏移量应用器
 *
 * 极轻量组件：build()只有Column { child }.offset().backgroundColor()
 * 通过StickyOffsetRegistry注册回调，当外层滚动Y变化时，
 * 仅本组件重渲染（设置@State stickyOffset），不触发父组件MarkdownTableBlockComponent的build()。
 *
 * @param applierHash 组件唯一标识（使用NodeView.nodeHash）
 * @param applierBgColor 背景颜色（覆盖body行）
 * @param applierChild 子内容builder（header行的Scroll+RowComponent）
 */
@Component
class StickyOffsetApplier {
    var applierHash: Int64 // 唯一标识
    var applierBgColor: Color // 背景颜色
    @BuilderParam
    var applierChild: () -> Unit // 子内容
    @State
    var stickyOffset: Float64 = 0.0 // 吸顶偏移量

    protected override func aboutToAppear(): Unit {
        StickyOffsetRegistry.register(applierHash, updateStickyOffset)
    }

    protected override func aboutToDisappear(): Unit {
        StickyOffsetRegistry.unregister(applierHash)
    }

    /**
     * 更新吸顶偏移量
     * 由StickyOffsetRegistry调用，仅触发本组件重渲染
     *
     * @param newOffset 新的偏移量
     */
    func updateStickyOffset(newOffset: Float64): Unit {
        this.stickyOffset = newOffset
    }

    func build() {
        Column() {
            applierChild()
        }
        .backgroundColor(applierBgColor)
        .offset(x: 0.0, y: stickyOffset)
    }
}
