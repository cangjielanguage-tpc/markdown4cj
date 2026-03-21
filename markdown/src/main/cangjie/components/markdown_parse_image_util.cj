/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

/**
 * 本地图片路径转换成PixelMap (./开头)
 *
 * @param destination 图片路径
 * @param uiAbilityContext UIAbilityContext
 * @param stageContext StageContext
 * @param callback PixelMap图片、图片高度、图片宽度
 * @return Future<Unit> 线程
 */
func rawfileToPixelmap1(
    destination: String,
    uiAbilityContext: ?UIAbilityContext,
    stageContext: ?StageContext,
    callback: (?PixelMap, ?Float64, ?Float64) -> Unit
): Future<Unit> {
    let fut: Future<Unit> = spawn {
        var pixelMap: ?PixelMap = Option<PixelMap>.None
        var height: ?Float64 = Option<Float64>.None
        var width: ?Float64 = Option<Float64>.None
        try (imageLoadLimiter = ImageLoadLimiter()) {
            if (Thread
            .currentThread.hasPendingCancellation) {
                return
            }
            var resourceManager: ?ResourceManager = None
            if (let Some(v) <- uiAbilityContext) {
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
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.Release()
                    return
                }
                var size = pixelMap().getImageInfo().size
                width = Float64(size.width)
                height = Float64(size.height)
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

/**
 * 图片替换
 *
 * @param destination 图片路径
 * @param imageCallbackCallback 替换接口
 * @param callback PixelMap图片、图片高度、图片宽度
 * @return Future<Unit> 线程
 */
func callbackToPixelmap(
    destination: String,
    imageCallbackCallback: (String) -> ?Array<UInt8>,
    callback: (?PixelMap, ?Float64, ?Float64) -> Unit
): Future<Unit> {
    let fut: Future<Unit> = spawn {
        var pixelMap: ?PixelMap = Option<PixelMap>.None
        var height: ?Float64 = Option<Float64>.None
        var width: ?Float64 = Option<Float64>.None
        try (imageLoadLimiter = ImageLoadLimiter()) {
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let data: ?Array<UInt8> = imageCallbackCallback(destination)
            if (let Some(v) <- data) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var imageSource: ImageSource = createImageSource(v)
                if (Thread.currentThread.hasPendingCancellation) {
                    imageSource.Release()
                    return
                }
                pixelMap = imageSource.createPixelMap()
                imageSource.Release()
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap?.Release()
                    return
                }
                var size = pixelMap().getImageInfo().size
                width = Float64(size.width)
                height = Float64(size.height)
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
