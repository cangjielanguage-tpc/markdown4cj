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
   * 是否按照链接文本字体大小显示文本
   */
  private isLinkSize?: boolean = undefined

  /**
   * 全局样式
   */
  private markdownThemeGlobal: MarkdownThemeGlobal = new MarkdownThemeGlobal()

  /**
   * 音频样式
   */
  private markdownThemeAudio: MarkdownThemeAudio = new MarkdownThemeAudio()

  /**
   * Banner样式
   */
  private markdownThemeBanner: MarkdownThemeBanner = new MarkdownThemeBanner()

  /**
   * 块引用样式
   */
  private markdownThemeBlockQuote: MarkdownThemeBlockQuote = new MarkdownThemeBlockQuote()

  /**
   * 加粗文本样式
   */
  private markdownThemeBold: MarkdownThemeBold = new MarkdownThemeBold()

  /**
   * 代码块样式
   */
  private markdownThemeCodeBlock: MarkdownThemeCodeBlock = new MarkdownThemeCodeBlock()

  /**
   * 定义列表样式
   */
  private markdownThemeDefinitionList: MarkdownThemeDefinitionList = new MarkdownThemeDefinitionList()

  /**
   * 分割线样式
   */
  private markdownThemeDivider: MarkdownThemeDivider = new MarkdownThemeDivider()

  /**
   * 脚注定义样式
   */
  private markdownThemeFootnoteDef: MarkdownThemeFootnoteDef = new MarkdownThemeFootnoteDef()

  /**
   * 脚注引用样式
   */
  private markdownThemeFootnoteRef: MarkdownThemeFootnoteRef = new MarkdownThemeFootnoteRef()

  /**
   * 数学公式样式
   */
  private markdownThemeLatexMath: MarkdownThemeLatexMath = new MarkdownThemeLatexMath()

  /**
   * 标题样式
   */
  private markdownThemeHeading: MarkdownThemeHeading = new MarkdownThemeHeading()

  /**
   * HTML下划线文本样式
   */
  private markdownThemeHtmlUnderline: MarkdownThemeHtmlUnderline = new MarkdownThemeHtmlUnderline()

  /**
   * 图片样式
   */
  private markdownThemeImage: MarkdownThemeImage = new MarkdownThemeImage()

  /**
   * 内联代码样式
   */
  private markdownThemeInlineCode: MarkdownThemeInlineCode = new MarkdownThemeInlineCode()

  /**
   * 斜体文本样式
   */
  private markdownThemeItalic: MarkdownThemeItalic = new MarkdownThemeItalic()

  /**
   * 链接文本样式
   */
  private markdownThemeLink: MarkdownThemeLink = new MarkdownThemeLink()

  /**
   * 有序列表样式
   */
  private markdownThemeOrderedList: MarkdownThemeOrderedList = new MarkdownThemeOrderedList()

  /**
   * 段落样式
   */
  private markdownThemeParagraph: MarkdownThemeParagraph = new MarkdownThemeParagraph()

  /**
   * 删除线文本样式
   */
  private markdownThemeStrikethrough: MarkdownThemeStrikethrough = new MarkdownThemeStrikethrough()

  /**
   * 下标文本样式
   */
  private markdownThemeSub: MarkdownThemeSub = new MarkdownThemeSub()

  /**
   * 上标文本样式
   */
  private markdownThemeSup: MarkdownThemeSup = new MarkdownThemeSup()

  /**
   * 表格样式
   */
  private markdownThemeTable: MarkdownThemeTable = new MarkdownThemeTable()

  /**
   * 无序/任务列表样式
   */
  private markdownThemeBulletList: MarkdownThemeBulletList = new MarkdownThemeBulletList()

  /**
   * 视频样式
   */
  private markdownThemeVideo: MarkdownThemeVideo = new MarkdownThemeVideo()

  /**
   * 设置上下文
   *
   * @param context 上下文
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setStageContext
   */
  setContext(context: Context): void {
    this.markdownThemeGlobal.setStageContext(context)
  }

  /**
   * 设置浅色主题整体样式
   */
  setDefaultTheme(): void {
    // 浅色主题 - 只切换颜色属性
    // 全局主题
    this.markdownThemeGlobal.setBackgroundColor(0x00000000) // markdown全局背景颜色
    // 段落主题
    this.markdownThemeParagraph.setParagraphTextFontColor(0xFF191919) // 段落文本颜色
    // 标题主题
    this.markdownThemeHeading.setTextFontColorForAllHeading(0xFF191919) // 标题文本颜色
    this.markdownThemeHeading.setUnderlineColorForAllHeading(0xFF191919) // 标题下划线颜色
    // 表格主题
    this.markdownThemeTable.setTableBorderColor(0xFF000000) // 表格边框颜色
    this.markdownThemeTable.setTableTitleTextFontColor(0xFF191919) // 表格标题文本颜色
    this.markdownThemeTable.setTableContentTextFontColor(0xFF191919) // 表格内容文本颜色
    this.markdownThemeTable.setTableTitleBackgroundColor(0xFFFFFFFF) // 表格标题背景颜色
    this.markdownThemeTable.setTableContentOddRowBackgroundColor(0xFFE0E0E0) // 表格内容奇数行背景颜色
    this.markdownThemeTable.setTableContentEvenRowBackgroundColor(0xFFFFFFFF) // 表格内容偶数行背景颜色
    this.markdownThemeTable.setTableScrollBarColor(0xFF191919) // 表格滚动条颜色
    // 分隔线主题
    this.markdownThemeDivider.setDividerColor(0xFF191919) // 分隔线颜色
    // 引用块主题
    this.markdownThemeBlockQuote.setBlockQuoteLeftBorderColor(0xFF191919) // 引用块左侧边框颜色
    this.markdownThemeBlockQuote.setBlockQuoteBackgroundColor(0xFFEAEAEA) // 引用块背景颜色
    // 有序列表主题
    this.markdownThemeOrderedList.setOrderedListMarkerTextFontColor(0xFF191919) // 有序列表标记文本颜色
    // 无序列表主题
    this.markdownThemeBulletList.setBulletListBulletTextFontColor(0xFF191919) // 无序列表标记文本颜色
    this.markdownThemeBulletList.setBulletListCheckboxSelectedColor(0xFF808080) // 无序列表复选框选中颜色
    // 代码块主题
    this.markdownThemeCodeBlock.setCodeBlockBorderColor(0x00000000) // 代码块边框颜色
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectTextColor(0xFFFF0000) // 列表标题选中文本颜色
    this.markdownThemeCodeBlock.setCodeBlockListTitleUnselectTextColor(0xFF000000) // 列表标题未选中文本颜色
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectBackgroundColor(0xFF808080) // 列表标题选中背景颜色
    this.markdownThemeCodeBlock.setCodeBlockListTitleUnselectBackgroundColor(0x00000000) // 列表标题未选背景颜色
    // 音频主题
    this.markdownThemeAudio.setAudioBackgroundColor(0x00000000) // 音频背景颜色
    this.markdownThemeAudio.setAudioBorderColor(0x33000000) // 音频边框颜色
    this.markdownThemeAudio.setAudioShadowColor(0x1A000000) // 音频阴影颜色
    this.markdownThemeAudio.setAudioTitleTextFontColor(0xFF000000) // 音频标题文本颜色
    this.markdownThemeAudio.setAudioTypeTextFontColor(0x80000000) // 音频类型文本颜色
    this.markdownThemeAudio.setAudioButtonBackgroundColor(0xFF000000) // 音频按钮背景颜色
    this.markdownThemeAudio.setAudioButtonBorderColor(0x00000000) // 音频按钮边框颜色
    this.markdownThemeAudio.setAudioButtonTextFontColor(0xFFFFFFFF) // 音频按钮文本颜色
    // 视频主题
    this.markdownThemeVideo.setVideoBackgroundColor(0x00000000) // 视频背景颜色
    this.markdownThemeVideo.setVideoBorderColor(0x00000000) // 视频边框颜色
    this.markdownThemeVideo.setVideoTimeTextFontColor(0xFFFFFFFF) // 视频时间文本颜色
    this.markdownThemeVideo.setVideoReleaseButtonBackgroundColor(0xFFF5F5F5) // 视频发布按钮背景颜色
    this.markdownThemeVideo.setVideoReleaseButtonTextFontColor(0x60000000) // 视频发布按钮文本颜色
    this.markdownThemeVideo.setVideoDownloadButtonBackgroundColor(0xFFF5F5F5) // 视频下载按钮背景颜色
    this.markdownThemeVideo.setVideoDownloadButtonTextFontColor(0x60000000) // 视频下载按钮文本颜色
    // 脚注引用主题
    this.markdownThemeFootnoteRef.setFootnoteRefTextFontColor(0xFFFF0000) // 脚注引用文本颜色
    this.markdownThemeFootnoteRef.setFootnoteRefTextDecorationColor(0xFFFF0000) // 脚注引用文本下划线颜色
    this.markdownThemeFootnoteRef.setFootnoteRefTextBackgroundColor(0x00000000) // 脚注引用文本背景颜色
    // 行内代码主题
    this.markdownThemeInlineCode.setInlineCodeTextBackgroundColor(0xFFEAEAEA) // 行内代码文本背景颜色
    // LaTeX数学公式主题
    this.markdownThemeLatexMath.setLatexMathDefaultTextFontColor(0xFFFF0000) // 数学公式未加载状态文本颜色
    this.markdownThemeLatexMath.setLatexMathBackgroundColor(0x00000000) // 数学公式背景颜色
    this.markdownThemeLatexMath.setLatexMathTextColor(0xFF000000) // 数学公式文本颜色
    // HTML下划线主题
    this.markdownThemeHtmlUnderline.setHtmlUnderlineTextDecorationColor(0xFF191919) // HTML下划线文本下划线颜色
    // 图片主题
    this.markdownThemeImage.setImageBorderColor(0xFF000000) // 图片边框颜色
    this.markdownThemeImage.setImageDownloadButtonBackgroundColor(0xFFF5F5F5) // 图片下载按钮背景颜色
    this.markdownThemeImage.setImageDownloadButtonTextFontColor(0xE6000000) // 图片下载按钮文本颜色
    // 链接主题
    this.markdownThemeLink.setLinkTextFontColor(0xFFFF0000) // 链接文本颜色
    this.markdownThemeLink.setLinkTextDecorationColor(0xFFFF0000) // 链接文本下划线颜色
    this.markdownThemeLink.setLinkTextBackgroundColor(0x00000000) // 链接文本背景颜色
    this.markdownThemeLink.setLinkCircleIconBackgroundColor(0x00000000) // 链接圆形图标背景颜色
    this.markdownThemeLink.setLinkCircleIconButtonBackgroundColor(0xFF000000) // 链接圆形图标按钮背景颜色
    this.markdownThemeLink.setLinkCircleIconTextColor(0xFFFFFFFF) // 链接圆形图标按钮文本颜色
    this.markdownThemeLink.setLinkRectIconBackgroundColor(0x00000000) // 链接方形图标背景颜色
    this.markdownThemeLink.setLinkRectIconButtonBackgroundColor(0xFF000000) // 链接方形图标按钮背景颜色
    this.markdownThemeLink.setLinkRectIconTextColor(0xFFFFFFFF) // 链接方形图标按钮文本颜色
    this.markdownThemeLink.setLinkRectToolIconBackgroundColor(0x00000000) // 链接方形图标工具按钮背景颜色
    this.markdownThemeLink.setLinkRectToolIconButtonBackgroundColor(0xFFFFFFFF) // 链接方形图标工具按钮背景颜色
    // 删除线主题
    this.markdownThemeStrikethrough.setStrikethroughTextDecorationColor(0xFF191919) // 删除线文本下划线颜色
    // 代码高亮主题
    this.markdownThemeCodeBlock.setCodeBlockIsDark(false)
  }

  /**
   * 设置深色主题整体样式
   */
  setDarculaTheme(): void {
    // 深色主题设计

    // 全局主题
    this.markdownThemeGlobal.setBackgroundColor(0x00000000) // markdown全局背景颜色

    // 段落主题
    this.markdownThemeParagraph.setParagraphTextFontColor(0xFFE0E0E0) // 段落文本颜色

    // 标题主题
    this.markdownThemeHeading.setTextFontColorForAllHeading(0xFFE0E0E0) // 标题文本颜色
    this.markdownThemeHeading.setUnderlineColorForAllHeading(0xFFE0E0E0) // 标题下划线颜色

    // 表格主题
    this.markdownThemeTable.setTableBorderColor(0xFF404040) // 表格边框颜色
    this.markdownThemeTable.setTableTitleTextFontColor(0xFFE0E0E0) // 表格标题文本颜色
    this.markdownThemeTable.setTableContentTextFontColor(0xFFE0E0E0) // 表格内容文本颜色
    this.markdownThemeTable.setTableTitleBackgroundColor(0xFF2D2D2D) // 表格标题背景颜色
    this.markdownThemeTable.setTableContentOddRowBackgroundColor(0xFF1E1E1E) // 表格内容奇数行背景颜色
    this.markdownThemeTable.setTableContentEvenRowBackgroundColor(0xFF2D2D2D) // 表格内容偶数行背景颜色
    this.markdownThemeTable.setTableScrollBarColor(0xFFE0E0E0) // 表格滚动条颜色

    // 分隔线主题
    this.markdownThemeDivider.setDividerColor(0xFFE0E0E0) // 分隔线颜色

    // 引用块主题
    this.markdownThemeBlockQuote.setBlockQuoteLeftBorderColor(0xFFE0E0E0) // 引用块左侧边框颜色
    this.markdownThemeBlockQuote.setBlockQuoteBackgroundColor(0xFF252526) // 引用块背景颜色

    // 有序列表主题
    this.markdownThemeOrderedList.setOrderedListMarkerTextFontColor(0xFFE0E0E0) // 有序列表标记文本颜色

    // 无序列表主题
    this.markdownThemeBulletList.setBulletListBulletTextFontColor(0xFFE0E0E0) // 无序列表标记文本颜色
    this.markdownThemeBulletList.setBulletListCheckboxSelectedColor(0xFF4A90E2) // 无序列表复选框选中颜色

    // 代码块主题
    this.markdownThemeCodeBlock.setCodeBlockBorderColor(0x00000000) // 代码块边框颜色
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectTextColor(0xFF4A90E2) // 列表标题选中文本颜色
    this.markdownThemeCodeBlock.setCodeBlockListTitleUnselectTextColor(0xFFE0E0E0) // 列表标题未选中文本颜色
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectBackgroundColor(0xFF2D2D2D) // 列表标题选中背景颜色
    this.markdownThemeCodeBlock.setCodeBlockListTitleUnselectBackgroundColor(0x00000000) // 列表标题未选背景颜色

    // 音频主题
    this.markdownThemeAudio.setAudioBackgroundColor(0xFF1E1E1E) // 音频背景颜色
    this.markdownThemeAudio.setAudioBorderColor(0xFF404040) // 音频边框颜色
    this.markdownThemeAudio.setAudioShadowColor(0x40000000) // 音频阴影颜色
    this.markdownThemeAudio.setAudioTitleTextFontColor(0xFFE0E0E0) // 音频标题文本颜色
    this.markdownThemeAudio.setAudioTypeTextFontColor(0xFFA0A0A0) // 音频类型文本颜色
    this.markdownThemeAudio.setAudioButtonBackgroundColor(0xFF2D2D2D) // 音频按钮背景颜色
    this.markdownThemeAudio.setAudioButtonBorderColor(0xFF404040) // 音频按钮边框颜色
    this.markdownThemeAudio.setAudioButtonTextFontColor(0xFFE0E0E0) // 音频按钮文本颜色

    // 视频主题
    this.markdownThemeVideo.setVideoBackgroundColor(0xFF1E1E1E) // 视频背景颜色
    this.markdownThemeVideo.setVideoBorderColor(0xFF404040) // 视频边框颜色
    this.markdownThemeVideo.setVideoTimeTextFontColor(0xFFE0E0E0) // 视频时间文本颜色
    this.markdownThemeVideo.setVideoReleaseButtonBackgroundColor(0xFF2D2D2D) // 视频释放按钮背景颜色
    this.markdownThemeVideo.setVideoReleaseButtonTextFontColor(0xFFE0E0E0) // 视频释放按钮文本颜色
    this.markdownThemeVideo.setVideoDownloadButtonBackgroundColor(0xFF2D2D2D) // 视频下载按钮背景颜色
    this.markdownThemeVideo.setVideoDownloadButtonTextFontColor(0xFFE0E0E0) // 视频下载按钮文本颜色

    // 脚注引用主题
    this.markdownThemeFootnoteRef.setFootnoteRefTextFontColor(0xFF4A90E2) // 脚注引用文本颜色
    this.markdownThemeFootnoteRef.setFootnoteRefTextDecorationColor(0xFF4A90E2) // 脚注引用文本下划线颜色
    this.markdownThemeFootnoteRef.setFootnoteRefTextBackgroundColor(0xFF1E1E1E) // 脚注引用文本背景颜色

    // 行内代码主题
    this.markdownThemeInlineCode.setInlineCodeTextBackgroundColor(0xFF252526) // 行内代码背景颜色

    // LaTeX数学公式主题
    this.markdownThemeLatexMath.setLatexMathDefaultTextFontColor(0xFF4A90E2) // 数学公式未加载状态文本颜色
    this.markdownThemeLatexMath.setLatexMathBackgroundColor(0x00000000) // 数学公式背景颜色
    this.markdownThemeLatexMath.setLatexMathTextColor(0xFFE0E0E0) // 数学公式文本颜色

    // HTML下划线主题
    this.markdownThemeHtmlUnderline.setHtmlUnderlineTextDecorationColor(0xFFE0E0E0) // HTML下划线文本下划线颜色

    // 图片主题
    this.markdownThemeImage.setImageBorderColor(0xFF404040) // 图片边框颜色
    this.markdownThemeImage.setImageDownloadButtonBackgroundColor(0xFF2D2D2D) // 图片下载按钮背景颜色
    this.markdownThemeImage.setImageDownloadButtonTextFontColor(0xFFE0E0E0) // 图片下载按钮文本颜色

    // 链接主题
    this.markdownThemeLink.setLinkTextFontColor(0xFF4A90E2) // 链接文本颜色
    this.markdownThemeLink.setLinkTextDecorationColor(0xFF4A90E2) // 链接文本下划线颜色
    this.markdownThemeLink.setLinkTextBackgroundColor(0x00000000) // 链接文本背景颜色
    this.markdownThemeLink.setLinkCircleIconBackgroundColor(0x00000000) // 链接圆形图标背景颜色
    this.markdownThemeLink.setLinkCircleIconButtonBackgroundColor(0xFF2D2D2D) // 链接圆形图标按钮背景颜色
    this.markdownThemeLink.setLinkCircleIconTextColor(0xFFE0E0E0) // 链接圆形图标按钮文本颜色
    this.markdownThemeLink.setLinkRectIconBackgroundColor(0x00000000) // 链接方形图标背景颜色
    this.markdownThemeLink.setLinkRectIconButtonBackgroundColor(0xFF2D2D2D) // 链接方形图标按钮背景颜色
    this.markdownThemeLink.setLinkRectIconTextColor(0xFFE0E0E0) // 链接方形图标按钮文本颜色
    this.markdownThemeLink.setLinkRectToolIconBackgroundColor(0x00000000) // 链接方形图标工具按钮背景颜色
    this.markdownThemeLink.setLinkRectToolIconButtonBackgroundColor(0xFF2D2D2D) // 链接方形图标工具图标按钮背景颜色

    // 删除线主题
    this.markdownThemeStrikethrough.setStrikethroughTextDecorationColor(0xFF404040) // 删除线文本装饰线颜色

    // 代码高亮主题
    this.markdownThemeCodeBlock.setCodeBlockIsDark(true)
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
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockFullScreenIcon
   */
  setCodeFullScreenIcon(codeFullScreenIcon: Resource): void {
    this.markdownThemeCodeBlock.setCodeBlockFullScreenIcon(codeFullScreenIcon)
  }

  /**
   * 设置代码块复制图片icon
   *
   * @param codeCopyIcon 代码块复制图片icon
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockCopyIcon
   */
  setCodeCopyIcon(codeCopyIcon: Resource): void {
    this.markdownThemeCodeBlock.setCodeBlockCopyIcon(codeCopyIcon)
  }

  /**
   * 设置音频图片icon
   *
   * @param audioIcon 音频图片icon
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioIcon
   */
  setAudioIcon(audioIcon: Resource): void {
    this.markdownThemeAudio.setAudioIcon(audioIcon)
  }

  /**
   * 设置视频默认占位图
   *
   * @param videoImage 视频默认占位图
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoPlaceholder
   */
  setVideoImage(videoImage: Resource): void {
    this.markdownThemeVideo.setVideoPlaceholder(videoImage)
  }

  /**
   * 设置视频播放按钮icon
   *
   * @param playCircleFillIcon 视频播放按钮icon
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoPlayIcon
   */
  setPlayCircleFillIcon(playCircleFillIcon: Resource): void {
    this.markdownThemeVideo.setVideoPlayIcon(playCircleFillIcon)
  }

  /**
   * 设置banner占位图
   *
   * @param bannerImage banner占位图
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBanner#setBannerPlaceholder
   */
  setBannerImage(bannerImage: Resource): void {
    this.markdownThemeBanner.setBannerPlaceholder(bannerImage)
  }

  /**
   * 设置图片占位图
   *
   * @param imageResource 图片占位图
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImagePlaceholder
   */
  setImageResource(imageResource: Resource): void {
    this.markdownThemeImage.setImagePlaceholder(imageResource)
  }

  /**
   * 设置视频发布默认图标
   *
   * @param videoReleaseImage 视频发布默认图标
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonIcon
   */
  setVideoReleaseImage(videoReleaseImage: Resource): void {
    this.markdownThemeVideo.setVideoReleaseButtonIcon(videoReleaseImage)
  }

  /**
   * 设置视频下载默认图标
   *
   * @param videoDownloadImage 视频下载默认图标
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonIcon
   */
  setVideoDownloadImage(videoDownloadImage: Resource): void {
    this.markdownThemeVideo.setVideoDownloadButtonIcon(videoDownloadImage)
  }

  /**
   * 设置图片下载默认图标
   *
   * @param imageDownloadImage 图片下载默认图标
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonIcon
   */
  setImageDownloadImage(imageDownloadImage: Resource): void {
    this.markdownThemeImage.setImageDownloadButtonIcon(imageDownloadImage)
  }

  /**
   * 设置markdown是否同步解析
   *
   * @param isMarkdownParserSync markdown是否同步解析 - 默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setIsMarkdownParserSync
   */
  setIsMarkdownParserSync(isMarkdownParserSync: boolean): void {
    this.markdownThemeGlobal.setIsMarkdownParserSync(isMarkdownParserSync)
  }

  /**
   * 设置是否打开长按复制粘贴
   *
   * @param isOnCopy 是否打开长按复制粘贴 - 默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setIsOnCopy
   */
  setIsOnCopy(isOnCopy: boolean): void {
    this.markdownThemeGlobal.setIsOnCopy(isOnCopy)
  }

  /**
   * 设置markdown第一个模块上边距
   *
   * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setGlobalMargin
   */
  setBlockFirstTopMargin(blockFirstTopMargin: number): void {
    let blockMarginRight = this.markdownThemeGlobal.getBlockMarginRight()
    let blockMarginBottom = this.markdownThemeGlobal.getBlockMarginBottom()
    let blockMarginLeft = this.markdownThemeGlobal.getBlockMarginLeft()
    this.markdownThemeGlobal.setGlobalMargin(blockFirstTopMargin, blockMarginRight, blockMarginBottom, blockMarginLeft)
  }

  /**
   * 设置markdown最后一个模块下边距
   *
   * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setGlobalMargin
   */
  setBlockLastBottomMargin(blockLastBottomMargin: number): void {
    let blockMarginTop = this.markdownThemeGlobal.getBlockMarginTop()
    let blockMarginRight = this.markdownThemeGlobal.getBlockMarginRight()
    let blockMarginLeft = this.markdownThemeGlobal.getBlockMarginLeft()
    this.markdownThemeGlobal.setGlobalMargin(blockMarginTop, blockMarginRight, blockLastBottomMargin, blockMarginLeft)
  }

  /**
   * 设置模块间上下间距
   *
   * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setBlockSpacing
   */
  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): void {
    this.markdownThemeGlobal.setBlockSpacing(blockTopAndBottomMargins)
  }

  /**
   * 设置链接是否是图片显示
   *
   * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkIsIcon
   */
  setIsLinkStyle(isLinkStyle: boolean): void {
    this.markdownThemeLink.setLinkIsIcon(isLinkStyle)
  }

  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkListIsIcon
   */
  setIsListLinkStyle(isListLinkStyle: boolean): void {
    this.markdownThemeLink.setLinkListIsIcon(isListLinkStyle)
  }

  /**
   * 设置文本格式链接文本颜色
   *
   * @param linkColor 文本格式链接文本颜色 - 默认0xFF0000FF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkTextFontColor
   */
  setLinkColor(linkColor: number): void {
    this.markdownThemeLink.setLinkTextFontColor(linkColor)
  }

  /**
   * 设置是否按照链接文本字体大小显示文本
   *
   * @param isLinkSize 是否按照链接文本字体大小显示文本 - true：显示链接字体文本大小；false：跟随标题段落大小显示。默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkTextFontSize
   */
  setIsLinkSize(isLinkSize: boolean): void {
    if (isLinkSize) {
      if (this.markdownThemeLink.getLinkTextFontSize() == undefined) {
        this.markdownThemeLink.setLinkTextFontSize(14.0)
      }
    } else {
      this.markdownThemeLink.setLinkTextFontSize(undefined)
    }
  }

  /**
   * 设置文本格式链接文字大小
   *
   * @param linkSize 文本格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkTextFontSize
   */
  setLinkSize(linkSize: number): void {
    this.markdownThemeLink.setLinkTextFontSize(linkSize)
  }

  /**
   * 设置文本格式链接文字行高
   *
   * @param linkLineHeight 文本格式链接文字行高
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkTextLineHeight
   */
  setLinkLineHeight(linkLineHeight: number): void {
    this.markdownThemeLink.setLinkTextLineHeight(linkLineHeight)
  }

  /**
   * 设置文本格式链接背景颜色
   *
   * @param linkBackgroundColor 文本格式链接背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkTextBackgroundColor
   */
  setLinkBackgroundColor(linkBackgroundColor: number): void {
    this.markdownThemeLink.setLinkTextBackgroundColor(linkBackgroundColor)
  }

  /**
   * 设置文本格式是否显示链接下划线
   *
   * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkTextDecorationType
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
   * @param linkCircleImageBackgroundColor 圆形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconBackgroundColor
   */
  setLinkCircleImageBackgroundColor(linkCircleImageBackgroundColor: number): void {
    this.markdownThemeLink.setLinkCircleIconBackgroundColor(linkCircleImageBackgroundColor)
  }

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param linkCircleImageButtonBackgroundColor 圆形图片格式链接控件背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconButtonBackgroundColor
   */
  setLinkCircleImageButtonBackgroundColor(linkCircleImageButtonBackgroundColor: number): void {
    this.markdownThemeLink.setLinkCircleIconButtonBackgroundColor(linkCircleImageButtonBackgroundColor)
  }

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconTextSize
   */
  setLinkCircleImageTextSize(linkCircleImageTextSize: number): void {
    this.markdownThemeLink.setLinkCircleIconTextSize(linkCircleImageTextSize)
  }

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconTextColor
   */
  setLinkCircleImageTextColor(linkCircleImageTextColor: number): void {
    this.markdownThemeLink.setLinkCircleIconTextColor(linkCircleImageTextColor)
  }

  /**
   * 设置圆形图片格式链接半径
   *
   * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconRadius
   */
  setLinkCircleImageRadius(linkCircleImageRadius: number): void {
    this.markdownThemeLink.setLinkCircleIconRadius(linkCircleImageRadius)
  }

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkCircleIconMargin
   */
  setLinkCircleImageMargin(linkCircleImageMargin: number): void {
    this.markdownThemeLink.setLinkCircleIconMargin(linkCircleImageMargin)
  }

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectImageBackgroundColor 圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconBackgroundColor
   */
  setLinkRectImageBackgroundColor(linkRectImageBackgroundColor: number): void {
    this.markdownThemeLink.setLinkRectIconBackgroundColor(linkRectImageBackgroundColor)
  }

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectImageButtonBackgroundColor 圆角矩形图片格式链接控件背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconButtonBackgroundColor
   */
  setLinkRectImageButtonBackgroundColor(linkRectImageButtonBackgroundColor: number): void {
    this.markdownThemeLink.setLinkRectIconButtonBackgroundColor(linkRectImageButtonBackgroundColor)
  }

  /**
   * 圆角矩形图片格式链接文字大小
   *
   * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconTextSize
   */
  setLinkRectImageTextSize(linkRectImageTextSize: number): void {
    this.markdownThemeLink.setLinkRectIconTextSize(linkRectImageTextSize)
  }

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconTextColor
   */
  setLinkRectImageTextColor(linkRectImageTextColor: number): void {
    this.markdownThemeLink.setLinkRectIconTextColor(linkRectImageTextColor)
  }

  /**
   * 圆角矩形图片格式链接控件高度
   *
   * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconHeight
   */
  setLinkRectImageHeight(linkRectImageHeight: number): void {
    this.markdownThemeLink.setLinkRectIconHeight(linkRectImageHeight)
  }

  /**
   * 圆角矩形图片格式链接左右内边距
   *
   * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconPadding
   */
  setLinkRectImagePadding(linkRectImagePadding: number): void {
    this.markdownThemeLink.setLinkRectIconPadding(linkRectImagePadding)
  }

  /**
   * 圆角矩形图片格式链接圆角半径
   *
   * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconRadius
   */
  setLinkRectImageRadius(linkRectImageRadius: number): void {
    this.markdownThemeLink.setLinkRectIconRadius(linkRectImageRadius)
  }

  /**
   * 圆角矩形图片格式链接左右外边距
   *
   * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectIconMargin
   */
  setLinkRectImageMargin(linkRectImageMargin: number): void {
    this.markdownThemeLink.setLinkRectIconMargin(linkRectImageMargin)
  }

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectToolImageBackgroundColor 空心圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconBackgroundColor
   */
  setLinkRectToolImageBackgroundColor(linkRectToolImageBackgroundColor: number): void {
    this.markdownThemeLink.setLinkRectToolIconBackgroundColor(linkRectToolImageBackgroundColor)
  }

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectToolImageButtonBackgroundColor 空心圆角矩形图片格式链接控件背景颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconBackgroundColor
   */
  setLinkRectToolImageButtonBackgroundColor(linkRectToolImageButtonBackgroundColor: number): void {
    this.markdownThemeLink.setLinkRectToolIconBackgroundColor(linkRectToolImageButtonBackgroundColor)
  }

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconTextSize
   */
  setLinkRectToolImageTextSize(linkRectToolImageTextSize: number): void {
    this.markdownThemeLink.setLinkRectToolIconTextSize(linkRectToolImageTextSize)
  }

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconHeight
   */
  setLinkRectToolImageHeight(linkRectToolImageHeight: number): void {
    this.markdownThemeLink.setLinkRectToolIconHeight(linkRectToolImageHeight)
  }

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconPadding
   */
  setLinkRectToolImagePadding(linkRectToolImagePadding: number): void {
    this.markdownThemeLink.setLinkRectToolIconPadding(linkRectToolImagePadding)
  }

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconBorderWidth
   */
  setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: number): void {
    this.markdownThemeLink.setLinkRectToolIconBorderWidth(linkRectToolImageBorderWidth)
  }

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconDividingLineWidth
   */
  setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: number): void {
    this.markdownThemeLink.setLinkRectToolIconDividingLineWidth(linkRectToolImageDividingLineWidth)
  }

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconMargin
   */
  setLinkRectToolImageMargin(linkRectToolImageMargin: number): void {
    this.markdownThemeLink.setLinkRectToolIconMargin(linkRectToolImageMargin)
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconLineLeftPadding
   */
  setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: number): void {
    this.markdownThemeLink.setLinkRectToolIconLineLeftPadding(linkRectToolImageLineLeftPadding)
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLink#setLinkRectToolIconLineRightPadding
   */
  setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: number): void {
    this.markdownThemeLink.setLinkRectToolIconLineRightPadding(linkRectToolImageLineRightPadding)
  }

  /**
   * 设置块引用左边距
   *
   * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteMargin
   */
  setBlockQuoteLeftMargin(blockQuoteLeftMargin: number): void {
    let blockQuoteMarginTop = this.markdownThemeBlockQuote.getBlockQuoteMarginTop()
    let blockQuoteMarginRight = this.markdownThemeBlockQuote.getBlockQuoteMarginRight()
    let blockQuoteMarginBottom = this.markdownThemeBlockQuote.getBlockQuoteMarginBottom()
    this.markdownThemeBlockQuote.setBlockQuoteMargin(blockQuoteMarginTop, blockQuoteMarginRight, blockQuoteMarginBottom, blockQuoteLeftMargin)
  }

  /**
   * 设置块引用右边距
   *
   * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteMargin
   */
  setBlockQuoteRightMargin(blockQuoteRightMargin: number): void {
    let blockQuoteMarginTop = this.markdownThemeBlockQuote.getBlockQuoteMarginTop()
    let blockQuoteMarginBottom = this.markdownThemeBlockQuote.getBlockQuoteMarginBottom()
    let blockQuoteMarginLeft = this.markdownThemeBlockQuote.getBlockQuoteMarginLeft()
    this.markdownThemeBlockQuote.setBlockQuoteMargin(blockQuoteMarginTop, blockQuoteRightMargin, blockQuoteMarginBottom, blockQuoteMarginLeft)
  }

  /**
   * 设置块引用左边线条宽度
   *
   * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteLeftBorderWidth
   */
  setBlockQuoteWidth(blockQuoteWidth: number): void {
    this.markdownThemeBlockQuote.setBlockQuoteLeftBorderWidth(blockQuoteWidth)
  }

  /**
   * 设置块引用左边线条颜色
   *
   * @param blockQuoteColor 块引用左边线条颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteLeftBorderColor
   */
  setBlockQuoteColor(blockQuoteColor: number): void {
    this.markdownThemeBlockQuote.setBlockQuoteLeftBorderColor(blockQuoteColor)
  }

  /**
   * 设置块引用背景颜色
   *
   * @param blockQuoteBackgroundColor 块引用背景颜色 - 默认0xFFEAEAEA
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteBackgroundColor
   */
  setBlockQuoteBackgroundColor(blockQuoteBackgroundColor: number): void {
    this.markdownThemeBlockQuote.setBlockQuoteBackgroundColor(blockQuoteBackgroundColor)
  }

  /**
   * 设置块引用子模块上下间距
   *
   * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBlockQuote#setBlockQuoteChildSpacing
   */
  setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: number): void {
    this.markdownThemeBlockQuote.setBlockQuoteChildSpacing(blockQuoteTopAndBottomMargins)
  }

  /**
   * 设置有序列表、无序列表、任务列表子模块上下间距
   *
   * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListChildSpacing
   *             MarkdownThemeOrderedList#setBulletListChildSpacing
   */
  setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: number): void {
    this.markdownThemeOrderedList.setOrderedListChildSpacing(blockOrderedAndBulletTopAndBottomMargins)
    this.markdownThemeBulletList.setBulletListChildSpacing(blockOrderedAndBulletTopAndBottomMargins)
  }

  /**
   * 设置有序列表、无序列表、任务列表左边距
   *
   * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMargin
   *             MarkdownThemeOrderedList#setBulletListMargin
   */
  setBlockLeftMargin(blockLeftMargin: number): void {
    let orderedListMarginTop = this.markdownThemeOrderedList.getOrderedListMarginTop()
    let orderedListMarginRight = this.markdownThemeOrderedList.getOrderedListMarginRight()
    let orderedListMarginBottom = this.markdownThemeOrderedList.getOrderedListMarginBottom()
    this.markdownThemeOrderedList.setOrderedListMargin(orderedListMarginTop, orderedListMarginRight, orderedListMarginBottom, blockLeftMargin)

    let bulletListMarginTop = this.markdownThemeBulletList.getBulletListMarginTop()
    let bulletListMarginRight = this.markdownThemeBulletList.getBulletListMarginRight()
    let bulletListMarginBottom = this.markdownThemeBulletList.getBulletListMarginBottom()
    this.markdownThemeBulletList.setBulletListMargin(bulletListMarginTop, bulletListMarginRight, bulletListMarginBottom, blockLeftMargin)
  }

  /**
   * 设置有序列表、无序列表、任务列表右边距
   *
   * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMargin
   *             MarkdownThemeOrderedList#setBulletListMargin
   */
  setBlockRightMargin(blockRightMargin: number): void {
    let orderedListMarginTop = this.markdownThemeOrderedList.getOrderedListMarginTop()
    let orderedListMarginBottom = this.markdownThemeOrderedList.getOrderedListMarginBottom()
    let orderedListMarginLeft = this.markdownThemeOrderedList.getOrderedListMarginLeft()
    this.markdownThemeOrderedList.setOrderedListMargin(orderedListMarginTop, blockRightMargin, orderedListMarginBottom, orderedListMarginLeft)

    let bulletListMarginTop = this.markdownThemeBulletList.getBulletListMarginTop()
    let bulletListMarginBottom = this.markdownThemeBulletList.getBulletListMarginBottom()
    let bulletListMarginLeft = this.markdownThemeBulletList.getBulletListMarginLeft()
    this.markdownThemeBulletList.setBulletListMargin(bulletListMarginTop, blockRightMargin, bulletListMarginBottom, bulletListMarginLeft)
  }

  /**
   * 设置有序列表前缀文本是否加粗
   *
   * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMarkerTextFontWeight
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
   * @param orderedListItemColor 有序列表前缀文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMarkerTextFontColor
   */
  setOrderedListItemColor(orderedListItemColor: number): void {
    this.markdownThemeOrderedList.setOrderedListMarkerTextFontColor(orderedListItemColor)
  }

  /**
   * 设置有序列表前缀文本大小
   *
   * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMarkerTextFontSize
   */
  setOrderedListItemSize(orderedListItemSize: number): void {
    this.markdownThemeOrderedList.setOrderedListMarkerTextFontSize(orderedListItemSize)
  }

  /**
   * 设置有序列表前缀文本行高
   *
   * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeOrderedList#setOrderedListMarkerTextLineHeight
   */
  setOrderedListItemLineHeight(orderedListItemLineHeight: number): void {
    this.markdownThemeOrderedList.setOrderedListMarkerTextLineHeight(orderedListItemLineHeight)
  }

  /**
   * 设置无序列表前缀是否全部是实心圆型
   *
   * @param bulletListItemCircle 无序列表前缀是否全部是实心圆型 - 默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBulletList#setBulletListBulletIsCircle
   */
  setBulletListItemCircle(bulletListItemCircle: boolean): void {
    this.markdownThemeBulletList.setBulletListBulletIsCircle(bulletListItemCircle)
  }

  /**
   * 设置无序列表前缀文本颜色
   *
   * @param bulletListItemColor 无序列表前缀文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBulletList#setBulletListBulletTextFontColor
   */
  setBulletListItemColor(bulletListItemColor: number): void {
    this.markdownThemeBulletList.setBulletListBulletTextFontColor(bulletListItemColor)
  }

  /**
   * 设置无序列表前缀文本大小
   *
   * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBulletList#setBulletListBulletTextFontSize
   */
  setBulletListItemSize(bulletListItemSize: number): void {
    this.markdownThemeBulletList.setBulletListBulletTextFontSize(bulletListItemSize)
  }

  /**
   * 设置无序列表前缀文本行高
   *
   * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBulletList#setBulletListBulletTextLineHeight
   */
  setBulletListItemLineHeight(bulletListItemLineHeight: number): void {
    this.markdownThemeBulletList.setBulletListBulletTextLineHeight(bulletListItemLineHeight)
  }

  /**
   * 设置任务列表选择框宽高
   *
   * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeBulletList#setBulletListCheckboxWidth
   *             MarkdownThemeBulletList#setBulletListCheckboxHeight
   */
  setTaskListItemLength(taskListItemLength: number): void {
    this.markdownThemeBulletList.setBulletListCheckboxWidth(taskListItemLength)
    this.markdownThemeBulletList.setBulletListCheckboxHeight(taskListItemLength)
  }

  /**
   * 设置是否格式化代码块内容
   *
   * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块内容；false：不格式化代码块内容。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockIsCodeFormat
   */
  setIsCodeFormat(isCodeFormat: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockIsCodeFormat(isCodeFormat)
  }

  /**
   * 设置内联代码文本颜色
   *
   * @param codeTextColor 内联代码文本颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeInlineCode#setInlineCodeTextFontColor
   */
  setCodeTextColor(codeTextColor: number): void {
    this.markdownThemeInlineCode.setInlineCodeTextFontColor(codeTextColor)
  }

  /**
   * 设置内联代码背景颜色
   *
   * @param codeBackgroundColor 内联代码背景颜色 - 默认0xFFEAEAEA
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeInlineCode#setInlineCodeTextBackgroundColor
   */
  setCodeBackgroundColor(codeBackgroundColor: number): void {
    this.markdownThemeInlineCode.setInlineCodeTextBackgroundColor(codeBackgroundColor)
  }

  /**
   * 设置内联代码文本大小
   *
   * @param codeTextSize 内联代码文本大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeInlineCode#setInlineCodeTextFontSize
   */
  setCodeTextSize(codeTextSize: number): void {
    this.markdownThemeInlineCode.setInlineCodeTextFontSize(codeTextSize)
  }

  /**
   * 设置内联代码文本字体
   *
   * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeInlineCode#setInlineCodeTextFontFamily
   */
  setCodeTypeface(codeTypeface: string): void {
    this.markdownThemeInlineCode.setInlineCodeTextFontFamily(codeTypeface)
  }

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockParserSync
   */
  setIsCodeBlockParserSync(isCodeBlockParserSync: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockParserSync(isCodeBlockParserSync)
  }

  /**
   * 设置代码块代码文本颜色
   *
   * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTextFontColor
   */
  setCodeBlockTextColor(codeBlockTextColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockTextFontColor(codeBlockTextColor)
  }

  /**
   * 设置代码块代码类型文本颜色
   *
   * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTypeTextFontColor
   */
  setCodeBlockTypeTextColor(codeBlockTypeTextColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockTypeTextFontColor(codeBlockTypeTextColor)
  }

  /**
   * 设置代码块代码类型文本
   *
   * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTypeText
   */
  setCodeBlockTypeTextStr(codeBlockTypeTextStr: string): void {
    this.markdownThemeCodeBlock.setCodeBlockTypeText(codeBlockTypeTextStr)
  }

  /**
   * 设置代码类型和代码块距离
   *
   * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTitleLayoutMarginBottom
   */
  setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: number): void {
    this.markdownThemeCodeBlock.setCodeBlockTitleLayoutMarginBottom(codeBlockTypeTextPadding)
  }

  /**
   * 设置代码块复制、全屏图片文字是否显示
   *
   * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockFullScreenTextIsShow
   *             MarkdownThemeCodeBlock#setCodeBlockCopyTextIsShow
   */
  setCodeBlockIconTextHide(codeBlockIconTextHide: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockFullScreenTextIsShow(codeBlockIconTextHide)
    this.markdownThemeCodeBlock.setCodeBlockCopyTextIsShow(codeBlockIconTextHide)
  }

  /**
   * 设置代码块代码行号是否显示
   *
   * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockLineNumberIsShow
   */
  setCodeBlockLineNumberHide(codeBlockLineNumberHide: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockLineNumberIsShow(codeBlockLineNumberHide)
  }

  /**
   * 设置代码块背景颜色
   *
   * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockBackgroundColor
   */
  setCodeBlockBackgroundColor(codeBlockBackgroundColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockBackgroundColor(codeBlockBackgroundColor)
  }

  /**
   * 设置代码块左边距
   *
   * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockMargin
   */
  setCodeMultilineMargin(codeMultilineMargin: number): void {
    let codeBlockMarginTop = this.markdownThemeCodeBlock.getCodeBlockMarginTop()
    let codeBlockMarginRight = this.markdownThemeCodeBlock.getCodeBlockMarginRight()
    let codeBlockMarginBottom = this.markdownThemeCodeBlock.getCodeBlockMarginBottom()
    this.markdownThemeCodeBlock.setCodeBlockMargin(codeBlockMarginTop, codeBlockMarginRight, codeBlockMarginBottom, codeMultilineMargin)
  }

  /**
   * 设置代码块字体
   *
   * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTextFontFamily
   */
  setCodeBlockTypeface(codeBlockTypeface: string): void {
    this.markdownThemeCodeBlock.setCodeBlockTextFontFamily(codeBlockTypeface)
  }

  /**
   * 设置代码块代码文本大小
   *
   * @param codeBlockTextSize 代码块代码文本大小 -  默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTextFontSize
   */
  setCodeBlockTextSize(codeBlockTextSize: number): void {
    this.markdownThemeCodeBlock.setCodeBlockTextFontSize(codeBlockTextSize)
  }

  /**
   * 设置代码块代码文本行高
   *
   * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockTextLineHeight
   */
  setCodeBlockLineHeight(codeBlockLineHeight: number): void {
    this.markdownThemeCodeBlock.setCodeBlockTextLineHeight(codeBlockLineHeight)
  }

  /**
   * 设置代码块控件圆角大小
   *
   * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockAllRadius
   */
  setCodeBlockRadius(codeBlockRadius: number): void {
    this.markdownThemeCodeBlock.setCodeBlockAllRadius(codeBlockRadius)
  }

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockFullScreenButtonIsShow
   */
  setIsCodeFullScreen(isCodeFullScreen: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockFullScreenButtonIsShow(isCodeFullScreen)
  }

  /**
   * 设置代码块代码全屏、代码复制按钮宽高
   *
   * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockFullScreenIconHeight
   *             MarkdownThemeCodeBlock#setCodeBlockFullScreenIconWidth
   *             MarkdownThemeCodeBlock#setCodeBlockCopyIconHeight
   *             MarkdownThemeCodeBlock#setCodeBlockCopyIconWidth
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
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleTextSize
   */
  setCodeListTitleTextSize(codeListTitleTextSize: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleTextSize(codeListTitleTextSize)
  }

  /**
   * 设置组合代码选中标题字体大小
   *
   * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleSelectTextSize
   */
  setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectTextSize(codeListTitleSelectTextSize)
  }

  /**
   * 设置组合代码选中标题文本颜色
   *
   * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认Color.RED
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleSelectTextColor
   */
  setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectTextColor(codeListTitleSelectTextColor)
  }

  /**
   * 设置组合代码未选中标题文本颜色
   *
   * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认Color.BLACK
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleUnselectTextColor
   */
  setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleUnselectTextColor(codeListTitleUnSelectTextColor)
  }

  /**
   * 设置组合代码选中标题背景颜色
   *
   * @param codeListTitleSelectBackgroundColor 组合代码选中标题背景颜色 - 默认Color.GRAY
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleSelectBackgroundColor
   */
  setCodeListTitleSelectBackgroundColor(codeListTitleSelectBackgroundColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectBackgroundColor(codeListTitleSelectBackgroundColor)
  }

  /**
   * 设置组合代码未选中标题背景颜色
   *
   * @param codeListTitleUnSelectBackgroundColor 组合代码未选中标题背景颜色 - 默认Color.TRANSPARENT
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockListTitleUnselectBackgroundColor
   */
  setCodeListTitleUnSelectBackgroundColor(codeListTitleUnSelectBackgroundColor: number): void {
    this.markdownThemeCodeBlock.setCodeBlockListTitleUnselectBackgroundColor(codeListTitleUnSelectBackgroundColor)
  }

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockIsSeparate
   */
  setIsSeparateCodeBlock(isSeparateCodeBlock: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockIsSeparate(isSeparateCodeBlock)
  }

  /**
   * 设置单独代码块行号宽度
   *
   * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockSeparateWidth
   */
  setSeparateCodeBlockWidth(separateCodeBlockWidth: number): void {
    this.markdownThemeCodeBlock.setCodeBlockSeparateWidth(separateCodeBlockWidth)
  }

  /**
   * 设置单独代码块是否居底显示
   *
   * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockSeparateIsBottom
   */
  setSeparateCodeIsBottom(separateCodeIsBottom: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockSeparateIsBottom(separateCodeIsBottom)
  }

  /**
   * 设置H1、H2标题下分割线高度
   *
   * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setUnderlineHeightForAllHeading
   */
  setHeadingBreakHeight(headingBreakHeight: number): void {
    this.markdownThemeHeading.setUnderlineHeightForAllHeading(headingBreakHeight)
  }

  /**
   * 设置标题文本字体
   *
   * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontFamilyForAllHeading
   */
  setHeadingTypeface(headingTypeface: string): void {
    this.markdownThemeHeading.setTextFontFamilyForAllHeading(headingTypeface)
  }

  /**
   * 设置标题模块上间距
   *
   * @param headingTopMargins 标题模块上间距 - 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setMarginForDesignateHeading
   */
  setHeadingTopMargins(headingTopMargins: number): void {
    let heading1MarginRight = this.markdownThemeHeading.getHeading1MarginRight()
    let heading1MarginBottom = this.markdownThemeHeading.getHeading1MarginBottom()
    let heading1MarginLeft = this.markdownThemeHeading.getHeading1MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(1, headingTopMargins, heading1MarginRight, heading1MarginBottom, heading1MarginLeft)

    let heading2MarginRight = this.markdownThemeHeading.getHeading2MarginRight()
    let heading2MarginBottom = this.markdownThemeHeading.getHeading2MarginBottom()
    let heading2MarginLeft = this.markdownThemeHeading.getHeading2MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(2, headingTopMargins, heading2MarginRight, heading2MarginBottom, heading2MarginLeft)

    let heading3MarginRight = this.markdownThemeHeading.getHeading3MarginRight()
    let heading3MarginBottom = this.markdownThemeHeading.getHeading3MarginBottom()
    let heading3MarginLeft = this.markdownThemeHeading.getHeading3MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(3, headingTopMargins, heading3MarginRight, heading3MarginBottom, heading3MarginLeft)

    let heading4MarginRight = this.markdownThemeHeading.getHeading4MarginRight()
    let heading4MarginBottom = this.markdownThemeHeading.getHeading4MarginBottom()
    let heading4MarginLeft = this.markdownThemeHeading.getHeading4MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(4, headingTopMargins, heading4MarginRight, heading4MarginBottom, heading4MarginLeft)

    let heading5MarginRight = this.markdownThemeHeading.getHeading5MarginRight()
    let heading5MarginBottom = this.markdownThemeHeading.getHeading5MarginBottom()
    let heading5MarginLeft = this.markdownThemeHeading.getHeading5MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(5, headingTopMargins, heading5MarginRight, heading5MarginBottom, heading5MarginLeft)

    let heading6MarginRight = this.markdownThemeHeading.getHeading6MarginRight()
    let heading6MarginBottom = this.markdownThemeHeading.getHeading6MarginBottom()
    let heading6MarginLeft = this.markdownThemeHeading.getHeading6MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(6, headingTopMargins, heading6MarginRight, heading6MarginBottom, heading6MarginLeft)
  }

  /**
   * 设置标题模块下间距
   *
   * @param headingBottomMargins 标题模块下间距 - 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setMarginForDesignateHeading
   */
  setHeadingBottomMargins(headingBottomMargins: number): void {
    let heading1MarginTop = this.markdownThemeHeading.getHeading1MarginTop()
    let heading1MarginRight = this.markdownThemeHeading.getHeading1MarginRight()
    let heading1MarginLeft = this.markdownThemeHeading.getHeading1MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(1, heading1MarginTop, heading1MarginRight, headingBottomMargins, heading1MarginLeft)

    let heading2MarginTop = this.markdownThemeHeading.getHeading2MarginTop()
    let heading2MarginRight = this.markdownThemeHeading.getHeading2MarginRight()
    let heading2MarginLeft = this.markdownThemeHeading.getHeading2MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(2, heading2MarginTop, heading2MarginRight, headingBottomMargins, heading2MarginLeft)

    let heading3MarginTop = this.markdownThemeHeading.getHeading3MarginTop()
    let heading3MarginRight = this.markdownThemeHeading.getHeading3MarginRight()
    let heading3MarginLeft = this.markdownThemeHeading.getHeading3MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(3, heading3MarginTop, heading3MarginRight, headingBottomMargins, heading3MarginLeft)

    let heading4MarginTop = this.markdownThemeHeading.getHeading4MarginTop()
    let heading4MarginRight = this.markdownThemeHeading.getHeading4MarginRight()
    let heading4MarginLeft = this.markdownThemeHeading.getHeading4MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(4, heading4MarginTop, heading4MarginRight, headingBottomMargins, heading4MarginLeft)

    let heading5MarginTop = this.markdownThemeHeading.getHeading5MarginTop()
    let heading5MarginRight = this.markdownThemeHeading.getHeading5MarginRight()
    let heading5MarginLeft = this.markdownThemeHeading.getHeading5MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(5, heading5MarginTop, heading5MarginRight, headingBottomMargins, heading5MarginLeft)

    let heading6MarginTop = this.markdownThemeHeading.getHeading6MarginTop()
    let heading6MarginRight = this.markdownThemeHeading.getHeading6MarginRight()
    let heading6MarginLeft = this.markdownThemeHeading.getHeading6MarginLeft()
    this.markdownThemeHeading.setMarginForDesignateHeading(6, heading6MarginTop, heading6MarginRight, headingBottomMargins, heading6MarginLeft)
  }

  /**
   * 设置标题文本大小数组
   *
   * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForEachHeading
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
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize1(headingTextSize1: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(1, headingTextSize1)
  }

  /**
   * 设置二级标题文本大小
   *
   * @param headingTextSize2 二级标题文本大小 - 默认17.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize2(headingTextSize2: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(2, headingTextSize2)
  }

  /**
   * 设置三级标题文本大小
   *
   * @param headingTextSize3 三级标题文本大小 - 默认16.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize3(headingTextSize3: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(3, headingTextSize3)
  }

  /**
   * 设置四级标题文本大小
   *
   * @param headingTextSize4 四级标题文本大小 - 默认15.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize4(headingTextSize4: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(4, headingTextSize4)
  }

  /**
   * 设置五级标题文本大小
   *
   * @param headingTextSize5 五级标题文本大小 - 默认15.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize5(headingTextSize5: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(5, headingTextSize5)
  }

  /**
   * 设置六级标题文本大小
   *
   * @param headingTextSize6 六级标题文本大小 - 默认13.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize6(headingTextSize6: number): void {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(6, headingTextSize6)
  }

  /**
   * 设置标题文本颜色
   *
   * @param headingTextColor 标题文本颜色 - 默认0xFF191919
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForAllHeading
   */
  setHeadingTextColor(headingTextColor: number): void {
    this.markdownThemeHeading.setTextFontColorForAllHeading(headingTextColor)
  }

  /**
   * 设置H1、H2标题下分割线颜色
   *
   * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0xFF191919
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setUnderlineColorForAllHeading
   */
  setHeadingBreakColor(headingBreakColor: number): void {
    this.markdownThemeHeading.setUnderlineColorForAllHeading(headingBreakColor)
  }

  /**
   * 设置标题文本字间距
   *
   * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLetterSpacingForAllHeading
   */
  setHeadingTextWordSpace(headingTextWordSpace: number): void {
    this.markdownThemeHeading.setTextLetterSpacingForAllHeading(headingTextWordSpace)
  }

  /**
   * 设置一级标题文本行高
   *
   * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight1(headingTextLineHeight1: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(1, headingTextLineHeight1)
  }

  /**
   * 设置二级标题文本行高
   *
   * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight2(headingTextLineHeight2: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(2, headingTextLineHeight2)
  }

  /**
   * 设置三级标题文本行高
   *
   * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight3(headingTextLineHeight3: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(3, headingTextLineHeight3)
  }

  /**
   * 设置四级标题文本行高
   *
   * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight4(headingTextLineHeight4: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(4, headingTextLineHeight4)
  }

  /**
   * 设置五级标题文本行高
   *
   * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight5(headingTextLineHeight5: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(5, headingTextLineHeight5)
  }

  /**
   * 设置六级标题文本行高
   *
   * @param headingTextLineHeight6 六级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight6(headingTextLineHeight6: number): void {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(6, headingTextLineHeight6)
  }

  /**
   * 设置一级标题文本颜色
   *
   * @param headingTextColor1 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor1(headingTextColor1: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(1, headingTextColor1)
  }

  /**
   * 设置H1标题下分割线颜色
   *
   * @param headingBreakColor1 H1标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setUnderlineColorForDesignateHeading
   */
  setHeadingBreakColor1(headingBreakColor1: number): void {
    this.markdownThemeHeading.setUnderlineColorForDesignateHeading(1, headingBreakColor1)
  }

  /**
   * 设置二级标题文本颜色
   *
   * @param headingTextColor2 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor2(headingTextColor2: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(2, headingTextColor2)
  }

  /**
   * 设置H2标题下分割线颜色
   *
   * @param headingBreakColor2 H2标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setUnderlineColorForDesignateHeading
   */
  setHeadingBreakColor2(headingBreakColor2: number): void {
    this.markdownThemeHeading.setUnderlineColorForDesignateHeading(2, headingBreakColor2)
  }

  /**
   * 设置三级标题文本颜色
   *
   * @param headingTextColor3 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor3(headingTextColor3: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(3, headingTextColor3)
  }

  /**
   * 设置四级标题文本颜色
   *
   * @param headingTextColor4 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor4(headingTextColor4: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(4, headingTextColor4)
  }

  /**
   * 设置五级标题文本颜色
   *
   * @param headingTextColor5 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor5(headingTextColor5: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(5, headingTextColor5)
  }

  /**
   * 设置六级标题文本颜色
   *
   * @param headingTextColor6 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHeading#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor6(headingTextColor6: number): void {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(6, headingTextColor6)
  }

  /**
   * 设置段落模块上间距
   *
   * @param paragraphTopMargins 段落模块上间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphMargin
   */
  setParagraphTopMargins(paragraphTopMargins: number): void {
    let paragraphMarginRight = this.markdownThemeParagraph.getParagraphMarginRight()
    let paragraphMarginBottom = this.markdownThemeParagraph.getParagraphMarginBottom()
    let paragraphMarginLeft = this.markdownThemeParagraph.getParagraphMarginLeft()
    this.markdownThemeParagraph.setParagraphMargin(paragraphTopMargins, paragraphMarginRight, paragraphMarginBottom, paragraphMarginLeft)
  }

  /**
   * 设置段落模块下间距
   *
   * @param paragraphBottomMargins 段落模块下间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphMargin
   */
  setParagraphBottomMargins(paragraphBottomMargins: number): void {
    let paragraphMarginTop = this.markdownThemeParagraph.getParagraphMarginTop()
    let paragraphMarginRight = this.markdownThemeParagraph.getParagraphMarginRight()
    let paragraphMarginLeft = this.markdownThemeParagraph.getParagraphMarginLeft()
    this.markdownThemeParagraph.setParagraphMargin(paragraphMarginTop, paragraphMarginRight, paragraphBottomMargins, paragraphMarginLeft)
  }

  /**
   * 设置段落文本大小
   *
   * @param paragraphTextSize 段落文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphTextFontSize
   */
  setParagraphTextSize(paragraphTextSize: number): void {
    this.markdownThemeParagraph.setParagraphTextFontSize(paragraphTextSize)
  }

  /**
   * 设置段落文本颜色
   *
   * @param paragraphTextColor 段落文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphTextFontColor
   */
  setParagraphTextColor(paragraphTextColor: number): void {
    this.markdownThemeParagraph.setParagraphTextFontColor(paragraphTextColor)
  }

  /**
   * 设置段落文本字间距
   *
   * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphTextLetterSpacing
   */
  setParagraphTextWordSpace(paragraphTextWordSpace: number): void {
    this.markdownThemeParagraph.setParagraphTextLetterSpacing(paragraphTextWordSpace)
  }

  /**
   * 设置段落文本行高
   *
   * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphTextLineHeight
   */
  setParagraphTextLineHeight(paragraphTextLineHeight: number): void {
    this.markdownThemeParagraph.setParagraphTextLineHeight(paragraphTextLineHeight)
  }

  /**
   * 设置段落文本字体
   *
   * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeParagraph#setParagraphTextFontFamily
   */
  setParagraphTypeface(paragraphTypeface: string): void {
    this.markdownThemeParagraph.setParagraphTextFontFamily(paragraphTypeface)
  }

  /**
   * 设置分割线颜色
   *
   * @param thematicBreakColor 分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDivider#setDividerColor
   */
  setThematicBreakColor(thematicBreakColor: number): void {
    this.markdownThemeDivider.setDividerColor(thematicBreakColor)
  }

  /**
   * 设置分割线高度
   *
   * @param thematicBreakHeight 分割线高度 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDivider#setDividerStrokeWidth
   */
  setThematicBreakHeight(thematicBreakHeight: number): void {
    this.markdownThemeDivider.setDividerStrokeWidth(thematicBreakHeight)
  }

  /**
   * 设置分割线上部外边距
   *
   * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDivider#setDividerMargin
   */
  setThematicBreakTopMargin(thematicBreakTopMargin: number): void {
    let dividerMarginRight = this.markdownThemeDivider.getDividerMarginRight()
    let dividerMarginBottom = this.markdownThemeDivider.getDividerMarginBottom()
    let dividerMarginLeft = this.markdownThemeDivider.getDividerMarginLeft()
    this.markdownThemeDivider.setDividerMargin(thematicBreakTopMargin, dividerMarginRight, dividerMarginBottom, dividerMarginLeft)
  }

  /**
   * 设置分割线下部外边距
   *
   * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDivider#setDividerMargin
   */
  setThematicBreakBottomMargin(thematicBreakBottomMargin: number): void {
    let dividerMarginTop = this.markdownThemeDivider.getDividerMarginTop()
    let dividerMarginRight = this.markdownThemeDivider.getDividerMarginRight()
    let dividerMarginLeft = this.markdownThemeDivider.getDividerMarginLeft()
    this.markdownThemeDivider.setDividerMargin(dividerMarginTop, dividerMarginRight, thematicBreakBottomMargin, dividerMarginLeft)
  }

  /**
   * 设置软换行是否换行
   *
   * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setIsLineBreak
   */
  setIsLineBreak(isLineBreak: boolean): void {
    this.markdownThemeGlobal.setIsLineBreak(isLineBreak)
  }

  /**
   * 设置数学公式未加载状态是否显示文字
   *
   * @param latexDefaultText 数学公式未加载状态是否显示文字 - 默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathDefaultText
   */
  setLatexDefaultText(latexDefaultText: boolean): void {
    this.markdownThemeLatexMath.setLatexMathDefaultText(latexDefaultText)
  }

  /**
   * 设置数学公式文本大小
   *
   * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathDefaultTextFontSize
   */
  setLatexMathTextSize(latexMathTextSize: number): void {
    this.markdownThemeLatexMath.setLatexMathDefaultTextFontSize(latexMathTextSize)
  }

  /**
   * 设置数学公式背景色
   *
   * @param latexMathBackgroundColor 数学公式背景色 - 默认Color.TRANSPARENT
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathBackgroundColor
   */
  setLatexMathBackgroundColor(latexMathBackgroundColor: number): void {
    this.markdownThemeLatexMath.setLatexMathBackgroundColor(latexMathBackgroundColor)
  }

  /**
   * 设置数学公式文本颜色
   *
   * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathTextColor
   */
  setLatexMathTextColor(latexMathTextColor: number): void {
    this.markdownThemeLatexMath.setLatexMathTextColor(latexMathTextColor)
  }

  /**
   * 设置数学公式生成图片格式
   *
   * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.0xFORMAT_BGRA_8888
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathColorFormat
   */
  setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): void {
    this.markdownThemeLatexMath.setLatexMathColorFormat(latexMathColorFormat)
  }

  /**
   * 设置块结构的数学公式是否居中
   *
   * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathBlockCenter
   */
  setLatexMathBlockCenter(latexMathBlockCenter: boolean): void {
    this.markdownThemeLatexMath.setLatexMathBlockCenter(latexMathBlockCenter)
  }

  /**
   * 设置数学公式字体路径
   *
   * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeLatexMath#setLatexMathResPath
   */
  setLatexMathResStr(latexMathResStr: string): void {
    this.markdownThemeLatexMath.setLatexMathResPath(latexMathResStr)
  }

  /**
   * 设置音频阴影颜色值
   *
   * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioShadowColor
   */
  setAudioShadowColor(audioShadowColor: number): void {
    this.markdownThemeAudio.setAudioShadowColor(audioShadowColor)
  }

  /**
   * 设置音频边框颜色
   *
   * @param audioBorderColor 音频边框颜色 - 默认0x33000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioBorderColor
   */
  setAudioBorderColor(audioBorderColor: number): void {
    this.markdownThemeAudio.setAudioBorderColor(audioBorderColor)
  }

  /**
   * 设置音频边框粗细
   *
   * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioBorderWidth
   */
  setAudioBorderWidth(audioBorderWidth: number): void {
    this.markdownThemeAudio.setAudioBorderWidth(audioBorderWidth)
  }

  /**
   * 设置音频边框圆角
   *
   * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioBorderAllRadius
   */
  setAudioBorderRadius(audioBorderRadius: number): void {
    this.markdownThemeAudio.setAudioBorderAllRadius(audioBorderRadius)
  }

  /**
   * 设置音频按钮背景颜色
   *
   * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认Color.BLACK
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioButtonBackgroundColor
   */
  setAudioButtonBackgroundColor(audioButtonBackgroundColor: number): void {
    this.markdownThemeAudio.setAudioButtonBackgroundColor(audioButtonBackgroundColor)
  }

  /**
   * 设置音频按钮文字颜色
   *
   * @param audioButtonTextColor 音频按钮文字颜色 - 默认Color.WHITE
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioButtonTextFontColor
   */
  setAudioButtonTextColor(audioButtonTextColor: number): void {
    this.markdownThemeAudio.setAudioButtonTextFontColor(audioButtonTextColor)
  }

  /**
   * 设置音频按钮文字大小
   *
   * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioButtonTextFontSize
   */
  setAudioButtonTextSize(audioButtonTextSize: number): void {
    this.markdownThemeAudio.setAudioButtonTextFontSize(audioButtonTextSize)
  }

  /**
   * 设置音频按钮文字内容
   *
   * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioButtonText
   */
  setAudioButtonText(audioButtonText: string): void {
    this.markdownThemeAudio.setAudioButtonText(audioButtonText)
  }

  /**
   * 设置音频按钮圆角
   *
   * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioButtonAllRadius
   */
  setAudioButtonBorderRadius(audioButtonBorderRadius: number): void {
    this.markdownThemeAudio.setAudioButtonAllRadius(audioButtonBorderRadius)
  }

  /**
   * 设置音频标题文字大小
   *
   * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTitleTextFontSize
   */
  setAudioTitleTextSize(audioTitleTextSize: number): void {
    this.markdownThemeAudio.setAudioTitleTextFontSize(audioTitleTextSize)
  }

  /**
   * 设置音频标题文字颜色
   *
   * @param audioTitleTextColor音频标题文字颜色 - 默认Color.BLACK
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTitleTextFontColor
   */
  setAudioTitleTextColor(audioTitleTextColor: number): void {
    this.markdownThemeAudio.setAudioTitleTextFontColor(audioTitleTextColor)
  }

  /**
   * 设置音频标题文字行高
   *
   * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTitleTextLineHeight
   */
  setAudioTitleTextLineHeight(audioTitleTextLineHeight: number): void {
    this.markdownThemeAudio.setAudioTitleTextLineHeight(audioTitleTextLineHeight)
  }

  /**
   * 设置音频类型文字大小
   *
   * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTypeTextFontSize
   */
  setAudioTypeTextSize(audioTypeTextSize: number): void {
    this.markdownThemeAudio.setAudioTypeTextFontSize(audioTypeTextSize)
  }

  /**
   * 设置音频类型文字颜色
   *
   * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTypeTextFontColor
   */
  setAudioTypeTextColor(audioTypeTextColor: number): void {
    this.markdownThemeAudio.setAudioTypeTextFontColor(audioTypeTextColor)
  }

  /**
   * 设置音频类型文字行高
   *
   * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioTypeTextLineHeight
   */
  setAudioTypeTextLineHeight(audioTypeTextLineHeight: number): void {
    this.markdownThemeAudio.setAudioTypeTextLineHeight(audioTypeTextLineHeight)
  }

  /**
   * 设置音频上边距
   *
   * @param audioMarginTop 音频上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioMargin
   */
  setAudioMarginTop(audioMarginTop: number): void {
    let audioMarginRight = this.markdownThemeAudio.getAudioMarginRight()
    let audioMarginBottom = this.markdownThemeAudio.getAudioMarginBottom()
    let audioMarginLeft = this.markdownThemeAudio.getAudioMarginLeft()
    this.markdownThemeAudio.setAudioMargin(audioMarginTop, audioMarginRight, audioMarginBottom, audioMarginLeft)
  }

  /**
   * 设置音频下边距
   *
   * @param audioMarginBottom 音频下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeAudio#setAudioMargin
   */
  setAudioMarginBottom(audioMarginBottom: number): void {
    let audioMarginTop = this.markdownThemeAudio.getAudioMarginTop()
    let audioMarginRight = this.markdownThemeAudio.getAudioMarginRight()
    let audioMarginLeft = this.markdownThemeAudio.getAudioMarginLeft()
    this.markdownThemeAudio.setAudioMargin(audioMarginTop, audioMarginRight, audioMarginBottom, audioMarginLeft)
  }

  /**
   * 设置视频圆角
   *
   * @param videoBorderRadius 视频圆角 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoBorderAllRadius
   */
  setVideoBorderRadius(videoBorderRadius: number): void {
    this.markdownThemeVideo.setVideoBorderAllRadius(videoBorderRadius)
  }

  /**
   * 设置视频时间文本颜色
   *
   * @param videoTimeTextColor 视频时间文本颜色 - 默认Color.WHITE
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoTimeTextFontColor
   */
  setVideoTimeTextColor(videoTimeTextColor: number): void {
    this.markdownThemeVideo.setVideoTimeTextFontColor(videoTimeTextColor)
  }

  /**
   * 设置视频时间文本大小
   *
   * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoTimeTextFontSize
   */
  setVideoTimeTextSize(videoTimeTextSize: number): void {
    this.markdownThemeVideo.setVideoTimeTextFontSize(videoTimeTextSize)
  }

  /**
   * 设置视频时间文本居右边距
   *
   * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoTimeTextMarginRight
   */
  setVideoTimeTextMarginRight(videoTimeTextMarginRight: number): void {
    this.markdownThemeVideo.setVideoTimeTextMarginRight(videoTimeTextMarginRight)
  }

  /**
   * 设置视频时间文本居底边距
   *
   * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoTimeTextMarginBottom
   */
  setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: number): void {
    this.markdownThemeVideo.setVideoTimeTextMarginBottom(videoTimeTextMarginBottom)
  }

  /**
   * 设置视频上边距
   *
   * @param videoMarginTop 视频上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoMargin
   */
  setVideoMarginTop(videoMarginTop: number): void {
    let videoMarginRight = this.markdownThemeVideo.getVideoMarginRight()
    let videoMarginBottom = this.markdownThemeVideo.getVideoMarginBottom()
    let videoMarginLeft = this.markdownThemeVideo.getVideoMarginLeft()
    this.markdownThemeVideo.setVideoMargin(videoMarginTop, videoMarginRight, videoMarginBottom, videoMarginLeft)
  }

  /**
   * 设置视频下边距
   *
   * @param videoMarginBottom 视频下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoMargin
   */
  setVideoMarginBottom(videoMarginBottom: number): void {
    let videoMarginTop = this.markdownThemeVideo.getVideoMarginTop()
    let videoMarginRight = this.markdownThemeVideo.getVideoMarginRight()
    let videoMarginLeft = this.markdownThemeVideo.getVideoMarginLeft()
    this.markdownThemeVideo.setVideoMargin(videoMarginTop, videoMarginRight, videoMarginBottom, videoMarginLeft)
  }

  /**
   * 设置视频发布/下载按钮布局是否显示
   *
   * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默认false不显示
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoBottomLayoutVisible
   */
  setIsVideoBottomLayout(isVideoBottomLayout: boolean): void {
    this.markdownThemeVideo.setVideoBottomLayoutVisible(isVideoBottomLayout)
  }

  /**
   * 设置视频发布按钮图片宽度和高度
   *
   * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonIconWidth
   *             MarkdownThemeVideo#setVideoReleaseButtonIconHeight
   */
  setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonIconWidth(videoReleaseImageWidthHeight)
    this.markdownThemeVideo.setVideoReleaseButtonIconHeight(videoReleaseImageWidthHeight)
  }

  /**
   * 设置视频发布按钮宽度
   *
   * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonWidth
   */
  setVideoReleaseWidth(videoReleaseWidth: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonWidth(videoReleaseWidth)
  }

  /**
   * 设置视频发布按钮高度
   *
   * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonHeight
   */
  setVideoReleaseHeight(videoReleaseHeight: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonHeight(videoReleaseHeight)
  }

  /**
   * 设置视频发布按钮圆角
   *
   * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonAllRadius
   */
  setVideoReleaseRadius(videoReleaseRadius: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonAllRadius(videoReleaseRadius)
  }

  /**
   * 设置视频发布按钮文本内容
   *
   * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonText
   */
  setVideoReleaseText(videoReleaseText: string): void {
    this.markdownThemeVideo.setVideoReleaseButtonText(videoReleaseText)
  }

  /**
   * 设置视频发布按钮文本大小
   *
   * @param videoReleaseTexSize 视频发布按钮文本大小 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonTextFontSize
   */
  setVideoReleaseTexSize(videoReleaseTexSize: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonTextFontSize(videoReleaseTexSize)
  }

  /**
   * 设置视频发布按钮文本颜色
   *
   * @param videoReleaseTextColor 视频发布按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonTextFontColor
   */
  setVideoReleaseTextColor(videoReleaseTextColor: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonTextFontColor(videoReleaseTextColor)
  }

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoReleaseButtonBackgroundColor
   */
  setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: number): void {
    this.markdownThemeVideo.setVideoReleaseButtonBackgroundColor(videoReleaseBackgroundColor)
  }

  /**
   * 设置视频下载按钮图片宽度和高度
   *
   * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonIconWidth
   *             MarkdownThemeVideo#setVideoDownloadButtonIconHeight
   */
  setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonIconWidth(videoDownloadImageWidthHeight)
    this.markdownThemeVideo.setVideoDownloadButtonIconHeight(videoDownloadImageWidthHeight)
  }

  /**
   * 设置视频下载按钮宽度
   *
   * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonWidth
   */
  setVideoDownloadWidth(videoDownloadWidth: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonWidth(videoDownloadWidth)
  }

  /**
   * 设置视频下载按钮高度
   *
   * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonHeight
   */
  setVideoDownloadHeight(videoDownloadHeight: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonHeight(videoDownloadHeight)
  }

  /**
   * 设置视频下载按钮圆角
   *
   * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonAllRadius
   */
  setVideoDownloadRadius(videoDownloadRadius: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonAllRadius(videoDownloadRadius)
  }

  /**
   * 设置视频下载按钮文本内容
   *
   * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonText
   */
  setVideoDownloadText(videoDownloadText: string): void {
    this.markdownThemeVideo.setVideoDownloadButtonText(videoDownloadText)
  }

  /**
   * 设置视频下载按钮文本大小
   *
   * @param videoDownloadTexSize 视频下载按钮文本大小 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonTextFontSize
   */
  setVideoDownloadTexSize(videoDownloadTexSize: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonTextFontSize(videoDownloadTexSize)
  }

  /**
   * 设置视频下载按钮文本颜色
   *
   * @param videoDownloadTextColor 视频下载按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonTextFontColor
   */
  setVideoDownloadTextColor(videoDownloadTextColor: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonTextFontColor(videoDownloadTextColor)
  }

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeVideo#setVideoDownloadButtonBackgroundColor
   */
  setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: number): void {
    this.markdownThemeVideo.setVideoDownloadButtonBackgroundColor(videoDownloadBackgroundColor)
  }

  /**
   * 设置图片缩放类型
   *
   * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageFitType
   */
  setImageFitType(imageFitType: ImageFitType): void {
    this.markdownThemeImage.setImageFitType(imageFitType)
  }

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageMaximumWidth
   */
  setImageMaximumWidth(imageMaximumWidth: number): void {
    this.markdownThemeImage.setImageMaximumWidth(imageMaximumWidth)
  }

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageFixedRatioWidth
   */
  setImageFixedRatioWidth(imageFixedRatioWidth: number): void {
    this.markdownThemeImage.setImageFixedRatioWidth(imageFixedRatioWidth)
  }

  /**
   * 设置图片最大高度
   *
   * @param imageMaxHeight 图片最大高度 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageMaxHeight
   */
  setImageMaxHeight(imageMaxHeight: number): void {
    this.markdownThemeImage.setImageMaxHeight(imageMaxHeight)
  }

  /**
   * 设置图片最大宽度
   *
   * @param imageMaxWidth 图片最大宽度 - 默认None
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageMaxWidth
   */
  setImageMaxWidth(imageMaxWidth: number): void {
    this.markdownThemeImage.setImageMaxWidth(imageMaxWidth)
  }

  /**
   * 设置图片圆角大小
   *
   * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageBorderAllRadius
   */
  setImageBorderRadius(imageBorderRadius: number): void {
    this.markdownThemeImage.setImageBorderAllRadius(imageBorderRadius)
  }

  /**
   * 设置图片边框宽度
   *
   * @param imageBorderWidth 图片边框宽度 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageBorderWidth
   */
  setImageBorderWidth(imageBorderWidth: number): void {
    this.markdownThemeImage.setImageBorderWidth(imageBorderWidth)
  }

  /**
   * 设置图片边框颜色
   *
   * @param imageBorderColor 图片边框颜色 - 默认Color.BLACK
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageBorderColor
   */
  setImageBorderColor(imageBorderColor: number): void {
    this.markdownThemeImage.setImageBorderColor(imageBorderColor)
  }

  /**
   * 设置网络图片是否压缩
   *
   * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageAutoResize
   */
  setIsAutoResize(isAutoResize: boolean): void {
    this.markdownThemeImage.setImageAutoResize(isAutoResize)
  }

  /**
   * 设置图片上边距
   *
   * @param imageMarginTop 图片上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageMargin
   */
  setImageMarginTop(imageMarginTop: number): void {
    let imageMarginRight = this.markdownThemeImage.getImageMarginRight()
    let imageMarginBottom = this.markdownThemeImage.getImageMarginBottom()
    let imageMarginLeft = this.markdownThemeImage.getImageMarginLeft()
    this.markdownThemeImage.setImageMargin(imageMarginTop, imageMarginRight, imageMarginBottom, imageMarginLeft)
  }

  /**
   * 设置图片下边距
   *
   * @param imageMarginBottom 图片下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageMargin
   */
  setImageMarginBottom(imageMarginBottom: number): void {
    let imageMarginTop = this.markdownThemeImage.getImageMarginTop()
    let imageMarginRight = this.markdownThemeImage.getImageMarginRight()
    let imageMarginLeft = this.markdownThemeImage.getImageMarginLeft()
    this.markdownThemeImage.setImageMargin(imageMarginTop, imageMarginRight, imageMarginBottom, imageMarginLeft)
  }

  /**
   * 设置图片是否有下载按钮
   *
   * @param isImageDownload 图片是否有下载按钮 - 默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonVisible
   */
  setIsImageDownload(isImageDownload: boolean): void {
    this.markdownThemeImage.setImageDownloadButtonVisible(isImageDownload)
  }

  /**
   * 设置是否图文混排
   *
   * @param isImageMixedLayout 是否图文混排 - 默认true
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setIsImageMixedLayout
   */
  setIsImageMixedLayout(isImageMixedLayout: boolean): void {
    this.markdownThemeImage.setIsImageMixedLayout(isImageMixedLayout)
  }

  /**
   * 设置图片下载按钮图片宽度和高度
   *
   * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonIconWidth
   *             MarkdownThemeImage#setImageDownloadButtonIconHeight
   */
  setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: number): void {
    this.markdownThemeImage.setImageDownloadButtonIconWidth(imageDownloadImageWidthHeight)
    this.markdownThemeImage.setImageDownloadButtonIconHeight(imageDownloadImageWidthHeight)
  }

  /**
   * 设置图片下载按钮宽度
   *
   * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonWidth
   */
  setImageDownloadWidth(imageDownloadWidth: number): void {
    this.markdownThemeImage.setImageDownloadButtonWidth(imageDownloadWidth)
  }

  /**
   * 设置图片下载按钮高度
   *
   * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonHeight
   */
  setImageDownloadHeight(imageDownloadHeight: number): void {
    this.markdownThemeImage.setImageDownloadButtonHeight(imageDownloadHeight)
  }

  /**
   * 设置图片下载按钮圆角
   *
   * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonAllRadius
   */
  setImageDownloadRadius(imageDownloadRadius: number): void {
    this.markdownThemeImage.setImageDownloadButtonAllRadius(imageDownloadRadius)
  }

  /**
   * 设置图片下载按钮文本内容
   *
   * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonText
   */
  setImageDownloadText(imageDownloadText: string): void {
    this.markdownThemeImage.setImageDownloadButtonText(imageDownloadText)
  }

  /**
   * 设置图片下载按钮文本大小
   *
   * @param imageDownloadTexSize 图片下载按钮文本大小 - 默认16.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonTextFontSize
   */
  setImageDownloadTexSize(imageDownloadTexSize: number): void {
    this.markdownThemeImage.setImageDownloadButtonTextFontSize(imageDownloadTexSize)
  }

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param imageDownloadTextColor 图片下载按钮文本颜色 - 默认0XE6000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonTextFontColor
   */
  setImageDownloadTextColor(imageDownloadTextColor: number): void {
    this.markdownThemeImage.setImageDownloadButtonTextFontColor(imageDownloadTextColor)
  }

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeImage#setImageDownloadButtonBackgroundColor
   */
  setImageDownloadBackgroundColor(imageDownloadBackgroundColor: number): void {
    this.markdownThemeImage.setImageDownloadButtonBackgroundColor(imageDownloadBackgroundColor)
  }

  /**
   * 设置表格内容内边距
   *
   * @param tableCellPadding 表格内容内边距 - 默认4.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableCellAllPadding
   */
  setTableCellPadding(tableCellPadding: number): void {
    this.markdownThemeTable.setTableCellAllPadding(tableCellPadding)
  }

  /**
   * 设置表格边框颜色
   *
   * @param tableBorderColor 表格边框颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableBorderColor
   */
  setTableBorderColor(tableBorderColor: number): void {
    this.markdownThemeTable.setTableBorderColor(tableBorderColor)
  }

  /**
   * 设置表格边框宽度
   *
   * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableBorderWidth
   */
  setTableBorderWidth(tableBorderWidth: number): void {
    this.markdownThemeTable.setTableBorderWidth(tableBorderWidth)
  }

  /**
   * 设置表格奇数行背景色
   *
   * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentOddRowBackgroundColor
   */
  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): void {
    this.markdownThemeTable.setTableContentOddRowBackgroundColor(tableOddRowBackgroundColor)
  }

  /**
   * 设置表格偶数行背景色
   *
   * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0xFFE0E0E0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentEvenRowBackgroundColor
   */
  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): void {
    this.markdownThemeTable.setTableContentEvenRowBackgroundColor(tableEvenRowBackgroundColor)
  }

  /**
   * 设置表格标题背景色
   *
   * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableTitleBackgroundColor
   */
  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): void {
    this.markdownThemeTable.setTableTitleBackgroundColor(tableHeaderRowBackgroundColor)
  }

  /**
   * 设置表格标题文本颜色
   *
   * @param tableTitleTextColor 表格标题文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableTitleTextFontColor
   */
  setTableTitleTextColor(tableTitleTextColor: number): void {
    this.markdownThemeTable.setTableTitleTextFontColor(tableTitleTextColor)
  }

  /**
   * 设置表格文本行高
   *
   * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentTextLineHeight
   *             MarkdownThemeTable#setTableTitleTextLineHeight
   */
  setTableTextLineHeight(tableTextLineHeight: number): void {
    this.markdownThemeTable.setTableContentTextLineHeight(tableTextLineHeight)
    this.markdownThemeTable.setTableTitleTextLineHeight(tableTextLineHeight)
  }

  /**
   * 设置表格标题文本大小
   *
   * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableTitleTextFontSize
   */
  setTableTitleTextSize(tableTitleTextSize: number): void {
    this.markdownThemeTable.setTableTitleTextFontSize(tableTitleTextSize)
  }

  /**
   * 设置表格标题文本行高
   *
   * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableTitleTextLineHeight
   */
  setTableTitleLineHeight(tableTitleLineHeight: number): void {
    this.markdownThemeTable.setTableTitleTextLineHeight(tableTitleLineHeight)
  }

  /**
   * 设置表格内容文本颜色
   *
   * @param tableContentTextColor 表格内容文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentTextFontColor
   */
  setTableContentTextColor(tableContentTextColor: number): void {
    this.markdownThemeTable.setTableContentTextFontColor(tableContentTextColor)
  }

  /**
   * 设置表格内容文本大小
   *
   * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentTextFontSize
   */
  setTableContentTextSize(tableContentTextSize: number): void {
    this.markdownThemeTable.setTableContentTextFontSize(tableContentTextSize)
  }

  /**
   * 设置表格内容文本行高
   *
   * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableContentTextLineHeight
   */
  setTableContentTextLineHeight(tableTextLineHeight: number): void {
    this.markdownThemeTable.setTableContentTextLineHeight(tableTextLineHeight)
  }

  /**
   * 设置表格圆角
   *
   * @param tableRadius 表格圆角 - 默认5.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableAllRadius
   */
  setTableRadius(tableRadius: number): void {
    this.markdownThemeTable.setTableAllRadius(tableRadius)
  }

  /**
   * 设置表格最小宽度
   *
   * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableMinCellWidth
   */
  setTableMinTextWidth(tableMinTextWidth: number): void {
    this.markdownThemeTable.setTableMinCellWidth(tableMinTextWidth)
  }

  /**
   * 设置表格最大宽度
   *
   * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableMaxCellWidth
   */
  setTableMaxTextWidth(tableMaxTextWidth: number): void {
    this.markdownThemeTable.setTableMaxCellWidth(tableMaxTextWidth)
  }

  /**
   * 设置表格第一列是否加粗
   *
   * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableFirstColumnIsBold
   */
  setTableFirstColumnBold(tableFirstColumnBold: boolean): void {
    this.markdownThemeTable.setTableFirstColumnIsBold(tableFirstColumnBold)
  }

  /**
   * 设置表格是否显示滚动条
   *
   * @param tableScrollBarShow 表格是否显示滚动条 - true：显示(auto状态)；false：不显示。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableScrollBarState
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
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeTable#setTableScrollBarColor
   */
  setTableScrollBarColor(tableScrollBarColor: number): void {
    this.markdownThemeTable.setTableScrollBarColor(tableScrollBarColor)
  }

  /**
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockIsDark
   */
  setIsDark(isDark: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockIsDark(isDark)
  }

  /**
   * 设置删除线颜色
   *
   * @param strikethroughColor 删除线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeStrikethrough#setStrikethroughTextDecorationColor
   */
  setStrikethroughColor(strikethroughColor: number): void {
    this.markdownThemeStrikethrough.setStrikethroughTextDecorationColor(strikethroughColor)
  }

  /**
   * 设置删除线样式
   *
   * @param strikethroughStyle 删除线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeStrikethrough#setStrikethroughTextDecorationStyle
   */
  setStrikethroughStyle(strikethroughStyle: MarkdownTextDecorationStyle): void {
    this.markdownThemeStrikethrough.setStrikethroughTextDecorationStyle(strikethroughStyle)
  }

  /**
   * 设置定义列表术语和定义行之间间距
   *
   * @param descListTermAndDefMargins 定义列表定义行缩进 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDefinitionList#setDefinitionListTermToDescriptionSpacing
   */
  setDescListTermAndDefMargins(descListTermAndDefMargins: number): void {
    this.markdownThemeDefinitionList.setDefinitionListTermToDescriptionSpacing(descListTermAndDefMargins)
  }

  /**
   * 设置定义列表定义行缩进
   *
   * @param descListDefIndentation 定义列表定义行缩进 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDefinitionList#setDefinitionListDescriptionIndent
   */
  setDescListDefIndentation(descListDefIndentation: number): void {
    this.markdownThemeDefinitionList.setDefinitionListDescriptionIndent(descListDefIndentation)
  }

  /**
   * 设置定义列表定义行间距
   *
   * @param descListDefMargins 定义列表定义行间距 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeDefinitionList#setDefinitionListDescriptionItemSpacing
   */
  setDescListDefMargins(descListDefMargins: number): void {
    this.markdownThemeDefinitionList.setDefinitionListDescriptionItemSpacing(descListDefMargins)
  }

  /**
   * 设置下标字体颜色
   *
   * @param subTextColor 下标字体颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSub#setSubTextFontColor
   */
  setSubTextColor(subTextColor: number): void {
    this.markdownThemeSub.setSubTextFontColor(subTextColor)
  }

  /**
   * 设置下标字体大小
   *
   * @param subTextSize 下标字体大小 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSub#setSubTextFontSize
   */
  setSubTextSize(subTextSize: number): void {
    this.markdownThemeSub.setSubTextFontSize(subTextSize)
  }

  /**
   * 设置下标偏移距离
   *
   * @param subOffsetDist 下标偏移距离 默认0.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSub#setSubTextBaselineOffset
   */
  setSubOffsetDist(subOffsetDist: number): void {
    this.markdownThemeSub.setSubTextBaselineOffset(subOffsetDist)
  }

  /**
   * 设置上标字体颜色
   *
   * @param supTextColor 上标字体颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSup#setSupTextFontColor
   */
  setSupTextColor(supTextColor: number): void {
    this.markdownThemeSup.setSupTextFontColor(supTextColor)
  }

  /**
   * 设置上标字体大小
   *
   * @param supTextSize 上标字体大小 默认8.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSup#setSupTextFontSize
   */
  setSupTextSize(supTextSize: number): void {
    this.markdownThemeSup.setSupTextFontSize(supTextSize)
  }

  /**
   * 设置上标偏移距离
   *
   * @param supOffsetDist 上标偏移距离 默认6.0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeSup#setSupTextBaselineOffset
   */
  setSupOffsetDist(supOffsetDist: number): void {
    this.markdownThemeSup.setSupTextBaselineOffset(supOffsetDist)
  }

  /**
   * 设置下划线颜色
   *
   * @param underlineColor 下划线颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHtmlUnderline#setHtmlUnderlineTextDecorationColor
   */
  setUnderlineColor(underlineColor: number): void {
    this.markdownThemeHtmlUnderline.setHtmlUnderlineTextDecorationColor(underlineColor)
  }

  /**
   * 设置下划线样式
   *
   * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeHtmlUnderline#setHtmlUnderlineTextDecorationStyle
   */
  setUnderlineStyle(underlineStyle: MarkdownTextDecorationStyle): void {
    this.markdownThemeHtmlUnderline.setHtmlUnderlineTextDecorationStyle(underlineStyle)
  }

  /**
   * 设置markdown是否支持滚动手势
   *
   * @param openGestureSwipe true-支持滚动手势，false-不支持滚动手势，默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeGlobal#setOpenGestureSwipe
   */
  setOpenGestureSwipe(openGestureSwipe: boolean): void {
    this.markdownThemeGlobal.setOpenGestureSwipe(openGestureSwipe)
  }

  /**
   * 设置codeformat是否用制表符
   *
   * @param useTab true-使用，false-不使用，默认false
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockUseTab
   */
  setUseTab(useTab: boolean): void {
    this.markdownThemeCodeBlock.setCodeBlockUseTab(useTab)
  }

  /**
   * 设置codeformat空格缩进数量
   *
   * @param indentWidth 空格缩进数量，默认4空格
   * @deprecated since 1.4.0
   * @useinstead MarkdownThemeCodeBlock#setCodeBlockIndentWidth
   */
  setIndentWidth(indentWidth: number): void {
    this.markdownThemeCodeBlock.setCodeBlockIndentWidth(indentWidth)
  }

  /**
   * 获取是否按照链接文本字体大小显示文本
   *
   * @returns 是否按照链接文本字体大小显示文本
   */
  getIsLinkSize(): boolean | undefined {
    return this.isLinkSize
  }

  /**
   * 获取全局样式
   *
   * @returns 全局样式对象
   */
  getMarkdownThemeGlobal(): MarkdownThemeGlobal {
    return this.markdownThemeGlobal
  }

  /**
   * 获取音频样式
   *
   * @returns 音频样式对象
   */
  getMarkdownThemeAudio(): MarkdownThemeAudio {
    return this.markdownThemeAudio
  }

  /**
   * 获取Banner样式
   *
   * @returns Banner样式对象
   */
  getMarkdownThemeBanner(): MarkdownThemeBanner {
    return this.markdownThemeBanner
  }

  /**
   * 获取块引用样式
   *
   * @returns 块引用样式对象
   */
  getMarkdownThemeBlockQuote(): MarkdownThemeBlockQuote {
    return this.markdownThemeBlockQuote
  }

  /**
   * 获取加粗文本样式
   *
   * @returns 加粗文本样式对象
   */
  getMarkdownThemeBold(): MarkdownThemeBold {
    return this.markdownThemeBold
  }

  /**
   * 获取代码块样式
   *
   * @returns 代码块样式对象
   */
  getMarkdownThemeCodeBlock(): MarkdownThemeCodeBlock {
    return this.markdownThemeCodeBlock
  }

  /**
   * 获取定义列表样式
   *
   * @returns 定义列表样式对象
   */
  getMarkdownThemeDefinitionList(): MarkdownThemeDefinitionList {
    return this.markdownThemeDefinitionList
  }

  /**
   * 获取分割线样式
   *
   * @returns 分割线样式对象
   */
  getMarkdownThemeDivider(): MarkdownThemeDivider {
    return this.markdownThemeDivider
  }

  /**
   * 获取脚注定义样式
   *
   * @returns 脚注定义样式对象
   */
  getMarkdownThemeFootnoteDef(): MarkdownThemeFootnoteDef {
    return this.markdownThemeFootnoteDef
  }

  /**
   * 获取脚注引用样式
   *
   * @returns 脚注引用样式对象
   */
  getMarkdownThemeFootnoteRef(): MarkdownThemeFootnoteRef {
    return this.markdownThemeFootnoteRef
  }

  /**
   * 获取数学公式样式
   *
   * @returns 数学公式样式对象
   */
  getMarkdownThemeLatexMath(): MarkdownThemeLatexMath {
    return this.markdownThemeLatexMath
  }

  /**
   * 获取标题样式
   *
   * @returns 标题样式对象
   */
  getMarkdownThemeHeading(): MarkdownThemeHeading {
    return this.markdownThemeHeading
  }

  /**
   * 获取HTML下划线文本样式
   *
   * @returns HTML下划线文本样式对象
   */
  getMarkdownThemeHtmlUnderline(): MarkdownThemeHtmlUnderline {
    return this.markdownThemeHtmlUnderline
  }

  /**
   * 获取图片样式
   *
   * @returns 图片样式对象
   */
  getMarkdownThemeImage(): MarkdownThemeImage {
    return this.markdownThemeImage
  }

  /**
   * 获取内联代码样式
   *
   * @returns 内联代码样式对象
   */
  getMarkdownThemeInlineCode(): MarkdownThemeInlineCode {
    return this.markdownThemeInlineCode
  }

  /**
   * 获取斜体文本样式
   *
   * @returns 斜体文本样式对象
   */
  getMarkdownThemeItalic(): MarkdownThemeItalic {
    return this.markdownThemeItalic
  }

  /**
   * 获取链接文本样式
   *
   * @returns 链接文本样式对象
   */
  getMarkdownThemeLink(): MarkdownThemeLink {
    return this.markdownThemeLink
  }

  /**
   * 获取有序列表样式
   *
   * @returns 有序列表样式对象
   */
  getMarkdownThemeOrderedList(): MarkdownThemeOrderedList {
    return this.markdownThemeOrderedList
  }

  /**
   * 获取段落样式
   *
   * @returns 段落样式对象
   */
  getMarkdownThemeParagraph(): MarkdownThemeParagraph {
    return this.markdownThemeParagraph
  }

  /**
   * 获取删除线文本样式
   *
   * @returns 删除线文本样式对象
   */
  getMarkdownThemeStrikethrough(): MarkdownThemeStrikethrough {
    return this.markdownThemeStrikethrough
  }

  /**
   * 获取下标文本样式
   *
   * @returns 下标文本样式对象
   */
  getMarkdownThemeSub(): MarkdownThemeSub {
    return this.markdownThemeSub
  }

  /**
   * 获取上标文本样式
   *
   * @returns 上标文本样式对象
   */
  getMarkdownThemeSup(): MarkdownThemeSup {
    return this.markdownThemeSup
  }

  /**
   * 获取表格样式
   *
   * @returns 表格样式对象
   */
  getMarkdownThemeTable(): MarkdownThemeTable {
    return this.markdownThemeTable
  }

  /**
   * 获取无序/任务列表样式
   *
   * @returns 无序/任务列表样式对象
   */
  getMarkdownThemeBulletList(): MarkdownThemeBulletList {
    return this.markdownThemeBulletList
  }

  /**
   * 获取视频样式
   *
   * @returns 视频样式对象
   */
  getMarkdownThemeVideo(): MarkdownThemeVideo {
    return this.markdownThemeVideo
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