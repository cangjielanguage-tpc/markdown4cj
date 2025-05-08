/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class MarkdownParseLinkUtil {
    static func linkStrToCirclePixelMap(strText: String, markdownAIConfiguration: MarkdownAIConfiguration,
        callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            arr = drawCircleImageButton(strText, markdownAIConfiguration.markdownAITheme.linkCircleImageTextSize,
                markdownAIConfiguration.markdownAITheme.linkCircleImageTextColor.toUInt32(),
                markdownAIConfiguration.markdownAITheme.linkCircleImageButtonBackGroupColor.toUInt32(),
                markdownAIConfiguration.markdownAITheme.linkCircleImageBackGroupColor.toUInt32(),
                markdownAIConfiguration.markdownAITheme.linkCircleImageRadius, ColorFormatEnum.COLOR_FORMAT_BGRA_8888)
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
        }
        return fut
    }

    static func linkStrToRectPixelMap(strText: String, markdownAIConfiguration: MarkdownAIConfiguration,
        callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            arr = drawRectImageButton(strText, markdownAIConfiguration.markdownAITheme.linkRectImageTextSize,
                markdownAIConfiguration.markdownAITheme.linkRectImageTextColor.toUInt32(),
                markdownAIConfiguration.markdownAITheme.linkRectImageButtonBackGroupColor.toUInt32(),
                markdownAIConfiguration.markdownAITheme.linkRectImageBackGroupColor.toUInt32(),
                markdownAIConfiguration.markdownAITheme.linkRectImageHeight, ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                markdownAIConfiguration.markdownAITheme.linkRectImagePadding,
                markdownAIConfiguration.markdownAITheme.linkRectImageRadius)
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
        }
        return fut
    }

    static func linkStrToRectToolPixelMap(strText: String, strType: String, markdownAIConfiguration: MarkdownAIConfiguration,
        callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            arr = drawRectToolImageButton(strText,strType,
                markdownAIConfiguration.markdownAITheme.linkRectToolImageTextSize,
                markdownAIConfiguration.markdownAITheme.linkRectToolImageTextColor.toUInt32(),
                markdownAIConfiguration.markdownAITheme.linkRectToolImageButtonBackGroupColor.toUInt32(),
                markdownAIConfiguration.markdownAITheme.linkRectToolImageBackGroupColor.toUInt32(),
                markdownAIConfiguration.markdownAITheme.linkRectToolImageButtonBorderColor.toUInt32(),
                markdownAIConfiguration.markdownAITheme.linkRectToolImageBorderWidth,
                markdownAIConfiguration.markdownAITheme.linkRectToolImageButtonDividingLineColor.toUInt32(),
                markdownAIConfiguration.markdownAITheme.linkRectToolImageDividingLineWidth,
                markdownAIConfiguration.markdownAITheme.linkRectToolImageHeight, ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                markdownAIConfiguration.markdownAITheme.linkRectToolImagePadding)
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
        }
        return fut
    }
}
