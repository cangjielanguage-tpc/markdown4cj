package markdown.components

import ohos.state_macro_manage.*

/**
 * 表格头复制按钮组件
 * 显示标题文字和复制按钮，点击复制按钮时回调序列化的表格纯文本
 */
@Component
class MarkdownTableTitleComponent {
    var tableTitleMarkdownConfiguration: MarkdownConfiguration // markdown配置
    @Prop
    var tableTitleFullText: String // 表格序列化的纯文本

    func build() {
        Row {
            if (tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableHeadTitleText.size > 0) {
                Text(tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableHeadTitleText)
                    .fontColor(getHeadTitleFontColor())
                    .fontSize(getHeadTitleFontSize())
                    .fontStyle(getHeadTitleFontStyle())
                    .fontWeight(getHeadTitleFontWeight())
                    .fontFamily(getHeadTitleFontFamily())
                    .lineHeight(getHeadTitleLineHeight())
                    .letterSpacing(tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableTitleTextLetterSpacing)
                    .margin(left: tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableHeadTitleTextMarginLeft)
                    .maxLines(1)
                    .textOverflow(TextOverflow.Ellipsis)
                    .constraintSize(minWidth: 30.percent)
                    .layoutWeight(1)
            }
            if (tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableHeadCopyIcon.isSome()) {
                Image(tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableHeadCopyIcon())
                    .width(tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableHeadCopyIconWidth)
                    .height(tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableHeadCopyIconHeight)
                    .margin(right: tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableHeadCopyIconMarginRight)
                    .onClick({
                        event => onCopyClicked()
                    })
            }
        }
        .width(100.percent)
        .padding(
            top: tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableCellPaddingTop,
            bottom: tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableCellPaddingBottom,
            left: tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableCellPaddingLeft,
            right: tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableCellPaddingRight
        )
        .backgroundColor(tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableTitleBackgroundColor)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .borderStyle(tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableBorderStyle)
        .borderWidth(top: 0.0, bottom: tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableBorderWidth, left: 0.0, right: 0.0)
        .borderColor(tableTitleMarkdownConfiguration.markdownTheme.tableTheme.tableBorderColor)
    }

    func getHeadTitleFontColor(): Color {
        let theme = tableTitleMarkdownConfiguration.markdownTheme.tableTheme
        if (theme.tableHeadTitleTextFontColor.isSome()) {
            return theme.tableHeadTitleTextFontColor()
        }
        return theme.tableTitleTextFontColor
    }

    func getHeadTitleFontSize(): Float64 {
        let theme = tableTitleMarkdownConfiguration.markdownTheme.tableTheme
        if (theme.tableHeadTitleTextFontSize.isSome()) {
            return theme.tableHeadTitleTextFontSize()
        }
        return theme.tableTitleTextFontSize
    }

    func getHeadTitleFontStyle(): FontStyle {
        let theme = tableTitleMarkdownConfiguration.markdownTheme.tableTheme
        if (theme.tableHeadTitleTextFontStyle.isSome()) {
            return theme.tableHeadTitleTextFontStyle()
        }
        return theme.tableTitleTextFontStyle
    }

    func getHeadTitleFontWeight(): FontWeight {
        let theme = tableTitleMarkdownConfiguration.markdownTheme.tableTheme
        if (theme.tableHeadTitleTextFontWeight.isSome()) {
            return theme.tableHeadTitleTextFontWeight()
        }
        return theme.tableTitleTextFontWeight
    }

    func getHeadTitleFontFamily(): String {
        let theme = tableTitleMarkdownConfiguration.markdownTheme.tableTheme
        if (theme.tableHeadTitleTextFontFamily.isSome()) {
            return theme.tableHeadTitleTextFontFamily()
        }
        return theme.tableTitleTextFontFamily
    }

    func getHeadTitleLineHeight(): Float64 {
        let theme = tableTitleMarkdownConfiguration.markdownTheme.tableTheme
        if (theme.tableHeadTitleTextLineHeight.isSome()) {
            return theme.tableHeadTitleTextLineHeight()
        }
        return theme.tableTitleTextLineHeight
    }

    /**
     * 复制按钮点击事件
     */
    func onCopyClicked(): Unit {
        if (let Some(cb) <- tableTitleMarkdownConfiguration.tableCopyCallback) {
            cb(tableTitleFullText)
        }
    }
}
