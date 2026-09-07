package markdown.components

class MarkdownParseImageUtil {
    /**
     * 本地图片路径转换成PixelMap (./或../开头)
     * 对齐ArkUI实现：剥离./、../前缀后按rawfile根路径加载
     *
     * @param destination 图片路径
     * @param uiAbilityContext UIAbilityContext
     * @param stageContext StageContext
     * @param callback PixelMap图片、图片高度、图片宽度
     * @return Future<Unit> 线程
     */
    static func rawfileToPixelmap(
        destination: String,
        uiAbilityContext: ?UIAbilityContext,
        stageContext: ?StageContext,
        callback: (?PixelMap, ?Float64, ?Float64) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var height: ?Float64 = Option<Float64>.None
            var width: ?Float64 = Option<Float64>.None
            var imageSource: ?ImageSource = Option<ImageSource>.None
            try (imageLoadLimiter = ImageLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
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
                    var arrayUInt8: Array<UInt8> = v.getRawFileContent(resolveRawfilePath(destination))
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    imageSource = createImageSource(arrayUInt8)
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
                        var size = p.getImageInfo().size
                        width = Float64(size.width)
                        height = Float64(size.height)
                    }
                }
            } catch (e: Exception) {
                pixelMap?.Release()
                pixelMap = Option<PixelMap>.None
            } finally {
                imageSource?.Release()
                imageSource = Option<ImageSource>.None
            }
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap?.Release()
                pixelMap = Option<PixelMap>.None
                return
            }
            callback(pixelMap, width, height)
        }
        return fut
    }

    /**
     * 解析本地图片的rawfile路径
     * 剥离路径中的./、../相对段，按rawfile根路径解析（对齐ArkUI的$rawfile(url.substring(2))行为）
     *
     * @param destination 图片相对路径
     * @return rawfile路径
     */
    static func resolveRawfilePath(destination: String): String {
        let stack = ArrayList<String>()
        for (p in destination.split("/")) {
            if (p == "" || p == ".") {
                continue
            }
            if (p == "..") {
                if (stack.size > 0) {
                    stack.remove(at: stack.size - 1)
                }
            } else {
                stack.add(p)
            }
        }
        let sb = StringBuilder()
        for (i in 0..stack.size) {
            if (i > 0) {
                sb.append("/")
            }
            sb.append(stack[i])
        }
        return sb.toString()
    }

    /**
     * 图片替换
     *
     * @param destination 图片路径
     * @param imageReplaceCallback 替换接口
     * @param callback PixelMap图片、图片高度、图片宽度
     * @return Future<Unit> 线程
     */
    static func callbackToPixelmap(
        destination: String,
        imageReplaceCallback: (String) -> ?Array<UInt8>,
        callback: (?PixelMap, ?Float64, ?Float64) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var height: ?Float64 = Option<Float64>.None
            var width: ?Float64 = Option<Float64>.None
            var imageSource: ?ImageSource = Option<ImageSource>.None
            try (imageLoadLimiter = ImageLoadLimiter()) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                let data: ?Array<UInt8> = imageReplaceCallback(destination)
                if (let Some(v) <- data) {
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    imageSource = createImageSource(v)
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
                        var size = p.getImageInfo().size
                        width = Float64(size.width)
                        height = Float64(size.height)
                    }
                }
            } catch (e: Exception) {
                pixelMap?.Release()
                pixelMap = Option<PixelMap>.None
            } finally {
                imageSource?.Release()
                imageSource = Option<ImageSource>.None
            }
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap?.Release()
                pixelMap = Option<PixelMap>.None
                return
            }
            callback(pixelMap, width, height)
        }
        return fut
    }

    /**
     * AppResource占位图转换成PixelMap
     *
     * @param imagePlaceholder 占位图图片
     * @param uiAbilityContext UIAbilityContext
     * @param stageContext StageContext
     * @param callback PixelMap图片、图片高度、图片宽度
     * @return Future<Unit> 线程
     */
    static func resourceToPixelmap(
        imagePlaceholder: AppResource,
        uiAbilityContext: ?UIAbilityContext,
        stageContext: ?StageContext,
        callback: (?PixelMap, ?Float64, ?Float64) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            var pixelMap: ?PixelMap = Option<PixelMap>.None
            var height: ?Float64 = Option<Float64>.None
            var width: ?Float64 = Option<Float64>.None
            var imageSource: ?ImageSource = Option<ImageSource>.None
            try (imageLoadLimiter = ImageLoadLimiter()) {
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
                    var arrayUInt8: Array<UInt8> = v.getMediaContent(imagePlaceholder, 0)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    imageSource = createImageSource(arrayUInt8)
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
                        var size = p.getImageInfo().size
                        width = Float64(size.width)
                        height = Float64(size.height)
                    }
                }
            } catch (e: Exception) {
                pixelMap?.Release()
                pixelMap = Option<PixelMap>.None
            } finally {
                imageSource?.Release()
                imageSource = Option<ImageSource>.None
            }
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap?.Release()
                pixelMap = Option<PixelMap>.None
                return
            }
            callback(pixelMap, width, height)
        }
        return fut
    }
}

let semaphoreImage: Semaphore = Semaphore(50)

class ImageLoadLimiter <: Resource {
    let closed = AtomicBool(false)

    init() {
        semaphoreImage.acquire()
    }

    public override func isClosed(): Bool {
        return closed.load()
    }

    public override func close(): Unit {
        if (isClosed()) {
            return
        }
        semaphoreImage.release()
        closed.store(true)
    }
}
