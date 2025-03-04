/**
 * Created on 2025/2/27
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

@Component
class MarkdownCodeBlockINCComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 代码内容
     */
    var codeText: String

    /**
     * 代码类型
     */
    var info: ?String

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    var codeItem: NodeView

    func build() {
        Stack(Alignment.TopEnd) {
            // 代码块部分
            codeBlockComponent()
            // 复制按钮全屏按钮部分
            if (getProp<Bool>(codeItem, "closed", true)) {
                codeBlockButtonComponent()
            }
        }
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
    }

    /**
     * 代码文本内容
     */
    @Builder
    func codeBlockTextComponent() {
        Text(codeText)
            // 设置文本颜色
            .fontColor(codeTextColor(markdownConfiguration.markdownTheme, markdownConfiguration.prismTheme))
            // 设置文本尺寸
            .fontSize(markdownConfiguration.markdownTheme.codeBlockTextSize)
            // 设置文本的字体列表
            .fontFamily(markdownConfiguration.markdownTheme.codeBlockTypeface)
            // 设置多行文本的文本对齐方式
            .textAlign(TextAlign.Start)
            // 设置内边距属性
            .padding(left: markdownConfiguration.markdownTheme.codeMultilineMargin)
    }

    /**
     * 代码块部分
     */
    @Builder
    func codeBlockComponent() {
        Scroll() {
            // 代码文本内容
            codeBlockTextComponent()
        }
        // 设置组件的背景色
        .backgroundColor(codeBackgroundColor(markdownConfiguration.markdownTheme, markdownConfiguration.prismTheme))
        // 设置滚动方法
        .scrollable(ScrollDirection.Horizontal)
        // 设置滚动条状态
        .scrollBar(BarState.Off)
        // 设置元素内容的对齐方式
        .align(Alignment.Start)
        // 设置元素水平方向的布局
        .direction(Direction.Ltr)
        // 设置组件自身的宽度
        .width(100.percent)
        // 设置内边距属性
        .padding(top: 10, bottom: 10)
    }

    /**
     * 复制按钮和全屏按钮部分
     */
    @Builder
    func codeBlockButtonComponent() {
        Row() {
            // 复制按钮
            if (markdownConfiguration.markdownTheme.codeCopyIcon.isSome() && codeText.trimAscii().size > 0) {
                // 设置图片的数据源
                Image(markdownConfiguration.markdownTheme.codeCopyIcon())
                    // 设置组件自身的宽度
                    .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置组件自身的高度
                    .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Contain)
                    // 点击动作触发该方法调用
                    .onClick {evt => codeCopyOnClick(codeText, markdownConfiguration.codeCopyCallback)}
            }
            // 全屏按钮
            if (markdownConfiguration.markdownTheme.codeFullScreenIcon.isSome() && codeText.trimAscii().size > 0) {
                // 设置图片的数据源
                Image(markdownConfiguration.markdownTheme.codeFullScreenIcon())
                    // 设置组件自身的宽度
                    .width(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置组件自身的高度
                    .height(markdownConfiguration.markdownTheme.iconWidthAndHeight)
                    // 设置外边距属性
                    .margin(left: 8)
                    // 设置图片的缩放类型
                    .objectFit(ImageFit.Contain)
                    // 控制当前组件显示或隐藏
                    .visibility(isVisibility(markdownConfiguration.markdownTheme.isCodeFullScreen))
                    // 点击动作触发该方法调用
                    .onClick {evt => codeFullScreenOnClick(codeText, info, markdownConfiguration.codeFullScreenCallback)}
            }
        }
        // 设置外边距属性
        .margin(top: 8, right: 8)
    }

    /**
     * 代码块文字颜色 -- 代码高亮
     *
     * @param item PrismNodesParseRes
     * @param markdownTheme markdown基础样式
     * @param prismTheme 代码高亮样式
     * @return 文字颜色
     */
    func codeTextColor(markdownTheme: MarkdownTheme, prismTheme: PrismTheme): Color {
        if (markdownTheme.codeBlockTextColor.isSome()) {
            return markdownTheme.codeBlockTextColor()
        } else {
            return prismTheme.textColor()
        }
    }
}
