/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 本地图片路径转换成PixelMap (./开头)
 *
 * @param destination 图片路径
 * @param abilityContext AbilityContext
 * @param stageContext StageContext
 * @param componentWidth 控件宽度 - 单位px
 * @param callback PixelMap图片、图片高度、图片宽度 回调接口
 */
func rawfileToPixelmap(destination: String, abilityContext: ?AbilityContext, stageContext: ?StageContext, componentWidth: Float64, callback: (?PixelMap, ?Float64, ?Float64) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        var pixelMap: ?PixelMap = Option<PixelMap>.None
        var height: ?Float64 = Option<Float64>.None
        var width: ?Float64 = Option<Float64>.None
        try (imageLoadLimiter = ImageLoadLimiter()) {
            var resourceManager: ?ResourceManager = None
            if (let Some(v) <- abilityContext) {
                resourceManager = ResourceManager.getResourceManager(getStageContext(v))
            } else {
                if (let Some(v) <- stageContext) {
                    resourceManager = ResourceManager.getResourceManager(v)
                }
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
                    imageSource.Release()
                    return
                }
                pixelMap = imageSource.createPixelMap()
                imageSource.Release()
                var size: Size = pixelMap().getImageInfo().size
                var sizeWidth: Float64 = Float64(size.width)
                var sizeHeight: Float64 = Float64(size.height)
                var aspectRatio: Float64 = sizeHeight / sizeWidth
                width = if (componentWidth > sizeWidth) {
                    sizeWidth
                } else {
                    componentWidth
                }
                height = width() * aspectRatio
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.Release()
                    return
                }
                pixelMap?.scale(Float32(width() / sizeWidth), Float32(height() / sizeHeight))
            }
        } catch (e: Exception) {
        } finally {
            try {
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.Release()
                    return
                }
                callback(pixelMap, width, height)
            } catch (_) {
            }
        }
    }
    return fut
}

let semaphore: Semaphore = Semaphore(50)

class ImageLoadLimiter <: Resource {
    let closed = AtomicBool(false)

    init() {
        semaphore.acquire()
    }

    public override func isClosed(): Bool {
        return closed.load()
    }

    public override func close(): Unit {
        if (isClosed()) {
            return
        }
        semaphore.release()
        closed.store(true)
    }
}
