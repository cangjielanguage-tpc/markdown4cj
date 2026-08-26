import { AudioTheme } from "./AudioTheme"
import {
  COLOR_BLACK,
  COLOR_WHITE,
  COLOR_RED,
  COLOR_TRANSPARENT,
  COLOR_FF191919,
  COLOR_FFEAEAEA,
  COLOR_E6000000,
  COLOR_FFF5F5F5,
  COLOR_FFE0E0E0,
  COLOR_33000000,
  COLOR_1A000000,
  COLOR_80000000,
  COLOR_FF808080,
  COLOR_60000000,
  COLOR_40000000,
  COLOR_FF404040,
  COLOR_FF2D2D2D,
  COLOR_FF1E1E1E,
  COLOR_FF252526,
  COLOR_FF4A90E2,
  COLOR_FFA0A0A0,
  COLOR_FF191919_SCB,
  COLOR_FFE0E0E0_SCB,
  COLOR_TRANSPARENT_SCB
} from "../base/Constants"
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
import { LatexMathTheme } from "./LatexMathTheme"
import { LinkTheme } from "./LinkTheme"
import { OrderedListTheme } from "./OrderedListTheme"
import { ParagraphTheme } from "./ParagraphTheme"
import { StrikethroughTheme } from "./StrikethroughTheme"
import { SubTheme } from "./SubTheme"
import { SupTheme } from "./SupTheme"
import { TableTheme } from "./TableTheme"
import { VideoTheme } from "./VideoTheme"
import { LatexMathColorFormat } from "@cangjie-tpc/formula_hybrid"

/**
 * Markdown样式配置
 */
@Observed
export class MarkdownTheme {
  globalTheme: GlobalTheme = new GlobalTheme() // 全局样式
  audioTheme: AudioTheme = new AudioTheme() // 音频样式
  bannerTheme: BannerTheme = new BannerTheme() // Banner样式
  blockQuoteTheme: BlockQuoteTheme = new BlockQuoteTheme() // 块引用样式
  boldTheme: BoldTheme = new BoldTheme() // 加粗文本样式
  codeBlockTheme: CodeBlockTheme = new CodeBlockTheme() // 代码块样式
  definitionListTheme: DefinitionListTheme = new DefinitionListTheme() // 定义列表样式
  dividerTheme: DividerTheme = new DividerTheme() // 分割线样式
  footnoteDefTheme: FootnoteDefTheme = new FootnoteDefTheme() // 脚注定义样式
  footnoteRefTheme: FootnoteRefTheme = new FootnoteRefTheme() // 脚注引用样式
  headingTheme: HeadingTheme = new HeadingTheme() // 标题样式
  htmlUnderlineTheme: HtmlUnderlineTheme = new HtmlUnderlineTheme() // HTML下划线文本样式
  imageTheme: ImageTheme = new ImageTheme() // 图片样式
  inlineCodeTheme: InlineCodeTheme = new InlineCodeTheme() // 内联代码样式
  italicTheme: ItalicTheme = new ItalicTheme() // 斜体文本样式
  latexMathTheme: LatexMathTheme = new LatexMathTheme() // 数学公式样式
  linkTheme: LinkTheme = new LinkTheme() // 链接文本样式
  orderedListTheme: OrderedListTheme = new OrderedListTheme() // 有序列表样式
  paragraphTheme: ParagraphTheme = new ParagraphTheme() // 段落样式
  strikethroughTheme: StrikethroughTheme = new StrikethroughTheme() // 删除线文本样式
  subTheme: SubTheme = new SubTheme() // 下标文本样式
  supTheme: SupTheme = new SupTheme() // 上标文本样式
  tableTheme: TableTheme = new TableTheme() // 表格样式
  bulletListTheme: BulletListTheme = new BulletListTheme() // 无序/任务列表样式
  videoTheme: VideoTheme = new VideoTheme() // 视频样式
  highlightTheme: HighlightTheme = new HighlightTheme() // 高亮样式

  /**
   * 设置上下文
   *
   * @param context 上下文
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setStageContext
   * @return MarkdownTheme
   */
  setContext(context: Context): MarkdownTheme {
    this.globalTheme.setStageContext(context)
    return this
  }

  /**
   * 设置默认浅色主题
   *
   * @return MarkdownTheme
   */
  setDefaultTheme(): MarkdownTheme {
    // 浅色主题 - 只切换颜色属性
    // 全局主题
    this.globalTheme.setBackgroundColor(COLOR_TRANSPARENT) // markdown全局背景颜色
    // 段落主题
    this.paragraphTheme.setParagraphTextFontColor(COLOR_FF191919) // 段落文本颜色
    // 标题主题
    this.headingTheme.setTextFontColorForAllHeading(COLOR_FF191919) // 标题文本颜色
    this.headingTheme.setUnderlineColorForAllHeading(COLOR_FF191919) // 标题下划线颜色
    // 表格主题
    this.tableTheme.setTableBorderColor(COLOR_BLACK) // 表格边框颜色
    this.tableTheme.setTableTitleTextFontColor(COLOR_FF191919) // 表格标题文本颜色
    this.tableTheme.setTableContentTextFontColor(COLOR_FF191919) // 表格内容文本颜色
    this.tableTheme.setTableTitleBackgroundColor(COLOR_WHITE) // 表格标题背景颜色
    this.tableTheme.setTableContentOddRowBackgroundColor(COLOR_FFE0E0E0) // 表格内容奇数行背景颜色
    this.tableTheme.setTableContentEvenRowBackgroundColor(COLOR_WHITE) // 表格内容偶数行背景颜色
    this.tableTheme.setTableScrollBarColor(COLOR_FF191919_SCB) // 表格滚动条颜色
    // 分隔线主题
    this.dividerTheme.setDividerColor(COLOR_FF191919) // 分隔线颜色
    // 引用块主题
    this.blockQuoteTheme.setBlockQuoteLeftBorderColor(COLOR_FF191919) // 引用块左侧边框颜色
    this.blockQuoteTheme.setBlockQuoteBackgroundColor(COLOR_FFEAEAEA) // 引用块背景颜色
    // 有序列表主题
    this.orderedListTheme.setOrderedListMarkerTextFontColor(COLOR_FF191919) // 有序列表标记文本颜色
    // 无序列表主题
    this.bulletListTheme.setBulletListBulletTextFontColor(COLOR_FF191919) // 无序列表标记文本颜色
    this.bulletListTheme.setBulletListCheckboxSelectedColor(COLOR_FF808080) // 无序列表复选框选中颜色
    // 代码块主题
    this.codeBlockTheme.setCodeBlockBorderColor(COLOR_TRANSPARENT) // 代码块边框颜色
    this.codeBlockTheme.setCodeBlockListTitleSelectTextColor(COLOR_RED) // 列表标题选中文本颜色
    this.codeBlockTheme.setCodeBlockListTitleUnselectTextColor(COLOR_BLACK) // 列表标题未选中文本颜色
    this.codeBlockTheme.setCodeBlockListTitleSelectBackgroundColor(COLOR_FF808080) // 列表标题选中背景颜色
    this.codeBlockTheme.setCodeBlockListTitleUnselectBackgroundColor(COLOR_TRANSPARENT) // 列表标题未选背景颜色
    // 音频主题
    this.audioTheme.setAudioBackgroundColor(COLOR_TRANSPARENT) // 音频背景颜色
    this.audioTheme.setAudioBorderColor(COLOR_33000000) // 音频边框颜色
    this.audioTheme.setAudioShadowColor(COLOR_1A000000) // 音频阴影颜色
    this.audioTheme.setAudioTitleTextFontColor(COLOR_BLACK) // 音频标题文本颜色
    this.audioTheme.setAudioTypeTextFontColor(COLOR_80000000) // 音频类型文本颜色
    this.audioTheme.setAudioButtonBackgroundColor(COLOR_BLACK) // 音频按钮背景颜色
    this.audioTheme.setAudioButtonBorderColor(COLOR_TRANSPARENT) // 音频按钮边框颜色
    this.audioTheme.setAudioButtonTextFontColor(COLOR_WHITE) // 音频按钮文本颜色
    // 视频主题
    this.videoTheme.setVideoBackgroundColor(COLOR_TRANSPARENT) // 视频背景颜色
    this.videoTheme.setVideoBorderColor(COLOR_TRANSPARENT) // 视频边框颜色
    this.videoTheme.setVideoTimeTextFontColor(COLOR_WHITE) // 视频时间文本颜色
    this.videoTheme.setVideoReleaseButtonBackgroundColor(COLOR_FFF5F5F5) // 视频发布按钮背景颜色
    this.videoTheme.setVideoReleaseButtonTextFontColor(COLOR_60000000) // 视频发布按钮文本颜色
    this.videoTheme.setVideoDownloadButtonBackgroundColor(COLOR_FFF5F5F5) // 视频下载按钮背景颜色
    this.videoTheme.setVideoDownloadButtonTextFontColor(COLOR_60000000) // 视频下载按钮文本颜色
    // 脚注引用主题
    this.footnoteRefTheme.setFootnoteRefTextFontColor(COLOR_RED) // 脚注引用文本颜色
    this.footnoteRefTheme.setFootnoteRefTextDecorationColor(COLOR_RED) // 脚注引用文本下划线颜色
    this.footnoteRefTheme.setFootnoteRefTextBackgroundColor(COLOR_TRANSPARENT) // 脚注引用文本背景颜色
    // 行内代码主题
    this.inlineCodeTheme.setInlineCodeTextBackgroundColor(COLOR_FFEAEAEA) // 行内代码文本背景颜色
    // HTML下划线主题
    this.htmlUnderlineTheme.setHtmlUnderlineTextDecorationColor(COLOR_FF191919) // HTML下划线文本下划线颜色
    // 图片主题
    this.imageTheme.setImageBorderColor(COLOR_BLACK) // 图片边框颜色
    this.imageTheme.setImageDownloadButtonBackgroundColor(COLOR_FFF5F5F5) // 图片下载按钮背景颜色
    this.imageTheme.setImageDownloadButtonTextFontColor(COLOR_E6000000) // 图片下载按钮文本颜色
    // 链接主题
    this.linkTheme.setLinkTextFontColor(COLOR_RED) // 链接文本颜色
    this.linkTheme.setLinkTextDecorationColor(COLOR_RED) // 链接文本下划线颜色
    this.linkTheme.setLinkTextBackgroundColor(COLOR_TRANSPARENT) // 链接文本背景颜色
    this.linkTheme.setLinkCircleIconBackgroundColor(COLOR_TRANSPARENT) // 链接圆形图标背景颜色
    this.linkTheme.setLinkCircleIconButtonBackgroundColor(COLOR_BLACK) // 链接圆形图标按钮背景颜色
    this.linkTheme.setLinkCircleIconTextColor(COLOR_WHITE) // 链接圆形图标按钮文本颜色
    this.linkTheme.setLinkRectIconBackgroundColor(COLOR_TRANSPARENT) // 链接方形图标背景颜色
    this.linkTheme.setLinkRectIconButtonBackgroundColor(COLOR_BLACK) // 链接方形图标按钮背景颜色
    this.linkTheme.setLinkRectIconTextColor(COLOR_WHITE) // 链接方形图标按钮文本颜色
    this.linkTheme.setLinkRectToolIconBackgroundColor(COLOR_TRANSPARENT) // 链接方形图标工具按钮背景颜色
    this.linkTheme.setLinkRectToolIconButtonBackgroundColor(COLOR_WHITE) // 链接方形图标工具按钮背景颜色
    // 删除线主题
    this.strikethroughTheme.setStrikethroughTextDecorationColor(COLOR_FF191919) // 删除线文本下划线颜色
    // 代码高亮主题
    this.codeBlockTheme.setCodeBlockIsDark(false)
    // 数学公式主题
    this.latexMathTheme.setLatexMathTextColor(COLOR_FF191919)
    this.latexMathTheme.setLatexMathBackgroundColor(COLOR_TRANSPARENT_SCB)
    this.latexMathTheme.setLatexMathDefaultTextFontColor(COLOR_FF191919)
    return this
  }

  /**
   * 设置Darcula深色主题
   *
   * @return MarkdownTheme
   */
  setDarculaTheme(): MarkdownTheme {
    // 深色主题设计
    // 全局主题
    this.globalTheme.setBackgroundColor(COLOR_TRANSPARENT) // markdown全局背景颜色
    // 段落主题
    this.paragraphTheme.setParagraphTextFontColor(COLOR_FFE0E0E0) // 段落文本颜色
    // 标题主题
    this.headingTheme.setTextFontColorForAllHeading(COLOR_FFE0E0E0) // 标题文本颜色
    this.headingTheme.setUnderlineColorForAllHeading(COLOR_FFE0E0E0) // 标题下划线颜色
    // 表格主题
    this.tableTheme.setTableBorderColor(COLOR_FF404040) // 表格边框颜色
    this.tableTheme.setTableTitleTextFontColor(COLOR_FFE0E0E0) // 表格标题文本颜色
    this.tableTheme.setTableContentTextFontColor(COLOR_FFE0E0E0) // 表格内容文本颜色
    this.tableTheme.setTableTitleBackgroundColor(COLOR_FF2D2D2D) // 表格标题背景颜色
    this.tableTheme.setTableContentOddRowBackgroundColor(COLOR_FF1E1E1E) // 表格内容奇数行背景颜色
    this.tableTheme.setTableContentEvenRowBackgroundColor(COLOR_FF2D2D2D) // 表格内容偶数行背景颜色
    this.tableTheme.setTableScrollBarColor(COLOR_FFE0E0E0_SCB) // 表格滚动条颜色
    // 分隔线主题
    this.dividerTheme.setDividerColor(COLOR_FFE0E0E0) // 分隔线颜色
    // 引用块主题
    this.blockQuoteTheme.setBlockQuoteLeftBorderColor(COLOR_FFE0E0E0) // 引用块左侧边框颜色
    this.blockQuoteTheme.setBlockQuoteBackgroundColor(COLOR_FF252526) // 引用块背景颜色
    // 有序列表主题
    this.orderedListTheme.setOrderedListMarkerTextFontColor(COLOR_FFE0E0E0) // 有序列表标记文本颜色
    // 无序列表主题
    this.bulletListTheme.setBulletListBulletTextFontColor(COLOR_FFE0E0E0) // 无序列表标记文本颜色
    this.bulletListTheme.setBulletListCheckboxSelectedColor(COLOR_FF4A90E2) // 无序列表复选框选中颜色
    // 代码块主题
    this.codeBlockTheme.setCodeBlockBorderColor(COLOR_TRANSPARENT) // 代码块边框颜色
    this.codeBlockTheme.setCodeBlockListTitleSelectTextColor(COLOR_FF4A90E2) // 列表标题选中文本颜色
    this.codeBlockTheme.setCodeBlockListTitleUnselectTextColor(COLOR_FFE0E0E0) // 列表标题未选中文本颜色
    this.codeBlockTheme.setCodeBlockListTitleSelectBackgroundColor(COLOR_FF2D2D2D) // 列表标题选中背景颜色
    this.codeBlockTheme.setCodeBlockListTitleUnselectBackgroundColor(COLOR_TRANSPARENT) // 列表标题未选背景颜色
    // 音频主题
    this.audioTheme.setAudioBackgroundColor(COLOR_FF1E1E1E) // 音频背景颜色
    this.audioTheme.setAudioBorderColor(COLOR_FF404040) // 音频边框颜色
    this.audioTheme.setAudioShadowColor(COLOR_40000000) // 音频阴影颜色
    this.audioTheme.setAudioTitleTextFontColor(COLOR_FFE0E0E0) // 音频标题文本颜色
    this.audioTheme.setAudioTypeTextFontColor(COLOR_FFA0A0A0) // 音频类型文本颜色
    this.audioTheme.setAudioButtonBackgroundColor(COLOR_FF2D2D2D) // 音频按钮背景颜色
    this.audioTheme.setAudioButtonBorderColor(COLOR_FF404040) // 音频按钮边框颜色
    this.audioTheme.setAudioButtonTextFontColor(COLOR_FFE0E0E0) // 音频按钮文本颜色
    // 视频主题
    this.videoTheme.setVideoBackgroundColor(COLOR_FF1E1E1E) // 视频背景颜色
    this.videoTheme.setVideoBorderColor(COLOR_FF404040) // 视频边框颜色
    this.videoTheme.setVideoTimeTextFontColor(COLOR_FFE0E0E0) // 视频时间文本颜色
    this.videoTheme.setVideoReleaseButtonBackgroundColor(COLOR_FF2D2D2D) // 视频释放按钮背景颜色
    this.videoTheme.setVideoReleaseButtonTextFontColor(COLOR_FFE0E0E0) // 视频释放按钮文本颜色
    this.videoTheme.setVideoDownloadButtonBackgroundColor(COLOR_FF2D2D2D) // 视频下载按钮背景颜色
    this.videoTheme.setVideoDownloadButtonTextFontColor(COLOR_FFE0E0E0) // 视频下载按钮文本颜色
    // 脚注引用主题
    this.footnoteRefTheme.setFootnoteRefTextFontColor(COLOR_FF4A90E2) // 脚注引用文本颜色
    this.footnoteRefTheme.setFootnoteRefTextDecorationColor(COLOR_FF4A90E2) // 脚注引用文本下划线颜色
    this.footnoteRefTheme.setFootnoteRefTextBackgroundColor(COLOR_FF1E1E1E) // 脚注引用文本背景颜色
    // 行内代码主题
    this.inlineCodeTheme.setInlineCodeTextBackgroundColor(COLOR_FF252526) // 行内代码背景颜色
    // HTML下划线主题
    this.htmlUnderlineTheme.setHtmlUnderlineTextDecorationColor(COLOR_FFE0E0E0) // HTML下划线文本下划线颜色
    // 图片主题
    this.imageTheme.setImageBorderColor(COLOR_FF404040) // 图片边框颜色
    this.imageTheme.setImageDownloadButtonBackgroundColor(COLOR_FF2D2D2D) // 图片下载按钮背景颜色
    this.imageTheme.setImageDownloadButtonTextFontColor(COLOR_FFE0E0E0) // 图片下载按钮文本颜色
    // 链接主题
    this.linkTheme.setLinkTextFontColor(COLOR_FF4A90E2) // 链接文本颜色
    this.linkTheme.setLinkTextDecorationColor(COLOR_FF4A90E2) // 链接文本下划线颜色
    this.linkTheme.setLinkTextBackgroundColor(COLOR_TRANSPARENT) // 链接文本背景颜色
    this.linkTheme.setLinkCircleIconBackgroundColor(COLOR_TRANSPARENT) // 链接圆形图标背景颜色
    this.linkTheme.setLinkCircleIconButtonBackgroundColor(COLOR_FF2D2D2D) // 链接圆形图标按钮背景颜色
    this.linkTheme.setLinkCircleIconTextColor(COLOR_FFE0E0E0) // 链接圆形图标按钮文本颜色
    this.linkTheme.setLinkRectIconBackgroundColor(COLOR_TRANSPARENT) // 链接方形图标背景颜色
    this.linkTheme.setLinkRectIconButtonBackgroundColor(COLOR_FF2D2D2D) // 链接方形图标按钮背景颜色
    this.linkTheme.setLinkRectIconTextColor(COLOR_FFE0E0E0) // 链接方形图标按钮文本颜色
    this.linkTheme.setLinkRectToolIconBackgroundColor(COLOR_TRANSPARENT) // 链接方形图标工具按钮背景颜色
    this.linkTheme.setLinkRectToolIconButtonBackgroundColor(COLOR_FF2D2D2D) // 链接方形图标工具图标按钮背景颜色
    // 删除线主题
    this.strikethroughTheme.setStrikethroughTextDecorationColor(COLOR_FF404040) // 删除线文本装饰线颜色
    // 代码高亮主题
    this.codeBlockTheme.setCodeBlockIsDark(true)
    // 数学公式主题
    this.latexMathTheme.setLatexMathTextColor(COLOR_FFE0E0E0)
    this.latexMathTheme.setLatexMathBackgroundColor(COLOR_TRANSPARENT_SCB)
    this.latexMathTheme.setLatexMathDefaultTextFontColor(COLOR_FFE0E0E0)
    return this
  }

  /**
   * 设置全局样式
   *
   * @param globalTheme 全局样式
   * @return MarkdownTheme
   */
  setGlobalTheme(globalTheme: GlobalTheme): MarkdownTheme {
    this.globalTheme = globalTheme
    return this
  }

  /**
   * 设置音频样式
   *
   * @param audioTheme 音频样式
   * @return MarkdownTheme
   */
  setAudioTheme(audioTheme: AudioTheme): MarkdownTheme {
    this.audioTheme = audioTheme
    return this
  }

  /**
   * 设置Banner样式
   *
   * @param bannerTheme Banner样式
   * @return MarkdownTheme
   */
  setBannerTheme(bannerTheme: BannerTheme): MarkdownTheme {
    this.bannerTheme = bannerTheme
    return this
  }

  /**
   * 设置块引用样式
   *
   * @param blockQuoteTheme 块引用样式
   * @return MarkdownTheme
   */
  setBlockQuoteTheme(blockQuoteTheme: BlockQuoteTheme): MarkdownTheme {
    this.blockQuoteTheme = blockQuoteTheme
    return this
  }

  /**
   * 设置加粗文本样式
   *
   * @param boldTheme 加粗文本样式
   * @return MarkdownTheme
   */
  setBoldTheme(boldTheme: BoldTheme): MarkdownTheme {
    this.boldTheme = boldTheme
    return this
  }

  /**
   * 设置代码块样式
   *
   * @param codeBlockTheme 代码块样式
   * @return MarkdownTheme
   */
  setCodeBlockTheme(codeBlockTheme: CodeBlockTheme): MarkdownTheme {
    this.codeBlockTheme = codeBlockTheme
    return this
  }

  /**
   * 设置定义列表样式
   *
   * @param definitionListTheme 定义列表样式
   * @return MarkdownTheme
   */
  setDefinitionListTheme(definitionListTheme: DefinitionListTheme): MarkdownTheme {
    this.definitionListTheme = definitionListTheme
    return this
  }

  /**
   * 设置分割线样式
   *
   * @param dividerTheme 分割线样式
   * @return MarkdownTheme
   */
  setDividerTheme(dividerTheme: DividerTheme): MarkdownTheme {
    this.dividerTheme = dividerTheme
    return this
  }

  /**
   * 设置脚注定义样式
   *
   * @param footnoteDefTheme 脚注定义样式
   * @return MarkdownTheme
   */
  setFootnoteDefTheme(footnoteDefTheme: FootnoteDefTheme): MarkdownTheme {
    this.footnoteDefTheme = footnoteDefTheme
    return this
  }

  /**
   * 设置脚注引用样式
   *
   * @param footnoteRefTheme 脚注引用样式
   * @return MarkdownTheme
   */
  setFootnoteRefTheme(footnoteRefTheme: FootnoteRefTheme): MarkdownTheme {
    this.footnoteRefTheme = footnoteRefTheme
    return this
  }

  /**
   * 设置标题样式
   *
   * @param headingTheme 标题样式
   * @return MarkdownTheme
   */
  setHeadingTheme(headingTheme: HeadingTheme): MarkdownTheme {
    this.headingTheme = headingTheme
    return this
  }

  /**
   * 设置HTML下划线文本样式
   *
   * @param htmlUnderlineTheme HTML下划线文本样式
   * @return MarkdownTheme
   */
  setHtmlUnderlineTheme(htmlUnderlineTheme: HtmlUnderlineTheme): MarkdownTheme {
    this.htmlUnderlineTheme = htmlUnderlineTheme
    return this
  }

  /**
   * 设置图片样式
   *
   * @param imageTheme 图片样式
   * @return MarkdownTheme
   */
  setImageTheme(imageTheme: ImageTheme): MarkdownTheme {
    this.imageTheme = imageTheme
    return this
  }

  /**
   * 设置内联代码样式
   *
   * @param inlineCodeTheme 内联代码样式
   * @return MarkdownTheme
   */
  setInlineCodeTheme(inlineCodeTheme: InlineCodeTheme): MarkdownTheme {
    this.inlineCodeTheme = inlineCodeTheme
    return this
  }

  /**
   * 设置斜体文本样式
   *
   * @param italicTheme 斜体文本样式
   * @return MarkdownTheme
   */
  setItalicTheme(italicTheme: ItalicTheme): MarkdownTheme {
    this.italicTheme = italicTheme
    return this
  }

  /**
   * 设置数学公式样式
   *
   * @param latexMathTheme 数学公式样式
   * @return MarkdownTheme
   */
  setLatexMathTheme(latexMathTheme: LatexMathTheme): MarkdownTheme {
    this.latexMathTheme = latexMathTheme
    return this
  }

  /**
   * 设置数学公式未加载状态是否显示文字
   *
   * @param latexDefaultText 数学公式未加载状态是否显示文字 - 默认true
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathDefaultText
   * @return MarkdownTheme
   */
  setLatexDefaultText(latexDefaultText: boolean): MarkdownTheme {
    this.latexMathTheme.setLatexMathDefaultText(latexDefaultText)
    return this
  }

  /**
   * 设置数学公式文本大小
   *
   * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathDefaultTextFontSize
   * @return MarkdownTheme
   */
  setLatexMathTextSize(latexMathTextSize: number): MarkdownTheme {
    this.latexMathTheme.setLatexMathTextSize(latexMathTextSize)
    return this
  }

  /**
   * 设置数学公式背景色
   *
   * @param latexMathBackgroundColor 数学公式背景色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathBackgroundColor
   * @return MarkdownTheme
   */
  setLatexMathBackgroundColor(latexMathBackgroundColor: ResourceColor): MarkdownTheme {
    this.latexMathTheme.setLatexMathBackgroundColor(latexMathBackgroundColor)
    return this
  }

  /**
   * 设置数学公式文本颜色
   *
   * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathTextColor
   * @return MarkdownTheme
   */
  setLatexMathTextColor(latexMathTextColor: ResourceColor): MarkdownTheme {
    this.latexMathTheme.setLatexMathTextColor(latexMathTextColor)
    return this
  }

  /**
   * 设置数学公式生成图片格式
   *
   * @param latexMathColorFormat 数学公式生成图片格式 - 0:RGB_565, 1:BGRA_8888。默认1
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathColorFormat
   * @return MarkdownTheme
   */
  setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): MarkdownTheme {
    this.latexMathTheme.setLatexMathColorFormat(latexMathColorFormat)
    return this
  }

  /**
   * 设置块结构的数学公式是否居中
   *
   * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认true
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathBlockCenter
   * @return MarkdownTheme
   */
  setLatexMathBlockCenter(latexMathBlockCenter: boolean): MarkdownTheme {
    this.latexMathTheme.setLatexMathBlockCenter(latexMathBlockCenter)
    return this
  }

  /**
   * 设置数学公式字体路径
   *
   * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
   * @deprecated since 1.4.0
   * @useinstead LatexMathTheme#setLatexMathResPath
   * @return MarkdownTheme
   */
  setLatexMathResStr(latexMathResStr: string): MarkdownTheme {
    this.latexMathTheme.setLatexMathResPath(latexMathResStr)
    return this
  }

  /**
   * 设置链接文本样式
   *
   * @param linkTheme 链接文本样式
   * @return MarkdownTheme
   */
  setLinkTheme(linkTheme: LinkTheme): MarkdownTheme {
    this.linkTheme = linkTheme
    return this
  }

  /**
   * 设置有序列表样式
   *
   * @param orderedListTheme 有序列表样式
   * @return MarkdownTheme
   */
  setOrderedListTheme(orderedListTheme: OrderedListTheme): MarkdownTheme {
    this.orderedListTheme = orderedListTheme
    return this
  }

  /**
   * 设置段落样式
   *
   * @param paragraphTheme 段落样式
   * @return MarkdownTheme
   */
  setParagraphTheme(paragraphTheme: ParagraphTheme): MarkdownTheme {
    this.paragraphTheme = paragraphTheme
    return this
  }

  /**
   * 设置删除线文本样式
   *
   * @param strikethroughTheme 删除线文本样式
   * @return MarkdownTheme
   */
  setStrikethroughTheme(strikethroughTheme: StrikethroughTheme): MarkdownTheme {
    this.strikethroughTheme = strikethroughTheme
    return this
  }

  /**
   * 设置下标文本样式
   *
   * @param subTheme 下标文本样式
   * @return MarkdownTheme
   */
  setSubTheme(subTheme: SubTheme): MarkdownTheme {
    this.subTheme = subTheme
    return this
  }

  /**
   * 设置上标文本样式
   *
   * @param supTheme 上标文本样式
   * @return MarkdownTheme
   */
  setSupTheme(supTheme: SupTheme): MarkdownTheme {
    this.supTheme = supTheme
    return this
  }

  /**
   * 设置表格样式
   *
   * @param tableTheme 表格样式
   * @return MarkdownTheme
   */
  setTableTheme(tableTheme: TableTheme): MarkdownTheme {
    this.tableTheme = tableTheme
    return this
  }

  /**
   * 设置无序/任务列表样式
   *
   * @param bulletListTheme 无序/任务列表样式
   * @return MarkdownTheme
   */
  setBulletListTheme(bulletListTheme: BulletListTheme): MarkdownTheme {
    this.bulletListTheme = bulletListTheme
    return this
  }

  /**
   * 设置视频样式
   *
   * @param videoTheme 视频样式
   * @return MarkdownTheme
   */
  setVideoTheme(videoTheme: VideoTheme): MarkdownTheme {
    this.videoTheme = videoTheme
    return this
  }

  /**
   * 设置高亮样式
   *
   * @param highlightTheme 高亮样式
   * @return MarkdownTheme
   */
  setHighlightTheme(highlightTheme: HighlightTheme): MarkdownTheme {
    this.highlightTheme = highlightTheme
    return this
  }

  /**
   * 设置代码块全屏图片icon
   *
   * @param codeFullScreenIcon 代码块全屏图片icon
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenIcon
   * @return MarkdownTheme
   */
  setCodeFullScreenIcon(codeFullScreenIcon: Resource): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockFullScreenIcon(codeFullScreenIcon)
    return this
  }

  /**
   * 设置代码块复制图片icon
   *
   * @param codeCopyIcon 代码块复制图片icon
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockCopyIcon
   * @return MarkdownTheme
   */
  setCodeCopyIcon(codeCopyIcon: Resource): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockCopyIcon(codeCopyIcon)
    return this
  }

  /**
   * 设置音频图片icon
   *
   * @param audioIcon 音频图片icon
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioIcon
   * @return MarkdownTheme
   */
  setAudioIcon(audioIcon: Resource): MarkdownTheme {
    this.audioTheme.setAudioIcon(audioIcon)
    return this
  }

  /**
   * 设置视频默认占位图
   *
   * @param videoImage 视频默认占位图
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoPlaceholder
   * @return MarkdownTheme
   */
  setVideoImage(videoImage: Resource): MarkdownTheme {
    this.videoTheme.setVideoPlaceholder(videoImage)
    return this
  }

  /**
   * 设置视频播放按钮icon
   *
   * @param playCircleFillIcon 视频播放按钮icon
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoPlayIcon
   * @return MarkdownTheme
   */
  setPlayCircleFillIcon(playCircleFillIcon: Resource): MarkdownTheme {
    this.videoTheme.setVideoPlayIcon(playCircleFillIcon)
    return this
  }

  /**
   * 设置banner占位图
   *
   * @param bannerImage banner占位图
   * @deprecated since 1.4.0
   * @useinstead BannerTheme#setBannerPlaceholder
   * @return MarkdownTheme
   */
  setBannerImage(bannerImage: Resource): MarkdownTheme {
    this.bannerTheme.setBannerPlaceholder(bannerImage)
    return this
  }

  /**
   * 设置图片占位图
   *
   * @param imageResource 图片占位图
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImagePlaceholder
   * @return MarkdownTheme
   */
  setImageResource(imageResource: Resource): MarkdownTheme {
    this.imageTheme.setImagePlaceholder(imageResource)
    return this
  }

  /**
   * 设置视频发布默认图标
   *
   * @param videoReleaseImage 视频发布默认图标
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonIcon
   * @return MarkdownTheme
   */
  setVideoReleaseImage(videoReleaseImage: Resource): MarkdownTheme {
    this.videoTheme.setVideoReleaseButtonIcon(videoReleaseImage)
    return this
  }

  /**
   * 设置视频下载默认图标
   *
   * @param videoDownloadImage 视频下载默认图标
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonIcon
   * @return MarkdownTheme
   */
  setVideoDownloadImage(videoDownloadImage: Resource): MarkdownTheme {
    this.videoTheme.setVideoDownloadButtonIcon(videoDownloadImage)
    return this
  }

  /**
   * 设置图片下载默认图标
   *
   * @param imageDownloadImage 图片下载默认图标
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonIcon
   * @return MarkdownTheme
   */
  setImageDownloadImage(imageDownloadImage: Resource): MarkdownTheme {
    this.imageTheme.setImageDownloadButtonIcon(imageDownloadImage)
    return this
  }

  /**
   * 设置markdown是否同步解析
   *
   * @param isMarkdownParserSync markdown是否同步解析 - 默认false
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsMarkdownParserSync
   * @return MarkdownTheme
   */
  setIsMarkdownParserSync(isMarkdownParserSync: boolean): MarkdownTheme {
    this.globalTheme.setIsMarkdownParserSync(isMarkdownParserSync)
    return this
  }

  /**
   * 设置是否打开长按复制粘贴
   *
   * @param isOnCopy 是否打开长按复制粘贴 - 默认true
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsOnCopy
   * @return MarkdownTheme
   */
  setIsOnCopy(isOnCopy: boolean): MarkdownTheme {
    this.globalTheme.setIsOnCopy(isOnCopy)
    return this
  }

  /**
   * 设置markdown第一个模块上边距
   *
   * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setGlobalMargin
   * @return MarkdownTheme
   */
  setBlockFirstTopMargin(blockFirstTopMargin: number): MarkdownTheme {
    this.globalTheme.setGlobalMargin({ top: blockFirstTopMargin })
    return this
  }

  /**
   * 设置markdown最后一个模块下边距
   *
   * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setGlobalMargin
   * @return MarkdownTheme
   */
  setBlockLastBottomMargin(blockLastBottomMargin: number): MarkdownTheme {
    this.globalTheme.setGlobalMargin({ bottom: blockLastBottomMargin })
    return this
  }

  /**
   * 设置模块间上下间距
   *
   * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setBlockSpacing
   * @return MarkdownTheme
   */
  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): MarkdownTheme {
    this.globalTheme.setBlockSpacing(blockTopAndBottomMargins)
    return this
  }

  /**
   * 设置链接是否是图片显示
   *
   * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkIsIcon
   * @return MarkdownTheme
   */
  setIsLinkStyle(isLinkStyle: boolean): MarkdownTheme {
    this.linkTheme.setLinkIsIcon(isLinkStyle)
    return this
  }

  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkListIsIcon
   * @return MarkdownTheme
   */
  setIsListLinkStyle(isListLinkStyle: boolean): MarkdownTheme {
    this.linkTheme.setLinkListIsIcon(isListLinkStyle)
    return this
  }

  /**
   * 设置文本格式链接文本颜色
   *
   * @param linkColor 文本格式链接文本颜色 - 默认0xFF0000FF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextFontColor
   * @return MarkdownTheme
   */
  setLinkColor(linkColor: number): MarkdownTheme {
    this.linkTheme.setLinkTextFontColor(linkColor)
    return this
  }

  /**
   * 设置是否按照链接文本字体大小显示文本
   *
   * @param isLinkSize 是否按照链接文本字体大小显示文本 - true：显示链接字体文本大小；false：跟随标题段落大小显示。默认true
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextFontSize
   * @return MarkdownTheme
   */
  setIsLinkSize(isLinkSize: boolean): MarkdownTheme {
    if (isLinkSize) {
      if (this.linkTheme.linkTextFontSize === undefined) {
        this.linkTheme.setLinkTextFontSize(14.0)
      }
    } else {
      this.linkTheme.setLinkTextFontSize(undefined)
    }
    return this
  }

  /**
   * 设置文本格式链接文字大小
   *
   * @param linkSize 文本格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextFontSize
   * @return MarkdownTheme
   */
  setLinkSize(linkSize: number): MarkdownTheme {
    this.linkTheme.setLinkTextFontSize(linkSize)
    return this
  }

  /**
   * 设置文本格式链接文字行高
   *
   * @param linkLineHeight 文本格式链接文字行高
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextLineHeight
   * @return MarkdownTheme
   */
  setLinkLineHeight(linkLineHeight: number): MarkdownTheme {
    this.linkTheme.setLinkTextLineHeight(linkLineHeight)
    return this
  }

  /**
   * 设置文本格式链接背景颜色
   *
   * @param linkBackgroundColor 文本格式链接背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextBackgroundColor
   * @return MarkdownTheme
   */
  setLinkBackgroundColor(linkBackgroundColor: number): MarkdownTheme {
    this.linkTheme.setLinkTextBackgroundColor(linkBackgroundColor)
    return this
  }

  /**
   * 设置文本格式是否显示链接下划线
   *
   * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkTextDecorationType
   * @return MarkdownTheme
   */
  setIsLinkUnderlined(isLinkUnderlined: boolean): MarkdownTheme {
    if (isLinkUnderlined) { // 显示下划线
      this.linkTheme.setLinkTextDecorationType(TextDecorationType.Underline)
    } else { // 不显示下划线
      this.linkTheme.setLinkTextDecorationType(TextDecorationType.None)
    }
    return this
  }

  /**
   * 设置圆形图片格式链接主题背景颜色
   *
   * @param linkCircleImageBackgroundColor 圆形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconBackgroundColor
   * @return MarkdownTheme
   */
  setLinkCircleImageBackgroundColor(linkCircleImageBackgroundColor: number): MarkdownTheme {
    this.linkTheme.setLinkCircleIconBackgroundColor(linkCircleImageBackgroundColor)
    return this
  }

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param linkCircleImageButtonBackgroundColor 圆形图片格式链接控件背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconButtonBackgroundColor
   * @return MarkdownTheme
   */
  setLinkCircleImageButtonBackgroundColor(linkCircleImageButtonBackgroundColor: number): MarkdownTheme {
    this.linkTheme.setLinkCircleIconButtonBackgroundColor(linkCircleImageButtonBackgroundColor)
    return this
  }

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconTextSize
   * @return MarkdownTheme
   */
  setLinkCircleImageTextSize(linkCircleImageTextSize: number): MarkdownTheme {
    this.linkTheme.setLinkCircleIconTextSize(linkCircleImageTextSize)
    return this
  }

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconTextColor
   * @return MarkdownTheme
   */
  setLinkCircleImageTextColor(linkCircleImageTextColor: number): MarkdownTheme {
    this.linkTheme.setLinkCircleIconTextColor(linkCircleImageTextColor)
    return this
  }

  /**
   * 设置圆形图片格式链接半径
   *
   * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconRadius
   * @return MarkdownTheme
   */
  setLinkCircleImageRadius(linkCircleImageRadius: number): MarkdownTheme {
    this.linkTheme.setLinkCircleIconRadius(linkCircleImageRadius)
    return this
  }

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkCircleIconMargin
   * @return MarkdownTheme
   */
  setLinkCircleImageMargin(linkCircleImageMargin: number): MarkdownTheme {
    this.linkTheme.setLinkCircleIconMargin(linkCircleImageMargin)
    return this
  }

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectImageBackgroundColor 圆角矩形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconBackgroundColor
   * @return MarkdownTheme
   */
  setLinkRectImageBackgroundColor(linkRectImageBackgroundColor: number): MarkdownTheme {
    this.linkTheme.setLinkRectIconBackgroundColor(linkRectImageBackgroundColor)
    return this
  }

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectImageButtonBackgroundColor 圆角矩形图片格式链接控件背景颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconButtonBackgroundColor
   * @return MarkdownTheme
   */
  setLinkRectImageButtonBackgroundColor(linkRectImageButtonBackgroundColor: number): MarkdownTheme {
    this.linkTheme.setLinkRectIconButtonBackgroundColor(linkRectImageButtonBackgroundColor)
    return this
  }

  /**
   * 设置圆角矩形图片格式链接文字大小
   *
   * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconTextSize
   * @return MarkdownTheme
   */
  setLinkRectImageTextSize(linkRectImageTextSize: number): MarkdownTheme {
    this.linkTheme.setLinkRectIconTextSize(linkRectImageTextSize)
    return this
  }

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconTextColor
   * @return MarkdownTheme
   */
  setLinkRectImageTextColor(linkRectImageTextColor: number): MarkdownTheme {
    this.linkTheme.setLinkRectIconTextColor(linkRectImageTextColor)
    return this
  }

  /**
   * 设置圆角矩形图片格式链接控件高度
   *
   * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconHeight
   * @return MarkdownTheme
   */
  setLinkRectImageHeight(linkRectImageHeight: Length): MarkdownTheme {
    this.linkTheme.setLinkRectIconHeight(linkRectImageHeight)
    return this
  }

  /**
   * 设置圆角矩形图片格式链接左右内边距
   *
   * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconPadding
   * @return MarkdownTheme
   */
  setLinkRectImagePadding(linkRectImagePadding: number): MarkdownTheme {
    this.linkTheme.setLinkRectIconPadding(linkRectImagePadding)
    return this
  }

  /**
   * 设置圆角矩形图片格式链接圆角半径
   *
   * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconRadius
   * @return MarkdownTheme
   */
  setLinkRectImageRadius(linkRectImageRadius: number): MarkdownTheme {
    this.linkTheme.setLinkRectIconRadius(linkRectImageRadius)
    return this
  }

  /**
   * 设置圆角矩形图片格式链接左右外边距
   *
   * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectIconMargin
   * @return MarkdownTheme
   */
  setLinkRectImageMargin(linkRectImageMargin: number): MarkdownTheme {
    this.linkTheme.setLinkRectIconMargin(linkRectImageMargin)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectToolImageBackgroundColor 空心圆角矩形图片格式链接主题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconBackgroundColor
   * @return MarkdownTheme
   */
  setLinkRectToolImageBackgroundColor(linkRectToolImageBackgroundColor: number): MarkdownTheme {
    this.linkTheme.setLinkRectToolIconBackgroundColor(linkRectToolImageBackgroundColor)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectToolImageButtonBackgroundColor 空心圆角矩形图片格式链接控件背景颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconButtonBackgroundColor
   * @return MarkdownTheme
   */
  setLinkRectToolImageButtonBackgroundColor(linkRectToolImageButtonBackgroundColor: number): MarkdownTheme {
    this.linkTheme.setLinkRectToolIconButtonBackgroundColor(linkRectToolImageButtonBackgroundColor)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconTextSize
   * @return MarkdownTheme
   */
  setLinkRectToolImageTextSize(linkRectToolImageTextSize: number): MarkdownTheme {
    this.linkTheme.setLinkRectToolIconTextSize(linkRectToolImageTextSize)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconHeight
   * @return MarkdownTheme
   */
  setLinkRectToolImageHeight(linkRectToolImageHeight: Length): MarkdownTheme {
    this.linkTheme.setLinkRectToolIconHeight(linkRectToolImageHeight)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconPadding
   * @return MarkdownTheme
   */
  setLinkRectToolImagePadding(linkRectToolImagePadding: number): MarkdownTheme {
    this.linkTheme.setLinkRectToolIconPadding(linkRectToolImagePadding)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconBorderWidth
   * @return MarkdownTheme
   */
  setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: Length): MarkdownTheme {
    this.linkTheme.setLinkRectToolIconBorderWidth(linkRectToolImageBorderWidth)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconDividingLineWidth
   * @return MarkdownTheme
   */
  setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: Length): MarkdownTheme {
    this.linkTheme.setLinkRectToolIconDividingLineWidth(linkRectToolImageDividingLineWidth)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconMargin
   * @return MarkdownTheme
   */
  setLinkRectToolImageMargin(linkRectToolImageMargin: number): MarkdownTheme {
    this.linkTheme.setLinkRectToolIconMargin(linkRectToolImageMargin)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconLineLeftPadding
   * @return MarkdownTheme
   */
  setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: number): MarkdownTheme {
    this.linkTheme.setLinkRectToolIconLineLeftPadding(linkRectToolImageLineLeftPadding)
    return this
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
   * @deprecated since 1.4.0
   * @useinstead LinkTheme#setLinkRectToolIconLineRightPadding
   * @return MarkdownTheme
   */
  setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: number): MarkdownTheme {
    this.linkTheme.setLinkRectToolIconLineRightPadding(linkRectToolImageLineRightPadding)
    return this
  }

  /**
   * 设置块引用左边距
   *
   * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteMargin
   * @return MarkdownTheme
   */
  setBlockQuoteLeftMargin(blockQuoteLeftMargin: number): MarkdownTheme {
    this.blockQuoteTheme.setBlockQuoteMargin({ left: blockQuoteLeftMargin })
    return this
  }

  /**
   * 设置块引用右边距
   *
   * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteMargin
   * @return MarkdownTheme
   */
  setBlockQuoteRightMargin(blockQuoteRightMargin: number): MarkdownTheme {
    this.blockQuoteTheme.setBlockQuoteMargin({ right: blockQuoteRightMargin })
    return this
  }

  /**
   * 设置块引用左边线条宽度
   *
   * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteLeftBorderWidth
   * @return MarkdownTheme
   */
  setBlockQuoteWidth(blockQuoteWidth: Length): MarkdownTheme {
    this.blockQuoteTheme.setBlockQuoteLeftBorderWidth(blockQuoteWidth)
    return this
  }

  /**
   * 设置块引用左边线条颜色
   *
   * @param blockQuoteColor 块引用左边线条颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteLeftBorderColor
   * @return MarkdownTheme
   */
  setBlockQuoteColor(blockQuoteColor: number): MarkdownTheme {
    this.blockQuoteTheme.setBlockQuoteLeftBorderColor(blockQuoteColor)
    return this
  }

  /**
   * 设置块引用背景颜色
   *
   * @param blockQuoteBackgroundColor 块引用背景颜色 - 默认0xFFEAEAEA
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteBackgroundColor
   * @return MarkdownTheme
   */
  setBlockQuoteBackgroundColor(blockQuoteBackgroundColor: number): MarkdownTheme {
    this.blockQuoteTheme.setBlockQuoteBackgroundColor(blockQuoteBackgroundColor)
    return this
  }

  /**
   * 设置块引用子模块上下间距
   *
   * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead BlockQuoteTheme#setBlockQuoteChildSpacing
   * @return MarkdownTheme
   */
  setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: number): MarkdownTheme {
    this.blockQuoteTheme.setBlockQuoteChildSpacing(blockQuoteTopAndBottomMargins)
    return this
  }

  /**
   * 设置有序列表、无序列表、任务列表子模块上下间距
   *
   * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListChildSpacing
   *             orderedListTheme#setBulletListChildSpacing
   * @return MarkdownTheme
   */
  setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: number): MarkdownTheme {
    this.orderedListTheme.setOrderedListChildSpacing(blockOrderedAndBulletTopAndBottomMargins)
    this.bulletListTheme.setBulletListChildSpacing(blockOrderedAndBulletTopAndBottomMargins)
    return this
  }

  /**
   * 设置有序列表、无序列表、任务列表左边距
   *
   * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMargin
   *             orderedListTheme#setBulletListMargin
   * @return MarkdownTheme
   */
  setBlockLeftMargin(blockLeftMargin: number): MarkdownTheme {
    this.orderedListTheme.setOrderedListMargin({ left: blockLeftMargin })
    this.bulletListTheme.setBulletListMargin({ left: blockLeftMargin })
    return this
  }

  /**
   * 设置有序列表、无序列表、任务列表右边距
   *
   * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMargin
   *             orderedListTheme#setBulletListMargin
   * @return MarkdownTheme
   */
  setBlockRightMargin(blockRightMargin: number): MarkdownTheme {
    this.orderedListTheme.setOrderedListMargin({ right: blockRightMargin })
    this.bulletListTheme.setBulletListMargin({ right: blockRightMargin })
    return this
  }

  /**
   * 设置有序列表前缀文本是否加粗
   *
   * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontWeight
   * @return MarkdownTheme
   */
  setOrderedListItemPrefixBold(orderedListItemPrefixBold: boolean): MarkdownTheme {
    if (orderedListItemPrefixBold) {
      this.orderedListTheme.setOrderedListMarkerTextFontWeight(FontWeight.Bold)
    } else {
      this.orderedListTheme.setOrderedListMarkerTextFontWeight(FontWeight.Normal)
    }
    return this
  }

  /**
   * 设置有序列表前缀文本颜色
   *
   * @param orderedListItemColor 有序列表前缀文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontColor
   * @return MarkdownTheme
   */
  setOrderedListItemColor(orderedListItemColor: number): MarkdownTheme {
    this.orderedListTheme.setOrderedListMarkerTextFontColor(orderedListItemColor)
    return this
  }

  /**
   * 设置有序列表前缀文本大小
   *
   * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextFontSize
   * @return MarkdownTheme
   */
  setOrderedListItemSize(orderedListItemSize: number): MarkdownTheme {
    this.orderedListTheme.setOrderedListMarkerTextFontSize(orderedListItemSize)
    return this
  }

  /**
   * 设置有序列表前缀文本行高
   *
   * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead OrderedListTheme#setOrderedListMarkerTextLineHeight
   * @return MarkdownTheme
   */
  setOrderedListItemLineHeight(orderedListItemLineHeight: number): MarkdownTheme {
    this.orderedListTheme.setOrderedListMarkerTextLineHeight(orderedListItemLineHeight)
    return this
  }

  /**
   * 设置无序列表前缀是否全部是实心圆型
   *
   * @param bulletListItemCircle 无序列表前缀是否全部是实心圆型 - 默认false
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletIsCircle
   * @return MarkdownTheme
   */
  setBulletListItemCircle(bulletListItemCircle: boolean): MarkdownTheme {
    this.bulletListTheme.setBulletListBulletIsCircle(bulletListItemCircle)
    return this
  }

  /**
   * 设置无序列表前缀文本颜色
   *
   * @param bulletListItemColor 无序列表前缀文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextFontColor
   * @return MarkdownTheme
   */
  setBulletListItemColor(bulletListItemColor: number): MarkdownTheme {
    this.bulletListTheme.setBulletListBulletTextFontColor(bulletListItemColor)
    return this
  }

  /**
   * 设置无序列表前缀文本大小
   *
   * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextFontSize
   * @return MarkdownTheme
   */
  setBulletListItemSize(bulletListItemSize: number): MarkdownTheme {
    this.bulletListTheme.setBulletListBulletTextFontSize(bulletListItemSize)
    return this
  }

  /**
   * 设置无序列表前缀文本行高
   *
   * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListBulletTextLineHeight
   * @return MarkdownTheme
   */
  setBulletListItemLineHeight(bulletListItemLineHeight: number): MarkdownTheme {
    this.bulletListTheme.setBulletListBulletTextLineHeight(bulletListItemLineHeight)
    return this
  }

  /**
   * 设置任务列表选择框宽高
   *
   * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
   * @deprecated since 1.4.0
   * @useinstead BulletListTheme#setBulletListCheckboxWidth
   *             bulletListTheme#setBulletListCheckboxHeight
   * @return MarkdownTheme
   */
  setTaskListItemLength(taskListItemLength: number): MarkdownTheme {
    this.bulletListTheme.setBulletListCheckboxWidth(taskListItemLength)
    this.bulletListTheme.setBulletListCheckboxHeight(taskListItemLength)
    return this
  }

  /**
   * 设置是否格式化代码块内容
   *
   * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块内容；false：不格式化代码块内容。默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsCodeFormat
   * @return MarkdownTheme
   */
  setIsCodeFormat(isCodeFormat: boolean): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockIsCodeFormat(isCodeFormat)
    return this
  }

  /**
   * 设置内联代码文本颜色
   *
   * @param codeTextColor 内联代码文本颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontColor
   * @return MarkdownTheme
   */
  setCodeTextColor(codeTextColor: number): MarkdownTheme {
    this.inlineCodeTheme.setInlineCodeTextFontColor(codeTextColor)
    return this
  }

  /**
   * 设置内联代码背景颜色
   *
   * @param codeBackgroundColor 内联代码背景颜色 - 默认0xFFEAEAEA
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextBackgroundColor
   * @return MarkdownTheme
   */
  setCodeBackgroundColor(codeBackgroundColor: number): MarkdownTheme {
    this.inlineCodeTheme.setInlineCodeTextBackgroundColor(codeBackgroundColor)
    return this
  }

  /**
   * 设置内联代码文本大小
   *
   * @param codeTextSize 内联代码文本大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontSize
   * @return MarkdownTheme
   */
  setCodeTextSize(codeTextSize: number): MarkdownTheme {
    this.inlineCodeTheme.setInlineCodeTextFontSize(codeTextSize)
    return this
  }

  /**
   * 设置内联代码文本字体
   *
   * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead InlineCodeTheme#setInlineCodeTextFontFamily
   * @return MarkdownTheme
   */
  setCodeTypeface(codeTypeface: string): MarkdownTheme {
    this.inlineCodeTheme.setInlineCodeTextFontFamily(codeTypeface)
    return this
  }

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockParserSync
   * @return MarkdownTheme
   */
  setIsCodeBlockParserSync(isCodeBlockParserSync: boolean): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockParserSync(isCodeBlockParserSync)
    return this
  }

  /**
   * 设置代码块代码文本颜色
   *
   * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontColor
   * @return MarkdownTheme
   */
  setCodeBlockTextColor(codeBlockTextColor: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockTextFontColor(codeBlockTextColor)
    return this
  }

  /**
   * 设置代码块代码类型文本颜色
   *
   * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTypeTextFontColor
   * @return MarkdownTheme
   */
  setCodeBlockTypeTextColor(codeBlockTypeTextColor: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockTypeTextFontColor(codeBlockTypeTextColor)
    return this
  }

  /**
   * 设置代码块代码类型文本
   *
   * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTypeText
   * @return MarkdownTheme
   */
  setCodeBlockTypeTextStr(codeBlockTypeTextStr: string): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockTypeText(codeBlockTypeTextStr)
    return this
  }

  /**
   * 设置代码类型和代码块距离
   *
   * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTitleLayoutMarginBottom
   * @return MarkdownTheme
   */
  setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockTitleLayoutMarginBottom(codeBlockTypeTextPadding)
    return this
  }

  /**
   * 设置代码块复制、全屏图片文字是否显示
   *
   * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否隐藏 - true：隐藏；false：显示。默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenTextIsShow
   *             codeBlockTheme#setCodeBlockCopyTextIsShow
   * @return MarkdownTheme
   */
  setCodeBlockIconTextHide(codeBlockIconTextHide: boolean): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockFullScreenTextIsShow(!codeBlockIconTextHide)
    this.codeBlockTheme.setCodeBlockCopyTextIsShow(!codeBlockIconTextHide)
    return this
  }

  /**
   * 设置代码块代码行号是否显示
   *
   * @param codeBlockLineNumberHide 代码块代码行号是否隐藏 - true：隐藏；false：显示。默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockLineNumberIsShow
   * @return MarkdownTheme
   */
  setCodeBlockLineNumberHide(codeBlockLineNumberHide: boolean): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockLineNumberIsShow(!codeBlockLineNumberHide)
    return this
  }

  /**
   * 设置代码块背景颜色
   *
   * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockBackgroundColor
   * @return MarkdownTheme
   */
  setCodeBlockBackgroundColor(codeBlockBackgroundColor: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockBackgroundColor(codeBlockBackgroundColor)
    return this
  }

  /**
   * 设置代码块左边距
   *
   * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockMargin
   * @return MarkdownTheme
   */
  setCodeMultilineMargin(codeMultilineMargin: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockMargin({ left: codeMultilineMargin })
    return this
  }

  /**
   * 设置代码块字体
   *
   * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontFamily
   * @return MarkdownTheme
   */
  setCodeBlockTypeface(codeBlockTypeface: string): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockTextFontFamily(codeBlockTypeface)
    return this
  }

  /**
   * 设置代码块代码文本大小
   *
   * @param codeBlockTextSize 代码块代码文本大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextFontSize
   * @return MarkdownTheme
   */
  setCodeBlockTextSize(codeBlockTextSize: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockTextFontSize(codeBlockTextSize)
    return this
  }

  /**
   * 设置代码块代码文本行高
   *
   * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockTextLineHeight
   * @return MarkdownTheme
   */
  setCodeBlockLineHeight(codeBlockLineHeight: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockTextLineHeight(codeBlockLineHeight)
    return this
  }

  /**
   * 设置代码块控件圆角大小
   *
   * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockRadius
   * @return MarkdownTheme
   */
  setCodeBlockRadius(codeBlockRadius: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockRadius(codeBlockRadius)
    return this
  }

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenButtonIsShow
   * @return MarkdownTheme
   */
  setIsCodeFullScreen(isCodeFullScreen: boolean): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockFullScreenButtonIsShow(isCodeFullScreen)
    return this
  }

  /**
   * 设置代码块代码全屏、代码复制按钮宽高
   *
   * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockFullScreenIconHeight
   *             codeBlockTheme#setCodeBlockFullScreenIconWidth
   *             codeBlockTheme#setCodeBlockCopyIconHeight
   *             codeBlockTheme#setCodeBlockCopyIconWidth
   * @return MarkdownTheme
   */
  setIconWidthAndHeight(iconWidthAndHeight: Length): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockFullScreenIconHeight(iconWidthAndHeight)
    this.codeBlockTheme.setCodeBlockFullScreenIconWidth(iconWidthAndHeight)
    this.codeBlockTheme.setCodeBlockCopyIconHeight(iconWidthAndHeight)
    this.codeBlockTheme.setCodeBlockCopyIconWidth(iconWidthAndHeight)
    return this
  }

  /**
   * 设置组合代码未选中标题字体大小
   *
   * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleTextSize
   * @return MarkdownTheme
   */
  setCodeListTitleTextSize(codeListTitleTextSize: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockListTitleTextSize(codeListTitleTextSize)
    return this
  }

  /**
   * 设置组合代码选中标题字体大小
   *
   * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectTextSize
   * @return MarkdownTheme
   */
  setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockListTitleSelectTextSize(codeListTitleSelectTextSize)
    return this
  }

  /**
   * 设置组合代码选中标题文本颜色
   *
   * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认0xFFFF0000
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectTextColor
   * @return MarkdownTheme
   */
  setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockListTitleSelectTextColor(codeListTitleSelectTextColor)
    return this
  }

  /**
   * 设置组合代码未选中标题文本颜色
   *
   * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleUnselectTextColor
   * @return MarkdownTheme
   */
  setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockListTitleUnselectTextColor(codeListTitleUnSelectTextColor)
    return this
  }

  /**
   * 设置组合代码选中标题背景颜色
   *
   * @param codeListTitleSelectBackgroundColor 组合代码选中标题背景颜色 - 默认0xFF808080
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleSelectBackgroundColor
   * @return MarkdownTheme
   */
  setCodeListTitleSelectBackgroundColor(codeListTitleSelectBackgroundColor: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockListTitleSelectBackgroundColor(codeListTitleSelectBackgroundColor)
    return this
  }

  /**
   * 设置组合代码未选中标题背景颜色
   *
   * @param codeListTitleUnSelectBackgroundColor 组合代码未选中标题背景颜色 - 默认0x00FFFFFF
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockListTitleUnselectBackgroundColor
   * @return MarkdownTheme
   */
  setCodeListTitleUnSelectBackgroundColor(codeListTitleUnSelectBackgroundColor: number): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockListTitleUnselectBackgroundColor(codeListTitleUnSelectBackgroundColor)
    return this
  }

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsSeparate
   * @return MarkdownTheme
   */
  setIsSeparateCodeBlock(isSeparateCodeBlock: boolean): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockIsSeparate(isSeparateCodeBlock)
    return this
  }

  /**
   * 设置单独代码块行号宽度
   *
   * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockSeparateWidth
   * @return MarkdownTheme
   */
  setSeparateCodeBlockWidth(separateCodeBlockWidth: Length): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockSeparateWidth(separateCodeBlockWidth)
    return this
  }

  /**
   * 设置单独代码块是否居底显示
   *
   * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockSeparateIsBottom
   * @return MarkdownTheme
   */
  setSeparateCodeIsBottom(separateCodeIsBottom: boolean): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockSeparateIsBottom(separateCodeIsBottom)
    return this
  }

  /**
   * 设置H1、H2标题下分割线高度
   *
   * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineHeightForAllHeading
   * @return MarkdownTheme
   */
  setHeadingBreakHeight(headingBreakHeight: number): MarkdownTheme {
    this.headingTheme.setUnderlineHeightForAllHeading(headingBreakHeight)
    return this
  }

  /**
   * 设置标题文本字体
   *
   * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontFamilyForAllHeading
   * @return MarkdownTheme
   */
  setHeadingTypeface(headingTypeface: string): MarkdownTheme {
    this.headingTheme.setTextFontFamilyForAllHeading(headingTypeface)
    return this
  }

  /**
   * 设置标题模块上间距
   *
   * @param headingTopMargins 标题模块上间距 - 默认8.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setMarginForAllHeadingEachLevel
   * @return MarkdownTheme
   */
  setHeadingTopMargins(headingTopMargins: number): MarkdownTheme {
    this.headingTheme.setMarginForAllHeadingEachLevel({ top: headingTopMargins })
    return this
  }

  /**
   * 设置标题模块下间距
   *
   * @param headingBottomMargins 标题模块下间距 - 默认8.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setMarginForAllHeadingEachLevel
   * @return MarkdownTheme
   */
  setHeadingBottomMargins(headingBottomMargins: number): MarkdownTheme {
    this.headingTheme.setMarginForAllHeadingEachLevel({ bottom: headingBottomMargins })
    return this
  }

  /**
   * 设置标题文本大小数组
   *
   * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForEachHeading
   * @return MarkdownTheme
   */
  setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<number>): MarkdownTheme {
    this.headingTheme.setTextFontSizeForEachHeading(headingTextSizeMultipliers)
    return this
  }

  /**
   * 设置一级标题文本大小
   *
   * @param headingTextSize1 一级标题文本大小 - 默认20.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextSize1(headingTextSize1: number): MarkdownTheme {
    this.headingTheme.setTextFontSizeForDesignateHeading(1, headingTextSize1)
    return this
  }

  /**
   * 设置二级标题文本大小
   *
   * @param headingTextSize2 二级标题文本大小 - 默认17.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextSize2(headingTextSize2: number): MarkdownTheme {
    this.headingTheme.setTextFontSizeForDesignateHeading(2, headingTextSize2)
    return this
  }

  /**
   * 设置三级标题文本大小
   *
   * @param headingTextSize3 三级标题文本大小 - 默认16.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextSize3(headingTextSize3: number): MarkdownTheme {
    this.headingTheme.setTextFontSizeForDesignateHeading(3, headingTextSize3)
    return this
  }

  /**
   * 设置四级标题文本大小
   *
   * @param headingTextSize4 四级标题文本大小 - 默认15.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextSize4(headingTextSize4: number): MarkdownTheme {
    this.headingTheme.setTextFontSizeForDesignateHeading(4, headingTextSize4)
    return this
  }

  /**
   * 设置五级标题文本大小
   *
   * @param headingTextSize5 五级标题文本大小 - 默认15.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextSize5(headingTextSize5: number): MarkdownTheme {
    this.headingTheme.setTextFontSizeForDesignateHeading(5, headingTextSize5)
    return this
  }

  /**
   * 设置六级标题文本大小
   *
   * @param headingTextSize6 六级标题文本大小 - 默认13.0
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontSizeForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextSize6(headingTextSize6: number): MarkdownTheme {
    this.headingTheme.setTextFontSizeForDesignateHeading(6, headingTextSize6)
    return this
  }

  /**
   * 设置标题文本颜色
   *
   * @param headingTextColor 标题文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForAllHeading
   * @return MarkdownTheme
   */
  setHeadingTextColor(headingTextColor: number): MarkdownTheme {
    this.headingTheme.setTextFontColorForAllHeading(headingTextColor)
    return this
  }

  /**
   * 设置H1、H2标题下分割线颜色
   *
   * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForAllHeading
   * @return MarkdownTheme
   */
  setHeadingBreakColor(headingBreakColor: number): MarkdownTheme {
    this.headingTheme.setUnderlineColorForAllHeading(headingBreakColor)
    return this
  }

  /**
   * 设置标题文本字间距
   *
   * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLetterSpacingForAllHeading
   * @return MarkdownTheme
   */
  setHeadingTextWordSpace(headingTextWordSpace: number): MarkdownTheme {
    this.headingTheme.setTextLetterSpacingForAllHeading(headingTextWordSpace)
    return this
  }

  /**
   * 设置一级标题文本行高
   *
   * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextLineHeight1(headingTextLineHeight1: number): MarkdownTheme {
    this.headingTheme.setTextLineHeightForDesignateHeading(1, headingTextLineHeight1)
    return this
  }

  /**
   * 设置二级标题文本行高
   *
   * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextLineHeight2(headingTextLineHeight2: number): MarkdownTheme {
    this.headingTheme.setTextLineHeightForDesignateHeading(2, headingTextLineHeight2)
    return this
  }

  /**
   * 设置三级标题文本行高
   *
   * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextLineHeight3(headingTextLineHeight3: number): MarkdownTheme {
    this.headingTheme.setTextLineHeightForDesignateHeading(3, headingTextLineHeight3)
    return this
  }

  /**
   * 设置四级标题文本行高
   *
   * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextLineHeight4(headingTextLineHeight4: number): MarkdownTheme {
    this.headingTheme.setTextLineHeightForDesignateHeading(4, headingTextLineHeight4)
    return this
  }

  /**
   * 设置五级标题文本行高
   *
   * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextLineHeight5(headingTextLineHeight5: number): MarkdownTheme {
    this.headingTheme.setTextLineHeightForDesignateHeading(5, headingTextLineHeight5)
    return this
  }

  /**
   * 设置六级标题文本行高
   *
   * @param headingTextLineHeight6 六级标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextLineHeightForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextLineHeight6(headingTextLineHeight6: number): MarkdownTheme {
    this.headingTheme.setTextLineHeightForDesignateHeading(6, headingTextLineHeight6)
    return this
  }

  /**
   * 设置一级标题文本颜色
   *
   * @param headingTextColor1 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextColor1(headingTextColor1: number): MarkdownTheme {
    this.headingTheme.setTextFontColorForDesignateHeading(1, headingTextColor1)
    return this
  }

  /**
   * 设置H1标题下分割线颜色
   *
   * @param headingBreakColor1 H1标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingBreakColor1(headingBreakColor1: number): MarkdownTheme {
    this.headingTheme.setUnderlineColorForDesignateHeading(1, headingBreakColor1)
    return this
  }

  /**
   * 设置二级标题文本颜色
   *
   * @param headingTextColor2 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextColor2(headingTextColor2: number): MarkdownTheme {
    this.headingTheme.setTextFontColorForDesignateHeading(2, headingTextColor2)
    return this
  }

  /**
   * 设置H2标题下分割线颜色
   *
   * @param headingBreakColor2 H2标题下分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setUnderlineColorForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingBreakColor2(headingBreakColor2: number): MarkdownTheme {
    this.headingTheme.setUnderlineColorForDesignateHeading(2, headingBreakColor2)
    return this
  }

  /**
   * 设置三级标题文本颜色
   *
   * @param headingTextColor3 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextColor3(headingTextColor3: number): MarkdownTheme {
    this.headingTheme.setTextFontColorForDesignateHeading(3, headingTextColor3)
    return this
  }

  /**
   * 设置四级标题文本颜色
   *
   * @param headingTextColor4 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextColor4(headingTextColor4: number): MarkdownTheme {
    this.headingTheme.setTextFontColorForDesignateHeading(4, headingTextColor4)
    return this
  }

  /**
   * 设置五级标题文本颜色
   *
   * @param headingTextColor5 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextColor5(headingTextColor5: number): MarkdownTheme {
    this.headingTheme.setTextFontColorForDesignateHeading(5, headingTextColor5)
    return this
  }

  /**
   * 设置六级标题文本颜色
   *
   * @param headingTextColor6 标题文本颜色
   * @deprecated since 1.4.0
   * @useinstead HeadingTheme#setTextFontColorForDesignateHeading
   * @return MarkdownTheme
   */
  setHeadingTextColor6(headingTextColor6: number): MarkdownTheme {
    this.headingTheme.setTextFontColorForDesignateHeading(6, headingTextColor6)
    return this
  }

  /**
   * 设置段落模块上间距
   *
   * @param paragraphTopMargins 段落模块上间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphMargin
   * @return MarkdownTheme
   */
  setParagraphTopMargins(paragraphTopMargins: number): MarkdownTheme {
    this.paragraphTheme.setParagraphMargin({ top: paragraphTopMargins })
    return this
  }

  /**
   * 设置段落模块下间距
   *
   * @param paragraphBottomMargins 段落模块下间距 - 默认8.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphMargin
   * @return MarkdownTheme
   */
  setParagraphBottomMargins(paragraphBottomMargins: number): MarkdownTheme {
    this.paragraphTheme.setParagraphMargin({ bottom: paragraphBottomMargins })
    return this
  }

  /**
   * 设置段落文本大小
   *
   * @param paragraphTextSize 段落文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontSize
   * @return MarkdownTheme
   */
  setParagraphTextSize(paragraphTextSize: number): MarkdownTheme {
    this.paragraphTheme.setParagraphTextFontSize(paragraphTextSize)
    return this
  }

  /**
   * 设置段落文本颜色
   *
   * @param paragraphTextColor 段落文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontColor
   * @return MarkdownTheme
   */
  setParagraphTextColor(paragraphTextColor: number): MarkdownTheme {
    this.paragraphTheme.setParagraphTextFontColor(paragraphTextColor)
    return this
  }

  /**
   * 设置段落文本字间距
   *
   * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextLetterSpacing
   * @return MarkdownTheme
   */
  setParagraphTextWordSpace(paragraphTextWordSpace: number): MarkdownTheme {
    this.paragraphTheme.setParagraphTextLetterSpacing(paragraphTextWordSpace)
    return this
  }

  /**
   * 设置段落文本行高
   *
   * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextLineHeight
   * @return MarkdownTheme
   */
  setParagraphTextLineHeight(paragraphTextLineHeight: number): MarkdownTheme {
    this.paragraphTheme.setParagraphTextLineHeight(paragraphTextLineHeight)
    return this
  }

  /**
   * 设置段落文本字体
   *
   * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
   * @deprecated since 1.4.0
   * @useinstead ParagraphTheme#setParagraphTextFontFamily
   * @return MarkdownTheme
   */
  setParagraphTypeface(paragraphTypeface: string): MarkdownTheme {
    this.paragraphTheme.setParagraphTextFontFamily(paragraphTypeface)
    return this
  }

  /**
   * 设置分割线颜色
   *
   * @param thematicBreakColor 分割线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerColor
   * @return MarkdownTheme
   */
  setThematicBreakColor(thematicBreakColor: number): MarkdownTheme {
    this.dividerTheme.setDividerColor(thematicBreakColor)
    return this
  }

  /**
   * 设置分割线高度
   *
   * @param thematicBreakHeight 分割线高度 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerStrokeWidth
   * @return MarkdownTheme
   */
  setThematicBreakHeight(thematicBreakHeight: number): MarkdownTheme {
    this.dividerTheme.setDividerStrokeWidth(thematicBreakHeight)
    return this
  }

  /**
   * 设置分割线上部外边距
   *
   * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerMargin
   * @return MarkdownTheme
   */
  setThematicBreakTopMargin(thematicBreakTopMargin: number): MarkdownTheme {
    this.dividerTheme.setDividerMargin({ top: thematicBreakTopMargin })
    return this
  }

  /**
   * 设置分割线下部外边距
   *
   * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead DividerTheme#setDividerMargin
   * @return MarkdownTheme
   */
  setThematicBreakBottomMargin(thematicBreakBottomMargin: number): MarkdownTheme {
    this.dividerTheme.setDividerMargin({ bottom: thematicBreakBottomMargin })
    return this
  }

  /**
   * 设置软换行是否换行
   *
   * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setIsLineBreak
   * @return MarkdownTheme
   */
  setIsLineBreak(isLineBreak: boolean): MarkdownTheme {
    this.globalTheme.setIsLineBreak(isLineBreak)
    return this
  }

  /**
   * 设置音频阴影颜色值
   *
   * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioShadowColor
   * @return MarkdownTheme
   */
  setAudioShadowColor(audioShadowColor: number): MarkdownTheme {
    this.audioTheme.setAudioShadowColor(audioShadowColor)
    return this
  }

  /**
   * 设置音频边框颜色
   *
   * @param audioBorderColor 音频边框颜色 - 默认0x33000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderColor
   * @return MarkdownTheme
   */
  setAudioBorderColor(audioBorderColor: number): MarkdownTheme {
    this.audioTheme.setAudioBorderColor(audioBorderColor)
    return this
  }

  /**
   * 设置音频边框粗细
   *
   * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderWidth
   * @return MarkdownTheme
   */
  setAudioBorderWidth(audioBorderWidth: Length): MarkdownTheme {
    this.audioTheme.setAudioBorderWidth(audioBorderWidth)
    return this
  }

  /**
   * 设置音频边框圆角
   *
   * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioBorderRadius
   * @return MarkdownTheme
   */
  setAudioBorderRadius(audioBorderRadius: number): MarkdownTheme {
    this.audioTheme.setAudioBorderRadius(audioBorderRadius)
    return this
  }

  /**
   * 设置音频按钮背景颜色
   *
   * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonBackgroundColor
   * @return MarkdownTheme
   */
  setAudioButtonBackgroundColor(audioButtonBackgroundColor: number): MarkdownTheme {
    this.audioTheme.setAudioButtonBackgroundColor(audioButtonBackgroundColor)
    return this
  }

  /**
   * 设置音频按钮文字颜色
   *
   * @param audioButtonTextColor 音频按钮文字颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonTextFontColor
   * @return MarkdownTheme
   */
  setAudioButtonTextColor(audioButtonTextColor: number): MarkdownTheme {
    this.audioTheme.setAudioButtonTextFontColor(audioButtonTextColor)
    return this
  }

  /**
   * 设置音频按钮文字大小
   *
   * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonTextFontSize
   * @return MarkdownTheme
   */
  setAudioButtonTextSize(audioButtonTextSize: number): MarkdownTheme {
    this.audioTheme.setAudioButtonTextFontSize(audioButtonTextSize)
    return this
  }

  /**
   * 设置音频按钮文字内容
   *
   * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonText
   * @return MarkdownTheme
   */
  setAudioButtonText(audioButtonText: string): MarkdownTheme {
    this.audioTheme.setAudioButtonText(audioButtonText)
    return this
  }

  /**
   * 设置音频按钮圆角
   *
   * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioButtonRadius
   * @return MarkdownTheme
   */
  setAudioButtonBorderRadius(audioButtonBorderRadius: number): MarkdownTheme {
    this.audioTheme.setAudioButtonRadius(audioButtonBorderRadius)
    return this
  }

  /**
   * 设置音频标题文字大小
   *
   * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextFontSize
   * @return MarkdownTheme
   */
  setAudioTitleTextSize(audioTitleTextSize: number): MarkdownTheme {
    this.audioTheme.setAudioTitleTextFontSize(audioTitleTextSize)
    return this
  }

  /**
   * 设置音频标题文字颜色
   *
   * @param audioTitleTextColor 音频标题文字颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextFontColor
   * @return MarkdownTheme
   */
  setAudioTitleTextColor(audioTitleTextColor: number): MarkdownTheme {
    this.audioTheme.setAudioTitleTextFontColor(audioTitleTextColor)
    return this
  }

  /**
   * 设置音频标题文字行高
   *
   * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTitleTextLineHeight
   * @return MarkdownTheme
   */
  setAudioTitleTextLineHeight(audioTitleTextLineHeight: number): MarkdownTheme {
    this.audioTheme.setAudioTitleTextLineHeight(audioTitleTextLineHeight)
    return this
  }

  /**
   * 设置音频类型文字大小
   *
   * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextFontSize
   * @return MarkdownTheme
   */
  setAudioTypeTextSize(audioTypeTextSize: number): MarkdownTheme {
    this.audioTheme.setAudioTypeTextFontSize(audioTypeTextSize)
    return this
  }

  /**
   * 设置音频类型文字颜色
   *
   * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextFontColor
   * @return MarkdownTheme
   */
  setAudioTypeTextColor(audioTypeTextColor: number): MarkdownTheme {
    this.audioTheme.setAudioTypeTextFontColor(audioTypeTextColor)
    return this
  }

  /**
   * 设置音频类型文字行高
   *
   * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioTypeTextLineHeight
   * @return MarkdownTheme
   */
  setAudioTypeTextLineHeight(audioTypeTextLineHeight: number): MarkdownTheme {
    this.audioTheme.setAudioTypeTextLineHeight(audioTypeTextLineHeight)
    return this
  }

  /**
   * 设置音频上边距
   *
   * @param audioMarginTop 音频上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioMargin
   * @return MarkdownTheme
   */
  setAudioMarginTop(audioMarginTop: number): MarkdownTheme {
    this.audioTheme.setAudioMargin({ top: audioMarginTop })
    return this
  }

  /**
   * 设置音频下边距
   *
   * @param audioMarginBottom 音频下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead AudioTheme#setAudioMargin
   * @return MarkdownTheme
   */
  setAudioMarginBottom(audioMarginBottom: number): MarkdownTheme {
    this.audioTheme.setAudioMargin({ bottom: audioMarginBottom })
    return this
  }

  /**
   * 设置视频圆角
   *
   * @param videoBorderRadius 视频圆角 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoBorderRadius
   * @return MarkdownTheme
   */
  setVideoBorderRadius(videoBorderRadius: number): MarkdownTheme {
    this.videoTheme.setVideoBorderRadius(videoBorderRadius)
    return this
  }

  /**
   * 设置视频时间文本颜色
   *
   * @param videoTimeTextColor 视频时间文本颜色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextFontColor
   * @return MarkdownTheme
   */
  setVideoTimeTextColor(videoTimeTextColor: number): MarkdownTheme {
    this.videoTheme.setVideoTimeTextFontColor(videoTimeTextColor)
    return this
  }

  /**
   * 设置视频时间文本大小
   *
   * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextFontSize
   * @return MarkdownTheme
   */
  setVideoTimeTextSize(videoTimeTextSize: number): MarkdownTheme {
    this.videoTheme.setVideoTimeTextFontSize(videoTimeTextSize)
    return this
  }

  /**
   * 设置视频时间文本居右边距
   *
   * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextMarginRight
   * @return MarkdownTheme
   */
  setVideoTimeTextMarginRight(videoTimeTextMarginRight: number): MarkdownTheme {
    this.videoTheme.setVideoTimeTextMarginRight(videoTimeTextMarginRight)
    return this
  }

  /**
   * 设置视频时间文本居底边距
   *
   * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoTimeTextMarginBottom
   * @return MarkdownTheme
   */
  setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: number): MarkdownTheme {
    this.videoTheme.setVideoTimeTextMarginBottom(videoTimeTextMarginBottom)
    return this
  }

  /**
   * 设置视频上边距
   *
   * @param videoMarginTop 视频上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoMargin
   * @return MarkdownTheme
   */
  setVideoMarginTop(videoMarginTop: number): MarkdownTheme {
    this.videoTheme.setVideoMargin({ top: videoMarginTop })
    return this
  }

  /**
   * 设置视频下边距
   *
   * @param videoMarginBottom 视频下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoMargin
   * @return MarkdownTheme
   */
  setVideoMarginBottom(videoMarginBottom: number): MarkdownTheme {
    this.videoTheme.setVideoMargin({ bottom: videoMarginBottom })
    return this
  }

  /**
   * 设置视频发布/下载按钮布局是否显示
   *
   * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默认false不显示
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoBottomLayoutVisible
   * @return MarkdownTheme
   */
  setIsVideoBottomLayout(isVideoBottomLayout: boolean): MarkdownTheme {
    this.videoTheme.setVideoBottomLayoutVisible(isVideoBottomLayout)
    return this
  }

  /**
   * 设置视频发布按钮图片宽度和高度
   *
   * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonIconWidth
   *             videoTheme#setVideoReleaseButtonIconHeight
   * @return MarkdownTheme
   */
  setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: Length): MarkdownTheme {
    this.videoTheme.setVideoReleaseButtonIconWidth(videoReleaseImageWidthHeight)
    this.videoTheme.setVideoReleaseButtonIconHeight(videoReleaseImageWidthHeight)
    return this
  }

  /**
   * 设置视频发布按钮宽度
   *
   * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonWidth
   * @return MarkdownTheme
   */
  setVideoReleaseWidth(videoReleaseWidth: Length): MarkdownTheme {
    this.videoTheme.setVideoReleaseButtonWidth(videoReleaseWidth)
    return this
  }

  /**
   * 设置视频发布按钮高度
   *
   * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonHeight
   * @return MarkdownTheme
   */
  setVideoReleaseHeight(videoReleaseHeight: Length): MarkdownTheme {
    this.videoTheme.setVideoReleaseButtonHeight(videoReleaseHeight)
    return this
  }

  /**
   * 设置视频发布按钮圆角
   *
   * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonRadius
   * @return MarkdownTheme
   */
  setVideoReleaseRadius(videoReleaseRadius: number): MarkdownTheme {
    this.videoTheme.setVideoReleaseButtonRadius(videoReleaseRadius)
    return this
  }

  /**
   * 设置视频发布按钮文本内容
   *
   * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonText
   * @return MarkdownTheme
   */
  setVideoReleaseText(videoReleaseText: string): MarkdownTheme {
    this.videoTheme.setVideoReleaseButtonText(videoReleaseText)
    return this
  }

  /**
   * 设置视频发布按钮文本大小
   *
   * @param videoReleaseTextSize 视频发布按钮文本大小 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonTextFontSize
   * @return MarkdownTheme
   */
  setVideoReleaseTextSize(videoReleaseTextSize: number): MarkdownTheme {
    this.videoTheme.setVideoReleaseButtonTextFontSize(videoReleaseTextSize)
    return this
  }

  /**
   * 设置视频发布按钮文本颜色
   *
   * @param videoReleaseTextColor 视频发布按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonTextFontColor
   * @return MarkdownTheme
   */
  setVideoReleaseTextColor(videoReleaseTextColor: number): MarkdownTheme {
    this.videoTheme.setVideoReleaseButtonTextFontColor(videoReleaseTextColor)
    return this
  }

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoReleaseButtonBackgroundColor
   * @return MarkdownTheme
   */
  setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: number): MarkdownTheme {
    this.videoTheme.setVideoReleaseButtonBackgroundColor(videoReleaseBackgroundColor)
    return this
  }

  /**
   * 设置视频下载按钮图片宽度和高度
   *
   * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonIconWidth
   *             videoTheme#setVideoDownloadButtonIconHeight
   * @return MarkdownTheme
   */
  setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: Length): MarkdownTheme {
    this.videoTheme.setVideoDownloadButtonIconWidth(videoDownloadImageWidthHeight)
    this.videoTheme.setVideoDownloadButtonIconHeight(videoDownloadImageWidthHeight)
    return this
  }

  /**
   * 设置视频下载按钮宽度
   *
   * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonWidth
   * @return MarkdownTheme
   */
  setVideoDownloadWidth(videoDownloadWidth: Length): MarkdownTheme {
    this.videoTheme.setVideoDownloadButtonWidth(videoDownloadWidth)
    return this
  }

  /**
   * 设置视频下载按钮高度
   *
   * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonHeight
   * @return MarkdownTheme
   */
  setVideoDownloadHeight(videoDownloadHeight: Length): MarkdownTheme {
    this.videoTheme.setVideoDownloadButtonHeight(videoDownloadHeight)
    return this
  }

  /**
   * 设置视频下载按钮圆角
   *
   * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonRadius
   * @return MarkdownTheme
   */
  setVideoDownloadRadius(videoDownloadRadius: number): MarkdownTheme {
    this.videoTheme.setVideoDownloadButtonRadius(videoDownloadRadius)
    return this
  }

  /**
   * 设置视频下载按钮文本内容
   *
   * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonText
   * @return MarkdownTheme
   */
  setVideoDownloadText(videoDownloadText: string): MarkdownTheme {
    this.videoTheme.setVideoDownloadButtonText(videoDownloadText)
    return this
  }

  /**
   * 设置视频下载按钮文本大小
   *
   * @param videoDownloadTextSize 视频下载按钮文本大小 - 默认16.0vp
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonTextFontSize
   * @return MarkdownTheme
   */
  setVideoDownloadTextSize(videoDownloadTextSize: number): MarkdownTheme {
    this.videoTheme.setVideoDownloadButtonTextFontSize(videoDownloadTextSize)
    return this
  }

  /**
   * 设置视频下载按钮文本颜色
   *
   * @param videoDownloadTextColor 视频下载按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonTextFontColor
   * @return MarkdownTheme
   */
  setVideoDownloadTextColor(videoDownloadTextColor: number): MarkdownTheme {
    this.videoTheme.setVideoDownloadButtonTextFontColor(videoDownloadTextColor)
    return this
  }

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead VideoTheme#setVideoDownloadButtonBackgroundColor
   * @return MarkdownTheme
   */
  setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: number): MarkdownTheme {
    this.videoTheme.setVideoDownloadButtonBackgroundColor(videoDownloadBackgroundColor)
    return this
  }

  /**
   * 设置图片缩放类型
   *
   * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageFitType
   * @return MarkdownTheme
   */
  setImageFitType(imageFitType: ImageFit): MarkdownTheme {
    this.imageTheme.setImageFitType(imageFitType)
    return this
  }

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaximumWidth
   * @return MarkdownTheme
   */
  setImageMaximumWidth(imageMaximumWidth: number): MarkdownTheme {
    this.imageTheme.setImageMaximumWidth(imageMaximumWidth)
    return this
  }

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageFixedRatioWidth
   * @return MarkdownTheme
   */
  setImageFixedRatioWidth(imageFixedRatioWidth: number): MarkdownTheme {
    this.imageTheme.setImageFixedRatioWidth(imageFixedRatioWidth)
    return this
  }

  /**
   * 设置图片最大高度
   *
   * @param imageMaxHeight 图片最大高度 - 默认None
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaxHeight
   * @return MarkdownTheme
   */
  setImageMaxHeight(imageMaxHeight: number): MarkdownTheme {
    this.imageTheme.setImageMaxHeight(imageMaxHeight)
    return this
  }

  /**
   * 设置图片最大宽度
   *
   * @param imageMaxWidth 图片最大宽度 - 默认None
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMaxWidth
   * @return MarkdownTheme
   */
  setImageMaxWidth(imageMaxWidth: number): MarkdownTheme {
    this.imageTheme.setImageMaxWidth(imageMaxWidth)
    return this
  }

  /**
   * 设置图片圆角大小
   *
   * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderRadius
   * @return MarkdownTheme
   */
  setImageBorderRadius(imageBorderRadius: number): MarkdownTheme {
    this.imageTheme.setImageBorderRadius(imageBorderRadius)
    return this
  }

  /**
   * 设置图片边框宽度
   *
   * @param imageBorderWidth 图片边框宽度 - 默认0.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderWidth
   * @return MarkdownTheme
   */
  setImageBorderWidth(imageBorderWidth: Length): MarkdownTheme {
    this.imageTheme.setImageBorderWidth(imageBorderWidth)
    return this
  }

  /**
   * 设置图片边框颜色
   *
   * @param imageBorderColor 图片边框颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageBorderColor
   * @return MarkdownTheme
   */
  setImageBorderColor(imageBorderColor: number): MarkdownTheme {
    this.imageTheme.setImageBorderColor(imageBorderColor)
    return this
  }

  /**
   * 设置网络图片是否压缩
   *
   * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageAutoResize
   * @return MarkdownTheme
   */
  setIsAutoResize(isAutoResize: boolean): MarkdownTheme {
    this.imageTheme.setImageAutoResize(isAutoResize)
    return this
  }

  /**
   * 设置图片上边距
   *
   * @param imageMarginTop 图片上边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMargin
   * @return MarkdownTheme
   */
  setImageMarginTop(imageMarginTop: number): MarkdownTheme {
    this.imageTheme.setImageMargin({ top: imageMarginTop })
    return this
  }

  /**
   * 设置图片下边距
   *
   * @param imageMarginBottom 图片下边距 - 默认10.0vp
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageMargin
   * @return MarkdownTheme
   */
  setImageMarginBottom(imageMarginBottom: number): MarkdownTheme {
    this.imageTheme.setImageMargin({ bottom: imageMarginBottom })
    return this
  }

  /**
   * 设置图片是否有下载按钮
   *
   * @param isImageDownload 图片是否有下载按钮 - 默认false
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonVisible
   * @return MarkdownTheme
   */
  setIsImageDownload(isImageDownload: boolean): MarkdownTheme {
    this.imageTheme.setImageDownloadButtonVisible(isImageDownload)
    return this
  }

  /**
   * 设置是否图文混排
   *
   * @param isImageMixedLayout 是否图文混排 - 默认true
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setIsImageMixedLayout
   * @return MarkdownTheme
   */
  setIsImageMixedLayout(isImageMixedLayout: boolean): MarkdownTheme {
    this.imageTheme.setIsImageMixedLayout(isImageMixedLayout)
    return this
  }

  /**
   * 设置图片下载按钮图片宽度和高度
   *
   * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonIconWidth
   *             imageTheme#setImageDownloadButtonIconHeight
   * @return MarkdownTheme
   */
  setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: Length): MarkdownTheme {
    this.imageTheme.setImageDownloadButtonIconWidth(imageDownloadImageWidthHeight)
    this.imageTheme.setImageDownloadButtonIconHeight(imageDownloadImageWidthHeight)
    return this
  }

  /**
   * 设置图片下载按钮宽度
   *
   * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonWidth
   * @return MarkdownTheme
   */
  setImageDownloadWidth(imageDownloadWidth: Length): MarkdownTheme {
    this.imageTheme.setImageDownloadButtonWidth(imageDownloadWidth)
    return this
  }

  /**
   * 设置图片下载按钮高度
   *
   * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonHeight
   * @return MarkdownTheme
   */
  setImageDownloadHeight(imageDownloadHeight: Length): MarkdownTheme {
    this.imageTheme.setImageDownloadButtonHeight(imageDownloadHeight)
    return this
  }

  /**
   * 设置图片下载按钮圆角
   *
   * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonRadius
   * @return MarkdownTheme
   */
  setImageDownloadRadius(imageDownloadRadius: number): MarkdownTheme {
    this.imageTheme.setImageDownloadButtonRadius(imageDownloadRadius)
    return this
  }

  /**
   * 设置图片下载按钮文本内容
   *
   * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonText
   * @return MarkdownTheme
   */
  setImageDownloadText(imageDownloadText: string): MarkdownTheme {
    this.imageTheme.setImageDownloadButtonText(imageDownloadText)
    return this
  }

  /**
   * 设置图片下载按钮文本大小
   *
   * @param imageDownloadTextSize 图片下载按钮文本大小 - 默认16.0
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonTextFontSize
   * @return MarkdownTheme
   */
  setImageDownloadTextSize(imageDownloadTextSize: number): MarkdownTheme {
    this.imageTheme.setImageDownloadButtonTextFontSize(imageDownloadTextSize)
    return this
  }

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param imageDownloadTextColor 图片下载按钮文本颜色 - 默认0xE6000000
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonTextFontColor
   * @return MarkdownTheme
   */
  setImageDownloadTextColor(imageDownloadTextColor: number): MarkdownTheme {
    this.imageTheme.setImageDownloadButtonTextFontColor(imageDownloadTextColor)
    return this
  }

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0xFFF5F5F5
   * @deprecated since 1.4.0
   * @useinstead ImageTheme#setImageDownloadButtonBackgroundColor
   * @return MarkdownTheme
   */
  setImageDownloadBackgroundColor(imageDownloadBackgroundColor: number): MarkdownTheme {
    this.imageTheme.setImageDownloadButtonBackgroundColor(imageDownloadBackgroundColor)
    return this
  }

  /**
   * 设置表格内容内边距
   *
   * @param tableCellPadding 表格内容内边距 - 默认4.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableCellPadding
   * @return MarkdownTheme
   */
  setTableCellPadding(tableCellPadding: number): MarkdownTheme {
    this.tableTheme.setTableCellPadding(tableCellPadding)
    return this
  }

  /**
   * 设置表格边框颜色
   *
   * @param tableBorderColor 表格边框颜色 - 默认0xFF000000
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableBorderColor
   * @return MarkdownTheme
   */
  setTableBorderColor(tableBorderColor: number): MarkdownTheme {
    this.tableTheme.setTableBorderColor(tableBorderColor)
    return this
  }

  /**
   * 设置表格边框宽度
   *
   * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableBorderWidth
   * @return MarkdownTheme
   */
  setTableBorderWidth(tableBorderWidth: Length): MarkdownTheme {
    this.tableTheme.setTableBorderWidth(tableBorderWidth)
    return this
  }

  /**
   * 设置表格奇数行背景色
   *
   * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentOddRowBackgroundColor
   * @return MarkdownTheme
   */
  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): MarkdownTheme {
    this.tableTheme.setTableContentOddRowBackgroundColor(tableOddRowBackgroundColor)
    return this
  }

  /**
   * 设置表格偶数行背景色
   *
   * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0xFFE0E0E0
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentEvenRowBackgroundColor
   * @return MarkdownTheme
   */
  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): MarkdownTheme {
    this.tableTheme.setTableContentEvenRowBackgroundColor(tableEvenRowBackgroundColor)
    return this
  }

  /**
   * 设置表格标题背景色
   *
   * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认0xFFFFFFFF
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleBackgroundColor
   * @return MarkdownTheme
   */
  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): MarkdownTheme {
    this.tableTheme.setTableTitleBackgroundColor(tableHeaderRowBackgroundColor)
    return this
  }

  /**
   * 设置表格标题文本颜色
   *
   * @param tableTitleTextColor 表格标题文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextFontColor
   * @return MarkdownTheme
   */
  setTableTitleTextColor(tableTitleTextColor: number): MarkdownTheme {
    this.tableTheme.setTableTitleTextFontColor(tableTitleTextColor)
    return this
  }

  /**
   * 设置表格文本行高
   *
   * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextLineHeight
   *             tableTheme#setTableTitleTextLineHeight
   * @return MarkdownTheme
   */
  setTableTextLineHeight(tableTextLineHeight: number): MarkdownTheme {
    this.tableTheme.setTableContentTextLineHeight(tableTextLineHeight)
    this.tableTheme.setTableTitleTextLineHeight(tableTextLineHeight)
    return this
  }

  /**
   * 设置表格标题文本大小
   *
   * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextFontSize
   * @return MarkdownTheme
   */
  setTableTitleTextSize(tableTitleTextSize: number): MarkdownTheme {
    this.tableTheme.setTableTitleTextFontSize(tableTitleTextSize)
    return this
  }

  /**
   * 设置表格标题文本行高
   *
   * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableTitleTextLineHeight
   * @return MarkdownTheme
   */
  setTableTitleLineHeight(tableTitleLineHeight: number): MarkdownTheme {
    this.tableTheme.setTableTitleTextLineHeight(tableTitleLineHeight)
    return this
  }

  /**
   * 设置表格内容文本颜色
   *
   * @param tableContentTextColor 表格内容文本颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextFontColor
   * @return MarkdownTheme
   */
  setTableContentTextColor(tableContentTextColor: number): MarkdownTheme {
    this.tableTheme.setTableContentTextFontColor(tableContentTextColor)
    return this
  }

  /**
   * 设置表格内容文本大小
   *
   * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextFontSize
   * @return MarkdownTheme
   */
  setTableContentTextSize(tableContentTextSize: number): MarkdownTheme {
    this.tableTheme.setTableContentTextFontSize(tableContentTextSize)
    return this
  }

  /**
   * 设置表格内容文本行高
   *
   * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableContentTextLineHeight
   * @return MarkdownTheme
   */
  setTableContentTextLineHeight(tableTextLineHeight: number): MarkdownTheme {
    this.tableTheme.setTableContentTextLineHeight(tableTextLineHeight)
    return this
  }

  /**
   * 设置表格圆角
   *
   * @param tableRadius 表格圆角 - 默认5.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableRadius
   * @return MarkdownTheme
   */
  setTableRadius(tableRadius: number): MarkdownTheme {
    this.tableTheme.setTableRadius(tableRadius)
    return this
  }

  /**
   * 设置表格最小宽度
   *
   * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableMinCellWidth
   * @return MarkdownTheme
   */
  setTableMinTextWidth(tableMinTextWidth: Length): MarkdownTheme {
    this.tableTheme.setTableMinCellWidth(tableMinTextWidth)
    return this
  }

  /**
   * 设置表格最大宽度
   *
   * @param tableMaxTextWidth 表格最大宽度 - 默认300.0vp
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableMaxCellWidth
   * @return MarkdownTheme
   */
  setTableMaxTextWidth(tableMaxTextWidth: Length): MarkdownTheme {
    this.tableTheme.setTableMaxCellWidth(tableMaxTextWidth)
    return this
  }

  /**
   * 设置表格第一列是否加粗
   *
   * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableFirstColumnIsBold
   * @return MarkdownTheme
   */
  setTableFirstColumnBold(tableFirstColumnBold: boolean): MarkdownTheme {
    this.tableTheme.setTableFirstColumnIsBold(tableFirstColumnBold)
    return this
  }

  /**
   * 设置表格是否显示滚动条
   *
   * @param tableScrollBarShow 表格是否显示滚动条 - true：显示(auto状态)；false：不显示。默认false
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableScrollBarState
   * @return MarkdownTheme
   */
  setTableScrollBarShow(tableScrollBarShow: boolean): MarkdownTheme {
    if (tableScrollBarShow) {
      this.tableTheme.setTableScrollBarState(BarState.Auto)
    } else {
      this.tableTheme.setTableScrollBarState(BarState.Off)
    }
    return this
  }

  /**
   * 设置表格滚动条颜色
   *
   * @param tableScrollBarColor 表格滚动条颜色
   * @deprecated since 1.4.0
   * @useinstead TableTheme#setTableScrollBarColor
   * @return MarkdownTheme
   */
  setTableScrollBarColor(tableScrollBarColor: number): MarkdownTheme {
    this.tableTheme.setTableScrollBarColor(tableScrollBarColor)
    return this
  }

  /**
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIsDark
   * @return MarkdownTheme
   */
  setIsDark(isDark: boolean): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockIsDark(isDark)
    return this
  }

  /**
   * 设置删除线颜色
   *
   * @param strikethroughColor 删除线颜色 - 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead StrikethroughTheme#setStrikethroughTextDecorationColor
   * @return MarkdownTheme
   */
  setStrikethroughColor(strikethroughColor: number): MarkdownTheme {
    this.strikethroughTheme.setStrikethroughTextDecorationColor(strikethroughColor)
    return this
  }

  /**
   * 设置删除线样式
   *
   * @param strikethroughStyle 删除线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @deprecated since 1.4.0
   * @useinstead StrikethroughTheme#setStrikethroughTextDecorationStyle
   * @return MarkdownTheme
   */
  setStrikethroughStyle(strikethroughStyle: TextDecorationStyle): MarkdownTheme {
    this.strikethroughTheme.setStrikethroughTextDecorationStyle(strikethroughStyle)
    return this
  }

  /**
   * 设置定义列表术语和定义行之间间距
   *
   * @param descListTermAndDefMargins 定义列表术语和定义行之间间距 默认8.0
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListTermToDescriptionSpacing
   * @return MarkdownTheme
   */
  setDescListTermAndDefMargins(descListTermAndDefMargins: number): MarkdownTheme {
    this.definitionListTheme.setDefinitionListTermToDescriptionSpacing(descListTermAndDefMargins)
    return this
  }

  /**
   * 设置定义列表定义行缩进
   *
   * @param descListDefIndentation 定义列表定义行缩进 默认8.0
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListDescriptionIndent
   * @return MarkdownTheme
   */
  setDescListDefIndentation(descListDefIndentation: number): MarkdownTheme {
    this.definitionListTheme.setDefinitionListDescriptionIndent(descListDefIndentation)
    return this
  }

  /**
   * 设置定义列表定义行间距
   *
   * @param descListDefMargins 定义列表定义行间距 默认8.0
   * @deprecated since 1.4.0
   * @useinstead DefinitionListTheme#setDefinitionListDescriptionItemSpacing
   * @return MarkdownTheme
   */
  setDescListDefMargins(descListDefMargins: number): MarkdownTheme {
    this.definitionListTheme.setDefinitionListDescriptionItemSpacing(descListDefMargins)
    return this
  }

  /**
   * 设置下标字体颜色
   *
   * @param subTextColor 下标字体颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextFontColor
   * @return MarkdownTheme
   */
  setSubTextColor(subTextColor: number): MarkdownTheme {
    this.subTheme.setSubTextFontColor(subTextColor)
    return this
  }

  /**
   * 设置下标字体大小
   *
   * @param subTextSize 下标字体大小 默认8.0
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextFontSize
   * @return MarkdownTheme
   */
  setSubTextSize(subTextSize: number): MarkdownTheme {
    this.subTheme.setSubTextFontSize(subTextSize)
    return this
  }

  /**
   * 设置下标偏移距离
   *
   * @param subOffsetDist 下标偏移距离 默认0.0
   * @deprecated since 1.4.0
   * @useinstead SubTheme#setSubTextBaselineOffset
   * @return MarkdownTheme
   */
  setSubOffsetDist(subOffsetDist: number): MarkdownTheme {
    this.subTheme.setSubTextBaselineOffset(subOffsetDist)
    return this
  }

  /**
   * 设置上标字体颜色
   *
   * @param supTextColor 上标字体颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextFontColor
   * @return MarkdownTheme
   */
  setSupTextColor(supTextColor: number): MarkdownTheme {
    this.supTheme.setSupTextFontColor(supTextColor)
    return this
  }

  /**
   * 设置上标字体大小
   *
   * @param supTextSize 上标字体大小 默认8.0
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextFontSize
   * @return MarkdownTheme
   */
  setSupTextSize(supTextSize: number): MarkdownTheme {
    this.supTheme.setSupTextFontSize(supTextSize)
    return this
  }

  /**
   * 设置上标偏移距离
   *
   * @param supOffsetDist 上标偏移距离 默认6.0
   * @deprecated since 1.4.0
   * @useinstead SupTheme#setSupTextBaselineOffset
   * @return MarkdownTheme
   */
  setSupOffsetDist(supOffsetDist: number): MarkdownTheme {
    this.supTheme.setSupTextBaselineOffset(supOffsetDist)
    return this
  }

  /**
   * 设置下划线颜色
   *
   * @param underlineColor 下划线颜色 默认0xFF191919
   * @deprecated since 1.4.0
   * @useinstead HtmlUnderlineTheme#setHtmlUnderlineTextDecorationColor
   * @return MarkdownTheme
   */
  setUnderlineColor(underlineColor: number): MarkdownTheme {
    this.htmlUnderlineTheme.setHtmlUnderlineTextDecorationColor(underlineColor)
    return this
  }

  /**
   * 设置下划线样式
   *
   * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   * @deprecated since 1.4.0
   * @useinstead HtmlUnderlineTheme#setHtmlUnderlineTextDecorationStyle
   * @return MarkdownTheme
   */
  setUnderlineStyle(underlineStyle: TextDecorationStyle): MarkdownTheme {
    this.htmlUnderlineTheme.setHtmlUnderlineTextDecorationStyle(underlineStyle)
    return this
  }

  /**
   * 设置markdown是否支持滚动手势
   *
   * @param openGestureSwipe true-支持滚动手势，false-不支持滚动手势，默认false
   * @deprecated since 1.4.0
   * @useinstead GlobalTheme#setOpenGestureSwipe
   * @return MarkdownTheme
   */
  setOpenGestureSwipe(openGestureSwipe: boolean): MarkdownTheme {
    this.globalTheme.setOpenGestureSwipe(openGestureSwipe)
    return this
  }

  /**
   * 设置codeformat是否用制表符
   *
   * @param useTab true-使用，false-不使用，默认false
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockUseTab
   * @return MarkdownTheme
   */
  setUseTab(useTab: boolean): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockUseTab(useTab)
    return this
  }

  /**
   * 设置codeformat空格缩进数量
   *
   * @param indentWidth 空格缩进数量，默认4空格
   * @deprecated since 1.4.0
   * @useinstead CodeBlockTheme#setCodeBlockIndentWidth
   * @return MarkdownTheme
   */
  setIndentWidth(indentWidth: Length): MarkdownTheme {
    this.codeBlockTheme.setCodeBlockIndentWidth(indentWidth)
    return this
  }
}

/**
 * 通用外边距数组配置
 */
export interface MarkdownMarginArrayOptions {
  top?: Length[]
  right?: Length[]
  bottom?: Length[]
  left?: Length[]
}

/**
 * 通用内边距数组配置
 */
export interface MarkdownPaddingArrayOptions {
  top?: Length[]
  right?: Length[]
  bottom?: Length[]
  left?: Length[]
}
