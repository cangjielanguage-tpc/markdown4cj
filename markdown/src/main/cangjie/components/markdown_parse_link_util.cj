package markdown.components

class MarkdownParseLinkUtil {
    static func linkStrToCirclePixelMap(strText: String, linkCircleIconTextSize: Float64, linkCircleIconRadius: Float64, markdownConfiguration: MarkdownConfiguration, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
            try (linkLoadLimiter = LinkLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                arr = drawCircleImageButton(
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
                var imageSource: ImageSource = createImageSource(arr())
                if (Thread.currentThread.hasPendingCancellation) {
                    imageSource.Release()
                    return
                }
                pixelMap = imageSource.createPixelMap()
                imageSource.Release()
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var size: Size = pixelMap().getImageInfo().size
                imageWidth = Float64(size.width)
                imageHeight = Float64(size.height)
                callback(pixelMap, imageHeight, imageWidth, arr)
            } catch (e: Exception) {
                callback(pixelMap, imageHeight, imageWidth, arr)
            }
        }
        return fut
    }

    static func linkStrToRectPixelMap(strText: String, linkRectIconTextSize: Float64, linkRectIconHeight: Float64, linkRectIconPadding: Float64, linkRectIconRadius: Float64, markdownConfiguration: MarkdownConfiguration, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
            try (linkLoadLimiter = LinkLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                arr = drawRectImageButton(
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
                var imageSource: ImageSource = createImageSource(arr())
                if (Thread.currentThread.hasPendingCancellation) {
                    imageSource.Release()
                    return
                }
                pixelMap = imageSource.createPixelMap()
                imageSource.Release()
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var size: Size = pixelMap().getImageInfo().size
                imageWidth = Float64(size.width)
                imageHeight = Float64(size.height)
                callback(pixelMap, imageHeight, imageWidth, arr)
            } catch (e: Exception) {
                callback(pixelMap, imageHeight, imageWidth, arr)
            }
        }
        return fut
    }

    static func linkStrToRectToolPixelMap(strText: String, strType: String, linkRectToolIconTextSize: Float64, linkRectToolIconHeight: Float64, linkRectToolIconPadding: Float64, linkRectToolIconBorderWidth: Float64, linkRectToolIconDividingLineWidth: Float64, linkRectToolIconLineLeftPadding: Float64, linkRectToolIconLineRightPadding: Float64, markdownConfiguration: MarkdownConfiguration, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
            try (linkLoadLimiter = LinkLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var c1 = typeStringColor(strType)[0]
                var c2 = typeStringColor(strType)[1]
                arr = drawRectToolImageButton(
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
                var imageSource: ImageSource = createImageSource(arr())
                if (Thread.currentThread.hasPendingCancellation) {
                    imageSource.Release()
                    return
                }
                pixelMap = imageSource.createPixelMap()
                imageSource.Release()
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var size: Size = pixelMap().getImageInfo().size
                imageWidth = Float64(size.width)
                imageHeight = Float64(size.height)
                callback(pixelMap, imageHeight, imageWidth, arr)
            } catch (e: Exception) {
                callback(pixelMap, imageHeight, imageWidth, arr)
            }
        }
        return fut
    }
}

let semaphoreLink: Semaphore = Semaphore(1)

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
