package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownCodeBlockTheme {
    /**
     * 代码深浅色模式
     */
    var codeBlockIsDark: ?Bool = None

    /**
     * 是否格式化围栏代码块内容
     */
    var codeBlockIsCodeFormat: ?Bool = None

    /**
     * codeformat是否用制表符
     */
    var codeBlockUseTab: ?Bool = None

    /**
     * codeformat空格缩进数量
     */
    var codeBlockIndentWidth: ?Int64 = None

    /**
     * 围栏代码块代码高亮是否同步解析
     */
    var codeBlockParserSync: ?Bool = None

    /**
     * 代码块背景颜色
     */
    var codeBlockBackgroundColor: ?Color = None

    /**
     * 代码块上外边距
     */
    var codeBlockMarginTop: ?Float64 = None

    /**
     * 代码块右外边距
     */
    var codeBlockMarginRight: ?Float64 = None

    /**
     * 代码块下外边距
     */
    var codeBlockMarginBottom: ?Float64 = None

    /**
     * 代码块左外边距
     */
    var codeBlockMarginLeft: ?Float64 = None

    /**
     * 代码块上内边距
     */
    var codeBlockPaddingTop: ?Float64 = None

    /**
     * 代码块右内边距
     */
    var codeBlockPaddingRight: ?Float64 = None

    /**
     * 代码块下内边距
     */
    var codeBlockPaddingBottom: ?Float64 = None

    /**
     * 代码块左内边距
     */
    var codeBlockPaddingLeft: ?Float64 = None

    /**
     * 代码块边框样式
     */
    var codeBlockBorderStyle: ?BorderStyle = None

    /**
     * 代码块边框宽度
     */
    var codeBlockBorderWidth: ?Float64 = None

    /**
     * 代码块边框颜色
     */
    var codeBlockBorderColor: ?Color = None

    /**
     * 代码块边框左上圆角
     */
    var codeBlockRadiusTopLeft: ?Float64 = None

    /**
     * 代码块边框右上圆角
     */
    var codeBlockRadiusTopRight: ?Float64 = None

    /**
     * 代码块边框左下圆角
     */
    var codeBlockRadiusBottomLeft: ?Float64 = None

    /**
     * 代码块边框右下圆角
     */
    var codeBlockRadiusBottomRight: ?Float64 = None

    /**
     * 代码块类型和代码块内容间距
     */
    var codeBlockTitleLayoutMarginBottom: ?Float64 = None

    /**
     * 代码块类型左边距
     */
    var codeBlockTypeTextMarginLeft: ?Float64 = None

    /**
     * 代码块没有代码类型时默认显示文本
     */
    var codeBlockTypeText: ?String = None

    /**
     * 代码块类型文本颜色
     */
    var codeBlockTypeTextFontColor: ?Color = None

    /**
     * 代码块类型文本尺寸
     */
    var codeBlockTypeTextFontSize: ?Float64 = None

    /**
     * 代码块类型文本字体样式
     */
    var codeBlockTypeTextFontStyle: ?FontStyle = None

    /**
     * 代码块类型文本字体粗细
     */
    var codeBlockTypeTextFontWeight: ?FontWeight = None

    /**
     * 代码块类型文本字体
     */
    var codeBlockTypeTextFontFamily: ?String = None

    /**
     * 代码块类型文本行高
     */
    var codeBlockTypeTextLineHeight: ?Float64 = None

    /**
     * 代码块代码复制和代码全屏间距
     */
    var codeBlockCopyFullScreenSpacing: ?Float64 = None

    /**
     * 代码块代码复制按钮是否显示
     */
    var codeBlockCopyButtonIsShow: ?Bool = None

    /**
     * 代码块代码复制文本是否显示
     */
    var codeBlockCopyTextIsShow: ?Bool = None

    /**
     * 代码块代码复制图标宽度
     */
    var codeBlockCopyIconWidth: ?Float64 = None

    /**
     * 代码块代码复制图标高度
     */
    var codeBlockCopyIconHeight: ?Float64 = None

    /**
     * 代码块代码复制图标和文本间距
     */
    var codeBlockCopyIconTextSpacing: ?Float64 = None

    /**
     * 代码块代码复制默认文本内容
     */
    var codeBlockCopyText: ?String = None

    /**
     * 代码块代码复制文本颜色
     */
    var codeBlockCopyTextFontColor: ?Color = None

    /**
     * 代码块代码复制文本尺寸
     */
    var codeBlockCopyTextFontSize: ?Float64 = None

    /**
     * 代码块代码复制文本字体样式
     */
    var codeBlockCopyTextFontStyle: ?FontStyle = None

    /**
     * 代码块代码复制文本字体粗细
     */
    var codeBlockCopyTextFontWeight: ?FontWeight = None

    /**
     * 代码块代码复制文本字体
     */
    var codeBlockCopyTextFontFamily: ?String = None

    /**
     * 代码块代码复制文本行高
     */
    var codeBlockCopyTextLineHeight: ?Float64 = None

    /**
     * 代码块代码全屏按钮是否显示
     */
    var codeBlockFullScreenButtonIsShow: ?Bool = None

    /**
     * 代码块代码全屏文本是否显示
     */
    var codeBlockFullScreenTextIsShow: ?Bool = None

    /**
     * 代码块代码全屏图标宽度
     */
    var codeBlockFullScreenIconWidth: ?Float64 = None

    /**
     * 代码块代码全屏图标高度
     */
    var codeBlockFullScreenIconHeight: ?Float64 = None

    /**
     * 代码块代码全屏图标和文本间距
     */
    var codeBlockFullScreenIconTextSpacing: ?Float64 = None

    /**
     * 代码块代码全屏默认文本内容
     */
    var codeBlockFullScreenText: ?String = None

    /**
     * 代码块代码全屏文本颜色
     */
    var codeBlockFullScreenTextFontColor: ?Color = None

    /**
     * 代码块代码全屏文本尺寸
     */
    var codeBlockFullScreenTextFontSize: ?Float64 = None

    /**
     * 代码块代码全屏文本字体样式
     */
    var codeBlockFullScreenTextFontStyle: ?FontStyle = None

    /**
     * 代码块代码全屏文本字体粗细
     */
    var codeBlockFullScreenTextFontWeight: ?FontWeight = None

    /**
     * 代码块代码全屏文本字体
     */
    var codeBlockFullScreenTextFontFamily: ?String = None

    /**
     * 代码块代码全屏文本行高
     */
    var codeBlockFullScreenTextLineHeight: ?Float64 = None

    /**
     * 代码块代码行号是否显示
     */
    var codeBlockLineNumberIsShow: ?Bool = None

    /**
     * 代码块代码行号左内边距
     */
    var codeBlockLineNumberTextPaddingLeft: ?Float64 = None

    /**
     * 代码块代码行号文本颜色
     */
    var codeBlockLineNumberTextFontColor: ?Color = None

    /**
     * 代码块代码行号文本尺寸
     */
    var codeBlockLineNumberTextFontSize: ?Float64 = None

    /**
     * 代码块代码行号文本字体样式
     */
    var codeBlockLineNumberTextFontStyle: ?FontStyle = None

    /**
     * 代码块代码行号文本字体粗细
     */
    var codeBlockLineNumberTextFontWeight: ?FontWeight = None

    /**
     * 代码块代码行号文本字体
     */
    var codeBlockLineNumberTextFontFamily: ?String = None

    /**
     * 代码块代码行号文本行高
     */
    var codeBlockLineNumberTextLineHeight: ?Float64 = None

    /**
     * 代码块代码行号和代码块中间分割线颜色
     */
    var codeBlockDividerColor: ?Color = None

    /**
     * 代码块代码行号和代码块中间分割线宽度
     */
    var codeBlockDividerStrokeWidth: ?Float64 = None

    /**
     * 代码块代码行号和分割线间距
     */
    var codeBlockLineNumberDividerSpacing: ?Float64 = None

    /**
     * 代码块文本颜色
     */
    var codeBlockTextFontColor: ?Color = None

    /**
     * 代码块代码文本右外边距
     */
    var codeBlockTextMarginRight: ?Float64 = None

    /**
     * 代码块代码文本左外边距
     */
    var codeBlockTextMarginLeft: ?Float64 = None

    /**
     * 代码块文本尺寸
     */
    var codeBlockTextFontSize: ?Float64 = None

    /**
     * 代码块文本字体样式
     */
    var codeBlockTextFontStyle: ?FontStyle = None

    /**
     * 代码块文本字体粗细
     */
    var codeBlockTextFontWeight: ?FontWeight = None

    /**
     * 代码块文本字体
     */
    var codeBlockTextFontFamily: ?String = None

    /**
     * 代码块文本行高
     */
    var codeBlockTextLineHeight: ?Float64 = None

    /**
     * 代码块文本字符间距
     */
    var codeBlockTextLetterSpacing: ?Float64 = None

    /**
     * 组合代码块未选中标题字体大小
     */
    var codeBlockListTitleTextSize: ?Float64 = None

    /**
     * 组合代码块选中标题字体大小
     */
    var codeBlockListTitleSelectTextSize: ?Float64 = None

    /**
     * 组合代码块选中标题文本颜色
     */
    var codeBlockListTitleSelectTextColor: ?Color = None

    /**
     * 组合代码块未选中标题文本颜色
     */
    var codeBlockListTitleUnselectTextColor: ?Color = None

    /**
     * 组合代码块选中标题背景颜色
     */
    var codeBlockListTitleSelectBackgroundColor: ?Color = None

    /**
     * 组合代码块未选中标题背景颜色
     */
    var codeBlockListTitleUnselectBackgroundColor: ?Color = None

    /**
     * 是否单独代码块显示
     */
    var codeBlockIsSeparate: ?Bool = None

    /**
     * 单独代码块行号宽度
     */
    var codeBlockSeparateWidth: ?Float64 = None

    /**
     * 单独代码块是否居底显示
     */
    var codeBlockSeparateIsBottom: ?Bool = None

    public init() {}

    /**
     * 设置代码块深浅色
     *
     * @param isDark 是否是深色 - true：深色；false：浅色。默认false
     */
    public func setCodeBlockIsDark(isDark: Bool): Unit {
        this.codeBlockIsDark = isDark
    }

    /**
     * 设置是否格式化围栏代码块内容
     *
     * @param isCodeFormat 是否格式化围栏代码块内容
     */
    public func setCodeBlockIsCodeFormat(isCodeFormat: Bool): Unit {
        codeBlockIsCodeFormat = isCodeFormat
    }

    /**
     * 设置codeformat是否用制表符
     *
     * @param useTab 是否用制表符
     */
    public func setCodeBlockUseTab(useTab: Bool): Unit {
        codeBlockUseTab = useTab
    }

    /**
     * 设置codeformat空格缩进数量
     *
     * @param indentWidth 空格缩进数量
     */
    public func setCodeBlockIndentWidth(indentWidth: Int64): Unit {
        codeBlockIndentWidth = indentWidth
    }

    /**
     * 设置围栏代码块代码高亮是否同步解析
     *
     * @param parserSync 是否同步解析
     */
    public func setCodeBlockParserSync(parserSync: Bool): Unit {
        codeBlockParserSync = parserSync
    }

    /**
     * 设置代码块背景颜色
     *
     * @param color 代码块背景颜色
     */
    public func setCodeBlockBackgroundColor(color: UInt32): Unit {
        codeBlockBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 代码块整体外边距
     *
     * @param margin 外边距
     */
    public func setCodeBlockAllMargin(margin: Float64): Unit {
        codeBlockMarginTop = margin
        codeBlockMarginRight = margin
        codeBlockMarginBottom = margin
        codeBlockMarginLeft = margin
    }

    /**
     * 代码块分别设置四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     */
    public func setCodeBlockMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        codeBlockMarginTop = top
        codeBlockMarginRight = right
        codeBlockMarginBottom = bottom
        codeBlockMarginLeft = left
    }

    /**
     * 代码块整体内边距
     *
     * @param padding 内边距
     */
    public func setCodeBlockAllPadding(padding: Float64): Unit {
        codeBlockPaddingTop = padding
        codeBlockPaddingRight = padding
        codeBlockPaddingBottom = padding
        codeBlockPaddingLeft = padding
    }

    /**
     * 代码块分别设置四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     */
    public func setCodeBlockPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        codeBlockPaddingTop = top
        codeBlockPaddingRight = right
        codeBlockPaddingBottom = bottom
        codeBlockPaddingLeft = left
    }

    /**
     * 设置代码块边框样式
     *
     * @param borderStyle 代码块边框样式
     */
    public func setCodeBlockBorderStyle(borderStyle: Int64): Unit {
        codeBlockBorderStyle = convertBorderStyle(borderStyle)
    }

    /**
     * 设置代码块边框宽度
     *
     * @param borderWidth 代码块边框宽度
     */
    public func setCodeBlockBorderWidth(borderWidth: Float64): Unit {
        codeBlockBorderWidth = borderWidth
    }

    /**
     * 设置代码块边框颜色
     *
     * @param borderColor 代码块边框颜色
     */
    public func setCodeBlockBorderColor(borderColor: UInt32): Unit {
        codeBlockBorderColor = transColorForTransparent(borderColor)
    }

    /**
     * 代码块整体圆角
     *
     * @param radius 圆角
     */
    public func setCodeBlockAllRadius(radius: Float64): Unit {
        codeBlockRadiusTopLeft = radius
        codeBlockRadiusTopRight = radius
        codeBlockRadiusBottomLeft = radius
        codeBlockRadiusBottomRight = radius
    }

    /**
     * 代码块分别设置四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     */
    public func setCodeBlockRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        codeBlockRadiusTopLeft = topLeft
        codeBlockRadiusTopRight = topRight
        codeBlockRadiusBottomLeft = bottomLeft
        codeBlockRadiusBottomRight = bottomRight
    }

    /**
     * 设置代码块类型和代码块内容间距
     *
     * @param marginBottom 代码块类型和代码块内容间距
     */
    public func setCodeBlockTitleLayoutMarginBottom(marginBottom: Float64): Unit {
        codeBlockTitleLayoutMarginBottom = marginBottom
    }

    /**
     * 设置代码块类型左边距
     *
     * @param marginLeft 代码块类型左边距
     */
    public func setCodeBlockTypeTextMarginLeft(marginLeft: Float64): Unit {
        codeBlockTypeTextMarginLeft = marginLeft
    }

    /**
     * 设置代码块没有代码类型时默认显示文本
     *
     * @param text 默认显示文本
     */
    public func setCodeBlockTypeText(text: String): Unit {
        codeBlockTypeText = text
    }

    /**
     * 设置代码块类型文本颜色
     *
     * @param color 代码块类型文本颜色
     */
    public func setCodeBlockTypeTextFontColor(color: UInt32): Unit {
        codeBlockTypeTextFontColor = transColorForTransparent(color)
    }

    /**
     * 设置代码块类型文本尺寸
     *
     * @param size 代码块类型文本尺寸
     */
    public func setCodeBlockTypeTextFontSize(size: Float64): Unit {
        codeBlockTypeTextFontSize = size
    }

    /**
     * 设置代码块类型文本字体样式
     *
     * @param style 代码块类型文本字体样式
     */
    public func setCodeBlockTypeTextFontStyle(style: Int64): Unit {
        codeBlockTypeTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置代码块类型文本字体粗细
     *
     * @param weight 代码块类型文本字体粗细
     */
    public func setCodeBlockTypeTextFontWeight(weight: Int64): Unit {
        codeBlockTypeTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置代码块类型文本字体
     *
     * @param family 代码块类型文本字体
     */
    public func setCodeBlockTypeTextFontFamily(family: String): Unit {
        codeBlockTypeTextFontFamily = family
    }

    /**
     * 设置代码块类型文本行高
     *
     * @param height 代码块类型文本行高
     */
    public func setCodeBlockTypeTextLineHeight(height: Float64): Unit {
        codeBlockTypeTextLineHeight = height
    }

    /**
     * 设置代码块代码复制和代码全屏间距
     *
     * @param spacing 代码块代码复制和代码全屏间距
     */
    public func setCodeBlockCopyFullScreenSpacing(spacing: Float64): Unit {
        codeBlockCopyFullScreenSpacing = spacing
    }

    /**
     * 设置代码块代码复制按钮是否显示
     *
     * @param isShow 是否显示
     */
    public func setCodeBlockCopyButtonIsShow(isShow: Bool): Unit {
        codeBlockCopyButtonIsShow = isShow
    }

    /**
     * 设置代码块代码复制文本是否显示
     *
     * @param isShow 是否显示
     */
    public func setCodeBlockCopyTextIsShow(isShow: Bool): Unit {
        codeBlockCopyTextIsShow = isShow
    }

    /**
     * 设置代码块代码复制图标宽度
     *
     * @param width 图标宽度
     */
    public func setCodeBlockCopyIconWidth(width: Float64): Unit {
        codeBlockCopyIconWidth = width
    }

    /**
     * 设置代码块代码复制图标高度
     *
     * @param height 图标高度
     */
    public func setCodeBlockCopyIconHeight(height: Float64): Unit {
        codeBlockCopyIconHeight = height
    }

    /**
     * 设置代码块代码复制图标和文本间距
     *
     * @param spacing 代码块代码复制图标和文本间距
     */
    public func setCodeBlockCopyIconTextSpacing(spacing: Float64): Unit {
        codeBlockCopyIconTextSpacing = spacing
    }

    /**
     * 设置代码块代码复制默认文本内容
     *
     * @param text 默认文本内容
     */
    public func setCodeBlockCopyText(text: String): Unit {
        codeBlockCopyText = text
    }

    /**
     * 设置代码块代码复制文本颜色
     *
     * @param color 代码块代码复制文本颜色
     */
    public func setCodeBlockCopyTextFontColor(color: UInt32): Unit {
        codeBlockCopyTextFontColor = transColorForTransparent(color)
    }

    /**
     * 设置代码块代码复制文本尺寸
     *
     * @param size 代码块代码复制文本尺寸
     */
    public func setCodeBlockCopyTextFontSize(size: Float64): Unit {
        codeBlockCopyTextFontSize = size
    }

    /**
     * 设置代码块代码复制文本字体样式
     *
     * @param style 代码块代码复制文本字体样式
     */
    public func setCodeBlockCopyTextFontStyle(style: Int64): Unit {
        codeBlockCopyTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置代码块代码复制文本字体粗细
     *
     * @param weight 代码块代码复制文本字体粗细
     */
    public func setCodeBlockCopyTextFontWeight(weight: Int64): Unit {
        codeBlockCopyTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置代码块代码复制文本字体
     *
     * @param family 代码块代码复制文本字体
     */
    public func setCodeBlockCopyTextFontFamily(family: String): Unit {
        codeBlockCopyTextFontFamily = family
    }

    /**
     * 设置代码块代码复制文本行高
     *
     * @param height 代码块代码复制文本行高
     */
    public func setCodeBlockCopyTextLineHeight(height: Float64): Unit {
        codeBlockCopyTextLineHeight = height
    }

    /**
     * 设置代码块代码全屏按钮是否显示
     *
     * @param isShow 是否显示
     */
    public func setCodeBlockFullScreenButtonIsShow(isShow: Bool): Unit {
        codeBlockFullScreenButtonIsShow = isShow
    }

    /**
     * 设置代码块代码全屏文本是否显示
     *
     * @param isShow 是否显示
     */
    public func setCodeBlockFullScreenTextIsShow(isShow: Bool): Unit {
        codeBlockFullScreenTextIsShow = isShow
    }

    /**
     * 设置代码块代码全屏图标宽度
     *
     * @param width 图标宽度
     */
    public func setCodeBlockFullScreenIconWidth(width: Float64): Unit {
        codeBlockFullScreenIconWidth = width
    }

    /**
     * 设置代码块代码全屏图标高度
     *
     * @param height 图标高度
     */
    public func setCodeBlockFullScreenIconHeight(height: Float64): Unit {
        codeBlockFullScreenIconHeight = height
    }

    /**
     * 设置代码块代码全屏图标和文本间距
     *
     * @param spacing 代码块代码全屏图标和文本间距
     */
    public func setCodeBlockFullScreenIconTextSpacing(spacing: Float64): Unit {
        codeBlockFullScreenIconTextSpacing = spacing
    }

    /**
     * 设置代码块代码全屏默认文本内容
     *
     * @param text 默认文本内容
     */
    public func setCodeBlockFullScreenText(text: String): Unit {
        codeBlockFullScreenText = text
    }

    /**
     * 设置代码块代码全屏文本颜色
     *
     * @param color 代码块代码全屏文本颜色
     */
    public func setCodeBlockFullScreenTextFontColor(color: UInt32): Unit {
        codeBlockFullScreenTextFontColor = transColorForTransparent(color)
    }

    /**
     * 设置代码块代码全屏文本尺寸
     *
     * @param size 代码块代码全屏文本尺寸
     */
    public func setCodeBlockFullScreenTextFontSize(size: Float64): Unit {
        codeBlockFullScreenTextFontSize = size
    }

    /**
     * 设置代码块代码全屏文本字体样式
     *
     * @param style 代码块代码全屏文本字体样式
     */
    public func setCodeBlockFullScreenTextFontStyle(style: Int64): Unit {
        codeBlockFullScreenTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置代码块代码全屏文本字体粗细
     *
     * @param weight 代码块代码全屏文本字体粗细
     */
    public func setCodeBlockFullScreenTextFontWeight(weight: Int64): Unit {
        codeBlockFullScreenTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置代码块代码全屏文本字体
     *
     * @param family 代码块代码全屏文本字体
     */
    public func setCodeBlockFullScreenTextFontFamily(family: String): Unit {
        codeBlockFullScreenTextFontFamily = family
    }

    /**
     * 设置代码块代码全屏文本行高
     *
     * @param height 代码块代码全屏文本行高
     */
    public func setCodeBlockFullScreenTextLineHeight(height: Float64): Unit {
        codeBlockFullScreenTextLineHeight = height
    }

    /**
     * 设置代码块代码行号是否显示
     *
     * @param isShow 是否显示
     */
    public func setCodeBlockLineNumberIsShow(isShow: Bool): Unit {
        codeBlockLineNumberIsShow = isShow
    }

    /**
     * 设置代码块代码行号左内边距
     *
     * @param left 代码块代码行号左内边距
     */
    public func setCodeBlockLineNumberTextPaddingLeft(left: Float64): Unit {
        codeBlockLineNumberTextPaddingLeft = left
    }

    /**
     * 设置代码块代码行号文本颜色
     *
     * @param color 代码块代码行号文本颜色
     */
    public func setCodeBlockLineNumberTextFontColor(color: UInt32): Unit {
        codeBlockLineNumberTextFontColor = transColorForTransparent(color)
    }

    /**
     * 设置代码块代码行号文本尺寸
     *
     * @param size 代码块代码行号文本尺寸
     */
    public func setCodeBlockLineNumberTextFontSize(size: Float64): Unit {
        codeBlockLineNumberTextFontSize = size
    }

    /**
     * 设置代码块代码行号文本字体样式
     *
     * @param style 代码块代码行号文本字体样式
     */
    public func setCodeBlockLineNumberTextFontStyle(style: Int64): Unit {
        codeBlockLineNumberTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置代码块代码行号文本字体粗细
     *
     * @param weight 代码块代码行号文本字体粗细
     */
    public func setCodeBlockLineNumberTextFontWeight(weight: Int64): Unit {
        codeBlockLineNumberTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置代码块代码行号文本字体
     *
     * @param family 代码块代码行号文本字体
     */
    public func setCodeBlockLineNumberTextFontFamily(family: String): Unit {
        codeBlockLineNumberTextFontFamily = family
    }

    /**
     * 设置代码块代码行号文本行高
     *
     * @param height 代码块代码行号文本行高
     */
    public func setCodeBlockLineNumberTextLineHeight(height: Float64): Unit {
        codeBlockLineNumberTextLineHeight = height
    }

    /**
     * 设置代码块代码行号和代码块中间分割线颜色
     *
     * @param color 分割线颜色
     */
    public func setCodeBlockDividerColor(color: UInt32): Unit {
        codeBlockDividerColor = transColorForTransparent(color)
    }

    /**
     * 设置代码块代码行号和代码块中间分割线宽度
     *
     * @param strokeWidth 分割线宽度
     */
    public func setCodeBlockDividerStrokeWidth(strokeWidth: Float64): Unit {
        codeBlockDividerStrokeWidth = strokeWidth
    }

    /**
     * 设置代码块代码行号和分割线间距
     *
     * @param spacing 代码块代码行号和分割线间距
     */
    public func setCodeBlockLineNumberDividerSpacing(spacing: Float64): Unit {
        codeBlockLineNumberDividerSpacing = spacing
    }

    /**
     * 设置代码块文本颜色
     *
     * @param color 代码块文本颜色
     */
    public func setCodeBlockTextFontColor(color: UInt32): Unit {
        codeBlockTextFontColor = transColorForTransparent(color)
    }

    /**
     * 设置代码块代码文本右外边距
     *
     * @param marginRight 代码块代码文本右外边距
     */
    public func setCodeBlockTextMarginRight(marginRight: Float64): Unit {
        codeBlockTextMarginRight = marginRight
    }

    /**
     * 设置代码块代码文本左外边距
     *
     * @param marginLeft 代码块代码文本左外边距
     */
    public func setCodeBlockTextMarginLeft(marginLeft: Float64): Unit {
        codeBlockTextMarginLeft = marginLeft
    }

    /**
     * 设置代码块文本尺寸
     *
     * @param size 代码块文本尺寸
     */
    public func setCodeBlockTextFontSize(size: Float64): Unit {
        codeBlockTextFontSize = size
    }

    /**
     * 设置代码块文本字体样式
     *
     * @param style 代码块文本字体样式
     */
    public func setCodeBlockTextFontStyle(style: Int64): Unit {
        codeBlockTextFontStyle = convertFontStyle(style)
    }

    /**
     * 设置代码块文本字体粗细
     *
     * @param weight 代码块文本字体粗细
     */
    public func setCodeBlockTextFontWeight(weight: Int64): Unit {
        codeBlockTextFontWeight = convertFontWeight(weight)
    }

    /**
     * 设置代码块文本字体
     *
     * @param family 代码块文本字体
     */
    public func setCodeBlockTextFontFamily(family: String): Unit {
        codeBlockTextFontFamily = family
    }

    /**
     * 设置代码块文本行高
     *
     * @param height 代码块文本行高
     */
    public func setCodeBlockTextLineHeight(height: Float64): Unit {
        codeBlockTextLineHeight = height
    }

    /**
     * 设置代码块文本字符间距
     *
     * @param spacing 代码块文本字符间距
     */
    public func setCodeBlockTextLetterSpacing(spacing: Float64): Unit {
        codeBlockTextLetterSpacing = spacing
    }

    /**
     * 设置组合代码块未选中标题字体大小
     *
     * @param size 字体大小
     */
    public func setCodeBlockListTitleTextSize(size: Float64): Unit {
        codeBlockListTitleTextSize = size
    }

    /**
     * 设置组合代码块选中标题字体大小
     *
     * @param size 字体大小
     */
    public func setCodeBlockListTitleSelectTextSize(size: Float64): Unit {
        codeBlockListTitleSelectTextSize = size
    }

    /**
     * 设置组合代码块选中标题文本颜色
     *
     * @param color 文本颜色
     */
    public func setCodeBlockListTitleSelectTextColor(color: UInt32): Unit {
        codeBlockListTitleSelectTextColor = transColorForTransparent(color)
    }

    /**
     * 设置组合代码块未选中标题文本颜色
     *
     * @param color 文本颜色
     */
    public func setCodeBlockListTitleUnselectTextColor(color: UInt32): Unit {
        codeBlockListTitleUnselectTextColor = transColorForTransparent(color)
    }

    /**
     * 设置组合代码块选中标题背景颜色
     *
     * @param color 背景颜色
     */
    public func setCodeBlockListTitleSelectBackgroundColor(color: UInt32): Unit {
        codeBlockListTitleSelectBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 设置组合代码块未选中标题背景颜色
     *
     * @param color 背景颜色
     */
    public func setCodeBlockListTitleUnselectBackgroundColor(color: UInt32): Unit {
        codeBlockListTitleUnselectBackgroundColor = transColorForTransparent(color)
    }

    /**
     * 设置是否单独代码块显示
     *
     * @param isSeparate 是否单独显示
     */
    public func setCodeBlockIsSeparate(isSeparate: Bool): Unit {
        codeBlockIsSeparate = isSeparate
    }

    /**
     * 设置单独代码块行号宽度
     *
     * @param width 行号宽度
     */
    public func setCodeBlockSeparateWidth(width: Float64): Unit {
        codeBlockSeparateWidth = width
    }

    /**
     * 设置单独代码块是否居底显示
     *
     * @param isBottom 是否居底
     */
    public func setCodeBlockSeparateIsBottom(isBottom: Bool): Unit {
        codeBlockSeparateIsBottom = isBottom
    }
}
