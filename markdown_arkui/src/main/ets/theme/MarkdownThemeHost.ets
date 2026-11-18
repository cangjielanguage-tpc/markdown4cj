import { MarkdownTheme } from "./MarkdownTheme"
import { GlobalTheme } from "./GlobalTheme"
import { AudioTheme } from "./AudioTheme"
import { BannerTheme } from "./BannerTheme"
import { BlockQuoteTheme } from "./BlockQuoteTheme"
import { BoldTheme } from "./BoldTheme"
import { CodeBlockTheme } from "./CodeBlockTheme"
import { DefinitionListTheme } from "./DefinitionListTheme"
import { DividerTheme } from "./DividerTheme"
import { FootnoteDefTheme } from "./FootnoteDefTheme"
import { FootnoteRefTheme } from "./FootnoteRefTheme"
import { HeadingTheme } from "./HeadingTheme"
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
import { BulletListTheme } from "./BulletListTheme"
import { VideoTheme } from "./VideoTheme"
import { HighlightTheme } from "./HighlightTheme"

/**
 * Markdown 主题集中观察宿主
 *
 * 每个 Markdown 根组件只需挂载一个本组件（直接挂在根容器内，Observer 空 build 零布局
 * 占位），由它把
 * 聚合主题与 26 个子主题下发给 MarkdownThemeObserver 做集中观察，替代原先
 * 段落/标题/列表项各自持有的一整套子主题 @ObjectLink 订阅。
 *
 * 整个 MarkdownTheme 对象被替换时，本组件的聚合链接与 Observer 的 26 个子主题
 * 链接同步换绑，触发分类发布，段落/标题按新主题重新判定派生资源。
 */
@Component
export struct MarkdownThemeHost {
  @ObjectLink theme: MarkdownTheme // 聚合主题：整对象替换时经 build 下发新子主题

  build() {
    // 纯观察宿主：仅挂载 Observer（其 build 为空），不产生渲染节点与布局占位
    MarkdownThemeObserver({
      theme: this.theme,
      globalTheme: this.theme.globalTheme,
      audioTheme: this.theme.audioTheme,
      bannerTheme: this.theme.bannerTheme,
      blockQuoteTheme: this.theme.blockQuoteTheme,
      boldTheme: this.theme.boldTheme,
      codeBlockTheme: this.theme.codeBlockTheme,
      definitionListTheme: this.theme.definitionListTheme,
      dividerTheme: this.theme.dividerTheme,
      footnoteDefTheme: this.theme.footnoteDefTheme,
      footnoteRefTheme: this.theme.footnoteRefTheme,
      headingTheme: this.theme.headingTheme,
      htmlUnderlineTheme: this.theme.htmlUnderlineTheme,
      imageTheme: this.theme.imageTheme,
      inlineCodeTheme: this.theme.inlineCodeTheme,
      italicTheme: this.theme.italicTheme,
      latexMathTheme: this.theme.latexMathTheme,
      linkTheme: this.theme.linkTheme,
      orderedListTheme: this.theme.orderedListTheme,
      paragraphTheme: this.theme.paragraphTheme,
      strikethroughTheme: this.theme.strikethroughTheme,
      subTheme: this.theme.subTheme,
      supTheme: this.theme.supTheme,
      tableTheme: this.theme.tableTheme,
      bulletListTheme: this.theme.bulletListTheme,
      videoTheme: this.theme.videoTheme,
      highlightTheme: this.theme.highlightTheme
    })
  }
}

/**
 * Markdown 主题集中观察器
 *
 * 持有 26 个子主题 @ObjectLink 与 1 个聚合主题 @ObjectLink（共 27 个包装）。
 * 子主题 setter、公开字段修改以及子主题替换都走相应的 @Watch 观察链；
 * 用一个零延时任务合并同批变化，分别记录链接、公式、图片是否变化，
 * 再通过聚合对象的 notifyRenderChanged 递增分类代次、通知所有聚合链接。
 * 销毁时清掉待执行任务，避免已销毁组件再触碰聚合对象。
 */
@Component
export struct MarkdownThemeObserver {
  @ObjectLink theme: MarkdownTheme // 聚合主题（发布目标）
  @ObjectLink @Watch('onPlainThemeChanged') globalTheme: GlobalTheme
  @ObjectLink @Watch('onPlainThemeChanged') audioTheme: AudioTheme
  @ObjectLink @Watch('onPlainThemeChanged') bannerTheme: BannerTheme
  @ObjectLink @Watch('onPlainThemeChanged') blockQuoteTheme: BlockQuoteTheme
  @ObjectLink @Watch('onPlainThemeChanged') boldTheme: BoldTheme
  @ObjectLink @Watch('onPlainThemeChanged') codeBlockTheme: CodeBlockTheme
  @ObjectLink @Watch('onPlainThemeChanged') definitionListTheme: DefinitionListTheme
  @ObjectLink @Watch('onPlainThemeChanged') dividerTheme: DividerTheme
  @ObjectLink @Watch('onPlainThemeChanged') footnoteDefTheme: FootnoteDefTheme
  @ObjectLink @Watch('onPlainThemeChanged') footnoteRefTheme: FootnoteRefTheme
  @ObjectLink @Watch('onPlainThemeChanged') headingTheme: HeadingTheme
  @ObjectLink @Watch('onPlainThemeChanged') htmlUnderlineTheme: HtmlUnderlineTheme
  @ObjectLink @Watch('onImageThemeChanged') imageTheme: ImageTheme
  @ObjectLink @Watch('onPlainThemeChanged') inlineCodeTheme: InlineCodeTheme
  @ObjectLink @Watch('onPlainThemeChanged') italicTheme: ItalicTheme
  @ObjectLink @Watch('onLatexMathThemeChanged') latexMathTheme: LatexMathTheme
  @ObjectLink @Watch('onLinkThemeChanged') linkTheme: LinkTheme
  @ObjectLink @Watch('onPlainThemeChanged') orderedListTheme: OrderedListTheme
  @ObjectLink @Watch('onPlainThemeChanged') paragraphTheme: ParagraphTheme
  @ObjectLink @Watch('onPlainThemeChanged') strikethroughTheme: StrikethroughTheme
  @ObjectLink @Watch('onPlainThemeChanged') subTheme: SubTheme
  @ObjectLink @Watch('onPlainThemeChanged') supTheme: SupTheme
  @ObjectLink @Watch('onPlainThemeChanged') tableTheme: TableTheme
  @ObjectLink @Watch('onPlainThemeChanged') bulletListTheme: BulletListTheme
  @ObjectLink @Watch('onPlainThemeChanged') videoTheme: VideoTheme
  @ObjectLink @Watch('onPlainThemeChanged') highlightTheme: HighlightTheme
  private publishTimerId: number = -1 // 零延时合并任务 ID（-1 表示无待执行任务）
  private pendingLinkChanged: boolean = false // 本批待发布的链接类别标志
  private pendingLatexChanged: boolean = false // 本批待发布的公式类别标志
  private pendingImageChanged: boolean = false // 本批待发布的图片类别标志

  /**
   * 普通样式子主题变化：无派生资源需重建，合并发布一次 plain 代次，
   * 供依赖 renderPlainVersion 做全量刷新的场景使用。
   */
  onPlainThemeChanged(): void {
    this.schedulePublish(false, false, false)
  }

  /**
   * 链接图标样式变化：发布后段落/标题按 renderLinkVersion 重建图标像素图。
   */
  onLinkThemeChanged(): void {
    this.schedulePublish(true, false, false)
  }

  /**
   * 数学公式样式变化：发布后段落/标题按 renderLatexVersion 重载公式图片。
   */
  onLatexMathThemeChanged(): void {
    this.schedulePublish(false, true, false)
  }

  /**
   * 图片样式变化：发布后段落/标题按 renderImageVersion 重算图片显示尺寸。
   */
  onImageThemeChanged(): void {
    this.schedulePublish(false, false, true)
  }

  /**
   * 合并同批变化：已有待执行任务时只累积类别标志，否则起一个零延时任务，
   * 到点后按累积标志调用聚合对象的 notifyRenderChanged 递增分类代次。
   */
  private schedulePublish(linkChanged: boolean, latexChanged: boolean, imageChanged: boolean): void {
    if (linkChanged) {
      this.pendingLinkChanged = true
    }
    if (latexChanged) {
      this.pendingLatexChanged = true
    }
    if (imageChanged) {
      this.pendingImageChanged = true
    }
    if (this.publishTimerId !== -1) {
      return
    }
    this.publishTimerId = setTimeout(() => {
      this.publishTimerId = -1
      const linkChanged: boolean = this.pendingLinkChanged
      const latexChanged: boolean = this.pendingLatexChanged
      const imageChanged: boolean = this.pendingImageChanged
      this.pendingLinkChanged = false
      this.pendingLatexChanged = false
      this.pendingImageChanged = false
      this.theme.notifyRenderChanged(linkChanged, latexChanged, imageChanged)
    }, 0)
  }

  aboutToDisappear(): void {
    // 清掉待执行任务，避免已销毁组件再触碰聚合对象
    if (this.publishTimerId !== -1) {
      clearTimeout(this.publishTimerId)
      this.publishTimerId = -1
    }
  }

  build() {
    // 纯观察器：build 为空，不参与渲染与布局
  }
}
