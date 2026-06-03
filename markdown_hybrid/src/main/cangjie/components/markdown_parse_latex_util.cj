package markdown.components

class MarkdownParseLatexUtil {
    private static let latexReentrantMutex: Mutex = Mutex() // 全局锁

    /**
     * 数学公式文本转换成数学公式图片 - 单行
     *
     * @param strLatexMath 数学公式文本
     * @param markdownTheme markdown样式
     * @param latexMathTextSize 数学公式文本大小 - 单位px
     * @param latexStrCallback 数学公式文本替换接口 旧文本 -> 新文本
     * @param callback 数学公式图片回调接口 - PixelMap图片、图片高度、图片宽度、图片数组数据
     * @return 线程
     */
    static func latexMathStrToPixelMap(
        strLatexMath: String,
        markdownTheme: MarkdownTheme,
        latexMathTextSize: Float64,
        latexStrCallback: (String) -> String,
        callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            synchronized(latexReentrantMutex) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var pixelMap: ?PixelMap = Option<PixelMap>.None
                var imageHeight: ?Float64 = Option<Float64>.None
                var imageWidth: ?Float64 = Option<Float64>.None
                var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
                var imageSource: ?ImageSource = Option<ImageSource>.None
                var latex: ?LaTeX = Option<LaTeX>.None
                var r: ?Render = Option<Render>.None
                var g2: ?Graphic2D = Option<Graphic2D>.None
                try {
                    let strLatexMathNew = latexStrCallback(strLatexMath)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    latex = LaTeX(markdownTheme.latexMathTheme.latexMathResPath)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    r = latex?.parse(strLatexMathNew, getLatexmathWidth(strLatexMathNew), Float32(latexMathTextSize), Float32(10), markdownTheme.latexMathTheme.latexMathTextColor.toUInt32())
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    g2 = if (let Some(v) <- r) {
                        Graphic2D(v, latexMathColorFormat(markdownTheme.latexMathTheme.latexMathColorFormat))
                    } else {
                        Option<Graphic2D>.None
                    }
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    if (let Some(v) <- g2) {
                        r?.draw(v, markdownTheme.latexMathTheme.latexMathBackgroundColor.toUInt32())
                    }
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    if (let Some(v) <- g2) {
                        arr = r?.toBitmap(v)
                    }
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    if (let Some(v) <- arr) {
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
                            var size: Size = p.getImageInfo().size
                            imageWidth = Float64(size.width)
                            imageHeight = Float64(size.height)
                        }
                    }
                } catch (e: Exception) {
                    pixelMap?.Release()
                    pixelMap = Option<PixelMap>.None
                } finally {
                    imageSource?.Release()
                    imageSource = Option<ImageSource>.None
                    g2?.release()
                    g2 = Option<Graphic2D>.None
                    r?.finalize()
                    r = Option<Render>.None
                    latex?.release()
                    latex = Option<LaTeX>.None
                    if (Thread.currentThread.hasPendingCancellation) {
                        pixelMap?.Release()
                        pixelMap = Option<PixelMap>.None
                        return
                    }
                }
                callback(pixelMap, imageHeight, imageWidth, arr)
            }
        }
        return fut
    }

    /**
     * 数学公式文本转换成数学公式图片 - 行内
     *
     * @param strLatexMath 数学公式文本
     * @param markdownTheme markdown样式
     * @param latexMathTextSize 数学公式文本大小 - 单位px
     * @param componentWidth 控件宽度 - 单位px
     * @param latexStrCallback 数学公式文本替换接口 旧文本 -> 新文本
     * @param callback 数学公式图片回调接口 - PixelMap图片、图片高度、图片宽度、图片数组数据
     * @return Future
     */
    static func latexMathStrToPixelMapRow(
        strLatexMath: String,
        markdownTheme: MarkdownTheme,
        latexMathTextSize: Float64,
        componentWidth: Float64,
        latexStrCallback: (String) -> String,
        callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit
    ): Future<Unit> {
        let fut: Future<Unit> = spawn {
            synchronized(latexReentrantMutex) {
                if (Thread.currentThread.hasPendingCancellation) {
                    return
                }
                var pixelMap: ?PixelMap = Option<PixelMap>.None
                var height: ?Float64 = Option<Float64>.None
                var width: ?Float64 = Option<Float64>.None
                var arr: ?Array<UInt8> = Option<Array<UInt8>>.None
                var imageSource: ?ImageSource = Option<ImageSource>.None
                var latex: ?LaTeX = Option<LaTeX>.None
                var r: ?Render = Option<Render>.None
                var g2: ?Graphic2D = Option<Graphic2D>.None
                try {
                    let strLatexMathNew = latexStrCallback(strLatexMath)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    latex = LaTeX(markdownTheme.latexMathTheme.latexMathResPath)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    r = latex?.parse(strLatexMathNew, getLatexmathWidth(strLatexMathNew), Float32(latexMathTextSize), Float32(10), markdownTheme.latexMathTheme.latexMathTextColor.toUInt32())
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    g2 = if (let Some(v) <- r) {
                        Graphic2D(v, latexMathColorFormat(markdownTheme.latexMathTheme.latexMathColorFormat))
                    } else {
                        Option<Graphic2D>.None
                    }
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    if (let Some(v) <- g2) {
                        r?.draw(v, markdownTheme.latexMathTheme.latexMathBackgroundColor.toUInt32())
                    }
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    if (let Some(v) <- g2) {
                        arr = r?.toBitmap(v)
                    }
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    if (let Some(v) <- arr) {
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
                            var size: Size = p.getImageInfo().size
                            var sizeWidth: Float64 = Float64(size.width)
                            var sizeHeight: Float64 = Float64(size.height)
                            var aspectRatio: Float64 = sizeHeight / sizeWidth
                            width = if (componentWidth > sizeWidth) {
                                sizeWidth
                            } else {
                                componentWidth
                            }
                            height = width() * aspectRatio
                            p.scale(Float32(width() / sizeWidth), Float32(height() / sizeHeight))
                        }
                    }
                } catch (e: Exception) {
                    pixelMap?.Release()
                    pixelMap = Option<PixelMap>.None
                } finally {
                    imageSource?.Release()
                    imageSource = Option<ImageSource>.None
                    g2?.release()
                    g2 = Option<Graphic2D>.None
                    r?.finalize()
                    r = Option<Render>.None
                    latex?.release()
                    latex = Option<LaTeX>.None
                    if (Thread.currentThread.hasPendingCancellation) {
                        pixelMap?.Release()
                        pixelMap = Option<PixelMap>.None
                        return
                    }
                }
                callback(pixelMap, height, width, arr)
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
