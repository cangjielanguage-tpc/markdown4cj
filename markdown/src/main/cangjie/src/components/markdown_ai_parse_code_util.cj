/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class MarkdownParseCodeUtil {
    static func codeStrToRectPixelMap(strText: String, markdownAIConfiguration: MarkdownAIConfiguration, isFakeBoldText: Bool, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
            try (codeLoadLimiter = CodeLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                arr = drawRectImageButton(
                    strText,
                    markdownAIConfiguration.markdownAITheme.codeTextSize,
                    markdownAIConfiguration.markdownAITheme.codeTextColor.toUInt32(),
                    markdownAIConfiguration.markdownAITheme.codeBackgroundColor.toUInt32(),
                    markdownAIConfiguration.markdownAITheme.codeBackgroundColor.toUInt32(),
                    markdownAIConfiguration.markdownAITheme.codeHeight,
                    ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                    markdownAIConfiguration.markdownAITheme.codeLeftAndRightPadding,
                    0.0,
                    isFakeBoldText
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

let codeSemaphore: Semaphore = Semaphore(1)

class CodeLoadLimiter <: Resource {
    let closed = AtomicBool(false)

    init() {
        codeSemaphore.acquire()
    }

    public override func isClosed(): Bool {
        return closed.load()
    }

    public override func close(): Unit {
        if (isClosed()) {
            return
        }
        codeSemaphore.release()
        closed.store(true)
    }
}
