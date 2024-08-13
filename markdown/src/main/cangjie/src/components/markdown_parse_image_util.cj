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
func imageSpanToPixelmap(destination: String, componentWidth: Float64, callback: (?PixelMap, ?Float64, ?Float64) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        try {
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            var imageSource: ImageSource = createImageSource(destination)
            if (Thread.currentThread.hasPendingCancellation) {
                imageSource.Release()
                return
            }
            var pixelMap: PixelMap = imageSource.createPixelMap()
            if (Thread.currentThread.hasPendingCancellation) {
                imageSource.Release()
                pixelMap.Release()
                return
            }
            imageSource.Release()
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            var size: Size = pixelMap.getImageInfo().size
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            var aspectRatio: Float64 = Float64(size.height) / Float64(size.width)
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            var imageWidth: Float64 = px2vp(Int64(size.width).px)().value
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            var imageHeight: Float64 = px2vp(Int64(size.height).px)().value
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            var width: Float64 = if (componentWidth > imageWidth) {
                imageWidth
            } else {
                componentWidth
            }
            var height: Float64 = width * aspectRatio
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            pixelMap.scale(Float32(width / imageWidth), Float32(height / imageHeight))
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            callback(pixelMap, width, height)
        } catch (e: Exception) {
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            callback(Option<PixelMap>.None, Option<Float64>.None, Option<Float64>.None)
        }
    }
    return fut
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
    callback: (?PixelMap, ?Float64, ?Float64) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        try {
            if (let Some(v) <- abilityContext) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                let resourceManager = ResourceManager.getResourceManager(getStageContext(v))
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
                var pixelMap: PixelMap = imageSource.createPixelMap()
                if (Thread.currentThread.hasPendingCancellation) {
                    imageSource.Release()
                    pixelMap.Release()
                    return
                }
                imageSource.Release()
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap.Release()
                    return
                }
                var size: Size = pixelMap.getImageInfo().size
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap.Release()
                    return
                }
                var aspectRatio: Float64 = Float64(size.height) / Float64(size.width)
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap.Release()
                    return
                }
                var imageWidth: Float64 = px2vp(Int64(size.width).px)().value
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap.Release()
                    return
                }
                var imageHeight: Float64 = px2vp(Int64(size.height).px)().value
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap.Release()
                    return
                }
                var width: Float64 = if (componentWidth > imageWidth) {
                    imageWidth
                } else {
                    componentWidth
                }
                var height: Float64 = width * aspectRatio
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap.Release()
                    return
                }
                pixelMap.scale(Float32(width / imageWidth), Float32(height / imageHeight))
                if (Thread.currentThread.hasPendingCancellation) {
                    pixelMap.Release()
                    return
                }
                callback(pixelMap, width, height)
            } else {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                callback(Option<PixelMap>.None, Option<Float64>.None, Option<Float64>.None)
            }
        } catch (e: Exception) {
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            callback(Option<PixelMap>.None, Option<Float64>.None, Option<Float64>.None)
        }
    }
    return fut
}

let client: Client = ClientBuilder().readTimeout(Duration.minute * 1).poolSize(2000).tlsConfig(getTlsClientConfig()).build()

func getTlsClientConfig():TlsClientConfig{
    var tls:TlsClientConfig = TlsClientConfig()
    tls.verifyMode = CertificateVerifyMode.TrustAll
    return tls
}

/**
 * 网络图片转PixelMap
 *
 * @param path 图片链接
 * @param componentWidth 控件宽度 - 单位vp
 * @param callback PixelMap图片、图片高度、图片宽度 回调接口
 */
func getImageFromHttpClient(path: String, componentWidth: Float64, callback: (?PixelMap, ?Float64, ?Float64) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
        try {
            let str: String = path.trimAscii()
            let resp: HttpResponse = client.get(str)
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let inputStream: InputStream = resp.body
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let bodySize :Int64 = if(let Some(v)  <- resp.bodySize){
                if(v > 0){
                    v
                } else {
                    2048
                }
            } else {
                2048
            }
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            var arrDataTemp: Array<UInt8> = Array<UInt8>(bodySize, item: 0)
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let listbuf: ArrayList<UInt8> = ArrayList<UInt8>()
            var read: Int64 = 0
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            do {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                read = inputStream.read(arrDataTemp)
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                listbuf.appendAll(arrDataTemp[0..read])
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
            } while (read > 0)
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let arrData: Array<UInt8> = listbuf.toArray()
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            var imageSource: ImageSource = createImageSource(arrData)
            if (Thread.currentThread.hasPendingCancellation) {
                imageSource.Release()
                return
            }
            var pixelMap: PixelMap = imageSource.createPixelMap()
            if (Thread.currentThread.hasPendingCancellation) {
                imageSource.Release()
                pixelMap.Release()
                return
            }
            imageSource.Release()
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            var size: Size = pixelMap.getImageInfo().size
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            var aspectRatio: Float64 = Float64(size.height) / Float64(size.width)
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            var imageWidth: Float64 = px2vp(Int64(size.width).px)().value
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            var imageHeight: Float64 = px2vp(Int64(size.height).px)().value
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            var width: Float64 = if (componentWidth > imageWidth) {
                imageWidth
            } else {
                componentWidth
            }
            var height: Float64 = width * aspectRatio
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            pixelMap.scale(Float32(width / imageWidth), Float32(height / imageHeight))
            if (Thread.currentThread.hasPendingCancellation) {
                pixelMap.Release()
                return
            }
            callback(pixelMap, width, height)
        } catch (e: Exception) {
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            callback(Option<PixelMap>.None, Option<Float64>.None, Option<Float64>.None)
        }
    }
    return fut
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
