/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJMarkdownBannerTheme {
    /**
     * banner上外边距
     */
    var bannerMarginTop: ?Float64 = None

    /**
     * banner右外边距
     */
    var bannerMarginRight: ?Float64 = None

    /**
     * banner下外边距
     */
    var bannerMarginBottom: ?Float64 = None

    /**
     * banner左外边距
     */
    var bannerMarginLeft: ?Float64 = None

    /**
     * banner上内边距
     */
    var bannerPaddingTop: ?Float64 = None

    /**
     * banner右内边距
     */
    var bannerPaddingRight: ?Float64 = None

    /**
     * banner下内边距
     */
    var bannerPaddingBottom: ?Float64 = None

    /**
     * banner左内边距
     */
    var bannerPaddingLeft: ?Float64 = None

    public init() {}

    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     */
    public func setBannerAllMargin(margin: Float64): Unit {
        bannerMarginTop = margin
        bannerMarginRight = margin
        bannerMarginBottom = margin
        bannerMarginLeft = margin
    }

    /**
     * 分别设置4个外边距
     *
     * @param top-上外边距 命名参数
     * @param right-右外边距 命名参数
     * @param bottom-下外边距 命名参数
     * @param left-左外边距 命名参数
     */
    public func setBannerMargin(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        bannerMarginTop = top
        bannerMarginRight = right
        bannerMarginBottom = bottom
        bannerMarginLeft = left
    }

    /**
     * 设置4个内边距为统一值
     *
     * @param padding 内边距
     */
    public func setBannerAllPadding(padding: Float64): Unit {
        bannerPaddingTop = padding
        bannerPaddingRight = padding
        bannerPaddingBottom = padding
        bannerPaddingLeft = padding
    }

    /**
     * 分别设置4个内边距
     *
     * @param top-上内边距 命名参数
     * @param right-右内边距 命名参数
     * @param bottom-下内边距 命名参数
     * @param left-左内边距 命名参数
     */
    public func setBannerPadding(top!: Float64, right!: Float64, bottom!: Float64, left!: Float64): Unit {
        bannerPaddingTop = top
        bannerPaddingRight = right
        bannerPaddingBottom = bottom
        bannerPaddingLeft = left
    }
}
