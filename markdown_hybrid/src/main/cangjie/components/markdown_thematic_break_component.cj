package markdown.components

import ohos.state_macro_manage.*

/**
 * 分割线控件
 */
@Component
class MarkdownThematicBreakComponent {
    var markdownTheme: MarkdownTheme // markdown样式

    func build() {
        Column() {
            if (markdownTheme.dividerTheme.dividerStrokeWidth > 0.0) {
                Divider()
                    .color(markdownTheme.dividerTheme.dividerColor)
                    .strokeWidth(markdownTheme.dividerTheme.dividerStrokeWidth)
                    .lineCap(markdownTheme.dividerTheme.dividerStyle)
            }
        }
        .padding(
            top: markdownTheme.dividerTheme.dividerPaddingTop,
            right: markdownTheme.dividerTheme.dividerPaddingRight,
            bottom: markdownTheme.dividerTheme.dividerPaddingBottom,
            left: markdownTheme.dividerTheme.dividerPaddingLeft
        )
    }
}
