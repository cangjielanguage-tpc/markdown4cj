import { NodeController, FrameNode } from '@kit.ArkUI'
import { requireCJLib } from 'libark_interop_loader.so'
import {
  CustomLib,
  CJMarkdownConfig,
  CJMarkdownTheme,
  CJMarkdownPlugin,
  CJMarkdownScroller,
  CJMarkdownAudioTheme,
  CJMarkdownBannerTheme,
  CJMarkdownBlockQuoteTheme,
  CJMarkdownBoldTheme,
  CJMarkdownBulletListTheme,
  CJMarkdownCodeBlockTheme,
  CJMarkdownDefinitionListTheme,
  CJMarkdownFootnoteDefTheme,
  CJMarkdownDividerTheme,
  CJMarkdownFootnoteRefTheme,
  CJMarkdownGlobalTheme,
  CJMarkdownHeadingTheme,
  CJMarkdownHtmlUnderlineTheme,
  CJMarkdownImageTheme,
  CJMarkdownInlineCodeTheme,
  CJMarkdownItalicTheme,
  CJMarkdownVideoTheme,
  CJMarkdownTableTheme,
  CJMarkdownSupTheme,
  CJMarkdownSubTheme,
  CJMarkdownStrikethroughTheme,
  CJMarkdownParagraphTheme,
  CJMarkdownOrderedListTheme,
  CJMarkdownLinkTheme,
  CJMarkdownLatexMathTheme,
  CJNodeViewStringBuilder
} from 'libark_interop_api_markdown.so'
import { MarkdownRectResult } from './MarkdownRectResult'
import { MarkdownPlugin } from './MarkdownPlugin'
import { MarkdownConfiguration } from './MarkdownConfiguration'
import { MarkdownThemeAudio } from './MarkdownThemeAudio'
import { MarkdownThemeBanner } from './MarkdownThemeBanner'
import { MarkdownThemeBlockQuote } from './MarkdownThemeBlockQuote'
import { MarkdownThemeBold } from './MarkdownThemeBold'
import { MarkdownThemeBulletList } from './MarkdownThemeBulletList'
import { MarkdownThemeCodeBlock } from './MarkdownThemeCodeBlock'
import { MarkdownThemeDefinitionList } from './MarkdownThemeDefinitionList'
import { MarkdownThemeFootnoteDef } from './MarkdownThemeFootnoteDef'
import { MarkdownThemeDivider } from './MarkdownThemeDivider'
import { MarkdownThemeFootnoteRef } from './MarkdownThemeFootnoteRef'
import { MarkdownThemeGlobal } from './MarkdownThemeGlobal'
import { MarkdownThemeHeading } from './MarkdownThemeHeading'
import { MarkdownThemeHtmlUnderline } from './MarkdownThemeHtmlUnderline'
import { MarkdownThemeImage } from './MarkdownThemeImage'
import { MarkdownThemeInlineCode } from './MarkdownThemeInlineCode'
import { MarkdownThemeItalic } from './MarkdownThemeItalic'
import { MarkdownThemeVideo } from './MarkdownThemeVideo'
import { MarkdownThemeTable } from './MarkdownThemeTable'
import { MarkdownThemeSup } from './MarkdownThemeSup'
import { MarkdownThemeSub } from './MarkdownThemeSub'
import { MarkdownThemeStrikethrough } from './MarkdownThemeStrikethrough'
import { MarkdownThemeParagraph } from './MarkdownThemeParagraph'
import { MarkdownThemeOrderedList } from './MarkdownThemeOrderedList'
import { MarkdownThemeLink } from './MarkdownThemeLink'
import { MarkdownThemeLatexMath } from './MarkdownThemeLatexMath'

export let global_customLib: CustomLib | undefined = undefined

class CJNodeController extends NodeController {
  rootNode?: FrameNode = undefined
  public callbackCJ: (input: string, isInputEnded: boolean, incrementalAnalysis: boolean) => void =
    (input: string, isInputEnded: boolean, incrementalAnalysis: boolean) => {
      this.mdStr = input
      this.isInputEnded = isInputEnded
      this.incrementalAnalysis = incrementalAnalysis
    } // 持续输出调用
  mdStr: string
  isInputEnded: boolean
  incrementalAnalysis: boolean
  config?: CJMarkdownConfig
  plugin?: CJMarkdownPlugin
  listScroller?: CJMarkdownScroller

  constructor(input: string, isInputEnded: boolean, incrementalAnalysis: boolean, config?: CJMarkdownConfig, plugin?: CJMarkdownPlugin, listScroller?: CJMarkdownScroller) {
    super()
    this.mdStr = input
    this.isInputEnded = isInputEnded
    this.incrementalAnalysis = incrementalAnalysis
    this.config = config
    this.plugin = plugin
    this.listScroller = listScroller
  }

  makeNode(ctx: UIContext): FrameNode | null {
    if (this.rootNode === undefined) {
      this.rootNode = new FrameNode(ctx)
      if (global_customLib !== undefined) {
        this.callbackCJ = global_customLib.getLoadCJPage(this.mdStr, this.isInputEnded, this.incrementalAnalysis, this.config, this.plugin, this.listScroller)
      }
    }
    return this.rootNode
  }
}

/**
 * 全局文本对象
 */
export class MarkdownNodeViewString {
  private cjNodeViewStringBuilder: CJNodeViewStringBuilder | undefined = undefined

  /**
   * 构造函数
   */
  constructor() {
    if (global_customLib === undefined) {
      global_customLib = requireCJLib("libmarkdown.so") as CustomLib
    }
    this.cjNodeViewStringBuilder = new global_customLib.CJNodeViewStringBuilder()
  }

  /**
   * 获取全局文本对象
   *
   * @returns 全局文本对象
   */
  getCJNodeViewStringBuilder(): CJNodeViewStringBuilder | undefined {
    return this.cjNodeViewStringBuilder
  }

  /**
   * 获取全局文本
   *
   * @returns 全局文本
   */
  toString(): string {
    if (this.cjNodeViewStringBuilder !== undefined) {
      return this.cjNodeViewStringBuilder.toString()
    } else {
      return ""
    }
  }
}

/**
 * Markdown滑动控制器
 */
export class MarkdownScroller {
  private scroller: CJMarkdownScroller | undefined = undefined

  /**
   * 构造函数
   */
  constructor() {
    if (global_customLib === undefined) {
      global_customLib = requireCJLib("libmarkdown.so") as CustomLib
    }
    this.scroller = new global_customLib.CJMarkdownScroller()
  }

  /**
   * 滚动到容器边缘
   *
   * @param edge 滚动到容器边缘
   */
  scrollEdge(edge: Edge): void {
    switch (edge) {
      case Edge.Top:
        this.scroller?.scrollEdge(1)
        break
      case Edge.Bottom:
        this.scroller?.scrollEdge(2)
        break
      default:
        this.scroller?.scrollEdge(1)
        break
    }
  }

  /**
   * 滚动指定距离
   *
   * @param xOffset x轴偏移量
   * @param yOffset y轴偏移量
   */
  scrollBy(xOffset: number, yOffset: number): void {
    this.scroller?.scrollBy(xOffset, yOffset)
  }

  /**
   * 滑动到指定Index
   *
   * @param index 要滑动到的目标元素在当前容器中的索引值
   */
  scrollToIndex(index: number): void {
    this.scroller?.scrollToIndex(index)
  }

  /**
   * 判断是否滚动到底部
   *
   * @returns 是否滚动到底部
   */
  isAtEnd(): boolean {
    return this.scroller?.isAtEnd() || false
  }

  /**
   * 获取当前y轴偏移量
   *
   * @returns 当前y轴偏移量
   */
  currentYOffset(): number {
    return this.scroller?.currentYOffset() || 0
  }

  /**
   * 获取子组件的大小及相对容器组件的位置
   *
   * @param index 索引值
   * @returns 子组件的大小和相对于组件的位置
   */
  getItemRect(index: number): MarkdownRectResult {
    if (global_customLib === undefined) {
      return new MarkdownRectResult(0, 0, 0, 0)
    }
    let rect = this.scroller?.getItemRect(index) || new global_customLib.CJRectResult(0, 0, 0, 0)
    return new MarkdownRectResult(rect.getItemRectX(), rect.getItemRectY(), rect.getItemRectWidth(), rect.getItemRectHeight())
  }

  /**
   * 获取内部CJMarkdownScroller实例
   *
   * @returns CJMarkdownScroller实例
   */
  getScroller(): CJMarkdownScroller | undefined {
    if (global_customLib === undefined) {
      return this.scroller
    }
    if (this.scroller === undefined) {
      this.scroller = new global_customLib.CJMarkdownScroller()
    }
    return this.scroller
  }
}

@Component
export struct CJMarkdown {
  /**
   * 外部传入的Markdown文档
   */
  @Prop @Watch('onMarkDownChange') content: string = ''
  /**
   * 流式输入是否输入结束。true:结束输入,false:持续输入。默认true
   */
  @Prop @Watch('onMarkDownChange') isInputEnded: boolean = true
  /**
   * markdown是否增量解析。true:增量解析,false:全量解析。默认false
   */
  @Prop @Watch('onMarkDownChange') incrementalAnalysis: boolean = false
  /**
   * markdown配置
   */
  @State config?: MarkdownConfiguration = undefined
  /**
   * markdown插件
   */
  @State plugin?: MarkdownPlugin = undefined
  /**
   * 滑动控制器
   */
  @State listScroller?: MarkdownScroller = undefined
  /**
   * 是否使用Cangjie互操作组件展示。true:使用Cangjie互操作组件,false:使用ArkUI。默认true
   */
  @Prop useCangjieComponent?: boolean = true
  /**
   * 使用ArkUI布局用户传入ArkUI自定义组件,不传则使用三方库自带的Text组件显示
   */
  @BuilderParam customContains: () => void = this.defaultTextBuilder
  private markdownNode: CJNodeController | null = null

  @Builder
  defaultTextBuilder() {
    if (!this.useCangjieComponent) {
      Column() {
        Text(this.content)
      }
      .width('100%')
      .height('100%')
    }
  }

  onMarkDownChange(): void {
    if (this.useCangjieComponent === true) {
      this.markdownNode?.callbackCJ(this.content, this.isInputEnded, this.incrementalAnalysis)
    }
  }

  aboutToAppear(): void {
    if (this.useCangjieComponent === true) {
      if (global_customLib === undefined) {
        global_customLib = requireCJLib("libmarkdown.so") as CustomLib
      }
      this.markdownNode = new CJNodeController(this.content, this.isInputEnded, this.incrementalAnalysis, this.getConfig(), this.getPlugin(), this.listScroller?.getScroller())
    } else {
      global_customLib = undefined
    }
  }

  build() {
    if (this.useCangjieComponent) {
      NodeContainer(this.markdownNode)
    } else {
      this.customContains()
    }
  }

  getConfig(): CJMarkdownConfig | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownConfig: CJMarkdownConfig = new global_customLib.CJMarkdownConfig()
    if (this.config !== undefined) {
      if (this.config.getLinkCallback() !== undefined) {
        cjMarkdownConfig.setLinkCallback(this.config.getLinkCallback())
      }
      if (this.config.getTextCopyCallback() !== undefined) {
        cjMarkdownConfig.setTextCopyCallback(this.config.getTextCopyCallback())
      }
      if (this.config.getImageCallback() !== undefined) {
        cjMarkdownConfig.setImageCallback(this.config.getImageCallback())
      }
      if (this.config.getImageCallbackCallback() !== undefined) {
        global_customLib.registerImgPreprocessCallback(this.config.getImageCallbackCallback())
      } else {
        global_customLib.registerImgPreprocessCallback(undefined)
      }
      if (this.config.getImageDownloadCallback() !== undefined) {
        cjMarkdownConfig.setImageDownloadCallback(this.config.getImageDownloadCallback())
      }
      if (this.config.getAudioCallback() !== undefined) {
        cjMarkdownConfig.setAudioCallback(this.config.getAudioCallback())
      }
      if (this.config.getVideoCallback() !== undefined) {
        cjMarkdownConfig.setVideoCallback(this.config.getVideoCallback())
      }
      if (this.config.getVideoImageCallback() !== undefined) {
        cjMarkdownConfig.setVideoImageCallback(this.config.getVideoImageCallback())
      }
      if (this.config.getVideoReleaseCallback() !== undefined) {
        cjMarkdownConfig.setVideoReleaseCallback(this.config.getVideoReleaseCallback())
      }
      if (this.config.getVideoDownloadCallback() !== undefined) {
        cjMarkdownConfig.setVideoDownloadCallback(this.config.getVideoDownloadCallback())
      }
      if (this.config.getCodeCopyCallback() !== undefined) {
        cjMarkdownConfig.setCodeCopyCallback(this.config.getCodeCopyCallback())
      }
      if (this.config.getCodeFullScreenCallback() !== undefined) {
        cjMarkdownConfig.setCodeFullScreenCallback(this.config.getCodeFullScreenCallback())
      }
      if (this.config.getLatexImageCallback() !== undefined) {
        cjMarkdownConfig.setLatexImageCallback(this.config.getLatexImageCallback())
      }
      if (this.config.getLatexStrCallback() !== undefined) {
        cjMarkdownConfig.setLatexStrCallback(this.config.getLatexStrCallback())
      }
      if (this.config.getTocIndexCallback() !== undefined) {
        cjMarkdownConfig.setTocIndexCallback(this.config.getTocIndexCallback())
      }
      if (this.config.getFootnoteCallback() !== undefined) {
        cjMarkdownConfig.setFootnoteCallback(this.config.getFootnoteCallback())
      }
      cjMarkdownConfig.setNodeString(this.config.getMarkdownNodeViewString().getCJNodeViewStringBuilder())
      cjMarkdownConfig.setCJMarkdownTheme(this.getTheme())
    }
    return cjMarkdownConfig
  }

  getPlugin(): CJMarkdownPlugin | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownPlugin: CJMarkdownPlugin = new global_customLib.CJMarkdownPlugin()
    if (this.plugin !== undefined) {
      cjMarkdownPlugin.setIsBlockAudioPlugin(this.plugin.getIsBlockAudioPlugin())
      cjMarkdownPlugin.setIsBlockVideoPlugin(this.plugin.getIsBlockVideoPlugin())
      cjMarkdownPlugin.setIsCodeListPlugin(this.plugin.getIsCodeListPlugin())
      cjMarkdownPlugin.setIsFootnotePlugin(this.plugin.getIsFootnotePlugin())
      cjMarkdownPlugin.setIsHtmlPlugin(this.plugin.getIsHtmlPlugin())
      cjMarkdownPlugin.setIsTablePlugin(this.plugin.getIsTablePlugin())
      cjMarkdownPlugin.setIsTocPlugin(this.plugin.getIsTocPlugin())
      cjMarkdownPlugin.setIsTaskListPlugin(this.plugin.getIsTaskListPlugin())
      cjMarkdownPlugin.setIsStrikethroughPlugin(this.plugin.getIsStrikethroughPlugin())
      cjMarkdownPlugin.setIsLinkifyPlugin(this.plugin.getIsLinkifyPlugin(), this.plugin.getRegs())
      cjMarkdownPlugin.setIsLinkViewPlugin(this.plugin.getIsLinkViewPlugin())
      cjMarkdownPlugin.setIsLatexMathPlugin(this.plugin.getIsLatexMathPlugin())
      cjMarkdownPlugin.setIsImageStylePlugin(this.plugin.getIsImageStylePlugin())
      cjMarkdownPlugin.setIsImageSlidePlugin(this.plugin.getIsImageSlidePlugin())
      cjMarkdownPlugin.setIsImageTextMixPlugin(this.plugin.getIsImageTextMixPlugin())
      cjMarkdownPlugin.setIsImageCollectPlugin(this.plugin.getIsImageCollectPlugin())
      cjMarkdownPlugin.setIsDescListPlugin(this.plugin.getIsDescListPlugin())
      cjMarkdownPlugin.setIsHeadIDPlugin(this.plugin.getIsHeadIDPlugin())
      cjMarkdownPlugin.setIsSubPlugin(this.plugin.getIsSubPlugin())
      cjMarkdownPlugin.setIsSupPlugin(this.plugin.getIsSupPlugin())
      cjMarkdownPlugin.setIsEmojiPlugin(this.plugin.getIsEmojiPlugin(), this.plugin.getIsEmojiLight())
    }
    return cjMarkdownPlugin
  }

  getTheme(): CJMarkdownTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme: CJMarkdownTheme = new global_customLib.CJMarkdownTheme()
    if (this.config !== undefined) {
      let markdownTheme = this.config.getMarkdownTheme()
      if (markdownTheme !== undefined) {
        if (markdownTheme.getMarkdownThemeGlobal().getStageContext() !== undefined) {
          global_customLib.setGlobalContext(markdownTheme.getMarkdownThemeGlobal().getStageContext())
        } else {
          global_customLib.setGlobalContext(undefined)
        }
        global_customLib.getCJResource(
          markdownTheme.getMarkdownThemeCodeBlock().getCodeBlockFullScreenIcon(),
          markdownTheme.getMarkdownThemeCodeBlock().getCodeBlockCopyIcon(),
          markdownTheme.getMarkdownThemeAudio().getAudioIcon(),
          markdownTheme.getMarkdownThemeVideo().getVideoPlaceholder(),
          markdownTheme.getMarkdownThemeVideo().getVideoPlayIcon(),
          markdownTheme.getMarkdownThemeBanner().getBannerPlaceholder(),
          markdownTheme.getMarkdownThemeImage().getImagePlaceholder(),
          markdownTheme.getMarkdownThemeVideo().getVideoReleaseButtonIcon(),
          markdownTheme.getMarkdownThemeVideo().getVideoDownloadButtonIcon(),
          markdownTheme.getMarkdownThemeImage().getImageDownloadButtonIcon()
        )
        cjMarkdownTheme.setCJMarkdownGlobalTheme(this.getGlobalTheme(markdownTheme.getMarkdownThemeGlobal()))
        cjMarkdownTheme.setCJMarkdownAudioTheme(this.getAudioTheme(markdownTheme.getMarkdownThemeAudio()))
        cjMarkdownTheme.setCJMarkdownBannerTheme(this.getBannerTheme(markdownTheme.getMarkdownThemeBanner()))
        cjMarkdownTheme.setCJMarkdownBlockQuoteTheme(this.getBlockQuoteTheme(markdownTheme.getMarkdownThemeBlockQuote()))
        cjMarkdownTheme.setCJMarkdownBoldTheme(this.getBoldTheme(markdownTheme.getMarkdownThemeBold()))
        cjMarkdownTheme.setCJMarkdownBulletListTheme(this.getBulletListTheme(markdownTheme.getMarkdownThemeBulletList()))
        cjMarkdownTheme.setCJMarkdownCodeBlockTheme(this.getCodeBlockTheme(markdownTheme.getMarkdownThemeCodeBlock()))
        cjMarkdownTheme.setCJMarkdownDefinitionListTheme(this.getDefinitionListTheme(markdownTheme.getMarkdownThemeDefinitionList()))
        cjMarkdownTheme.setCJMarkdownDividerTheme(this.getDividerTheme(markdownTheme.getMarkdownThemeDivider()))
        cjMarkdownTheme.setCJMarkdownFootnoteDefTheme(this.getFootnoteDefTheme(markdownTheme.getMarkdownThemeFootnoteDef()))
        cjMarkdownTheme.setCJMarkdownFootnoteRefTheme(this.getFootnoteRefTheme(markdownTheme.getMarkdownThemeFootnoteRef()))
        cjMarkdownTheme.setCJMarkdownHeadingTheme(this.getHeadingTheme(markdownTheme.getMarkdownThemeHeading()))
        cjMarkdownTheme.setCJMarkdownHtmlUnderlineTheme(this.getHtmlUnderlineTheme(markdownTheme.getMarkdownThemeHtmlUnderline()))
        cjMarkdownTheme.setCJMarkdownImageTheme(this.getImageTheme(markdownTheme.getMarkdownThemeImage()))
        cjMarkdownTheme.setCJMarkdownInlineCodeTheme(this.getInlineCodeTheme(markdownTheme.getMarkdownThemeInlineCode()))
        cjMarkdownTheme.setCJMarkdownItalicTheme(this.getItalicTheme(markdownTheme.getMarkdownThemeItalic()))
        cjMarkdownTheme.setCJMarkdownLatexMathTheme(this.getLatexMathTheme(markdownTheme.getMarkdownThemeLatexMath()))
        cjMarkdownTheme.setCJMarkdownLinkTheme(this.getLinkTheme(markdownTheme.getMarkdownThemeLink()))
        cjMarkdownTheme.setCJMarkdownOrderedListTheme(this.getOrderedListTheme(markdownTheme.getMarkdownThemeOrderedList()))
        cjMarkdownTheme.setCJMarkdownParagraphTheme(this.getParagraphTheme(markdownTheme.getMarkdownThemeParagraph()))
        cjMarkdownTheme.setCJMarkdownStrikethroughTheme(this.getStrikethroughTheme(markdownTheme.getMarkdownThemeStrikethrough()))
        cjMarkdownTheme.setCJMarkdownSubTheme(this.getSubTheme(markdownTheme.getMarkdownThemeSub()))
        cjMarkdownTheme.setCJMarkdownSupTheme(this.getSupTheme(markdownTheme.getMarkdownThemeSup()))
        cjMarkdownTheme.setCJMarkdownTableTheme(this.getTableTheme(markdownTheme.getMarkdownThemeTable()))
        cjMarkdownTheme.setCJMarkdownVideoTheme(this.getVideoTheme(markdownTheme.getMarkdownThemeVideo()))
      }
    }
    return cjMarkdownTheme
  }

  getAudioTheme(theme: MarkdownThemeAudio): CJMarkdownAudioTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownAudioTheme()
    if (theme.getAudioBackgroundColor() !== undefined) {
      cjMarkdownTheme.setAudioBackgroundColor(theme.getAudioBackgroundColor())
    }
    let audioMarginTop: number = theme.getAudioMarginTop() ?? 0
    let audioMarginRight: number = theme.getAudioMarginRight() ?? 0
    let audioMarginBottom: number = theme.getAudioMarginBottom() ?? 0
    let audioMarginLeft: number = theme.getAudioMarginLeft() ?? 0
    cjMarkdownTheme.setAudioMargin(audioMarginTop, audioMarginRight, audioMarginBottom, audioMarginLeft)

    let audioPaddingTop: number = theme.getAudioPaddingTop() ?? 12
    let audioPaddingRight: number = theme.getAudioPaddingRight() ?? 16
    let audioPaddingBottom: number = theme.getAudioPaddingBottom() ?? 12
    let audioPaddingLeft: number = theme.getAudioPaddingLeft() ?? 12
    cjMarkdownTheme.setAudioPadding(audioPaddingTop, audioPaddingRight, audioPaddingBottom, audioPaddingLeft)

    if (theme.getAudioBorderStyle() !== undefined) {
      cjMarkdownTheme.setAudioBorderStyle(theme.getAudioBorderStyle())
    }
    if (theme.getAudioBorderWidth() !== undefined) {
      cjMarkdownTheme.setAudioBorderWidth(theme.getAudioBorderWidth())
    }
    if (theme.getAudioBorderColor() !== undefined) {
      cjMarkdownTheme.setAudioBorderColor(theme.getAudioBorderColor())
    }
    let audioRadiusTopLeft: number = theme.getAudioRadiusTopLeft() ?? 12
    let audioRadiusTopRight: number = theme.getAudioRadiusTopRight() ?? 12
    let audioRadiusBottomLeft: number = theme.getAudioRadiusBottomLeft() ?? 12
    let audioRadiusBottomRight: number = theme.getAudioRadiusBottomRight() ?? 12
    cjMarkdownTheme.setAudioBorderRadius(audioRadiusTopLeft, audioRadiusTopRight, audioRadiusBottomLeft, audioRadiusBottomRight)

    if (theme.getAudioShadowRadius() !== undefined) {
      cjMarkdownTheme.setAudioShadowRadius(theme.getAudioShadowRadius())
    }
    if (theme.getAudioShadowColor() !== undefined) {
      cjMarkdownTheme.setAudioShadowColor(theme.getAudioShadowColor())
    }
    if (theme.getAudioShadowOffsetX() !== undefined) {
      cjMarkdownTheme.setAudioShadowOffsetX(theme.getAudioShadowOffsetX())
    }
    if (theme.getAudioShadowOffsetY() !== undefined) {
      cjMarkdownTheme.setAudioShadowOffsetY(theme.getAudioShadowOffsetY())
    }
    if (theme.getAudioButtonWidth() !== undefined) {
      cjMarkdownTheme.setAudioButtonWidth(theme.getAudioButtonWidth())
    }
    if (theme.getAudioButtonHeight() !== undefined) {
      cjMarkdownTheme.setAudioButtonHeight(theme.getAudioButtonHeight())
    }
    if (theme.getAudioButtonBackgroundColor() !== undefined) {
      cjMarkdownTheme.setAudioButtonBackgroundColor(theme.getAudioButtonBackgroundColor())
    }
    if (theme.getAudioButtonBorderStyle() !== undefined) {
      cjMarkdownTheme.setAudioButtonBorderStyle(theme.getAudioButtonBorderStyle())
    }
    if (theme.getAudioButtonBorderWidth() !== undefined) {
      cjMarkdownTheme.setAudioButtonBorderWidth(theme.getAudioButtonBorderWidth())
    }
    if (theme.getAudioButtonBorderColor() !== undefined) {
      cjMarkdownTheme.setAudioButtonBorderColor(theme.getAudioButtonBorderColor())
    }
    let audioButtonRadiusTopLeft: number = theme.getAudioButtonRadiusTopLeft() ?? 16
    let audioButtonRadiusTopRight: number = theme.getAudioButtonRadiusTopRight() ?? 16
    let audioButtonRadiusBottomLeft: number = theme.getAudioButtonRadiusBottomLeft() ?? 16
    let audioButtonRadiusBottomRight: number = theme.getAudioButtonRadiusBottomRight() ?? 16
    cjMarkdownTheme.setAudioButtonRadius(audioButtonRadiusTopLeft, audioButtonRadiusTopRight, audioButtonRadiusBottomLeft, audioButtonRadiusBottomRight)

    if (theme.getAudioButtonText() !== undefined) {
      cjMarkdownTheme.setAudioButtonText(theme.getAudioButtonText())
    }
    if (theme.getAudioButtonTextFontColor() !== undefined) {
      cjMarkdownTheme.setAudioButtonTextFontColor(theme.getAudioButtonTextFontColor())
    }
    if (theme.getAudioButtonTextFontSize() !== undefined) {
      cjMarkdownTheme.setAudioButtonTextFontSize(theme.getAudioButtonTextFontSize())
    }
    if (theme.getAudioButtonTextFontStyle() !== undefined) {
      cjMarkdownTheme.setAudioButtonTextFontStyle(theme.getAudioButtonTextFontStyle())
    }
    if (theme.getAudioButtonTextFontWeight() !== undefined) {
      cjMarkdownTheme.setAudioButtonTextFontWeight(this.convertFontWeight(theme.getAudioButtonTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getAudioButtonTextFontFamily() !== undefined) {
      cjMarkdownTheme.setAudioButtonTextFontFamily(theme.getAudioButtonTextFontFamily())
    }
    if (theme.getAudioButtonTextLineHeight() !== undefined) {
      cjMarkdownTheme.setAudioButtonTextLineHeight(theme.getAudioButtonTextLineHeight())
    }
    if (theme.getAudioIconWidth() !== undefined) {
      cjMarkdownTheme.setAudioIconWidth(theme.getAudioIconWidth())
    }
    if (theme.getAudioIconHeight() !== undefined) {
      cjMarkdownTheme.setAudioIconHeight(theme.getAudioIconHeight())
    }
    let audioIconRadiusTopLeft: number = theme.getAudioIconRadiusTopLeft() ?? 8
    let audioIconRadiusTopRight: number = theme.getAudioIconRadiusTopRight() ?? 8
    let audioIconRadiusBottomLeft: number = theme.getAudioIconRadiusBottomLeft() ?? 8
    let audioIconRadiusBottomRight: number = theme.getAudioIconRadiusBottomRight() ?? 8
    cjMarkdownTheme.setAudioIconRadius(audioIconRadiusTopLeft, audioIconRadiusTopRight, audioIconRadiusBottomLeft, audioIconRadiusBottomRight
    )
    if (theme.getAudioIconFitType() !== undefined) {
      cjMarkdownTheme.setAudioIconFitType(theme.getAudioIconFitType())
    }
    if (theme.getAudioTitleTextFontColor() !== undefined) {
      cjMarkdownTheme.setAudioTitleTextFontColor(theme.getAudioTitleTextFontColor())
    }
    if (theme.getAudioTitleTextFontSize() !== undefined) {
      cjMarkdownTheme.setAudioTitleTextFontSize(theme.getAudioTitleTextFontSize())
    }
    if (theme.getAudioTitleTextFontStyle() !== undefined) {
      cjMarkdownTheme.setAudioTitleTextFontStyle(theme.getAudioTitleTextFontStyle())
    }
    if (theme.getAudioTitleTextFontWeight() !== undefined) {
      cjMarkdownTheme.setAudioTitleTextFontWeight(this.convertFontWeight(theme.getAudioTitleTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getAudioTitleTextFontFamily() !== undefined) {
      cjMarkdownTheme.setAudioTitleTextFontFamily(theme.getAudioTitleTextFontFamily())
    }
    if (theme.getAudioTitleTextLineHeight() !== undefined) {
      cjMarkdownTheme.setAudioTitleTextLineHeight(theme.getAudioTitleTextLineHeight())
    }
    if (theme.getAudioTypeTextFontColor() !== undefined) {
      cjMarkdownTheme.setAudioTypeTextFontColor(theme.getAudioTypeTextFontColor())
    }
    if (theme.getAudioTypeTextFontSize() !== undefined) {
      cjMarkdownTheme.setAudioTypeTextFontSize(theme.getAudioTypeTextFontSize())
    }
    if (theme.getAudioTypeTextFontStyle() !== undefined) {
      cjMarkdownTheme.setAudioTypeTextFontStyle(theme.getAudioTypeTextFontStyle())
    }
    if (theme.getAudioTypeTextFontWeight() !== undefined) {
      cjMarkdownTheme.setAudioTypeTextFontWeight(this.convertFontWeight(theme.getAudioTypeTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getAudioTypeTextFontFamily() !== undefined) {
      cjMarkdownTheme.setAudioTypeTextFontFamily(theme.getAudioTypeTextFontFamily())
    }
    if (theme.getAudioTypeTextLineHeight() !== undefined) {
      cjMarkdownTheme.setAudioTypeTextLineHeight(theme.getAudioTypeTextLineHeight())
    }
    if (theme.getAudioTitleToTypeSpacing() !== undefined) {
      cjMarkdownTheme.setAudioTitleToTypeSpacing(theme.getAudioTitleToTypeSpacing())
    }
    return cjMarkdownTheme
  }

  getBannerTheme(theme: MarkdownThemeBanner): CJMarkdownBannerTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownBannerTheme()
    let bannerMarginTop: number = theme.getBannerMarginTop() ?? 0
    let bannerMarginRight: number = theme.getBannerMarginRight() ?? 0
    let bannerMarginBottom: number = theme.getBannerMarginBottom() ?? 0
    let bannerMarginLeft: number = theme.getBannerMarginLeft() ?? 0
    cjMarkdownTheme.setBannerMargin(bannerMarginTop, bannerMarginRight, bannerMarginBottom, bannerMarginLeft)

    let bannerPaddingTop: number = theme.getBannerPaddingTop() ?? 0
    let bannerPaddingRight: number = theme.getBannerPaddingRight() ?? 0
    let bannerPaddingBottom: number = theme.getBannerPaddingBottom() ?? 0
    let bannerPaddingLeft: number = theme.getBannerPaddingLeft() ?? 0
    cjMarkdownTheme.setBannerPadding(bannerPaddingTop, bannerPaddingRight, bannerPaddingBottom, bannerPaddingLeft)
    return cjMarkdownTheme
  }

  getBlockQuoteTheme(theme: MarkdownThemeBlockQuote): CJMarkdownBlockQuoteTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownBlockQuoteTheme()
    if (theme.getBlockQuoteBackgroundColor() !== undefined) {
      cjMarkdownTheme.setBlockQuoteBackgroundColor(theme.getBlockQuoteBackgroundColor())
    }
    let blockQuoteMarginTop: number = theme.getBlockQuoteMarginTop() ?? 0
    let blockQuoteMarginRight: number = theme.getBlockQuoteMarginRight() ?? 0
    let blockQuoteMarginBottom: number = theme.getBlockQuoteMarginBottom() ?? 0
    let blockQuoteMarginLeft: number = theme.getBlockQuoteMarginLeft() ?? 8
    cjMarkdownTheme.setBlockQuoteMargin(blockQuoteMarginTop, blockQuoteMarginRight, blockQuoteMarginBottom, blockQuoteMarginLeft)

    let blockQuotePaddingTop: number = theme.getBlockQuotePaddingTop() ?? 0
    let blockQuotePaddingRight: number = theme.getBlockQuotePaddingRight() ?? 0
    let blockQuotePaddingBottom: number = theme.getBlockQuotePaddingBottom() ?? 0
    let blockQuotePaddingLeft: number = theme.getBlockQuotePaddingLeft() ?? 0
    cjMarkdownTheme.setBlockQuotePadding(blockQuotePaddingTop, blockQuotePaddingRight, blockQuotePaddingBottom, blockQuotePaddingLeft)

    let blockQuoteRadiusTopLeft: number = theme.getBlockQuoteRadiusTopLeft() ?? 0
    let blockQuoteRadiusTopRight: number = theme.getBlockQuoteRadiusTopRight() ?? 0
    let blockQuoteRadiusBottomLeft: number = theme.getBlockQuoteRadiusBottomLeft() ?? 0
    let blockQuoteRadiusBottomRight: number = theme.getBlockQuoteRadiusBottomRight() ?? 0
    cjMarkdownTheme.setBlockQuoteRadius(blockQuoteRadiusTopLeft, blockQuoteRadiusTopRight, blockQuoteRadiusBottomLeft, blockQuoteRadiusBottomRight)
    if (theme.getBlockQuoteLeftBorderWidth() !== undefined) {
      cjMarkdownTheme.setBlockQuoteLeftBorderWidth(theme.getBlockQuoteLeftBorderWidth())
    }
    if (theme.getBlockQuoteLeftBorderColor() !== undefined) {
      cjMarkdownTheme.setBlockQuoteLeftBorderColor(theme.getBlockQuoteLeftBorderColor())
    }
    if (theme.getBlockQuoteBorderContentSpacing() !== undefined) {
      cjMarkdownTheme.setBlockQuoteBorderContentSpacing(theme.getBlockQuoteBorderContentSpacing())
    }
    if (theme.getBlockQuoteChildSpacing() !== undefined) {
      cjMarkdownTheme.setBlockQuoteChildSpacing(theme.getBlockQuoteChildSpacing())
    }
    return cjMarkdownTheme
  }

  getBoldTheme(theme: MarkdownThemeBold): CJMarkdownBoldTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownBoldTheme()
    if (theme.getBoldTextFontColor() !== undefined) {
      cjMarkdownTheme.setBoldTextFontColor(theme.getBoldTextFontColor())
    }
    if (theme.getBoldTextFontSize() !== undefined) {
      cjMarkdownTheme.setBoldTextFontSize(theme.getBoldTextFontSize())
    }
    if (theme.getBoldTextFontStyle() !== undefined) {
      cjMarkdownTheme.setBoldTextFontStyle(theme.getBoldTextFontStyle())
    }
    if (theme.getBoldTextFontWeight() !== undefined) {
      cjMarkdownTheme.setBoldTextFontWeight(this.convertFontWeight(theme.getBoldTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getBoldTextFontFamily() !== undefined) {
      cjMarkdownTheme.setBoldTextFontFamily(theme.getBoldTextFontFamily())
    }
    if (theme.getBoldTextLineHeight() !== undefined) {
      cjMarkdownTheme.setBoldTextLineHeight(theme.getBoldTextLineHeight())
    }
    if (theme.getBoldTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setBoldTextLetterSpacing(theme.getBoldTextLetterSpacing())
    }
    return cjMarkdownTheme
  }

  getBulletListTheme(theme: MarkdownThemeBulletList): CJMarkdownBulletListTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownBulletListTheme()
    if (theme.getBulletListBackgroundColor() !== undefined) {
      cjMarkdownTheme.setBulletListBackgroundColor(theme.getBulletListBackgroundColor())
    }
    let bulletListMarginTop: number = theme.getBulletListMarginTop() ?? 0
    let bulletListMarginRight: number = theme.getBulletListMarginRight() ?? 0
    let bulletListMarginBottom: number = theme.getBulletListMarginBottom() ?? 0
    let bulletListMarginLeft: number = theme.getBulletListMarginLeft() ?? 8
    cjMarkdownTheme.setBulletListMargin(bulletListMarginTop, bulletListMarginRight, bulletListMarginBottom, bulletListMarginLeft)

    let bulletListPaddingTop: number = theme.getBulletListPaddingTop() ?? 0
    let bulletListPaddingRight: number = theme.getBulletListPaddingRight() ?? 0
    let bulletListPaddingBottom: number = theme.getBulletListPaddingBottom() ?? 0
    let bulletListPaddingLeft: number = theme.getBulletListPaddingLeft() ?? 0
    cjMarkdownTheme.setBulletListPadding(bulletListPaddingTop, bulletListPaddingRight, bulletListPaddingBottom, bulletListPaddingLeft)
    if (theme.getBulletListChildSpacing() !== undefined) {
      cjMarkdownTheme.setBulletListChildSpacing(theme.getBulletListChildSpacing())
    }
    if (theme.getBulletListChildChildSpacing() !== undefined) {
      cjMarkdownTheme.setBulletListChildChildSpacing(theme.getBulletListChildChildSpacing())
    }
    if (theme.getBulletListBulletSpacing() !== undefined) {
      cjMarkdownTheme.setBulletListBulletSpacing(theme.getBulletListBulletSpacing())
    }
    if (theme.getBulletListBulletIsCircle() !== undefined) {
      cjMarkdownTheme.setBulletListBulletIsCircle(theme.getBulletListBulletIsCircle())
    }
    if (theme.getBulletListBulletTextFontColor() !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextFontColor(theme.getBulletListBulletTextFontColor())
    }
    if (theme.getBulletListBulletTextFontSize() !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextFontSize(theme.getBulletListBulletTextFontSize())
    }
    if (theme.getBulletListBulletTextFontStyle() !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextFontStyle(theme.getBulletListBulletTextFontStyle())
    }
    if (theme.getBulletListBulletTextFontWeight() !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextFontWeight(this.convertFontWeight(theme.getBulletListBulletTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getBulletListBulletTextFontFamily() !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextFontFamily(theme.getBulletListBulletTextFontFamily())
    }
    if (theme.getBulletListBulletTextLineHeight() !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextLineHeight(theme.getBulletListBulletTextLineHeight())
    }
    if (theme.getBulletListCheckboxSpacing() !== undefined) {
      cjMarkdownTheme.setBulletListCheckboxSpacing(theme.getBulletListCheckboxSpacing())
    }
    if (theme.getBulletListCheckboxWidth() !== undefined) {
      cjMarkdownTheme.setBulletListCheckboxWidth(theme.getBulletListCheckboxWidth())
    }
    if (theme.getBulletListCheckboxHeight() !== undefined) {
      cjMarkdownTheme.setBulletListCheckboxHeight(theme.getBulletListCheckboxHeight())
    }
    if (theme.getBulletListCheckboxSelectedColor() !== undefined) {
      cjMarkdownTheme.setBulletListCheckboxSelectedColor(theme.getBulletListCheckboxSelectedColor())
    }
    if (theme.getBulletListCheckboxShape() !== undefined) {
      cjMarkdownTheme.setBulletListCheckboxShape(theme.getBulletListCheckboxShape())
    }
    return cjMarkdownTheme
  }

  getCodeBlockTheme(theme: MarkdownThemeCodeBlock): CJMarkdownCodeBlockTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownCodeBlockTheme()
    if (theme.getCodeBlockIsCodeFormat() !== undefined) {
      cjMarkdownTheme.setCodeBlockIsCodeFormat(theme.getCodeBlockIsCodeFormat())
    }
    if (theme.getCodeBlockUseTab() !== undefined) {
      cjMarkdownTheme.setCodeBlockUseTab(theme.getCodeBlockUseTab())
    }
    if (theme.getCodeBlockIndentWidth() !== undefined) {
      cjMarkdownTheme.setCodeBlockIndentWidth(theme.getCodeBlockIndentWidth())
    }
    if (theme.getCodeBlockParserSync() !== undefined) {
      cjMarkdownTheme.setCodeBlockParserSync(theme.getCodeBlockParserSync())
    }
    if (theme.getCodeBlockBackgroundColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockBackgroundColor(theme.getCodeBlockBackgroundColor())
    }
    let codeBlockMarginTop: number = theme.getCodeBlockMarginTop() ?? 8
    let codeBlockMarginRight: number = theme.getCodeBlockMarginRight() ?? 0
    let codeBlockMarginBottom: number = theme.getCodeBlockMarginBottom() ?? 8
    let codeBlockMarginLeft: number = theme.getCodeBlockMarginLeft() ?? 0
    cjMarkdownTheme.setCodeBlockMargin(codeBlockMarginTop, codeBlockMarginRight, codeBlockMarginBottom, codeBlockMarginLeft)

    let codeBlockPaddingTop: number = theme.getCodeBlockPaddingTop() ?? 0
    let codeBlockPaddingRight: number = theme.getCodeBlockPaddingRight() ?? 8
    let codeBlockPaddingBottom: number = theme.getCodeBlockPaddingBottom() ?? 8
    let codeBlockPaddingLeft: number = theme.getCodeBlockPaddingLeft() ?? 0
    cjMarkdownTheme.setCodeBlockPadding(codeBlockPaddingTop, codeBlockPaddingRight, codeBlockPaddingBottom, codeBlockPaddingLeft)
    if (theme.getCodeBlockBorderStyle() !== undefined) {
      cjMarkdownTheme.setCodeBlockBorderStyle(theme.getCodeBlockBorderStyle())
    }
    if (theme.getCodeBlockBorderWidth() !== undefined) {
      cjMarkdownTheme.setCodeBlockBorderWidth(theme.getCodeBlockBorderWidth())
    }
    if (theme.getCodeBlockBorderColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockBorderColor(theme.getCodeBlockBorderColor())
    }
    let codeBlockRadiusTopLeft: number = theme.getCodeBlockRadiusTopLeft() ?? 8
    let codeBlockRadiusTopRight: number = theme.getCodeBlockRadiusTopRight() ?? 8
    let codeBlockRadiusBottomLeft: number = theme.getCodeBlockRadiusBottomLeft() ?? 8
    let codeBlockRadiusBottomRight: number = theme.getCodeBlockRadiusBottomRight() ?? 8
    cjMarkdownTheme.setCodeBlockRadius(codeBlockRadiusTopLeft, codeBlockRadiusTopRight, codeBlockRadiusBottomLeft, codeBlockRadiusBottomRight)
    if (theme.getCodeBlockTitleLayoutMarginBottom() !== undefined) {
      cjMarkdownTheme.setCodeBlockTitleLayoutMarginBottom(theme.getCodeBlockTitleLayoutMarginBottom())
    }
    if (theme.getCodeBlockTypeTextMarginLeft() !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextMarginLeft(theme.getCodeBlockTypeTextMarginLeft())
    }
    if (theme.getCodeBlockTypeText() !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeText(theme.getCodeBlockTypeText())
    }
    if (theme.getCodeBlockTypeTextFontColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextFontColor(theme.getCodeBlockTypeTextFontColor())
    }
    if (theme.getCodeBlockTypeTextFontSize() !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextFontSize(theme.getCodeBlockTypeTextFontSize())
    }
    if (theme.getCodeBlockTypeTextFontStyle() !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextFontStyle(theme.getCodeBlockTypeTextFontStyle())
    }
    if (theme.getCodeBlockTypeTextFontWeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextFontWeight(this.convertFontWeight(theme.getCodeBlockTypeTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getCodeBlockTypeTextFontFamily() !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextFontFamily(theme.getCodeBlockTypeTextFontFamily())
    }
    if (theme.getCodeBlockTypeTextLineHeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextLineHeight(theme.getCodeBlockTypeTextLineHeight())
    }
    if (theme.getCodeBlockCopyFullScreenSpacing() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyFullScreenSpacing(theme.getCodeBlockCopyFullScreenSpacing())
    }
    if (theme.getCodeBlockCopyButtonIsShow() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyButtonIsShow(theme.getCodeBlockCopyButtonIsShow())
    }
    if (theme.getCodeBlockCopyTextIsShow() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextIsShow(theme.getCodeBlockCopyTextIsShow())
    }
    if (theme.getCodeBlockCopyIconWidth() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyIconWidth(theme.getCodeBlockCopyIconWidth())
    }
    if (theme.getCodeBlockCopyIconHeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyIconHeight(theme.getCodeBlockCopyIconHeight())
    }
    if (theme.getCodeBlockCopyIconTextSpacing() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyIconTextSpacing(theme.getCodeBlockCopyIconTextSpacing())
    }
    if (theme.getCodeBlockCopyText() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyText(theme.getCodeBlockCopyText())
    }
    if (theme.getCodeBlockCopyTextFontColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextFontColor(theme.getCodeBlockCopyTextFontColor())
    }
    if (theme.getCodeBlockCopyTextFontSize() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextFontSize(theme.getCodeBlockCopyTextFontSize())
    }
    if (theme.getCodeBlockCopyTextFontStyle() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextFontStyle(theme.getCodeBlockCopyTextFontStyle())
    }
    if (theme.getCodeBlockCopyTextFontWeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextFontWeight(this.convertFontWeight(theme.getCodeBlockCopyTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getCodeBlockCopyTextFontFamily() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextFontFamily(theme.getCodeBlockCopyTextFontFamily())
    }
    if (theme.getCodeBlockCopyTextLineHeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextLineHeight(theme.getCodeBlockCopyTextLineHeight())
    }
    if (theme.getCodeBlockFullScreenButtonIsShow() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenButtonIsShow(theme.getCodeBlockFullScreenButtonIsShow())
    }
    if (theme.getCodeBlockFullScreenTextIsShow() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextIsShow(theme.getCodeBlockFullScreenTextIsShow())
    }
    if (theme.getCodeBlockFullScreenIconWidth() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenIconWidth(theme.getCodeBlockFullScreenIconWidth())
    }
    if (theme.getCodeBlockFullScreenIconHeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenIconHeight(theme.getCodeBlockFullScreenIconHeight())
    }
    if (theme.getCodeBlockFullScreenIconTextSpacing() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenIconTextSpacing(theme.getCodeBlockFullScreenIconTextSpacing())
    }
    if (theme.getCodeBlockFullScreenText() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenText(theme.getCodeBlockFullScreenText())
    }
    if (theme.getCodeBlockFullScreenTextFontColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextFontColor(theme.getCodeBlockFullScreenTextFontColor())
    }
    if (theme.getCodeBlockFullScreenTextFontSize() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextFontSize(theme.getCodeBlockFullScreenTextFontSize())
    }
    if (theme.getCodeBlockFullScreenTextFontStyle() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextFontStyle(theme.getCodeBlockFullScreenTextFontStyle())
    }
    if (theme.getCodeBlockFullScreenTextFontWeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextFontWeight(this.convertFontWeight(theme.getCodeBlockFullScreenTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getCodeBlockFullScreenTextFontFamily() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextFontFamily(theme.getCodeBlockFullScreenTextFontFamily())
    }
    if (theme.getCodeBlockFullScreenTextLineHeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextLineHeight(theme.getCodeBlockFullScreenTextLineHeight())
    }
    if (theme.getCodeBlockLineNumberIsShow() !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberIsShow(theme.getCodeBlockLineNumberIsShow())
    }
    if (theme.getCodeBlockLineNumberTextPaddingLeft() !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextPaddingLeft(theme.getCodeBlockLineNumberTextPaddingLeft())
    }
    if (theme.getCodeBlockLineNumberTextFontColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextFontColor(theme.getCodeBlockLineNumberTextFontColor())
    }
    if (theme.getCodeBlockLineNumberTextFontSize() !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextFontSize(theme.getCodeBlockLineNumberTextFontSize())
    }
    if (theme.getCodeBlockLineNumberTextFontStyle() !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextFontStyle(theme.getCodeBlockLineNumberTextFontStyle())
    }
    if (theme.getCodeBlockLineNumberTextFontWeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextFontWeight(this.convertFontWeight(theme.getCodeBlockLineNumberTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getCodeBlockLineNumberTextFontFamily() !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextFontFamily(theme.getCodeBlockLineNumberTextFontFamily())
    }
    if (theme.getCodeBlockLineNumberTextLineHeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextLineHeight(theme.getCodeBlockLineNumberTextLineHeight())
    }
    if (theme.getCodeBlockDividerColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockDividerColor(theme.getCodeBlockDividerColor())
    }
    if (theme.getCodeBlockDividerStrokeWidth() !== undefined) {
      cjMarkdownTheme.setCodeBlockDividerStrokeWidth(theme.getCodeBlockDividerStrokeWidth())
    }
    if (theme.getCodeBlockLineNumberDividerSpacing() !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberDividerSpacing(theme.getCodeBlockLineNumberDividerSpacing())
    }
    if (theme.getCodeBlockTextFontColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockTextFontColor(theme.getCodeBlockTextFontColor())
    }
    if (theme.getCodeBlockTextMarginRight() !== undefined) {
      cjMarkdownTheme.setCodeBlockTextMarginRight(theme.getCodeBlockTextMarginRight())
    }
    if (theme.getCodeBlockTextMarginLeft() !== undefined) {
      cjMarkdownTheme.setCodeBlockTextMarginLeft(theme.getCodeBlockTextMarginLeft())
    }
    if (theme.getCodeBlockTextFontSize() !== undefined) {
      cjMarkdownTheme.setCodeBlockTextFontSize(theme.getCodeBlockTextFontSize())
    }
    if (theme.getCodeBlockTextFontStyle() !== undefined) {
      cjMarkdownTheme.setCodeBlockTextFontStyle(theme.getCodeBlockTextFontStyle())
    }
    if (theme.getCodeBlockTextFontWeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockTextFontWeight(this.convertFontWeight(theme.getCodeBlockTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getCodeBlockTextFontFamily() !== undefined) {
      cjMarkdownTheme.setCodeBlockTextFontFamily(theme.getCodeBlockTextFontFamily())
    }
    if (theme.getCodeBlockTextLineHeight() !== undefined) {
      cjMarkdownTheme.setCodeBlockTextLineHeight(theme.getCodeBlockTextLineHeight())
    }
    if (theme.getCodeBlockTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setCodeBlockTextLetterSpacing(theme.getCodeBlockTextLetterSpacing())
    }
    if (theme.getCodeBlockListTitleTextSize() !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleTextSize(theme.getCodeBlockListTitleTextSize())
    }
    if (theme.getCodeBlockListTitleSelectTextSize() !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleSelectTextSize(theme.getCodeBlockListTitleSelectTextSize())
    }
    if (theme.getCodeBlockListTitleSelectTextColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleSelectTextColor(theme.getCodeBlockListTitleSelectTextColor())
    }
    if (theme.getCodeBlockListTitleUnselectTextColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleUnselectTextColor(theme.getCodeBlockListTitleUnselectTextColor())
    }
    if (theme.getCodeBlockListTitleSelectBackgroundColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleSelectBackgroundColor(theme.getCodeBlockListTitleSelectBackgroundColor())
    }
    if (theme.getCodeBlockListTitleUnselectBackgroundColor() !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleUnselectBackgroundColor(theme.getCodeBlockListTitleUnselectBackgroundColor())
    }
    if (theme.getCodeBlockIsSeparate() !== undefined) {
      cjMarkdownTheme.setCodeBlockIsSeparate(theme.getCodeBlockIsSeparate())
    }
    if (theme.getCodeBlockSeparateWidth() !== undefined) {
      cjMarkdownTheme.setCodeBlockSeparateWidth(theme.getCodeBlockSeparateWidth())
    }
    if (theme.getCodeBlockSeparateIsBottom() !== undefined) {
      cjMarkdownTheme.setCodeBlockSeparateIsBottom(theme.getCodeBlockSeparateIsBottom())
    }
    return cjMarkdownTheme
  }

  getDefinitionListTheme(theme: MarkdownThemeDefinitionList): CJMarkdownDefinitionListTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownDefinitionListTheme()
    if (theme.getDefinitionListBackgroundColor() !== undefined) {
      cjMarkdownTheme.setDefinitionListBackgroundColor(theme.getDefinitionListBackgroundColor())
    }
    let definitionListMarginTop: number = theme.getDefinitionListMarginTop() ?? 0
    let definitionListMarginRight: number = theme.getDefinitionListMarginRight() ?? 0
    let definitionListMarginBottom: number = theme.getDefinitionListMarginBottom() ?? 0
    let definitionListMarginLeft: number = theme.getDefinitionListMarginLeft() ?? 0
    cjMarkdownTheme.setDefinitionListMargin(definitionListMarginTop, definitionListMarginRight, definitionListMarginBottom, definitionListMarginLeft)

    let definitionListPaddingTop: number = theme.getDefinitionListPaddingTop() ?? 0
    let definitionListPaddingRight: number = theme.getDefinitionListPaddingRight() ?? 0
    let definitionListPaddingBottom: number = theme.getDefinitionListPaddingBottom() ?? 0
    let definitionListPaddingLeft: number = theme.getDefinitionListPaddingLeft() ?? 0
    cjMarkdownTheme.setDefinitionListPadding(definitionListPaddingTop, definitionListPaddingRight, definitionListPaddingBottom, definitionListPaddingLeft)
    if (theme.getDefinitionListTermToDescriptionSpacing() !== undefined) {
      cjMarkdownTheme.setDefinitionListTermToDescriptionSpacing(theme.getDefinitionListTermToDescriptionSpacing())
    }
    if (theme.getDefinitionListTermTextFontWeight() !== undefined) {
      cjMarkdownTheme.setDefinitionListTermTextFontWeight(this.convertFontWeight(theme.getDefinitionListTermTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getDefinitionListTermTextFontStyle() !== undefined) {
      cjMarkdownTheme.setDefinitionListTermTextFontStyle(theme.getDefinitionListTermTextFontStyle())
    }
    if (theme.getDefinitionListDescriptionItemSpacing() !== undefined) {
      cjMarkdownTheme.setDefinitionListDescriptionItemSpacing(theme.getDefinitionListDescriptionItemSpacing())
    }
    if (theme.getDefinitionListDescriptionIndent() !== undefined) {
      cjMarkdownTheme.setDefinitionListDescriptionIndent(theme.getDefinitionListDescriptionIndent())
    }
    return cjMarkdownTheme
  }

  getDividerTheme(theme: MarkdownThemeDivider): CJMarkdownDividerTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownDividerTheme()
    let dividerMarginTop: number = theme.getDividerMarginTop() ?? 0
    let dividerMarginRight: number = theme.getDividerMarginRight() ?? 0
    let dividerMarginBottom: number = theme.getDividerMarginBottom() ?? 0
    let dividerMarginLeft: number = theme.getDividerMarginLeft() ?? 0
    cjMarkdownTheme.setDividerMargin(dividerMarginTop, dividerMarginRight, dividerMarginBottom, dividerMarginLeft)

    let dividerPaddingTop: number = theme.getDividerPaddingTop() ?? 0
    let dividerPaddingRight: number = theme.getDividerPaddingRight() ?? 0
    let dividerPaddingBottom: number = theme.getDividerPaddingBottom() ?? 0
    let dividerPaddingLeft: number = theme.getDividerPaddingLeft() ?? 0
    cjMarkdownTheme.setDividerPadding(dividerPaddingTop, dividerPaddingRight, dividerPaddingBottom, dividerPaddingLeft)
    if (theme.getDividerColor() !== undefined) {
      cjMarkdownTheme.setDividerColor(theme.getDividerColor())
    }
    if (theme.getDividerStrokeWidth() !== undefined) {
      cjMarkdownTheme.setDividerStrokeWidth(theme.getDividerStrokeWidth())
    }
    if (theme.getDividerStyle() !== undefined) {
      cjMarkdownTheme.setDividerStyle(theme.getDividerStyle())
    }
    return cjMarkdownTheme
  }

  getFootnoteDefTheme(theme: MarkdownThemeFootnoteDef): CJMarkdownFootnoteDefTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownFootnoteDefTheme()
    if (theme.getFootnoteDefBackgroundColor() !== undefined) {
      cjMarkdownTheme.setFootnoteDefBackgroundColor(theme.getFootnoteDefBackgroundColor())
    }
    let footnoteDefMarginTop: number = theme.getFootnoteDefMarginTop() ?? 0
    let footnoteDefMarginRight: number = theme.getFootnoteDefMarginRight() ?? 0
    let footnoteDefMarginBottom: number = theme.getFootnoteDefMarginBottom() ?? 0
    let footnoteDefMarginLeft: number = theme.getFootnoteDefMarginLeft() ?? 0
    cjMarkdownTheme.setFootnoteDefMargin(footnoteDefMarginTop, footnoteDefMarginRight, footnoteDefMarginBottom, footnoteDefMarginLeft)

    let footnoteDefPaddingTop: number = theme.getFootnoteDefPaddingTop() ?? 0
    let footnoteDefPaddingRight: number = theme.getFootnoteDefPaddingRight() ?? 0
    let footnoteDefPaddingBottom: number = theme.getFootnoteDefPaddingBottom() ?? 0
    let footnoteDefPaddingLeft: number = theme.getFootnoteDefPaddingLeft() ?? 0
    cjMarkdownTheme.setFootnoteDefPadding(footnoteDefPaddingTop, footnoteDefPaddingRight, footnoteDefPaddingBottom, footnoteDefPaddingLeft)
    return cjMarkdownTheme
  }

  getFootnoteRefTheme(theme: MarkdownThemeFootnoteRef): CJMarkdownFootnoteRefTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownFootnoteRefTheme()
    if (theme.getFootnoteRefTextFontColor() !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextFontColor(theme.getFootnoteRefTextFontColor())
    }
    if (theme.getFootnoteRefTextFontSize() !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextFontSize(theme.getFootnoteRefTextFontSize())
    }
    if (theme.getFootnoteRefTextFontStyle() !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextFontStyle(theme.getFootnoteRefTextFontStyle())
    }
    if (theme.getFootnoteRefTextFontWeight() !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextFontWeight(this.convertFontWeight(theme.getFootnoteRefTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getFootnoteRefTextFontFamily() !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextFontFamily(theme.getFootnoteRefTextFontFamily())
    }
    if (theme.getFootnoteRefTextLineHeight() !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextLineHeight(theme.getFootnoteRefTextLineHeight())
    }
    if (theme.getFootnoteRefTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextLetterSpacing(theme.getFootnoteRefTextLetterSpacing())
    }
    if (theme.getFootnoteRefTextDecorationType() !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextDecorationType(theme.getFootnoteRefTextDecorationType())
    }
    if (theme.getFootnoteRefTextDecorationColor() !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextDecorationColor(theme.getFootnoteRefTextDecorationColor())
    }
    if (theme.getFootnoteRefTextDecorationStyle() !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextDecorationStyle(theme.getFootnoteRefTextDecorationStyle())
    }
    if (theme.getFootnoteRefTextBackgroundColor() !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextBackgroundColor(theme.getFootnoteRefTextBackgroundColor())
    }
    let footnoteRefTextBackgroundRadiusTopLeft: number = theme.getFootnoteRefTextBackgroundRadiusTopLeft() ?? 0
    let footnoteRefTextBackgroundRadiusTopRight: number = theme.getFootnoteRefTextBackgroundRadiusTopRight() ?? 0
    let footnoteRefTextBackgroundRadiusBottomLeft: number = theme.getFootnoteRefTextBackgroundRadiusBottomLeft() ?? 0
    let footnoteRefTextBackgroundRadiusBottomRight: number = theme.getFootnoteRefTextBackgroundRadiusBottomRight() ?? 0
    cjMarkdownTheme.setFootnoteRefTextBackgroundRadius(
      footnoteRefTextBackgroundRadiusTopLeft,
      footnoteRefTextBackgroundRadiusTopRight,
      footnoteRefTextBackgroundRadiusBottomLeft,
      footnoteRefTextBackgroundRadiusBottomRight
    )
    return cjMarkdownTheme
  }

  getGlobalTheme(theme: MarkdownThemeGlobal): CJMarkdownGlobalTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownGlobalTheme()
    if (theme.getIsMarkdownParserSync() !== undefined) {
      cjMarkdownTheme.setIsMarkdownParserSync(theme.getIsMarkdownParserSync())
    }
    if (theme.getIsOnCopy() !== undefined) {
      cjMarkdownTheme.setIsOnCopy(theme.getIsOnCopy())
    }
    if (theme.getBackgroundColor() !== undefined) {
      cjMarkdownTheme.setBackgroundColor(theme.getBackgroundColor())
    }
    let blockMarginTop: number = theme.getBlockMarginTop() ?? 0
    let blockMarginRight: number = theme.getBlockMarginRight() ?? 0
    let blockMarginBottom: number = theme.getBlockMarginBottom() ?? 0
    let blockMarginLeft: number = theme.getBlockMarginLeft() ?? 0
    cjMarkdownTheme.setGlobalMargin(blockMarginTop, blockMarginRight, blockMarginBottom, blockMarginLeft)
    if (theme.getMarkdownBlockSpacing() !== undefined) {
      cjMarkdownTheme.setBlockSpacing(theme.getMarkdownBlockSpacing())
    }
    if (theme.getIsLineBreak() !== undefined) {
      cjMarkdownTheme.setIsLineBreak(theme.getIsLineBreak())
    }
    if (theme.getOpenGestureSwipe() !== undefined) {
      cjMarkdownTheme.setOpenGestureSwipe(theme.getOpenGestureSwipe())
    }
    return cjMarkdownTheme
  }

  getHeadingTheme(theme: MarkdownThemeHeading): CJMarkdownHeadingTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownHeadingTheme()
    // H1
    if (theme.getHeading1BackgroundColor() !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(1, theme.getHeading1BackgroundColor())
    }
    let heading1MarginTop: number = theme.getHeading1MarginTop() ?? 0
    let heading1MarginRight: number = theme.getHeading1MarginRight() ?? 0
    let heading1MarginBottom: number = theme.getHeading1MarginBottom() ?? 0
    let heading1MarginLeft: number = theme.getHeading1MarginLeft() ?? 0
    cjMarkdownTheme.setMarginForDesignateHeading(1, heading1MarginTop, heading1MarginRight, heading1MarginBottom, heading1MarginLeft)

    let heading1PaddingTop: number = theme.getHeading1PaddingTop() ?? 0
    let heading1PaddingRight: number = theme.getHeading1PaddingRight() ?? 0
    let heading1PaddingBottom: number = theme.getHeading1PaddingBottom() ?? 0
    let heading1PaddingLeft: number = theme.getHeading1PaddingLeft() ?? 0
    cjMarkdownTheme.setPaddingForDesignateHeading(1, heading1PaddingTop, heading1PaddingRight, heading1PaddingBottom, heading1PaddingLeft)
    if (theme.getHeading1TextFontColor() !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(1, theme.getHeading1TextFontColor())
    }
    if (theme.getHeading1TextFontSize() !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(1, theme.getHeading1TextFontSize())
    }
    if (theme.getHeading1TextFontStyle() !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(1, theme.getHeading1TextFontStyle())
    }
    if (theme.getHeading1TextFontWeight() !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(1, theme.getHeading1TextFontWeight())
    }
    if (theme.getHeading1TextFontFamily() !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(1, theme.getHeading1TextFontFamily())
    }
    if (theme.getHeading1TextLineHeight() !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(1, theme.getHeading1TextLineHeight())
    }
    if (theme.getHeading1TextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(1, theme.getHeading1TextLetterSpacing())
    }
    if (theme.getHeading1UnderlineHeight() !== undefined) {
      cjMarkdownTheme.setUnderlineHeightForDesignateHeading(1, theme.getHeading1UnderlineHeight())
    }
    if (theme.getHeading1UnderlineColor() !== undefined) {
      cjMarkdownTheme.setUnderlineColorForDesignateHeading(1, theme.getHeading1UnderlineColor())
    }
    if (theme.getHeading1UnderlineSpacing() !== undefined) {
      cjMarkdownTheme.setUnderlineSpacingForDesignateHeading(1, theme.getHeading1UnderlineSpacing())
    }
    // H2
    if (theme.getHeading2BackgroundColor() !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(2, theme.getHeading2BackgroundColor())
    }
    let heading2MarginTop: number = theme.getHeading2MarginTop() ?? 0
    let heading2MarginRight: number = theme.getHeading2MarginRight() ?? 0
    let heading2MarginBottom: number = theme.getHeading2MarginBottom() ?? 0
    let heading2MarginLeft: number = theme.getHeading2MarginLeft() ?? 0
    cjMarkdownTheme.setMarginForDesignateHeading(2, heading2MarginTop, heading2MarginRight, heading2MarginBottom, heading2MarginLeft)

    let heading2PaddingTop: number = theme.getHeading2PaddingTop() ?? 0
    let heading2PaddingRight: number = theme.getHeading2PaddingRight() ?? 0
    let heading2PaddingBottom: number = theme.getHeading2PaddingBottom() ?? 0
    let heading2PaddingLeft: number = theme.getHeading2PaddingLeft() ?? 0
    cjMarkdownTheme.setPaddingForDesignateHeading(2, heading2PaddingTop, heading2PaddingRight, heading2PaddingBottom, heading2PaddingLeft)
    if (theme.getHeading2TextFontColor() !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(2, theme.getHeading2TextFontColor())
    }
    if (theme.getHeading2TextFontSize() !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(2, theme.getHeading2TextFontSize())
    }
    if (theme.getHeading2TextFontStyle() !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(2, theme.getHeading2TextFontStyle())
    }
    if (theme.getHeading2TextFontWeight() !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(2, theme.getHeading2TextFontWeight())
    }
    if (theme.getHeading2TextFontFamily() !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(2, theme.getHeading2TextFontFamily())
    }
    if (theme.getHeading2TextLineHeight() !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(2, theme.getHeading2TextLineHeight())
    }
    if (theme.getHeading2TextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(2, theme.getHeading2TextLetterSpacing())
    }
    if (theme.getHeading2UnderlineHeight() !== undefined) {
      cjMarkdownTheme.setUnderlineHeightForDesignateHeading(2, theme.getHeading2UnderlineHeight())
    }
    if (theme.getHeading2UnderlineColor() !== undefined) {
      cjMarkdownTheme.setUnderlineColorForDesignateHeading(2, theme.getHeading2UnderlineColor())
    }
    if (theme.getHeading2UnderlineSpacing() !== undefined) {
      cjMarkdownTheme.setUnderlineSpacingForDesignateHeading(2, theme.getHeading2UnderlineSpacing())
    }
    // H3
    if (theme.getHeading3BackgroundColor() !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(3, theme.getHeading3BackgroundColor())
    }
    let heading3MarginTop: number = theme.getHeading3MarginTop() ?? 0
    let heading3MarginRight: number = theme.getHeading3MarginRight() ?? 0
    let heading3MarginBottom: number = theme.getHeading3MarginBottom() ?? 0
    let heading3MarginLeft: number = theme.getHeading3MarginLeft() ?? 0
    cjMarkdownTheme.setMarginForDesignateHeading(3, heading3MarginTop, heading3MarginRight, heading3MarginBottom, heading3MarginLeft)

    let heading3PaddingTop: number = theme.getHeading3PaddingTop() ?? 0
    let heading3PaddingRight: number = theme.getHeading3PaddingRight() ?? 0
    let heading3PaddingBottom: number = theme.getHeading3PaddingBottom() ?? 0
    let heading3PaddingLeft: number = theme.getHeading3PaddingLeft() ?? 0
    cjMarkdownTheme.setPaddingForDesignateHeading(3, heading3PaddingTop, heading3PaddingRight, heading3PaddingBottom, heading3PaddingLeft)
    if (theme.getHeading3TextFontColor() !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(3, theme.getHeading3TextFontColor())
    }
    if (theme.getHeading3TextFontSize() !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(3, theme.getHeading3TextFontSize())
    }
    if (theme.getHeading3TextFontStyle() !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(3, theme.getHeading3TextFontStyle())
    }
    if (theme.getHeading3TextFontWeight() !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(3, theme.getHeading3TextFontWeight())
    }
    if (theme.getHeading3TextFontFamily() !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(3, theme.getHeading3TextFontFamily())
    }
    if (theme.getHeading3TextLineHeight() !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(3, theme.getHeading3TextLineHeight())
    }
    if (theme.getHeading3TextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(3, theme.getHeading3TextLetterSpacing())
    }
    // H4
    if (theme.getHeading4BackgroundColor() !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(4, theme.getHeading4BackgroundColor())
    }
    let heading4MarginTop: number = theme.getHeading4MarginTop() ?? 0
    let heading4MarginRight: number = theme.getHeading4MarginRight() ?? 0
    let heading4MarginBottom: number = theme.getHeading4MarginBottom() ?? 0
    let heading4MarginLeft: number = theme.getHeading4MarginLeft() ?? 0
    cjMarkdownTheme.setMarginForDesignateHeading(4, heading4MarginTop, heading4MarginRight, heading4MarginBottom, heading4MarginLeft)

    let heading4PaddingTop: number = theme.getHeading4PaddingTop() ?? 0
    let heading4PaddingRight: number = theme.getHeading4PaddingRight() ?? 0
    let heading4PaddingBottom: number = theme.getHeading4PaddingBottom() ?? 0
    let heading4PaddingLeft: number = theme.getHeading4PaddingLeft() ?? 0
    cjMarkdownTheme.setPaddingForDesignateHeading(4, heading4PaddingTop, heading4PaddingRight, heading4PaddingBottom, heading4PaddingLeft)
    if (theme.getHeading4TextFontColor() !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(4, theme.getHeading4TextFontColor())
    }
    if (theme.getHeading4TextFontSize() !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(4, theme.getHeading4TextFontSize())
    }
    if (theme.getHeading4TextFontStyle() !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(4, theme.getHeading4TextFontStyle())
    }
    if (theme.getHeading4TextFontWeight() !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(4, theme.getHeading4TextFontWeight())
    }
    if (theme.getHeading4TextFontFamily() !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(4, theme.getHeading4TextFontFamily())
    }
    if (theme.getHeading4TextLineHeight() !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(4, theme.getHeading4TextLineHeight())
    }
    if (theme.getHeading4TextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(4, theme.getHeading4TextLetterSpacing())
    }
    // H5
    if (theme.getHeading5BackgroundColor() !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(5, theme.getHeading5BackgroundColor())
    }
    let heading5MarginTop: number = theme.getHeading5MarginTop() ?? 0
    let heading5MarginRight: number = theme.getHeading5MarginRight() ?? 0
    let heading5MarginBottom: number = theme.getHeading5MarginBottom() ?? 0
    let heading5MarginLeft: number = theme.getHeading5MarginLeft() ?? 0
    cjMarkdownTheme.setMarginForDesignateHeading(5, heading5MarginTop, heading5MarginRight, heading5MarginBottom, heading5MarginLeft)

    let heading5PaddingTop: number = theme.getHeading5PaddingTop() ?? 0
    let heading5PaddingRight: number = theme.getHeading5PaddingRight() ?? 0
    let heading5PaddingBottom: number = theme.getHeading5PaddingBottom() ?? 0
    let heading5PaddingLeft: number = theme.getHeading5PaddingLeft() ?? 0
    cjMarkdownTheme.setPaddingForDesignateHeading(5, heading5PaddingTop, heading5PaddingRight, heading5PaddingBottom, heading5PaddingLeft)
    if (theme.getHeading5TextFontColor() !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(5, theme.getHeading5TextFontColor())
    }
    if (theme.getHeading5TextFontSize() !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(5, theme.getHeading5TextFontSize())
    }
    if (theme.getHeading5TextFontStyle() !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(5, theme.getHeading5TextFontStyle())
    }
    if (theme.getHeading5TextFontWeight() !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(5, theme.getHeading5TextFontWeight())
    }
    if (theme.getHeading5TextFontFamily() !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(5, theme.getHeading5TextFontFamily())
    }
    if (theme.getHeading5TextLineHeight() !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(5, theme.getHeading5TextLineHeight())
    }
    if (theme.getHeading5TextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(5, theme.getHeading5TextLetterSpacing())
    }
    // H6
    if (theme.getHeading6BackgroundColor() !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(6, theme.getHeading6BackgroundColor())
    }
    let heading6MarginTop: number = theme.getHeading6MarginTop() ?? 0
    let heading6MarginRight: number = theme.getHeading6MarginRight() ?? 0
    let heading6MarginBottom: number = theme.getHeading6MarginBottom() ?? 0
    let heading6MarginLeft: number = theme.getHeading6MarginLeft() ?? 0
    cjMarkdownTheme.setMarginForDesignateHeading(6, heading6MarginTop, heading6MarginRight, heading6MarginBottom, heading6MarginLeft)

    let heading6PaddingTop: number = theme.getHeading6PaddingTop() ?? 0
    let heading6PaddingRight: number = theme.getHeading6PaddingRight() ?? 0
    let heading6PaddingBottom: number = theme.getHeading6PaddingBottom() ?? 0
    let heading6PaddingLeft: number = theme.getHeading6PaddingLeft() ?? 0
    cjMarkdownTheme.setPaddingForDesignateHeading(6, heading6PaddingTop, heading6PaddingRight, heading6PaddingBottom, heading6PaddingLeft)
    if (theme.getHeading6TextFontColor() !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(6, theme.getHeading6TextFontColor())
    }
    if (theme.getHeading6TextFontSize() !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(6, theme.getHeading6TextFontSize())
    }
    if (theme.getHeading6TextFontStyle() !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(6, theme.getHeading6TextFontStyle())
    }
    if (theme.getHeading6TextFontWeight() !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(6, theme.getHeading6TextFontWeight())
    }
    if (theme.getHeading6TextFontFamily() !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(6, theme.getHeading6TextFontFamily())
    }
    if (theme.getHeading6TextLineHeight() !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(6, theme.getHeading6TextLineHeight())
    }
    if (theme.getHeading6TextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(6, theme.getHeading6TextLetterSpacing())
    }
    return cjMarkdownTheme
  }

  getHtmlUnderlineTheme(theme: MarkdownThemeHtmlUnderline): CJMarkdownHtmlUnderlineTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownHtmlUnderlineTheme()
    if (theme.getHtmlUnderlineTextFontColor() !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextFontColor(theme.getHtmlUnderlineTextFontColor())
    }
    if (theme.getHtmlUnderlineTextFontSize() !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextFontSize(theme.getHtmlUnderlineTextFontSize())
    }
    if (theme.getHtmlUnderlineTextFontStyle() !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextFontStyle(theme.getHtmlUnderlineTextFontStyle())
    }
    if (theme.getHtmlUnderlineTextFontWeight() !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextFontWeight(this.convertFontWeight(theme.getHtmlUnderlineTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getHtmlUnderlineTextFontFamily() !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextFontFamily(theme.getHtmlUnderlineTextFontFamily())
    }
    if (theme.getHtmlUnderlineTextLineHeight() !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextLineHeight(theme.getHtmlUnderlineTextLineHeight())
    }
    if (theme.getHtmlUnderlineTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextLetterSpacing(theme.getHtmlUnderlineTextLetterSpacing())
    }
    if (theme.getHtmlUnderlineTextDecorationColor() !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextDecorationColor(theme.getHtmlUnderlineTextDecorationColor())
    }
    if (theme.getHtmlUnderlineTextDecorationStyle() !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextDecorationStyle(theme.getHtmlUnderlineTextDecorationStyle())
    }
    return cjMarkdownTheme
  }

  getImageTheme(theme: MarkdownThemeImage): CJMarkdownImageTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownImageTheme()
    let imageMarginTop: number = theme.getImageMarginTop() ?? 0
    let imageMarginRight: number = theme.getImageMarginRight() ?? 0
    let imageMarginBottom: number = theme.getImageMarginBottom() ?? 0
    let imageMarginLeft: number = theme.getImageMarginLeft() ?? 0
    cjMarkdownTheme.setImageMargin(imageMarginTop, imageMarginRight, imageMarginBottom, imageMarginLeft)

    let imageRadiusTopLeft: number = theme.getImageRadiusTopLeft() ?? 0
    let imageRadiusTopRight: number = theme.getImageRadiusTopRight() ?? 0
    let imageRadiusBottomLeft: number = theme.getImageRadiusBottomLeft() ?? 0
    let imageRadiusBottomRight: number = theme.getImageRadiusBottomRight() ?? 0
    cjMarkdownTheme.setImageBorderRadius(imageRadiusTopLeft, imageRadiusTopRight, imageRadiusBottomLeft, imageRadiusBottomRight)
    if (theme.getImageBorderStyle() !== undefined) {
      cjMarkdownTheme.setImageBorderStyle(theme.getImageBorderStyle())
    }
    if (theme.getImageBorderWidth() !== undefined) {
      cjMarkdownTheme.setImageBorderWidth(theme.getImageBorderWidth())
    }
    if (theme.getImageBorderColor() !== undefined) {
      cjMarkdownTheme.setImageBorderColor(theme.getImageBorderColor())
    }
    if (theme.getImageAutoResize() !== undefined) {
      cjMarkdownTheme.setImageAutoResize(theme.getImageAutoResize())
    }
    if (theme.getIsImageMixedLayout() !== undefined) {
      cjMarkdownTheme.setIsImageMixedLayout(theme.getIsImageMixedLayout())
    }
    if (theme.getImageMaximumWidth() !== undefined) {
      cjMarkdownTheme.setImageMaximumWidth(theme.getImageMaximumWidth())
    }
    if (theme.getImageFixedRatioWidth() !== undefined) {
      cjMarkdownTheme.setImageFixedRatioWidth(theme.getImageFixedRatioWidth())
    }
    if (theme.getImageMaxHeight() !== undefined) {
      cjMarkdownTheme.setImageMaxHeight(theme.getImageMaxHeight())
    }
    if (theme.getImageHeight() !== undefined) {
      cjMarkdownTheme.setImageHeight(theme.getImageHeight())
    }
    if (theme.getImageMaxWidth() !== undefined) {
      cjMarkdownTheme.setImageMaxWidth(theme.getImageMaxWidth())
    }
    if (theme.getImageWidth() !== undefined) {
      cjMarkdownTheme.setImageWidth(theme.getImageWidth())
    }
    if (theme.getImageFitType() !== undefined) {
      cjMarkdownTheme.setImageFitType(theme.getImageFitType())
    }
    if (theme.getImageBottomLayoutMarginTop() !== undefined) {
      cjMarkdownTheme.setImageBottomLayoutMarginTop(theme.getImageBottomLayoutMarginTop())
    }
    if (theme.getImageDownloadButtonVisible() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonVisible(theme.getImageDownloadButtonVisible())
    }
    if (theme.getImageDownloadButtonWidth() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonWidth(theme.getImageDownloadButtonWidth())
    }
    if (theme.getImageDownloadButtonHeight() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonHeight(theme.getImageDownloadButtonHeight())
    }
    let imageDownloadButtonRadiusTopLeft: number = theme.getImageDownloadButtonRadiusTopLeft() ?? 22
    let imageDownloadButtonRadiusTopRight: number = theme.getImageDownloadButtonRadiusTopRight() ?? 22
    let imageDownloadButtonRadiusBottomLeft: number = theme.getImageDownloadButtonRadiusBottomLeft() ?? 22
    let imageDownloadButtonRadiusBottomRight: number = theme.getImageDownloadButtonRadiusBottomRight() ?? 22
    cjMarkdownTheme.setImageDownloadButtonRadius(
      imageDownloadButtonRadiusTopLeft,
      imageDownloadButtonRadiusTopRight,
      imageDownloadButtonRadiusBottomLeft,
      imageDownloadButtonRadiusBottomRight
    )
    if (theme.getImageDownloadButtonIconWidth() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonIconWidth(theme.getImageDownloadButtonIconWidth())
    }
    if (theme.getImageDownloadButtonIconHeight() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonIconHeight(theme.getImageDownloadButtonIconHeight())
    }
    if (theme.getImageDownloadButtonIconTextGap() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonIconTextGap(theme.getImageDownloadButtonIconTextGap())
    }
    if (theme.getImageDownloadButtonBackgroundColor() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonBackgroundColor(theme.getImageDownloadButtonBackgroundColor())
    }
    if (theme.getImageDownloadButtonText() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonText(theme.getImageDownloadButtonText())
    }
    if (theme.getImageDownloadButtonTextFontColor() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextFontColor(theme.getImageDownloadButtonTextFontColor())
    }
    if (theme.getImageDownloadButtonTextFontSize() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextFontSize(theme.getImageDownloadButtonTextFontSize())
    }
    if (theme.getImageDownloadButtonTextFontStyle() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextFontStyle(theme.getImageDownloadButtonTextFontStyle())
    }
    if (theme.getImageDownloadButtonTextFontWeight() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextFontWeight(this.convertFontWeight(theme.getImageDownloadButtonTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getImageDownloadButtonTextFontFamily() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextFontFamily(theme.getImageDownloadButtonTextFontFamily())
    }
    if (theme.getImageDownloadButtonTextLineHeight() !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextLineHeight(theme.getImageDownloadButtonTextLineHeight())
    }
    return cjMarkdownTheme
  }

  getInlineCodeTheme(theme: MarkdownThemeInlineCode): CJMarkdownInlineCodeTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownInlineCodeTheme()
    if (theme.getInlineCodeTextFontColor() !== undefined) {
      cjMarkdownTheme.setInlineCodeTextFontColor(theme.getInlineCodeTextFontColor())
    }
    if (theme.getInlineCodeTextFontSize() !== undefined) {
      cjMarkdownTheme.setInlineCodeTextFontSize(theme.getInlineCodeTextFontSize())
    }
    if (theme.getInlineCodeTextFontStyle() !== undefined) {
      cjMarkdownTheme.setInlineCodeTextFontStyle(theme.getInlineCodeTextFontStyle())
    }
    if (theme.getInlineCodeTextFontWeight() !== undefined) {
      cjMarkdownTheme.setInlineCodeTextFontWeight(this.convertFontWeight(theme.getInlineCodeTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getInlineCodeTextFontFamily() !== undefined) {
      cjMarkdownTheme.setInlineCodeTextFontFamily(theme.getInlineCodeTextFontFamily())
    }
    if (theme.getInlineCodeTextLineHeight() !== undefined) {
      cjMarkdownTheme.setInlineCodeTextLineHeight(theme.getInlineCodeTextLineHeight())
    }
    if (theme.getInlineCodeTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setInlineCodeTextLetterSpacing(theme.getInlineCodeTextLetterSpacing())
    }
    if (theme.getInlineCodeTextBackgroundColor() !== undefined) {
      cjMarkdownTheme.setInlineCodeTextBackgroundColor(theme.getInlineCodeTextBackgroundColor())
    }
    let inlineCodeTextBackgroundRadiusTopLeft: number = theme.getInlineCodeTextBackgroundRadiusTopLeft() ?? 0
    let inlineCodeTextBackgroundRadiusTopRight: number = theme.getInlineCodeTextBackgroundRadiusTopRight() ?? 0
    let inlineCodeTextBackgroundRadiusBottomLeft: number = theme.getInlineCodeTextBackgroundRadiusBottomLeft() ?? 0
    let inlineCodeTextBackgroundRadiusBottomRight: number = theme.getInlineCodeTextBackgroundRadiusBottomRight() ?? 0
    cjMarkdownTheme.setInlineCodeTextBackgroundRadius(
      inlineCodeTextBackgroundRadiusTopLeft,
      inlineCodeTextBackgroundRadiusTopRight,
      inlineCodeTextBackgroundRadiusBottomLeft,
      inlineCodeTextBackgroundRadiusBottomRight
    )
    return cjMarkdownTheme
  }

  getItalicTheme(theme: MarkdownThemeItalic): CJMarkdownItalicTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownItalicTheme()
    if (theme.getItalicTextFontColor() !== undefined) {
      cjMarkdownTheme.setItalicTextFontColor(theme.getItalicTextFontColor())
    }
    if (theme.getItalicTextFontSize() !== undefined) {
      cjMarkdownTheme.setItalicTextFontSize(theme.getItalicTextFontSize())
    }
    if (theme.getItalicTextFontWeight() !== undefined) {
      cjMarkdownTheme.setItalicTextFontWeight(this.convertFontWeight(theme.getItalicTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getItalicTextFontFamily() !== undefined) {
      cjMarkdownTheme.setItalicTextFontFamily(theme.getItalicTextFontFamily())
    }
    if (theme.getItalicTextLineHeight() !== undefined) {
      cjMarkdownTheme.setItalicTextLineHeight(theme.getItalicTextLineHeight())
    }
    if (theme.getItalicTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setItalicTextLetterSpacing(theme.getItalicTextLetterSpacing())
    }
    return cjMarkdownTheme
  }

  getLatexMathTheme(theme: MarkdownThemeLatexMath): CJMarkdownLatexMathTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownLatexMathTheme()
    let latexMathMarginTop: number = theme.getLatexMathMarginTop() ?? 0
    let latexMathMarginRight: number = theme.getLatexMathMarginRight() ?? 0
    let latexMathMarginBottom: number = theme.getLatexMathMarginBottom() ?? 0
    let latexMathMarginLeft: number = theme.getLatexMathMarginLeft() ?? 0
    cjMarkdownTheme.setLatexMathMargin(latexMathMarginTop, latexMathMarginRight, latexMathMarginBottom, latexMathMarginLeft)

    let latexMathPaddingTop: number = theme.getLatexMathPaddingTop() ?? 0
    let latexMathPaddingRight: number = theme.getLatexMathPaddingRight() ?? 0
    let latexMathPaddingBottom: number = theme.getLatexMathPaddingBottom() ?? 0
    let latexMathPaddingLeft: number = theme.getLatexMathPaddingLeft() ?? 0
    cjMarkdownTheme.setLatexMathPadding(latexMathPaddingTop, latexMathPaddingRight, latexMathPaddingBottom, latexMathPaddingLeft)
    if (theme.getLatexMathDefaultText() !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultText(theme.getLatexMathDefaultText())
    }
    if (theme.getLatexMathDefaultTextFontColor() !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultTextFontColor(theme.getLatexMathDefaultTextFontColor())
    }
    if (theme.getLatexMathDefaultTextFontSize() !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultTextFontSize(theme.getLatexMathDefaultTextFontSize())
    }
    if (theme.getLatexMathDefaultTextFontStyle() !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultTextFontStyle(theme.getLatexMathDefaultTextFontStyle())
    }
    if (theme.getLatexMathDefaultTextFontWeight() !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultTextFontWeight(this.convertFontWeight(theme.getLatexMathDefaultTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getLatexMathDefaultTextFontFamily() !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultTextFontFamily(theme.getLatexMathDefaultTextFontFamily())
    }
    if (theme.getLatexMathTextSize() !== undefined) {
      cjMarkdownTheme.setLatexMathTextSize(theme.getLatexMathTextSize())
    }
    if (theme.getLatexMathBackgroundColor() !== undefined) {
      cjMarkdownTheme.setLatexMathBackgroundColor(theme.getLatexMathBackgroundColor())
    }
    if (theme.getLatexMathTextColor() !== undefined) {
      cjMarkdownTheme.setLatexMathTextColor(theme.getLatexMathTextColor())
    }
    if (theme.getLatexMathColorFormat() !== undefined) {
      cjMarkdownTheme.setLatexMathColorFormat(theme.getLatexMathColorFormat())
    }
    if (theme.getLatexMathBlockCenter() !== undefined) {
      cjMarkdownTheme.setLatexMathBlockCenter(theme.getLatexMathBlockCenter())
    }
    if (theme.getLatexMathResPath() !== undefined) {
      cjMarkdownTheme.setLatexMathResPath(theme.getLatexMathResPath())
    }
    return cjMarkdownTheme
  }

  getLinkTheme(theme: MarkdownThemeLink): CJMarkdownLinkTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownLinkTheme()
    if (theme.getLinkIsIcon() !== undefined) {
      cjMarkdownTheme.setLinkIsIcon(theme.getLinkIsIcon())
    }
    if (theme.getLinkListIsIcon() !== undefined) {
      cjMarkdownTheme.setLinkListIsIcon(theme.getLinkListIsIcon())
    }
    if (theme.getLinkTextFontColor() !== undefined) {
      cjMarkdownTheme.setLinkTextFontColor(theme.getLinkTextFontColor())
    }
    if (theme.getLinkTextFontSize() !== undefined) {
      cjMarkdownTheme.setLinkTextFontSize(theme.getLinkTextFontSize())
    }
    if (theme.getLinkTextFontStyle() !== undefined) {
      cjMarkdownTheme.setLinkTextFontStyle(theme.getLinkTextFontStyle())
    }
    if (theme.getLinkTextFontWeight() !== undefined) {
      cjMarkdownTheme.setLinkTextFontWeight(this.convertFontWeight(theme.getLinkTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getLinkTextFontFamily() !== undefined) {
      cjMarkdownTheme.setLinkTextFontFamily(theme.getLinkTextFontFamily())
    }
    if (theme.getLinkTextLineHeight() !== undefined) {
      cjMarkdownTheme.setLinkTextLineHeight(theme.getLinkTextLineHeight())
    }
    if (theme.getLinkTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setLinkTextLetterSpacing(theme.getLinkTextLetterSpacing())
    }
    if (theme.getLinkTextDecorationType() !== undefined) {
      cjMarkdownTheme.setLinkTextDecorationType(theme.getLinkTextDecorationType())
    }
    if (theme.getLinkTextDecorationColor() !== undefined) {
      cjMarkdownTheme.setLinkTextDecorationColor(theme.getLinkTextDecorationColor())
    }
    if (theme.getLinkTextDecorationStyle() !== undefined) {
      cjMarkdownTheme.setLinkTextDecorationStyle(theme.getLinkTextDecorationStyle())
    }
    if (theme.getLinkTextBackgroundColor() !== undefined) {
      cjMarkdownTheme.setLinkTextBackgroundColor(theme.getLinkTextBackgroundColor())
    }
    let linkTextBackgroundRadiusTopLeft: number = theme.getLinkTextBackgroundRadiusTopLeft() ?? 0
    let linkTextBackgroundRadiusTopRight: number = theme.getLinkTextBackgroundRadiusTopRight() ?? 0
    let linkTextBackgroundRadiusBottomLeft: number = theme.getLinkTextBackgroundRadiusBottomLeft() ?? 0
    let linkTextBackgroundRadiusBottomRight: number = theme.getLinkTextBackgroundRadiusBottomRight() ?? 0
    cjMarkdownTheme.setLinkTextBackgroundRadius(
      linkTextBackgroundRadiusTopLeft,
      linkTextBackgroundRadiusTopRight,
      linkTextBackgroundRadiusBottomLeft,
      linkTextBackgroundRadiusBottomRight
    )
    if (theme.getLinkCircleIconBackgroundColor() !== undefined) {
      cjMarkdownTheme.setLinkCircleIconBackgroundColor(theme.getLinkCircleIconBackgroundColor())
    }
    if (theme.getLinkCircleIconButtonBackgroundColor() !== undefined) {
      cjMarkdownTheme.setLinkCircleIconButtonBackgroundColor(theme.getLinkCircleIconButtonBackgroundColor())
    }
    if (theme.getLinkCircleIconTextSize() !== undefined) {
      cjMarkdownTheme.setLinkCircleIconTextSize(theme.getLinkCircleIconTextSize())
    }
    if (theme.getLinkCircleIconTextColor() !== undefined) {
      cjMarkdownTheme.setLinkCircleIconTextColor(theme.getLinkCircleIconTextColor())
    }
    if (theme.getLinkCircleIconRadius() !== undefined) {
      cjMarkdownTheme.setLinkCircleIconRadius(theme.getLinkCircleIconRadius())
    }
    if (theme.getLinkCircleIconMargin() !== undefined) {
      cjMarkdownTheme.setLinkCircleIconMargin(theme.getLinkCircleIconMargin())
    }
    if (theme.getLinkRectIconBackgroundColor() !== undefined) {
      cjMarkdownTheme.setLinkRectIconBackgroundColor(theme.getLinkRectIconBackgroundColor())
    }
    if (theme.getLinkRectIconButtonBackgroundColor() !== undefined) {
      cjMarkdownTheme.setLinkRectIconButtonBackgroundColor(theme.getLinkRectIconButtonBackgroundColor())
    }
    if (theme.getLinkRectIconTextSize() !== undefined) {
      cjMarkdownTheme.setLinkRectIconTextSize(theme.getLinkRectIconTextSize())
    }
    if (theme.getLinkRectIconTextColor() !== undefined) {
      cjMarkdownTheme.setLinkRectIconTextColor(theme.getLinkRectIconTextColor())
    }
    if (theme.getLinkRectIconHeight() !== undefined) {
      cjMarkdownTheme.setLinkRectIconHeight(theme.getLinkRectIconHeight())
    }
    if (theme.getLinkRectIconPadding() !== undefined) {
      cjMarkdownTheme.setLinkRectIconPadding(theme.getLinkRectIconPadding())
    }
    if (theme.getLinkRectIconRadius() !== undefined) {
      cjMarkdownTheme.setLinkRectIconRadius(theme.getLinkRectIconRadius())
    }
    if (theme.getLinkRectIconMargin() !== undefined) {
      cjMarkdownTheme.setLinkRectIconMargin(theme.getLinkRectIconMargin())
    }
    if (theme.getLinkRectToolIconBackgroundColor() !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconBackgroundColor(theme.getLinkRectToolIconBackgroundColor())
    }
    if (theme.getLinkRectToolIconButtonBackgroundColor() !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconButtonBackgroundColor(theme.getLinkRectToolIconButtonBackgroundColor())
    }
    if (theme.getLinkRectToolIconTextSize() !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconTextSize(theme.getLinkRectToolIconTextSize())
    }
    if (theme.getLinkRectToolIconHeight() !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconHeight(theme.getLinkRectToolIconHeight())
    }
    if (theme.getLinkRectToolIconPadding() !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconPadding(theme.getLinkRectToolIconPadding())
    }
    if (theme.getLinkRectToolIconBorderWidth() !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconBorderWidth(theme.getLinkRectToolIconBorderWidth())
    }
    if (theme.getLinkRectToolIconDividingLineWidth() !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconDividingLineWidth(theme.getLinkRectToolIconDividingLineWidth())
    }
    if (theme.getLinkRectToolIconMargin() !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconMargin(theme.getLinkRectToolIconMargin())
    }
    if (theme.getLinkRectToolIconLineLeftPadding() !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconLineLeftPadding(theme.getLinkRectToolIconLineLeftPadding())
    }
    if (theme.getLinkRectToolIconLineRightPadding() !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconLineRightPadding(theme.getLinkRectToolIconLineRightPadding())
    }
    return cjMarkdownTheme
  }

  getOrderedListTheme(theme: MarkdownThemeOrderedList): CJMarkdownOrderedListTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownOrderedListTheme()
    if (theme.getOrderedListBackgroundColor() !== undefined) {
      cjMarkdownTheme.setOrderedListBackgroundColor(theme.getOrderedListBackgroundColor())
    }
    let orderedListMarginTop: number = theme.getOrderedListMarginTop() ?? 0
    let orderedListMarginRight: number = theme.getOrderedListMarginRight() ?? 0
    let orderedListMarginBottom: number = theme.getOrderedListMarginBottom() ?? 0
    let orderedListMarginLeft: number = theme.getOrderedListMarginLeft() ?? 8
    cjMarkdownTheme.setOrderedListMargin(
      orderedListMarginTop,
      orderedListMarginRight,
      orderedListMarginBottom,
      orderedListMarginLeft
    )
    let orderedListPaddingTop: number = theme.getOrderedListPaddingTop() ?? 0
    let orderedListPaddingRight: number = theme.getOrderedListPaddingRight() ?? 0
    let orderedListPaddingBottom: number = theme.getOrderedListPaddingBottom() ?? 0
    let orderedListPaddingLeft: number = theme.getOrderedListPaddingLeft() ?? 0
    cjMarkdownTheme.setOrderedListPadding(
      orderedListPaddingTop,
      orderedListPaddingRight,
      orderedListPaddingBottom,
      orderedListPaddingLeft
    )
    if (theme.getOrderedListChildSpacing() !== undefined) {
      cjMarkdownTheme.setOrderedListChildSpacing(theme.getOrderedListChildSpacing())
    }
    if (theme.getOrderedListChildChildSpacing() !== undefined) {
      cjMarkdownTheme.setOrderedListChildChildSpacing(theme.getOrderedListChildChildSpacing())
    }
    if (theme.getOrderedListMarkerSpacing() !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerSpacing(theme.getOrderedListMarkerSpacing())
    }
    if (theme.getOrderedListMarkerTextFontColor() !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextFontColor(theme.getOrderedListMarkerTextFontColor())
    }
    if (theme.getOrderedListMarkerTextFontSize() !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextFontSize(theme.getOrderedListMarkerTextFontSize())
    }
    if (theme.getOrderedListMarkerTextFontStyle() !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextFontStyle(theme.getOrderedListMarkerTextFontStyle())
    }
    if (theme.getOrderedListMarkerTextFontWeight() !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextFontWeight(this.convertFontWeight(theme.getOrderedListMarkerTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getOrderedListMarkerTextFontFamily() !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextFontFamily(theme.getOrderedListMarkerTextFontFamily())
    }
    if (theme.getOrderedListMarkerTextLineHeight() !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextLineHeight(theme.getOrderedListMarkerTextLineHeight())
    }
    return cjMarkdownTheme
  }

  getParagraphTheme(theme: MarkdownThemeParagraph): CJMarkdownParagraphTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownParagraphTheme()
    if (theme.getParagraphBackgroundColor() !== undefined) {
      cjMarkdownTheme.setParagraphBackgroundColor(theme.getParagraphBackgroundColor())
    }
    let paragraphMarginTop: number = theme.getParagraphMarginTop() ?? 0
    let paragraphMarginRight: number = theme.getParagraphMarginRight() ?? 0
    let paragraphMarginBottom: number = theme.getParagraphMarginBottom() ?? 0
    let paragraphMarginLeft: number = theme.getParagraphMarginLeft() ?? 0
    cjMarkdownTheme.setParagraphMargin(paragraphMarginTop, paragraphMarginRight, paragraphMarginBottom, paragraphMarginLeft)

    let paragraphPaddingTop: number = theme.getParagraphPaddingTop() ?? 0
    let paragraphPaddingRight: number = theme.getParagraphPaddingRight() ?? 0
    let paragraphPaddingBottom: number = theme.getParagraphPaddingBottom() ?? 0
    let paragraphPaddingLeft: number = theme.getParagraphPaddingLeft() ?? 0
    cjMarkdownTheme.setParagraphPadding(paragraphPaddingTop, paragraphPaddingRight, paragraphPaddingBottom, paragraphPaddingLeft)
    if (theme.getParagraphTextFontColor() !== undefined) {
      cjMarkdownTheme.setParagraphTextFontColor(theme.getParagraphTextFontColor())
    }
    if (theme.getParagraphTextFontSize() !== undefined) {
      cjMarkdownTheme.setParagraphTextFontSize(theme.getParagraphTextFontSize())
    }
    if (theme.getParagraphTextFontStyle() !== undefined) {
      cjMarkdownTheme.setParagraphTextFontStyle(theme.getParagraphTextFontStyle())
    }
    if (theme.getParagraphTextFontWeight() !== undefined) {
      cjMarkdownTheme.setParagraphTextFontWeight(this.convertFontWeight(theme.getParagraphTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getParagraphTextFontFamily() !== undefined) {
      cjMarkdownTheme.setParagraphTextFontFamily(theme.getParagraphTextFontFamily())
    }
    if (theme.getParagraphTextLineHeight() !== undefined) {
      cjMarkdownTheme.setParagraphTextLineHeight(theme.getParagraphTextLineHeight())
    }
    if (theme.getParagraphTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setParagraphTextLetterSpacing(theme.getParagraphTextLetterSpacing())
    }
    return cjMarkdownTheme
  }

  getStrikethroughTheme(theme: MarkdownThemeStrikethrough): CJMarkdownStrikethroughTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownStrikethroughTheme()
    if (theme.getStrikethroughTextFontColor() !== undefined) {
      cjMarkdownTheme.setStrikethroughTextFontColor(theme.getStrikethroughTextFontColor())
    }
    if (theme.getStrikethroughTextFontSize() !== undefined) {
      cjMarkdownTheme.setStrikethroughTextFontSize(theme.getStrikethroughTextFontSize())
    }
    if (theme.getStrikethroughTextFontStyle() !== undefined) {
      cjMarkdownTheme.setStrikethroughTextFontStyle(theme.getStrikethroughTextFontStyle())
    }
    if (theme.getStrikethroughTextFontWeight() !== undefined) {
      cjMarkdownTheme.setStrikethroughTextFontWeight(this.convertFontWeight(theme.getStrikethroughTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getStrikethroughTextFontFamily() !== undefined) {
      cjMarkdownTheme.setStrikethroughTextFontFamily(theme.getStrikethroughTextFontFamily())
    }
    if (theme.getStrikethroughTextLineHeight() !== undefined) {
      cjMarkdownTheme.setStrikethroughTextLineHeight(theme.getStrikethroughTextLineHeight())
    }
    if (theme.getStrikethroughTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setStrikethroughTextLetterSpacing(theme.getStrikethroughTextLetterSpacing())
    }
    if (theme.getStrikethroughTextDecorationColor() !== undefined) {
      cjMarkdownTheme.setStrikethroughTextDecorationColor(theme.getStrikethroughTextDecorationColor())
    }
    if (theme.getStrikethroughTextDecorationStyle() !== undefined) {
      cjMarkdownTheme.setStrikethroughTextDecorationStyle(theme.getStrikethroughTextDecorationStyle())
    }
    return cjMarkdownTheme
  }

  getSubTheme(theme: MarkdownThemeSub): CJMarkdownSubTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownSubTheme()
    if (theme.getSubTextFontColor() !== undefined) {
      cjMarkdownTheme.setSubTextFontColor(theme.getSubTextFontColor())
    }
    if (theme.getSubTextFontSize() !== undefined) {
      cjMarkdownTheme.setSubTextFontSize(theme.getSubTextFontSize())
    }
    if (theme.getSubTextFontStyle() !== undefined) {
      cjMarkdownTheme.setSubTextFontStyle(theme.getSubTextFontStyle())
    }
    if (theme.getSubTextFontWeight() !== undefined) {
      cjMarkdownTheme.setSubTextFontWeight(this.convertFontWeight(theme.getSubTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getSubTextFontFamily() !== undefined) {
      cjMarkdownTheme.setSubTextFontFamily(theme.getSubTextFontFamily())
    }
    if (theme.getSubTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setSubTextLetterSpacing(theme.getSubTextLetterSpacing())
    }
    if (theme.getSubTextBaselineOffset() !== undefined) {
      cjMarkdownTheme.setSubTextBaselineOffset(theme.getSubTextBaselineOffset())
    }
    return cjMarkdownTheme
  }

  getSupTheme(theme: MarkdownThemeSup): CJMarkdownSupTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownSupTheme()
    if (theme.getSupTextFontColor() !== undefined) {
      cjMarkdownTheme.setSupTextFontColor(theme.getSupTextFontColor())
    }
    if (theme.getSupTextFontSize() !== undefined) {
      cjMarkdownTheme.setSupTextFontSize(theme.getSupTextFontSize())
    }
    if (theme.getSupTextFontStyle() !== undefined) {
      cjMarkdownTheme.setSupTextFontStyle(theme.getSupTextFontStyle())
    }
    if (theme.getSupTextFontWeight() !== undefined) {
      cjMarkdownTheme.setSupTextFontWeight(this.convertFontWeight(theme.getSupTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getSupTextFontFamily() !== undefined) {
      cjMarkdownTheme.setSupTextFontFamily(theme.getSupTextFontFamily())
    }
    if (theme.getSupTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setSupTextLetterSpacing(theme.getSupTextLetterSpacing())
    }
    if (theme.getSupTextBaselineOffset() !== undefined) {
      cjMarkdownTheme.setSupTextBaselineOffset(theme.getSupTextBaselineOffset())
    }
    return cjMarkdownTheme
  }

  getTableTheme(theme: MarkdownThemeTable): CJMarkdownTableTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownTableTheme()
    if (theme.getTableTitleBackgroundColor() !== undefined) {
      cjMarkdownTheme.setTableTitleBackgroundColor(theme.getTableTitleBackgroundColor())
    }
    if (theme.getTableContentOddRowBackgroundColor() !== undefined) {
      cjMarkdownTheme.setTableContentOddRowBackgroundColor(theme.getTableContentOddRowBackgroundColor())
    }
    if (theme.getTableContentEvenRowBackgroundColor() !== undefined) {
      cjMarkdownTheme.setTableContentEvenRowBackgroundColor(theme.getTableContentEvenRowBackgroundColor())
    }
    let tableMarginTop: number = theme.getTableMarginTop() ?? 0
    let tableMarginRight: number = theme.getTableMarginRight() ?? 0
    let tableMarginBottom: number = theme.getTableMarginBottom() ?? 0
    let tableMarginLeft: number = theme.getTableMarginLeft() ?? 0
    cjMarkdownTheme.setTableMargin(tableMarginTop, tableMarginRight, tableMarginBottom, tableMarginLeft)

    let tablePaddingTop: number = theme.getTablePaddingTop() ?? 0
    let tablePaddingRight: number = theme.getTablePaddingRight() ?? 0
    let tablePaddingBottom: number = theme.getTablePaddingBottom() ?? 0
    let tablePaddingLeft: number = theme.getTablePaddingLeft() ?? 0
    cjMarkdownTheme.setTablePadding(tablePaddingTop, tablePaddingRight, tablePaddingBottom, tablePaddingLeft)

    let tableCellPaddingTop: number = theme.getTableCellPaddingTop() ?? 4
    let tableCellPaddingRight: number = theme.getTableCellPaddingRight() ?? 4
    let tableCellPaddingBottom: number = theme.getTableCellPaddingBottom() ?? 4
    let tableCellPaddingLeft: number = theme.getTableCellPaddingLeft() ?? 4
    cjMarkdownTheme.setTableCellPadding(tableCellPaddingTop, tableCellPaddingRight, tableCellPaddingBottom, tableCellPaddingLeft)
    if (theme.getTableBorderStyle() !== undefined) {
      cjMarkdownTheme.setTableBorderStyle(theme.getTableBorderStyle())
    }
    if (theme.getTableBorderWidth() !== undefined) {
      cjMarkdownTheme.setTableBorderWidth(theme.getTableBorderWidth())
    }
    if (theme.getTableBorderColor() !== undefined) {
      cjMarkdownTheme.setTableBorderColor(theme.getTableBorderColor())
    }
    let tableRadiusTopLeft: number = theme.getTableRadiusTopLeft() ?? 5
    let tableRadiusTopRight: number = theme.getTableRadiusTopRight() ?? 5
    let tableRadiusBottomLeft: number = theme.getTableRadiusBottomLeft() ?? 5
    let tableRadiusBottomRight: number = theme.getTableRadiusBottomRight() ?? 5
    cjMarkdownTheme.setTableRadius(tableRadiusTopLeft, tableRadiusTopRight, tableRadiusBottomLeft, tableRadiusBottomRight)
    if (theme.getTableScrollBarState() !== undefined) {
      cjMarkdownTheme.setTableScrollBarState(theme.getTableScrollBarState())
    }
    if (theme.getTableScrollBarColor() !== undefined) {
      cjMarkdownTheme.setTableScrollBarColor(theme.getTableScrollBarColor())
    }
    if (theme.getTableMinCellWidth() !== undefined) {
      cjMarkdownTheme.setTableMinCellWidth(theme.getTableMinCellWidth())
    }
    if (theme.getTableMaxCellWidth() !== undefined) {
      cjMarkdownTheme.setTableMaxCellWidth(theme.getTableMaxCellWidth())
    }
    if (theme.getTableFirstColumnIsBold() !== undefined) {
      cjMarkdownTheme.setTableFirstColumnIsBold(theme.getTableFirstColumnIsBold())
    }
    if (theme.getTableTitleTextFontColor() !== undefined) {
      cjMarkdownTheme.setTableTitleTextFontColor(theme.getTableTitleTextFontColor())
    }
    if (theme.getTableTitleTextFontSize() !== undefined) {
      cjMarkdownTheme.setTableTitleTextFontSize(theme.getTableTitleTextFontSize())
    }
    if (theme.getTableTitleTextFontStyle() !== undefined) {
      cjMarkdownTheme.setTableTitleTextFontStyle(theme.getTableTitleTextFontStyle())
    }
    if (theme.getTableTitleTextFontWeight() !== undefined) {
      cjMarkdownTheme.setTableTitleTextFontWeight(this.convertFontWeight(theme.getTableTitleTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getTableTitleTextFontFamily() !== undefined) {
      cjMarkdownTheme.setTableTitleTextFontFamily(theme.getTableTitleTextFontFamily())
    }
    if (theme.getTableTitleTextLineHeight() !== undefined) {
      cjMarkdownTheme.setTableTitleTextLineHeight(theme.getTableTitleTextLineHeight())
    }
    if (theme.getTableTitleTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setTableTitleTextLetterSpacing(theme.getTableTitleTextLetterSpacing())
    }
    if (theme.getTableContentTextFontColor() !== undefined) {
      cjMarkdownTheme.setTableContentTextFontColor(theme.getTableContentTextFontColor())
    }
    if (theme.getTableContentTextFontSize() !== undefined) {
      cjMarkdownTheme.setTableContentTextFontSize(theme.getTableContentTextFontSize())
    }
    if (theme.getTableContentTextFontStyle() !== undefined) {
      cjMarkdownTheme.setTableContentTextFontStyle(theme.getTableContentTextFontStyle())
    }
    if (theme.getTableContentTextFontWeight() !== undefined) {
      cjMarkdownTheme.setTableContentTextFontWeight(this.convertFontWeight(theme.getTableContentTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getTableContentTextFontFamily() !== undefined) {
      cjMarkdownTheme.setTableContentTextFontFamily(theme.getTableContentTextFontFamily())
    }
    if (theme.getTableContentTextLineHeight() !== undefined) {
      cjMarkdownTheme.setTableContentTextLineHeight(theme.getTableContentTextLineHeight())
    }
    if (theme.getTableContentTextLetterSpacing() !== undefined) {
      cjMarkdownTheme.setTableContentTextLetterSpacing(theme.getTableContentTextLetterSpacing())
    }
    return cjMarkdownTheme
  }

  getVideoTheme(theme: MarkdownThemeVideo): CJMarkdownVideoTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownVideoTheme()
    if (theme.getVideoBackgroundColor() !== undefined) {
      cjMarkdownTheme.setVideoBackgroundColor(theme.getVideoBackgroundColor())
    }
    let videoMarginTop: number = theme.getVideoMarginTop() ?? 0
    let videoMarginRight: number = theme.getVideoMarginRight() ?? 0
    let videoMarginBottom: number = theme.getVideoMarginBottom() ?? 0
    let videoMarginLeft: number = theme.getVideoMarginLeft() ?? 0
    cjMarkdownTheme.setVideoMargin(videoMarginTop, videoMarginRight, videoMarginBottom, videoMarginLeft)

    let videoPaddingTop: number = theme.getVideoPaddingTop() ?? 0
    let videoPaddingRight: number = theme.getVideoPaddingRight() ?? 0
    let videoPaddingBottom: number = theme.getVideoPaddingBottom() ?? 0
    let videoPaddingLeft: number = theme.getVideoPaddingLeft() ?? 0
    cjMarkdownTheme.setVideoPadding(videoPaddingTop, videoPaddingRight, videoPaddingBottom, videoPaddingLeft)

    let videoRadiusTopLeft: number = theme.getVideoRadiusTopLeft() ?? 10
    let videoRadiusTopRight: number = theme.getVideoRadiusTopRight() ?? 10
    let videoRadiusBottomLeft: number = theme.getVideoRadiusBottomLeft() ?? 10
    let videoRadiusBottomRight: number = theme.getVideoRadiusBottomRight() ?? 10
    cjMarkdownTheme.setVideoBorderRadius(videoRadiusTopLeft, videoRadiusTopRight, videoRadiusBottomLeft, videoRadiusBottomRight)
    if (theme.getVideoImageFitType() !== undefined) {
      cjMarkdownTheme.setVideoImageFitType(theme.getVideoImageFitType())
    }
    if (theme.getVideoBorderStyle() !== undefined) {
      cjMarkdownTheme.setVideoBorderStyle(theme.getVideoBorderStyle())
    }
    if (theme.getVideoBorderWidth() !== undefined) {
      cjMarkdownTheme.setVideoBorderWidth(theme.getVideoBorderWidth())
    }
    if (theme.getVideoBorderColor() !== undefined) {
      cjMarkdownTheme.setVideoBorderColor(theme.getVideoBorderColor())
    }
    if (theme.getVideoTimeTextFontColor() !== undefined) {
      cjMarkdownTheme.setVideoTimeTextFontColor(theme.getVideoTimeTextFontColor())
    }
    if (theme.getVideoTimeTextFontSize() !== undefined) {
      cjMarkdownTheme.setVideoTimeTextFontSize(theme.getVideoTimeTextFontSize())
    }
    if (theme.getVideoTimeTextFontStyle() !== undefined) {
      cjMarkdownTheme.setVideoTimeTextFontStyle(theme.getVideoTimeTextFontStyle())
    }
    if (theme.getVideoTimeTextFontWeight() !== undefined) {
      cjMarkdownTheme.setVideoTimeTextFontWeight(this.convertFontWeight(theme.getVideoTimeTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getVideoTimeTextFontFamily() !== undefined) {
      cjMarkdownTheme.setVideoTimeTextFontFamily(theme.getVideoTimeTextFontFamily())
    }
    if (theme.getVideoTimeTextLineHeight() !== undefined) {
      cjMarkdownTheme.setVideoTimeTextLineHeight(theme.getVideoTimeTextLineHeight())
    }
    if (theme.getVideoTimeTextMarginRight() !== undefined) {
      cjMarkdownTheme.setVideoTimeTextMarginRight(theme.getVideoTimeTextMarginRight())
    }
    if (theme.getVideoTimeTextMarginBottom() !== undefined) {
      cjMarkdownTheme.setVideoTimeTextMarginBottom(theme.getVideoTimeTextMarginBottom())
    }
    if (theme.getVideoBottomLayoutVisible() !== undefined) {
      cjMarkdownTheme.setVideoBottomLayoutVisible(theme.getVideoBottomLayoutVisible())
    }
    if (theme.getVideoBottomLayoutMarginTop() !== undefined) {
      cjMarkdownTheme.setVideoBottomLayoutMarginTop(theme.getVideoBottomLayoutMarginTop())
    }
    if (theme.getVideoPlayIconWidth() !== undefined) {
      cjMarkdownTheme.setVideoPlayIconWidth(theme.getVideoPlayIconWidth())
    }
    if (theme.getVideoPlayIconHeight() !== undefined) {
      cjMarkdownTheme.setVideoPlayIconHeight(theme.getVideoPlayIconHeight())
    }
    if (theme.getVideoPlayIconFitType() !== undefined) {
      cjMarkdownTheme.setVideoPlayIconFitType(theme.getVideoPlayIconFitType())
    }
    if (theme.getVideoReleaseButtonVisible() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonVisible(theme.getVideoReleaseButtonVisible())
    }
    if (theme.getVideoReleaseButtonBackgroundColor() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonBackgroundColor(theme.getVideoReleaseButtonBackgroundColor())
    }
    if (theme.getVideoReleaseButtonWidth() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonWidth(theme.getVideoReleaseButtonWidth())
    }
    if (theme.getVideoReleaseButtonHeight() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonHeight(theme.getVideoReleaseButtonHeight())
    }
    let videoReleaseButtonRadiusTopLeft: number = theme.getVideoReleaseButtonRadiusTopLeft() ?? 22
    let videoReleaseButtonRadiusTopRight: number = theme.getVideoReleaseButtonRadiusTopRight() ?? 22
    let videoReleaseButtonRadiusBottomLeft: number = theme.getVideoReleaseButtonRadiusBottomLeft() ?? 22
    let videoReleaseButtonRadiusBottomRight: number = theme.getVideoReleaseButtonRadiusBottomRight() ?? 22
    cjMarkdownTheme.setVideoReleaseButtonRadius(
      videoReleaseButtonRadiusTopLeft,
      videoReleaseButtonRadiusTopRight,
      videoReleaseButtonRadiusBottomLeft,
      videoReleaseButtonRadiusBottomRight
    )
    if (theme.getVideoReleaseButtonIconWidth() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonIconWidth(theme.getVideoReleaseButtonIconWidth())
    }
    if (theme.getVideoReleaseButtonIconHeight() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonIconHeight(theme.getVideoReleaseButtonIconHeight())
    }
    if (theme.getVideoReleaseButtonIconTextGap() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonIconTextGap(theme.getVideoReleaseButtonIconTextGap())
    }
    if (theme.getVideoReleaseButtonText() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonText(theme.getVideoReleaseButtonText())
    }
    if (theme.getVideoReleaseButtonTextFontColor() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextFontColor(theme.getVideoReleaseButtonTextFontColor())
    }
    if (theme.getVideoReleaseButtonTextFontSize() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextFontSize(theme.getVideoReleaseButtonTextFontSize())
    }
    if (theme.getVideoReleaseButtonTextFontStyle() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextFontStyle(theme.getVideoReleaseButtonTextFontStyle())
    }
    if (theme.getVideoReleaseButtonTextFontWeight() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextFontWeight(this.convertFontWeight(theme.getVideoReleaseButtonTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getVideoReleaseButtonTextFontFamily() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextFontFamily(theme.getVideoReleaseButtonTextFontFamily())
    }
    if (theme.getVideoReleaseButtonTextLineHeight() !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextLineHeight(theme.getVideoReleaseButtonTextLineHeight())
    }
    if (theme.getVideoDownloadButtonVisible() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonVisible(theme.getVideoDownloadButtonVisible())
    }
    if (theme.getVideoDownloadButtonBackgroundColor() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonBackgroundColor(theme.getVideoDownloadButtonBackgroundColor())
    }
    if (theme.getVideoDownloadButtonWidth() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonWidth(theme.getVideoDownloadButtonWidth())
    }
    if (theme.getVideoDownloadButtonHeight() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonHeight(theme.getVideoDownloadButtonHeight())
    }
    let videoDownloadButtonRadiusTopLeft: number = theme.getVideoDownloadButtonRadiusTopLeft() ?? 22
    let videoDownloadButtonRadiusTopRight: number = theme.getVideoDownloadButtonRadiusTopRight() ?? 22
    let videoDownloadButtonRadiusBottomLeft: number = theme.getVideoDownloadButtonRadiusBottomLeft() ?? 22
    let videoDownloadButtonRadiusBottomRight: number = theme.getVideoDownloadButtonRadiusBottomRight() ?? 22
    cjMarkdownTheme.setVideoDownloadButtonRadius(
      videoDownloadButtonRadiusTopLeft,
      videoDownloadButtonRadiusTopRight,
      videoDownloadButtonRadiusBottomLeft,
      videoDownloadButtonRadiusBottomRight
    )
    if (theme.getVideoDownloadButtonIconWidth() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonIconWidth(theme.getVideoDownloadButtonIconWidth())
    }
    if (theme.getVideoDownloadButtonIconHeight() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonIconHeight(theme.getVideoDownloadButtonIconHeight())
    }
    if (theme.getVideoDownloadButtonIconTextGap() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonIconTextGap(theme.getVideoDownloadButtonIconTextGap())
    }
    if (theme.getVideoDownloadButtonText() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonText(theme.getVideoDownloadButtonText())
    }
    if (theme.getVideoDownloadButtonTextFontColor() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextFontColor(theme.getVideoDownloadButtonTextFontColor())
    }
    if (theme.getVideoDownloadButtonTextFontSize() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextFontSize(theme.getVideoDownloadButtonTextFontSize())
    }
    if (theme.getVideoDownloadButtonTextFontStyle() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextFontStyle(theme.getVideoDownloadButtonTextFontStyle())
    }
    if (theme.getVideoDownloadButtonTextFontWeight() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextFontWeight(this.convertFontWeight(theme.getVideoDownloadButtonTextFontWeight() ?? FontWeight.Normal))
    }
    if (theme.getVideoDownloadButtonTextFontFamily() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextFontFamily(theme.getVideoDownloadButtonTextFontFamily())
    }
    if (theme.getVideoDownloadButtonTextLineHeight() !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextLineHeight(theme.getVideoDownloadButtonTextLineHeight())
    }
    return cjMarkdownTheme
  }

  convertFontWeight(weight: FontWeight): number {
    switch (weight) {
      case FontWeight.Lighter:
        return 0
      case FontWeight.Normal:
        return 1
      case FontWeight.Regular:
        return 2
      case FontWeight.Medium:
        return 3
      case FontWeight.Bold:
        return 4
      case FontWeight.Bolder:
        return 5
      default:
        return 1
    }
  }
}
