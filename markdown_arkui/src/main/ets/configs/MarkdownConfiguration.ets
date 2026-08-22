import { MarkdownTheme } from "../theme/MarkdownTheme"
import { MarkdownHighlightParagraph } from "./MarkdownHighlightParagraph"
import { MarkdownNodeViewString } from "./MarkdownNodeViewString"
import { MarkdownExposureEvent } from "../model/MarkdownExposureEvent"

/**
 * markdown配置
 */
@Observed
export class MarkdownConfiguration {
  linkCallback?: (url: string) => void = undefined // 链接的点击事件
  textCopyCallback?: (text: string) => void = undefined // 文本复制的点击事件
  imageCallback?: (url: string, urlList: Array<string>) => void = undefined // 图片的点击事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> = undefined // 图片替换事件
  imageDownloadCallback?: (url: string) => void = undefined // 图片下载的点击事件
  audioCallback?: (url: string) => void = undefined // 音频的点击事件
  videoCallback?: (url: string, urlList: Array<string>) => void = undefined // 视频的点击事件
  videoImageCallback?: (url: string, coverCallback: (coverUrl: string, aspectRatio: number, duration: number) => void) => void = undefined // 视频的图片替换回调
  videoReleaseCallback?: (url: string) => void = undefined // 视频发布的点击事件
  videoDownloadCallback?: (url: string) => void = undefined // 视频下载的点击事件
  codeCopyCallback?: (code: string) => void = undefined // 代码复制按钮的点击事件
  codeFullScreenCallback?: (code: string, language: string | undefined) => void = undefined // 代码全屏按钮的点击事件
  tocIndexCallback?: (index: number | undefined) => void = undefined // TOC跳转指定位置
  footnoteCallback?: (index: number | undefined) => void = undefined // 脚注跳转指定位置
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void = undefined // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  tableCopyCallback?: (text: string) => void = undefined // 表格复制点击事件
  customLongPressCallback?: () => void = undefined // 自定义长按事件
  paragraphHeadingAnimationStart?: () => void = undefined // 段落动画开始回调
  paragraphHeadingAnimationEnd?: () => void = undefined // 段落动画结束回调

  markdownHighlightParagraph: MarkdownHighlightParagraph = new MarkdownHighlightParagraph() // 高亮段落设置
  markdownNodeViewString: MarkdownNodeViewString = new MarkdownNodeViewString() // 获取全局文本
  markdownTheme: MarkdownTheme = new MarkdownTheme() // markdown默认样式
  elementExposureCallback?: (event: MarkdownExposureEvent) => void = undefined // 元素曝光回调（链接显示/消失时触发）
  exposureThreshold: number = 0.5 // 曝光可见阈值（0~1，链接与可见区交集面积/链接面积 ≥ 此值才算可见）

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
   * 设置元素曝光回调
   * 链接（eventType='link'）进入屏幕可见区域时回调 visible=true，离开时回调 visible=false。
   * 可见判定：链接渲染矩形与段落在屏可见区交集面积 / 链接面积 ≥ exposureThreshold。
   * 同一链接持续停留不重复触发；滚出后再滚入会再次触发（一次显示+一次消失成对）。
   *
   * @param cb 曝光回调(event：{ eventType, visible, data })
   */
  setElementExposureCallback(cb: (event: MarkdownExposureEvent) => void): MarkdownConfiguration {
    this.elementExposureCallback = cb
    return this
  }

  /**
   * 设置曝光可见阈值
   *
   * @param threshold 0~1，链接与可见区交集面积 / 链接面积 ≥ 此值才算可见。0=漏出任意像素即可见
   */
  setExposureThreshold(threshold: number): MarkdownConfiguration {
    if (threshold < 0) {
      this.exposureThreshold = 0
    } else if (threshold > 1) {
      this.exposureThreshold = 1
    } else {
      this.exposureThreshold = threshold
    }
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
   * 设置表格复制的点击事件
   *
   * @param cb 文本复制的点击事件(text：复制的文本)
   */
  setTableCopyCallback(cb: (text: string) => void): MarkdownConfiguration {
    this.tableCopyCallback = cb
    return this
  }

  /**
   * 设置段落动画开始回调
   *
   * @param cb 段落动画开始回调
   */
  setParagraphHeadingAnimationStart(cb: () => void): MarkdownConfiguration {
    this.paragraphHeadingAnimationStart = cb
    return this
  }

  /**
   * 设置段落动画结束回调
   *
   * @param cb 段落动画结束回调
   */
  setParagraphHeadingAnimationEnd(cb: () => void): MarkdownConfiguration {
    this.paragraphHeadingAnimationEnd = cb
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
   * 设置数学公式图片点击回调
   *
   * @param cb 数学公式图片点击回调(data：图片数据,height：图片高度-单位px,width：图片宽度-单位px) --- 需要加载formula_hybrid
   */
  setLatexImageCallback(cb: (data: ArrayBuffer, height: number, width: number) => void): MarkdownConfiguration {
    this.latexImageCallback = cb
    return this
  }

  /**
   * 设置数学公式数据处理事件
   *
   * @param cb 数学公式数据处理事件(str：数学公式文本 返回值是处理后的数学公式文本) --- 需要加载formula_hybrid
   */
  setLatexStrCallback(cb: (str: string) => string): MarkdownConfiguration {
    this.latexStrCallback = cb
    return this
  }

  /**
   * 自定义长按事件
   *
   * @param cb 自定义长按事件
   */
  setLongCallback(cb: () => void): void {
    this.customLongPressCallback = cb
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
   * 获取高亮设置对象
   */
  getMarkdownHighlightParagraph(): MarkdownHighlightParagraph {
    return this.markdownHighlightParagraph
  }
}