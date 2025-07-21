/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

let resPath: String = "/data/storage/el1/bundle/entry/resources/resfile/res"

class MarkdownParseLatexUtil {
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
     * @param callback PixelMap图片、图片高度、图片宽度、图片数组数据 回调接口
     */
    static func latexMathStrToPixelMap(strLatexMath: String, markdownConfiguration: MarkdownConfiguration, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit): Future<Unit> {
        let fut: Future<Unit> = spawn {
            synchronized(latexReentrantMutex) {
                var pixelMap: ?PixelMap = Option<PixelMap>.None
                var imageHeight: ?Float64 = Option<Float64>.None
                var imageWidth: ?Float64 = Option<Float64>.None
                var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
                try {
                    let strLatexMathNew = markdownConfiguration.latexStrCallback(strLatexMath)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    var latex = LaTeX(resPath)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    var r = latex.parse(strLatexMathNew, getLatexmathWidth(strLatexMathNew), Float32(markdownConfiguration.markdownTheme.latexMathTextSize), Float32(markdownConfiguration.markdownTheme.latexMathTextLineSpacing), markdownConfiguration.markdownTheme.latexMathTextColor.toUInt32())
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    var g2 = Graphic2D(r, latexMathColorFormat(markdownConfiguration.markdownTheme.latexMathColorFormat))
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    r.draw(g2, markdownConfiguration.markdownTheme.latexMathBackGroupColor.toUInt32())
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    arr = r.toBitmap(g2)
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
                    var size: Size = pixelMap().getImageInfo().size
                    imageWidth = Float64(size.width)
                    imageHeight = Float64(size.height)
                } catch (e: Exception) {
                } finally {
                    try {
                        if (Thread.currentThread.hasPendingCancellation) {
                            pixelMap?.Release()
                            return
                        }
                        callback(pixelMap, imageHeight, imageWidth, arr)
                    } catch (_) {
                    }
                }
            }
        }
        return fut
    }

    /**
     * 数学公式文本转换成数学公式图片 - 行内
     *
     * @param strLatexMath 数学公式文本
     * @param resStr 数学公式需要的字体资源目录路径
     * @param markdownConfiguration Markdown Configuration
     * @param componentWidth 控件宽度 - 单位vp
     * @param callback PixelMap图片、图片高度、图片宽度、图片数组数据 回调接口
     */
    static func latexMathStrToPixelMapRow(strLatexMath: String, markdownConfiguration: MarkdownConfiguration, componentWidth: Float64, callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit, backGroupColor: Color): Future<Unit> {
        let fut: Future<Unit> = spawn {
            synchronized(latexReentrantMutex) {
                var pixelMap: ?PixelMap = Option<PixelMap>.None
                var height: ?Float64 = Option<Float64>.None
                var width: ?Float64 = Option<Float64>.None
                var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
                try {
                    let strLatexMathNew = markdownConfiguration.latexStrCallback(strLatexMath)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    var latex = LaTeX(resPath)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    var r = latex.parse(strLatexMathNew, getLatexmathWidth(strLatexMathNew), Float32(markdownConfiguration.markdownTheme.latexMathTextSize), Float32(markdownConfiguration.markdownTheme.latexMathTextLineSpacing), markdownConfiguration.markdownTheme.latexMathTextColor.toUInt32())
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    var g2 = Graphic2D(r, latexMathColorFormat(markdownConfiguration.markdownTheme.latexMathColorFormat))
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    r.draw(g2, backGroupColor.toUInt32())
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    arr = r.toBitmap(g2)
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
                } catch (e: Exception) {
                } finally {
                    try {
                        if (Thread.currentThread.hasPendingCancellation) {
                            pixelMap?.Release()
                            return
                        }
                        callback(pixelMap, height, width, arr)
                    } catch (_) {
                    }
                }
            }
        }
        return fut
    }
}

/**
 * 数学公式宽度特殊处理
 *
 * @param strLatexMath 数学公式文本
 * @return 宽度
 */
func getLatexmathWidth(strLatexMath: String): Int32 {
    if (strLatexMath.contains("aligned") || strLatexMath.contains("align") || strLatexMath.contains("flalign") || strLatexMath.contains("gather") || strLatexMath.contains("multline") || strLatexMath.contains("eqnarray")) {
        Int32(10)
    } else {
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
    return match (latexMathColorFormat) {
        case LatexMathColorFormat.COLOR_FORMAT_RGB_565 => ColorFormat.COLOR_FORMAT_RGB_565
        case LatexMathColorFormat.COLOR_FORMAT_BGRA_8888 => ColorFormat.COLOR_FORMAT_BGRA_8888
    }
}
