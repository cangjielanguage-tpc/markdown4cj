/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.arkui.state_macro_manage.*

class MarkdownParseLinkUtil {
    static func linkStrToCirclePixelMap(linkCircleImageTextSize: Float64, linkCircleImageRadius: Float64, strText: String, markdownConfiguration: MarkdownConfiguration, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
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
                    linkCircleImageTextSize,
                    markdownConfiguration.markdownTheme.linkCircleImageTextColor.toUInt32(),
                    markdownConfiguration.markdownTheme.linkCircleImageButtonBackGroupColor.toUInt32(),
                    markdownConfiguration.markdownTheme.linkCircleImageBackGroupColor.toUInt32(),
                    linkCircleImageRadius,
                    ColorFormatEnum.COLOR_FORMAT_BGRA_8888
                )
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var imageSource: ImageSource = createImageSource(arr())
                if (Thread.currentThread.hasPendingCancellation) {
                    imageSource.release()
                    return
                }
                pixelMap = imageSource.createPixelMap()
                imageSource.release()
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var size = pixelMap().getImageInfo().size
                imageWidth = Float64(size.width)
                imageHeight = Float64(size.height)
                callback(pixelMap, imageHeight, imageWidth, arr)
            } catch (e: Exception) {
                callback(pixelMap, imageHeight, imageWidth, arr)
            }
        }
        return fut
    }

    static func linkStrToRectPixelMap(linkRectImageTextSize: Float64, linkRectImageHeight: Float64, linkRectImagePadding: Float64, linkRectImageRadius: Float64, strText: String, markdownConfiguration: MarkdownConfiguration, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
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
                    linkRectImageTextSize,
                    markdownConfiguration.markdownTheme.linkRectImageTextColor.toUInt32(),
                    markdownConfiguration.markdownTheme.linkRectImageButtonBackGroupColor.toUInt32(),
                    markdownConfiguration.markdownTheme.linkRectImageBackGroupColor.toUInt32(),
                    linkRectImageHeight,
                    ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                    linkRectImagePadding,
                    linkRectImageRadius,
                    false
                )
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var imageSource: ImageSource = createImageSource(arr())
                if (Thread.currentThread.hasPendingCancellation) {
                    imageSource.release()
                    return
                }
                pixelMap = imageSource.createPixelMap()
                imageSource.release()
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var size = pixelMap().getImageInfo().size
                imageWidth = Float64(size.width)
                imageHeight = Float64(size.height)
                callback(pixelMap, imageHeight, imageWidth, arr)
            } catch (e: Exception) {
                callback(pixelMap, imageHeight, imageWidth, arr)
            }
        }
        return fut
    }

    static func linkStrToRectToolPixelMap(linkRectToolImageTextSize: Float64, linkRectToolImageHeight: Float64, linkRectToolImagePadding: Float64, linkRectToolImageBorderWidth: Float64, linkRectToolImageDividingLineWidth: Float64, linkRectToolImageLineLeftPadding: Float64, linkRectToolImageLineRightPadding: Float64, strText: String, strType: String, markdownConfiguration: MarkdownConfiguration, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
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
                    linkRectToolImageTextSize,
                    c1.toUInt32(),
                    markdownConfiguration.markdownTheme.linkRectToolImageButtonBackGroupColor.toUInt32(),
                    markdownConfiguration.markdownTheme.linkRectToolImageBackGroupColor.toUInt32(),
                    c1.toUInt32(),
                    linkRectToolImageBorderWidth,
                    c2.toUInt32(),
                    linkRectToolImageDividingLineWidth,
                    linkRectToolImageHeight,
                    ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                    linkRectToolImagePadding,
                    linkRectToolImageLineLeftPadding,
                    linkRectToolImageLineRightPadding
                )
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var imageSource: ImageSource = createImageSource(arr())
                if (Thread.currentThread.hasPendingCancellation) {
                    imageSource.release()
                    return
                }
                pixelMap = imageSource.createPixelMap()
                imageSource.release()
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var size = pixelMap().getImageInfo().size
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
