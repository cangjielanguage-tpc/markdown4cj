package markdown.components.theme

/**
 * banner样式
 */
public class BannerTheme <: MarkdownBaseTheme {
    public var bannerMarginTop: Float64 = 0.0 // banner上外边距
    public var bannerMarginRight: Float64 = 0.0 // banner右外边距
    public var bannerMarginBottom: Float64 = 0.0 // banner下外边距
    public var bannerMarginLeft: Float64 = 0.0 // banner左外边距
    public var bannerPaddingTop: Float64 = 0.0 // banner上内边距
    public var bannerPaddingRight: Float64 = 0.0 // banner右内边距
    public var bannerPaddingBottom: Float64 = 0.0 // banner下内边距
    public var bannerPaddingLeft: Float64 = 0.0 // banner左内边距
    public var bannerPlaceholder: ?AppResource = None // banner占位图

    /**
     * 统一设置banner整体外边距
     *
     * @param margin 外边距
     * @return 当前BannerTheme对象
     */
    public func setBannerMargin(margin: Float64): BannerTheme {
        this.bannerMarginTop = margin
        this.bannerMarginRight = margin
        this.bannerMarginBottom = margin
        this.bannerMarginLeft = margin
        return this
    }

    /**
     * 分别设置banner四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前BannerTheme对象
     */
    public func setBannerMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): BannerTheme {
        this.bannerMarginTop = top
        this.bannerMarginRight = right
        this.bannerMarginBottom = bottom
        this.bannerMarginLeft = left
        return this
    }

    /**
     * 统一设置banner整体内边距
     *
     * @param padding 内边距
     * @return 当前BannerTheme对象
     */
    public func setBannerPadding(padding: Float64): BannerTheme {
        this.bannerPaddingTop = padding
        this.bannerPaddingRight = padding
        this.bannerPaddingBottom = padding
        this.bannerPaddingLeft = padding
        return this
    }

    /**
     * 分别设置banner四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前BannerTheme对象
     */
    public func setBannerPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): BannerTheme {
        this.bannerPaddingTop = top
        this.bannerPaddingRight = right
        this.bannerPaddingBottom = bottom
        this.bannerPaddingLeft = left
        return this
    }

    /**
     * 设置banner占位图
     *
     * @param resource banner占位图
     * @return 当前BannerTheme对象
     */
    public func setBannerPlaceholder(resource: AppResource): BannerTheme {
        this.bannerPlaceholder = resource
        return this
    }
}