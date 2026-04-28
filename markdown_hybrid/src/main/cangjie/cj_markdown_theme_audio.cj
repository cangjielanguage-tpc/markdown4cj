package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownAudioTheme {
    /**
     * 音频背景颜色
     */
    var audioBackgroundColor: ?Color = None
    /**
     * 音频上外边距
     */
    var audioMarginTop: ?Float64 = None
    /**
     * 音频右外边距
     */
    var audioMarginRight: ?Float64 = None
    /**
     * 音频下外边距
     */
    var audioMarginBottom: ?Float64 = None
    /**
     * 音频左外边距
     */
    var audioMarginLeft: ?Float64 = None
    /**
     * 音频上内边距
     */
    var audioPaddingTop: ?Float64 = None
    /**
     * 音频右内边距
     */
    var audioPaddingRight: ?Float64 = None
    /**
     * 音频下内边距
     */
    var audioPaddingBottom: ?Float64 = None
    /**
     * 音频左内边距
     */
    var audioPaddingLeft: ?Float64 = None
    /**
     * 音频边框样式
     */
    var audioBorderStyle: ?BorderStyle = None
    /**
     * 音频边框宽度
     */
    var audioBorderWidth: ?Float64 = None
    /**
     * 音频边框颜色
     */
    var audioBorderColor: ?Color = None
    /**
     * 音频边框左上圆角
     */
    var audioRadiusTopLeft: ?Float64 = None
    /**
     * 音频边框右上圆角
     */
    var audioRadiusTopRight: ?Float64 = None
    /**
     * 音频边框左下圆角
     */
    var audioRadiusBottomLeft: ?Float64 = None
    /**
     * 音频边框右下圆角
     */
    var audioRadiusBottomRight: ?Float64 = None
    /**
     * 音频阴影颜色值
     */
    var audioShadowColor: ?Color = None
    /**
     * 音频阴影模糊半径
     */
    var audioShadowRadius: ?Float64 = None
    /**
     * 音频阴影X轴偏移量
     */
    var audioShadowOffsetX: ?Float64 = None
    /**
     * 音频阴影Y轴偏移量
     */
    var audioShadowOffsetY: ?Float64 = None
    /**
     * 音频图标宽度
     */
    var audioIconWidth: ?Float64 = None
    /**
     * 音频图标高度
     */
    var audioIconHeight: ?Float64 = None
    /**
     * 音频图标左上圆角
     */
    var audioIconRadiusTopLeft: ?Float64 = None
    /**
     * 音频图标右上圆角
     */
    var audioIconRadiusTopRight: ?Float64 = None
    /**
     * 音频图标左下圆角
     */
    var audioIconRadiusBottomLeft: ?Float64 = None
    /**
     * 音频图标右下圆角
     */
    var audioIconRadiusBottomRight: ?Float64 = None
    /**
     * 音频图标缩放类型
     */
    var audioIconFitType: ?ImageFit = Option<ImageFit>.None
    /**
     * 音频标题文本和类型文本间距
     */
    var audioTitleToTypeSpacing: ?Float64 = None
    /**
     * 音频按钮宽度
     */
    var audioButtonWidth: ?Float64 = None
    /**
     * 音频按钮高度
     */
    var audioButtonHeight: ?Float64 = None
    /**
     * 音频按钮背景颜色
     */
    var audioButtonBackgroundColor: ?Color = None
    /**
     * 音频按钮边框样式
     */
    var audioButtonBorderStyle: ?BorderStyle = None
    /**
     * 音频按钮边框宽度
     */
    var audioButtonBorderWidth: ?Float64 = None
    /**
     * 音频按钮边框颜色
     */
    var audioButtonBorderColor: ?Color = None
    /**
     * 音频按钮边框左上圆角
     */
    var audioButtonRadiusTopLeft: ?Float64 = None
    /**
     * 音频按钮边框右上圆角
     */
    var audioButtonRadiusTopRight: ?Float64 = None
    /**
     * 音频按钮边框左下圆角
     */
    var audioButtonRadiusBottomLeft: ?Float64 = None
    /**
     * 音频按钮边框右下圆角
     */
    var audioButtonRadiusBottomRight: ?Float64 = None
    /**
     * 音频按钮默认文本内容
     */
    var audioButtonText: ?String = None
    /**
     * 音频按钮文本颜色
     */
    var audioButtonTextFontColor: ?Color = None
    /**
     * 音频按钮文本尺寸
     */
    var audioButtonTextFontSize: ?Float64 = None
    /**
     * 音频按钮文本字体样式
     */
    var audioButtonTextFontStyle: ?FontStyle = None
    /**
     * 音频按钮文本字体粗细
     */
    var audioButtonTextFontWeight: ?FontWeight = None
    /**
     * 音频按钮文本字体
     */
    var audioButtonTextFontFamily: ?String = None
    /**
     * 音频按钮文本行高
     */
    var audioButtonTextLineHeight: ?Float64 = None
    /**
     * 音频标题文本颜色
     */
    var audioTitleTextFontColor: ?Color = None
    /**
     * 音频标题文本尺寸
     */
    var audioTitleTextFontSize: ?Float64 = None
    /**
     * 音频标题文本字体样式
     */
    var audioTitleTextFontStyle: ?FontStyle = None
    /**
     * 音频标题文本字体粗细
     */
    var audioTitleTextFontWeight: ?FontWeight = None
    /**
     * 音频标题文本字体
     */
    var audioTitleTextFontFamily: ?String = None
    /**
     * 音频标题文本行高
     */
    var audioTitleTextLineHeight: ?Float64 = None
    /**
     * 音频类型文本颜色
     */
    var audioTypeTextFontColor: ?Color = None
    /**
     * 音频类型文本尺寸
     */
    var audioTypeTextFontSize: ?Float64 = None
    /**
     * 音频类型文本字体样式
     */
    var audioTypeTextFontStyle: ?FontStyle = None
    /**
     * 音频类型文本字体粗细
     */
    var audioTypeTextFontWeight: ?FontWeight = None
    /**
     * 音频类型文本字体
     */
    var audioTypeTextFontFamily: ?String = None
    /**
     * 音频类型文本行高
     */
    var audioTypeTextLineHeight: ?Float64 = None

    public init() {}

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setAudioAllMargin(margin: Float64): Unit {
        audioMarginTop = margin
        audioMarginRight = margin
        audioMarginBottom = margin
        audioMarginLeft = margin
    }
    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setAudioMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        audioMarginTop = top
        audioMarginRight = right
        audioMarginBottom = bottom
        audioMarginLeft = left
    }
    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setAudioAllPadding(padding: Float64): Unit {
        audioPaddingTop = padding
        audioPaddingRight = padding
        audioPaddingBottom = padding
        audioPaddingLeft = padding
    }
    /**
     * 分别设置4个内边距  separately
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setAudioPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        audioPaddingTop = top
        audioPaddingRight = right
        audioPaddingBottom = bottom
        audioPaddingLeft = left
    }
    /**
     * 设置音频背景颜色
     *
     * @param color 音频背景颜色
     */
    public func setAudioBackgroundColor(color: UInt32): Unit {
        audioBackgroundColor = transColorForTrasparent(color)
    }
    /**
     * 设置音频边框样式
     *
     * @param style 边框样式
     */
    public func setAudioBorderStyle(style: Int64): Unit {
        audioBorderStyle = convertBorderStyle(style)
    }
    /**
     * 设置音频边框宽度
     *
     * @param width 边框宽度
     */
    public func setAudioBorderWidth(width: Float64): Unit {
        audioBorderWidth = width
    }
    /**
     * 设置音频边框颜色
     *
     * @param color 边框颜色
     */
    public func setAudioBorderColor(color: UInt32): Unit {
        audioBorderColor = transColorForTrasparent(color)
    }
    /**
     * 设置音频边框4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setAudioBorderAllRadius(radius: Float64): Unit {
        audioRadiusTopLeft = radius
        audioRadiusTopRight = radius
        audioRadiusBottomLeft = radius
        audioRadiusBottomRight = radius
    }
    /**
     * 分别设置音频边框4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setAudioBorderRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        audioRadiusTopLeft = topLeft
        audioRadiusTopRight = topRight
        audioRadiusBottomLeft = bottomLeft
        audioRadiusBottomRight = bottomRight
    }
    /**
     * 设置音频阴影颜色
     *
     * @param color 阴影颜色
     */
    public func setAudioShadowColor(color: UInt32): Unit {
        audioShadowColor = transColorForTrasparent(color)
    }
    /**
     * 设置音频阴影模糊半径
     *
     * @param radius 阴影模糊半径
     */
    public func setAudioShadowRadius(radius: Float64): Unit {
        audioShadowRadius = radius
    }
    /**
     * 设置音频阴影X轴偏移量
     *
     * @param offsetX 阴影X轴偏移量
     */
    public func setAudioShadowOffsetX(offsetX: Float64): Unit {
        audioShadowOffsetX = offsetX
    }
    /**
     * 设置音频阴影Y轴偏移量
     *
     * @param offsetY 阴影Y轴偏移量
     */
    public func setAudioShadowOffsetY(offsetY: Float64): Unit {
        audioShadowOffsetY = offsetY
    }
    /**
     * 设置音频图标宽度
     *
     * @param width 图标宽度
     */
    public func setAudioIconWidth(width: Float64): Unit {
        audioIconWidth = width
    }
    /**
     * 设置音频图标高度
     *
     * @param height 图标高度
     */
    public func setAudioIconHeight(height: Float64): Unit {
        audioIconHeight = height
    }
    /**
     * 统一设置音频图标4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setAudioIconAllRadius(radius: Float64): Unit {
        audioIconRadiusTopLeft = radius
        audioIconRadiusTopRight = radius
        audioIconRadiusBottomLeft = radius
        audioIconRadiusBottomRight = radius
    }
    /**
     * 分别设置音频图标4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setAudioIconRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        audioIconRadiusTopLeft = topLeft
        audioIconRadiusTopRight = topRight
        audioIconRadiusBottomLeft = bottomLeft
        audioIconRadiusBottomRight = bottomRight
    }
    /**
     * 设置音频图标缩放类型
     *
     * @param fitType 图标缩放类型
     */
    public func setAudioIconFitType(fitType: Int64): Unit {
        audioIconFitType = match (fitType) {
            case 0 => ImageFit.Contain
            case 1 => ImageFit.Cover
            case 2 => ImageFit.Fill
            case _ => ImageFit.Cover
        }
    }
    /**
     * 设置音频标题文本和类型文本间距
     *
     * @param spacing 间距
     */
    public func setAudioTitleToTypeSpacing(spacing: Float64): Unit {
        audioTitleToTypeSpacing = spacing
    }
    /**
     * 设置音频按钮宽度
     *
     * @param width 按钮宽度
     */
    public func setAudioButtonWidth(width: Float64): Unit {
        audioButtonWidth = width
    }
    /**
     * 设置音频按钮高度
     *
     * @param height 按钮高度
     */
    public func setAudioButtonHeight(height: Float64): Unit {
        audioButtonHeight = height
    }
    /**
     * 设置音频按钮背景颜色
     *
     * @param color 按钮背景颜色
     */
    public func setAudioButtonBackgroundColor(color: UInt32): Unit {
        audioButtonBackgroundColor = transColorForTrasparent(color)
    }
    /**
     * 设置音频按钮边框样式
     *
     * @param style 按钮边框样式
     */
    public func setAudioButtonBorderStyle(style: Int64): Unit {
        audioButtonBorderStyle = convertBorderStyle(style)
    }
    /**
     * 设置音频按钮边框宽度
     *
     * @param width 按钮边框宽度
     */
    public func setAudioButtonBorderWidth(width: Float64): Unit {
        audioButtonBorderWidth = width
    }
    /**
     * 设置音频按钮边框颜色
     *
     * @param color 按钮边框颜色
     */
    public func setAudioButtonBorderColor(color: UInt32): Unit {
        audioButtonBorderColor = transColorForTrasparent(color)
    }
    /**
     * 设置音频按钮4个圆角为统一值
     *
     * @param radius 圆角
     */
    public func setAudioButtonAllRadius(radius: Float64): Unit {
        audioButtonRadiusTopLeft = radius
        audioButtonRadiusTopRight = radius
        audioButtonRadiusBottomLeft = radius
        audioButtonRadiusBottomRight = radius
    }
    /**
     * 分别设置音频按钮4个圆角
     *
     * @param topLeft-左上圆角 命名参数
     * @param topRight-右上圆角 命名参数
     * @param bottomLeft-左下圆角 命名参数
     * @param bottomRight-右下圆角 命名参数
     */
    public func setAudioButtonRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): Unit {
        audioButtonRadiusTopLeft = topLeft
        audioButtonRadiusTopRight = topRight
        audioButtonRadiusBottomLeft = bottomLeft
        audioButtonRadiusBottomRight = bottomRight
    }
    /**
     * 设置音频按钮文本内容
     *
     * @param text 按钮文本内容
     */
    public func setAudioButtonText(text: String): Unit {
        audioButtonText = text
    }
    /**
     * 设置音频按钮文本颜色
     *
     * @param color 按钮文本颜色
     */
    public func setAudioButtonTextFontColor(color: UInt32): Unit {
        audioButtonTextFontColor = transColorForTrasparent(color)
    }
    /**
     * 设置音频按钮文本尺寸
     *
     * @param size 按钮文本尺寸
     */
    public func setAudioButtonTextFontSize(size: Float64): Unit {
        audioButtonTextFontSize = size
    }
    /**
     * 设置音频按钮文本字体样式
     *
     * @param style 按钮文本字体样式
     */
    public func setAudioButtonTextFontStyle(style: Int64): Unit {
        audioButtonTextFontStyle = convertFontStyle(style)
    }
    /**
     * 设置音频按钮文本字体粗细
     *
     * @param weight 按钮文本字体粗细
     */
    public func setAudioButtonTextFontWeight(weight: String): Unit {
        audioButtonTextFontWeight = convertFontWeight(weight)
    }
    /**
     * 设置音频按钮文本字体
     *
     * @param family 按钮文本字体
     */
    public func setAudioButtonTextFontFamily(family: String): Unit {
        audioButtonTextFontFamily = family
    }
    /**
     * 设置音频按钮文本行高
     *
     * @param lineHeight 按钮文本行高
     */
    public func setAudioButtonTextLineHeight(lineHeight: Float64): Unit {
        audioButtonTextLineHeight = lineHeight
    }
    /**
     * 设置音频标题文本颜色
     *
     * @param color 标题文本颜色
     */
    public func setAudioTitleTextFontColor(color: UInt32): Unit {
        audioTitleTextFontColor = transColorForTrasparent(color)
    }
    /**
     * 设置音频标题文本尺寸
     *
     * @param size 标题文本尺寸
     */
    public func setAudioTitleTextFontSize(size: Float64): Unit {
        audioTitleTextFontSize = size
    }
    /**
     * 设置音频标题文本字体样式
     *
     * @param style 标题文本字体样式
     */
    public func setAudioTitleTextFontStyle(style: Int64): Unit {
        audioTitleTextFontStyle = convertFontStyle(style)
    }
    /**
     * 设置音频标题文本字体粗细
     *
     * @param weight 标题文本字体粗细
     */
    public func setAudioTitleTextFontWeight(weight: String): Unit {
        audioTitleTextFontWeight = convertFontWeight(weight)
    }
    /**
     * 设置音频标题文本字体
     *
     * @param family 标题文本字体
     */
    public func setAudioTitleTextFontFamily(family: String): Unit {
        audioTitleTextFontFamily = family
    }
    /**
     * 设置音频标题文本行高
     *
     * @param lineHeight 标题文本行高
     */
    public func setAudioTitleTextLineHeight(lineHeight: Float64): Unit {
        audioTitleTextLineHeight = lineHeight
    }
    /**
     * 设置音频类型文本颜色
     *
     * @param color 类型文本颜色
     */
    public func setAudioTypeTextFontColor(color: UInt32): Unit {
        audioTypeTextFontColor = transColorForTrasparent(color)
    }
    /**
     * 设置音频类型文本尺寸
     *
     * @param size 类型文本尺寸
     */
    public func setAudioTypeTextFontSize(size: Float64): Unit {
        audioTypeTextFontSize = size
    }
    /**
     * 设置音频类型文本字体样式
     *
     * @param style 类型文本字体样式
     */
    public func setAudioTypeTextFontStyle(style: Int64): Unit {
        audioTypeTextFontStyle = convertFontStyle(style)
    }
    /**
     * 设置音频类型文本字体粗细
     *
     * @param weight 类型文本字体粗细
     */
    public func setAudioTypeTextFontWeight(weight: String): Unit {
        audioTypeTextFontWeight = convertFontWeight(weight)
    }
    /**
     * 设置音频类型文本字体
     *
     * @param family 类型文本字体
     */
    public func setAudioTypeTextFontFamily(family: String): Unit {
        audioTypeTextFontFamily = family
    }
    /**
     * 设置音频类型文本行高
     *
     * @param lineHeight 类型文本行高
     */
    public func setAudioTypeTextLineHeight(lineHeight: Float64): Unit {
        audioTypeTextLineHeight = lineHeight
    }
}
