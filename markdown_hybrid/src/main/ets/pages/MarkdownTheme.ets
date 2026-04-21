import { MarkdownThemeGlobal } from "./MarkdownThemeGlobal"
import { MarkdownThemeAudio } from "./MarkdownThemeAudio"
import { MarkdownThemeBanner } from "./MarkdownThemeBanner"
import { MarkdownThemeBlockQuote } from "./MarkdownThemeBlockQuote"
import { MarkdownThemeBold } from "./MarkdownThemeBold"
import { MarkdownThemeCodeBlock } from "./MarkdownThemeCodeBlock"
import { MarkdownThemeDefinitionList } from "./MarkdownThemeDefinitionList"
import { MarkdownThemeDivider } from "./MarkdownThemeDivider"
import { MarkdownThemeFootnoteDef } from "./MarkdownThemeFootnoteDef"
import { MarkdownThemeFootnoteRef } from "./MarkdownThemeFootnoteRef"
import { MarkdownThemeLatexMath } from "./MarkdownThemeLatexMath"
import { MarkdownThemeHeading } from "./MarkdownThemeHeading"
import { MarkdownThemeHtmlUnderline } from "./MarkdownThemeHtmlUnderline"
import { MarkdownThemeImage } from "./MarkdownThemeImage"
import { MarkdownThemeInlineCode } from "./MarkdownThemeInlineCode"
import { MarkdownThemeItalic } from "./MarkdownThemeItalic"
import { MarkdownThemeLink } from "./MarkdownThemeLink"
import { MarkdownThemeOrderedList } from "./MarkdownThemeOrderedList"
import { MarkdownThemeParagraph } from "./MarkdownThemeParagraph"
import { MarkdownThemeStrikethrough } from "./MarkdownThemeStrikethrough"
import { MarkdownThemeSub } from "./MarkdownThemeSub"
import { MarkdownThemeSup } from "./MarkdownThemeSup"
import { MarkdownThemeTable } from "./MarkdownThemeTable"
import { MarkdownThemeVideo } from "./MarkdownThemeVideo"
import { MarkdownThemeBulletList } from "./MarkdownThemeBulletList"

/**
 * Markdown用户可设置的样式
 */
export class MarkdownTheme {
  /**
   * 上下文
   */
  context?: Context = undefined

  /**
   * 代码深浅色模式
   */
  isDark?: boolean = undefined

  /**
   * 是否按照链接文本字体大小显示文本
   */
  isLinkSize?: boolean = undefined

  /**
   * 全局样式
   */
  markdownThemeGlobal: MarkdownThemeGlobal = new MarkdownThemeGlobal()

  /**
   * 音频样式
   */
  markdownThemeAudio: MarkdownThemeAudio = new MarkdownThemeAudio()

  /**
   * Banner样式
   */
  markdownThemeBanner: MarkdownThemeBanner = new MarkdownThemeBanner()

  /**
   * 块引用样式
   */
  markdownThemeBlockQuote: MarkdownThemeBlockQuote = new MarkdownThemeBlockQuote()

  /**
   * 加粗文本样式
   */
  markdownThemeBold: MarkdownThemeBold = new MarkdownThemeBold()

  /**
   * 代码块样式
   */
  markdownThemeCodeBlock: MarkdownThemeCodeBlock = new MarkdownThemeCodeBlock()

  /**
   * 定义列表样式
   */
  markdownThemeDefinitionList: MarkdownThemeDefinitionList = new MarkdownThemeDefinitionList()

  /**
   * 分割线样式
   */
  markdownThemeDivider: MarkdownThemeDivider = new MarkdownThemeDivider()

  /**
   * 脚注定义样式
   */
  markdownThemeFootnoteDef: MarkdownThemeFootnoteDef = new MarkdownThemeFootnoteDef()

  /**
   * 脚注引用样式
   */
  markdownThemeFootnoteRef: MarkdownThemeFootnoteRef = new MarkdownThemeFootnoteRef()

  /**
   * 数学公式样式
   */
  markdownThemeLatexMath: MarkdownThemeLatexMath = new MarkdownThemeLatexMath()

  /**
   * 标题样式
   */
  markdownThemeHeading: MarkdownThemeHeading = new MarkdownThemeHeading()

  /**
   * HTML下划线文本样式
   */
  markdownThemeHtmlUnderline: MarkdownThemeHtmlUnderline = new MarkdownThemeHtmlUnderline()

  /**
   * 图片样式
   */
  markdownThemeImage: MarkdownThemeImage = new MarkdownThemeImage()

  /**
   * 内联代码样式
   */
  markdownThemeInlineCode: MarkdownThemeInlineCode = new MarkdownThemeInlineCode()

  /**
   * 斜体文本样式
   */
  markdownThemeItalic: MarkdownThemeItalic = new MarkdownThemeItalic()

  /**
   * 链接文本样式
   */
  markdownThemeLink: MarkdownThemeLink = new MarkdownThemeLink()

  /**
   * 有序列表样式
   */
  markdownThemeOrderedList: MarkdownThemeOrderedList = new MarkdownThemeOrderedList()

  /**
   * 段落样式
   */
  markdownThemeParagraph: MarkdownThemeParagraph = new MarkdownThemeParagraph()

  /**
   * 删除线文本样式
   */
  markdownThemeStrikethrough: MarkdownThemeStrikethrough = new MarkdownThemeStrikethrough()

  /**
   * 下标文本样式
   */
  markdownThemeSub: MarkdownThemeSub = new MarkdownThemeSub()

  /**
   * 上标文本样式
   */
  markdownThemeSup: MarkdownThemeSup = new MarkdownThemeSup()

  /**
   * 表格样式
   */
  markdownThemeTable: MarkdownThemeTable = new MarkdownThemeTable()

  /**
   * 无序/任务列表样式
   */
  markdownThemeBulletList: MarkdownThemeBulletList = new MarkdownThemeBulletList()

  /**
   * 视频样式
   */
  markdownThemeVideo: MarkdownThemeVideo = new MarkdownThemeVideo()

  /**
   * 设置上下文
   *
   * @param context 上下文
   */
  setContext(context: Context): void {
    this.context = context
  }

  /**
   * 设置全局样式
   *
   * @param markdownThemeGlobal 全局样式
   */
  setMarkdownThemeGlobal(markdownThemeGlobal: MarkdownThemeGlobal): void {
    this.markdownThemeGlobal = markdownThemeGlobal
  }

  /**
   * 设置音频样式
   *
   * @param markdownThemeAudio 音频样式
   */
  setMarkdownThemeAudio(markdownThemeAudio: MarkdownThemeAudio): void {
    this.markdownThemeAudio = markdownThemeAudio
  }

  /**
   * 设置Banner样式
   *
   * @param markdownThemeBanner Banner样式
   */
  setMarkdownThemeBanner(markdownThemeBanner: MarkdownThemeBanner): void {
    this.markdownThemeBanner = markdownThemeBanner
  }

  /**
   * 设置块引用样式
   *
   * @param markdownThemeBlockQuote 块引用样式
   */
  setMarkdownThemeBlockQuote(markdownThemeBlockQuote: MarkdownThemeBlockQuote): void {
    this.markdownThemeBlockQuote = markdownThemeBlockQuote
  }

  /**
   * 设置加粗文本样式
   *
   * @param markdownThemeBold 加粗文本样式
   */
  setMarkdownThemeBold(markdownThemeBold: MarkdownThemeBold): void {
    this.markdownThemeBold = markdownThemeBold
  }

  /**
   * 设置代码块样式
   *
   * @param markdownThemeCodeBlock 代码块样式
   */
  setMarkdownThemeCodeBlock(markdownThemeCodeBlock: MarkdownThemeCodeBlock): void {
    this.markdownThemeCodeBlock = markdownThemeCodeBlock
  }

  /**
   * 设置定义列表样式
   *
   * @param markdownThemeDefinitionList 定义列表样式
   */
  setMarkdownThemeDefinitionList(markdownThemeDefinitionList: MarkdownThemeDefinitionList): void {
    this.markdownThemeDefinitionList = markdownThemeDefinitionList
  }

  /**
   * 设置分割线样式
   *
   * @param markdownThemeDivider 分割线样式
   */
  setMarkdownThemeDivider(markdownThemeDivider: MarkdownThemeDivider): void {
    this.markdownThemeDivider = markdownThemeDivider
  }

  /**
   * 设置脚注定义样式
   *
   * @param markdownThemeFootnoteDef 脚注定义样式
   */
  setMarkdownThemeFootnoteDef(markdownThemeFootnoteDef: MarkdownThemeFootnoteDef): void {
    this.markdownThemeFootnoteDef = markdownThemeFootnoteDef
  }

  /**
   * 设置脚注引用样式
   *
   * @param markdownThemeFootnoteRef 脚注引用样式
   */
  setMarkdownThemeFootnoteRef(markdownThemeFootnoteRef: MarkdownThemeFootnoteRef): void {
    this.markdownThemeFootnoteRef = markdownThemeFootnoteRef
  }

  /**
   * 设置数学公式样式
   *
   * @param markdownThemeLatexMath 数学公式样式
   */
  setMarkdownThemeLatexMath(markdownThemeLatexMath: MarkdownThemeLatexMath): void {
    this.markdownThemeLatexMath = markdownThemeLatexMath
  }

  /**
   * 设置标题样式
   *
   * @param markdownThemeHeading 标题样式
   */
  setMarkdownThemeHeading(markdownThemeHeading: MarkdownThemeHeading): void {
    this.markdownThemeHeading = markdownThemeHeading
  }

  /**
   * 设置HTML下划线文本样式
   *
   * @param markdownThemeHtmlUnderline HTML下划线文本样式
   */
  setMarkdownThemeHtmlUnderline(markdownThemeHtmlUnderline: MarkdownThemeHtmlUnderline): void {
    this.markdownThemeHtmlUnderline = markdownThemeHtmlUnderline
  }

  /**
   * 设置图片样式
   *
   * @param markdownThemeImage 图片样式
   */
  setMarkdownThemeImage(markdownThemeImage: MarkdownThemeImage): void {
    this.markdownThemeImage = markdownThemeImage
  }

  /**
   * 设置内联代码样式
   *
   * @param markdownThemeInlineCode 内联代码样式
   */
  setMarkdownThemeInlineCode(markdownThemeInlineCode: MarkdownThemeInlineCode): void {
    this.markdownThemeInlineCode = markdownThemeInlineCode
  }

  /**
   * 设置斜体文本样式
   *
   * @param markdownThemeItalic 斜体文本样式
   */
  setMarkdownThemeItalic(markdownThemeItalic: MarkdownThemeItalic): void {
    this.markdownThemeItalic = markdownThemeItalic
  }

  /**
   * 设置链接文本样式
   *
   * @param markdownThemeLink 链接文本样式
   */
  setMarkdownThemeLink(markdownThemeLink: MarkdownThemeLink): void {
    this.markdownThemeLink = markdownThemeLink
  }

  /**
   * 设置有序列表样式
   *
   * @param markdownThemeOrderedList 有序列表样式
   */
  setMarkdownThemeOrderedList(markdownThemeOrderedList: MarkdownThemeOrderedList): void {
    this.markdownThemeOrderedList = markdownThemeOrderedList
  }

  /**
   * 设置段落样式
   *
   * @param markdownThemeParagraph 段落样式
   */
  setMarkdownThemeParagraph(markdownThemeParagraph: MarkdownThemeParagraph): void {
    this.markdownThemeParagraph = markdownThemeParagraph
  }

  /**
   * 设置删除线文本样式
   *
   * @param markdownThemeStrikethrough 删除线文本样式
   */
  setMarkdownThemeStrikethrough(markdownThemeStrikethrough: MarkdownThemeStrikethrough): void {
    this.markdownThemeStrikethrough = markdownThemeStrikethrough
  }

  /**
   * 设置下标文本样式
   *
   * @param markdownThemeSub 下标文本样式
   */
  setMarkdownThemeSub(markdownThemeSub: MarkdownThemeSub): void {
    this.markdownThemeSub = markdownThemeSub
  }

  /**
   * 设置上标文本样式
   *
   * @param markdownThemeSup 上标文本样式
   */
  setMarkdownThemeSup(markdownThemeSup: MarkdownThemeSup): void {
    this.markdownThemeSup = markdownThemeSup
  }

  /**
   * 设置表格样式
   *
   * @param markdownThemeTable 表格样式
   */
  setMarkdownThemeTable(markdownThemeTable: MarkdownThemeTable): void {
    this.markdownThemeTable = markdownThemeTable
  }

  /**
   * 设置无序/任务列表样式
   *
   * @param markdownThemeBulletList 无序/任务列表样式
   */
  setMarkdownThemeBulletList(markdownThemeBulletList: MarkdownThemeBulletList): void {
    this.markdownThemeBulletList = markdownThemeBulletList
  }

  /**
   * 设置视频样式
   *
   * @param markdownThemeVideo 视频样式
   */
  setMarkdownThemeVideo(markdownThemeVideo: MarkdownThemeVideo): void {
    this.markdownThemeVideo = markdownThemeVideo
  }

  /**
   * 设置代码块全屏图片icon
   *
   * @param codeFullScreenIcon 代码块全屏图片icon
   */
  setCodeFullScreenIcon(codeFullScreenIcon: Resource): void {
    this.markdownThemeCodeBlock.setCodeBlockFullScreenIcon(codeFullScreenIcon)
  }

  /**
   * 设置代码块复制图片icon
   *
   * @param codeCopyIcon 代码块复制图片icon
   */
  setCodeCopyIcon(codeCopyIcon: Resource): void {
    this.markdownThemeCodeBlock.setCodeBlockCopyIcon(codeCopyIcon)
  }

  /**
   * 设置音频图片icon
   *
   * @param audioIcon 音频图片icon
   */
  setAudioIcon(audioIcon: Resource): void {
    this.markdownThemeAudio.setAudioIcon(audioIcon)
  }

  /**
   * 设置视频默认占位图
   *
   * @param videoImage 视频默认占位图
   */
  setVideoImage(videoImage: Resource): void {
    this.markdownThemeVideo.setVideoPlaceholder(videoImage)
  }

  /**
   * 设置视频播放按钮icon
   *
   * @param playCircleFillIcon 视频播放按钮icon
   */
  setPlayCircleFillIcon(playCircleFillIcon: Resource): void {
    this.markdownThemeVideo.setVideoPlayIcon(playCircleFillIcon)
  }

  /**
   * 设置banner占位图
   *
   * @param bannerImage banner占位图
   */
  setBannerImage(bannerImage: Resource): void {
    this.markdownThemeBanner.setBannerPlaceholder(bannerImage)
  }

  /**
   * 设置图片占位图
   *
   * @param imageResource 图片占位图
   */
  setImageResource(imageResource: Resource): void {
    this.markdownThemeImage.setImagePlaceholder(imageResource)
  }

  /**
   * 设置视频发布默认图标
   *
   * @param videoReleaseImage 视频发布默认图标
   */
  setVideoReleaseImage(videoReleaseImage: Resource): void {
    this.markdownThemeVideo.setVideoReleaseButtonIcon(videoReleaseImage)
  }

  /**
   * 设置视频下载默认图标
   *
   * @param videoDownloadImage 视频下载默认图标
   */
  setVideoDownloadImage(videoDownloadImage: Resource): void {
    this.markdownThemeVideo.setVideoDownloadButtonIcon(videoDownloadImage)
  }

  /**
   * 设置图片下载默认图标
   *
   * @param imageDownloadImage 图片下载默认图标
   */
  setImageDownloadImage(imageDownloadImage: Resource): void {
    this.markdownThemeImage.setImageDownloadButtonIcon(imageDownloadImage)
  }

  /**
   * 设置markdown是否同步解析
   *
   * @param isMarkdownParserSync markdown是否同步解析 - 默认false
   */
  setIsMarkdownParserSync(isMarkdownParserSync: boolean): void {
    this.markdownThemeGlobal.setIsMarkdownParserSync(isMarkdownParserSync)
  }

  /**
   * 设置是否打开长按复制粘贴
   *
   * @param isOnCopy 是否打开长按复制粘贴 - 默认true
   */
  setIsOnCopy(isOnCopy: boolean): void {
    this.markdownThemeGlobal.setIsOnCopy(isOnCopy)
  }

  /**
   * 设置markdown第一个模块上边距
   *
   * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
   */
  setBlockFirstTopMargin(blockFirstTopMargin: number): void {
    this.markdownThemeGlobal.setMargin(blockFirstTopMargin)
  }

  /**
   * 设置markdown最后一个模块下边距
   *
   * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
   */
  setBlockLastBottomMargin(blockLastBottomMargin: number): void {
    this.markdownThemeGlobal.setMargin(undefined, undefined, blockLastBottomMargin, undefined)
  }

  /**
   * 设置模块间上下间距
   *
   * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
   */
  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): void {
    this.markdownThemeGlobal.setMarkdownBlockSpacing(blockTopAndBottomMargins)
  }

  /**
   * 设置链接是否是图片显示
   *
   * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   */
  setIsLinkStyle(isLinkStyle: boolean): void {
    this.markdownThemeLink.setLinkIsIcon(isLinkStyle)
  }

  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   */
  setIsListLinkStyle(isListLinkStyle: boolean): void {
    this.markdownThemeLink.setLinkListIsIcon(isListLinkStyle)
  }

  /**
   * 设置文本格式链接文本颜色
   *
   * @param linkColor 文本格式链接文本颜色 - 默认0XFF0000FF
   */
  setLinkColor(linkColor: number): void {
    this.markdownThemeLink.setLinkTextFontColor(linkColor)
  }

  /**
   * 设置是否按照链接文本字体大小显示文本
   *
   * @param isLinkSize 是否按照链接文本字体大小显示文本 - true：显示链接字体文本大小；false：跟随标题段落大小显示。默认true
   */
  setIsLinkSize(isLinkSize: boolean): void {
    this.isLinkSize = isLinkSize
  }

  /**
   * 设置文本格式链接文字大小
   *
   * @param linkSize 文本格式链接文字大小 - 默认14.0fp
   */
  setLinkSize(linkSize: number): void {
    this.markdownThemeLink.setLinkTextFontSize(linkSize)
  }

  /**
   * 设置文本格式链接文字行高
   *
   * @param linkLineHeight 文本格式链接文字行高
   */
  setLinkLineHeight(linkLineHeight: number): void {
    this.markdownThemeLink.setLinkTextLineHeight(linkLineHeight)
  }

  /**
   * 设置文本格式链接背景颜色
   *
   * @param linkBackGroupColor 文本格式链接背景颜色 - 默认0XFF000000
   */
  setLinkBackGroupColor(linkBackGroupColor: number): void {
    this.markdownThemeLink.setLinkTextBackgroundColor(linkBackGroupColor)
  }

  /**
   * 设置文本格式是否显示链接下划线
   *
   * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
   */
  setIsLinkUnderlined(isLinkUnderlined: boolean): void {
    if (isLinkUnderlined) { // 显示下划线
      this.markdownThemeLink.setLinkTextDecorationType(TextDecorationType.Underline)
    } else { // 不显示下划线
      this.markdownThemeLink.setLinkTextDecorationType(TextDecorationType.None)
    }
  }

  /**
   * 设置圆形图片格式链接主题背景颜色
   *
   * @param linkCircleImageBackGroupColor 圆形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkCircleImageBackGroupColor(linkCircleImageBackGroupColor: number): void {
    this.markdownThemeLink.setLinkCircleIconBackgroundColor(linkCircleImageBackGroupColor)
  }

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param linkCircleImageButtonBackGroupColor 圆形图片格式链接控件背景颜色 - 默认0XFF000000
   */
  setLinkCircleImageButtonBackGroupColor(linkCircleImageButtonBackGroupColor: number): void {
    this.markdownThemeLink.setLinkCircleIconButtonBackgroundColor(linkCircleImageButtonBackGroupColor)
  }

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkCircleImageTextSize(linkCircleImageTextSize: number): void {
    this.markdownThemeLink.setLinkCircleIconTextSize(linkCircleImageTextSize)
  }

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0XFFFFFFFF
   */
  setLinkCircleImageTextColor(linkCircleImageTextColor: number): void {
    this.markdownThemeLink.setLinkCircleIconTextColor(linkCircleImageTextColor)
  }

  /**
   * 设置圆形图片格式链接半径
   *
   * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
   */
  setLinkCircleImageRadius(linkCircleImageRadius: number): void {
    this.markdownThemeLink.setLinkCircleIconRadius(linkCircleImageRadius)
  }

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkCircleImageMargin(linkCircleImageMargin: number): void {
    this.markdownThemeLink.setLinkCircleIconMargin(linkCircleImageMargin)
  }

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectImageBackGroupColor 圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkRectImageBackGroupColor(linkRectImageBackGroupColor: number): void {
    this.markdownThemeLink.setLinkRectIconBackgroundColor(linkRectImageBackGroupColor)
  }

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectImageButtonBackGroupColor 圆角矩形图片格式链接控件背景颜色 - 默认0XFF000000
   */
  setLinkRectImageButtonBackGroupColor(linkRectImageButtonBackGroupColor: number): void {
    this.markdownThemeLink.setLinkRectIconButtonBackgroundColor(linkRectImageButtonBackGroupColor)
  }

  /**
   * 圆角矩形图片格式链接文字大小
   *
   * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkRectImageTextSize(linkRectImageTextSize: number): void {
    this.markdownThemeLink.setLinkRectIconTextSize(linkRectImageTextSize)
  }

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0XFFFFFFFF
   */
  setLinkRectImageTextColor(linkRectImageTextColor: number): void {
    this.markdownThemeLink.setLinkRectIconTextColor(linkRectImageTextColor)
  }

  /**
   * 圆角矩形图片格式链接控件高度
   *
   * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
   */
  setLinkRectImageHeight(linkRectImageHeight: number): void {
    this.markdownThemeLink.setLinkRectIconHeight(linkRectImageHeight)
  }

  /**
   * 圆角矩形图片格式链接左右内边距
   *
   * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
   */
  setLinkRectImagePadding(linkRectImagePadding: number): void {
    this.markdownThemeLink.setLinkRectIconPadding(linkRectImagePadding)
  }

  /**
   * 圆角矩形图片格式链接圆角半径
   *
   * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
   */
  setLinkRectImageRadius(linkRectImageRadius: number): void {
    this.markdownThemeLink.setLinkRectIconRadius(linkRectImageRadius)
  }

  /**
   * 圆角矩形图片格式链接左右外边距
   *
   * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkRectImageMargin(linkRectImageMargin: number): void {
    this.markdownThemeLink.setLinkRectIconMargin(linkRectImageMargin)
  }

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectToolImageBackGroupColor 空心圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkRectToolImageBackGroupColor(linkRectToolImageBackGroupColor: number): void {
    this.markdownThemeLink.setLinkRectToolIconBackgroundColor(linkRectToolImageBackGroupColor)
  }

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectToolImageButtonBackGroupColor 空心圆角矩形图片格式链接控件背景颜色 - 默认OXFFFFFFFF
   */
  setLinkRectToolImageButtonBackGroupColor(linkRectToolImageButtonBackGroupColor: number): void {
    this.markdownThemeLink.setLinkRectToolIconBackgroundColor(linkRectToolImageButtonBackGroupColor)
  }

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkRectToolImageTextSize(linkRectToolImageTextSize: number): void {
    this.markdownThemeLink.setLinkRectToolIconTextSize(linkRectToolImageTextSize)
  }

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
   */
  setLinkRectToolImageHeight(linkRectToolImageHeight: number): void {
    this.markdownThemeLink.setLinkRectToolIconHeight(linkRectToolImageHeight)
  }

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
   */
  setLinkRectToolImagePadding(linkRectToolImagePadding: number): void {
    this.markdownThemeLink.setLinkRectToolIconPadding(linkRectToolImagePadding)
  }

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
   */
  setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: number): void {
    this.markdownThemeLink.setLinkRectToolIconBorderWidth(linkRectToolImageBorderWidth)
  }

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
   */
  setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: number): void {
    this.markdownThemeLink.setLinkRectToolIconDividingLineWidth(linkRectToolImageDividingLineWidth)
  }

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkRectToolImageMargin(linkRectToolImageMargin: number): void {
    this.markdownThemeLink.setLinkRectToolIconMargin(linkRectToolImageMargin)
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
   */
  setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: number): void {
    this.markdownThemeLink.setLinkRectToolIconLineLeftPadding(linkRectToolImageLineLeftPadding)
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
   */
  setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: number): void {
    this.markdownThemeLink.setLinkRectToolIconLineRightPadding(linkRectToolImageLineRightPadding)
  }

  /**
   * 设置块引用左边距
   *
   * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
   */
  setBlockQuoteLeftMargin(blockQuoteLeftMargin: number): void {
    this.markdownThemeBlockQuote.setBlockQuoteMargin(undefined, undefined, undefined, blockQuoteLeftMargin)
  }

  /**
   * 设置块引用右边距
   *
   * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
   */
  setBlockQuoteRightMargin(blockQuoteRightMargin: number): void {
    this.markdownThemeBlockQuote.setBlockQuoteMargin(undefined, blockQuoteRightMargin, undefined, undefined)
  }

  /**
   * 设置块引用左边线条宽度
   *
   * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
   */
  setBlockQuoteWidth(blockQuoteWidth: number): void {
    this.markdownThemeBlockQuote.setBlockQuoteLeftBorderWidth(blockQuoteWidth)
  }

  /**
   * 设置块引用左边线条颜色
   *
   * @param blockQuoteColor 块引用左边线条颜色 - 默认0XFF191919
   */
  setBlockQuoteColor(blockQuoteColor: number): void {
    this.markdownThemeBlockQuote.setBlockQuoteLeftBorderColor(blockQuoteColor)
  }

  /**
   * 设置块引用背景颜色
   *
   * @param blockQuoteBackGroupColor 块引用背景颜色 - 默认0XFFEAEAEA
   */
  setBlockQuoteBackGroupColor(blockQuoteBackGroupColor: number): void {
    this.markdownThemeBlockQuote.setBlockQuoteBackgroundColor(blockQuoteBackGroupColor)
  }

  /**
   * 设置块引用子模块上下间距
   *
   * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
   */
  setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: number): void {
    this.markdownThemeBlockQuote.setBlockQuoteChildSpacing(blockQuoteTopAndBottomMargins)
  }

  /**
   * 设置有序列表、无序列表、任务列表子模块上下间距
   *
   * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
   */
  setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: number): void {
    this.markdownThemeOrderedList.setOrderedListChildSpacing(blockOrderedAndBulletTopAndBottomMargins)
    this.markdownThemeBulletList.setBulletListChildSpacing(blockOrderedAndBulletTopAndBottomMargins)
  }

  /**
   * 设置有序列表、无序列表、任务列表左边距
   *
   * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
   */
  setBlockLeftMargin(blockLeftMargin: number): void {
    this.markdownThemeOrderedList.setOrderedListMargin(undefined, undefined, undefined, blockLeftMargin)
    this.markdownThemeBulletList.setBulletListMargin(undefined, undefined, undefined, blockLeftMargin)
  }

  /**
   * 设置有序列表、无序列表、任务列表右边距
   *
   * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
   */
  setBlockRightMargin(blockRightMargin: number): void {
    this.markdownThemeOrderedList.setOrderedListMargin(undefined, blockRightMargin, undefined, undefined)
    this.markdownThemeBulletList.setBulletListMargin(undefined, blockRightMargin, undefined, undefined)
  }

  /**
   * 设置有序列表前缀文本是否加粗
   *
   * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
   */
  setOrderedListItemPrefixBold(orderedListItemPrefixBold: boolean): void {
    if (orderedListItemPrefixBold) {
      this.markdownThemeOrderedList.setOrderedListMarkerTextFontWeight(FontWeight.Bold)
    } else {
      this.markdownThemeOrderedList.setOrderedListMarkerTextFontWeight(FontWeight.Normal)
    }
  }

  /**
   * 设置有序列表前缀文本颜色
   *
   * @param orderedListItemColor 有序列表前缀文本颜色 - 默认OXFF191919
   */
  setOrderedListItemColor(orderedListItemColor: number): void {
    this.markdownThemeOrderedList.setOrderedListMarkerTextFontColor(orderedListItemColor)
  }

  /**
   * 设置有序列表前缀文本大小
   *
   * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
   */
  setOrderedListItemSize(orderedListItemSize: number): void {
    this.markdownThemeOrderedList.setOrderedListMarkerTextFontSize(orderedListItemSize)
  }

  /**
   * 设置有序列表前缀文本行高
   *
   * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
   */
  setOrderedListItemLineHeight(orderedListItemLineHeight: number): void {
    this.markdownThemeOrderedList.setOrderedListMarkerTextLineHeight(orderedListItemLineHeight)
  }

  /**
   * 设置无序列表前缀是否全部是实心圆型
   *
   * @param bulletListItemCircle 无序列表前缀是否全部是实心圆型 - 默认false
   */
  setBulletListItemCircle(bulletListItemCircle: boolean): void {
    this.markdownThemeBulletList.setBulletListBulletIsCircle(bulletListItemCircle)
  }

  /**
   * 设置无序列表前缀文本颜色
   *
   * @param bulletListItemColor 无序列表前缀文本颜色 - 默认OXFF191919
   */
  setBulletListItemColor(bulletListItemColor: number): void {
    this.markdownThemeBulletList.setBulletListBulletTextFontColor(bulletListItemColor)
  }

  /**
   * 设置无序列表前缀文本大小
   *
   * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
   */
  setBulletListItemSize(bulletListItemSize: number): void {
    this.markdownThemeBulletList.setBulletListBulletTextFontSize(bulletListItemSize)
  }

  /**
   * 设置无序列表前缀文本行高
   *
   * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
   */
  setBulletListItemLineHeight(bulletListItemLineHeight: number): void {
    this.markdownThemeBulletList.setBulletListBulletTextLineHeight(bulletListItemLineHeight)
  }

  /**
   * 设置任务列表选择框宽高
   *
   * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
   */
  setTaskListItemLength(taskListItemLength: number): void {
    this.markdownThemeBulletList.setBulletListCheckboxWidth(taskListItemLength)
    this.markdownThemeBulletList.setBulletListCheckboxHeight(taskListItemLength)
  }

  /**
   * 设置是否格式化代码块内容
   *
   * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块内容；false：不格式化代码块内容。默认false
   */
  setIsCodeFormat(isCodeFormat: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockIsCodeFormat(isCodeFormat)
  }

  /**
   * 设置内联代码文本颜色
   *
   * @param codeTextColor 内联代码文本颜色 - 默认OXFF000000
   */
  setCodeTextColor(codeTextColor: number): void {
    this.markdownThemeInlineCode.setInlineCodeTextFontColor(codeTextColor)
  }

  /**
   * 设置内联代码背景颜色
   *
   * @param codeBackgroundColor 内联代码背景颜色 - 默认OXFFEAEAEA
   */
  setCodeBackgroundColor(codeBackgroundColor: number): void {
    this.markdownThemeInlineCode.setInlineCodeTextBackgroundColor(codeBackgroundColor)
  }

  /**
   * 设置内联代码文本大小
   *
   * @param codeTextSize 内联代码文本大小 - 默认13.0fp
   */
  setCodeTextSize(codeTextSize: number): void {
    this.markdownThemeInlineCode.setInlineCodeTextFontSize(codeTextSize)
  }

  /**
   * 设置内联代码文本字体
   *
   * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
   */
  setCodeTypeface(codeTypeface: string): void {
    this.markdownThemeInlineCode.setInlineCodeTextFontFamily(codeTypeface)
  }

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
   */
  setIsCodeBlockParserSync(isCodeBlockParserSync: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockParserSync(isCodeBlockParserSync)
  }

  /**
   * 设置代码块代码文本颜色
   *
   * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
   */
  setCodeBlockTextColor(codeBlockTextColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockTextFontColor(codeBlockTextColor)
  }

  /**
   * 设置代码块代码类型文本颜色
   *
   * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
   */
  setCodeBlockTypeTextColor(codeBlockTypeTextColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockTypeTextFontColor(codeBlockTypeTextColor)
  }

  /**
   * 设置代码块代码类型文本
   *
   * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
   */
  setCodeBlockTypeTextStr(codeBlockTypeTextStr: string): void {
    this.markdownThemeCodeBlock.setCodeBlockTypeText(codeBlockTypeTextStr)
  }

  /**
   * 设置代码类型和代码块距离
   *
   * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
   */
  setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: number): void {
    this.markdownThemeCodeBlock.setCodeBlockTitleLayoutMarginBottom(codeBlockTypeTextPadding)
  }

  /**
   * 设置代码块复制、全屏图片文字是否显示
   *
   * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
   */
  setCodeBlockIconTextHide(codeBlockIconTextHide: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockFullScreenTextIsShow(codeBlockIconTextHide)
    this.markdownThemeCodeBlock.setCodeBlockCopyTextIsShow(codeBlockIconTextHide)
  }

  /**
   * 设置代码块代码行号是否显示
   *
   * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
   */
  setCodeBlockLineNumberHide(codeBlockLineNumberHide: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockLineNumberIsShow(codeBlockLineNumberHide)
  }

  /**
   * 设置代码块背景颜色
   *
   * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
   */
  setCodeBlockBackgroundColor(codeBlockBackgroundColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockBackgroundColor(codeBlockBackgroundColor)
  }

  /**
   * 设置代码块左边距
   *
   * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
   */
  setCodeMultilineMargin(codeMultilineMargin: number): void {
    this.markdownThemeCodeBlock.setCodeBlockMargin(undefined, undefined, undefined, codeMultilineMargin)
  }

  /**
   * 设置代码块字体
   *
   * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
   */
  setCodeBlockTypeface(codeBlockTypeface: string): void {
    this.markdownThemeCodeBlock.setCodeBlockTextFontFamily(codeBlockTypeface)
  }

  /**
   * 设置代码块代码文本大小
   *
   * @param codeBlockTextSize 代码块代码文本大小 -  默认13.0fp
   */
  setCodeBlockTextSize(codeBlockTextSize: number): void {
    this.markdownThemeCodeBlock.setCodeBlockTextFontSize(codeBlockTextSize)
  }

  /**
   * 设置代码块代码文本行高
   *
   * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
   */
  setCodeBlockLineHeight(codeBlockLineHeight: number): void {
    this.markdownThemeCodeBlock.setCodeBlockTextLineHeight(codeBlockLineHeight)
  }

  /**
   * 设置代码块控件圆角大小
   *
   * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
   */
  setCodeBlockRadius(codeBlockRadius: number): void {
    this.markdownThemeCodeBlock.setCodeBlockAllRadius(codeBlockRadius)
  }

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
   */
  setIsCodeFullScreen(isCodeFullScreen: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockFullScreenButtonIsShow(isCodeFullScreen)
  }

  /**
   * 设置代码块代码全屏、代码复制按钮宽高
   *
   * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
   */
  setIconWidthAndHeight(iconWidthAndHeight: number): void {
    this.markdownThemeCodeBlock.setCodeBlockFullScreenIconHeight(iconWidthAndHeight)
    this.markdownThemeCodeBlock.setCodeBlockFullScreenIconWidth(iconWidthAndHeight)
    this.markdownThemeCodeBlock.setCodeBlockCopyIconHeight(iconWidthAndHeight)
    this.markdownThemeCodeBlock.setCodeBlockCopyIconWidth(iconWidthAndHeight)
  }

  /**
   * 设置组合代码未选中标题字体大小
   *
   * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
   */
  setCodeListTitleTextSize(codeListTitleTextSize: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleTextSize(codeListTitleTextSize)
  }

  /**
   * 设置组合代码选中标题字体大小
   *
   * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
   */
  setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectTextSize(codeListTitleSelectTextSize)
  }

  /**
   * 设置组合代码选中标题文本颜色
   *
   * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认Color.RED
   */
  setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectTextColor(codeListTitleSelectTextColor)
  }

  /**
   * 设置组合代码未选中标题文本颜色
   *
   * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认Color.BLACK
   */
  setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleUnSelectTextColor(codeListTitleUnSelectTextColor)
  }

  /**
   * 设置组合代码选中标题背景颜色
   *
   * @param codeListTitleSelectBackGroupColor 组合代码选中标题背景颜色 - 默认Color.GRAY
   */
  setCodeListTitleSelectBackGroupColor(codeListTitleSelectBackGroupColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectBackGroupColor(codeListTitleSelectBackGroupColor)
  }

  /**
   * 设置组合代码未选中标题背景颜色
   *
   * @param codeListTitleUnSelectBackGroupColor 组合代码未选中标题背景颜色 - 默认Color.TRANSPARENT
   */
  setCodeListTitleUnSelectBackGroupColor(codeListTitleUnSelectBackGroupColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleUnSelectBackGroupColor(codeListTitleUnSelectBackGroupColor)
  }

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
   */
  setIsSeparateCodeBlock(isSeparateCodeBlock: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockIsSeparate(isSeparateCodeBlock)
  }

  /**
   * 设置单独代码块行号宽度
   *
   * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
   */
  setSeparateCodeBlockWidth(separateCodeBlockWidth: number): void {
    this.markdownThemeCodeBlock.setCodeBlockSeparateWidth(separateCodeBlockWidth)
  }

  /**
   * 设置单独代码块是否居底显示
   *
   * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
   */
  setSeparateCodeIsBottom(separateCodeIsBottom: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockSeparateIsBottom(separateCodeIsBottom)
  }

  /**
   * 设置H1、H2标题下分割线高度
   *
   * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
   */
  setHeadingBreakHeight(headingBreakHeight: number): void {
    this.markdownThemeHeading.setUnderlineHeightForAllHeading(headingBreakHeight)
  }

  /**
   * 设置标题文本字体
   *
   * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
   */
  setHeadingTypeface(headingTypeface: string): void {
    this.markdownThemeHeading.setTextFontFamilyForAllHeading(headingTypeface)
  }

  /**
   * 设置标题模块上间距
   *
   * @param headingTopMargins 标题模块上间距 - 默认8.0
   */
  setHeadingTopMargins(headingTopMargins: number): void {
    this.markdownThemeHeading.setMarginForAllHeadingEachLevel(headingTopMargins, undefined, undefined, undefined)
  }

  /**
   * 设置标题模块下间距
   *
   * @param headingBottomMargins 标题模块下间距 - 默认8.0
   */
  setHeadingBottomMargins(headingBottomMargins: number): void {
    this.markdownThemeHeading.setMarginForAllHeadingEachLevel(undefined, undefined, headingBottomMargins, undefined)
  }

  /**
   * 设置标题文本大小数组
   *
   * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   */
  setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<number>): void {
    if (headingTextSizeMultipliers.length != 6) {
      return
    }
    this.markdownThemeHeading.setTextFontSizeForEachHeading(headingTextSizeMultipliers)
  }

  /**
   * 设置一级标题文本大小
   *
   * @param headingTextSize1 一级标题文本大小 - 默认20.0
   */
  setHeadingTextSize1(headingTextSize1: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(1, headingTextSize1)
  }

  /**
   * 设置二级标题文本大小
   *
   * @param headingTextSize2 二级标题文本大小 - 默认17.0
   */
  setHeadingTextSize2(headingTextSize2: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(2, headingTextSize2)
  }

  /**
   * 设置三级标题文本大小
   *
   * @param headingTextSize3 三级标题文本大小 - 默认16.0
   */
  setHeadingTextSize3(headingTextSize3: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(3, headingTextSize3)
  }

  /**
   * 设置四级标题文本大小
   *
   * @param headingTextSize4 四级标题文本大小 - 默认15.0
   */
  setHeadingTextSize4(headingTextSize4: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(4, headingTextSize4)
  }

  /**
   * 设置五级标题文本大小
   *
   * @param headingTextSize5 五级标题文本大小 - 默认15.0
   */
  setHeadingTextSize5(headingTextSize5: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(5, headingTextSize5)
  }

  /**
   * 设置六级标题文本大小
   *
   * @param headingTextSize6 六级标题文本大小 - 默认13.0
   */
  setHeadingTextSize6(headingTextSize6: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(6, headingTextSize6)
  }

  /**
   * 设置标题文本颜色
   *
   * @param headingTextColor 标题文本颜色 - 默认0XFF191919
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   */
  setHeadingTextColor(headingTextColor: number): void {
    this.markdownThemeHeading.setTextFontColorForAllHeading(headingTextColor)
  }

  /**
   * 设置H1、H2标题下分割线颜色
   *
   * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0XFF191919
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   */
  setHeadingBreakColor(headingBreakColor: number): void {
    this.markdownThemeHeading.setUnderlineColorForAllHeading(headingBreakColor)
  }

  /**
   * 设置标题文本字间距
   *
   * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
   */
  setHeadingTextWordSpace(headingTextWordSpace: number): void {
    this.markdownThemeHeading.setTextLetterSpacingForAllHeading(headingTextWordSpace)
  }

  /**
   * 设置一级标题文本行高
   *
   * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight1(headingTextLineHeight1: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(1, headingTextLineHeight1)
  }

  /**
   * 设置二级标题文本行高
   *
   * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight2(headingTextLineHeight2: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(2, headingTextLineHeight2)
  }

  /**
   * 设置三级标题文本行高
   *
   * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight3(headingTextLineHeight3: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(3, headingTextLineHeight3)
  }

  /**
   * 设置四级标题文本行高
   *
   * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight4(headingTextLineHeight4: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(4, headingTextLineHeight4)
  }

  /**
   * 设置五级标题文本行高
   *
   * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight5(headingTextLineHeight5: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(5, headingTextLineHeight5)
  }

  /**
   * 设置六级标题文本行高
   *
   * @param headingTextLineHeight6 六级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight6(headingTextLineHeight6: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(6, headingTextLineHeight6)
  }

  /**
   * 设置一级标题文本颜色
   *
   * @param headingTextColor1 标题文本颜色
   */
  setHeadingTextColor1(headingTextColor1: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(1, headingTextColor1)
  }

  /**
   * 设置H1标题下分割线颜色
   *
   * @param headingBreakColor1 H1标题下分割线颜色 - 默认0XFF191919
   */
  setHeadingBreakColor1(headingBreakColor1: number): void {
    this.markdownThemeHeading.setUnderlineColorForDesignateHeading(1, headingBreakColor1)
  }

  /**
   * 设置二级标题文本颜色
   *
   * @param headingTextColor2 标题文本颜色
   */
  setHeadingTextColor2(headingTextColor2: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(2, headingTextColor2)
  }

  /**
   * 设置H2标题下分割线颜色
   *
   * @param headingBreakColor2 H2标题下分割线颜色 - 默认0XFF191919
   */
  setHeadingBreakColor2(headingBreakColor2: number): void {
    this.markdownThemeHeading.setUnderlineColorForDesignateHeading(2, headingBreakColor2)
  }

  /**
   * 设置三级标题文本颜色
   *
   * @param headingTextColor3 标题文本颜色
   */
  setHeadingTextColor3(headingTextColor3: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(3, headingTextColor3)
  }

  /**
   * 设置四级标题文本颜色
   *
   * @param headingTextColor4 标题文本颜色
   */
  setHeadingTextColor4(headingTextColor4: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(4, headingTextColor4)
  }

  /**
   * 设置五级标题文本颜色
   *
   * @param headingTextColor5 标题文本颜色
   */
  setHeadingTextColor5(headingTextColor5: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(5, headingTextColor5)
  }

  /**
   * 设置六级标题文本颜色
   *
   * @param headingTextColor6 标题文本颜色
   */
  setHeadingTextColor6(headingTextColor6: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(6, headingTextColor6)
  }

  /**
   * 设置段落模块上间距
   *
   * @param paragraphTopMargins 段落模块上间距 - 默认8.0vp
   */
  setParagraphTopMargins(paragraphTopMargins: number): void {
    this.markdownThemeParagraph.setParagraphMargin(paragraphTopMargins, undefined, undefined, undefined)
  }

  /**
   * 设置段落模块下间距
   *
   * @param paragraphBottomMargins 段落模块下间距 - 默认8.0vp
   */
  setParagraphBottomMargins(paragraphBottomMargins: number): void {
    this.markdownThemeParagraph.setParagraphMargin(undefined, undefined, paragraphBottomMargins, undefined)
  }

  /**
   * 设置段落文本大小
   *
   * @param paragraphTextSize 段落文本大小 - 默认14.0fp
   */
  setParagraphTextSize(paragraphTextSize: number): void {
    this.markdownThemeParagraph.setParagraphTextFontSize(paragraphTextSize)
  }

  /**
   * 设置段落文本颜色
   *
   * @param paragraphTextColor 段落文本颜色 - 默认0XFF191919
   */
  setParagraphTextColor(paragraphTextColor: number): void {
    this.markdownThemeParagraph.setParagraphTextFontColor(paragraphTextColor)
  }

  /**
   * 设置段落文本字间距
   *
   * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
   */
  setParagraphTextWordSpace(paragraphTextWordSpace: number): void {
    this.markdownThemeParagraph.setParagraphTextLetterSpacing(paragraphTextWordSpace)
  }

  /**
   * 设置段落文本行高
   *
   * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
   */
  setParagraphTextLineHeight(paragraphTextLineHeight: number): void {
    this.markdownThemeParagraph.setParagraphTextLineHeight(paragraphTextLineHeight)
  }

  /**
   * 设置段落文本字体
   *
   * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
   */
  setParagraphTypeface(paragraphTypeface: string): void {
    this.markdownThemeParagraph.setParagraphTextFontFamily(paragraphTypeface)
  }

  /**
   * 设置分割线颜色
   *
   * @param thematicBreakColor 分割线颜色 - 默认0XFF191919
   */
  setThematicBreakColor(thematicBreakColor: number): void {
    this.markdownThemeDivider.setDividerColor(thematicBreakColor)
  }

  /**
   * 设置分割线高度
   *
   * @param thematicBreakHeight 分割线高度 - 默认0.5vp
   */
  setThematicBreakHeight(thematicBreakHeight: number): void {
    this.markdownThemeDivider.setDividerStrokeWidth(thematicBreakHeight)
  }

  /**
   * 设置分割线上部外边距
   *
   * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
   */
  setThematicBreakTopMargin(thematicBreakTopMargin: number): void {
    this.markdownThemeDivider.setDividerMargin(thematicBreakTopMargin, undefined, undefined, undefined)
  }

  /**
   * 设置分割线下部外边距
   *
   * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
   */
  setThematicBreakBottomMargin(thematicBreakBottomMargin: number): void {
    this.markdownThemeDivider.setDividerMargin(undefined, undefined, thematicBreakBottomMargin, undefined)
  }

  /**
   * 设置软换行是否换行
   *
   * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
   */
  setIsLineBreak(isLineBreak: boolean): void {
    this.markdownThemeGlobal.setIsLineBreak(isLineBreak)
  }

  /**
   * 设置数学公式未加载状态是否显示文字
   *
   * @param latexDefaultText 数学公式未加载状态是否显示文字 - 默认true
   */
  setLatexDefaultText(latexDefaultText: boolean): void {
    this.markdownThemeLatexMath.setLatexMathDefaultText(latexDefaultText)
  }

  /**
   * 设置数学公式文本大小
   *
   * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
   */
  setLatexMathTextSize(latexMathTextSize: number): void {
    this.markdownThemeLatexMath.setLatexMathDefaultTextFontSize(latexMathTextSize)
  }

  /**
   * 设置数学公式背景色
   *
   * @param latexMathBackGroupColor 数学公式背景色 - 默认Color.TRANSPARENT
   */
  setLatexMathBackGroupColor(latexMathBackGroupColor: number): void {
    this.markdownThemeLatexMath.setLatexMathBackgroundColor(latexMathBackGroupColor)
  }

  /**
   * 设置数学公式文本颜色
   *
   * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
   */
  setLatexMathTextColor(latexMathTextColor: number): void {
    this.markdownThemeLatexMath.setLatexMathTextColor(latexMathTextColor)
  }

  /**
   * 设置数学公式生成图片格式
   *
   * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
   */
  setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): void {
    this.markdownThemeLatexMath.setLatexMathColorFormat(latexMathColorFormat)
  }

  /**
   * 设置块结构的数学公式是否居中
   *
   * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认false
   */
  setLatexMathBlockCenter(latexMathBlockCenter: boolean): void {
    this.markdownThemeLatexMath.setLatexMathBlockCenter(latexMathBlockCenter)
  }

  /**
   * 设置数学公式字体路径
   *
   * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
   */
  setLatexMathResStr(latexMathResStr: string): void {
    this.markdownThemeLatexMath.setLatexMathResPath(latexMathResStr)
  }

  /**
   * 设置音频阴影颜色值
   *
   * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
   */
  setAudioShadowColor(audioShadowColor: number): void {
    this.markdownThemeAudio.setAudioShadowColor(audioShadowColor)
  }

  /**
   * 设置音频边框颜色
   *
   * @param audioBorderColor 音频边框颜色 - 默认0x33000000
   */
  setAudioBorderColor(audioBorderColor: number): void {
    this.markdownThemeAudio.setAudioBorderColor(audioBorderColor)
  }

  /**
   * 设置音频边框粗细
   *
   * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
   */
  setAudioBorderWidth(audioBorderWidth: number): void {
    this.markdownThemeAudio.setAudioBorderWidth(audioBorderWidth)
  }

  /**
   * 设置音频边框圆角
   *
   * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
   */
  setAudioBorderRadius(audioBorderRadius: number): void {
    this.markdownThemeAudio.setAudioAllRadius(audioBorderRadius)
  }

  /**
   * 设置音频按钮背景颜色
   *
   * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认Color.BLACK
   */
  setAudioButtonBackgroundColor(audioButtonBackgroundColor: number): void {
    this.markdownThemeAudio.setAudioButtonBackgroundColor(audioButtonBackgroundColor)
  }

  /**
   * 设置音频按钮文字颜色
   *
   * @param audioButtonTextColor 音频按钮文字颜色 - 默认Color.WHITE
   */
  setAudioButtonTextColor(audioButtonTextColor: number): void {
    this.markdownThemeAudio.setAudioButtonTextFontColor(audioButtonTextColor)
  }

  /**
   * 设置音频按钮文字大小
   *
   * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
   */
  setAudioButtonTextSize(audioButtonTextSize: number): void {
    this.markdownThemeAudio.setAudioButtonTextFontSize(audioButtonTextSize)
  }

  /**
   * 设置音频按钮文字内容
   *
   * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
   */
  setAudioButtonText(audioButtonText: string): void {
    this.markdownThemeAudio.setAudioButtonText(audioButtonText)
  }

  /**
   * 设置音频按钮圆角
   *
   * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
   */
  setAudioButtonBorderRadius(audioButtonBorderRadius: number): void {
    this.markdownThemeAudio.setAudioButtonAllRadius(audioButtonBorderRadius)
  }

  /**
   * 设置音频标题文字大小
   *
   * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
   */
  setAudioTitleTextSize(audioTitleTextSize: number): void {
    this.markdownThemeAudio.setAudioTitleTextFontSize(audioTitleTextSize)
  }

  /**
   * 设置音频标题文字颜色
   *
   * @param audioTitleTextColor音频标题文字颜色 - 默认Color.BLACK
   */
  setAudioTitleTextColor(audioTitleTextColor: number): void {
    this.markdownThemeAudio.setAudioTitleTextFontColor(audioTitleTextColor)
  }

  /**
   * 设置音频标题文字行高
   *
   * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
   */
  setAudioTitleTextLineHeight(audioTitleTextLineHeight: number): void {
    this.markdownThemeAudio.setAudioTitleTextLineHeight(audioTitleTextLineHeight)
  }

  /**
   * 设置音频类型文字大小
   *
   * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
   */
  setAudioTypeTextSize(audioTypeTextSize: number): void {
    this.markdownThemeAudio.setAudioTypeTextFontSize(audioTypeTextSize)
  }

  /**
   * 设置音频类型文字颜色
   *
   * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
   */
  setAudioTypeTextColor(audioTypeTextColor: number): void {
    this.markdownThemeAudio.setAudioTypeTextFontColor(audioTypeTextColor)
  }

  /**
   * 设置音频类型文字行高
   *
   * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
   */
  setAudioTypeTextLineHeight(audioTypeTextLineHeight: number): void {
    this.markdownThemeAudio.setAudioTypeTextLineHeight(audioTypeTextLineHeight)
  }

  /**
   * 设置音频上边距
   *
   * @param audioMarginTop 音频上边距 - 默认10.0vp
   */
  setAudioMarginTop(audioMarginTop: number): void {
    this.markdownThemeAudio.setAudioMargin(audioMarginTop, undefined, undefined, undefined)
  }

  /**
   * 设置音频下边距
   *
   * @param audioMarginBottom 音频下边距 - 默认10.0vp
   */
  setAudioMarginBottom(audioMarginBottom: number): void {
    this.markdownThemeAudio.setAudioMargin(undefined, undefined, audioMarginBottom, undefined)
  }

  /**
   * 设置视频圆角
   *
   * @param videoBorderRadius 视频圆角 - 默认10.0vp
   */
  setVideoBorderRadius(videoBorderRadius: number): void {
    this.markdownThemeVideo.setVideoAllRadius(videoBorderRadius)
  }

  /**
   * 设置视频时间文本颜色
   *
   * @param videoTimeTextColor 视频时间文本颜色 - 默认Color.WHITE
   */
  setVideoTimeTextColor(videoTimeTextColor: number): void {
    this.markdownThemeVideo.setVideoTimeTextFontColor(videoTimeTextColor)
  }

  /**
   * 设置视频时间文本大小
   *
   * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
   */
  setVideoTimeTextSize(videoTimeTextSize: number): void {
    this.markdownThemeVideo.setVideoTimeTextFontSize(videoTimeTextSize)
  }

  /**
   * 设置视频时间文本居右边距
   *
   * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
   */
  setVideoTimeTextMarginRight(videoTimeTextMarginRight: number): void {
    this.markdownThemeVideo.setVideoTimeTextMarginRight(videoTimeTextMarginRight)
  }

  /**
   * 设置视频时间文本居底边距
   *
   * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
   */
  setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: number): void {
    this.markdownThemeVideo.setVideoTimeTextMarginBottom(videoTimeTextMarginBottom)
  }

  /**
   * 设置视频上边距
   *
   * @param videoMarginTop 视频上边距 - 默认10.0vp
   */
  setVideoMarginTop(videoMarginTop: number): void {
    this.markdownThemeVideo.setVideoMargin(videoMarginTop, undefined, undefined, undefined)
  }

  /**
   * 设置视频下边距
   *
   * @param videoMarginBottom 视频下边距 - 默认10.0vp
   */
  setVideoMarginBottom(videoMarginBottom: number): void {
    this.markdownThemeVideo.setVideoMargin(undefined, undefined, videoMarginBottom, undefined)
  }

  /**
   * 设置视频发布/下载按钮布局是否显示
   *
   * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默认false不显示
   */
  setIsVideoBottomLayout(isVideoBottomLayout: boolean): void {
    this.markdownThemeVideo.setVideoBottomLayoutVisible(isVideoBottomLayout)
  }

  /**
   * 设置视频发布按钮图片宽度和高度
   *
   * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
   */
  setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonIconWidth(videoReleaseImageWidthHeight)
    this.markdownThemeVideo.setVideoReleaseButtonIconHeight(videoReleaseImageWidthHeight)
  }

  /**
   * 设置视频发布按钮宽度
   *
   * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
   */
  setVideoReleaseWidth(videoReleaseWidth: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonWidth(videoReleaseWidth)
  }

  /**
   * 设置视频发布按钮高度
   *
   * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
   */
  setVideoReleaseHeight(videoReleaseHeight: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonHeight(videoReleaseHeight)
  }

  /**
   * 设置视频发布按钮圆角
   *
   * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
   */
  setVideoReleaseRadius(videoReleaseRadius: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonAllRadius(videoReleaseRadius)
  }

  /**
   * 设置视频发布按钮文本内容
   *
   * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
   */
  setVideoReleaseText(videoReleaseText: string): void {
    this.markdownThemeVideo.setVideoReleaseButtonText(videoReleaseText)
  }

  /**
   * 设置视频发布按钮文本大小
   *
   * @param videoReleaseTexSize 视频发布按钮文本大小 - 默认16.0vp
   */
  setVideoReleaseTexSize(videoReleaseTexSize: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonTextFontSize(videoReleaseTexSize)
  }

  /**
   * 设置视频发布按钮文本颜色
   *
   * @param videoReleaseTexColor 视频发布按钮文本颜色 - 默认0xE6000000
   */
  setVideoReleaseTexColor(videoReleaseTexColor: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonTextFontColor(videoReleaseTexColor)
  }

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
   */
  setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonBackgroundColor(videoReleaseBackgroundColor)
  }

  /**
   * 设置视频下载按钮图片宽度和高度
   *
   * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
   */
  setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonIconWidth(videoDownloadImageWidthHeight)
    this.markdownThemeVideo.setVideoDownloadButtonIconHeight(videoDownloadImageWidthHeight)
  }

  /**
   * 设置视频下载按钮宽度
   *
   * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
   */
  setVideoDownloadWidth(videoDownloadWidth: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonWidth(videoDownloadWidth)
  }

  /**
   * 设置视频下载按钮高度
   *
   * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
   */
  setVideoDownloadHeight(videoDownloadHeight: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonHeight(videoDownloadHeight)
  }

  /**
   * 设置视频下载按钮圆角
   *
   * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
   */
  setVideoDownloadRadius(videoDownloadRadius: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonAllRadius(videoDownloadRadius)
  }

  /**
   * 设置视频下载按钮文本内容
   *
   * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
   */
  setVideoDownloadText(videoDownloadText: string): void {
    this.markdownThemeVideo.setVideoDownloadButtonText(videoDownloadText)
  }

  /**
   * 设置视频下载按钮文本大小
   *
   * @param videoDownloadTexSize 视频下载按钮文本大小 - 默认16.0vp
   */
  setVideoDownloadTexSize(videoDownloadTexSize: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonTextFontSize(videoDownloadTexSize)
  }

  /**
   * 设置视频下载按钮文本颜色
   *
   * @param videoDownloadTexColor 视频下载按钮文本颜色 - 默认0xE6000000
   */
  setVideoDownloadTexColor(videoDownloadTexColor: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonTextFontColor(videoDownloadTexColor)
  }

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
   */
  setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonBackgroundColor(videoDownloadBackgroundColor)
  }

  /**
   * 设置图片缩放类型
   *
   * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
   */
  setImageFitType(imageFitType: ImageFitType): void {
    this.markdownThemeImage.setImageFitType(imageFitType)
  }

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
   */
  setImageMaximumWidth(imageMaximumWidth: number): void {
    this.markdownThemeImage.setImageMaximumWidth(imageMaximumWidth)
  }

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
   */
  setImageFixedRatioWidth(imageFixedRatioWidth: number): void {
    this.markdownThemeImage.setImageFixedRatioWidth(imageFixedRatioWidth)
  }

  /**
   * 设置图片最大高度
   *
   * @param imageMaxHeight 图片最大高度 - 默认None
   */
  setImageMaxHeight(imageMaxHeight: number): void {
    this.markdownThemeImage.setImageMaxHeight(imageMaxHeight)
  }

  /**
   * 设置图片最大宽度
   *
   * @param imageMaxWidth 图片最大宽度 - 默认None
   */
  setImageMaxWidth(imageMaxWidth: number): void {
    this.markdownThemeImage.setImageMaxWidth(imageMaxWidth)
  }

  /**
   * 设置图片圆角大小
   *
   * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
   */
  setImageBorderRadius(imageBorderRadius: number): void {
    this.markdownThemeImage.setImageAllRadius(imageBorderRadius)
  }

  /**
   * 设置图片边框宽度
   *
   * @param imageBorderWidth 图片边框宽度 - 默认0.0vp
   */
  setImageBorderWidth(imageBorderWidth: number): void {
    this.markdownThemeImage.setImageBorderWidth(imageBorderWidth)
  }

  /**
   * 设置图片边框颜色
   *
   * @param imageBorderColor 图片边框颜色 - 默认Color.BLACK
   */
  setImageBorderColor(imageBorderColor: number): void {
    this.markdownThemeImage.setImageBorderColor(imageBorderColor)
  }

  /**
   * 设置网络图片是否压缩
   *
   * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
   */
  setIsAutoResize(isAutoResize: boolean): void {
    this.markdownThemeImage.setImageAutoResize(isAutoResize)
  }

  /**
   * 设置图片上边距
   *
   * @param imageMarginTop 图片上边距 - 默认10.0vp
   */
  setImageMarginTop(imageMarginTop: number): void {
    this.markdownThemeImage.setImageMargin(imageMarginTop, undefined, undefined, undefined)
  }

  /**
   * 设置图片下边距
   *
   * @param imageMarginBottom 图片下边距 - 默认10.0vp
   */
  setImageMarginBottom(imageMarginBottom: number): void {
    this.markdownThemeImage.setImageMargin(undefined, undefined, imageMarginBottom, undefined)
  }

  /**
   * 设置图片是否有下载按钮
   *
   * @param isImageDownload 图片是否有下载按钮 - 默认false
   */
  setIsImageDownload(isImageDownload: boolean): void {
    this.markdownThemeImage.setImageDownloadButtonVisible(isImageDownload)
  }

  /**
   * 设置是否图文混排
   *
   * @param isImageMixedLayout 是否图文混排 - 默认true
   */
  setIsImageMixedLayout(isImageMixedLayout: boolean): void {
    this.markdownThemeImage.setIsImageMixedLayout(isImageMixedLayout)
  }

  /**
   * 设置图片下载按钮图片宽度和高度
   *
   * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
   */
  setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: number): void {
    this.markdownThemeImage.setImageDownloadButtonIconWidth(imageDownloadImageWidthHeight)
    this.markdownThemeImage.setImageDownloadButtonIconHeight(imageDownloadImageWidthHeight)
  }

  /**
   * 设置图片下载按钮宽度
   *
   * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
   */
  setImageDownloadWidth(imageDownloadWidth: number): void {
    this.markdownThemeImage.setImageDownloadButtonWidth(imageDownloadWidth)
  }

  /**
   * 设置图片下载按钮高度
   *
   * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
   */
  setImageDownloadHeight(imageDownloadHeight: number): void {
    this.markdownThemeImage.setImageDownloadButtonHeight(imageDownloadHeight)
  }

  /**
   * 设置图片下载按钮圆角
   *
   * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
   */
  setImageDownloadRadius(imageDownloadRadius: number): void {
    this.markdownThemeImage.setImageDownloadButtonAllRadius(imageDownloadRadius)
  }

  /**
   * 设置图片下载按钮文本内容
   *
   * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
   */
  setImageDownloadText(imageDownloadText: string): void {
    this.markdownThemeImage.setImageDownloadButtonText(imageDownloadText)
  }

  /**
   * 设置图片下载按钮文本大小
   *
   * @param imageDownloadTexSize 图片下载按钮文本大小 - 默认16.0
   */
  setImageDownloadTexSize(imageDownloadTexSize: number): void {
    this.markdownThemeImage.setImageDownloadButtonTextFontSize(imageDownloadTexSize)
  }

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param imageDownloadTexColor 图片下载按钮文本颜色 - 默认0XE6000000
   */
  setImageDownloadTexColor(imageDownloadTexColor: number): void {
    this.markdownThemeImage.setImageDownloadButtonTextFontColor(imageDownloadTexColor)
  }

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0XFFF5F5F5
   */
  setImageDownloadBackgroundColor(imageDownloadBackgroundColor: number): void {
    this.markdownThemeImage.setImageDownloadButtonBackgroundColor(imageDownloadBackgroundColor)
  }

  /**
   * 设置表格内容内边距
   *
   * @param tableCellPadding 表格内容内边距 - 默认4.0vp
   */
  setTableCellPadding(tableCellPadding: number): void {
    this.markdownThemeTable.setTableCellAllPadding(tableCellPadding)
  }

  /**
   * 设置表格边框颜色
   *
   * @param tableBorderColor 表格边框颜色 - 默认0XFF000000
   */
  setTableBorderColor(tableBorderColor: number): void {
    this.markdownThemeTable.setTableBorderColor(tableBorderColor)
  }

  /**
   * 设置表格边框宽度
   *
   * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
   */
  setTableBorderWidth(tableBorderWidth: number): void {
    this.markdownThemeTable.setTableBorderWidth(tableBorderWidth)
  }

  /**
   * 设置表格奇数行背景色
   *
   * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0XFFFFFFFF
   */
  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): void {
    this.markdownThemeTable.setTableContentOddRowBackgroundColor(tableOddRowBackgroundColor)
  }

  /**
   * 设置表格偶数行背景色
   *
   * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0XFFE0E0E0
   */
  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): void {
    this.markdownThemeTable.setTableContentEvenRowBackgroundColor(tableEvenRowBackgroundColor)
  }

  /**
   * 设置表格标题背景色
   *
   * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认0XFFFFFFFF
   */
  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): void {
    this.markdownThemeTable.setTableTitleBackgroundColor(tableHeaderRowBackgroundColor)
  }

  /**
   * 设置表格标题文本颜色
   *
   * @param tableTitleTextColor 表格标题文本颜色 - 默认0XFF191919
   */
  setTableTitleTextColor(tableTitleTextColor: number): void {
    this.markdownThemeTable.setTableTitleTextFontColor(tableTitleTextColor)
  }

  /**
   * 设置表格文本行高
   *
   * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
   */
  setTableTextLineHeight(tableTextLineHeight: number): void {
    this.markdownThemeTable.setTableContentTextLineHeight(tableTextLineHeight)
    this.markdownThemeTable.setTableTitleTextLineHeight(tableTextLineHeight)
  }

  /**
   * 设置表格标题文本大小
   *
   * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
   */
  setTableTitleTextSize(tableTitleTextSize: number): void {
    this.markdownThemeTable.setTableTitleTextFontSize(tableTitleTextSize)
  }

  /**
   * 设置表格标题文本行高
   *
   * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
   */
  setTableTitleLineHeight(tableTitleLineHeight: number): void {
    this.markdownThemeTable.setTableTitleTextLineHeight(tableTitleLineHeight)
  }

  /**
   * 设置表格内容文本颜色
   *
   * @param tableContentTextColor 表格内容文本颜色 - 默认0XFF191919
   */
  setTableContentTextColor(tableContentTextColor: number): void {
    this.markdownThemeTable.setTableContentTextFontColor(tableContentTextColor)
  }

  /**
   * 设置表格内容文本大小
   *
   * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
   */
  setTableContentTextSize(tableContentTextSize: number): void {
    this.markdownThemeTable.setTableContentTextFontSize(tableContentTextSize)
  }

  /**
   * 设置表格内容文本行高
   *
   * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
   */
  setTableContentTextLineHeight(tableTextLineHeight: number): void {
    this.markdownThemeTable.setTableContentTextLineHeight(tableTextLineHeight)
  }

  /**
   * 设置表格圆角
   *
   * @param tableRadius 表格圆角 - 默认5.0vp
   */
  setTableRadius(tableRadius: number): void {
    this.markdownThemeTable.setTableAllRadius(tableRadius)
  }

  /**
   * 设置表格最小宽度
   *
   * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
   */
  setTableMinTextWidth(tableMinTextWidth: number): void {
    this.markdownThemeTable.setTableMinCellWidth(tableMinTextWidth)
  }

  /**
   * 设置表格最大宽度
   *
   * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
   */
  setTableMaxTextWidth(tableMaxTextWidth: number): void {
    this.markdownThemeTable.setTableMaxCellWidth(tableMaxTextWidth)
  }

  /**
   * 设置表格第一列是否加粗
   *
   * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
   */
  setTableFirstColumnBold(tableFirstColumnBold: boolean): void {
    this.markdownThemeTable.setTableFirstColumnIsBold(tableFirstColumnBold)
  }

  /**
   * 设置表格是否显示滚动条
   *
   * @param tableScrollBarShow 表格是否显示滚动条 - true：显示(auto状态)；false：不显示。默认false
   */
  setTableScrollBarShow(tableScrollBarShow: boolean): void {
    if (tableScrollBarShow) {
      this.markdownThemeTable.setTableScrollBarState(BarState.Auto)
    } else {
      this.markdownThemeTable.setTableScrollBarState(BarState.Off)
    }
  }

  /**
   * 设置表格滚动条颜色
   *
   * @param tableScrollBarColor 表格滚动条颜色
   */
  setTableScrollBarColor(tableScrollBarColor: number): void {
    this.markdownThemeTable.setTableScrollBarColor(tableScrollBarColor)
  }

  /**
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   */
  setIsDark(isDark: boolean): void {
    this.isDark = isDark
  }

  /**
   * 设置删除线颜色
   *
   * @param strikethroughColor 删除线颜色 - 默认0XFF191919
   */
  setStrikethroughColor(strikethroughColor: number): void {
    this.markdownThemeStrikethrough.setStrikethroughTextDecorationColor(strikethroughColor)
  }

  /**
   * 设置删除线样式
   *
   * @param strikethroughStyle 删除线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   */
  setStrikethroughStyle(strikethroughStyle: MarkdownTextDecorationStyle): void {
    this.markdownThemeStrikethrough.setStrikethroughTextDecorationStyle(strikethroughStyle)
  }

  /**
   * 设置定义列表术语和定义行之间间距
   *
   * @param descListTermAndDefMargins 定义列表定义行缩进 默认8.0
   */
  setDescListTermAndDefMargins(descListTermAndDefMargins: number): void {
    this.markdownThemeDefinitionList.setDefinitionListTermToDescriptionSpacing(descListTermAndDefMargins)
  }

  /**
   * 设置定义列表定义行缩进
   *
   * @param descListDefIndentation 定义列表定义行缩进 默认8.0
   */
  setDescListDefIndentation(descListDefIndentation: number): void {
    this.markdownThemeDefinitionList.setDefinitionListDescriptionIndent(descListDefIndentation)
  }

  /**
   * 设置定义列表定义行间距
   *
   * @param descListDefMargins 定义列表定义行间距 默认8.0
   */
  setDescListDefMargins(descListDefMargins: number): void {
    this.markdownThemeDefinitionList.setDefinitionListDescriptionItemSpacing(descListDefMargins)
  }

  /**
   * 设置下标字体颜色
   *
   * @param subTextColor 下标字体颜色 默认0XFF191919
   */
  setSubTextColor(subTextColor: number): void {
    this.markdownThemeSub.setSubTextFontColor(subTextColor)
  }

  /**
   * 设置下标字体大小
   *
   * @param subTextSize 下标字体大小 默认8.0
   */
  setSubTextSize(subTextSize: number): void {
    this.markdownThemeSub.setSubTextFontSize(subTextSize)
  }

  /**
   * 设置下标偏移距离
   *
   * @param subOffsetDist 下标偏移距离 默认0.0
   */
  setSubOffsetDist(subOffsetDist: number): void {
    this.markdownThemeSub.setSubTextBaselineOffset(subOffsetDist)
  }

  /**
   * 设置上标字体颜色
   *
   * @param supTextColor 上标字体颜色 默认0XFF191919
   */
  setSupTextColor(supTextColor: number): void {
    this.markdownThemeSup.setSupTextFontColor(supTextColor)
  }

  /**
   * 设置上标字体大小
   *
   * @param supTextSize 上标字体大小 默认8.0
   */
  setSupTextSize(supTextSize: number): void {
    this.markdownThemeSup.setSupTextFontSize(supTextSize)
  }

  /**
   * 设置上标偏移距离
   *
   * @param supOffsetDist 上标偏移距离 默认6.0
   */
  setSupOffsetDist(supOffsetDist: number): void {
    this.markdownThemeSup.setSupTextBaselineOffset(supOffsetDist)
  }

  /**
   * 设置下划线颜色
   *
   * @param underlineColor 下划线颜色 默认0XFF191919
   */
  setUnderlineColor(underlineColor: number): void {
    this.markdownThemeHtmlUnderline.setHtmlUnderlineTextDecorationColor(underlineColor)
  }

  /**
   * 设置下划线样式
   *
   * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   */
  setUnderlineStyle(underlineStyle: MarkdownTextDecorationStyle): void {
    this.markdownThemeHtmlUnderline.setHtmlUnderlineTextDecorationStyle(underlineStyle)
  }

  /**
   * 设置markdown是否支持滚动手势
   *
   * @param openGestureSwipe true-支持滚动手势，false-不支持滚动手势，默认false
   */
  setOpenGestureSwipe(openGestureSwipe: boolean): void {
    this.markdownThemeGlobal.setOpenGestureSwipe(openGestureSwipe)
  }

  /**
   * 设置codeformat是否用制表符
   *
   * @param useTab true-使用，false-不使用，默认false
   */
  setUseTab(useTab: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockUseTab(useTab)
  }

  /**
   * 设置codeformat空格缩进数量
   *
   * @param indentWidth 空格缩进数量，默认4空格
   */
  setIndentWidth(indentWidth: number): void {
    this.markdownThemeCodeBlock.setCodeBlockIndentWidth(indentWidth)
  }
}

/**
 * 数学公式生成图片格式的枚举
 */
export enum LatexMathColorFormat {
  /**
   * 16位
   */
  COLOR_FORMAT_RGB_565,
  /**
   * 32位
   */
  COLOR_FORMAT_BGRA_8888
}

/**
 * 图片缩放类型的枚举
 */
export enum ImageFitType {
  /**
   * 保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
   */
  Contain,
  /**
   * 保持宽高比进行缩小或者放大，使得图片恰好完全显示在显示边界内。
   */
  Cover,
  /**
   * 不保持宽高比进行放大缩小，使得图片充满显示边界。
   */
  Fill
}

/**
 * 文本装饰线样式
 */
export enum MarkdownTextDecorationStyle {
  /**
   * 实线
   */
  SOLID = 0,
  /**
   * 双横线
   */
  DOUBLE = 1,
  /**
   * 点线
   */
  DOTTED = 2,
  /**
   * 虚线
   */
  DASHED = 3,
  /**
   * 波浪线
   */
  WAVY = 4
}