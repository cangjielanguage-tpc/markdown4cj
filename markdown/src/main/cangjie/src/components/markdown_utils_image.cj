/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 数学公式宽度特殊处理
 *
 * @param strLatexMath 数学公式文本
 * @return 宽度
 */
func getLatexmathWidth(strLatexMath: String): Int32 {
    if (strLatexMath.contains("aligned")|| strLatexMath.contains("align")||strLatexMath.contains("flalign")||strLatexMath.contains("gather")||strLatexMath.contains("multline")||strLatexMath.contains("eqnarray")) {
    	Int32(10)
    } else  {
        Int32(2000)
    }
}

/**
 * 数学公式图片生成格式
 *
 * @param latexMathColorFormat 生成格式枚举
 * @return 图片格式枚举
 */
func latexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): ColorFormat {
    return match(latexMathColorFormat){
        case LatexMathColorFormat.COLOR_FORMAT_RGB_565 => ColorFormat.COLOR_FORMAT_RGB_565
        case LatexMathColorFormat.COLOR_FORMAT_BGRA_8888 => ColorFormat.COLOR_FORMAT_BGRA_8888
    }
}

/**
 * 本地图片路径转换成PixelMap (file:开头)
 *
 * @param destination 图片路径
 * @param componentWidth 控件宽度 - 单位vp
 * @return PixelMap和宽高 - 单位vp
 */
func imageSpanToPixelmap(destination: String, componentWidth: Float64): (?PixelMap, ?Float64, ?Float64) {
    try {
        var imageSource: ImageSource = createImageSource(destination)
        var pixelMap: PixelMap = imageSource.createPixelMap()
        imageSource.release()
        var size: Size = pixelMap.getImageInfo().size
        var aspectRatio: Float64  = Float64(size.height)/Float64(size.width)
        var imageWidth: Float64 = px2vp(Int64(size.width).px)().value
        var imageHeight: Float64 = px2vp(Int64(size.height).px)().value
        var width: Float64 = if (componentWidth > imageWidth) {
            imageWidth
        } else {
            componentWidth
        }
        var height: Float64 = width * aspectRatio
        pixelMap.scale(Float32(width/imageWidth), Float32(height/imageHeight))
        return (pixelMap, width, height)
    } catch (e: Exception) {
        return (None, None, None)
    }
}

/**
 * 本地图片路径转换成PixelMap (./开头)
 *
 * @param destination 图片路径
 * @param abilityContext AbilityContext
 * @param componentWidth 控件宽度 - 单位vp
 * @return PixelMap和宽高 - 单位vp
 */
func rawfileToPixelmap(destination: String, abilityContext: ?AbilityContext, componentWidth: Float64): (?PixelMap, ?Float64, ?Float64) {
    try {
        if (let Some(v) <- abilityContext) {
            let resourceManager = ResourceManager.getResourceManager(getStageContext(v))
            var arrayUInt8: Array<UInt8> = resourceManager.getRawFileContent(destination.replace("./", ""))
            var imageSource: ImageSource = createImageSource(arrayUInt8)
            var pixelMap: PixelMap = imageSource.createPixelMap()
            imageSource.release()
            var size: Size = pixelMap.getImageInfo().size
            var aspectRatio: Float64  = Float64(size.height) / Float64(size.width)
            var imageWidth: Float64 = px2vp(Int64(size.width).px)().value
            var imageHeight: Float64 = px2vp(Int64(size.height).px)().value
            var width: Float64 = if (componentWidth > imageWidth) {
                imageWidth
            } else {
                componentWidth
            }
            var height: Float64 = width * aspectRatio
            pixelMap.scale(Float32(width/imageWidth), Float32(height/imageHeight))
            return (pixelMap, width, height)
        } else {
            return (None, None, None)
        }
    } catch (e: Exception) {
        return (None, None, None)
    }
}

/**
 * 网络图片转PixelMap
 *
 * @param path 图片链接
 * @param componentWidth 控件宽度 - 单位vp
 * @return PixelMap和宽高 - 单位vp
 */
func getImageFromHttpClient(path: String, componentWidth: Float64): (?PixelMap, ?Float64, ?Float64) {
    try{
        let str: String = path.trimAscii()
        var tls: TlsClientConfig = TlsClientConfig()
        tls.verifyMode = CertificateVerifyMode.TrustAll
        var client:Client = ClientBuilder().readTimeout(Duration.minute*1).tlsConfig(tls).build()
        let resp :HttpResponse= client.get(str)
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
        imageSource.release()
        var size: Size = pixelMap.getImageInfo().size
        var aspectRatio: Float64  = Float64(size.height) / Float64(size.width)
        var imageWidth: Float64 = px2vp(Int64(size.width).px)().value
        var imageHeight: Float64 = px2vp(Int64(size.height).px)().value
        var width: Float64 = if (componentWidth > imageWidth) {
            imageWidth
        } else {
            componentWidth
        }
        var height: Float64 = width * aspectRatio
        pixelMap.scale(Float32(width/imageWidth), Float32(height/imageHeight))
        return (pixelMap, width, height)
    } catch (e: Exception) {
        return (None, None, None)
    }
}
