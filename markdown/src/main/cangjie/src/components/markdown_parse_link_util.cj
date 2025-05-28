/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class MarkdownParseLinkUtil {
    static func linkStrToCirclePixelMap(strText: String, markdownConfiguration: MarkdownConfiguration,
        callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit, backGroupColor: Color): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            arr = drawCircleImageButton(
                strText,
                markdownConfiguration.markdownTheme.linkCircleImageTextSize,
                markdownConfiguration.markdownTheme.linkCircleImageTextColor.toUInt32(),
                markdownConfiguration.markdownTheme.linkCircleImageButtonBackGroupColor.toUInt32(),
                backGroupColor.toUInt32(),
                markdownConfiguration.markdownTheme.linkCircleImageRadius,
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
        }
        return fut
    }

    static func linkStrToRectPixelMap(strText: String, markdownConfiguration: MarkdownConfiguration,
        callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit, backGroupColor: Color): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            arr = drawRectImageButton(
                strText,
                markdownConfiguration.markdownTheme.linkRectImageTextSize,
                markdownConfiguration.markdownTheme.linkRectImageTextColor.toUInt32(),
                markdownConfiguration.markdownTheme.linkRectImageButtonBackGroupColor.toUInt32(),
                backGroupColor.toUInt32(),
                markdownConfiguration.markdownTheme.linkRectImageHeight,
                ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                markdownConfiguration.markdownTheme.linkRectImagePadding,
                markdownConfiguration.markdownTheme.linkRectImageRadius
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
        }
        return fut
    }

    static func linkStrToRectToolPixelMap(strText: String, strType: String,
        markdownConfiguration: MarkdownConfiguration, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit, backGroupColor: Color): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var imageHeight: ?Float64 = Option<Float64>.None
            var imageWidth: ?Float64 = Option<Float64>.None
            var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            var c1 = typeStringColor(strType)[0]
            var c2 = typeStringColor(strType)[1]
            arr = drawRectToolImageButton(
                strText,
                strType,
                markdownConfiguration.markdownTheme.linkRectToolImageTextSize,
                c1.toUInt32(),
                markdownConfiguration.markdownTheme.linkRectToolImageButtonBackGroupColor.toUInt32(),
                backGroupColor.toUInt32(),
                c1.toUInt32(),
                markdownConfiguration.markdownTheme.linkRectToolImageBorderWidth,
                c2.toUInt32(),
                markdownConfiguration.markdownTheme.linkRectToolImageDividingLineWidth,
                markdownConfiguration.markdownTheme.linkRectToolImageHeight,
                ColorFormatEnum.COLOR_FORMAT_BGRA_8888,
                markdownConfiguration.markdownTheme.linkRectToolImagePadding,
                markdownConfiguration.markdownTheme.linkRectToolImageLineLeftPadding,
                markdownConfiguration.markdownTheme.linkRectToolImageLineRightPadding
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
        }
        return fut
    }
}
