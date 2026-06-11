package markdown.components.theme

/**
 * 标题样式
 */
public class HeadingTheme <: MarkdownBaseTheme {
    public var heading1BackgroundColor: ?Color = None // 一级标题背景颜色
    public var heading1MarginTop: Float64 = 0.0 // 一级标题上外边距
    public var heading1MarginRight: Float64 = 0.0 // 一级标题右外边距
    public var heading1MarginBottom: Float64 = 0.0 // 一级标题下外边距
    public var heading1MarginLeft: Float64 = 0.0 // 一级标题左外边距
    public var heading1PaddingTop: Float64 = 0.0 // 一级标题上内边距
    public var heading1PaddingRight: Float64 = 0.0 // 一级标题右内边距
    public var heading1PaddingBottom: Float64 = 0.0 // 一级标题下内边距
    public var heading1PaddingLeft: Float64 = 0.0 // 一级标题左内边距
    public var heading1TextFontColor: Color = COLOR_FF191919 // 一级标题文本颜色
    public var heading1TextFontSize: Float64 = 20.0 // 一级标题文本尺寸
    public var heading1TextFontStyle: FontStyle = FontStyle.Normal // 一级标题文本字体样式
    public var heading1TextFontWeight: FontWeight = FontWeight.W600 // 一级标题文本字体粗细
    public var heading1TextFontFamily: String = "HarmonyOS Sans" // 一级标题文本字体
    public var heading1TextLineHeight: Float64 = 22.0 // 一级标题文本行高
    public var heading1TextLetterSpacing: Float64 = 0.0 // 一级标题文本字符间距
    public var heading1UnderlineHeight: Float64 = 0.5 // 一级标题下划线高度
    public var heading1UnderlineColor: Color = COLOR_FF191919 // 一级标题下划线颜色
    public var heading1UnderlineSpacing: Float64 = 0.0 // 一级标题距离标题文本间距
    public var heading2BackgroundColor: ?Color = None // 二级标题背景颜色
    public var heading2MarginTop: Float64 = 0.0 // 二级标题上外边距
    public var heading2MarginRight: Float64 = 0.0 // 二级标题右外边距
    public var heading2MarginBottom: Float64 = 0.0 // 二级标题下外边距
    public var heading2MarginLeft: Float64 = 0.0 // 二级标题左外边距
    public var heading2PaddingTop: Float64 = 0.0 // 二级标题上内边距
    public var heading2PaddingRight: Float64 = 0.0 // 二级标题右内边距
    public var heading2PaddingBottom: Float64 = 0.0 // 二级标题下内边距
    public var heading2PaddingLeft: Float64 = 0.0 // 二级标题左内边距
    public var heading2TextFontColor: Color = COLOR_FF191919 // 二级标题文本颜色
    public var heading2TextFontSize: Float64 = 17.0 // 二级标题文本尺寸
    public var heading2TextFontStyle: FontStyle = FontStyle.Normal // 二级标题文本字体样式
    public var heading2TextFontWeight: FontWeight = FontWeight.W600 // 二级标题文本字体粗细
    public var heading2TextFontFamily: String = "HarmonyOS Sans" // 二级标题文本字体
    public var heading2TextLineHeight: Float64 = 22.0 // 二级标题文本行高
    public var heading2TextLetterSpacing: Float64 = 0.0 // 二级标题文本字符间距
    public var heading2UnderlineHeight: Float64 = 0.5 // 二级标题下划线高度
    public var heading2UnderlineColor: Color = COLOR_FF191919 // 二级标题下划线颜色
    public var heading2UnderlineSpacing: Float64 = 0.0 // 二级标题距离标题文本间距
    public var heading3BackgroundColor: ?Color = None // 三级标题背景颜色
    public var heading3MarginTop: Float64 = 0.0 // 三级标题上外边距
    public var heading3MarginRight: Float64 = 0.0 // 三级标题右外边距
    public var heading3MarginBottom: Float64 = 0.0 // 三级标题下外边距
    public var heading3MarginLeft: Float64 = 0.0 // 三级标题左外边距
    public var heading3PaddingTop: Float64 = 0.0 // 三级标题上内边距
    public var heading3PaddingRight: Float64 = 0.0 // 三级标题右内边距
    public var heading3PaddingBottom: Float64 = 0.0 // 三级标题下内边距
    public var heading3PaddingLeft: Float64 = 0.0 // 三级标题左内边距
    public var heading3TextFontColor: Color = COLOR_FF191919 // 三级标题文本颜色
    public var heading3TextFontSize: Float64 = 16.0 // 三级标题文本尺寸
    public var heading3TextFontStyle: FontStyle = FontStyle.Normal // 三级标题文本字体样式
    public var heading3TextFontWeight: FontWeight = FontWeight.W600 // 三级标题文本字体粗细
    public var heading3TextFontFamily: String = "HarmonyOS Sans" // 三级标题文本字体
    public var heading3TextLineHeight: Float64 = 22.0 // 三级标题文本行高
    public var heading3TextLetterSpacing: Float64 = 0.0 // 三级标题文本字符间距
    public var heading4BackgroundColor: ?Color = None // 四级标题背景颜色
    public var heading4MarginTop: Float64 = 0.0 // 四级标题上外边距
    public var heading4MarginRight: Float64 = 0.0 // 四级标题右外边距
    public var heading4MarginBottom: Float64 = 0.0 // 四级标题下外边距
    public var heading4MarginLeft: Float64 = 0.0 // 四级标题左外边距
    public var heading4PaddingTop: Float64 = 0.0 // 四级标题上内边距
    public var heading4PaddingRight: Float64 = 0.0 // 四级标题右内边距
    public var heading4PaddingBottom: Float64 = 0.0 // 四级标题下内边距
    public var heading4PaddingLeft: Float64 = 0.0 // 四级标题左内边距
    public var heading4TextFontColor: Color = COLOR_FF191919 // 四级标题文本颜色
    public var heading4TextFontSize: Float64 = 15.0 // 四级标题文本尺寸
    public var heading4TextFontStyle: FontStyle = FontStyle.Normal // 四级标题文本字体样式
    public var heading4TextFontWeight: FontWeight = FontWeight.W600 // 四级标题文本字体粗细
    public var heading4TextFontFamily: String = "HarmonyOS Sans" // 四级标题文本字体
    public var heading4TextLineHeight: Float64 = 22.0 // 四级标题文本行高
    public var heading4TextLetterSpacing: Float64 = 0.0 // 四级标题文本字符间距
    public var heading5BackgroundColor: ?Color = None // 五级标题背景颜色
    public var heading5MarginTop: Float64 = 0.0 // 五级标题上外边距
    public var heading5MarginRight: Float64 = 0.0 // 五级标题右外边距
    public var heading5MarginBottom: Float64 = 0.0 // 五级标题下外边距
    public var heading5MarginLeft: Float64 = 0.0 // 五级标题左外边距
    public var heading5PaddingTop: Float64 = 0.0 // 五级标题上内边距
    public var heading5PaddingRight: Float64 = 0.0 // 五级标题右内边距
    public var heading5PaddingBottom: Float64 = 0.0 // 五级标题下内边距
    public var heading5PaddingLeft: Float64 = 0.0 // 五级标题左内边距
    public var heading5TextFontColor: Color = COLOR_FF191919 // 五级标题文本颜色
    public var heading5TextFontSize: Float64 = 15.0 // 五级标题文本尺寸
    public var heading5TextFontStyle: FontStyle = FontStyle.Normal // 五级标题文本字体样式
    public var heading5TextFontWeight: FontWeight = FontWeight.W600 // 五级标题文本字体粗细
    public var heading5TextFontFamily: String = "HarmonyOS Sans" // 五级标题文本字体
    public var heading5TextLineHeight: Float64 = 22.0 // 五级标题文本行高
    public var heading5TextLetterSpacing: Float64 = 0.0 // 五级标题文本字符间距
    public var heading6BackgroundColor: ?Color = None // 六级标题背景颜色
    public var heading6MarginTop: Float64 = 0.0 // 六级标题上外边距
    public var heading6MarginRight: Float64 = 0.0 // 六级标题右外边距
    public var heading6MarginBottom: Float64 = 0.0 // 六级标题下外边距
    public var heading6MarginLeft: Float64 = 0.0 // 六级标题左外边距
    public var heading6PaddingTop: Float64 = 0.0 // 六级标题上内边距
    public var heading6PaddingRight: Float64 = 0.0 // 六级标题右内边距
    public var heading6PaddingBottom: Float64 = 0.0 // 六级标题下内边距
    public var heading6PaddingLeft: Float64 = 0.0 // 六级标题左内边距
    public var heading6TextFontColor: Color = COLOR_FF191919 // 六级标题文本颜色
    public var heading6TextFontSize: Float64 = 13.0 // 六级标题文本尺寸
    public var heading6TextFontStyle: FontStyle = FontStyle.Normal // 六级标题文本字体样式
    public var heading6TextFontWeight: FontWeight = FontWeight.W600 // 六级标题文本字体粗细
    public var heading6TextFontFamily: String = "HarmonyOS Sans" // 六级标题文本字体
    public var heading6TextLineHeight: Float64 = 22.0 // 六级标题文本行高
    public var heading6TextLetterSpacing: Float64 = 0.0 // 六级标题文本字符间距

    /**
     * 设置标题的背景颜色：设置所有标题为统一背景颜色
     *
     * @param color 背景颜色
     * @return 当前HeadingTheme对象
     */
    public func setBackgroundColorForAllHeading(color: Color): HeadingTheme {
        this.heading1BackgroundColor = color
        this.heading2BackgroundColor = color
        this.heading3BackgroundColor = color
        this.heading4BackgroundColor = color
        this.heading5BackgroundColor = color
        this.heading6BackgroundColor = color
        return this
    }

    /**
     * 设置标题的背景颜色：通过集合的方式，分别设置每级标题的背景颜色
     *
     * @param colorList 背景颜色集合
     * @return 当前HeadingTheme对象
     */
    public func setBackgroundColorForEachHeading(colorList: Array<Color>): HeadingTheme {
        var level = 1
        for (color in colorList) {
            setBackgroundColorForDesignateHeading(level, color)
            level += 1
        }
        return this
    }

    /**
     * 设置标题的背景颜色：指定标题等级，设置该等级标题的背景颜色
     *
     * @param level 标题等级
     * @param color 背景颜色
     * @return 当前HeadingTheme对象
     */
    public func setBackgroundColorForDesignateHeading(level: Int64, color: Color): HeadingTheme {
        match (level) {
            case 1 => this.heading1BackgroundColor = color
            case 2 => this.heading2BackgroundColor = color
            case 3 => this.heading3BackgroundColor = color
            case 4 => this.heading4BackgroundColor = color
            case 5 => this.heading5BackgroundColor = color
            case 6 => this.heading6BackgroundColor = color
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题的4个外边距：设置H1-H6级标题所有4个外边距为统一值
     *
     * @param margin 外边距
     * @return 当前HeadingTheme对象
     */
    public func setMarginForAllHeading(margin: Float64): HeadingTheme {
        this.heading1MarginTop = margin
        this.heading1MarginRight = margin
        this.heading1MarginBottom = margin
        this.heading1MarginLeft = margin
        this.heading2MarginTop = margin
        this.heading2MarginRight = margin
        this.heading2MarginBottom = margin
        this.heading2MarginLeft = margin
        this.heading3MarginTop = margin
        this.heading3MarginRight = margin
        this.heading3MarginBottom = margin
        this.heading3MarginLeft = margin
        this.heading4MarginTop = margin
        this.heading4MarginRight = margin
        this.heading4MarginBottom = margin
        this.heading4MarginLeft = margin
        this.heading5MarginTop = margin
        this.heading5MarginRight = margin
        this.heading5MarginBottom = margin
        this.heading5MarginLeft = margin
        this.heading6MarginTop = margin
        this.heading6MarginRight = margin
        this.heading6MarginBottom = margin
        this.heading6MarginLeft = margin
        return this
    }

    /**
     * 设置标题的4个外边距：设置H1-H6级标题，每级标题自己的4个外边距为统一值
     *
     * @param marginList 外边距集合
     * @return 当前HeadingTheme对象
     */
    public func setMarginForEachHeading(marginList: Array<Float64>): HeadingTheme {
        var level = 1
        for (margin in marginList) {
            setMarginForDesignateHeading(level, margin)
            level += 1
        }
        return this
    }

    /**
     * 设置标题的4个外边距：指定标题等级，设置标题的4个外边距为统一值
     *
     * @param level 标题等级
     * @param margin 外边距
     * @return 当前HeadingTheme对象
     */
    public func setMarginForDesignateHeading(level: Int64, margin: Float64): HeadingTheme {
        setMarginForDesignateHeading(level, top: margin, right: margin, bottom: margin, left: margin)
        return this
    }

    /**
     * 设置标题的4个外边距：分别设置H1-H6每级标题的每个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前HeadingTheme对象
     */
    public func setMarginForEachHeading(top!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], right!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], bottom!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], left!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]): HeadingTheme {
        for (index in 0..top.size) {
            setMarginForDesignateHeading((index + 1), top: top[index])
        }
        for (index in 0..right.size) {
            setMarginForDesignateHeading((index + 1), right: right[index])
        }
        for (index in 0..bottom.size) {
            setMarginForDesignateHeading((index + 1), bottom: bottom[index])
        }
        for (index in 0..left.size) {
            setMarginForDesignateHeading((index + 1), left: left[index])
        }
        return this
    }

    /**
     * 设置标题的4个外边距：指定标题等级，分别设置该标题的每个外边距
     *
     * @param level 标题等级
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前HeadingTheme对象
     */
    public func setMarginForDesignateHeading(level: Int64, top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): HeadingTheme {
        match (level) {
            case 1 =>
                this.heading1MarginTop = top
                this.heading1MarginRight = right
                this.heading1MarginBottom = bottom
                this.heading1MarginLeft = left
            case 2 =>
                this.heading2MarginTop = top
                this.heading2MarginRight = right
                this.heading2MarginBottom = bottom
                this.heading2MarginLeft = left
            case 3 =>
                this.heading3MarginTop = top
                this.heading3MarginRight = right
                this.heading3MarginBottom = bottom
                this.heading3MarginLeft = left
            case 4 =>
                this.heading4MarginTop = top
                this.heading4MarginRight = right
                this.heading4MarginBottom = bottom
                this.heading4MarginLeft = left
            case 5 =>
                this.heading5MarginTop = top
                this.heading5MarginRight = right
                this.heading5MarginBottom = bottom
                this.heading5MarginLeft = left
            case 6 =>
                this.heading6MarginTop = top
                this.heading6MarginRight = right
                this.heading6MarginBottom = bottom
                this.heading6MarginLeft = left
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题的4个内边距：设置H1-H6级标题所有4个内边距为统一值
     *
     * @param padding 内边距
     * @return 当前HeadingTheme对象
     */
    public func setPaddingForAllHeading(padding: Float64): HeadingTheme {
        this.heading1PaddingTop = padding
        this.heading1PaddingRight = padding
        this.heading1PaddingBottom = padding
        this.heading1PaddingLeft = padding
        this.heading2PaddingTop = padding
        this.heading2PaddingRight = padding
        this.heading2PaddingBottom = padding
        this.heading2PaddingLeft = padding
        this.heading3PaddingTop = padding
        this.heading3PaddingRight = padding
        this.heading3PaddingBottom = padding
        this.heading3PaddingLeft = padding
        this.heading4PaddingTop = padding
        this.heading4PaddingRight = padding
        this.heading4PaddingBottom = padding
        this.heading4PaddingLeft = padding
        this.heading5PaddingTop = padding
        this.heading5PaddingRight = padding
        this.heading5PaddingBottom = padding
        this.heading5PaddingLeft = padding
        this.heading6PaddingTop = padding
        this.heading6PaddingRight = padding
        this.heading6PaddingBottom = padding
        this.heading6PaddingLeft = padding
        return this
    }

    /**
     * 设置标题的4个内边距：设置H1-H6级标题，每级标题自己的4个内边距为统一值
     *
     * @param paddingList 内边距集合
     * @return 当前HeadingTheme对象
     */
    public func setPaddingForEachHeading(paddingList: Array<Float64>): HeadingTheme {
        var level = 1
        for (padding in paddingList) {
            setPaddingForDesignateHeading(level, padding)
            level += 1
        }
        return this
    }

    /**
     * 设置标题的4个内边距：指定标题等级，设置标题的4个内边距为统一值
     *
     * @param level 标题等级
     * @param padding 内边距
     * @return 当前HeadingTheme对象
     */
    public func setPaddingForDesignateHeading(level: Int64, padding: Float64): HeadingTheme {
        setPaddingForDesignateHeading(level, top: padding, right: padding, bottom: padding, left: padding)
        return this
    }

    /**
     * 设置标题的4个内边距：分别设置H1-H6每级标题的每个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前HeadingTheme对象
     */
    public func setPaddingForEachHeading(top!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], right!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], bottom!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], left!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]): HeadingTheme {
        for (index in 0..top.size) {
            setPaddingForDesignateHeading((index + 1), top: top[index])
        }
        for (index in 0..right.size) {
            setPaddingForDesignateHeading((index + 1), right: right[index])
        }
        for (index in 0..bottom.size) {
            setPaddingForDesignateHeading((index + 1), bottom: bottom[index])
        }
        for (index in 0..left.size) {
            setPaddingForDesignateHeading((index + 1), left: left[index])
        }
        return this
    }

    /**
     * 设置标题的4个内边距：指定标题等级，分别设置该标题的每个内边距
     *
     * @param level 标题等级
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前HeadingTheme对象
     */
    public func setPaddingForDesignateHeading(level: Int64, top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): HeadingTheme {
        match (level) {
            case 1 =>
                this.heading1PaddingTop = top
                this.heading1PaddingRight = right
                this.heading1PaddingBottom = bottom
                this.heading1PaddingLeft = left
            case 2 =>
                this.heading2PaddingTop = top
                this.heading2PaddingRight = right
                this.heading2PaddingBottom = bottom
                this.heading2PaddingLeft = left
            case 3 =>
                this.heading3PaddingTop = top
                this.heading3PaddingRight = right
                this.heading3PaddingBottom = bottom
                this.heading3PaddingLeft = left
            case 4 =>
                this.heading4PaddingTop = top
                this.heading4PaddingRight = right
                this.heading4PaddingBottom = bottom
                this.heading4PaddingLeft = left
            case 5 =>
                this.heading5PaddingTop = top
                this.heading5PaddingRight = right
                this.heading5PaddingBottom = bottom
                this.heading5PaddingLeft = left
            case 6 =>
                this.heading6PaddingTop = top
                this.heading6PaddingRight = right
                this.heading6PaddingBottom = bottom
                this.heading6PaddingLeft = left
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题文本颜色：所有标题的统一文本颜色
     *
     * @param color 文本颜色
     * @return 当前HeadingTheme对象
     */
    public func setTextFontColorForAllHeading(color: Color): HeadingTheme {
        this.heading1TextFontColor = color
        this.heading2TextFontColor = color
        this.heading3TextFontColor = color
        this.heading4TextFontColor = color
        this.heading5TextFontColor = color
        this.heading6TextFontColor = color
        return this
    }

    /**
     * 设置标题文本颜色：分别设置每级标题的文本颜色
     *
     * @param colorList 文本颜色集合
     * @return 当前HeadingTheme对象
     */
    public func setTextFontColorForEachHeading(colorList: Array<Color>): HeadingTheme {
        var level = 1
        for (color in colorList) {
            setTextFontColorForDesignateHeading(level, color)
            level += 1
        }
        return this
    }

    /**
     * 设置标题文本颜色：设置指定等级的标题的文本颜色
     *
     * @param level 标题等级
     * @param color 文本颜色
     * @return 当前HeadingTheme对象
     */
    public func setTextFontColorForDesignateHeading(level: Int64, color: Color): HeadingTheme {
        match (level) {
            case 1 => this.heading1TextFontColor = color
            case 2 => this.heading2TextFontColor = color
            case 3 => this.heading3TextFontColor = color
            case 4 => this.heading4TextFontColor = color
            case 5 => this.heading5TextFontColor = color
            case 6 => this.heading6TextFontColor = color
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题文本尺寸：所有标题的统一文本尺寸
     *
     * @param size 文本尺寸
     * @return 当前HeadingTheme对象
     */
    public func setTextFontSizeForAllHeading(size: Float64): HeadingTheme {
        this.heading1TextFontSize = size
        this.heading2TextFontSize = size
        this.heading3TextFontSize = size
        this.heading4TextFontSize = size
        this.heading5TextFontSize = size
        this.heading6TextFontSize = size
        return this
    }

    /**
     * 设置标题文本尺寸：分别设置每级标题的文本尺寸
     *
     * @param sizeList 文本尺寸集合
     * @return 当前HeadingTheme对象
     */
    public func setTextFontSizeForEachHeading(sizeList: Array<Float64>): HeadingTheme {
        var level = 1
        for (size in sizeList) {
            setTextFontSizeForDesignateHeading(level, size)
            level += 1
        }
        return this
    }

    /**
     * 设置标题文本尺寸：设置指定等级的标题的文本尺寸
     *
     * @param level 标题等级
     * @param size 文本尺寸
     * @return 当前HeadingTheme对象
     */
    public func setTextFontSizeForDesignateHeading(level: Int64, size: Float64): HeadingTheme {
        match (level) {
            case 1 => this.heading1TextFontSize = size
            case 2 => this.heading2TextFontSize = size
            case 3 => this.heading3TextFontSize = size
            case 4 => this.heading4TextFontSize = size
            case 5 => this.heading5TextFontSize = size
            case 6 => this.heading6TextFontSize = size
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题文本字体样式：所有标题的统一文本字体样式
     *
     * @param style 文本字体样式
     * @return 当前HeadingTheme对象
     */
    public func setTextFontStyleForAllHeading(style: FontStyle): HeadingTheme {
        this.heading1TextFontStyle = style
        this.heading2TextFontStyle = style
        this.heading3TextFontStyle = style
        this.heading4TextFontStyle = style
        this.heading5TextFontStyle = style
        this.heading6TextFontStyle = style
        return this
    }

    /**
     * 设置标题文本字体样式：分别设置每级标题的文本字体样式
     *
     * @param styleList 文本字体样式集合
     * @return 当前HeadingTheme对象
     */
    public func setTextFontStyleForEachHeading(styleList: Array<FontStyle>): HeadingTheme {
        var level = 1
        for (style in styleList) {
            setTextFontStyleForDesignateHeading(level, style)
            level += 1
        }
        return this
    }

    /**
     * 设置标题文本字体样式：设置指定等级的标题的文本字体样式
     *
     * @param level 标题等级
     * @param style 文本字体样式
     * @return 当前HeadingTheme对象
     */
    public func setTextFontStyleForDesignateHeading(level: Int64, style: FontStyle): HeadingTheme {
        match (level) {
            case 1 => this.heading1TextFontStyle = style
            case 2 => this.heading2TextFontStyle = style
            case 3 => this.heading3TextFontStyle = style
            case 4 => this.heading4TextFontStyle = style
            case 5 => this.heading5TextFontStyle = style
            case 6 => this.heading6TextFontStyle = style
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题文本字体粗细：所有标题的统一文本字体粗细
     *
     * @param weight 文本字体粗细
     * @return 当前HeadingTheme对象
     */
    public func setTextFontWeightForAllHeading(weight: FontWeight): HeadingTheme {
        this.heading1TextFontWeight = weight
        this.heading2TextFontWeight = weight
        this.heading3TextFontWeight = weight
        this.heading4TextFontWeight = weight
        this.heading5TextFontWeight = weight
        this.heading6TextFontWeight = weight
        return this
    }

    /**
     * 设置标题文本字体粗细：分别设置每级标题的文本字体粗细
     *
     * @param weightList 文本字体粗细集合
     * @return 当前HeadingTheme对象
     */
    public func setTextFontWeightForEachHeading(weightList: Array<FontWeight>): HeadingTheme {
        var level = 1
        for (weight in weightList) {
            setTextFontWeightForDesignateHeading(level, weight)
            level += 1
        }
        return this
    }

    /**
     * 设置标题文本字体粗细：设置指定等级的标题的文本字体粗细
     *
     * @param level 标题等级
     * @param weight 文本字体粗细
     * @return 当前HeadingTheme对象
     */
    public func setTextFontWeightForDesignateHeading(level: Int64, weight: FontWeight): HeadingTheme {
        match (level) {
            case 1 => this.heading1TextFontWeight = weight
            case 2 => this.heading2TextFontWeight = weight
            case 3 => this.heading3TextFontWeight = weight
            case 4 => this.heading4TextFontWeight = weight
            case 5 => this.heading5TextFontWeight = weight
            case 6 => this.heading6TextFontWeight = weight
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题文本字体：所有标题的统一文本字体
     *
     * @param family 文本字体
     * @return 当前HeadingTheme对象
     */
    public func setTextFontFamilyForAllHeading(family: String): HeadingTheme {
        this.heading1TextFontFamily = family
        this.heading2TextFontFamily = family
        this.heading3TextFontFamily = family
        this.heading4TextFontFamily = family
        this.heading5TextFontFamily = family
        this.heading6TextFontFamily = family
        return this
    }

    /**
     * 设置标题文本字体：分别设置每级标题的文本字体
     *
     * @param familyList 文本字体集合
     * @return 当前HeadingTheme对象
     */
    public func setTextFontFamilyForEachHeading(familyList: Array<String>): HeadingTheme {
        var level = 1
        for (family in familyList) {
            setTextFontFamilyForDesignateHeading(level, family)
            level += 1
        }
        return this
    }

    /**
     * 设置标题文本字体：设置指定等级的标题的文本字体
     *
     * @param level 标题等级
     * @param family 文本字体
     * @return 当前HeadingTheme对象
     */
    public func setTextFontFamilyForDesignateHeading(level: Int64, family: String): HeadingTheme {
        match (level) {
            case 1 => this.heading1TextFontFamily = family
            case 2 => this.heading2TextFontFamily = family
            case 3 => this.heading3TextFontFamily = family
            case 4 => this.heading4TextFontFamily = family
            case 5 => this.heading5TextFontFamily = family
            case 6 => this.heading6TextFontFamily = family
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题文本行高：所有标题的统一文本行高
     *
     * @param lineHeight 文本行高
     * @return 当前HeadingTheme对象
     */
    public func setTextLineHeightForAllHeading(lineHeight: Float64): HeadingTheme {
        this.heading1TextLineHeight = lineHeight
        this.heading2TextLineHeight = lineHeight
        this.heading3TextLineHeight = lineHeight
        this.heading4TextLineHeight = lineHeight
        this.heading5TextLineHeight = lineHeight
        this.heading6TextLineHeight = lineHeight
        return this
    }

    /**
     * 设置标题文本行高：分别设置每级标题的文本行高
     *
     * @param lineHeightList 文本行高集合
     * @return 当前HeadingTheme对象
     */
    public func setTextLineHeightForEachHeading(lineHeightList: Array<Float64>): HeadingTheme {
        var level = 1
        for (lineHeight in lineHeightList) {
            setTextLineHeightForDesignateHeading(level, lineHeight)
            level += 1
        }
        return this
    }

    /**
     * 设置标题文本行高：设置指定等级的标题的文本行高
     *
     * @param level 标题等级
     * @param lineHeight 文本行高
     * @return 当前HeadingTheme对象
     */
    public func setTextLineHeightForDesignateHeading(level: Int64, lineHeight: Float64): HeadingTheme {
        match (level) {
            case 1 => this.heading1TextLineHeight = lineHeight
            case 2 => this.heading2TextLineHeight = lineHeight
            case 3 => this.heading3TextLineHeight = lineHeight
            case 4 => this.heading4TextLineHeight = lineHeight
            case 5 => this.heading5TextLineHeight = lineHeight
            case 6 => this.heading6TextLineHeight = lineHeight
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题文本字符间距：所有标题的统一文本字符间距
     *
     * @param spacing 文本字符间距
     * @return 当前HeadingTheme对象
     */
    public func setTextLetterSpacingForAllHeading(spacing: Float64): HeadingTheme {
        this.heading1TextLetterSpacing = spacing
        this.heading2TextLetterSpacing = spacing
        this.heading3TextLetterSpacing = spacing
        this.heading4TextLetterSpacing = spacing
        this.heading5TextLetterSpacing = spacing
        this.heading6TextLetterSpacing = spacing
        return this
    }

    /**
     * 设置标题文本字符间距：分别设置每级标题的文本字符间距
     *
     * @param spacingList 文本字符间距集合
     * @return 当前HeadingTheme对象
     */
    public func setTextLetterSpacingForEachHeading(spacingList: Array<Float64>): HeadingTheme {
        var level = 1
        for (spacing in spacingList) {
            setTextLetterSpacingForDesignateHeading(level, spacing)
            level += 1
        }
        return this
    }

    /**
     * 设置标题文本字符间距：设置指定等级的标题的文本字符间距
     *
     * @param level 标题等级
     * @param spacing 文本字符间距
     * @return 当前HeadingTheme对象
     */
    public func setTextLetterSpacingForDesignateHeading(level: Int64, spacing: Float64): HeadingTheme {
        match (level) {
            case 1 => this.heading1TextLetterSpacing = spacing
            case 2 => this.heading2TextLetterSpacing = spacing
            case 3 => this.heading3TextLetterSpacing = spacing
            case 4 => this.heading4TextLetterSpacing = spacing
            case 5 => this.heading5TextLetterSpacing = spacing
            case 6 => this.heading6TextLetterSpacing = spacing
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题下划线高度：H1和H2标题的统一下划线高度
     *
     * @param height 下划线高度
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineHeightForAllHeading(height: Float64): HeadingTheme {
        this.heading1UnderlineHeight = height
        this.heading2UnderlineHeight = height
        return this
    }

    /**
     * 设置标题下划线高度：设置指定等级标题的下划线高度（仅H1和H2）
     *
     * @param level 标题等级
     * @param height 下划线高度
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineHeightForDesignateHeading(level: Int64, height: Float64): HeadingTheme {
        match (level) {
            case 1 => this.heading1UnderlineHeight = height
            case 2 => this.heading2UnderlineHeight = height
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题下划线颜色：H1和H2标题的统一下划线颜色
     *
     * @param color 下划线颜色
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineColorForAllHeading(color: Color): HeadingTheme {
        this.heading1UnderlineColor = color
        this.heading2UnderlineColor = color
        return this
    }

    /**
     * 设置标题下划线颜色：设置指定等级标题的下划线颜色（仅H1和H2）
     *
     * @param level 标题等级
     * @param color 下划线颜色
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineColorForDesignateHeading(level: Int64, color: Color): HeadingTheme {
        match (level) {
            case 1 => this.heading1UnderlineColor = color
            case 2 => this.heading2UnderlineColor = color
            case _ => ()
        }
        return this
    }

    /**
     * 设置标题下划线间距：H1和H2标题的统一下划线间距
     *
     * @param spacing 下划线间距
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineSpacingForAllHeading(spacing: Float64): HeadingTheme {
        this.heading1UnderlineSpacing = spacing
        this.heading2UnderlineSpacing = spacing
        return this
    }

    /**
     * 设置标题下划线间距：设置指定等级标题的下划线间距（仅H1和H2）
     *
     * @param level 标题等级
     * @param spacing 下划线间距
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineSpacingForDesignateHeading(level: Int64, spacing: Float64): HeadingTheme {
        match (level) {
            case 1 => this.heading1UnderlineSpacing = spacing
            case 2 => this.heading2UnderlineSpacing = spacing
            case _ => ()
        }
        return this
    }
}