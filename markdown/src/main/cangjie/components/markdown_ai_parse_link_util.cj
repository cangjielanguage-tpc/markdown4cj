/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class MarkdownParseLinkUtil {
    static func linkStrToCirclePixelMap(strText: String, markdownAIConfiguration: MarkdownAIConfiguration, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit, backGroupColor: Color): Future<Unit> {
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
                    markdownAIConfiguration.markdownAITheme.linkCircleImageTextSize,
                    markdownAIConfiguration.markdownAITheme.linkCircleImageTextColor.toUInt32(),
                    markdownAIConfiguration.markdownAITheme.linkCircleImageButtonBackGroupColor.toUInt32(),
                    backGroupColor.toUInt32(),
                    markdownAIConfiguration.markdownAITheme.linkCircleImageRadius,
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

    static func linkStrToRectPixelMap(strText: String, markdownAIConfiguration: MarkdownAIConfiguration, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit, backGroupColor: Color): Future<Unit> {
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
                    markdownAIConfiguration.markdownAITheme.linkRectImageTextSize,
                    markdownAIConfiguration.markdownAITheme.linkRectImageTextColor.toUInt32(),
                    markdownAIConfiguration.markdownAITheme.linkRectImageButtonBackGroupColor.toUInt32(),
                    backGroupColor.toUInt32(),
                    markdownAIConfiguration.markdownAITheme.linkRectImageHeight,
                    ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                    markdownAIConfiguration.markdownAITheme.linkRectImagePadding,
                    markdownAIConfiguration.markdownAITheme.linkRectImageRadius,
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

    static func linkStrToRectToolPixelMap(strText: String, strType: String, markdownAIConfiguration: MarkdownAIConfiguration, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit, backGroupColor: Color): Future<Unit> {
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
                    markdownAIConfiguration.markdownAITheme.linkRectToolImageTextSize,
                    c1.toUInt32(),
                    markdownAIConfiguration.markdownAITheme.linkRectToolImageButtonBackGroupColor.toUInt32(),
                    backGroupColor.toUInt32(),
                    c1.toUInt32(),
                    markdownAIConfiguration.markdownAITheme.linkRectToolImageBorderWidth,
                    c2.toUInt32(),
                    markdownAIConfiguration.markdownAITheme.linkRectToolImageDividingLineWidth,
                    markdownAIConfiguration.markdownAITheme.linkRectToolImageHeight,
                    ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                    markdownAIConfiguration.markdownAITheme.linkRectToolImagePadding,
                    markdownAIConfiguration.markdownAITheme.linkRectToolImageLineLeftPadding,
                    markdownAIConfiguration.markdownAITheme.linkRectToolImageLineRightPadding
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
