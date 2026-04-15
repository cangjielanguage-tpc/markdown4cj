package markdown.components.theme

/**
 * 代码块样式
 */
public class CodeBlockTheme <: MarkdownBaseTheme {
    public var codeBlockIsCodeFormat: Bool = false // 是否格式化围栏代码块内容
    public var codeBlockUseTab: Bool = false // codeformat是否用制表符
    public var codeBlockIndentWidth: Int64 = 4 // codeformat空格缩进数量
    public var codeBlockParserSync: Bool = false // 围栏代码块代码高亮是否同步解析
    public var codeBlockBackgroundColor: ?Color = None // 代码块背景颜色
    public var codeBlockMarginTop: Float64 = 0.0 // 代码块上外边距
    public var codeBlockMarginRight: Float64 = 0.0 // 代码块右外边距
    public var codeBlockMarginBottom: Float64 = 0.0 // 代码块下外边距
    public var codeBlockMarginLeft: Float64 = 0.0 // 代码块左外边距
    public var codeBlockPaddingTop: Float64 = 0.0 // 代码块上内边距
    public var codeBlockPaddingRight: Float64 = 8.0 // 代码块右内边距
    public var codeBlockPaddingBottom: Float64 = 8.0 // 代码块下内边距
    public var codeBlockPaddingLeft: Float64 = 0.0 // 代码块左内边距
    public var codeBlockBorderStyle: BorderStyle = BorderStyle.Solid // 代码块边框样式
    public var codeBlockBorderWidth: Float64 = 0.0 // 代码块边框宽度
    public var codeBlockBorderColor: Color = COLOR_TRANSPARENT // 代码块边框颜色
    public var codeBlockRadiusTopLeft: Float64 = 8.0 // 代码块边框左上圆角
    public var codeBlockRadiusTopRight: Float64 = 8.0 // 代码块边框右上圆角
    public var codeBlockRadiusBottomLeft: Float64 = 8.0 // 代码块边框左下圆角
    public var codeBlockRadiusBottomRight: Float64 = 8.0 // 代码块边框右下圆角
    public var codeBlockTitleLayoutMarginBottom: Float64 = 0.0 // 代码块类型和代码块内容间距
    public var codeBlockTypeTextMarginLeft: Float64 = 8.0 // 代码块类型左边距
    public var codeBlockTypeText: String = "" // 代码块没有代码类型时默认显示文本
    public var codeBlockTypeTextFontColor: ?Color = None // 代码块类型文本颜色
    public var codeBlockTypeTextFontSize: ?Float64 = None // 代码块类型文本尺寸
    public var codeBlockTypeTextFontStyle: ?FontStyle = None // 代码块类型文本字体样式
    public var codeBlockTypeTextFontWeight: ?FontWeight = None // 代码块类型文本字体粗细
    public var codeBlockTypeTextFontFamily: ?String = None // 代码块类型文本字体
    public var codeBlockTypeTextLineHeight: ?Float64 = None // 代码块类型文本行高
    public var codeBlockCopyFullScreenSpacing: Float64 = 5.0 // 代码块代码复制和代码全屏间距
    public var codeBlockCopyButtonIsShow: Bool = true // 代码块代码复制按钮是否显示
    public var codeBlockCopyTextIsShow: Bool = true // 代码块代码复制文本是否显示
    public var codeBlockCopyIcon: ?AppResource = None // 代码块代码复制按钮默认图标
    public var codeBlockCopyIconWidth: Float64 = 24.0 // 代码块代码复制图标宽度
    public var codeBlockCopyIconHeight: Float64 = 24.0 // 代码块代码复制图标高度
    public var codeBlockCopyIconTextSpacing: Float64 = 5.0 // 代码块代码复制图标和文本间距
    public var codeBlockCopyText: String = "复制代码" // 代码块代码复制默认文本内容
    public var codeBlockCopyTextFontColor: ?Color = None // 代码块代码复制文本颜色
    public var codeBlockCopyTextFontSize: ?Float64 = None // 代码块代码复制文本尺寸
    public var codeBlockCopyTextFontStyle: ?FontStyle = None // 代码块代码复制文本字体样式
    public var codeBlockCopyTextFontWeight: ?FontWeight = None // 代码块代码复制文本字体粗细
    public var codeBlockCopyTextFontFamily: ?String = None // 代码块代码复制文本字体
    public var codeBlockCopyTextLineHeight: ?Float64 = None // 代码块代码复制文本行高
    public var codeBlockFullScreenButtonIsShow: Bool = true // 代码块代码全屏按钮是否显示
    public var codeBlockFullScreenTextIsShow: Bool = true // 代码块代码全屏文本是否显示
    public var codeBlockFullScreenIcon: ?AppResource = None // 代码块代码全屏按钮默认图标
    public var codeBlockFullScreenIconWidth: Float64 = 24.0 // 代码块代码全屏图标宽度
    public var codeBlockFullScreenIconHeight: Float64 = 24.0 // 代码块代码全屏图标高度
    public var codeBlockFullScreenIconTextSpacing: Float64 = 5.0 // 代码块代码全屏图标和文本间距
    public var codeBlockFullScreenText: String = "全屏代码" // 代码块代码全屏默认文本内容
    public var codeBlockFullScreenTextFontColor: ?Color = None // 代码块代码全屏文本颜色
    public var codeBlockFullScreenTextFontSize: ?Float64 = None // 代码块代码全屏文本尺寸
    public var codeBlockFullScreenTextFontStyle: ?FontStyle = None // 代码块代码全屏文本字体样式
    public var codeBlockFullScreenTextFontWeight: ?FontWeight = None // 代码块代码全屏文本字体粗细
    public var codeBlockFullScreenTextFontFamily: ?String = None // 代码块代码全屏文本字体
    public var codeBlockFullScreenTextLineHeight: ?Float64 = None // 代码块代码全屏文本行高
    public var codeBlockLineNumberIsShow: Bool = true // 代码块代码行号是否显示
    public var codeBlockLineNumberTextPaddingLeft: Float64 = 8.0 // 代码块代码行号左内边距
    public var codeBlockLineNumberTextFontColor: ?Color = None // 代码块代码行号文本颜色
    public var codeBlockLineNumberTextFontSize: ?Float64 = None // 代码块代码行号文本尺寸
    public var codeBlockLineNumberTextFontStyle: ?FontStyle = None // 代码块代码行号文本字体样式
    public var codeBlockLineNumberTextFontWeight: ?FontWeight = None // 代码块代码行号文本字体粗细
    public var codeBlockLineNumberTextFontFamily: ?String = None // 代码块代码行号文本字体
    public var codeBlockLineNumberTextLineHeight: ?Float64 = None // 代码块代码行号文本行高
    public var codeBlockDividerColor: ?Color = None // 代码块代码行号和代码块中间分割线颜色
    public var codeBlockDividerStrokeWidth: Float64 = 0.5 // 代码块代码行号和代码块中间分割线宽度
    public var codeBlockLineNumberDividerSpacing: Float64 = 8.0 // 代码块代码行号和分割线间距
    public var codeBlockTextMarginRight: Float64 = 8.0 // 代码块代码文本右外边距
    public var codeBlockTextMarginLeft: Float64 = 8.0 // 代码块代码文本左外边距
    public var codeBlockTextFontColor: ?Color = None // 代码块代码文本颜色
    public var codeBlockTextFontSize: Float64 = 13.0 // 代码块代码文本尺寸
    public var codeBlockTextFontStyle: FontStyle = FontStyle.Normal // 代码块代码文本字体样式
    public var codeBlockTextFontWeight: FontWeight = FontWeight.W400 // 代码块代码文本字体粗细
    public var codeBlockTextFontFamily: String = "HarmonyOS Sans" // 代码块代码文本字体
    public var codeBlockTextLineHeight: Float64 = 22.0 // 代码块代码文本行高
    public var codeBlockTextLetterSpacing: Float64 = 0.0 // 代码块代码文本字符间距
    public var codeBlockListTitleTextSize: Float64 = 13.0 // 组合代码块未选中标题字体大小
    public var codeBlockListTitleSelectTextSize: Float64 = 13.0 // 组合代码块选中标题字体大小
    public var codeBlockListTitleSelectTextColor: Color = COLOR_RED // 组合代码块选中标题文本颜色
    public var codeBlockListTitleUnSelectTextColor: Color = COLOR_BLACK // 组合代码块未选中标题文本颜色
    public var codeBlockListTitleSelectBackgroupColor: Color = COLOR_GRAY // 组合代码块选中标题背景颜色
    public var codeBlockListTitleUnSelectBackgroupColor: Color = COLOR_TRANSPARENT // 组合代码块未选中标题背景颜色
    public var codeBlockIsSeparate: Bool = false // 是否单独代码块显示
    public var codeBlockSeparateWidth: Float64 = 50.0 // 单独代码块行号宽度
    public var codeBlockSeparateIsBottom: Bool = false // 单独代码块是否居底显示

    /**
     * 设置是否格式化围栏代码块内容
     *
     * @param isCodeFormat 是否格式化围栏代码块内容
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockIsCodeFormat(isCodeFormat: Bool): CodeBlockTheme {
        this.codeBlockIsCodeFormat = isCodeFormat
        return this
    }

    /**
     * 设置codeformat是否用制表符
     *
     * @param useTab 是否用制表符
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockUseTab(useTab: Bool): CodeBlockTheme {
        this.codeBlockUseTab = useTab
        return this
    }

    /**
     * 设置codeformat空格缩进数量
     *
     * @param indentWidth 空格缩进数量
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockIndentWidth(indentWidth: Int64): CodeBlockTheme {
        this.codeBlockIndentWidth = indentWidth
        return this
    }

    /**
     * 设置围栏代码块代码高亮是否同步解析
     *
     * @param parserSync 是否同步解析
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockParserSync(parserSync: Bool): CodeBlockTheme {
        this.codeBlockParserSync = parserSync
        return this
    }

    /**
     * 设置代码块背景颜色
     *
     * @param color 代码块背景颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockBackgroundColor(color: Color): CodeBlockTheme {
        this.codeBlockBackgroundColor = color
        return this
    }

    /**
     * 代码块整体外边距
     *
     * @param margin 外边距
     * @return 当前CodeBlockTheme对象
     */
    public func setMargin(margin: Float64): CodeBlockTheme {
        this.codeBlockMarginTop = margin
        this.codeBlockMarginRight = margin
        this.codeBlockMarginBottom = margin
        this.codeBlockMarginLeft = margin
        return this
    }

    /**
     * 代码块分别设置四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前CodeBlockTheme对象
     */
    public func setMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): CodeBlockTheme {
        this.codeBlockMarginTop = top
        this.codeBlockMarginRight = right
        this.codeBlockMarginBottom = bottom
        this.codeBlockMarginLeft = left
        return this
    }

    /**
     * 代码块整体内边距
     *
     * @param padding 内边距
     * @return 当前CodeBlockTheme对象
     */
    public func setPadding(padding: Float64): CodeBlockTheme {
        this.codeBlockPaddingTop = padding
        this.codeBlockPaddingRight = padding
        this.codeBlockPaddingBottom = padding
        this.codeBlockPaddingLeft = padding
        return this
    }

    /**
     * 代码块分别设置四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前CodeBlockTheme对象
     */
    public func setPadding(top!: Float64 = 0.0, right!: Float64 = 8.0, bottom!: Float64 = 8.0, left!: Float64 = 0.0): CodeBlockTheme {
        this.codeBlockPaddingTop = top
        this.codeBlockPaddingRight = right
        this.codeBlockPaddingBottom = bottom
        this.codeBlockPaddingLeft = left
        return this
    }

    /**
     * 设置代码块边框样式
     *
     * @param borderStyle 代码块边框样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockBorderStyle(borderStyle: BorderStyle): CodeBlockTheme {
        this.codeBlockBorderStyle = borderStyle
        return this
    }

    /**
     * 设置代码块边框宽度
     *
     * @param borderWidth 代码块边框宽度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockBorderWidth(borderWidth: Float64): CodeBlockTheme {
        this.codeBlockBorderWidth = borderWidth
        return this
    }

    /**
     * 设置代码块边框颜色
     *
     * @param borderColor 代码块边框颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockBorderColor(borderColor: Color): CodeBlockTheme {
        this.codeBlockBorderColor = borderColor
        return this
    }

    /**
     * 代码块整体圆角
     *
     * @param radius 圆角
     * @return 当前CodeBlockTheme对象
     */
    public func setRadius(radius: Float64): CodeBlockTheme {
        this.codeBlockRadiusTopLeft = radius
        this.codeBlockRadiusTopRight = radius
        this.codeBlockRadiusBottomLeft = radius
        this.codeBlockRadiusBottomRight = radius
        return this
    }

    /**
     * 代码块分别设置四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前CodeBlockTheme对象
     */
    public func setRadius(topLeft!: Float64 = 8.0, topRight!: Float64 = 8.0, bottomLeft!: Float64 = 8.0, bottomRight!: Float64 = 8.0): CodeBlockTheme {
        this.codeBlockRadiusTopLeft = topLeft
        this.codeBlockRadiusTopRight = topRight
        this.codeBlockRadiusBottomLeft = bottomLeft
        this.codeBlockRadiusBottomRight = bottomRight
        return this
    }

    /**
     * 设置代码块类型和代码块内容间距
     *
     * @param marginBottom 代码块类型和代码块内容间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTitleLayoutMarginBottom(marginBottom: Float64): CodeBlockTheme {
        this.codeBlockTitleLayoutMarginBottom = marginBottom
        return this
    }

    /**
     * 设置代码块类型左边距
     *
     * @param marginLeft 代码块类型左边距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextMarginLeft(marginLeft: Float64): CodeBlockTheme {
        this.codeBlockTypeTextMarginLeft = marginLeft
        return this
    }

    /**
     * 设置代码块没有代码类型时默认显示文本
     *
     * @param text 默认显示文本
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeText(text: String): CodeBlockTheme {
        this.codeBlockTypeText = text
        return this
    }

    /**
     * 设置代码块类型文本颜色
     *
     * @param color 代码块类型文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextFontColor(color: Color): CodeBlockTheme {
        this.codeBlockTypeTextFontColor = color
        return this
    }

    /**
     * 设置代码块类型文本尺寸
     *
     * @param size 代码块类型文本尺寸
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextFontSize(size: Float64): CodeBlockTheme {
        this.codeBlockTypeTextFontSize = size
        return this
    }

    /**
     * 设置代码块类型文本字体样式
     *
     * @param style 代码块类型文本字体样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextFontStyle(style: FontStyle): CodeBlockTheme {
        this.codeBlockTypeTextFontStyle = style
        return this
    }

    /**
     * 设置代码块类型文本字体粗细
     *
     * @param weight 代码块类型文本字体粗细
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextFontWeight(weight: FontWeight): CodeBlockTheme {
        this.codeBlockTypeTextFontWeight = weight
        return this
    }

    /**
     * 设置代码块类型文本字体
     *
     * @param family 代码块类型文本字体
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextFontFamily(family: String): CodeBlockTheme {
        this.codeBlockTypeTextFontFamily = family
        return this
    }

    /**
     * 设置代码块类型文本行高
     *
     * @param height 代码块类型文本行高
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextLineHeight(height: Float64): CodeBlockTheme {
        this.codeBlockTypeTextLineHeight = height
        return this
    }

    /**
     * 设置代码块代码复制和代码全屏间距
     *
     * @param spacing 代码块代码复制和代码全屏间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyFullScreenSpacing(spacing: Float64): CodeBlockTheme {
        this.codeBlockCopyFullScreenSpacing = spacing
        return this
    }

    /**
     * 设置代码块代码复制按钮是否显示
     *
     * @param isShow 是否显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyButtonIsShow(isShow: Bool): CodeBlockTheme {
        this.codeBlockCopyButtonIsShow = isShow
        return this
    }

    /**
     * 设置代码块代码复制文本是否显示
     *
     * @param isShow 是否显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextIsShow(isShow: Bool): CodeBlockTheme {
        this.codeBlockCopyTextIsShow = isShow
        return this
    }

    /**
     * 设置代码块代码复制按钮默认图标
     *
     * @param icon 默认图标
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyIcon(icon: AppResource): CodeBlockTheme {
        this.codeBlockCopyIcon = icon
        return this
    }

    /**
     * 设置代码块代码复制图标宽度
     *
     * @param width 图标宽度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyIconWidth(width: Float64): CodeBlockTheme {
        this.codeBlockCopyIconWidth = width
        return this
    }

    /**
     * 设置代码块代码复制图标高度
     *
     * @param height 图标高度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyIconHeight(height: Float64): CodeBlockTheme {
        this.codeBlockCopyIconHeight = height
        return this
    }

    /**
     * 设置代码块代码复制图标和文本间距
     *
     * @param spacing 代码块代码复制图标和文本间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyIconTextSpacing(spacing: Float64): CodeBlockTheme {
        this.codeBlockCopyIconTextSpacing = spacing
        return this
    }

    /**
     * 设置代码块代码复制默认文本内容
     *
     * @param text 默认文本内容
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyText(text: String): CodeBlockTheme {
        this.codeBlockCopyText = text
        return this
    }

    /**
     * 设置代码块代码复制文本颜色
     *
     * @param color 代码块代码复制文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextFontColor(color: Color): CodeBlockTheme {
        this.codeBlockCopyTextFontColor = color
        return this
    }

    /**
     * 设置代码块代码复制文本尺寸
     *
     * @param size 代码块代码复制文本尺寸
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextFontSize(size: Float64): CodeBlockTheme {
        this.codeBlockCopyTextFontSize = size
        return this
    }

    /**
     * 设置代码块代码复制文本字体样式
     *
     * @param style 代码块代码复制文本字体样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextFontStyle(style: FontStyle): CodeBlockTheme {
        this.codeBlockCopyTextFontStyle = style
        return this
    }

    /**
     * 设置代码块代码复制文本字体粗细
     *
     * @param weight 代码块代码复制文本字体粗细
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextFontWeight(weight: FontWeight): CodeBlockTheme {
        this.codeBlockCopyTextFontWeight = weight
        return this
    }

    /**
     * 设置代码块代码复制文本字体
     *
     * @param family 代码块代码复制文本字体
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextFontFamily(family: String): CodeBlockTheme {
        this.codeBlockCopyTextFontFamily = family
        return this
    }

    /**
     * 设置代码块代码复制文本行高
     *
     * @param height 代码块代码复制文本行高
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextLineHeight(height: Float64): CodeBlockTheme {
        this.codeBlockCopyTextLineHeight = height
        return this
    }

    /**
     * 设置代码块代码全屏按钮是否显示
     *
     * @param isShow 是否显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenButtonIsShow(isShow: Bool): CodeBlockTheme {
        this.codeBlockFullScreenButtonIsShow = isShow
        return this
    }

    /**
     * 设置代码块代码全屏文本是否显示
     *
     * @param isShow 是否显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextIsShow(isShow: Bool): CodeBlockTheme {
        this.codeBlockFullScreenTextIsShow = isShow
        return this
    }

    /**
     * 设置代码块代码全屏按钮默认图标
     *
     * @param icon 默认图标
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenIcon(icon: AppResource): CodeBlockTheme {
        this.codeBlockFullScreenIcon = icon
        return this
    }

    /**
     * 设置代码块代码全屏图标宽度
     *
     * @param width 图标宽度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenIconWidth(width: Float64): CodeBlockTheme {
        this.codeBlockFullScreenIconWidth = width
        return this
    }

    /**
     * 设置代码块代码全屏图标高度
     *
     * @param height 图标高度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenIconHeight(height: Float64): CodeBlockTheme {
        this.codeBlockFullScreenIconHeight = height
        return this
    }

    /**
     * 设置代码块代码全屏图标和文本间距
     *
     * @param spacing 代码块代码全屏图标和文本间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenIconTextSpacing(spacing: Float64): CodeBlockTheme {
        this.codeBlockFullScreenIconTextSpacing = spacing
        return this
    }

    /**
     * 设置代码块代码全屏默认文本内容
     *
     * @param text 默认文本内容
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenText(text: String): CodeBlockTheme {
        this.codeBlockFullScreenText = text
        return this
    }

    /**
     * 设置代码块代码全屏文本颜色
     *
     * @param color 代码块代码全屏文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextFontColor(color: Color): CodeBlockTheme {
        this.codeBlockFullScreenTextFontColor = color
        return this
    }

    /**
     * 设置代码块代码全屏文本尺寸
     *
     * @param size 代码块代码全屏文本尺寸
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextFontSize(size: Float64): CodeBlockTheme {
        this.codeBlockFullScreenTextFontSize = size
        return this
    }

    /**
     * 设置代码块代码全屏文本字体样式
     *
     * @param style 代码块代码全屏文本字体样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextFontStyle(style: FontStyle): CodeBlockTheme {
        this.codeBlockFullScreenTextFontStyle = style
        return this
    }

    /**
     * 设置代码块代码全屏文本字体粗细
     *
     * @param weight 代码块代码全屏文本字体粗细
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextFontWeight(weight: FontWeight): CodeBlockTheme {
        this.codeBlockFullScreenTextFontWeight = weight
        return this
    }

    /**
     * 设置代码块代码全屏文本字体
     *
     * @param family 代码块代码全屏文本字体
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextFontFamily(family: String): CodeBlockTheme {
        this.codeBlockFullScreenTextFontFamily = family
        return this
    }

    /**
     * 设置代码块代码全屏文本行高
     *
     * @param height 代码块代码全屏文本行高
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextLineHeight(height: Float64): CodeBlockTheme {
        this.codeBlockFullScreenTextLineHeight = height
        return this
    }

    /**
     * 设置代码块代码行号是否显示
     *
     * @param isShow 是否显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberIsShow(isShow: Bool): CodeBlockTheme {
        this.codeBlockLineNumberIsShow = isShow
        return this
    }

    /**
     * 设置代码块代码行号左内边距
     *
     * @param left 代码块代码行号左内边距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextPaddingLeft(left: Float64): CodeBlockTheme {
        this.codeBlockLineNumberTextPaddingLeft = left
        return this
    }

    /**
     * 设置代码块代码行号文本颜色
     *
     * @param color 代码块代码行号文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextFontColor(color: Color): CodeBlockTheme {
        this.codeBlockLineNumberTextFontColor = color
        return this
    }

    /**
     * 设置代码块代码行号文本尺寸
     *
     * @param size 代码块代码行号文本尺寸
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextFontSize(size: Float64): CodeBlockTheme {
        this.codeBlockLineNumberTextFontSize = size
        return this
    }

    /**
     * 设置代码块代码行号文本字体样式
     *
     * @param style 代码块代码行号文本字体样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextFontStyle(style: FontStyle): CodeBlockTheme {
        this.codeBlockLineNumberTextFontStyle = style
        return this
    }

    /**
     * 设置代码块代码行号文本字体粗细
     *
     * @param weight 代码块代码行号文本字体粗细
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextFontWeight(weight: FontWeight): CodeBlockTheme {
        this.codeBlockLineNumberTextFontWeight = weight
        return this
    }

    /**
     * 设置代码块代码行号文本字体
     *
     * @param family 代码块代码行号文本字体
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextFontFamily(family: String): CodeBlockTheme {
        this.codeBlockLineNumberTextFontFamily = family
        return this
    }

    /**
     * 设置代码块代码行号文本行高
     *
     * @param height 代码块代码行号文本行高
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextLineHeight(height: Float64): CodeBlockTheme {
        this.codeBlockLineNumberTextLineHeight = height
        return this
    }

    /**
     * 设置代码块代码行号和代码块中间分割线颜色
     *
     * @param color 分割线颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockDividerColor(color: Color): CodeBlockTheme {
        this.codeBlockDividerColor = color
        return this
    }

    /**
     * 设置代码块代码行号和代码块中间分割线宽度
     *
     * @param strokeWidth 分割线宽度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockDividerStrokeWidth(strokeWidth: Float64): CodeBlockTheme {
        this.codeBlockDividerStrokeWidth = strokeWidth
        return this
    }

    /**
     * 设置代码块代码行号和分割线间距
     *
     * @param spacing 代码块代码行号和分割线间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberDividerSpacing(spacing: Float64): CodeBlockTheme {
        this.codeBlockLineNumberDividerSpacing = spacing
        return this
    }

    /**
     * 设置代码块代码文本右外边距
     *
     * @param marginRight 代码块代码文本右外边距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextMarginRight(marginRight: Float64): CodeBlockTheme {
        this.codeBlockTextMarginRight = marginRight
        return this
    }

    /**
     * 设置代码块代码文本左外边距
     *
     * @param marginLeft 代码块代码文本左外边距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextMarginLeft(marginLeft: Float64): CodeBlockTheme {
        this.codeBlockTextMarginLeft = marginLeft
        return this
    }

    /**
     * 设置代码块代码文本颜色
     *
     * @param color 代码块代码文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextFontColor(color: Color): CodeBlockTheme {
        this.codeBlockTextFontColor = color
        return this
    }

    /**
     * 设置代码块代码文本尺寸
     *
     * @param size 代码块代码文本尺寸
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextFontSize(size: Float64): CodeBlockTheme {
        this.codeBlockTextFontSize = size
        return this
    }

    /**
     * 设置代码块代码文本字体样式
     *
     * @param style 代码块代码文本字体样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextFontStyle(style: FontStyle): CodeBlockTheme {
        this.codeBlockTextFontStyle = style
        return this
    }

    /**
     * 设置代码块代码文本字体粗细
     *
     * @param weight 代码块代码文本字体粗细
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextFontWeight(weight: FontWeight): CodeBlockTheme {
        this.codeBlockTextFontWeight = weight
        return this
    }

    /**
     * 设置代码块代码文本字体
     *
     * @param family 代码块代码文本字体
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextFontFamily(family: String): CodeBlockTheme {
        this.codeBlockTextFontFamily = family
        return this
    }

    /**
     * 设置代码块代码文本行高
     *
     * @param height 代码块代码文本行高
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextLineHeight(height: Float64): CodeBlockTheme {
        this.codeBlockTextLineHeight = height
        return this
    }

    /**
     * 设置代码块代码文本字符间距
     *
     * @param spacing 代码块代码文本字符间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextLetterSpacing(spacing: Float64): CodeBlockTheme {
        this.codeBlockTextLetterSpacing = spacing
        return this
    }

    /**
     * 设置组合代码块未选中标题字体大小
     *
     * @param size 字体大小
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleTextSize(size: Float64): CodeBlockTheme {
        this.codeBlockListTitleTextSize = size
        return this
    }

    /**
     * 设置组合代码块选中标题字体大小
     *
     * @param size 字体大小
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleSelectTextSize(size: Float64): CodeBlockTheme {
        this.codeBlockListTitleSelectTextSize = size
        return this
    }

    /**
     * 设置组合代码块选中标题文本颜色
     *
     * @param color 文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleSelectTextColor(color: Color): CodeBlockTheme {
        this.codeBlockListTitleSelectTextColor = color
        return this
    }

    /**
     * 设置组合代码块未选中标题文本颜色
     *
     * @param color 文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleUnSelectTextColor(color: Color): CodeBlockTheme {
        this.codeBlockListTitleUnSelectTextColor = color
        return this
    }

    /**
     * 设置组合代码块选中标题背景颜色
     *
     * @param color 背景颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleSelectBackgroupColor(color: Color): CodeBlockTheme {
        this.codeBlockListTitleSelectBackgroupColor = color
        return this
    }

    /**
     * 设置组合代码块未选中标题背景颜色
     *
     * @param color 背景颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleUnSelectBackgroupColor(color: Color): CodeBlockTheme {
        this.codeBlockListTitleUnSelectBackgroupColor = color
        return this
    }

    /**
     * 设置是否单独代码块显示
     *
     * @param isSeparate 是否单独显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockIsSeparate(isSeparate: Bool): CodeBlockTheme {
        this.codeBlockIsSeparate = isSeparate
        return this
    }

    /**
     * 设置单独代码块行号宽度
     *
     * @param width 行号宽度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockSeparateWidth(width: Float64): CodeBlockTheme {
        this.codeBlockSeparateWidth = width
        return this
    }

    /**
     * 设置单独代码块是否居底显示
     *
     * @param isBottom 是否居底
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockSeparateIsBottom(isBottom: Bool): CodeBlockTheme {
        this.codeBlockSeparateIsBottom = isBottom
        return this
    }
}