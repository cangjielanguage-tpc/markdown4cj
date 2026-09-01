package markdown.components.theme

import ohos.state_macro_manage.*

/**
 * 全局样式
 */
@Observed
public class GlobalTheme {
    @Publish
    public var stageContext: ?StageContext = Option<StageContext>.None // markdown上下文 - 互操作
    @Publish
    public var uiAbilityContext: ?UIAbilityContext = Option<UIAbilityContext>.None // markdown上下文 - 仓颉
    @Publish
    public var isMarkdownParserSync: Bool = false // markdown是否同步解析
    @Publish
    public var enableParseThrottle: Bool = false // 是否启用解析节流（流式输出时控制解析频率）
    @Publish
    public var parseThrottleMs: Int64 = 200 // 节流间隔（毫秒）
    @Publish
    public var isOnCopy: Bool = true // 是否打开长按复制粘贴
    @Publish
    public var blockMarginTop: Float64 = 0.0 // markdown全局上外边距
    @Publish
    public var blockMarginRight: Float64 = 0.0 // markdown全局右外边距
    @Publish
    public var blockMarginBottom: Float64 = 0.0 // markdown全局下外边距
    @Publish
    public var blockMarginLeft: Float64 = 0.0 // markdown全局左外边距
    @Publish
    public var markdownBlockSpacing: Int64 = 8 // markdown子组件主轴方向的间隔
    @Publish
    public var isLineBreak: Bool = false // 软换行是否换行
    @Publish
    public var openGestureSwipe: Bool = false // markdown是否支持滚动手势
    @Publish
    public var backgroundColor: Color = COLOR_TRANSPARENT // 背景颜色
    @Publish
    public var paragraphHeadingAnimationEnabled: Bool = false // 是否启用标题段落加载动画
    @Publish
    public var paragraphHeadingAnimationDuration: Int32 = 0 // 标题段落加载动画时长（毫秒）

    /**
     * 设置markdown上下文 - 互操作
     *
     * @param context 上下文对象
     * @return 当前GlobalTheme对象
     */
    public func setStageContext(context: StageContext): GlobalTheme {
        this.stageContext = context
        return this
    }

    /**
     * 设置markdown上下文 - 仓颉
     *
     * @param context 上下文对象
     * @return 当前GlobalTheme对象
     */
    public func setUiAbilityContext(context: UIAbilityContext): GlobalTheme {
        this.uiAbilityContext = context
        return this
    }

    /**
     * 设置markdown是否同步解析
     *
     * @param parserSync 是否同步解析
     * @return 当前GlobalTheme对象
     */
    public func setIsMarkdownParserSync(parserSync: Bool): GlobalTheme {
        this.isMarkdownParserSync = parserSync
        return this
    }

    /**
     * 设置是否打开长按复制粘贴
     *
     * @param onCopy 是否开启
     * @return 当前GlobalTheme对象
     */
    public func setIsOnCopy(onCopy: Bool): GlobalTheme {
        this.isOnCopy = onCopy
        return this
    }

    /**
     * 全局整体外边距
     *
     * @param margin 外边距
     * @return 当前GlobalTheme对象
     */
    public func setGlobalMargin(margin: Float64): GlobalTheme {
        this.blockMarginTop = margin
        this.blockMarginRight = margin
        this.blockMarginBottom = margin
        this.blockMarginLeft = margin
        return this
    }

    /**
     * 全局分别设置四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前GlobalTheme对象
     */
    public func setGlobalMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): GlobalTheme {
        this.blockMarginTop = top
        this.blockMarginRight = right
        this.blockMarginBottom = bottom
        this.blockMarginLeft = left
        return this
    }

    /**
     * 设置markdown子组件主轴方向的间隔
     *
     * @param space markdown子组件主轴方向的间隔
     * @return 当前GlobalTheme对象
     */
    public func setBlockSpacing(space: Int64): GlobalTheme {
        this.markdownBlockSpacing = space
        return this
    }

    /**
     * 设置软换行是否换行
     *
     * @param lineBreak 是否换行
     * @return 当前GlobalTheme对象
     */
    public func setIsLineBreak(lineBreak: Bool): GlobalTheme {
        this.isLineBreak = lineBreak
        return this
    }

    /**
     * 设置markdown是否支持滚动手势
     *
     * @param gestureSwipe 是否支持手势滑动
     * @return 当前GlobalTheme对象
     */
    public func setOpenGestureSwipe(gestureSwipe: Bool): GlobalTheme {
        this.openGestureSwipe = gestureSwipe
        return this
    }

    /**
     * 设置背景颜色
     *
     * @param color 背景颜色
     * @return 当前GlobalTheme对象
     */
    public func setBackgroundColor(color: Color): GlobalTheme {
        this.backgroundColor = color
        return this
    }

    /**
     * 设置是否启用解析节流
     *
     * @param enable 是否启用
     * @return 当前GlobalTheme对象
     */
    public func setEnableParseThrottle(enable: Bool): GlobalTheme {
        this.enableParseThrottle = enable
        return this
    }

    /**
     * 设置节流间隔
     *
     * @param throttleMs 节流间隔（毫秒）
     * @return 当前GlobalTheme对象
     */
    public func setParseThrottleMs(throttleMs: Int64): GlobalTheme {
        this.parseThrottleMs = throttleMs
        return this
    }

    /**
     * 设置标题段落加载动画是否启用
     * 开启后段落出现时从透明渐变为不透明（渐显），消失时从不透明渐变为透明（渐隐）
     *
     * @param enable 是否启用
     * @return 当前GlobalTheme对象
     */
    public func setParagraphHeadingAnimationEnabled(enable: Bool): GlobalTheme {
        this.paragraphHeadingAnimationEnabled = enable
        return this
    }

    /**
     * 设置标题段落加载动画时长
     *
     * @param duration 动画时长（毫秒）
     * @return 当前GlobalTheme对象
     */
    public func setParagraphHeadingAnimationDuration(duration: Int32): GlobalTheme {
        this.paragraphHeadingAnimationDuration = duration
        return this
    }
}