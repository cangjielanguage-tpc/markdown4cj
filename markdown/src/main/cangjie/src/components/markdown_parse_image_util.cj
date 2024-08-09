/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 本地图片路径转换成PixelMap (file:开头)
 *
 * @param destination 图片路径
 * @param componentWidth 控件宽度 - 单位vp
 * @param callback PixelMap图片、图片高度、图片宽度 回调接口
 */
func imageSpanToPixelmap(destination: String, componentWidth: Float64, callback: (?PixelMap, ?Float64, ?Float64) -> Unit) {
    spawn {
        try {
            var imageSource: ImageSource = createImageSource(destination)
            var pixelMap: PixelMap = imageSource.createPixelMap()
            imageSource.Release()
            var size: Size = pixelMap.getImageInfo().size
            var aspectRatio: Float64 = Float64(size.height) / Float64(size.width)
            var imageWidth: Float64 = px2vp(Int64(size.width).px)().value
            var imageHeight: Float64 = px2vp(Int64(size.height).px)().value
            var width: Float64 = if (componentWidth > imageWidth) {
                imageWidth
            } else {
                componentWidth
            }
            var height: Float64 = width * aspectRatio
            pixelMap.scale(Float32(width / imageWidth), Float32(height / imageHeight))
            callback(pixelMap, width, height)
        } catch (e: Exception) {
            callback(Option<PixelMap>.None, Option<Float64>.None, Option<Float64>.None)
        }
    }
}

/**
 * 本地图片路径转换成PixelMap (./开头)
 *
 * @param destination 图片路径
 * @param abilityContext AbilityContext
 * @param componentWidth 控件宽度 - 单位vp
 * @param callback PixelMap图片、图片高度、图片宽度 回调接口
 */
func rawfileToPixelmap(destination: String, abilityContext: ?AbilityContext, componentWidth: Float64,
    callback: (?PixelMap, ?Float64, ?Float64) -> Unit) {
    spawn {
        try {
            if (let Some(v) <- abilityContext) {
                let resourceManager = ResourceManager.getResourceManager(getStageContext(v))
                var arrayUInt8: Array<UInt8> = resourceManager.getRawFileContent(destination.replace("./", ""))
                var imageSource: ImageSource = createImageSource(arrayUInt8)
                var pixelMap: PixelMap = imageSource.createPixelMap()
                imageSource.Release()
                var size: Size = pixelMap.getImageInfo().size
                var aspectRatio: Float64 = Float64(size.height) / Float64(size.width)
                var imageWidth: Float64 = px2vp(Int64(size.width).px)().value
                var imageHeight: Float64 = px2vp(Int64(size.height).px)().value
                var width: Float64 = if (componentWidth > imageWidth) {
                    imageWidth
                } else {
                    componentWidth
                }
                var height: Float64 = width * aspectRatio
                pixelMap.scale(Float32(width / imageWidth), Float32(height / imageHeight))
                callback(pixelMap, width, height)
            } else {
                callback(Option<PixelMap>.None, Option<Float64>.None, Option<Float64>.None)
            }
        } catch (e: Exception) {
            callback(Option<PixelMap>.None, Option<Float64>.None, Option<Float64>.None)
        }
    }
}

/**
 * 网络图片转PixelMap
 *
 * @param path 图片链接
 * @param componentWidth 控件宽度 - 单位vp
 * @param callback PixelMap图片、图片高度、图片宽度 回调接口
 */
func getImageFromHttpClient(path: String, componentWidth: Float64, callback: (?PixelMap, ?Float64, ?Float64) -> Unit) {
    spawn {
        try {
            let str: String = path.trimAscii()
            var tls: TlsClientConfig = TlsClientConfig()
            tls.verifyMode = CertificateVerifyMode.TrustAll
            var client: Client = ClientBuilder().readTimeout(Duration.minute * 1).tlsConfig(tls).build()
            let resp: HttpResponse = client.get(str)
            let inputStream: InputStream = resp.body
            var arrDataTemp: Array<UInt8> = Array<UInt8>(2048, item: 0)
            let listbuf: ArrayList<UInt8> = ArrayList<UInt8>()
            var read: Int64 = 0
            do {
                read = inputStream.read(arrDataTemp)
                for (j in 0..read) {
                    listbuf.append(arrDataTemp[j])
                }
            } while (read > 0)
            let arrData: Array<UInt8> = listbuf.toArray()
            var imageSource: ImageSource = createImageSource(arrData)
            var pixelMap: PixelMap = imageSource.createPixelMap()
            imageSource.Release()
            var size: Size = pixelMap.getImageInfo().size
            var aspectRatio: Float64 = Float64(size.height) / Float64(size.width)
            var imageWidth: Float64 = px2vp(Int64(size.width).px)().value
            var imageHeight: Float64 = px2vp(Int64(size.height).px)().value
            var width: Float64 = if (componentWidth > imageWidth) {
                imageWidth
            } else {
                componentWidth
            }
            var height: Float64 = width * aspectRatio
            pixelMap.scale(Float32(width / imageWidth), Float32(height / imageHeight))
            callback(pixelMap, width, height)
        } catch (e: Exception) {
            callback(Option<PixelMap>.None, Option<Float64>.None, Option<Float64>.None)
        }
    }
}

/**
 * 释放PixelMap
 */
func delPixelMap(listPixelMap: ArrayList<?PixelMap>) {
    spawn {
        for (item in listPixelMap) {
            if (item.isSome()) {
                item().Release()
            }
        }
        listPixelMap.clear()
    }
}

/**
 * 判断是否有图片数据
 */
func isImagePixelMap(imageData: ImageData, listPixelMap: ArrayList<?PixelMap>): Bool {
    if (imageData.pixelMap.isSome() && imageData.height.isSome() && imageData.width.isSome()) {
        listPixelMap.append(imageData.pixelMap)
        return true
    }
    return false
}