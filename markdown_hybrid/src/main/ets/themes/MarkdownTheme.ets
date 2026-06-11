import { AudioTheme } from "./AudioTheme"
import { BannerTheme } from "./BannerTheme"
import { BlockQuoteTheme } from "./BlockQuoteTheme"
import { BoldTheme } from "./BoldTheme"
import { BulletListTheme } from "./BulletListTheme"
import { CodeBlockTheme } from "./CodeBlockTheme"
import { DefinitionListTheme } from "./DefinitionListTheme"
import { DividerTheme } from "./DividerTheme"
import { FootnoteDefTheme } from "./FootnoteDefTheme"
import { FootnoteRefTheme } from "./FootnoteRefTheme"
import { GlobalTheme } from "./GlobalTheme"
import { HeadingTheme } from "./HeadingTheme"
import { HighlightTheme } from "./HighlightTheme"
import { HtmlUnderlineTheme } from "./HtmlUnderlineTheme"
import { ImageTheme } from "./ImageTheme"
import { InlineCodeTheme } from "./InlineCodeTheme"
import { ItalicTheme } from "./ItalicTheme"
import { LinkTheme } from "./LinkTheme"
import { OrderedListTheme } from "./OrderedListTheme"
import { ParagraphTheme } from "./ParagraphTheme"
import { StrikethroughTheme } from "./StrikethroughTheme"
import { SubTheme } from "./SubTheme"
import { SupTheme } from "./SupTheme"
import { TableTheme } from "./TableTheme"
import { VideoTheme } from "./VideoTheme"


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
  private markdownThemeGlobal: GlobalTheme = new GlobalTheme()

  /**
   * 音频样式
   */
  private markdownThemeAudio: AudioTheme = new AudioTheme()

  /**
   * Banner样式
   */
  private markdownThemeBanner: BannerTheme = new BannerTheme()

  /**
   * 块引用样式
   */
  private markdownThemeBlockQuote: BlockQuoteTheme = new BlockQuoteTheme()

  /**
   * 加粗文本样式
   */
  private markdownThemeBold: BoldTheme = new BoldTheme()

  /**
   * 代码块样式
   */
  private markdownThemeCodeBlock: CodeBlockTheme = new CodeBlockTheme()

  /**
   * 定义列表样式
   */
  private markdownThemeDefinitionList: DefinitionListTheme = new DefinitionListTheme()

  /**
   * 分割线样式
   */
  private markdownThemeDivider: DividerTheme = new DividerTheme()

  /**
   * 脚注定义样式
   */
  private markdownThemeFootnoteDef: FootnoteDefTheme = new FootnoteDefTheme()

  /**
   * 脚注引用样式
   */
  private markdownThemeFootnoteRef: FootnoteRefTheme = new FootnoteRefTheme()

  /**
   * 标题样式
   */
  private markdownThemeHeading: HeadingTheme = new HeadingTheme()

  /**
   * HTML下划线文本样式
   */
  private markdownThemeHtmlUnderline: HtmlUnderlineTheme = new HtmlUnderlineTheme()

  /**
   * 图片样式
   */
  private markdownThemeImage: ImageTheme = new ImageTheme()

  /**
   * 内联代码样式
   */
  private markdownThemeInlineCode: InlineCodeTheme = new InlineCodeTheme()

  /**
   * 斜体文本样式
   */
  private markdownThemeItalic: ItalicTheme = new ItalicTheme()

  /**
   * 链接文本样式
   */
  private markdownThemeLink: LinkTheme = new LinkTheme()

  /**
   * 有序列表样式
   */
  private markdownThemeOrderedList: OrderedListTheme = new OrderedListTheme()

  /**
   * 段落样式
   */
  private markdownThemeParagraph: ParagraphTheme = new ParagraphTheme()

  /**
   * 删除线文本样式
   */
  private markdownThemeStrikethrough: StrikethroughTheme = new StrikethroughTheme()

  /**
   * 下标文本样式
   */
  private markdownThemeSub: SubTheme = new SubTheme()

  /**
   * 上标文本样式
   */
  private markdownThemeSup: SupTheme = new SupTheme()

  /**
   * 表格样式
   */
  private markdownThemeTable: TableTheme = new TableTheme()

  /**
   * 无序/任务列表样式
   */
  private markdownThemeBulletList: BulletListTheme = new BulletListTheme()

  /**
   * 视频样式
   */
  private markdownThemeVideo: VideoTheme = new VideoTheme()

  /**
   * 高亮样式
   */
  private markdownHighlightTheme: HighlightTheme = new HighlightTheme()

  /**
   * 设置上下文
   *
   * @param context 上下文
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setStageContext
   */
  setContext(context: Context): MarkdownTheme {
    this.markdownThemeGlobal.setStageContext(context)
    return this
  }

  /**
   * 设置浅色主题整体样式
   */
  setDefaultTheme(): MarkdownTheme {
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
    return this
  }

  /**
   * 设置深色主题整体样式
   */
  setDarculaTheme(): MarkdownTheme {
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
    return this
  }

  /**
   * 设置全局样式
   *
   * @param markdownThemeGlobal 全局样式
   */
  setGlobalTheme(markdownThemeGlobal: GlobalTheme): MarkdownTheme {
    this.markdownThemeGlobal = markdownThemeGlobal
    return this
  }

  /**
   * 设置音频样式
   *
   * @param markdownThemeAudio 音频样式
   */
  setAudioTheme(markdownThemeAudio: AudioTheme): MarkdownTheme {
    this.markdownThemeAudio = markdownThemeAudio
    return this
  }

  /**
   * 设置Banner样式
   *
   * @param markdownThemeBanner Banner样式
   */
  setBannerTheme(markdownThemeBanner: BannerTheme): MarkdownTheme {
    this.markdownThemeBanner = markdownThemeBanner
    return this
  }

  /**
   * 设置块引用样式
   *
   * @param markdownThemeBlockQuote 块引用样式
   */
  setBlockQuoteTheme(markdownThemeBlockQuote: BlockQuoteTheme): MarkdownTheme {
    this.markdownThemeBlockQuote = markdownThemeBlockQuote
    return this
  }

  /**
   * 设置加粗文本样式
   *
   * @param markdownThemeBold 加粗文本样式
   */
  setBoldTheme(markdownThemeBold: BoldTheme): MarkdownTheme {
    this.markdownThemeBold = markdownThemeBold
    return this
  }

  /**
   * 设置代码块样式
   *
   * @param markdownThemeCodeBlock 代码块样式
   */
  setCodeBlockTheme(markdownThemeCodeBlock: CodeBlockTheme): MarkdownTheme {
    this.markdownThemeCodeBlock = markdownThemeCodeBlock
    return this
  }

  /**
   * 设置定义列表样式
   *
   * @param markdownThemeDefinitionList 定义列表样式
   */
  setDefinitionListTheme(markdownThemeDefinitionList: DefinitionListTheme): MarkdownTheme {
    this.markdownThemeDefinitionList = markdownThemeDefinitionList
    return this
  }

  /**
   * 设置分割线样式
   *
   * @param markdownThemeDivider 分割线样式
   */
  setDividerTheme(markdownThemeDivider: DividerTheme): MarkdownTheme {
    this.markdownThemeDivider = markdownThemeDivider
    return this
  }

  /**
   * 设置脚注定义样式
   *
   * @param markdownThemeFootnoteDef 脚注定义样式
   */
  setFootnoteDefTheme(markdownThemeFootnoteDef: FootnoteDefTheme): MarkdownTheme {
    this.markdownThemeFootnoteDef = markdownThemeFootnoteDef
    return this
  }

  /**
   * 设置脚注引用样式
   *
   * @param markdownThemeFootnoteRef 脚注引用样式
   */
  setFootnoteRefTheme(markdownThemeFootnoteRef: FootnoteRefTheme): MarkdownTheme {
    this.markdownThemeFootnoteRef = markdownThemeFootnoteRef
    return this
  }

  /**
   * 设置标题样式
   *
   * @param markdownThemeHeading 标题样式
   */
  setHeadingTheme(markdownThemeHeading: HeadingTheme): MarkdownTheme {
    this.markdownThemeHeading = markdownThemeHeading
    return this
  }

  /**
   * 设置HTML下划线文本样式
   *
   * @param markdownThemeHtmlUnderline HTML下划线文本样式
   */
  setHtmlUnderlineTheme(markdownThemeHtmlUnderline: HtmlUnderlineTheme): MarkdownTheme {
    this.markdownThemeHtmlUnderline = markdownThemeHtmlUnderline
    return this
  }

  /**
   * 设置图片样式
   *
   * @param markdownThemeImage 图片样式
   */
  setImageTheme(markdownThemeImage: ImageTheme): MarkdownTheme {
    this.markdownThemeImage = markdownThemeImage
    return this
  }

  /**
   * 设置内联代码样式
   *
   * @param markdownThemeInlineCode 内联代码样式
   */
  setInlineCodeTheme(markdownThemeInlineCode: InlineCodeTheme): MarkdownTheme {
    this.markdownThemeInlineCode = markdownThemeInlineCode
    return this
  }

  /**
   * 设置斜体文本样式
   *
   * @param markdownThemeItalic 斜体文本样式
   */
  setItalicTheme(markdownThemeItalic: ItalicTheme): MarkdownTheme {
    this.markdownThemeItalic = markdownThemeItalic
    return this
  }

  /**
   * 设置链接文本样式
   *
   * @param markdownThemeLink 链接文本样式
   */
  setLinkTheme(markdownThemeLink: LinkTheme): MarkdownTheme {
    this.markdownThemeLink = markdownThemeLink
    return this
  }

  /**
   * 设置有序列表样式
   *
   * @param markdownThemeOrderedList 有序列表样式
   */
  setOrderedListTheme(markdownThemeOrderedList: OrderedListTheme): MarkdownTheme {
    this.markdownThemeOrderedList = markdownThemeOrderedList
    return this
  }

  /**
   * 设置段落样式
   *
   * @param markdownThemeParagraph 段落样式
   */
  setParagraphTheme(markdownThemeParagraph: ParagraphTheme): MarkdownTheme {
    this.markdownThemeParagraph = markdownThemeParagraph
    return this
  }

  /**
   * 设置删除线文本样式
   *
   * @param markdownThemeStrikethrough 删除线文本样式
   */
  setStrikethroughTheme(markdownThemeStrikethrough: StrikethroughTheme): MarkdownTheme {
    this.markdownThemeStrikethrough = markdownThemeStrikethrough
    return this
  }

  /**
   * 设置下标文本样式
   *
   * @param markdownThemeSub 下标文本样式
   */
  setSubTheme(markdownThemeSub: SubTheme): MarkdownTheme {
    this.markdownThemeSub = markdownThemeSub
    return this
  }

  /**
   * 设置上标文本样式
   *
   * @param markdownThemeSup 上标文本样式
   */
  setSupTheme(markdownThemeSup: SupTheme): MarkdownTheme {
    this.markdownThemeSup = markdownThemeSup
    return this
  }

  /**
   * 设置表格样式
   *
   * @param markdownThemeTable 表格样式
   */
  setTableTheme(markdownThemeTable: TableTheme): MarkdownTheme {
    this.markdownThemeTable = markdownThemeTable
    return this
  }

  /**
   * 设置无序/任务列表样式
   *
   * @param markdownThemeBulletList 无序/任务列表样式
   */
  setBulletListTheme(markdownThemeBulletList: BulletListTheme): MarkdownTheme {
    this.markdownThemeBulletList = markdownThemeBulletList
    return this
  }

  /**
   * 设置视频样式
   *
   * @param markdownThemeVideo 视频样式
   */
  setVideoTheme(markdownThemeVideo: VideoTheme): MarkdownTheme {
    this.markdownThemeVideo = markdownThemeVideo
    return this
  }

  /**
   * 设置高亮样式
   *
   * @param markdownHighlightTheme 高亮样式
   */
  setHighlightTheme(markdownHighlightTheme: HighlightTheme): MarkdownTheme {
    this.markdownHighlightTheme = markdownHighlightTheme
    return this
  }

  /**
   * 设置代码块全屏图片icon
   *
   * @param codeFullScreenIcon 代码块全屏图片icon
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenIcon
   */
  setCodeFullScreenIcon(codeFullScreenIcon: Resource): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockFullScreenIcon(codeFullScreenIcon)
    return this
  }

  /**
   * 设置代码块复制图片icon
   *
   * @param codeCopyIcon 代码块复制图片icon
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockCopyIcon
   */
  setCodeCopyIcon(codeCopyIcon: Resource): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockCopyIcon(codeCopyIcon)
    return this
  }

  /**
   * 设置音频图片icon
   *
   * @param audioIcon 音频图片icon
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioIcon
   */
  setAudioIcon(audioIcon: Resource): MarkdownTheme {
    this.markdownThemeAudio.setAudioIcon(audioIcon)
    return this
  }

  /**
   * 设置视频默认占位图
   *
   * @param videoImage 视频默认占位图
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoPlaceholder
   */
  setVideoImage(videoImage: Resource): MarkdownTheme {
    this.markdownThemeVideo.setVideoPlaceholder(videoImage)
    return this
  }

  /**
   * 设置视频播放按钮icon
   *
   * @param playCircleFillIcon 视频播放按钮icon
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoPlayIcon
   */
  setPlayCircleFillIcon(playCircleFillIcon: Resource): MarkdownTheme {
    this.markdownThemeVideo.setVideoPlayIcon(playCircleFillIcon)
    return this
  }

  /**
   * 设置banner占位图
   *
   * @param bannerImage banner占位图
   * @deprecated since 1.4.0
   * @useinstead BannerTheme#setBannerPlaceholder
   */
  setBannerImage(bannerImage: Resource): MarkdownTheme {
    this.markdownThemeBanner.setBannerPlaceholder(bannerImage)
    return this
  }

  /**
   * 设置图片占位图
   *
   * @param imageResource 图片占位图
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImagePlaceholder
   */
  setImageResource(imageResource: Resource): MarkdownTheme {
    this.markdownThemeImage.setImagePlaceholder(imageResource)
    return this
  }

  /**
   * 设置视频发布默认图标
   *
   * @param videoReleaseImage 视频发布默认图标
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonIcon
   */
  setVideoReleaseImage(videoReleaseImage: Resource): MarkdownTheme {
    this.markdownThemeVideo.setVideoReleaseButtonIcon(videoReleaseImage)
    return this
  }

  /**
   * 设置视频下载默认图标
   *
   * @param videoDownloadImage 视频下载默认图标
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonIcon
   */
  setVideoDownloadImage(videoDownloadImage: Resource): MarkdownTheme {
    this.markdownThemeVideo.setVideoDownloadButtonIcon(videoDownloadImage)
    return this
  }

  /**
   * 设置图片下载默认图标
   *
   * @param imageDownloadImage 图片下载默认图标
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonIcon
   */
  setImageDownloadImage(imageDownloadImage: Resource): MarkdownTheme {
    this.markdownThemeImage.setImageDownloadButtonIcon(imageDownloadImage)
    return this
  }

  /**
   * 设置markdown是否同步解析
   *
   * @param isMarkdownParserSync markdown是否同步解析 - 默认false
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsMarkdownParserSync
   */
  setIsMarkdownParserSync(isMarkdownParserSync: boolean): MarkdownTheme {
    this.markdownThemeGlobal.setIsMarkdownParserSync(isMarkdownParserSync)
    return this
  }

  /**
   * 设置是否打开长按复制粘贴
   *
   * @param isOnCopy 是否打开长按复制粘贴 - 默认true
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsOnCopy
   */
  setIsOnCopy(isOnCopy: boolean): MarkdownTheme {
    this.markdownThemeGlobal.setIsOnCopy(isOnCopy)
    return this
  }

  /**
   * 设置markdown第一个模块上边距
   *
   * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setGlobalMargin
   */
  setBlockFirstTopMargin(blockFirstTopMargin: number): MarkdownTheme {
    this.markdownThemeGlobal.setGlobalMargin({top: blockFirstTopMargin})
    return this
  }

  /**
   * 设置markdown最后一个模块下边距
   *
   * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setGlobalMargin
   */
  setBlockLastBottomMargin(blockLastBottomMargin: number): MarkdownTheme {
    this.markdownThemeGlobal.setGlobalMargin({bottom: blockLastBottomMargin})
    return this
  }

  /**
   * 设置模块间上下间距
   *
   * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setBlockSpacing
   */
  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): MarkdownTheme {
    this.markdownThemeGlobal.setBlockSpacing(blockTopAndBottomMargins)
    return this
  }

  /**
   * 设置链接是否是图片显示
   *
   * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkIsIcon
   */
  setIsLinkStyle(isLinkStyle: boolean): MarkdownTheme {
    this.markdownThemeLink.setLinkIsIcon(isLinkStyle)
    return this
  }

  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkListIsIcon
   */
  setIsListLinkStyle(isListLinkStyle: boolean): MarkdownTheme {
    this.markdownThemeLink.setLinkListIsIcon(isListLinkStyle)
    return this
  }

  /**
   * 设置文本格式链接文本颜色
   *
   * @param linkColor 文本格式链接文本颜色 - 默认0xFF0000FF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextFontColor
   */
  setLinkColor(linkColor: number): MarkdownTheme {
    this.markdownThemeLink.setLinkTextFontColor(linkColor)
    return this
  }

  /**
   * 设置是否按照链接文本字体大小显示文本
   *
   * @param isLinkSize 是否按照链接文本字体大小显示文本 - true：显示链接字体文本大小；false：跟随标题段落大小显示。默认true
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextFontSize
   */
  setIsLinkSize(isLinkSize: boolean): MarkdownTheme {
    if (isLinkSize) {
      if (this.markdownThemeLink.getLinkTextFontSize() == undefined) {
        this.markdownThemeLink.setLinkTextFontSize(14.0)
      }
    } else {
      this.markdownThemeLink.setLinkTextFontSize(undefined)
    }
    return this
  }

  /**
   * 设置文本格式链接文字大小
   *
   * @param linkSize 文本格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextFontSize
   */
  setLinkSize(linkSize: number): MarkdownTheme {
    this.markdownThemeLink.setLinkTextFontSize(linkSize)
    return this
  }

  /**
   * 设置文本格式链接文字行高
   *
   * @param linkLineHeight 文本格式链接文字行高
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextLineHeight
   */
  setLinkLineHeight(linkLineHeight: number): MarkdownTheme {
    this.markdownThemeLink.setLinkTextLineHeight(linkLineHeight)
    return this
  }

  /**
   * 设置文本格式链接背景颜色
   *
   * @param linkBackgroundColor 文本格式链接背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextBackgroundColor
   */
  setLinkBackgroundColor(linkBackgroundColor: number): MarkdownTheme {
    this.markdownThemeLink.setLinkTextBackgroundColor(linkBackgroundColor)
    return this
  }

  /**
   * 设置文本格式是否显示链接下划线
   *
   * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextDecorationType
   */
  setIsLinkUnderlined(isLinkUnderlined: boolean): MarkdownTheme {
    if (isLinkUnderlined) { // 显示下划线
      this.markdownThemeLink.setLinkTextDecorationType(TextDecorationType.Underline)
    } else { // 不显示下划线
      this.markdownThemeLink.setLinkTextDecorationType(TextDecorationType.None)
    }
    return this
  }

  /**
   * 设置圆形图片格式链接主题背景颜色
   *
   * @param linkCircleImageBackgroundColor 圆形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconBackgroundColor
   */
  setLinkCircleImageBackgroundColor(linkCircleImageBackgroundColor: number): MarkdownTheme {
    this.markdownThemeLink.setLinkCircleIconBackgroundColor(linkCircleImageBackgroundColor)
    return this
  }

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param linkCircleImageButtonBackgroundColor 圆形图片格式链接控件背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconButtonBackgroundColor
   */
  setLinkCircleImageButtonBackgroundColor(linkCircleImageButtonBackgroundColor: number): MarkdownTheme {
    this.markdownThemeLink.setLinkCircleIconButtonBackgroundColor(linkCircleImageButtonBackgroundColor)
    return this
  }

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconTextSize
   */
  setLinkCircleImageTextSize(linkCircleImageTextSize: number): MarkdownTheme {
    this.markdownThemeLink.setLinkCircleIconTextSize(linkCircleImageTextSize)
    return this
  }

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconTextColor
   */
  setLinkCircleImageTextColor(linkCircleImageTextColor: number): MarkdownTheme {
    this.markdownThemeLink.setLinkCircleIconTextColor(linkCircleImageTextColor)
    return this
  }

  /**
   * 设置圆形图片格式链接半径
   *
   * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconRadius
   */
  setLinkCircleImageRadius(linkCircleImageRadius: number): MarkdownTheme {
    this.markdownThemeLink.setLinkCircleIconRadius(linkCircleImageRadius)
    return this
  }

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconMargin
   */
  setLinkCircleImageMargin(linkCircleImageMargin: number): MarkdownTheme {
    this.markdownThemeLink.setLinkCircleIconMargin(linkCircleImageMargin)
    return this
  }

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectImageBackgroundColor 圆角矩形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconBackgroundColor
   */
  setLinkRectImageBackgroundColor(linkRectImageBackgroundColor: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectIconBackgroundColor(linkRectImageBackgroundColor)
    return this
  }

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectImageButtonBackgroundColor 圆角矩形图片格式链接控件背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconButtonBackgroundColor
   */
  setLinkRectImageButtonBackgroundColor(linkRectImageButtonBackgroundColor: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectIconButtonBackgroundColor(linkRectImageButtonBackgroundColor)
    return this
  }

  /**
   * 圆角矩形图片格式链接文字大小
   *
   * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconTextSize
   */
  setLinkRectImageTextSize(linkRectImageTextSize: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectIconTextSize(linkRectImageTextSize)
    return this
  }

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconTextColor
   */
  setLinkRectImageTextColor(linkRectImageTextColor: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectIconTextColor(linkRectImageTextColor)
    return this
  }

  /**
   * 圆角矩形图片格式链接控件高度
   *
   * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconHeight
   */
  setLinkRectImageHeight(linkRectImageHeight: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectIconHeight(linkRectImageHeight)
    return this
  }

  /**
   * 圆角矩形图片格式链接左右内边距
   *
   * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconPadding
   */
  setLinkRectImagePadding(linkRectImagePadding: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectIconPadding(linkRectImagePadding)
    return this
  }

  /**
   * 圆角矩形图片格式链接圆角半径
   *
   * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconRadius
   */
  setLinkRectImageRadius(linkRectImageRadius: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectIconRadius(linkRectImageRadius)
    return this
  }

  /**
   * 圆角矩形图片格式链接左右外边距
   *
   * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconMargin
   */
  setLinkRectImageMargin(linkRectImageMargin: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectIconMargin(linkRectImageMargin)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectToolImageBackgroundColor 空心圆角矩形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconBackgroundColor
   */
  setLinkRectToolImageBackgroundColor(linkRectToolImageBackgroundColor: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectToolIconBackgroundColor(linkRectToolImageBackgroundColor)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectToolImageButtonBackgroundColor 空心圆角矩形图片格式链接控件背景颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconBackgroundColor
   */
  setLinkRectToolImageButtonBackgroundColor(linkRectToolImageButtonBackgroundColor: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectToolIconBackgroundColor(linkRectToolImageButtonBackgroundColor)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconTextSize
   */
  setLinkRectToolImageTextSize(linkRectToolImageTextSize: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectToolIconTextSize(linkRectToolImageTextSize)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconHeight
   */
  setLinkRectToolImageHeight(linkRectToolImageHeight: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectToolIconHeight(linkRectToolImageHeight)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconPadding
   */
  setLinkRectToolImagePadding(linkRectToolImagePadding: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectToolIconPadding(linkRectToolImagePadding)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconBorderWidth
   */
  setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectToolIconBorderWidth(linkRectToolImageBorderWidth)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconDividingLineWidth
   */
  setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectToolIconDividingLineWidth(linkRectToolImageDividingLineWidth)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconMargin
   */
  setLinkRectToolImageMargin(linkRectToolImageMargin: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectToolIconMargin(linkRectToolImageMargin)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconLineLeftPadding
   */
  setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectToolIconLineLeftPadding(linkRectToolImageLineLeftPadding)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconLineRightPadding
   */
  setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: number): MarkdownTheme {
    this.markdownThemeLink.setLinkRectToolIconLineRightPadding(linkRectToolImageLineRightPadding)
    return this
  }

  /**
   * 设置块引用左边距
   *
   * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteMargin
   */
  setBlockQuoteLeftMargin(blockQuoteLeftMargin: number): MarkdownTheme {
    this.markdownThemeBlockQuote.setBlockQuoteMargin({left: blockQuoteLeftMargin})
    return this
  }

  /**
   * 设置块引用右边距
   *
   * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteMargin
   */
  setBlockQuoteRightMargin(blockQuoteRightMargin: number): MarkdownTheme {
    this.markdownThemeBlockQuote.setBlockQuoteMargin({right: blockQuoteRightMargin})
    return this
  }

  /**
   * 设置块引用左边线条宽度
   *
   * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteLeftBorderWidth
   */
  setBlockQuoteWidth(blockQuoteWidth: number): MarkdownTheme {
    this.markdownThemeBlockQuote.setBlockQuoteLeftBorderWidth(blockQuoteWidth)
    return this
  }

  /**
   * 设置块引用左边线条颜色
   *
   * @param blockQuoteColor 块引用左边线条颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteLeftBorderColor
   */
  setBlockQuoteColor(blockQuoteColor: number): MarkdownTheme {
    this.markdownThemeBlockQuote.setBlockQuoteLeftBorderColor(blockQuoteColor)
    return this
  }

  /**
   * 设置块引用背景颜色
   *
   * @param blockQuoteBackgroundColor 块引用背景颜色 - 默认0xFFEAEAEA
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteBackgroundColor
   */
  setBlockQuoteBackgroundColor(blockQuoteBackgroundColor: number): MarkdownTheme {
    this.markdownThemeBlockQuote.setBlockQuoteBackgroundColor(blockQuoteBackgroundColor)
    return this
  }

  /**
   * 设置块引用子模块上下间距
   *
   * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteChildSpacing
   */
  setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: number): MarkdownTheme {
    this.markdownThemeBlockQuote.setBlockQuoteChildSpacing(blockQuoteTopAndBottomMargins)
    return this
  }

  /**
   * 设置有序列表、无序列表、任务列表子模块上下间距
   *
   * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListChildSpacing
   *             MarkdownThemeOrderedListTheme#setBulletListChildSpacing
   */
  setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: number): MarkdownTheme {
    this.markdownThemeOrderedList.setOrderedListChildSpacing(blockOrderedAndBulletTopAndBottomMargins)
    this.markdownThemeBulletList.setBulletListChildSpacing(blockOrderedAndBulletTopAndBottomMargins)
    return this
  }

  /**
   * 设置有序列表、无序列表、任务列表左边距
   *
   * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMargin
   *             MarkdownThemeOrderedListTheme#setBulletListMargin
   */
  setBlockLeftMargin(blockLeftMargin: number): MarkdownTheme {
    this.markdownThemeOrderedList.setOrderedListMargin({left: blockLeftMargin})
    this.markdownThemeBulletList.setBulletListMargin({left: blockLeftMargin})
    return this
  }

  /**
   * 设置有序列表、无序列表、任务列表右边距
   *
   * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMargin
   *             MarkdownThemeOrderedListTheme#setBulletListMargin
   */
  setBlockRightMargin(blockRightMargin: number): MarkdownTheme {
    this.markdownThemeOrderedList.setOrderedListMargin({right: blockRightMargin})
    this.markdownThemeBulletList.setBulletListMargin({right: blockRightMargin})
    return this
  }

  /**
   * 设置有序列表前缀文本是否加粗
   *
   * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontWeight
   */
  setOrderedListItemPrefixBold(orderedListItemPrefixBold: boolean): MarkdownTheme {
    if (orderedListItemPrefixBold) {
      this.markdownThemeOrderedList.setOrderedListMarkerTextFontWeight(FontWeight.Bold)
    } else {
      this.markdownThemeOrderedList.setOrderedListMarkerTextFontWeight(FontWeight.Normal)
    }
    return this
  }

  /**
   * 设置有序列表前缀文本颜色
   *
   * @param orderedListItemColor 有序列表前缀文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontColor
   */
  setOrderedListItemColor(orderedListItemColor: number): MarkdownTheme {
    this.markdownThemeOrderedList.setOrderedListMarkerTextFontColor(orderedListItemColor)
    return this
  }

  /**
   * 设置有序列表前缀文本大小
   *
   * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontSize
   */
  setOrderedListItemSize(orderedListItemSize: number): MarkdownTheme {
    this.markdownThemeOrderedList.setOrderedListMarkerTextFontSize(orderedListItemSize)
    return this
  }

  /**
   * 设置有序列表前缀文本行高
   *
   * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextLineHeight
   */
  setOrderedListItemLineHeight(orderedListItemLineHeight: number): MarkdownTheme {
    this.markdownThemeOrderedList.setOrderedListMarkerTextLineHeight(orderedListItemLineHeight)
    return this
  }

  /**
   * 设置无序列表前缀是否全部是实心圆型
   *
   * @param bulletListItemCircle 无序列表前缀是否全部是实心圆型 - 默认false
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletIsCircle
   */
  setBulletListItemCircle(bulletListItemCircle: boolean): MarkdownTheme {
    this.markdownThemeBulletList.setBulletListBulletIsCircle(bulletListItemCircle)
    return this
  }

  /**
   * 设置无序列表前缀文本颜色
   *
   * @param bulletListItemColor 无序列表前缀文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextFontColor
   */
  setBulletListItemColor(bulletListItemColor: number): MarkdownTheme {
    this.markdownThemeBulletList.setBulletListBulletTextFontColor(bulletListItemColor)
    return this
  }

  /**
   * 设置无序列表前缀文本大小
   *
   * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextFontSize
   */
  setBulletListItemSize(bulletListItemSize: number): MarkdownTheme {
    this.markdownThemeBulletList.setBulletListBulletTextFontSize(bulletListItemSize)
    return this
  }

  /**
   * 设置无序列表前缀文本行高
   *
   * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextLineHeight
   */
  setBulletListItemLineHeight(bulletListItemLineHeight: number): MarkdownTheme {
    this.markdownThemeBulletList.setBulletListBulletTextLineHeight(bulletListItemLineHeight)
    return this
  }

  /**
   * 设置任务列表选择框宽高
   *
   * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListCheckboxWidth
   *             MarkdownThemeBulletListTheme#setBulletListCheckboxHeight
   */
  setTaskListItemLength(taskListItemLength: number): MarkdownTheme {
    this.markdownThemeBulletList.setBulletListCheckboxWidth(taskListItemLength)
    this.markdownThemeBulletList.setBulletListCheckboxHeight(taskListItemLength)
    return this
  }

  /**
   * 设置是否格式化代码块内容
   *
   * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块内容；false：不格式化代码块内容。默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsCodeFormat
   */
  setIsCodeFormat(isCodeFormat: boolean): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockIsCodeFormat(isCodeFormat)
    return this
  }

  /**
   * 设置内联代码文本颜色
   *
   * @param codeTextColor 内联代码文本颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontColor
   */
  setCodeTextColor(codeTextColor: number): MarkdownTheme {
    this.markdownThemeInlineCode.setInlineCodeTextFontColor(codeTextColor)
    return this
  }

  /**
   * 设置内联代码背景颜色
   *
   * @param codeBackgroundColor 内联代码背景颜色 - 默认0xFFEAEAEA
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextBackgroundColor
   */
  setCodeBackgroundColor(codeBackgroundColor: number): MarkdownTheme {
    this.markdownThemeInlineCode.setInlineCodeTextBackgroundColor(codeBackgroundColor)
    return this
  }

  /**
   * 设置内联代码文本大小
   *
   * @param codeTextSize 内联代码文本大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontSize
   */
  setCodeTextSize(codeTextSize: number): MarkdownTheme {
    this.markdownThemeInlineCode.setInlineCodeTextFontSize(codeTextSize)
    return this
  }

  /**
   * 设置内联代码文本字体
   *
   * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontFamily
   */
  setCodeTypeface(codeTypeface: string): MarkdownTheme {
    this.markdownThemeInlineCode.setInlineCodeTextFontFamily(codeTypeface)
    return this
  }

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockParserSync
   */
  setIsCodeBlockParserSync(isCodeBlockParserSync: boolean): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockParserSync(isCodeBlockParserSync)
    return this
  }

  /**
   * 设置代码块代码文本颜色
   *
   * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontColor
   */
  setCodeBlockTextColor(codeBlockTextColor: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockTextFontColor(codeBlockTextColor)
    return this
  }

  /**
   * 设置代码块代码类型文本颜色
   *
   * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTypeTextFontColor
   */
  setCodeBlockTypeTextColor(codeBlockTypeTextColor: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockTypeTextFontColor(codeBlockTypeTextColor)
    return this
  }

  /**
   * 设置代码块代码类型文本
   *
   * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTypeText
   */
  setCodeBlockTypeTextStr(codeBlockTypeTextStr: string): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockTypeText(codeBlockTypeTextStr)
    return this
  }

  /**
   * 设置代码类型和代码块距离
   *
   * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTitleLayoutMarginBottom
   */
  setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockTitleLayoutMarginBottom(codeBlockTypeTextPadding)
    return this
  }

  /**
   * 设置代码块复制、全屏图片文字是否显示
   *
   * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenTextIsShow
   *             MarkdownThemeCodeBlockTheme#setCodeBlockCopyTextIsShow
   */
  setCodeBlockIconTextHide(codeBlockIconTextHide: boolean): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockFullScreenTextIsShow(codeBlockIconTextHide)
    this.markdownThemeCodeBlock.setCodeBlockCopyTextIsShow(codeBlockIconTextHide)
    return this
  }

  /**
   * 设置代码块代码行号是否显示
   *
   * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockLineNumberIsShow
   */
  setCodeBlockLineNumberHide(codeBlockLineNumberHide: boolean): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockLineNumberIsShow(codeBlockLineNumberHide)
    return this
  }

  /**
   * 设置代码块背景颜色
   *
   * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockBackgroundColor
   */
  setCodeBlockBackgroundColor(codeBlockBackgroundColor: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockBackgroundColor(codeBlockBackgroundColor)
    return this
  }

  /**
   * 设置代码块左边距
   *
   * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockMargin
   */
  setCodeMultilineMargin(codeMultilineMargin: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockMargin({left: codeMultilineMargin})
    return this
  }

  /**
   * 设置代码块字体
   *
   * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontFamily
   */
  setCodeBlockTypeface(codeBlockTypeface: string): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockTextFontFamily(codeBlockTypeface)
    return this
  }

  /**
   * 设置代码块代码文本大小
   *
   * @param codeBlockTextSize 代码块代码文本大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontSize
   */
  setCodeBlockTextSize(codeBlockTextSize: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockTextFontSize(codeBlockTextSize)
    return this
  }

  /**
   * 设置代码块代码文本行高
   *
   * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextLineHeight
   */
  setCodeBlockLineHeight(codeBlockLineHeight: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockTextLineHeight(codeBlockLineHeight)
    return this
  }

  /**
   * 设置代码块控件圆角大小
   *
   * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockRadius
   */
  setCodeBlockRadius(codeBlockRadius: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockRadius(codeBlockRadius)
    return this
  }

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenButtonIsShow
   */
  setIsCodeFullScreen(isCodeFullScreen: boolean): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockFullScreenButtonIsShow(isCodeFullScreen)
    return this
  }

  /**
   * 设置代码块代码全屏、代码复制按钮宽高
   *
   * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenIconHeight
   *             MarkdownThemeCodeBlockTheme#setCodeBlockFullScreenIconWidth
   *             MarkdownThemeCodeBlockTheme#setCodeBlockCopyIconHeight
   *             MarkdownThemeCodeBlockTheme#setCodeBlockCopyIconWidth
   */
  setIconWidthAndHeight(iconWidthAndHeight: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockFullScreenIconHeight(iconWidthAndHeight)
    this.markdownThemeCodeBlock.setCodeBlockFullScreenIconWidth(iconWidthAndHeight)
    this.markdownThemeCodeBlock.setCodeBlockCopyIconHeight(iconWidthAndHeight)
    this.markdownThemeCodeBlock.setCodeBlockCopyIconWidth(iconWidthAndHeight)
    return this
  }

  /**
   * 设置组合代码未选中标题字体大小
   *
   * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleTextSize
   */
  setCodeListTitleTextSize(codeListTitleTextSize: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockListTitleTextSize(codeListTitleTextSize)
    return this
  }

  /**
   * 设置组合代码选中标题字体大小
   *
   * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectTextSize
   */
  setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectTextSize(codeListTitleSelectTextSize)
    return this
  }

  /**
   * 设置组合代码选中标题文本颜色
   *
   * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认0xFFFF0000
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectTextColor
   */
  setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectTextColor(codeListTitleSelectTextColor)
    return this
  }

  /**
   * 设置组合代码未选中标题文本颜色
   *
   * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleUnselectTextColor
   */
  setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockListTitleUnselectTextColor(codeListTitleUnSelectTextColor)
    return this
  }

  /**
   * 设置组合代码选中标题背景颜色
   *
   * @param codeListTitleSelectBackgroundColor 组合代码选中标题背景颜色 - 默认0xFF808080
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectBackgroundColor
   */
  setCodeListTitleSelectBackgroundColor(codeListTitleSelectBackgroundColor: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockListTitleSelectBackgroundColor(codeListTitleSelectBackgroundColor)
    return this
  }

  /**
   * 设置组合代码未选中标题背景颜色
   *
   * @param codeListTitleUnSelectBackgroundColor 组合代码未选中标题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleUnselectBackgroundColor
   */
  setCodeListTitleUnSelectBackgroundColor(codeListTitleUnSelectBackgroundColor: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockListTitleUnselectBackgroundColor(codeListTitleUnSelectBackgroundColor)
    return this
  }

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsSeparate
   */
  setIsSeparateCodeBlock(isSeparateCodeBlock: boolean): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockIsSeparate(isSeparateCodeBlock)
    return this
  }

  /**
   * 设置单独代码块行号宽度
   *
   * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockSeparateWidth
   */
  setSeparateCodeBlockWidth(separateCodeBlockWidth: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockSeparateWidth(separateCodeBlockWidth)
    return this
  }

  /**
   * 设置单独代码块是否居底显示
   *
   * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockSeparateIsBottom
   */
  setSeparateCodeIsBottom(separateCodeIsBottom: boolean): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockSeparateIsBottom(separateCodeIsBottom)
    return this
  }

  /**
   * 设置H1、H2标题下分割线高度
   *
   * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineHeightForAllHeading
   */
  setHeadingBreakHeight(headingBreakHeight: number): MarkdownTheme {
    this.markdownThemeHeading.setUnderlineHeightForAllHeading(headingBreakHeight)
    return this
  }

  /**
   * 设置标题文本字体
   *
   * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontFamilyForAllHeading
   */
  setHeadingTypeface(headingTypeface: string): MarkdownTheme {
    this.markdownThemeHeading.setTextFontFamilyForAllHeading(headingTypeface)
    return this
  }

  /**
   * 设置标题模块上间距
   *
   * @param headingTopMargins 标题模块上间距 - 默认8.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setMarginForAllHeadingEachLevel
   */
  setHeadingTopMargins(headingTopMargins: number): MarkdownTheme {
    this.markdownThemeHeading.setMarginForAllHeadingEachLevel({top: headingTopMargins})
    return this
  }

  /**
   * 设置标题模块下间距
   *
   * @param headingBottomMargins 标题模块下间距 - 默认8.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setMarginForAllHeadingEachLevel
   */
  setHeadingBottomMargins(headingBottomMargins: number): MarkdownTheme {
    this.markdownThemeHeading.setMarginForAllHeadingEachLevel({bottom: headingBottomMargins})
    return this
  }

  /**
   * 设置标题文本大小数组
   *
   * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForEachHeading
   */
  setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<number>): MarkdownTheme {
    if (headingTextSizeMultipliers.length != 6) {
      return this
    }
    this.markdownThemeHeading.setTextFontSizeForEachHeading(headingTextSizeMultipliers)
    return this
  }

  /**
   * 设置一级标题文本大小
   *
   * @param headingTextSize1 一级标题文本大小 - 默认20.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize1(headingTextSize1: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(1, headingTextSize1)
    return this
  }

  /**
   * 设置二级标题文本大小
   *
   * @param headingTextSize2 二级标题文本大小 - 默认17.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize2(headingTextSize2: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(2, headingTextSize2)
    return this
  }

  /**
   * 设置三级标题文本大小
   *
   * @param headingTextSize3 三级标题文本大小 - 默认16.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize3(headingTextSize3: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(3, headingTextSize3)
    return this
  }

  /**
   * 设置四级标题文本大小
   *
   * @param headingTextSize4 四级标题文本大小 - 默认15.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize4(headingTextSize4: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(4, headingTextSize4)
    return this
  }

  /**
   * 设置五级标题文本大小
   *
   * @param headingTextSize5 五级标题文本大小 - 默认15.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize5(headingTextSize5: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(5, headingTextSize5)
    return this
  }

  /**
   * 设置六级标题文本大小
   *
   * @param headingTextSize6 六级标题文本大小 - 默认13.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   */
  setHeadingTextSize6(headingTextSize6: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontSizeForDesignateHeading(6, headingTextSize6)
    return this
  }

  /**
   * 设置标题文本颜色
   *
   * @param headingTextColor 标题文本颜色 - 默认0xFF191919
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForAllHeading
   */
  setHeadingTextColor(headingTextColor: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontColorForAllHeading(headingTextColor)
    return this
  }

  /**
   * 设置H1、H2标题下分割线颜色
   *
   * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0xFF191919
   * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForAllHeading
   */
  setHeadingBreakColor(headingBreakColor: number): MarkdownTheme {
    this.markdownThemeHeading.setUnderlineColorForAllHeading(headingBreakColor)
    return this
  }

  /**
   * 设置标题文本字间距
   *
   * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLetterSpacingForAllHeading
   */
  setHeadingTextWordSpace(headingTextWordSpace: number): MarkdownTheme {
    this.markdownThemeHeading.setTextLetterSpacingForAllHeading(headingTextWordSpace)
    return this
  }

  /**
   * 设置一级标题文本行高
   *
   * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight1(headingTextLineHeight1: number): MarkdownTheme {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(1, headingTextLineHeight1)
    return this
  }

  /**
   * 设置二级标题文本行高
   *
   * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight2(headingTextLineHeight2: number): MarkdownTheme {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(2, headingTextLineHeight2)
    return this
  }

  /**
   * 设置三级标题文本行高
   *
   * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight3(headingTextLineHeight3: number): MarkdownTheme {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(3, headingTextLineHeight3)
    return this
  }

  /**
   * 设置四级标题文本行高
   *
   * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight4(headingTextLineHeight4: number): MarkdownTheme {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(4, headingTextLineHeight4)
    return this
  }

  /**
   * 设置五级标题文本行高
   *
   * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight5(headingTextLineHeight5: number): MarkdownTheme {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(5, headingTextLineHeight5)
    return this
  }

  /**
   * 设置六级标题文本行高
   *
   * @param headingTextLineHeight6 六级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   */
  setHeadingTextLineHeight6(headingTextLineHeight6: number): MarkdownTheme {
    this.markdownThemeHeading.setTextLineHeightForDesignateHeading(6, headingTextLineHeight6)
    return this
  }

  /**
   * 设置一级标题文本颜色
   *
   * @param headingTextColor1 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor1(headingTextColor1: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(1, headingTextColor1)
    return this
  }

  /**
   * 设置H1标题下分割线颜色
   *
   * @param headingBreakColor1 H1标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForDesignateHeading
   */
  setHeadingBreakColor1(headingBreakColor1: number): MarkdownTheme {
    this.markdownThemeHeading.setUnderlineColorForDesignateHeading(1, headingBreakColor1)
    return this
  }

  /**
   * 设置二级标题文本颜色
   *
   * @param headingTextColor2 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor2(headingTextColor2: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(2, headingTextColor2)
    return this
  }

  /**
   * 设置H2标题下分割线颜色
   *
   * @param headingBreakColor2 H2标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForDesignateHeading
   */
  setHeadingBreakColor2(headingBreakColor2: number): MarkdownTheme {
    this.markdownThemeHeading.setUnderlineColorForDesignateHeading(2, headingBreakColor2)
    return this
  }

  /**
   * 设置三级标题文本颜色
   *
   * @param headingTextColor3 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor3(headingTextColor3: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(3, headingTextColor3)
    return this
  }

  /**
   * 设置四级标题文本颜色
   *
   * @param headingTextColor4 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor4(headingTextColor4: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(4, headingTextColor4)
    return this
  }

  /**
   * 设置五级标题文本颜色
   *
   * @param headingTextColor5 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor5(headingTextColor5: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(5, headingTextColor5)
    return this
  }

  /**
   * 设置六级标题文本颜色
   *
   * @param headingTextColor6 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   */
  setHeadingTextColor6(headingTextColor6: number): MarkdownTheme {
    this.markdownThemeHeading.setTextFontColorForDesignateHeading(6, headingTextColor6)
    return this
  }

  /**
   * 设置段落模块上间距
   *
   * @param paragraphTopMargins 段落模块上间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphMargin
   */
  setParagraphTopMargins(paragraphTopMargins: number): MarkdownTheme {
    this.markdownThemeParagraph.setParagraphMargin({top: paragraphTopMargins})
    return this
  }

  /**
   * 设置段落模块下间距
   *
   * @param paragraphBottomMargins 段落模块下间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphMargin
   */
  setParagraphBottomMargins(paragraphBottomMargins: number): MarkdownTheme {
    this.markdownThemeParagraph.setParagraphMargin({bottom: paragraphBottomMargins})
    return this
  }

  /**
   * 设置段落文本大小
   *
   * @param paragraphTextSize 段落文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontSize
   */
  setParagraphTextSize(paragraphTextSize: number): MarkdownTheme {
    this.markdownThemeParagraph.setParagraphTextFontSize(paragraphTextSize)
    return this
  }

  /**
   * 设置段落文本颜色
   *
   * @param paragraphTextColor 段落文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontColor
   */
  setParagraphTextColor(paragraphTextColor: number): MarkdownTheme {
    this.markdownThemeParagraph.setParagraphTextFontColor(paragraphTextColor)
    return this
  }

  /**
   * 设置段落文本字间距
   *
   * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextLetterSpacing
   */
  setParagraphTextWordSpace(paragraphTextWordSpace: number): MarkdownTheme {
    this.markdownThemeParagraph.setParagraphTextLetterSpacing(paragraphTextWordSpace)
    return this
  }

  /**
   * 设置段落文本行高
   *
   * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextLineHeight
   */
  setParagraphTextLineHeight(paragraphTextLineHeight: number): MarkdownTheme {
    this.markdownThemeParagraph.setParagraphTextLineHeight(paragraphTextLineHeight)
    return this
  }

  /**
   * 设置段落文本字体
   *
   * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontFamily
   */
  setParagraphTypeface(paragraphTypeface: string): MarkdownTheme {
    this.markdownThemeParagraph.setParagraphTextFontFamily(paragraphTypeface)
    return this
  }

  /**
   * 设置分割线颜色
   *
   * @param thematicBreakColor 分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerColor
   */
  setThematicBreakColor(thematicBreakColor: number): MarkdownTheme {
    this.markdownThemeDivider.setDividerColor(thematicBreakColor)
    return this
  }

  /**
   * 设置分割线高度
   *
   * @param thematicBreakHeight 分割线高度 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerStrokeWidth
   */
  setThematicBreakHeight(thematicBreakHeight: number): MarkdownTheme {
    this.markdownThemeDivider.setDividerStrokeWidth(thematicBreakHeight)
    return this
  }

  /**
   * 设置分割线上部外边距
   *
   * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerMargin
   */
  setThematicBreakTopMargin(thematicBreakTopMargin: number): MarkdownTheme {
    this.markdownThemeDivider.setDividerMargin({top: thematicBreakTopMargin})
    return this
  }

  /**
   * 设置分割线下部外边距
   *
   * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerMargin
   */
  setThematicBreakBottomMargin(thematicBreakBottomMargin: number): MarkdownTheme {
    this.markdownThemeDivider.setDividerMargin({bottom: thematicBreakBottomMargin})
    return this
  }

  /**
   * 设置软换行是否换行
   *
   * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsLineBreak
   */
  setIsLineBreak(isLineBreak: boolean): MarkdownTheme {
    this.markdownThemeGlobal.setIsLineBreak(isLineBreak)
    return this
  }

  /**
   * 设置音频阴影颜色值
   *
   * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioShadowColor
   */
  setAudioShadowColor(audioShadowColor: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioShadowColor(audioShadowColor)
    return this
  }

  /**
   * 设置音频边框颜色
   *
   * @param audioBorderColor 音频边框颜色 - 默认0x33000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderColor
   */
  setAudioBorderColor(audioBorderColor: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioBorderColor(audioBorderColor)
    return this
  }

  /**
   * 设置音频边框粗细
   *
   * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderWidth
   */
  setAudioBorderWidth(audioBorderWidth: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioBorderWidth(audioBorderWidth)
    return this
  }

  /**
   * 设置音频边框圆角
   *
   * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderRadius
   */
  setAudioBorderRadius(audioBorderRadius: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioBorderRadius(audioBorderRadius)
    return this
  }

  /**
   * 设置音频按钮背景颜色
   *
   * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonBackgroundColor
   */
  setAudioButtonBackgroundColor(audioButtonBackgroundColor: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioButtonBackgroundColor(audioButtonBackgroundColor)
    return this
  }

  /**
   * 设置音频按钮文字颜色
   *
   * @param audioButtonTextColor 音频按钮文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonTextFontColor
   */
  setAudioButtonTextColor(audioButtonTextColor: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioButtonTextFontColor(audioButtonTextColor)
    return this
  }

  /**
   * 设置音频按钮文字大小
   *
   * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonTextFontSize
   */
  setAudioButtonTextSize(audioButtonTextSize: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioButtonTextFontSize(audioButtonTextSize)
    return this
  }

  /**
   * 设置音频按钮文字内容
   *
   * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonText
   */
  setAudioButtonText(audioButtonText: string): MarkdownTheme {
    this.markdownThemeAudio.setAudioButtonText(audioButtonText)
    return this
  }

  /**
   * 设置音频按钮圆角
   *
   * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonRadius
   */
  setAudioButtonBorderRadius(audioButtonBorderRadius: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioButtonRadius(audioButtonBorderRadius)
    return this
  }

  /**
   * 设置音频标题文字大小
   *
   * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextFontSize
   */
  setAudioTitleTextSize(audioTitleTextSize: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioTitleTextFontSize(audioTitleTextSize)
    return this
  }

  /**
   * 设置音频标题文字颜色
   *
   * @param audioTitleTextColor音频标题文字颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextFontColor
   */
  setAudioTitleTextColor(audioTitleTextColor: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioTitleTextFontColor(audioTitleTextColor)
    return this
  }

  /**
   * 设置音频标题文字行高
   *
   * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextLineHeight
   */
  setAudioTitleTextLineHeight(audioTitleTextLineHeight: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioTitleTextLineHeight(audioTitleTextLineHeight)
    return this
  }

  /**
   * 设置音频类型文字大小
   *
   * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextFontSize
   */
  setAudioTypeTextSize(audioTypeTextSize: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioTypeTextFontSize(audioTypeTextSize)
    return this
  }

  /**
   * 设置音频类型文字颜色
   *
   * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextFontColor
   */
  setAudioTypeTextColor(audioTypeTextColor: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioTypeTextFontColor(audioTypeTextColor)
    return this
  }

  /**
   * 设置音频类型文字行高
   *
   * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextLineHeight
   */
  setAudioTypeTextLineHeight(audioTypeTextLineHeight: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioTypeTextLineHeight(audioTypeTextLineHeight)
    return this
  }

  /**
   * 设置音频上边距
   *
   * @param audioMarginTop 音频上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioMargin
   */
  setAudioMarginTop(audioMarginTop: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioMargin({top: audioMarginTop})
    return this
  }

  /**
   * 设置音频下边距
   *
   * @param audioMarginBottom 音频下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioMargin
   */
  setAudioMarginBottom(audioMarginBottom: number): MarkdownTheme {
    this.markdownThemeAudio.setAudioMargin({bottom: audioMarginBottom})
    return this
  }

  /**
   * 设置视频圆角
   *
   * @param videoBorderRadius 视频圆角 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoBorderRadius
   */
  setVideoBorderRadius(videoBorderRadius: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoBorderRadius(videoBorderRadius)
    return this
  }

  /**
   * 设置视频时间文本颜色
   *
   * @param videoTimeTextColor 视频时间文本颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextFontColor
   */
  setVideoTimeTextColor(videoTimeTextColor: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoTimeTextFontColor(videoTimeTextColor)
    return this
  }

  /**
   * 设置视频时间文本大小
   *
   * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextFontSize
   */
  setVideoTimeTextSize(videoTimeTextSize: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoTimeTextFontSize(videoTimeTextSize)
    return this
  }

  /**
   * 设置视频时间文本居右边距
   *
   * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextMarginRight
   */
  setVideoTimeTextMarginRight(videoTimeTextMarginRight: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoTimeTextMarginRight(videoTimeTextMarginRight)
    return this
  }

  /**
   * 设置视频时间文本居底边距
   *
   * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextMarginBottom
   */
  setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoTimeTextMarginBottom(videoTimeTextMarginBottom)
    return this
  }

  /**
   * 设置视频上边距
   *
   * @param videoMarginTop 视频上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoMargin
   */
  setVideoMarginTop(videoMarginTop: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoMargin({top: videoMarginTop})
    return this
  }

  /**
   * 设置视频下边距
   *
   * @param videoMarginBottom 视频下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoMargin
   */
  setVideoMarginBottom(videoMarginBottom: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoMargin({bottom: videoMarginBottom})
    return this
  }

  /**
   * 设置视频发布/下载按钮布局是否显示
   *
   * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默认false不显示
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoBottomLayoutVisible
   */
  setIsVideoBottomLayout(isVideoBottomLayout: boolean): MarkdownTheme {
    this.markdownThemeVideo.setVideoBottomLayoutVisible(isVideoBottomLayout)
    return this
  }

  /**
   * 设置视频发布按钮图片宽度和高度
   *
   * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonIconWidth
   *             MarkdownThemeVideoTheme#setVideoReleaseButtonIconHeight
   */
  setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoReleaseButtonIconWidth(videoReleaseImageWidthHeight)
    this.markdownThemeVideo.setVideoReleaseButtonIconHeight(videoReleaseImageWidthHeight)
    return this
  }

  /**
   * 设置视频发布按钮宽度
   *
   * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonWidth
   */
  setVideoReleaseWidth(videoReleaseWidth: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoReleaseButtonWidth(videoReleaseWidth)
    return this
  }

  /**
   * 设置视频发布按钮高度
   *
   * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonHeight
   */
  setVideoReleaseHeight(videoReleaseHeight: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoReleaseButtonHeight(videoReleaseHeight)
    return this
  }

  /**
   * 设置视频发布按钮圆角
   *
   * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonRadius
   */
  setVideoReleaseRadius(videoReleaseRadius: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoReleaseButtonRadius(videoReleaseRadius)
    return this
  }

  /**
   * 设置视频发布按钮文本内容
   *
   * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonText
   */
  setVideoReleaseText(videoReleaseText: string): MarkdownTheme {
    this.markdownThemeVideo.setVideoReleaseButtonText(videoReleaseText)
    return this
  }

  /**
   * 设置视频发布按钮文本大小
   *
   * @param videoReleaseTextSize 视频发布按钮文本大小 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonTextFontSize
   */
  setVideoReleaseTextSize(videoReleaseTextSize: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoReleaseButtonTextFontSize(videoReleaseTextSize)
    return this
  }

  /**
   * 设置视频发布按钮文本颜色
   *
   * @param videoReleaseTextColor 视频发布按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonTextFontColor
   */
  setVideoReleaseTextColor(videoReleaseTextColor: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoReleaseButtonTextFontColor(videoReleaseTextColor)
    return this
  }

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonBackgroundColor
   */
  setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoReleaseButtonBackgroundColor(videoReleaseBackgroundColor)
    return this
  }

  /**
   * 设置视频下载按钮图片宽度和高度
   *
   * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonIconWidth
   *             MarkdownThemeVideoTheme#setVideoDownloadButtonIconHeight
   */
  setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoDownloadButtonIconWidth(videoDownloadImageWidthHeight)
    this.markdownThemeVideo.setVideoDownloadButtonIconHeight(videoDownloadImageWidthHeight)
    return this
  }

  /**
   * 设置视频下载按钮宽度
   *
   * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonWidth
   */
  setVideoDownloadWidth(videoDownloadWidth: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoDownloadButtonWidth(videoDownloadWidth)
    return this
  }

  /**
   * 设置视频下载按钮高度
   *
   * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonHeight
   */
  setVideoDownloadHeight(videoDownloadHeight: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoDownloadButtonHeight(videoDownloadHeight)
    return this
  }

  /**
   * 设置视频下载按钮圆角
   *
   * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonRadius
   */
  setVideoDownloadRadius(videoDownloadRadius: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoDownloadButtonRadius(videoDownloadRadius)
    return this
  }

  /**
   * 设置视频下载按钮文本内容
   *
   * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonText
   */
  setVideoDownloadText(videoDownloadText: string): MarkdownTheme {
    this.markdownThemeVideo.setVideoDownloadButtonText(videoDownloadText)
    return this
  }

  /**
   * 设置视频下载按钮文本大小
   *
   * @param videoDownloadTextSize 视频下载按钮文本大小 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonTextFontSize
   */
  setVideoDownloadTextSize(videoDownloadTextSize: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoDownloadButtonTextFontSize(videoDownloadTextSize)
    return this
  }

  /**
   * 设置视频下载按钮文本颜色
   *
   * @param videoDownloadTextColor 视频下载按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonTextFontColor
   */
  setVideoDownloadTextColor(videoDownloadTextColor: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoDownloadButtonTextFontColor(videoDownloadTextColor)
    return this
  }

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonBackgroundColor
   */
  setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: number): MarkdownTheme {
    this.markdownThemeVideo.setVideoDownloadButtonBackgroundColor(videoDownloadBackgroundColor)
    return this
  }

  /**
   * 设置图片缩放类型
   *
   * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageFitType
   */
  setImageFitType(imageFitType: ImageFitType): MarkdownTheme {
    this.markdownThemeImage.setImageFitType(imageFitType)
    return this
  }

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaximumWidth
   */
  setImageMaximumWidth(imageMaximumWidth: number): MarkdownTheme {
    this.markdownThemeImage.setImageMaximumWidth(imageMaximumWidth)
    return this
  }

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageFixedRatioWidth
   */
  setImageFixedRatioWidth(imageFixedRatioWidth: number): MarkdownTheme {
    this.markdownThemeImage.setImageFixedRatioWidth(imageFixedRatioWidth)
    return this
  }

  /**
   * 设置图片最大高度
   *
   * @param imageMaxHeight 图片最大高度 - 默认None
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaxHeight
   */
  setImageMaxHeight(imageMaxHeight: number): MarkdownTheme {
    this.markdownThemeImage.setImageMaxHeight(imageMaxHeight)
    return this
  }

  /**
   * 设置图片最大宽度
   *
   * @param imageMaxWidth 图片最大宽度 - 默认None
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaxWidth
   */
  setImageMaxWidth(imageMaxWidth: number): MarkdownTheme {
    this.markdownThemeImage.setImageMaxWidth(imageMaxWidth)
    return this
  }

  /**
   * 设置图片圆角大小
   *
   * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderRadius
   */
  setImageBorderRadius(imageBorderRadius: number): MarkdownTheme {
    this.markdownThemeImage.setImageBorderRadius(imageBorderRadius)
    return this
  }

  /**
   * 设置图片边框宽度
   *
   * @param imageBorderWidth 图片边框宽度 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderWidth
   */
  setImageBorderWidth(imageBorderWidth: number): MarkdownTheme {
    this.markdownThemeImage.setImageBorderWidth(imageBorderWidth)
    return this
  }

  /**
   * 设置图片边框颜色
   *
   * @param imageBorderColor 图片边框颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderColor
   */
  setImageBorderColor(imageBorderColor: number): MarkdownTheme {
    this.markdownThemeImage.setImageBorderColor(imageBorderColor)
    return this
  }

  /**
   * 设置网络图片是否压缩
   *
   * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageAutoResize
   */
  setIsAutoResize(isAutoResize: boolean): MarkdownTheme {
    this.markdownThemeImage.setImageAutoResize(isAutoResize)
    return this
  }

  /**
   * 设置图片上边距
   *
   * @param imageMarginTop 图片上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMargin
   */
  setImageMarginTop(imageMarginTop: number): MarkdownTheme {
    this.markdownThemeImage.setImageMargin({top: imageMarginTop})
    return this
  }

  /**
   * 设置图片下边距
   *
   * @param imageMarginBottom 图片下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMargin
   */
  setImageMarginBottom(imageMarginBottom: number): MarkdownTheme {
    this.markdownThemeImage.setImageMargin({bottom: imageMarginBottom})
    return this
  }

  /**
   * 设置图片是否有下载按钮
   *
   * @param isImageDownload 图片是否有下载按钮 - 默认false
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonVisible
   */
  setIsImageDownload(isImageDownload: boolean): MarkdownTheme {
    this.markdownThemeImage.setImageDownloadButtonVisible(isImageDownload)
    return this
  }

  /**
   * 设置是否图文混排
   *
   * @param isImageMixedLayout 是否图文混排 - 默认true
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setIsImageMixedLayout
   */
  setIsImageMixedLayout(isImageMixedLayout: boolean): MarkdownTheme {
    this.markdownThemeImage.setIsImageMixedLayout(isImageMixedLayout)
    return this
  }

  /**
   * 设置图片下载按钮图片宽度和高度
   *
   * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonIconWidth
   *             MarkdownThemeImageTheme#setImageDownloadButtonIconHeight
   */
  setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: number): MarkdownTheme {
    this.markdownThemeImage.setImageDownloadButtonIconWidth(imageDownloadImageWidthHeight)
    this.markdownThemeImage.setImageDownloadButtonIconHeight(imageDownloadImageWidthHeight)
    return this
  }

  /**
   * 设置图片下载按钮宽度
   *
   * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonWidth
   */
  setImageDownloadWidth(imageDownloadWidth: number): MarkdownTheme {
    this.markdownThemeImage.setImageDownloadButtonWidth(imageDownloadWidth)
    return this
  }

  /**
   * 设置图片下载按钮高度
   *
   * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonHeight
   */
  setImageDownloadHeight(imageDownloadHeight: number): MarkdownTheme {
    this.markdownThemeImage.setImageDownloadButtonHeight(imageDownloadHeight)
    return this
  }

  /**
   * 设置图片下载按钮圆角
   *
   * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonRadius
   */
  setImageDownloadRadius(imageDownloadRadius: number): MarkdownTheme {
    this.markdownThemeImage.setImageDownloadButtonRadius(imageDownloadRadius)
    return this
  }

  /**
   * 设置图片下载按钮文本内容
   *
   * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonText
   */
  setImageDownloadText(imageDownloadText: string): MarkdownTheme {
    this.markdownThemeImage.setImageDownloadButtonText(imageDownloadText)
    return this
  }

  /**
   * 设置图片下载按钮文本大小
   *
   * @param imageDownloadTextSize 图片下载按钮文本大小 - 默认16.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonTextFontSize
   */
  setImageDownloadTextSize(imageDownloadTextSize: number): MarkdownTheme {
    this.markdownThemeImage.setImageDownloadButtonTextFontSize(imageDownloadTextSize)
    return this
  }

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param imageDownloadTextColor 图片下载按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonTextFontColor
   */
  setImageDownloadTextColor(imageDownloadTextColor: number): MarkdownTheme {
    this.markdownThemeImage.setImageDownloadButtonTextFontColor(imageDownloadTextColor)
    return this
  }

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonBackgroundColor
   */
  setImageDownloadBackgroundColor(imageDownloadBackgroundColor: number): MarkdownTheme {
    this.markdownThemeImage.setImageDownloadButtonBackgroundColor(imageDownloadBackgroundColor)
    return this
  }

  /**
   * 设置表格内容内边距
   *
   * @param tableCellPadding 表格内容内边距 - 默认4.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableCellPadding
   */
  setTableCellPadding(tableCellPadding: number): MarkdownTheme {
    this.markdownThemeTable.setTableCellPadding(tableCellPadding)
    return this
  }

  /**
   * 设置表格边框颜色
   *
   * @param tableBorderColor 表格边框颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableBorderColor
   */
  setTableBorderColor(tableBorderColor: number): MarkdownTheme {
    this.markdownThemeTable.setTableBorderColor(tableBorderColor)
    return this
  }

  /**
   * 设置表格边框宽度
   *
   * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableBorderWidth
   */
  setTableBorderWidth(tableBorderWidth: number): MarkdownTheme {
    this.markdownThemeTable.setTableBorderWidth(tableBorderWidth)
    return this
  }

  /**
   * 设置表格奇数行背景色
   *
   * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentOddRowBackgroundColor
   */
  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): MarkdownTheme {
    this.markdownThemeTable.setTableContentOddRowBackgroundColor(tableOddRowBackgroundColor)
    return this
  }

  /**
   * 设置表格偶数行背景色
   *
   * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0xFFE0E0E0
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentEvenRowBackgroundColor
   */
  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): MarkdownTheme {
    this.markdownThemeTable.setTableContentEvenRowBackgroundColor(tableEvenRowBackgroundColor)
    return this
  }

  /**
   * 设置表格标题背景色
   *
   * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleBackgroundColor
   */
  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): MarkdownTheme {
    this.markdownThemeTable.setTableTitleBackgroundColor(tableHeaderRowBackgroundColor)
    return this
  }

  /**
   * 设置表格标题文本颜色
   *
   * @param tableTitleTextColor 表格标题文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextFontColor
   */
  setTableTitleTextColor(tableTitleTextColor: number): MarkdownTheme {
    this.markdownThemeTable.setTableTitleTextFontColor(tableTitleTextColor)
    return this
  }

  /**
   * 设置表格文本行高
   *
   * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextLineHeight
   *             MarkdownThemeTableTheme#setTableTitleTextLineHeight
   */
  setTableTextLineHeight(tableTextLineHeight: number): MarkdownTheme {
    this.markdownThemeTable.setTableContentTextLineHeight(tableTextLineHeight)
    this.markdownThemeTable.setTableTitleTextLineHeight(tableTextLineHeight)
    return this
  }

  /**
   * 设置表格标题文本大小
   *
   * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextFontSize
   */
  setTableTitleTextSize(tableTitleTextSize: number): MarkdownTheme {
    this.markdownThemeTable.setTableTitleTextFontSize(tableTitleTextSize)
    return this
  }

  /**
   * 设置表格标题文本行高
   *
   * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextLineHeight
   */
  setTableTitleLineHeight(tableTitleLineHeight: number): MarkdownTheme {
    this.markdownThemeTable.setTableTitleTextLineHeight(tableTitleLineHeight)
    return this
  }

  /**
   * 设置表格内容文本颜色
   *
   * @param tableContentTextColor 表格内容文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextFontColor
   */
  setTableContentTextColor(tableContentTextColor: number): MarkdownTheme {
    this.markdownThemeTable.setTableContentTextFontColor(tableContentTextColor)
    return this
  }

  /**
   * 设置表格内容文本大小
   *
   * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextFontSize
   */
  setTableContentTextSize(tableContentTextSize: number): MarkdownTheme {
    this.markdownThemeTable.setTableContentTextFontSize(tableContentTextSize)
    return this
  }

  /**
   * 设置表格内容文本行高
   *
   * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextLineHeight
   */
  setTableContentTextLineHeight(tableTextLineHeight: number): MarkdownTheme {
    this.markdownThemeTable.setTableContentTextLineHeight(tableTextLineHeight)
    return this
  }

  /**
   * 设置表格圆角
   *
   * @param tableRadius 表格圆角 - 默认5.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableRadius
   */
  setTableRadius(tableRadius: number): MarkdownTheme {
    this.markdownThemeTable.setTableRadius(tableRadius)
    return this
  }

  /**
   * 设置表格最小宽度
   *
   * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableMinCellWidth
   */
  setTableMinTextWidth(tableMinTextWidth: number): MarkdownTheme {
    this.markdownThemeTable.setTableMinCellWidth(tableMinTextWidth)
    return this
  }

  /**
   * 设置表格最大宽度
   *
   * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableMaxCellWidth
   */
  setTableMaxTextWidth(tableMaxTextWidth: number): MarkdownTheme {
    this.markdownThemeTable.setTableMaxCellWidth(tableMaxTextWidth)
    return this
  }

  /**
   * 设置表格第一列是否加粗
   *
   * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableFirstColumnIsBold
   */
  setTableFirstColumnBold(tableFirstColumnBold: boolean): MarkdownTheme {
    this.markdownThemeTable.setTableFirstColumnIsBold(tableFirstColumnBold)
    return this
  }

  /**
   * 设置表格是否显示滚动条
   *
   * @param tableScrollBarShow 表格是否显示滚动条 - true：显示(auto状态)；false：不显示。默认false
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableScrollBarState
   */
  setTableScrollBarShow(tableScrollBarShow: boolean): MarkdownTheme {
    if (tableScrollBarShow) {
      this.markdownThemeTable.setTableScrollBarState(BarState.Auto)
    } else {
      this.markdownThemeTable.setTableScrollBarState(BarState.Off)
    }
    return this
  }

  /**
   * 设置表格滚动条颜色
   *
   * @param tableScrollBarColor 表格滚动条颜色
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableScrollBarColor
   */
  setTableScrollBarColor(tableScrollBarColor: number): MarkdownTheme {
    this.markdownThemeTable.setTableScrollBarColor(tableScrollBarColor)
    return this
  }

  /**
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsDark
   */
  setIsDark(isDark: boolean): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockIsDark(isDark)
    return this
  }

  /**
   * 设置删除线颜色
   *
   * @param strikethroughColor 删除线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead StrikethroughTheme#setStrikethroughTextDecorationColor
   */
  setStrikethroughColor(strikethroughColor: number): MarkdownTheme {
    this.markdownThemeStrikethrough.setStrikethroughTextDecorationColor(strikethroughColor)
    return this
  }

  /**
   * 设置删除线样式
   *
   * @param strikethroughStyle 删除线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @deprecated since 1.4.0
   * @useinstead StrikethroughTheme#setStrikethroughTextDecorationStyle
   */
  setStrikethroughStyle(strikethroughStyle: TextDecorationStyle): MarkdownTheme {
    this.markdownThemeStrikethrough.setStrikethroughTextDecorationStyle(strikethroughStyle)
    return this
  }

  /**
   * 设置定义列表术语和定义行之间间距
   *
   * @param descListTermAndDefMargins 定义列表定义行缩进 默认8.0
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListTermToDescriptionSpacing
   */
  setDescListTermAndDefMargins(descListTermAndDefMargins: number): MarkdownTheme {
    this.markdownThemeDefinitionList.setDefinitionListTermToDescriptionSpacing(descListTermAndDefMargins)
    return this
  }

  /**
   * 设置定义列表定义行缩进
   *
   * @param descListDefIndentation 定义列表定义行缩进 默认8.0
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListDescriptionIndent
   */
  setDescListDefIndentation(descListDefIndentation: number): MarkdownTheme {
    this.markdownThemeDefinitionList.setDefinitionListDescriptionIndent(descListDefIndentation)
    return this
  }

  /**
   * 设置定义列表定义行间距
   *
   * @param descListDefMargins 定义列表定义行间距 默认8.0
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListDescriptionItemSpacing
   */
  setDescListDefMargins(descListDefMargins: number): MarkdownTheme {
    this.markdownThemeDefinitionList.setDefinitionListDescriptionItemSpacing(descListDefMargins)
    return this
  }

  /**
   * 设置下标字体颜色
   *
   * @param subTextColor 下标字体颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextFontColor
   */
  setSubTextColor(subTextColor: number): MarkdownTheme {
    this.markdownThemeSub.setSubTextFontColor(subTextColor)
    return this
  }

  /**
   * 设置下标字体大小
   *
   * @param subTextSize 下标字体大小 默认8.0
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextFontSize
   */
  setSubTextSize(subTextSize: number): MarkdownTheme {
    this.markdownThemeSub.setSubTextFontSize(subTextSize)
    return this
  }

  /**
   * 设置下标偏移距离
   *
   * @param subOffsetDist 下标偏移距离 默认0.0
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextBaselineOffset
   */
  setSubOffsetDist(subOffsetDist: number): MarkdownTheme {
    this.markdownThemeSub.setSubTextBaselineOffset(subOffsetDist)
    return this
  }

  /**
   * 设置上标字体颜色
   *
   * @param supTextColor 上标字体颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextFontColor
   */
  setSupTextColor(supTextColor: number): MarkdownTheme {
    this.markdownThemeSup.setSupTextFontColor(supTextColor)
    return this
  }

  /**
   * 设置上标字体大小
   *
   * @param supTextSize 上标字体大小 默认8.0
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextFontSize
   */
  setSupTextSize(supTextSize: number): MarkdownTheme {
    this.markdownThemeSup.setSupTextFontSize(supTextSize)
    return this
  }

  /**
   * 设置上标偏移距离
   *
   * @param supOffsetDist 上标偏移距离 默认6.0
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextBaselineOffset
   */
  setSupOffsetDist(supOffsetDist: number): MarkdownTheme {
    this.markdownThemeSup.setSupTextBaselineOffset(supOffsetDist)
    return this
  }

  /**
   * 设置下划线颜色
   *
   * @param underlineColor 下划线颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HtmlUnderlineTheme#setHtmlUnderlineTextDecorationColor
   */
  setUnderlineColor(underlineColor: number): MarkdownTheme {
    this.markdownThemeHtmlUnderline.setHtmlUnderlineTextDecorationColor(underlineColor)
    return this
  }

  /**
   * 设置下划线样式
   *
   * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @deprecated since 1.4.0
   * @useinstead HtmlUnderlineTheme#setHtmlUnderlineTextDecorationStyle
   */
  setUnderlineStyle(underlineStyle: TextDecorationStyle): MarkdownTheme {
    this.markdownThemeHtmlUnderline.setHtmlUnderlineTextDecorationStyle(underlineStyle)
    return this
  }

  /**
   * 设置markdown是否支持滚动手势
   *
   * @param openGestureSwipe true-支持滚动手势，false-不支持滚动手势，默认false
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setOpenGestureSwipe
   */
  setOpenGestureSwipe(openGestureSwipe: boolean): MarkdownTheme {
    this.markdownThemeGlobal.setOpenGestureSwipe(openGestureSwipe)
    return this
  }

  /**
   * 设置codeformat是否用制表符
   *
   * @param useTab true-使用，false-不使用，默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockUseTab
   */
  setUseTab(useTab: boolean): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockUseTab(useTab)
    return this
  }

  /**
   * 设置codeformat空格缩进数量
   *
   * @param indentWidth 空格缩进数量，默认4空格
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIndentWidth
   */
  setIndentWidth(indentWidth: number): MarkdownTheme {
    this.markdownThemeCodeBlock.setCodeBlockIndentWidth(indentWidth)
    return this
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
  getGlobalTheme(): GlobalTheme {
    return this.markdownThemeGlobal
  }

  /**
   * 获取音频样式
   *
   * @returns 音频样式对象
   */
  getAudioTheme(): AudioTheme {
    return this.markdownThemeAudio
  }

  /**
   * 获取Banner样式
   *
   * @returns Banner样式对象
   */
  getBannerTheme(): BannerTheme {
    return this.markdownThemeBanner
  }

  /**
   * 获取块引用样式
   *
   * @returns 块引用样式对象
   */
  getBlockQuoteTheme(): BlockQuoteTheme {
    return this.markdownThemeBlockQuote
  }

  /**
   * 获取加粗文本样式
   *
   * @returns 加粗文本样式对象
   */
  getBoldTheme(): BoldTheme {
    return this.markdownThemeBold
  }

  /**
   * 获取代码块样式
   *
   * @returns 代码块样式对象
   */
  getCodeBlockTheme(): CodeBlockTheme {
    return this.markdownThemeCodeBlock
  }

  /**
   * 获取定义列表样式
   *
   * @returns 定义列表样式对象
   */
  getDefinitionListTheme(): DefinitionListTheme {
    return this.markdownThemeDefinitionList
  }

  /**
   * 获取分割线样式
   *
   * @returns 分割线样式对象
   */
  getDividerTheme(): DividerTheme {
    return this.markdownThemeDivider
  }

  /**
   * 获取脚注定义样式
   *
   * @returns 脚注定义样式对象
   */
  getFootnoteDefTheme(): FootnoteDefTheme {
    return this.markdownThemeFootnoteDef
  }

  /**
   * 获取脚注引用样式
   *
   * @returns 脚注引用样式对象
   */
  getFootnoteRefTheme(): FootnoteRefTheme {
    return this.markdownThemeFootnoteRef
  }

  /**
   * 获取标题样式
   *
   * @returns 标题样式对象
   */
  getHeadingTheme(): HeadingTheme {
    return this.markdownThemeHeading
  }

  /**
   * 获取HTML下划线文本样式
   *
   * @returns HTML下划线文本样式对象
   */
  getHtmlUnderlineTheme(): HtmlUnderlineTheme {
    return this.markdownThemeHtmlUnderline
  }

  /**
   * 获取图片样式
   *
   * @returns 图片样式对象
   */
  getImageTheme(): ImageTheme {
    return this.markdownThemeImage
  }

  /**
   * 获取内联代码样式
   *
   * @returns 内联代码样式对象
   */
  getInlineCodeTheme(): InlineCodeTheme {
    return this.markdownThemeInlineCode
  }

  /**
   * 获取斜体文本样式
   *
   * @returns 斜体文本样式对象
   */
  getItalicTheme(): ItalicTheme {
    return this.markdownThemeItalic
  }

  /**
   * 获取链接文本样式
   *
   * @returns 链接文本样式对象
   */
  getLinkTheme(): LinkTheme {
    return this.markdownThemeLink
  }

  /**
   * 获取有序列表样式
   *
   * @returns 有序列表样式对象
   */
  getOrderedListTheme(): OrderedListTheme {
    return this.markdownThemeOrderedList
  }

  /**
   * 获取段落样式
   *
   * @returns 段落样式对象
   */
  getParagraphTheme(): ParagraphTheme {
    return this.markdownThemeParagraph
  }

  /**
   * 获取删除线文本样式
   *
   * @returns 删除线文本样式对象
   */
  getStrikethroughTheme(): StrikethroughTheme {
    return this.markdownThemeStrikethrough
  }

  /**
   * 获取下标文本样式
   *
   * @returns 下标文本样式对象
   */
  getSubTheme(): SubTheme {
    return this.markdownThemeSub
  }

  /**
   * 获取上标文本样式
   *
   * @returns 上标文本样式对象
   */
  getSupTheme(): SupTheme {
    return this.markdownThemeSup
  }

  /**
   * 获取表格样式
   *
   * @returns 表格样式对象
   */
  getTableTheme(): TableTheme {
    return this.markdownThemeTable
  }

  /**
   * 获取无序/任务列表样式
   *
   * @returns 无序/任务列表样式对象
   */
  getBulletListTheme(): BulletListTheme {
    return this.markdownThemeBulletList
  }

  /**
   * 获取视频样式
   *
   * @returns 视频样式对象
   */
  getVideoTheme(): VideoTheme {
    return this.markdownThemeVideo
  }

  /**
   * 获取高亮样式
   *
   * @returns 高亮样式对象
   */
  getHighlightTheme(): HighlightTheme {
    return this.markdownHighlightTheme
  }
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

/**
 * 通用外边距配置
 */
export interface MarkdownMarginOptions {
  top?: number
  right?: number
  bottom?: number
  left?: number
}

/**
 * 通用内边距配置
 */
export interface MarkdownPaddingOptions {
  top?: number
  right?: number
  bottom?: number
  left?: number
}

/**
 * 通用圆角配置
 */
export interface MarkdownRadiusOptions {
  topLeft?: number
  topRight?: number
  bottomLeft?: number
  bottomRight?: number
}