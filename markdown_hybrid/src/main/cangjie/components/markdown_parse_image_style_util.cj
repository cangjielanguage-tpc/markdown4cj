/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

/**
 * 本地图片路径转换成PixelMap (./开头)
 *
 * @param destination 图片路径
 * @param context Context
 * @param componentWidth 控件宽度 - 单位vp
 * @param callback PixelMap图片、图片高度、图片宽度 回调接口
 */
func rawfileToPixelmapStyle(destination: String, context: ?Context, componentWidth: Float64, w: ?Float64, h: ?Float64, callback: (?PixelMap, ?Float64, ?Float64) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        var pixelMap: ?PixelMap = Option<PixelMap>.None
        var height: ?Float64 = Option<Float64>.None
        var width: ?Float64 = Option<Float64>.None
        try (imageLoadLimiter = ImageLoadLimiter()) {
            var resourceManager: ?ResourceManager = None
            if (let Some(v) <- context) {
                resourceManager = v.resourceManager
            }
            if (let Some(v) <- resourceManager) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var arrayUInt8: Array<UInt8> = v.getRawFileContent(destination.replace("./", ""))
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var imageSource: ImageSource = createImageSource(arrayUInt8)
                if (Thread.currentThread.hasPendingCancellation) {
                    imageSource.release()
                    return
                }
                pixelMap = imageSource.createPixelMap()
                imageSource.release()
                var size = pixelMap().getImageInfo().size
                var sizeWidth: Float64 = Float64(size.width)
                var sizeHeight: Float64 = Float64(size.height)
                var aspectRatio: Float64 = sizeHeight / sizeWidth
                let widthNew = if (componentWidth > sizeWidth) {
                    sizeWidth
                } else {
                    componentWidth
                }
                let heightNew = widthNew * aspectRatio
                if (w.isSome() && h.isSome()) {
                    let aspectRatioNew: Float64 = h() / w()
                    width = if (componentWidth > w()) {
                        w()
                    } else {
                        componentWidth
                    }
                    height = width() * aspectRatioNew
                } else if (w.isSome() && h.isNone()) {
                    width = if (componentWidth > w()) {
                        w()
                    } else {
                        componentWidth
                    }
                    height = width() * aspectRatio
                } else if (w.isNone() && h.isSome()) {
                    width = if (componentWidth > h() / aspectRatio) {
                        h() / aspectRatio
                    } else {
                        componentWidth
                    }
                    height = width() * aspectRatio
                } else {
                    width = widthNew
                    height = heightNew
                }
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.release()
                    return
                }
                pixelMap?.scale(Float32(width() / sizeWidth), Float32(height() / sizeHeight))
            }
        } catch (e: Exception) {
        } finally {
            try {
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.release()
                    return
                }
                callback(pixelMap, width, height)
            } catch (_) {
            }
        }
    }
    return fut
}
