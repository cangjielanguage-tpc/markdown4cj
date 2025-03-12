/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.ark_interop_helper.*

/**
 * 本地图片路径转换成PixelMap (file:开头)
 *
 * @param destination 图片路径
 * @param componentWidth 控件宽度 - 单位vp
 * @param callback PixelMap图片、图片高度、图片宽度 回调接口
 */
func imageSpanToPixelmapStyle(destination: String, componentWidth: Float64, w: ?Float64, h: ?Float64, callback: (?Float64, ?Float64) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        var height: ?Float64 = Option<Float64>.None
        var width: ?Float64 = Option<Float64>.None
        try (imageLoadLimiter = ImageLoadLimiter()) {
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            var imageSource: ImageSource = createImageSource(destination)
            if (Thread.currentThread.hasPendingCancellation) {
                imageSource.Release()
                return
            }
            var size: Size = imageSource.getImageInfo().size
            if (Thread.currentThread.hasPendingCancellation) {
                imageSource.Release()
                return
            }
            imageSource.Release()
            var sizeWidth: Float64 = Float64(size.width)
            var sizeHeight: Float64 = Float64(size.height)
            var aspectRatio: Float64 = sizeHeight / sizeWidth
            var sizeWidthNew: Float64 = if(let Some(v) <- w){
                v
            }else{
                sizeWidth
            }
            var sizeHeightNew: Float64 = if(let Some(v) <- h){
                v
            }else{
                sizeHeight
            }
            if(w.isSome() && h.isSome()){

                width = if (componentWidth > sizeWidthNew) {
                    sizeWidthNew
                } else {
                    componentWidth
                }
                height = h()
            }else if (w.isSome() && h.isNone()){
                width = if (componentWidth > sizeWidthNew) {
                    sizeWidthNew
                } else {
                    componentWidth
                }
                height = if(let Some(v) <- h){
                    v
                }else{
                    width() * aspectRatio
                }
            } else if (w.isNone() && h.isSome()){
                height = h()
                width = if (componentWidth > height()/aspectRatio) {
                    height()/aspectRatio
                } else {
                    componentWidth
                }
            } else {
                width = if (componentWidth > sizeWidthNew) {
                    sizeWidthNew
                } else {
                    componentWidth
                }
                height = if(let Some(v) <- h){
                    v
                }else{
                    width() * aspectRatio
                }
            }
        } catch (e: Exception) {
        } finally {
            try {
                callback(width, height)
            } catch (_) {
            }
        }
    }
    return fut
}

/**
 * 本地图片路径转换成PixelMap (./开头)
 *
 * @param destination 图片路径
 * @param stageContext StageContext
 * @param componentWidth 控件宽度 - 单位vp
 * @param callback PixelMap图片、图片高度、图片宽度 回调接口
 */
func rawfileToPixelmapStyle(destination: String, stageContext: ?StageContext, componentWidth: Float64, w: ?Float64, h: ?Float64,
    callback: (?PixelMap, ?Float64, ?Float64) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        var pixelMap: ?PixelMap = Option<PixelMap>.None
        var height: ?Float64 = Option<Float64>.None
        var width: ?Float64 = Option<Float64>.None
        try (imageLoadLimiter = ImageLoadLimiter()) {
            if (let Some(v) <- stageContext) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                let resourceManager = ResourceManager.getResourceManager(v)
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var arrayUInt8: Array<UInt8> = resourceManager.getRawFileContent(destination.replace("./", ""))
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
            var sizeWidthNew: Float64 = if(let Some(v) <- w){
                v
            }else{
                sizeWidth
            }
            var sizeHeightNew: Float64 = if(let Some(v) <- h){
                v
            }else{
                sizeHeight
            }
            if(w.isSome() && h.isSome()){

                width = if (componentWidth > sizeWidthNew) {
                    sizeWidthNew
                } else {
                    componentWidth
                }
                height = h()
            }else if (w.isSome() && h.isNone()){
                width = if (componentWidth > sizeWidthNew) {
                    sizeWidthNew
                } else {
                    componentWidth
                }
                height = if(let Some(v) <- h){
                    v
                }else{
                    width() * aspectRatio
                }
            } else if (w.isNone() && h.isSome()){
                height = h()
                width = if (componentWidth > height()/aspectRatio) {
                    height()/aspectRatio
                } else {
                    componentWidth
                }
            } else {
                width = if (componentWidth > sizeWidthNew) {
                    sizeWidthNew
                } else {
                    componentWidth
                }
                height = if(let Some(v) <- h){
                    v
                }else{
                    width() * aspectRatio
                }
            }
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

/**
 * 网络图片转PixelMap
 *
 * @param path 图片链接
 * @param componentWidth 控件宽度 - 单位vp
 * @param callback PixelMap图片、图片高度、图片宽度 回调接口
 */
func getImageFromHttpClientStyle(path: String, componentWidth: Float64, w: ?Float64, h: ?Float64, callback: (?Float64, ?Float64) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        var height: ?Float64 = Option<Float64>.None
        var width: ?Float64 = Option<Float64>.None
        try (imageLoadLimiter = ImageLoadLimiter()) {
            let str: String = path.trimAscii()
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let resp: HttpResponse = client.get(str)
            let inputStream: InputStream = resp.body
            let bodySize: Int64 = if (let Some(v) <- resp.bodySize) {
                if (v > 0) {
                    v
                } else {
                    2048
                }
            } else {
                2048
            }
            var arrDataTemp: Array<UInt8> = Array<UInt8>(bodySize, item: 0)
            let listbuf: ArrayList<UInt8> = ArrayList<UInt8>()
            var read: Int64 = 0
            do {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                read = inputStream.read(arrDataTemp)
                listbuf.appendAll(arrDataTemp[0..read])
            } while (read > 0)
            let arrData: Array<UInt8> = listbuf.toArray()
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            var imageSource: ImageSource = createImageSource(arrData)
            var size: Size = imageSource.getImageInfo().size
            if (Thread.currentThread.hasPendingCancellation) {
                imageSource.Release()
                return
            }
            imageSource.Release()
            var sizeWidth: Float64 = Float64(size.width)
            var sizeHeight: Float64 = Float64(size.height)
            var aspectRatio: Float64 = sizeHeight / sizeWidth
            var sizeWidthNew: Float64 = if(let Some(v) <- w){
                v
            }else{
                sizeWidth
            }
            var sizeHeightNew: Float64 = if(let Some(v) <- h){
                v
            }else{
                sizeHeight
            }
            if(w.isSome() && h.isSome()){

                width = if (componentWidth > sizeWidthNew) {
                    sizeWidthNew
                } else {
                    componentWidth
                }
                height = h()
            }else if (w.isSome() && h.isNone()){
                width = if (componentWidth > sizeWidthNew) {
                    sizeWidthNew
                } else {
                    componentWidth
                }
                height = if(let Some(v) <- h){
                    v
                }else{
                    width() * aspectRatio
                }
            } else if (w.isNone() && h.isSome()){
                height = h()
                width = if (componentWidth > height()/aspectRatio) {
                    height()/aspectRatio
                } else {
                    componentWidth
                }
            } else {
                width = if (componentWidth > sizeWidthNew) {
                    sizeWidthNew
                } else {
                    componentWidth
                }
                height = if(let Some(v) <- h){
                    v
                }else{
                    width() * aspectRatio
                }
            }
        } catch (e: Exception) {
        } finally {
            try {
                callback(width, height)
            } catch (_) {
            }
        }
    }
    return fut
}
