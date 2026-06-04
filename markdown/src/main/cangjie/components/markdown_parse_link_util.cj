package markdown.components

class MarkdownParseLinkUtil {
    /**
     * 链接文本转换成链接图片 - 圆形
     *
     * @param strText 链接文本
     * @param linkCircleIconTextSize 链接文本大小 - 单位px
     * @param linkCircleIconRadius 链接圆角大小 - 单位px
     * @param markdownConfiguration MarkdownConfiguration
     * @param callback 回调接口 - PixelMap图片、图片高度、图片宽度
     * @return 线程
     */
    static func linkStrToCirclePixelMap(
        strText: String,
        linkCircleIconTextSize: Float64,
        linkCircleIconRadius: Float64,
        markdownConfiguration: MarkdownConfiguration,
        callback: (?PixelMap, ?Float64, ?Float64) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var imageSource: ?ImageSource = Option<ImageSource>.None
            try (linkLoadLimiter = LinkLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                let arr = drawCircleImageButton(
                    strText,
                    linkCircleIconTextSize,
                    markdownConfiguration.markdownTheme.linkTheme.linkCircleIconTextColor.toUInt32(),
                    markdownConfiguration.markdownTheme.linkTheme.linkCircleIconButtonBackgroundColor.toUInt32(),
                    markdownConfiguration.markdownTheme.linkTheme.linkCircleIconBackgroundColor.toUInt32(),
                    linkCircleIconRadius,
                    ColorFormatEnum.COLOR_FORMAT_BGRA_8888
                )
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                imageSource = createImageSource(arr)
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                pixelMap = imageSource?.createPixelMap()
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.Release()
                    pixelMap = Option<PixelMap>.None
                    return
                }
                if (let Some(p) <- pixelMap) {
                    var size: Size = p.getImageInfo().size
                    imageWidth = Float64(size.width)
                    imageHeight = Float64(size.height)
                }
            } catch (e: Exception) {
                pixelMap?.Release()
                pixelMap = Option<PixelMap>.None
            } finally {
                imageSource?.Release()
                imageSource = Option<ImageSource>.None
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.Release()
                    pixelMap = Option<PixelMap>.None
                    return
                }
            }
            callback(pixelMap, imageHeight, imageWidth)
        }
        return fut
    }

    /**
     * 链接文本转换成链接图片 - 圆角矩形
     *
     * @param strText 链接文本
     * @param linkCircleIconTextSize 链接文本大小 - 单位px
     * @param linkRectIconHeight 高度大小 - 单位px
     * @param linkRectIconPadding 内边距大小 - 单位px
     * @param linkCircleIconRadius 链接圆角大小 - 单位px
     * @param markdownConfiguration MarkdownConfiguration
     * @param callback 回调接口 - PixelMap图片、图片高度、图片宽度
     * @return 线程
     */
    static func linkStrToRectPixelMap(
        strText: String,
        linkRectIconTextSize: Float64,
        linkRectIconHeight: Float64,
        linkRectIconPadding: Float64,
        linkRectIconRadius: Float64,
        markdownConfiguration: MarkdownConfiguration,
        callback: (?PixelMap, ?Float64, ?Float64) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var imageSource: ?ImageSource = Option<ImageSource>.None
            try (linkLoadLimiter = LinkLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                let arr = drawRectImageButton(
                    strText,
                    linkRectIconTextSize,
                    markdownConfiguration.markdownTheme.linkTheme.linkRectIconTextColor.toUInt32(),
                    markdownConfiguration.markdownTheme.linkTheme.linkRectIconButtonBackgroundColor.toUInt32(),
                    markdownConfiguration.markdownTheme.linkTheme.linkRectIconBackgroundColor.toUInt32(),
                    linkRectIconHeight,
                    ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                    linkRectIconPadding,
                    linkRectIconRadius,
                    false
                )
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                imageSource = createImageSource(arr)
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                pixelMap = imageSource?.createPixelMap()
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.Release()
                    pixelMap = Option<PixelMap>.None
                    return
                }
                if (let Some(p) <- pixelMap) {
                    var size: Size = p.getImageInfo().size
                    imageWidth = Float64(size.width)
                    imageHeight = Float64(size.height)
                }
            } catch (e: Exception) {
                pixelMap?.Release()
                pixelMap = Option<PixelMap>.None
            } finally {
                imageSource?.Release()
                imageSource = Option<ImageSource>.None
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.Release()
                    pixelMap = Option<PixelMap>.None
                    return
                }
            }
            callback(pixelMap, imageHeight, imageWidth)
        }
        return fut
    }

    /**
     * 链接文本转换成链接图片 - 空心圆角矩形
     *
     * @param strText 链接文本
     * @param strType 链接类型
     * @param linkRectToolIconTextSize 链接文本大小 - 单位px
     * @param linkRectToolIconHeight 高度大小 - 单位px
     * @param linkRectToolIconPadding 内边距大小 - 单位px
     * @param linkRectToolIconBorderWidth 边框宽度大小 - 单位px
     * @param linkRectToolIconDividingLineWidth 分割线宽度大小 - 单位px
     * @param linkRectToolIconLineLeftPadding 左内边距大小 - 单位px
     * @param linkRectToolIconLineRightPadding 右内边距大小 - 单位px
     * @param markdownConfiguration MarkdownConfiguration
     * @param callback 回调接口 - PixelMap图片、图片高度、图片宽度
     * @return 线程
     */
    static func linkStrToRectToolPixelMap(
        strText: String,
        strType: String,
        linkRectToolIconTextSize: Float64,
        linkRectToolIconHeight: Float64,
        linkRectToolIconPadding: Float64,
        linkRectToolIconBorderWidth: Float64,
        linkRectToolIconDividingLineWidth: Float64,
        linkRectToolIconLineLeftPadding: Float64,
        linkRectToolIconLineRightPadding: Float64,
        markdownConfiguration: MarkdownConfiguration,
        callback: (?PixelMap, ?Float64, ?Float64) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var imageSource: ?ImageSource = Option<ImageSource>.None
            try (linkLoadLimiter = LinkLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var c1 = typeStringColor(strType)[0]
                var c2 = typeStringColor(strType)[1]
                let arr = drawRectToolImageButton(
                    strText,
                    strType,
                    linkRectToolIconTextSize,
                    c1.toUInt32(),
                    markdownConfiguration.markdownTheme.linkTheme.linkRectToolIconButtonBackgroundColor.toUInt32(),
                    markdownConfiguration.markdownTheme.linkTheme.linkRectToolIconBackgroundColor.toUInt32(),
                    c1.toUInt32(),
                    linkRectToolIconBorderWidth,
                    c2.toUInt32(),
                    linkRectToolIconDividingLineWidth,
                    linkRectToolIconHeight,
                    ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                    linkRectToolIconPadding,
                    linkRectToolIconLineLeftPadding,
                    linkRectToolIconLineRightPadding
                )
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                imageSource = createImageSource(arr)
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                pixelMap = imageSource?.createPixelMap()
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.Release()
                    pixelMap = Option<PixelMap>.None
                    return
                }
                if (let Some(p) <- pixelMap) {
                    var size: Size = p.getImageInfo().size
                    imageWidth = Float64(size.width)
                    imageHeight = Float64(size.height)
                }
            } catch (e: Exception) {
                pixelMap?.Release()
                pixelMap = Option<PixelMap>.None
            } finally {
                imageSource?.Release()
                imageSource = Option<ImageSource>.None
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.Release()
                    pixelMap = Option<PixelMap>.None
                    return
                }
            }
            callback(pixelMap, imageHeight, imageWidth)
        }
        return fut
    }
}

let semaphoreLink: Semaphore = Semaphore(50)

class LinkLoadLimiter <: Resource {
    let closed = AtomicBool(false)

    init() {
        semaphoreLink.acquire()
    }

    public override func isClosed(): Bool {
        return closed.load()
    }

    public override func close(): Unit {
        if (isClosed()) {
            return
        }
        semaphoreLink.release()
        closed.store(true)
    }
}
