import { MarkdownNodeViewString } from "./CJMarkDown"
import { MarkdownTheme } from "./MarkdownTheme"

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
  private imageCallbackCallback?: (url: string) => Promise<ArrayBuffer | undefined> = undefined
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
   * 设置链接点击回调
   *
   * @param cb 链接点击回调(url：链接url)
   */
  setLinkCallback(cb: (url: string) => void): void {
    this.linkCallback = cb
  }

  /**
   * 设置文本复制的点击事件
   *
   * @param cb 文本复制的点击事件(text：复制的文本)
   */
  setTextCopyCallback(cb: (text: string) => void): void {
    this.textCopyCallback = cb
  }

  /**
   * 设置图片点击回调
   *
   * @param cb 图片点击回调。 (url：图片url,urlList：所有图片和视频链接集合 --- 需要加载图片视频列表url集合列表解析插件)
   */
  setImageCallback(cb: (url: string, urlList: Array<string>) => void): void {
    this.imageCallback = cb
  }

  /**
   * 设置图片替换事件
   *
   * @param cb 图片替换事件。 (url：图片url 返回值是替换的图片数据)
   */
  setImageCallbackCallback(cb: (url: string) => Promise<ArrayBuffer | undefined>): void {
    this.imageCallbackCallback = cb
  }

  /**
   * 设置图片下载的点击事件
   *
   * @param cb 图片下载的点击事件。 (url：图片url)
   */
  setImageDownloadCallback(cb: (url: string) => void): void {
    this.imageDownloadCallback = cb
  }

  /**
   * 设置音频点击回调
   *
   * @param cb 音频点击回调(url：音频url) --- 需要加载音频解析插件
   */
  setAudioCallback(cb: (url: string) => void): void {
    this.audioCallback = cb
  }

  /**
   * 设置视频点击回调
   *
   * @param cb 视频点击回调。 (url：视频url,urlList：所有图片和视频链接集合 --- 需要加载图片视频列表url集合列表解析插件) --- 需要加载视频解析插件
   */
  setVideoCallback(cb: (url: string, urlList: Array<string>) => void): void {
    this.videoCallback = cb
  }

  /**
   * 设置视频占位图和宽高比和视频时长的回调
   *
   * @param cb 视频占位图和宽高比和视频时长回调。 (url：视频url,coverCallback：视频占位图和宽高比和视频时长回调 (coverUrl：视频首帧图,aspectRatio：图片宽高比,duration：视频时长)) --- 需要加载视频解析插件
   */
  setVideoImageCallback(cb: (url: string, coverCallback: (coverUrl: string, aspectRatio: number, duration: number) => void) => void): void {
    this.videoImageCallback = cb
  }

  /**
   * 设置视频发布的点击事件
   *
   * @param cb 视频发布的点击事件(url：视频url) --- 需要加载视频解析插件
   */
  setVideoReleaseCallback(cb: (url: string) => void): void {
    this.videoReleaseCallback = cb
  }

  /**
   * 设置视频下载的点击事件
   *
   * @param cb 视频下载的点击事件(url：视频url) --- 需要加载视频解析插件
   */
  setVideoDownloadCallback(cb: (url: string) => void): void {
    this.videoDownloadCallback = cb
  }

  /**
   * 设置代码复制点击回调
   *
   * @param cb 代码复制点击回调(code：代码内容)
   */
  setCodeCopyCallback(cb: (code: string) => void): void {
    this.codeCopyCallback = cb
  }

  /**
   * 设置代码全屏点击回调
   *
   * @param cb 代码全屏点击回调(code：代码内容, language：代码类型)
   */
  setCodeFullScreenCallback(cb: (code: string, language: string | undefined) => void): void {
    this.codeFullScreenCallback = cb
  }

  /**
   * 设置数学公式点击回调
   *
   * @param cb 数学公式点击回调(imageData：数学公式图片数组数据, height：图片高度, width：图片宽度) --- 需要加载数学公式解析插件
   */
  setLatexImageCallback(cb: (imageData: ArrayBuffer, height: number, width: number) => void): void {
    this.latexImageCallback = cb
  }

  /**
   * 设置数学公式公式预处理回调
   *
   * @param cb 数学公式公式预处理回调(formula：数学公式文本内容,return：处理过后的数学公式文本) --- 需要加载数学公式解析插件
   */
  setLatexStrCallback(cb: (formula: string) => string): void {
    this.latexStrCallback = cb
  }

  /**
   * 设置TOC点击回调
   *
   * @param cb TOC点击回调(index：第几条数据) --- 需要加载TOC解析插件
   */
  setTocIndexCallback(cb: (index: number | undefined) => void): void {
    this.tocIndexCallback = cb
  }

  /**
   * 设置脚注点击回调
   *
   * @param cb 脚注点击回调(index：第几条数据) --- 需要加载脚注解析插件
   */
  setFootnoteCallback(cb: (index: number | undefined) => void): void {
    this.footnoteCallback = cb
  }

  /**
   * 设置全局文本对象
   *
   * @param nodeString 全局文本对象
   */
  setNodeString(nodeString: MarkdownNodeViewString): void {
    this.markdownNodeViewString = nodeString
  }

  /**
   * 设置markdown样式
   *
   * @param markdownTheme markdown样式
   */
  setMarkdownTheme(markdownTheme: MarkdownTheme): void {
    this.markdownTheme = markdownTheme
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
  getImageCallbackCallback(): ((url: string) => Promise<ArrayBuffer | undefined>) | undefined {
    return this.imageCallbackCallback
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
}