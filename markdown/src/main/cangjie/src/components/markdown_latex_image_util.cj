/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

class MarkdownLatexImageUtil {
    /**
     * 全局锁
     */
    private static let latexReentrantMutex: ReentrantMutex = ReentrantMutex()

    /**
     * 数学公式文本转换成数学公式图片 - 单行
     *
     * @param strLatexMath 数学公式文本
     * @param resStr 数学公式需要的字体资源目录路径
     * @param markdownConfiguration Markdown Configuration
     * @return PixelMap图片、图片高度、图片宽度、图片数组数据
     */
    static func latexMathStrToPixelMap(strLatexMath: String, resStr: String, markdownConfiguration: MarkdownConfiguration): (?PixelMap, ?Length, ?Length, ?Array<UInt8>, String) {
        let strLatexMathNew = markdownConfiguration.latexStrCallback(strLatexMath)
        synchronized (latexReentrantMutex){
            try {
                var latex = LaTeX(resStr)
                var r = latex.parse(strLatexMathNew, getLatexmathWidth(strLatexMathNew), Float32(markdownConfiguration.markdownTheme.latexMathTextSize), Float32(markdownConfiguration.markdownTheme.latexMathTextLineSpacing), markdownConfiguration.markdownTheme.latexMathTextColor.toUInt32())
                var g2 = Graphic2D(r,latexMathColorFormat(markdownConfiguration.markdownTheme.latexMathColorFormat))
                r.draw(g2, markdownConfiguration.markdownTheme.latexMathBackGroupColor.toUInt32())
                var arr: Array<UInt8> = r.toBitmap(g2)
                var imageSource: ImageSource = createImageSource(arr)
                var pixelMap: PixelMap = imageSource.createPixelMap()
                imageSource.Release()
                return (pixelMap, Length(Int64(g2.height), unitType: LengthType.px), Length(Int64(g2.width), unitType: LengthType.px), arr, strLatexMath)
            } catch (e: Exception) {
                return (None, None, None, None, strLatexMath)
            }
        }
    }

    /**
     * 数学公式文本转换成数学公式图片 - 行内
     *
     * @param strLatexMath 数学公式文本
     * @param resStr 数学公式需要的字体资源目录路径
     * @param markdownConfiguration Markdown Configuration
     * @param componentWidth 控件宽度 - 单位vp
     * @return PixelMap和宽高,图片数组数据 - 单位vp
     */
    static func latexMathStrToPixelMapRow(strLatexMath: String, resStr: String, markdownConfiguration: MarkdownConfiguration, componentWidth: Float64): (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) {
        let strLatexMathNew = markdownConfiguration.latexStrCallback(strLatexMath)
        synchronized (latexReentrantMutex){
            try {
                var latex = LaTeX(resStr)
                var r = latex.parse(strLatexMathNew, getLatexmathWidth(strLatexMathNew), Float32(markdownConfiguration.markdownTheme.latexMathTextSize), Float32(markdownConfiguration.markdownTheme.latexMathTextLineSpacing), markdownConfiguration.markdownTheme.latexMathTextColor.toUInt32())
                var g2 = Graphic2D(r,latexMathColorFormat(markdownConfiguration.markdownTheme.latexMathColorFormat))
                r.draw(g2, markdownConfiguration.markdownTheme.latexMathBackGroupColor.toUInt32())
                var arr: Array<UInt8> = r.toBitmap(g2)
                var imageSource: ImageSource = createImageSource(arr)
                var pixelMap: PixelMap = imageSource.createPixelMap()
                imageSource.Release()
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
                return (pixelMap, height, width, arr)
            } catch (e: Exception) {
                return (None, None, None, None)
            }
        }
    }
}