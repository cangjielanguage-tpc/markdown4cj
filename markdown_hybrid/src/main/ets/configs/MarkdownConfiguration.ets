import { MarkdownNodeViewString } from "../pages/CJMarkDown"
import { MarkdownTheme } from "../themes/MarkdownTheme"
import { MarkdownHighlightParagraph } from "./MarkdownHighlightParagraph"
import { MarkdownExposureEvent } from "./MarkdownExposureEvent"
import { MarkdownScrollController } from "./MarkdownScrollController"

/**
 * markdown配置
 */
export class MarkdownConfiguration {
  /**
   * 链接的点击事件
   */
  private linkCallback?: (url: string) => void = undefined
  /**
   * 文本复制的点击事件
   */
  private textCopyCallback?: (text: string) => void = undefined
  /**
   * 图片的点击事件
   */
  private imageCallback?: (url: string, urlList: Array<string>) => void = undefined
  /**
   * 图片替换事件
   */
  private imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> = undefined
  /**
   * 图片下载的点击事件
   */
  private imageDownloadCallback?: (url: string) => void = undefined
  /**
   * 音频的点击事件
   */
  private audioCallback?: (url: string) => void = undefined
  /**
   * 视频的点击事件
   */
  private videoCallback?: (url: string, urlList: Array<string>) => void = undefined
  /**
   * 视频的图片替换回调
   */
  private videoImageCallback?: (url: string, coverCallback: (coverUrl: string, aspectRatio: number, duration: number) => void) => void = undefined
  /**
   * 视频发布的点击事件
   */
  private videoReleaseCallback?: (url: string) => void = undefined
  /**
   * 视频下载的点击事件
   */
  private videoDownloadCallback?: (url: string) => void = undefined
  /**
   * 代码复制按钮的点击事件
   */
  private codeCopyCallback?: (code: string) => void = undefined
  /**
   * 代码全屏按钮的点击事件
   */
  private codeFullScreenCallback?: (code: string, language: string | undefined) => void = undefined
  /**
   * 数学公式图片点击事件
   */
  private latexImageCallback?: (imageData: ArrayBuffer, height: number, width: number) => void = undefined
  /**
   * 数学公式数据处理事件
   */
  private latexStrCallback?: (formula: string) => string = undefined
  /**
   * TOC跳转指定位置
   */
  private tocIndexCallback?: (index: number | undefined) => void = undefined
  /**
   * 脚注跳转指定位置
   */
  private footnoteCallback?: (index: number | undefined) => void = undefined
  /**
   * 获取全局文本
   */
  private markdownNodeViewString: MarkdownNodeViewString = new MarkdownNodeViewString()
  /**
   * markdown默认样式
   */
  private markdownTheme?: MarkdownTheme = undefined

  /**
   * 表格复制回调
   */
  private tableCopyCallback?: (text: string) => void = undefined

  /**
   * 元素曝光回调
   */
  private elementExposureCallback?: (event: MarkdownExposureEvent) => void = undefined

  /**
   * 曝光可见阈值
   */
  private exposureThreshold?: number = undefined

  /**
   * 段落高亮配置
   */
  private markdownHighlightParagraph: MarkdownHighlightParagraph = new MarkdownHighlightParagraph()

  /**
   * 外层滚动控制器
   */
  private scrollController?: MarkdownScrollController = undefined

  /**
   * 段落动画开始回调
   */
  private paragraphAnimationStart?: () => void = undefined

  /**
   * 段落动画结束回调
   */
  private paragraphAnimationEnd?: () => void = undefined

  /**
   * 长按段落回调
   */
  private customLongPressCallback?: (text: string) => void = undefined

  /**
   * 满足自定义块级图片的条件
   */
  private isBlockImageCustom?: (url: string) => boolean = undefined

  /**
   * 满足自定义行内图片的条件
   */
  private isInLineImageCustom?: (url: string) => boolean = undefined

  /**
   * 满足自定义行内链接的条件
   */
  private isInLineLinkCustom?: (url: string) => boolean = undefined

  /**
   * 设置链接点击回调
   *
   * @param cb 链接点击回调(url：链接url)
   */
  setLinkCallback(cb: (url: string) => void): MarkdownConfiguration {
    this.linkCallback = cb
    return this
  }

  /**
   * 设置文本复制的点击事件
   *
   * @param cb 文本复制的点击事件(text：复制的文本)
   */
  setTextCopyCallback(cb: (text: string) => void): MarkdownConfiguration {
    this.textCopyCallback = cb
    return this
  }

  /**
   * 设置图片点击回调
   *
   * @param cb 图片点击回调。 (url：图片url,urlList：所有图片和视频链接集合 --- 需要加载图片视频列表url集合列表解析插件)
   */
  setImageCallback(cb: (url: string, urlList: Array<string>) => void): MarkdownConfiguration {
    this.imageCallback = cb
    return this
  }

  /**
   * 设置图片替换事件
   *
   * @param cb 图片替换事件。 (url：图片url 返回值是替换的图片数据)
   * @deprecated since 1.4.0
   * @useinstead MarkdownConfiguration#setImageReplaceCallback
   */
  setImageCallbackCallback(cb: (url: string) => Promise<ArrayBuffer | undefined>): MarkdownConfiguration {
    this.setImageReplaceCallback(cb)
    return this
  }

  /**
   * 设置图片替换事件
   *
   * @param cb 图片替换事件。 (url：图片url 返回值是替换的图片数据)
   */
  setImageReplaceCallback(cb: (url: string) => Promise<ArrayBuffer | undefined>): MarkdownConfiguration {
    this.imageReplaceCallback = cb
    return this
  }

  /**
   * 设置图片下载的点击事件
   *
   * @param cb 图片下载的点击事件。 (url：图片url)
   */
  setImageDownloadCallback(cb: (url: string) => void): MarkdownConfiguration {
    this.imageDownloadCallback = cb
    return this
  }

  /**
   * 设置音频点击回调
   *
   * @param cb 音频点击回调(url：音频url) --- 需要加载音频解析插件
   */
  setAudioCallback(cb: (url: string) => void): MarkdownConfiguration {
    this.audioCallback = cb
    return this
  }

  /**
   * 设置视频点击回调
   *
   * @param cb 视频点击回调。 (url：视频url,urlList：所有图片和视频链接集合 --- 需要加载图片视频列表url集合列表解析插件) --- 需要加载视频解析插件
   */
  setVideoCallback(cb: (url: string, urlList: Array<string>) => void): MarkdownConfiguration {
    this.videoCallback = cb
    return this
  }

  /**
   * 设置视频占位图和宽高比和视频时长的回调
   *
   * @param cb 视频占位图和宽高比和视频时长回调。 (url：视频url,coverCallback：视频占位图和宽高比和视频时长回调 (coverUrl：视频首帧图,aspectRatio：图片宽高比,duration：视频时长)) --- 需要加载视频解析插件
   */
  setVideoImageCallback(cb: (url: string, coverCallback: (coverUrl: string, aspectRatio: number, duration: number) => void) => void): MarkdownConfiguration {
    this.videoImageCallback = cb
    return this
  }

  /**
   * 设置视频发布的点击事件
   *
   * @param cb 视频发布的点击事件(url：视频url) --- 需要加载视频解析插件
   */
  setVideoReleaseCallback(cb: (url: string) => void): MarkdownConfiguration {
    this.videoReleaseCallback = cb
    return this
  }

  /**
   * 设置视频下载的点击事件
   *
   * @param cb 视频下载的点击事件(url：视频url) --- 需要加载视频解析插件
   */
  setVideoDownloadCallback(cb: (url: string) => void): MarkdownConfiguration {
    this.videoDownloadCallback = cb
    return this
  }

  /**
   * 设置代码复制点击回调
   *
   * @param cb 代码复制点击回调(code：代码内容)
   */
  setCodeCopyCallback(cb: (code: string) => void): MarkdownConfiguration {
    this.codeCopyCallback = cb
    return this
  }

  /**
   * 设置代码全屏点击回调
   *
   * @param cb 代码全屏点击回调(code：代码内容, language：代码类型)
   */
  setCodeFullScreenCallback(cb: (code: string, language: string | undefined) => void): MarkdownConfiguration {
    this.codeFullScreenCallback = cb
    return this
  }

  /**
   * 设置数学公式点击回调
   *
   * @param cb 数学公式点击回调(imageData：数学公式图片数组数据, height：图片高度, width：图片宽度) --- 需要加载数学公式解析插件
   */
  setLatexImageCallback(cb: (imageData: ArrayBuffer, height: number, width: number) => void): MarkdownConfiguration {
    this.latexImageCallback = cb
    return this
  }

  /**
   * 设置数学公式公式预处理回调
   *
   * @param cb 数学公式公式预处理回调(formula：数学公式文本内容,return：处理过后的数学公式文本) --- 需要加载数学公式解析插件
   */
  setLatexStrCallback(cb: (formula: string) => string): MarkdownConfiguration {
    this.latexStrCallback = cb
    return this
  }

  /**
   * 设置TOC点击回调
   *
   * @param cb TOC点击回调(index：第几条数据) --- 需要加载TOC解析插件
   */
  setTocIndexCallback(cb: (index: number | undefined) => void): MarkdownConfiguration {
    this.tocIndexCallback = cb
    return this
  }

  /**
   * 设置脚注点击回调
   *
   * @param cb 脚注点击回调(index：第几条数据) --- 需要加载脚注解析插件
   */
  setFootnoteCallback(cb: (index: number | undefined) => void): MarkdownConfiguration {
    this.footnoteCallback = cb
    return this
  }

  /**
   * 设置全局文本对象
   *
   * @param nodeString 全局文本对象
   */
  setNodeString(nodeString: MarkdownNodeViewString): MarkdownConfiguration {
    this.markdownNodeViewString = nodeString
    return this
  }

  /**
   * 设置markdown样式
   *
   * @param markdownTheme markdown样式
   */
  setMarkdownTheme(markdownTheme: MarkdownTheme): MarkdownConfiguration {
    this.markdownTheme = markdownTheme
    return this
  }

  /**
   * 获取链接的点击事件
   *
   * @returns 链接的点击事件回调函数
   */
  getLinkCallback(): ((url: string) => void) | undefined {
    return this.linkCallback
  }

  /**
   * 获取文本复制的点击事件
   *
   * @returns 文本复制的点击事件回调函数
   */
  getTextCopyCallback(): ((text: string) => void) | undefined {
    return this.textCopyCallback
  }

  /**
   * 获取图片的点击事件
   *
   * @returns 图片的点击事件回调函数
   */
  getImageCallback(): ((url: string, urlList: Array<string>) => void) | undefined {
    return this.imageCallback
  }

  /**
   * 获取图片替换事件
   *
   * @returns 图片替换事件回调函数
   */
  getImageReplaceCallback(): ((url: string) => Promise<ArrayBuffer | undefined>) | undefined {
    return this.imageReplaceCallback
  }

  /**
   * 获取图片下载的点击事件
   *
   * @returns 图片下载的点击事件回调函数
   */
  getImageDownloadCallback(): ((url: string) => void) | undefined {
    return this.imageDownloadCallback
  }

  /**
   * 获取音频的点击事件
   *
   * @returns 音频的点击事件回调函数
   */
  getAudioCallback(): ((url: string) => void) | undefined {
    return this.audioCallback
  }

  /**
   * 获取视频的点击事件
   *
   * @returns 视频的点击事件回调函数
   */
  getVideoCallback(): ((url: string, urlList: Array<string>) => void) | undefined {
    return this.videoCallback
  }

  /**
   * 获取视频的图片替换回调
   *
   * @returns 视频的图片替换回调函数
   */
  getVideoImageCallback(): ((url: string, coverCallback: (coverUrl: string, aspectRatio: number, duration: number) => void) => void) | undefined {
    return this.videoImageCallback
  }

  /**
   * 获取视频发布的点击事件
   *
   * @returns 视频发布的点击事件回调函数
   */
  getVideoReleaseCallback(): ((url: string) => void) | undefined {
    return this.videoReleaseCallback
  }

  /**
   * 获取视频下载的点击事件
   *
   * @returns 视频下载的点击事件回调函数
   */
  getVideoDownloadCallback(): ((url: string) => void) | undefined {
    return this.videoDownloadCallback
  }

  /**
   * 获取代码复制按钮的点击事件
   *
   * @returns 代码复制按钮的点击事件回调函数
   */
  getCodeCopyCallback(): ((code: string) => void) | undefined {
    return this.codeCopyCallback
  }

  /**
   * 获取代码全屏按钮的点击事件
   *
   * @returns 代码全屏按钮的点击事件回调函数
   */
  getCodeFullScreenCallback(): ((code: string, language: string | undefined) => void) | undefined {
    return this.codeFullScreenCallback
  }

  /**
   * 获取数学公式图片点击事件
   *
   * @returns 数学公式图片点击事件回调函数
   */
  getLatexImageCallback(): ((imageData: ArrayBuffer, height: number, width: number) => void) | undefined {
    return this.latexImageCallback
  }

  /**
   * 获取数学公式数据处理事件
   *
   * @returns 数学公式数据处理事件回调函数
   */
  getLatexStrCallback(): ((formula: string) => string) | undefined {
    return this.latexStrCallback
  }

  /**
   * 获取TOC跳转指定位置回调
   *
   * @returns TOC跳转指定位置回调函数
   */
  getTocIndexCallback(): ((index: number | undefined) => void) | undefined {
    return this.tocIndexCallback
  }

  /**
   * 获取脚注跳转指定位置回调
   *
   * @returns 脚注跳转指定位置回调函数
   */
  getFootnoteCallback(): ((index: number | undefined) => void) | undefined {
    return this.footnoteCallback
  }

  /**
   * 获取全局文本对象
   *
   * @returns 全局文本对象
   */
  getMarkdownNodeViewString(): MarkdownNodeViewString {
    return this.markdownNodeViewString
  }

  /**
   * 获取markdown默认样式
   *
   * @returns markdown默认样式对象
   */
  getMarkdownTheme(): MarkdownTheme | undefined {
    return this.markdownTheme
  }

  /**
   * 设置表格复制点击回调
   *
   * @param cb 表格复制点击回调(text：表格纯文本内容)
   */
  setTableCopyCallback(cb: (text: string) => void): MarkdownConfiguration {
    this.tableCopyCallback = cb
    return this
  }

  /**
   * 获取表格复制点击回调
   *
   * @returns 表格复制点击回调函数
   */
  getTableCopyCallback(): ((text: string) => void) | undefined {
    return this.tableCopyCallback
  }

  /**
   * 设置元素曝光回调
   *
   * 链接进入屏幕可见区域时回调 visible=true，离开时回调 visible=false。
   *
   * @param cb 曝光回调(event：{ type, visible, data })
   */
  setElementExposureCallback(cb: (event: MarkdownExposureEvent) => void): MarkdownConfiguration {
    this.elementExposureCallback = cb
    return this
  }

  /**
   * 获取元素曝光回调
   *
   * @returns 曝光回调函数
   */
  getElementExposureCallback(): ((event: MarkdownExposureEvent) => void) | undefined {
    return this.elementExposureCallback
  }

  /**
   * 设置曝光可见阈值
   *
   * @param threshold 0~1，链接与可见区交集面积 / 链接面积 ≥ 此值才算可见
   */
  setExposureThreshold(threshold: number): MarkdownConfiguration {
    this.exposureThreshold = threshold
    return this
  }

  /**
   * 获取曝光可见阈值
   *
   * @returns 曝光可见阈值
   */
  getExposureThreshold(): number | undefined {
    return this.exposureThreshold
  }

  /**
   * 设置高亮段落配置
   *
   * @param highlightParagraph 高亮段落配置对象
   */
  setMarkdownHighlightParagraph(highlightParagraph: MarkdownHighlightParagraph): MarkdownConfiguration {
    this.markdownHighlightParagraph = highlightParagraph
    return this
  }

  /**
   * 获取高亮段落配置
   *
   * @returns 高亮段落配置对象
   */
  getMarkdownHighlightParagraph(): MarkdownHighlightParagraph {
    return this.markdownHighlightParagraph
  }

  /**
   * 设置外层滚动控制器
   *
   * 不固定高度模式下，页面通过此控制器将外层Scroll的滚动Y传递给MarkdownComponent，
   * 实现表格吸顶功能。
   *
   * @param scrollController 外层滚动控制器
   */
  setScrollController(scrollController: MarkdownScrollController): MarkdownConfiguration {
    this.scrollController = scrollController
    return this
  }

  /**
   * 获取外层滚动控制器
   *
   * @returns 外层滚动控制器
   */
  getScrollController(): MarkdownScrollController | undefined {
    return this.scrollController
  }

  /**
   * 设置段落动画开始回调
   *
   * @param cb 段落动画开始回调
   */
  setParagraphHeadingAnimationStart(cb: () => void): MarkdownConfiguration {
    this.paragraphAnimationStart = cb
    return this
  }

  /**
   * 获取段落动画开始回调
   *
   * @returns 段落动画开始回调函数
   */
  getParagraphHeadingAnimationStart(): (() => void) | undefined {
    return this.paragraphAnimationStart
  }

  /**
   * 设置段落动画结束回调
   *
   * @param cb 段落动画结束回调
   */
  setParagraphHeadingAnimationEnd(cb: () => void): MarkdownConfiguration {
    this.paragraphAnimationEnd = cb
    return this
  }

  /**
   * 获取段落动画结束回调
   *
   * @returns 段落动画结束回调函数
   */
  getParagraphHeadingAnimationEnd(): (() => void) | undefined {
    return this.paragraphAnimationEnd
  }

  /**
   * 设置段落长按回调
   *
   * @param cb 长按段落回调，参数为当前段落的纯文本内容
   */
  setCustomLongPressCallback(cb: (text: string) => void): MarkdownConfiguration {
    this.customLongPressCallback = cb
    return this
  }

  /**
   * 获取段落长按回调
   *
   * @returns 长按段落回调函数
   */
  getCustomLongPressCallback(): ((text: string) => void) | undefined {
    return this.customLongPressCallback
  }

  /**
   * 设置满足自定义块级图片的条件
   *
   * @param cb 满足自定义块级图片的条件
   */
  setIsBlockImageCustom(cb: (url: string) => boolean): MarkdownConfiguration {
    this.isBlockImageCustom = cb
    return this
  }

  /**
   * 获取满足自定义块级图片的条件
   *
   * @returns 满足自定义块级图片的条件
   */
  getIsBlockImageCustom(): ((url: string) => boolean) | undefined {
    return this.isBlockImageCustom
  }

  /**
   * 设置满足自定义行内图片的条件
   *
   * @param cb 满足自定义行内图片的条件
   */
  setIsInLineImageCustom(cb: (url: string) => boolean): MarkdownConfiguration {
    this.isInLineImageCustom = cb
    return this
  }

  /**
   * 获取满足自定义行内图片的条件
   *
   * @returns 满足自定义行内图片的条件
   */
  getIsInLineImageCustom(): ((url: string) => boolean) | undefined {
    return this.isInLineImageCustom
  }

  /**
   * 设置满足自定义行内链接的条件
   *
   * @param cb 满足自定义行内链接的条件
   */
  setIsInLineLinkCustom(cb: (url: string) => boolean): MarkdownConfiguration {
    this.isInLineLinkCustom = cb
    return this
  }

  /**
   * 获取满足自定义行内链接的条件
   *
   * @returns 满足自定义行内链接的条件
   */
  getIsInLineLinkCustom(): ((url: string) => boolean) | undefined {
    return this.isInLineLinkCustom
  }
}