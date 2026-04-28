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
  CJMarkdownLatexMathTheme
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
      if (this.config.linkCallback !== undefined) {
        cjMarkdownConfig.setLinkCallback(this.config.linkCallback)
      }
      if (this.config.textCopyCallback !== undefined) {
        cjMarkdownConfig.setTextCopyCallback(this.config.textCopyCallback)
      }
      if (this.config.imageCallback !== undefined) {
        cjMarkdownConfig.setImageCallback(this.config.imageCallback)
      }
      if (this.config.imageCallbackCallback !== undefined) {
        global_customLib.registerImgPreprocessCallback(this.config.imageCallbackCallback)
      } else {
        global_customLib.registerImgPreprocessCallback(undefined)
      }
      if (this.config.imageDownloadCallback !== undefined) {
        cjMarkdownConfig.setImageDownloadCallback(this.config.imageDownloadCallback)
      }
      if (this.config.audioCallback !== undefined) {
        cjMarkdownConfig.setAudioCallback(this.config.audioCallback)
      }
      if (this.config.videoCallback !== undefined) {
        cjMarkdownConfig.setVideoCallback(this.config.videoCallback)
      }
      if (this.config.videoImageCallback !== undefined) {
        cjMarkdownConfig.setVideoImageCallback(this.config.videoImageCallback)
      }
      if (this.config.videoReleaseCallback !== undefined) {
        cjMarkdownConfig.setVideoReleaseCallback(this.config.videoReleaseCallback)
      }
      if (this.config.videoDownloadCallback !== undefined) {
        cjMarkdownConfig.setVideoDownloadCallback(this.config.videoDownloadCallback)
      }
      if (this.config.codeCopyCallback !== undefined) {
        cjMarkdownConfig.setCodeCopyCallback(this.config.codeCopyCallback)
      }
      if (this.config.codeFullScreenCallback !== undefined) {
        cjMarkdownConfig.setCodeFullScreenCallback(this.config.codeFullScreenCallback)
      }
      if (this.config.latexImageCallback !== undefined) {
        cjMarkdownConfig.setLatexImageCallback(this.config.latexImageCallback)
      }
      if (this.config.latexStrCallback !== undefined) {
        cjMarkdownConfig.setLatexStrCallback(this.config.latexStrCallback)
      }
      if (this.config.tocIndexCallback !== undefined) {
        cjMarkdownConfig.setTocIndexCallback(this.config.tocIndexCallback)
      }
      if (this.config.footnoteCallback !== undefined) {
        cjMarkdownConfig.setFootnoteCallback(this.config.footnoteCallback)
      }
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
      cjMarkdownPlugin.setIsBlockAudioPlugin(this.plugin.isBlockAudioPlugin)
      cjMarkdownPlugin.setIsBlockVideoPlugin(this.plugin.isBlockVideoPlugin)
      cjMarkdownPlugin.setIsCodeListPlugin(this.plugin.isCodeListPlugin)
      cjMarkdownPlugin.setIsFootnotePlugin(this.plugin.isFootnotePlugin)
      cjMarkdownPlugin.setIsHtmlPlugin(this.plugin.isHtmlPlugin)
      cjMarkdownPlugin.setIsTablePlugin(this.plugin.isTablePlugin)
      cjMarkdownPlugin.setIsTocPlugin(this.plugin.isTocPlugin)
      cjMarkdownPlugin.setIsTaskListPlugin(this.plugin.isTaskListPlugin)
      cjMarkdownPlugin.setIsStrikethroughPlugin(this.plugin.isStrikethroughPlugin)
      cjMarkdownPlugin.setIsLinkifyPlugin(this.plugin.isLinkifyPlugin, this.plugin.regs)
      cjMarkdownPlugin.setIsLinkViewPlugin(this.plugin.isLinkViewPlugin)
      cjMarkdownPlugin.setIsLatexMathPlugin(this.plugin.isLatexMathPlugin)
      cjMarkdownPlugin.setIsImageStylePlugin(this.plugin.isImageStylePlugin)
      cjMarkdownPlugin.setIsImageSlidePlugin(this.plugin.isImageSlidePlugin)
      cjMarkdownPlugin.setIsImageTextMixPlugin(this.plugin.isImageTextMixPlugin)
      cjMarkdownPlugin.setIsImageCollectPlugin(this.plugin.isImageCollectPlugin)
      cjMarkdownPlugin.setIsDescListPlugin(this.plugin.isDescListPlugin)
      cjMarkdownPlugin.setIsHeadIDPlugin(this.plugin.isHeadIDPlugin)
      cjMarkdownPlugin.setIsSubPlugin(this.plugin.isSubPlugin)
      cjMarkdownPlugin.setIsSupPlugin(this.plugin.isSupPlugin)
      cjMarkdownPlugin.setIsEmojiPlugin(this.plugin.isEmojiPlugin, this.plugin.isEmojiLight)
    }
    return cjMarkdownPlugin
  }

  getTheme(): CJMarkdownTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme: CJMarkdownTheme = new global_customLib.CJMarkdownTheme()
    if (this.config !== undefined) {
      if (this.config.markdownTheme !== undefined) {
        if (this.config.markdownTheme.markdownThemeGlobal !== undefined &&
            this.config.markdownTheme.markdownThemeGlobal.stageContext !== undefined) {
          global_customLib.setGlobalContext(this.config.markdownTheme.markdownThemeGlobal.stageContext)
        } else {
          global_customLib.setGlobalContext(undefined)
        }
        global_customLib.getCJResource(
          this.config.markdownTheme.markdownThemeCodeBlock.codeBlockFullScreenIcon,
          this.config.markdownTheme.markdownThemeCodeBlock.codeBlockCopyIcon,
          this.config.markdownTheme.markdownThemeAudio.audioIcon,
          this.config.markdownTheme.markdownThemeVideo.videoPlaceholder,
          this.config.markdownTheme.markdownThemeVideo.videoPlayIcon,
          this.config.markdownTheme.markdownThemeBanner.bannerPlaceholder,
          this.config.markdownTheme.markdownThemeImage.imagePlaceholder,
          this.config.markdownTheme.markdownThemeVideo.videoReleaseButtonIcon,
          this.config.markdownTheme.markdownThemeVideo.videoDownloadButtonIcon,
          this.config.markdownTheme.markdownThemeImage.imageDownloadButtonIcon
        )

        cjMarkdownTheme.setCJMarkdownGlobalTheme(this.getGlobalTheme(this.config.markdownTheme.markdownThemeGlobal))
        cjMarkdownTheme.setCJMarkdownAudioTheme(this.getAudioTheme(this.config.markdownTheme.markdownThemeAudio))
        cjMarkdownTheme.setCJMarkdownBannerTheme(this.getBannerTheme(this.config.markdownTheme.markdownThemeBanner))
        cjMarkdownTheme.setCJMarkdownBlockQuoteTheme(this.getBlockQuoteTheme(this.config.markdownTheme.markdownThemeBlockQuote))
        cjMarkdownTheme.setCJMarkdownBoldTheme(this.getBoldTheme(this.config.markdownTheme.markdownThemeBold))
        cjMarkdownTheme.setCJMarkdownBulletListTheme(this.getBulletListTheme(this.config.markdownTheme.markdownThemeBulletList))
        cjMarkdownTheme.setCJMarkdownCodeBlockTheme(this.getCodeBlockTheme(this.config.markdownTheme.markdownThemeCodeBlock))
        cjMarkdownTheme.setCJMarkdownDefinitionListTheme(this.getDefinitionListTheme(this.config.markdownTheme.markdownThemeDefinitionList))
        cjMarkdownTheme.setCJMarkdownDividerTheme(this.getDividerTheme(this.config.markdownTheme.markdownThemeDivider))
        cjMarkdownTheme.setCJMarkdownFootnoteDefTheme(this.getFootnoteDefTheme(this.config.markdownTheme.markdownThemeFootnoteDef))
        cjMarkdownTheme.setCJMarkdownFootnoteRefTheme(this.getFootnoteRefTheme(this.config.markdownTheme.markdownThemeFootnoteRef))
        cjMarkdownTheme.setCJMarkdownHeadingTheme(this.getHeadingTheme(this.config.markdownTheme.markdownThemeHeading))
        cjMarkdownTheme.setCJMarkdownHtmlUnderlineTheme(this.getHtmlUnderlineTheme(this.config.markdownTheme.markdownThemeHtmlUnderline))
        cjMarkdownTheme.setCJMarkdownImageTheme(this.getImageTheme(this.config.markdownTheme.markdownThemeImage))
        cjMarkdownTheme.setCJMarkdownInlineCodeTheme(this.getInlineCodeTheme(this.config.markdownTheme.markdownThemeInlineCode))
        cjMarkdownTheme.setCJMarkdownItalicTheme(this.getItalicTheme(this.config.markdownTheme.markdownThemeItalic))
        cjMarkdownTheme.setCJMarkdownLatexMathTheme(this.getLatexMathTheme(this.config.markdownTheme.markdownThemeLatexMath))
        cjMarkdownTheme.setCJMarkdownLinkTheme(this.getLinkTheme(this.config.markdownTheme.markdownThemeLink))
        cjMarkdownTheme.setCJMarkdownOrderedListTheme(this.getOrderedListTheme(this.config.markdownTheme.markdownThemeOrderedList))
        cjMarkdownTheme.setCJMarkdownParagraphTheme(this.getParagraphTheme(this.config.markdownTheme.markdownThemeParagraph))
        cjMarkdownTheme.setCJMarkdownStrikethroughTheme(this.getStrikethroughTheme(this.config.markdownTheme.markdownThemeStrikethrough))
        cjMarkdownTheme.setCJMarkdownSubTheme(this.getSubTheme(this.config.markdownTheme.markdownThemeSub))
        cjMarkdownTheme.setCJMarkdownSupTheme(this.getSupTheme(this.config.markdownTheme.markdownThemeSup))
        cjMarkdownTheme.setCJMarkdownTableTheme(this.getTableTheme(this.config.markdownTheme.markdownThemeTable))
        cjMarkdownTheme.setCJMarkdownVideoTheme(this.getVideoTheme(this.config.markdownTheme.markdownThemeVideo))

        if (this.config.markdownTheme.isLinkSize !== undefined) {
          cjMarkdownTheme.setIsLinkSize(this.config.markdownTheme.isLinkSize)
        }

        if (this.config.markdownTheme.markdownThemeCodeBlock !== undefined &&
            this.config.markdownTheme.markdownThemeCodeBlock.codeBlockIsDark !== undefined) {
          cjMarkdownTheme.setIsDark(this.config.markdownTheme.markdownThemeCodeBlock.codeBlockIsDark)
        }
      }
    }
    return cjMarkdownTheme
  }

  getAudioTheme(theme: MarkdownThemeAudio): CJMarkdownAudioTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownAudioTheme()
    if (theme.audioBackgroundColor !== undefined) {
      cjMarkdownTheme.setAudioBackgroundColor(theme.audioBackgroundColor)
    }
    let audioMarginTop: number = 0.0
    let audioMarginRight: number = 0.0
    let audioMarginBottom: number = 0.0
    let audioMarginLeft: number = 0.0
    if (theme.audioMarginTop !== undefined) {
      audioMarginTop = theme.audioMarginTop
    }
    if (theme.audioMarginRight !== undefined) {
      audioMarginRight = theme.audioMarginRight
    }
    if (theme.audioMarginBottom !== undefined) {
      audioMarginBottom = theme.audioMarginBottom
    }
    if (theme.audioMarginLeft !== undefined) {
      audioMarginLeft = theme.audioMarginLeft
    }
    cjMarkdownTheme.setAudioMargin(audioMarginTop, audioMarginRight, audioMarginBottom, audioMarginLeft)

    let audioPaddingTop: number = 12.0
    let audioPaddingRight: number = 16.0
    let audioPaddingBottom: number = 12.0
    let audioPaddingLeft: number = 12.0
    if (theme.audioPaddingTop !== undefined) {
      audioPaddingTop = theme.audioPaddingTop
    }
    if (theme.audioPaddingRight !== undefined) {
      audioPaddingRight = theme.audioPaddingRight
    }
    if (theme.audioPaddingBottom !== undefined) {
      audioPaddingBottom = theme.audioPaddingBottom
    }
    if (theme.audioPaddingLeft !== undefined) {
      audioPaddingLeft = theme.audioPaddingLeft
    }
    cjMarkdownTheme.setAudioPadding(audioPaddingTop, audioPaddingRight, audioPaddingBottom, audioPaddingLeft)
    if (theme.audioBorderStyle !== undefined) {
      cjMarkdownTheme.setAudioBorderStyle(theme.audioBorderStyle)
    }
    if (theme.audioBorderWidth !== undefined) {
      cjMarkdownTheme.setAudioBorderWidth(theme.audioBorderWidth)
    }
    if (theme.audioBorderColor !== undefined) {
      cjMarkdownTheme.setAudioBorderColor(theme.audioBorderColor)
    }
    let audioRadiusTopLeft: number = 12.0
    let audioRadiusTopRight: number = 12.0
    let audioRadiusBottomLeft: number = 12.0
    let audioRadiusBottomRight: number = 12.0
    if (theme.audioRadiusTopLeft !== undefined) {
      audioRadiusTopLeft = theme.audioRadiusTopLeft
    }
    if (theme.audioRadiusTopRight !== undefined) {
      audioRadiusTopRight = theme.audioRadiusTopRight
    }
    if (theme.audioRadiusBottomLeft !== undefined) {
      audioRadiusBottomLeft = theme.audioRadiusBottomLeft
    }
    if (theme.audioRadiusBottomRight !== undefined) {
      audioRadiusBottomRight = theme.audioRadiusBottomRight
    }
    cjMarkdownTheme.setAudioBorderRadius(audioRadiusTopLeft, audioRadiusTopRight, audioRadiusBottomLeft, audioRadiusBottomRight)
    if (theme.audioShadowRadius !== undefined) {
      cjMarkdownTheme.setAudioShadowRadius(theme.audioShadowRadius)
    }
    if (theme.audioShadowColor !== undefined) {
      cjMarkdownTheme.setAudioShadowColor(theme.audioShadowColor)
    }
    if (theme.audioShadowOffsetX !== undefined) {
      cjMarkdownTheme.setAudioShadowOffsetX(theme.audioShadowOffsetX)
    }
    if (theme.audioShadowOffsetY !== undefined) {
      cjMarkdownTheme.setAudioShadowOffsetY(theme.audioShadowOffsetY)
    }
    if (theme.audioButtonWidth !== undefined) {
      cjMarkdownTheme.setAudioButtonWidth(theme.audioButtonWidth)
    }
    if (theme.audioButtonHeight !== undefined) {
      cjMarkdownTheme.setAudioButtonHeight(theme.audioButtonHeight)
    }
    if (theme.audioButtonBackgroundColor !== undefined) {
      cjMarkdownTheme.setAudioButtonBackgroundColor(theme.audioButtonBackgroundColor)
    }
    if (theme.audioButtonBorderStyle !== undefined) {
      cjMarkdownTheme.setAudioButtonBorderStyle(theme.audioButtonBorderStyle)
    }
    if (theme.audioButtonBorderWidth !== undefined) {
      cjMarkdownTheme.setAudioButtonBorderWidth(theme.audioButtonBorderWidth)
    }
    if (theme.audioButtonBorderColor !== undefined) {
      cjMarkdownTheme.setAudioButtonBorderColor(theme.audioButtonBorderColor)
    }
    let audioButtonRadiusTopLeft: number = 16.0
    let audioButtonRadiusTopRight: number = 16.0
    let audioButtonRadiusBottomLeft: number = 16.0
    let audioButtonRadiusBottomRight: number = 16.0
    if (theme.audioButtonRadiusTopLeft !== undefined) {
      audioButtonRadiusTopLeft = theme.audioButtonRadiusTopLeft
    }
    if (theme.audioButtonRadiusTopRight !== undefined) {
      audioButtonRadiusTopRight = theme.audioButtonRadiusTopRight
    }
    if (theme.audioButtonRadiusBottomLeft !== undefined) {
      audioButtonRadiusBottomLeft = theme.audioButtonRadiusBottomLeft
    }
    if (theme.audioButtonRadiusBottomRight !== undefined) {
      audioButtonRadiusBottomRight = theme.audioButtonRadiusBottomRight
    }
    cjMarkdownTheme.setAudioButtonRadius(audioButtonRadiusTopLeft, audioButtonRadiusTopRight, audioButtonRadiusBottomLeft, audioButtonRadiusBottomRight)
    if (theme.audioButtonText !== undefined) {
      cjMarkdownTheme.setAudioButtonText(theme.audioButtonText)
    }
    if (theme.audioButtonTextFontColor !== undefined) {
      cjMarkdownTheme.setAudioButtonTextFontColor(theme.audioButtonTextFontColor)
    }
    if (theme.audioButtonTextFontSize !== undefined) {
      cjMarkdownTheme.setAudioButtonTextFontSize(theme.audioButtonTextFontSize)
    }
    if (theme.audioButtonTextFontStyle !== undefined) {
      cjMarkdownTheme.setAudioButtonTextFontStyle(theme.audioButtonTextFontStyle)
    }
    if (theme.audioButtonTextFontWeight !== undefined) {
      cjMarkdownTheme.setAudioButtonTextFontWeight(theme.audioButtonTextFontWeight.toString())
    }
    if (theme.audioButtonTextFontFamily !== undefined) {
      cjMarkdownTheme.setAudioButtonTextFontFamily(theme.audioButtonTextFontFamily)
    }
    if (theme.audioButtonTextLineHeight !== undefined) {
      cjMarkdownTheme.setAudioButtonTextLineHeight(theme.audioButtonTextLineHeight)
    }
    if (theme.audioIconWidth !== undefined) {
      cjMarkdownTheme.setAudioIconWidth(theme.audioIconWidth)
    }
    if (theme.audioIconHeight !== undefined) {
      cjMarkdownTheme.setAudioIconHeight(theme.audioIconHeight)
    }
    let audioIconRadiusTopLeft: number = 8.0
    let audioIconRadiusTopRight: number = 8.0
    let audioIconRadiusBottomLeft: number = 8.0
    let audioIconRadiusBottomRight: number = 8.0
    if (theme.audioIconRadiusTopLeft !== undefined) {
      audioIconRadiusTopLeft = theme.audioIconRadiusTopLeft
    }
    if (theme.audioIconRadiusTopRight !== undefined) {
      audioIconRadiusTopRight = theme.audioIconRadiusTopRight
    }
    if (theme.audioIconRadiusBottomLeft !== undefined) {
      audioIconRadiusBottomLeft = theme.audioIconRadiusBottomLeft
    }
    if (theme.audioIconRadiusBottomRight !== undefined) {
      audioIconRadiusBottomRight = theme.audioIconRadiusBottomRight
    }
    cjMarkdownTheme.setAudioIconRadius(audioIconRadiusTopLeft, audioIconRadiusTopRight, audioIconRadiusBottomLeft, audioIconRadiusBottomRight
    )
    if (theme.audioIconFitType !== undefined) {
      cjMarkdownTheme.setAudioIconFitType(theme.audioIconFitType)
    }
    if (theme.audioTitleTextFontColor !== undefined) {
      cjMarkdownTheme.setAudioTitleTextFontColor(theme.audioTitleTextFontColor)
    }
    if (theme.audioTitleTextFontSize !== undefined) {
      cjMarkdownTheme.setAudioTitleTextFontSize(theme.audioTitleTextFontSize)
    }
    if (theme.audioTitleTextFontStyle !== undefined) {
      cjMarkdownTheme.setAudioTitleTextFontStyle(theme.audioTitleTextFontStyle)
    }
    if (theme.audioTitleTextFontWeight !== undefined) {
      cjMarkdownTheme.setAudioTitleTextFontWeight(theme.audioTitleTextFontWeight.toString())
    }
    if (theme.audioTitleTextFontFamily !== undefined) {
      cjMarkdownTheme.setAudioTitleTextFontFamily(theme.audioTitleTextFontFamily)
    }
    if (theme.audioTitleTextLineHeight !== undefined) {
      cjMarkdownTheme.setAudioTitleTextLineHeight(theme.audioTitleTextLineHeight)
    }
    if (theme.audioTypeTextFontColor !== undefined) {
      cjMarkdownTheme.setAudioTypeTextFontColor(theme.audioTypeTextFontColor)
    }
    if (theme.audioTypeTextFontSize !== undefined) {
      cjMarkdownTheme.setAudioTypeTextFontSize(theme.audioTypeTextFontSize)
    }
    if (theme.audioTypeTextFontStyle !== undefined) {
      cjMarkdownTheme.setAudioTypeTextFontStyle(theme.audioTypeTextFontStyle)
    }
    if (theme.audioTypeTextFontWeight !== undefined) {
      cjMarkdownTheme.setAudioTypeTextFontWeight(theme.audioTypeTextFontWeight.toString())
    }
    if (theme.audioTypeTextFontFamily !== undefined) {
      cjMarkdownTheme.setAudioTypeTextFontFamily(theme.audioTypeTextFontFamily)
    }
    if (theme.audioTypeTextLineHeight !== undefined) {
      cjMarkdownTheme.setAudioTypeTextLineHeight(theme.audioTypeTextLineHeight)
    }
    if (theme.audioTitleToTypeSpacing !== undefined) {
      cjMarkdownTheme.setAudioTitleToTypeSpacing(theme.audioTitleToTypeSpacing)
    }
    return cjMarkdownTheme
  }

  getBannerTheme(theme: MarkdownThemeBanner): CJMarkdownBannerTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownBannerTheme()
    let bannerMarginTop: number = 0.0
    let bannerMarginRight: number = 0.0
    let bannerMarginBottom: number = 0.0
    let bannerMarginLeft: number = 0.0
    if (theme.bannerMarginTop !== undefined) {
      bannerMarginTop = theme.bannerMarginTop
    }
    if (theme.bannerMarginRight !== undefined) {
      bannerMarginRight = theme.bannerMarginRight
    }
    if (theme.bannerMarginBottom !== undefined) {
      bannerMarginBottom = theme.bannerMarginBottom
    }
    if (theme.bannerMarginLeft !== undefined) {
      bannerMarginLeft = theme.bannerMarginLeft
    }
    cjMarkdownTheme.setBannerMargin(bannerMarginTop, bannerMarginRight, bannerMarginBottom, bannerMarginLeft)

    let bannerPaddingTop: number = 0.0
    let bannerPaddingRight: number = 0.0
    let bannerPaddingBottom: number = 0.0
    let bannerPaddingLeft: number = 0.0
    if (theme.bannerPaddingTop !== undefined) {
      bannerPaddingTop = theme.bannerPaddingTop
    }
    if (theme.bannerPaddingRight !== undefined) {
      bannerPaddingRight = theme.bannerPaddingRight
    }
    if (theme.bannerPaddingBottom !== undefined) {
      bannerPaddingBottom = theme.bannerPaddingBottom
    }
    if (theme.bannerPaddingLeft !== undefined) {
      bannerPaddingLeft = theme.bannerPaddingLeft
    }
    cjMarkdownTheme.setBannerPadding(bannerPaddingTop, bannerPaddingRight, bannerPaddingBottom, bannerPaddingLeft)
    return cjMarkdownTheme
  }

  getBlockQuoteTheme(theme: MarkdownThemeBlockQuote): CJMarkdownBlockQuoteTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownBlockQuoteTheme()
    if (theme.blockQuoteBackgroundColor !== undefined) {
      cjMarkdownTheme.setBlockQuoteBackgroundColor(theme.blockQuoteBackgroundColor)
    }
    let blockQuoteMarginTop: number = 0.0
    let blockQuoteMarginRight: number = 0.0
    let blockQuoteMarginBottom: number = 0.0
    let blockQuoteMarginLeft: number = 8.0
    if (theme.blockQuoteMarginTop !== undefined) {
      blockQuoteMarginTop = theme.blockQuoteMarginTop
    }
    if (theme.blockQuoteMarginRight !== undefined) {
      blockQuoteMarginRight = theme.blockQuoteMarginRight
    }
    if (theme.blockQuoteMarginBottom !== undefined) {
      blockQuoteMarginBottom = theme.blockQuoteMarginBottom
    }
    if (theme.blockQuoteMarginLeft !== undefined) {
      blockQuoteMarginLeft = theme.blockQuoteMarginLeft
    }
    cjMarkdownTheme.setBlockQuoteMargin(blockQuoteMarginTop, blockQuoteMarginRight, blockQuoteMarginBottom, blockQuoteMarginLeft)

    let blockQuotePaddingTop: number = 0.0
    let blockQuotePaddingRight: number = 0.0
    let blockQuotePaddingBottom: number = 0.0
    let blockQuotePaddingLeft: number = 0.0
    if (theme.blockQuotePaddingTop !== undefined) {
      blockQuotePaddingTop = theme.blockQuotePaddingTop
    }
    if (theme.blockQuotePaddingRight !== undefined) {
      blockQuotePaddingRight = theme.blockQuotePaddingRight
    }
    if (theme.blockQuotePaddingBottom !== undefined) {
      blockQuotePaddingBottom = theme.blockQuotePaddingBottom
    }
    if (theme.blockQuotePaddingLeft !== undefined) {
      blockQuotePaddingLeft = theme.blockQuotePaddingLeft
    }
    cjMarkdownTheme.setBlockQuotePadding(blockQuotePaddingTop, blockQuotePaddingRight, blockQuotePaddingBottom, blockQuotePaddingLeft)

    let blockQuoteRadiusTopLeft: number = 0.0
    let blockQuoteRadiusTopRight: number = 0.0
    let blockQuoteRadiusBottomLeft: number = 0.0
    let blockQuoteRadiusBottomRight: number = 0.0
    if (theme.blockQuoteRadiusTopLeft !== undefined) {
      blockQuoteRadiusTopLeft = theme.blockQuoteRadiusTopLeft
    }
    if (theme.blockQuoteRadiusTopRight !== undefined) {
      blockQuoteRadiusTopRight = theme.blockQuoteRadiusTopRight
    }
    if (theme.blockQuoteRadiusBottomLeft !== undefined) {
      blockQuoteRadiusBottomLeft = theme.blockQuoteRadiusBottomLeft
    }
    if (theme.blockQuoteRadiusBottomRight !== undefined) {
      blockQuoteRadiusBottomRight = theme.blockQuoteRadiusBottomRight
    }
    cjMarkdownTheme.setBlockQuoteRadius(blockQuoteRadiusTopLeft, blockQuoteRadiusTopRight, blockQuoteRadiusBottomLeft, blockQuoteRadiusBottomRight)
    if (theme.blockQuoteLeftBorderWidth !== undefined) {
      cjMarkdownTheme.setBlockQuoteLeftBorderWidth(theme.blockQuoteLeftBorderWidth)
    }
    if (theme.blockQuoteLeftBorderColor !== undefined) {
      cjMarkdownTheme.setBlockQuoteLeftBorderColor(theme.blockQuoteLeftBorderColor)
    }
    if (theme.blockQuoteBorderContentSpacing !== undefined) {
      cjMarkdownTheme.setBlockQuoteBorderContentSpacing(theme.blockQuoteBorderContentSpacing)
    }
    if (theme.blockQuoteChildSpacing !== undefined) {
      cjMarkdownTheme.setBlockQuoteChildSpacing(theme.blockQuoteChildSpacing)
    }
    return cjMarkdownTheme
  }

  getBoldTheme(theme: MarkdownThemeBold): CJMarkdownBoldTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownBoldTheme()
    if (theme.boldTextFontColor !== undefined) {
      cjMarkdownTheme.setBoldTextFontColor(theme.boldTextFontColor)
    }
    if (theme.boldTextFontSize !== undefined) {
      cjMarkdownTheme.setBoldTextFontSize(theme.boldTextFontSize)
    }
    if (theme.boldTextFontStyle !== undefined) {
      cjMarkdownTheme.setBoldTextFontStyle(theme.boldTextFontStyle)
    }
    if (theme.boldTextFontWeight !== undefined) {
      cjMarkdownTheme.setBoldTextFontWeight(theme.boldTextFontWeight.toString())
    }
    if (theme.boldTextFontFamily !== undefined) {
      cjMarkdownTheme.setBoldTextFontFamily(theme.boldTextFontFamily)
    }
    if (theme.boldTextLineHeight !== undefined) {
      cjMarkdownTheme.setBoldTextLineHeight(theme.boldTextLineHeight)
    }
    if (theme.boldTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setBoldTextLetterSpacing(theme.boldTextLetterSpacing)
    }
    return cjMarkdownTheme
  }

  getBulletListTheme(theme: MarkdownThemeBulletList): CJMarkdownBulletListTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownBulletListTheme()
    if (theme.bulletListBackgroundColor !== undefined) {
      cjMarkdownTheme.setBulletListBackgroundColor(theme.bulletListBackgroundColor)
    }
    let bulletListMarginTop: number = 0.0
    let bulletListMarginRight: number = 0.0
    let bulletListMarginBottom: number = 0.0
    let bulletListMarginLeft: number = 8.0
    if (theme.bulletListMarginTop !== undefined) {
      bulletListMarginTop = theme.bulletListMarginTop
    }
    if (theme.bulletListMarginRight !== undefined) {
      bulletListMarginRight = theme.bulletListMarginRight
    }
    if (theme.bulletListMarginBottom !== undefined) {
      bulletListMarginBottom = theme.bulletListMarginBottom
    }
    if (theme.bulletListMarginLeft !== undefined) {
      bulletListMarginLeft = theme.bulletListMarginLeft
    }
    cjMarkdownTheme.setBulletListMargin(bulletListMarginTop, bulletListMarginRight, bulletListMarginBottom, bulletListMarginLeft)

    let bulletListPaddingTop: number = 0.0
    let bulletListPaddingRight: number = 0.0
    let bulletListPaddingBottom: number = 0.0
    let bulletListPaddingLeft: number = 0.0
    if (theme.bulletListPaddingTop !== undefined) {
      bulletListPaddingTop = theme.bulletListPaddingTop
    }
    if (theme.bulletListPaddingRight !== undefined) {
      bulletListPaddingRight = theme.bulletListPaddingRight
    }
    if (theme.bulletListPaddingBottom !== undefined) {
      bulletListPaddingBottom = theme.bulletListPaddingBottom
    }
    if (theme.bulletListPaddingLeft !== undefined) {
      bulletListPaddingLeft = theme.bulletListPaddingLeft
    }
    cjMarkdownTheme.setBulletListPadding(bulletListPaddingTop, bulletListPaddingRight, bulletListPaddingBottom, bulletListPaddingLeft)
    if (theme.bulletListChildSpacing !== undefined) {
      cjMarkdownTheme.setBulletListChildSpacing(theme.bulletListChildSpacing)
    }
    if (theme.bulletListChildChildSpacing !== undefined) {
      cjMarkdownTheme.setBulletListChildChildSpacing(theme.bulletListChildChildSpacing)
    }
    if (theme.bulletListBulletSpacing !== undefined) {
      cjMarkdownTheme.setBulletListBulletSpacing(theme.bulletListBulletSpacing)
    }
    if (theme.bulletListBulletIsCircle !== undefined) {
      cjMarkdownTheme.setBulletListBulletIsCircle(theme.bulletListBulletIsCircle)
    }
    if (theme.bulletListBulletTextFontColor !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextFontColor(theme.bulletListBulletTextFontColor)
    }
    if (theme.bulletListBulletTextFontSize !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextFontSize(theme.bulletListBulletTextFontSize)
    }
    if (theme.bulletListBulletTextFontStyle !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextFontStyle(theme.bulletListBulletTextFontStyle)
    }
    if (theme.bulletListBulletTextFontWeight !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextFontWeight(theme.bulletListBulletTextFontWeight.toString())
    }
    if (theme.bulletListBulletTextFontFamily !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextFontFamily(theme.bulletListBulletTextFontFamily)
    }
    if (theme.bulletListBulletTextLineHeight !== undefined) {
      cjMarkdownTheme.setBulletListBulletTextLineHeight(theme.bulletListBulletTextLineHeight)
    }
    if (theme.bulletListCheckboxSpacing !== undefined) {
      cjMarkdownTheme.setBulletListCheckboxSpacing(theme.bulletListCheckboxSpacing)
    }
    if (theme.bulletListCheckboxWidth !== undefined) {
      cjMarkdownTheme.setBulletListCheckboxWidth(theme.bulletListCheckboxWidth)
    }
    if (theme.bulletListCheckboxHeight !== undefined) {
      cjMarkdownTheme.setBulletListCheckboxHeight(theme.bulletListCheckboxHeight)
    }
    if (theme.bulletListCheckboxSelectedColor !== undefined) {
      cjMarkdownTheme.setBulletListCheckboxSelectedColor(theme.bulletListCheckboxSelectedColor)
    }
    if (theme.bulletListCheckboxShape !== undefined) {
      cjMarkdownTheme.setBulletListCheckboxShape(theme.bulletListCheckboxShape)
    }
    return cjMarkdownTheme
  }

  getCodeBlockTheme(theme: MarkdownThemeCodeBlock): CJMarkdownCodeBlockTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownCodeBlockTheme()
    if (theme.codeBlockIsCodeFormat !== undefined) {
      cjMarkdownTheme.setCodeBlockIsCodeFormat(theme.codeBlockIsCodeFormat)
    }
    if (theme.codeBlockUseTab !== undefined) {
      cjMarkdownTheme.setCodeBlockUseTab(theme.codeBlockUseTab)
    }
    if (theme.codeBlockIndentWidth !== undefined) {
      cjMarkdownTheme.setCodeBlockIndentWidth(theme.codeBlockIndentWidth)
    }
    if (theme.codeBlockParserSync !== undefined) {
      cjMarkdownTheme.setCodeBlockParserSync(theme.codeBlockParserSync)
    }
    if (theme.codeBlockBackgroundColor !== undefined) {
      cjMarkdownTheme.setCodeBlockBackgroundColor(theme.codeBlockBackgroundColor)
    }
    let codeBlockMarginTop: number = 8.0
    let codeBlockMarginRight: number = 0.0
    let codeBlockMarginBottom: number = 8.0
    let codeBlockMarginLeft: number = 0.0
    if (theme.codeBlockMarginTop !== undefined) {
      codeBlockMarginTop = theme.codeBlockMarginTop
    }
    if (theme.codeBlockMarginRight !== undefined) {
      codeBlockMarginRight = theme.codeBlockMarginRight
    }
    if (theme.codeBlockMarginBottom !== undefined) {
      codeBlockMarginBottom = theme.codeBlockMarginBottom
    }
    if (theme.codeBlockMarginLeft !== undefined) {
      codeBlockMarginLeft = theme.codeBlockMarginLeft
    }
    cjMarkdownTheme.setCodeBlockMargin(codeBlockMarginTop, codeBlockMarginRight, codeBlockMarginBottom, codeBlockMarginLeft)

    let codeBlockPaddingTop: number = 0.0
    let codeBlockPaddingRight: number = 8.0
    let codeBlockPaddingBottom: number = 8.0
    let codeBlockPaddingLeft: number = 0.0
    if (theme.codeBlockPaddingTop !== undefined) {
      codeBlockPaddingTop = theme.codeBlockPaddingTop
    }
    if (theme.codeBlockPaddingRight !== undefined) {
      codeBlockPaddingRight = theme.codeBlockPaddingRight
    }
    if (theme.codeBlockPaddingBottom !== undefined) {
      codeBlockPaddingBottom = theme.codeBlockPaddingBottom
    }
    if (theme.codeBlockPaddingLeft !== undefined) {
      codeBlockPaddingLeft = theme.codeBlockPaddingLeft
    }
    cjMarkdownTheme.setCodeBlockPadding(codeBlockPaddingTop, codeBlockPaddingRight, codeBlockPaddingBottom, codeBlockPaddingLeft)
    if (theme.codeBlockBorderStyle !== undefined) {
      cjMarkdownTheme.setCodeBlockBorderStyle(theme.codeBlockBorderStyle)
    }
    if (theme.codeBlockBorderWidth !== undefined) {
      cjMarkdownTheme.setCodeBlockBorderWidth(theme.codeBlockBorderWidth)
    }
    if (theme.codeBlockBorderColor !== undefined) {
      cjMarkdownTheme.setCodeBlockBorderColor(theme.codeBlockBorderColor)
    }
    let codeBlockRadiusTopLeft: number = 8.0
    let codeBlockRadiusTopRight: number = 8.0
    let codeBlockRadiusBottomLeft: number = 8.0
    let codeBlockRadiusBottomRight: number = 8.0
    if (theme.codeBlockRadiusTopLeft !== undefined) {
      codeBlockRadiusTopLeft = theme.codeBlockRadiusTopLeft
    }
    if (theme.codeBlockRadiusTopRight !== undefined) {
      codeBlockRadiusTopRight = theme.codeBlockRadiusTopRight
    }
    if (theme.codeBlockRadiusBottomLeft !== undefined) {
      codeBlockRadiusBottomLeft = theme.codeBlockRadiusBottomLeft
    }
    if (theme.codeBlockRadiusBottomRight !== undefined) {
      codeBlockRadiusBottomRight = theme.codeBlockRadiusBottomRight
    }
    cjMarkdownTheme.setCodeBlockRadius(codeBlockRadiusTopLeft, codeBlockRadiusTopRight, codeBlockRadiusBottomLeft, codeBlockRadiusBottomRight)
    if (theme.codeBlockTitleLayoutMarginBottom !== undefined) {
      cjMarkdownTheme.setCodeBlockTitleLayoutMarginBottom(theme.codeBlockTitleLayoutMarginBottom)
    }
    if (theme.codeBlockTypeTextMarginLeft !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextMarginLeft(theme.codeBlockTypeTextMarginLeft)
    }
    if (theme.codeBlockTypeText !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeText(theme.codeBlockTypeText)
    }
    if (theme.codeBlockTypeTextFontColor !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextFontColor(theme.codeBlockTypeTextFontColor)
    }
    if (theme.codeBlockTypeTextFontSize !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextFontSize(theme.codeBlockTypeTextFontSize)
    }
    if (theme.codeBlockTypeTextFontStyle !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextFontStyle(theme.codeBlockTypeTextFontStyle)
    }
    if (theme.codeBlockTypeTextFontWeight !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextFontWeight(theme.codeBlockTypeTextFontWeight.toString())
    }
    if (theme.codeBlockTypeTextFontFamily !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextFontFamily(theme.codeBlockTypeTextFontFamily)
    }
    if (theme.codeBlockTypeTextLineHeight !== undefined) {
      cjMarkdownTheme.setCodeBlockTypeTextLineHeight(theme.codeBlockTypeTextLineHeight)
    }
    if (theme.codeBlockCopyFullScreenSpacing !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyFullScreenSpacing(theme.codeBlockCopyFullScreenSpacing)
    }
    if (theme.codeBlockCopyButtonIsShow !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyButtonIsShow(theme.codeBlockCopyButtonIsShow)
    }
    if (theme.codeBlockCopyTextIsShow !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextIsShow(theme.codeBlockCopyTextIsShow)
    }
    if (theme.codeBlockCopyIconWidth !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyIconWidth(theme.codeBlockCopyIconWidth)
    }
    if (theme.codeBlockCopyIconHeight !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyIconHeight(theme.codeBlockCopyIconHeight)
    }
    if (theme.codeBlockCopyIconTextSpacing !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyIconTextSpacing(theme.codeBlockCopyIconTextSpacing)
    }
    if (theme.codeBlockCopyText !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyText(theme.codeBlockCopyText)
    }
    if (theme.codeBlockCopyTextFontColor !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextFontColor(theme.codeBlockCopyTextFontColor)
    }
    if (theme.codeBlockCopyTextFontSize !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextFontSize(theme.codeBlockCopyTextFontSize)
    }
    if (theme.codeBlockCopyTextFontStyle !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextFontStyle(theme.codeBlockCopyTextFontStyle)
    }
    if (theme.codeBlockCopyTextFontWeight !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextFontWeight(theme.codeBlockCopyTextFontWeight.toString())
    }
    if (theme.codeBlockCopyTextFontFamily !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextFontFamily(theme.codeBlockCopyTextFontFamily)
    }
    if (theme.codeBlockCopyTextLineHeight !== undefined) {
      cjMarkdownTheme.setCodeBlockCopyTextLineHeight(theme.codeBlockCopyTextLineHeight)
    }
    if (theme.codeBlockFullScreenButtonIsShow !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenButtonIsShow(theme.codeBlockFullScreenButtonIsShow)
    }
    if (theme.codeBlockFullScreenTextIsShow !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextIsShow(theme.codeBlockFullScreenTextIsShow)
    }
    if (theme.codeBlockFullScreenIconWidth !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenIconWidth(theme.codeBlockFullScreenIconWidth)
    }
    if (theme.codeBlockFullScreenIconHeight !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenIconHeight(theme.codeBlockFullScreenIconHeight)
    }
    if (theme.codeBlockFullScreenIconTextSpacing !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenIconTextSpacing(theme.codeBlockFullScreenIconTextSpacing)
    }
    if (theme.codeBlockFullScreenText !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenText(theme.codeBlockFullScreenText)
    }
    if (theme.codeBlockFullScreenTextFontColor !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextFontColor(theme.codeBlockFullScreenTextFontColor)
    }
    if (theme.codeBlockFullScreenTextFontSize !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextFontSize(theme.codeBlockFullScreenTextFontSize)
    }
    if (theme.codeBlockFullScreenTextFontStyle !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextFontStyle(theme.codeBlockFullScreenTextFontStyle)
    }
    if (theme.codeBlockFullScreenTextFontWeight !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextFontWeight(theme.codeBlockFullScreenTextFontWeight.toString())
    }
    if (theme.codeBlockFullScreenTextFontFamily !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextFontFamily(theme.codeBlockFullScreenTextFontFamily)
    }
    if (theme.codeBlockFullScreenTextLineHeight !== undefined) {
      cjMarkdownTheme.setCodeBlockFullScreenTextLineHeight(theme.codeBlockFullScreenTextLineHeight)
    }
    if (theme.codeBlockLineNumberIsShow !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberIsShow(theme.codeBlockLineNumberIsShow)
    }
    if (theme.codeBlockLineNumberTextPaddingLeft !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextPaddingLeft(theme.codeBlockLineNumberTextPaddingLeft)
    }
    if (theme.codeBlockLineNumberTextFontColor !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextFontColor(theme.codeBlockLineNumberTextFontColor)
    }
    if (theme.codeBlockLineNumberTextFontSize !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextFontSize(theme.codeBlockLineNumberTextFontSize)
    }
    if (theme.codeBlockLineNumberTextFontStyle !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextFontStyle(theme.codeBlockLineNumberTextFontStyle)
    }
    if (theme.codeBlockLineNumberTextFontWeight !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextFontWeight(theme.codeBlockLineNumberTextFontWeight.toString())
    }
    if (theme.codeBlockLineNumberTextFontFamily !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextFontFamily(theme.codeBlockLineNumberTextFontFamily)
    }
    if (theme.codeBlockLineNumberTextLineHeight !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberTextLineHeight(theme.codeBlockLineNumberTextLineHeight)
    }
    if (theme.codeBlockDividerColor !== undefined) {
      cjMarkdownTheme.setCodeBlockDividerColor(theme.codeBlockDividerColor)
    }
    if (theme.codeBlockDividerStrokeWidth !== undefined) {
      cjMarkdownTheme.setCodeBlockDividerStrokeWidth(theme.codeBlockDividerStrokeWidth)
    }
    if (theme.codeBlockLineNumberDividerSpacing !== undefined) {
      cjMarkdownTheme.setCodeBlockLineNumberDividerSpacing(theme.codeBlockLineNumberDividerSpacing)
    }
    if (theme.codeBlockTextFontColor !== undefined) {
      cjMarkdownTheme.setCodeBlockTextFontColor(theme.codeBlockTextFontColor)
    }
    if (theme.codeBlockTextMarginRight !== undefined) {
      cjMarkdownTheme.setCodeBlockTextMarginRight(theme.codeBlockTextMarginRight)
    }
    if (theme.codeBlockTextMarginLeft !== undefined) {
      cjMarkdownTheme.setCodeBlockTextMarginLeft(theme.codeBlockTextMarginLeft)
    }
    if (theme.codeBlockTextFontSize !== undefined) {
      cjMarkdownTheme.setCodeBlockTextFontSize(theme.codeBlockTextFontSize)
    }
    if (theme.codeBlockTextFontStyle !== undefined) {
      cjMarkdownTheme.setCodeBlockTextFontStyle(theme.codeBlockTextFontStyle)
    }
    if (theme.codeBlockTextFontWeight !== undefined) {
      cjMarkdownTheme.setCodeBlockTextFontWeight(theme.codeBlockTextFontWeight.toString())
    }
    if (theme.codeBlockTextFontFamily !== undefined) {
      cjMarkdownTheme.setCodeBlockTextFontFamily(theme.codeBlockTextFontFamily)
    }
    if (theme.codeBlockTextLineHeight !== undefined) {
      cjMarkdownTheme.setCodeBlockTextLineHeight(theme.codeBlockTextLineHeight)
    }
    if (theme.codeBlockTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setCodeBlockTextLetterSpacing(theme.codeBlockTextLetterSpacing)
    }
    if (theme.codeBlockListTitleTextSize !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleTextSize(theme.codeBlockListTitleTextSize)
    }
    if (theme.codeBlockListTitleSelectTextSize !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleSelectTextSize(theme.codeBlockListTitleSelectTextSize)
    }
    if (theme.codeBlockListTitleSelectTextColor !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleSelectTextColor(theme.codeBlockListTitleSelectTextColor)
    }
    if (theme.codeBlockListTitleUnselectTextColor !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleUnselectTextColor(theme.codeBlockListTitleUnselectTextColor)
    }
    if (theme.codeBlockListTitleSelectBackgroundColor !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleSelectBackgroundColor(theme.codeBlockListTitleSelectBackgroundColor)
    }
    if (theme.codeBlockListTitleUnselectBackgroundColor !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleUnselectBackgroundColor(theme.codeBlockListTitleUnselectBackgroundColor)
    }
    if (theme.codeBlockIsSeparate !== undefined) {
      cjMarkdownTheme.setCodeBlockIsSeparate(theme.codeBlockIsSeparate)
    }
    if (theme.codeBlockSeparateWidth !== undefined) {
      cjMarkdownTheme.setCodeBlockSeparateWidth(theme.codeBlockSeparateWidth)
    }
    if (theme.codeBlockSeparateIsBottom !== undefined) {
      cjMarkdownTheme.setCodeBlockSeparateIsBottom(theme.codeBlockSeparateIsBottom)
    }
    return cjMarkdownTheme
  }

  getDefinitionListTheme(theme: MarkdownThemeDefinitionList): CJMarkdownDefinitionListTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownDefinitionListTheme()
    if (theme.definitionListBackgroundColor !== undefined) {
      cjMarkdownTheme.setDefinitionListBackgroundColor(theme.definitionListBackgroundColor)
    }
    let definitionListMarginTop: number = 0.0
    let definitionListMarginRight: number = 0.0
    let definitionListMarginBottom: number = 0.0
    let definitionListMarginLeft: number = 0.0
    if (theme.definitionListMarginTop !== undefined) {
      definitionListMarginTop = theme.definitionListMarginTop
    }
    if (theme.definitionListMarginRight !== undefined) {
      definitionListMarginRight = theme.definitionListMarginRight
    }
    if (theme.definitionListMarginBottom !== undefined) {
      definitionListMarginBottom = theme.definitionListMarginBottom
    }
    if (theme.definitionListMarginLeft !== undefined) {
      definitionListMarginLeft = theme.definitionListMarginLeft
    }
    cjMarkdownTheme.setDefinitionListMargin(definitionListMarginTop, definitionListMarginRight, definitionListMarginBottom, definitionListMarginLeft)

    let definitionListPaddingTop: number = 0.0
    let definitionListPaddingRight: number = 0.0
    let definitionListPaddingBottom: number = 0.0
    let definitionListPaddingLeft: number = 0.0
    if (theme.definitionListPaddingTop !== undefined) {
      definitionListPaddingTop = theme.definitionListPaddingTop
    }
    if (theme.definitionListPaddingRight !== undefined) {
      definitionListPaddingRight = theme.definitionListPaddingRight
    }
    if (theme.definitionListPaddingBottom !== undefined) {
      definitionListPaddingBottom = theme.definitionListPaddingBottom
    }
    if (theme.definitionListPaddingLeft !== undefined) {
      definitionListPaddingLeft = theme.definitionListPaddingLeft
    }
    cjMarkdownTheme.setDefinitionListPadding(definitionListPaddingTop, definitionListPaddingRight, definitionListPaddingBottom, definitionListPaddingLeft)
    if (theme.definitionListTermToDescriptionSpacing !== undefined) {
      cjMarkdownTheme.setDefinitionListTermToDescriptionSpacing(theme.definitionListTermToDescriptionSpacing)
    }
    if (theme.definitionListTermTextFontWeight !== undefined) {
      cjMarkdownTheme.setDefinitionListTermTextFontWeight(theme.definitionListTermTextFontWeight.toString())
    }
    if (theme.definitionListTermTextFontStyle !== undefined) {
      cjMarkdownTheme.setDefinitionListTermTextFontStyle(theme.definitionListTermTextFontStyle)
    }
    if (theme.definitionListDescriptionItemSpacing !== undefined) {
      cjMarkdownTheme.setDefinitionListDescriptionItemSpacing(theme.definitionListDescriptionItemSpacing)
    }
    if (theme.definitionListDescriptionIndent !== undefined) {
      cjMarkdownTheme.setDefinitionListDescriptionIndent(theme.definitionListDescriptionIndent)
    }
    return cjMarkdownTheme
  }

  getDividerTheme(theme: MarkdownThemeDivider): CJMarkdownDividerTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownDividerTheme()
    let dividerMarginTop: number = 0.0
    let dividerMarginRight: number = 0.0
    let dividerMarginBottom: number = 0.0
    let dividerMarginLeft: number = 0.0
    if (theme.dividerMarginTop !== undefined) {
      dividerMarginTop = theme.dividerMarginTop
    }
    if (theme.dividerMarginRight !== undefined) {
      dividerMarginRight = theme.dividerMarginRight
    }
    if (theme.dividerMarginBottom !== undefined) {
      dividerMarginBottom = theme.dividerMarginBottom
    }
    if (theme.dividerMarginLeft !== undefined) {
      dividerMarginLeft = theme.dividerMarginLeft
    }
    cjMarkdownTheme.setDividerMargin(dividerMarginTop, dividerMarginRight, dividerMarginBottom, dividerMarginLeft)

    let dividerPaddingTop: number = 0.0
    let dividerPaddingRight: number = 0.0
    let dividerPaddingBottom: number = 0.0
    let dividerPaddingLeft: number = 0.0
    if (theme.dividerPaddingTop !== undefined) {
      dividerPaddingTop = theme.dividerPaddingTop
    }
    if (theme.dividerPaddingRight !== undefined) {
      dividerPaddingRight = theme.dividerPaddingRight
    }
    if (theme.dividerPaddingBottom !== undefined) {
      dividerPaddingBottom = theme.dividerPaddingBottom
    }
    if (theme.dividerPaddingLeft !== undefined) {
      dividerPaddingLeft = theme.dividerPaddingLeft
    }
    cjMarkdownTheme.setDividerPadding(dividerPaddingTop, dividerPaddingRight, dividerPaddingBottom, dividerPaddingLeft)
    if (theme.dividerColor !== undefined) {
      cjMarkdownTheme.setDividerColor(theme.dividerColor)
    }
    if (theme.dividerStrokeWidth !== undefined) {
      cjMarkdownTheme.setDividerStrokeWidth(theme.dividerStrokeWidth)
    }
    if (theme.dividerStyle !== undefined) {
      cjMarkdownTheme.setDividerStyle(theme.dividerStyle)
    }
    return cjMarkdownTheme
  }

  getFootnoteDefTheme(theme: MarkdownThemeFootnoteDef): CJMarkdownFootnoteDefTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownFootnoteDefTheme()
    if (theme.footnoteDefBackgroundColor !== undefined) {
      cjMarkdownTheme.setFootnoteDefBackgroundColor(theme.footnoteDefBackgroundColor)
    }
    let footnoteDefMarginTop: number = 0.0
    let footnoteDefMarginRight: number = 0.0
    let footnoteDefMarginBottom: number = 0.0
    let footnoteDefMarginLeft: number = 0.0
    if (theme.footnoteDefMarginTop !== undefined) {
      footnoteDefMarginTop = theme.footnoteDefMarginTop
    }
    if (theme.footnoteDefMarginRight !== undefined) {
      footnoteDefMarginRight = theme.footnoteDefMarginRight
    }
    if (theme.footnoteDefMarginBottom !== undefined) {
      footnoteDefMarginBottom = theme.footnoteDefMarginBottom
    }
    if (theme.footnoteDefMarginLeft !== undefined) {
      footnoteDefMarginLeft = theme.footnoteDefMarginLeft
    }
    cjMarkdownTheme.setFootnoteDefMargin(footnoteDefMarginTop, footnoteDefMarginRight, footnoteDefMarginBottom, footnoteDefMarginLeft)

    let footnoteDefPaddingTop: number = 0.0
    let footnoteDefPaddingRight: number = 0.0
    let footnoteDefPaddingBottom: number = 0.0
    let footnoteDefPaddingLeft: number = 0.0
    if (theme.footnoteDefPaddingTop !== undefined) {
      footnoteDefPaddingTop = theme.footnoteDefPaddingTop
    }
    if (theme.footnoteDefPaddingRight !== undefined) {
      footnoteDefPaddingRight = theme.footnoteDefPaddingRight
    }
    if (theme.footnoteDefPaddingBottom !== undefined) {
      footnoteDefPaddingBottom = theme.footnoteDefPaddingBottom
    }
    if (theme.footnoteDefPaddingLeft !== undefined) {
      footnoteDefPaddingLeft = theme.footnoteDefPaddingLeft
    }
    cjMarkdownTheme.setFootnoteDefPadding(footnoteDefPaddingTop, footnoteDefPaddingRight, footnoteDefPaddingBottom, footnoteDefPaddingLeft)
    return cjMarkdownTheme
  }

  getFootnoteRefTheme(theme: MarkdownThemeFootnoteRef): CJMarkdownFootnoteRefTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownFootnoteRefTheme()
    if (theme.footnoteRefTextFontColor !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextFontColor(theme.footnoteRefTextFontColor)
    }
    if (theme.footnoteRefTextFontSize !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextFontSize(theme.footnoteRefTextFontSize)
    }
    if (theme.footnoteRefTextFontStyle !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextFontStyle(theme.footnoteRefTextFontStyle)
    }
    if (theme.footnoteRefTextFontWeight !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextFontWeight(theme.footnoteRefTextFontWeight.toString())
    }
    if (theme.footnoteRefTextFontFamily !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextFontFamily(theme.footnoteRefTextFontFamily)
    }
    if (theme.footnoteRefTextLineHeight !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextLineHeight(theme.footnoteRefTextLineHeight)
    }
    if (theme.footnoteRefTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextLetterSpacing(theme.footnoteRefTextLetterSpacing)
    }
    if (theme.footnoteRefTextDecorationType !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextDecorationType(theme.footnoteRefTextDecorationType)
    }
    if (theme.footnoteRefTextDecorationColor !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextDecorationColor(theme.footnoteRefTextDecorationColor)
    }
    if (theme.footnoteRefTextDecorationStyle !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextDecorationStyle(theme.footnoteRefTextDecorationStyle)
    }
    if (theme.footnoteRefTextBackgroundColor !== undefined) {
      cjMarkdownTheme.setFootnoteRefTextBackgroundColor(theme.footnoteRefTextBackgroundColor)
    }
    let footnoteRefTextBackgroundRadiusTopLeft: number = 0.0
    let footnoteRefTextBackgroundRadiusTopRight: number = 0.0
    let footnoteRefTextBackgroundRadiusBottomLeft: number = 0.0
    let footnoteRefTextBackgroundRadiusBottomRight: number = 0.0
    if (theme.footnoteRefTextBackgroundRadiusTopLeft !== undefined) {
      footnoteRefTextBackgroundRadiusTopLeft = theme.footnoteRefTextBackgroundRadiusTopLeft
    }
    if (theme.footnoteRefTextBackgroundRadiusTopRight !== undefined) {
      footnoteRefTextBackgroundRadiusTopRight = theme.footnoteRefTextBackgroundRadiusTopRight
    }
    if (theme.footnoteRefTextBackgroundRadiusBottomLeft !== undefined) {
      footnoteRefTextBackgroundRadiusBottomLeft = theme.footnoteRefTextBackgroundRadiusBottomLeft
    }
    if (theme.footnoteRefTextBackgroundRadiusBottomRight !== undefined) {
      footnoteRefTextBackgroundRadiusBottomRight = theme.footnoteRefTextBackgroundRadiusBottomRight
    }
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
    if (theme.isMarkdownParserSync !== undefined) {
      cjMarkdownTheme.setIsMarkdownParserSync(theme.isMarkdownParserSync)
    }
    if (theme.isOnCopy !== undefined) {
      cjMarkdownTheme.setIsOnCopy(theme.isOnCopy)
    }
    if (theme.backgroundColor !== undefined) {
      cjMarkdownTheme.setBackgroundColor(theme.backgroundColor)
    }
    let blockMarginTop: number = 0.0
    let blockMarginRight: number = 0.0
    let blockMarginBottom: number = 0.0
    let blockMarginLeft: number = 0.0
    if (theme.blockMarginTop !== undefined) {
      blockMarginTop = theme.blockMarginTop
    }
    if (theme.blockMarginRight !== undefined) {
      blockMarginRight = theme.blockMarginRight
    }
    if (theme.blockMarginBottom !== undefined) {
      blockMarginBottom = theme.blockMarginBottom
    }
    if (theme.blockMarginLeft !== undefined) {
      blockMarginLeft = theme.blockMarginLeft
    }
    cjMarkdownTheme.setGlobalMargin(blockMarginTop, blockMarginRight, blockMarginBottom, blockMarginLeft)
    if (theme.markdownBlockSpacing !== undefined) {
      cjMarkdownTheme.setBlockSpacing(theme.markdownBlockSpacing)
    }
    if (theme.isLineBreak !== undefined) {
      cjMarkdownTheme.setIsLineBreak(theme.isLineBreak)
    }
    if (theme.openGestureSwipe !== undefined) {
      cjMarkdownTheme.setOpenGestureSwipe(theme.openGestureSwipe)
    }
    return cjMarkdownTheme
  }

  getHeadingTheme(theme: MarkdownThemeHeading): CJMarkdownHeadingTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownHeadingTheme()
    // H1
    if (theme.heading1BackgroundColor !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(1, theme.heading1BackgroundColor)
    }
    let heading1MarginTop: number = 0.0
    let heading1MarginRight: number = 0.0
    let heading1MarginBottom: number = 0.0
    let heading1MarginLeft: number = 0.0
    if (theme.heading1MarginTop !== undefined) {
      heading1MarginTop = theme.heading1MarginTop
    }
    if (theme.heading1MarginRight !== undefined) {
      heading1MarginRight = theme.heading1MarginRight
    }
    if (theme.heading1MarginBottom !== undefined) {
      heading1MarginBottom = theme.heading1MarginBottom
    }
    if (theme.heading1MarginLeft !== undefined) {
      heading1MarginLeft = theme.heading1MarginLeft
    }
    cjMarkdownTheme.setMarginForDesignateHeading(1, heading1MarginTop, heading1MarginRight, heading1MarginBottom, heading1MarginLeft)

    let heading1PaddingTop: number = 0.0
    let heading1PaddingRight: number = 0.0
    let heading1PaddingBottom: number = 0.0
    let heading1PaddingLeft: number = 0.0
    if (theme.heading1PaddingTop !== undefined) {
      heading1PaddingTop = theme.heading1PaddingTop
    }
    if (theme.heading1PaddingRight !== undefined) {
      heading1PaddingRight = theme.heading1PaddingRight
    }
    if (theme.heading1PaddingBottom !== undefined) {
      heading1PaddingBottom = theme.heading1PaddingBottom
    }
    if (theme.heading1PaddingLeft !== undefined) {
      heading1PaddingLeft = theme.heading1PaddingLeft
    }
    cjMarkdownTheme.setPaddingForDesignateHeading(1, heading1PaddingTop, heading1PaddingRight, heading1PaddingBottom, heading1PaddingLeft)
    if (theme.heading1TextFontColor !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(1, theme.heading1TextFontColor)
    }
    if (theme.heading1TextFontSize !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(1, theme.heading1TextFontSize)
    }
    if (theme.heading1TextFontStyle !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(1, theme.heading1TextFontStyle)
    }
    if (theme.heading1TextFontWeight !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(1, theme.heading1TextFontWeight)
    }
    if (theme.heading1TextFontFamily !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(1, theme.heading1TextFontFamily)
    }
    if (theme.heading1TextLineHeight !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(1, theme.heading1TextLineHeight)
    }
    if (theme.heading1TextLetterSpacing !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(1, theme.heading1TextLetterSpacing)
    }
    if (theme.heading1UnderlineHeight !== undefined) {
      cjMarkdownTheme.setUnderlineHeightForDesignateHeading(1, theme.heading1UnderlineHeight)
    }
    if (theme.heading1UnderlineColor !== undefined) {
      cjMarkdownTheme.setUnderlineColorForDesignateHeading(1, theme.heading1UnderlineColor)
    }
    if (theme.heading1UnderlineSpacing !== undefined) {
      cjMarkdownTheme.setUnderlineSpacingForDesignateHeading(1, theme.heading1UnderlineSpacing)
    }
    // H2
    if (theme.heading2BackgroundColor !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(2, theme.heading2BackgroundColor)
    }
    let heading2MarginTop: number = 0.0
    let heading2MarginRight: number = 0.0
    let heading2MarginBottom: number = 0.0
    let heading2MarginLeft: number = 0.0
    if (theme.heading2MarginTop !== undefined) {
      heading2MarginTop = theme.heading2MarginTop
    }
    if (theme.heading2MarginRight !== undefined) {
      heading2MarginRight = theme.heading2MarginRight
    }
    if (theme.heading2MarginBottom !== undefined) {
      heading2MarginBottom = theme.heading2MarginBottom
    }
    if (theme.heading2MarginLeft !== undefined) {
      heading2MarginLeft = theme.heading2MarginLeft
    }
    cjMarkdownTheme.setMarginForDesignateHeading(2, heading2MarginTop, heading2MarginRight, heading2MarginBottom, heading2MarginLeft)

    let heading2PaddingTop: number = 0.0
    let heading2PaddingRight: number = 0.0
    let heading2PaddingBottom: number = 0.0
    let heading2PaddingLeft: number = 0.0
    if (theme.heading2PaddingTop !== undefined) {
      heading2PaddingTop = theme.heading2PaddingTop
    }
    if (theme.heading2PaddingRight !== undefined) {
      heading2PaddingRight = theme.heading2PaddingRight
    }
    if (theme.heading2PaddingBottom !== undefined) {
      heading2PaddingBottom = theme.heading2PaddingBottom
    }
    if (theme.heading2PaddingLeft !== undefined) {
      heading2PaddingLeft = theme.heading2PaddingLeft
    }
    cjMarkdownTheme.setPaddingForDesignateHeading(2, heading2PaddingTop, heading2PaddingRight, heading2PaddingBottom, heading2PaddingLeft)
    if (theme.heading2TextFontColor !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(2, theme.heading2TextFontColor)
    }
    if (theme.heading2TextFontSize !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(2, theme.heading2TextFontSize)
    }
    if (theme.heading2TextFontStyle !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(2, theme.heading2TextFontStyle)
    }
    if (theme.heading2TextFontWeight !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(2, theme.heading2TextFontWeight)
    }
    if (theme.heading2TextFontFamily !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(2, theme.heading2TextFontFamily)
    }
    if (theme.heading2TextLineHeight !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(2, theme.heading2TextLineHeight)
    }
    if (theme.heading2TextLetterSpacing !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(2, theme.heading2TextLetterSpacing)
    }
    if (theme.heading2UnderlineHeight !== undefined) {
      cjMarkdownTheme.setUnderlineHeightForDesignateHeading(2, theme.heading2UnderlineHeight)
    }
    if (theme.heading2UnderlineColor !== undefined) {
      cjMarkdownTheme.setUnderlineColorForDesignateHeading(2, theme.heading2UnderlineColor)
    }
    if (theme.heading2UnderlineSpacing !== undefined) {
      cjMarkdownTheme.setUnderlineSpacingForDesignateHeading(2, theme.heading2UnderlineSpacing)
    }
    // H3
    if (theme.heading3BackgroundColor !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(3, theme.heading3BackgroundColor)
    }
    let heading3MarginTop: number = 0.0
    let heading3MarginRight: number = 0.0
    let heading3MarginBottom: number = 0.0
    let heading3MarginLeft: number = 0.0
    if (theme.heading3MarginTop !== undefined) {
      heading3MarginTop = theme.heading3MarginTop
    }
    if (theme.heading3MarginRight !== undefined) {
      heading3MarginRight = theme.heading3MarginRight
    }
    if (theme.heading3MarginBottom !== undefined) {
      heading3MarginBottom = theme.heading3MarginBottom
    }
    if (theme.heading3MarginLeft !== undefined) {
      heading3MarginLeft = theme.heading3MarginLeft
    }
    cjMarkdownTheme.setMarginForDesignateHeading(3, heading3MarginTop, heading3MarginRight, heading3MarginBottom, heading3MarginLeft)

    let heading3PaddingTop: number = 0.0
    let heading3PaddingRight: number = 0.0
    let heading3PaddingBottom: number = 0.0
    let heading3PaddingLeft: number = 0.0
    if (theme.heading3PaddingTop !== undefined) {
      heading3PaddingTop = theme.heading3PaddingTop
    }
    if (theme.heading3PaddingRight !== undefined) {
      heading3PaddingRight = theme.heading3PaddingRight
    }
    if (theme.heading3PaddingBottom !== undefined) {
      heading3PaddingBottom = theme.heading3PaddingBottom
    }
    if (theme.heading3PaddingLeft !== undefined) {
      heading3PaddingLeft = theme.heading3PaddingLeft
    }
    cjMarkdownTheme.setPaddingForDesignateHeading(3, heading3PaddingTop, heading3PaddingRight, heading3PaddingBottom, heading3PaddingLeft)
    if (theme.heading3TextFontColor !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(3, theme.heading3TextFontColor)
    }
    if (theme.heading3TextFontSize !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(3, theme.heading3TextFontSize)
    }
    if (theme.heading3TextFontStyle !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(3, theme.heading3TextFontStyle)
    }
    if (theme.heading3TextFontWeight !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(3, theme.heading3TextFontWeight)
    }
    if (theme.heading3TextFontFamily !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(3, theme.heading3TextFontFamily)
    }
    if (theme.heading3TextLineHeight !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(3, theme.heading3TextLineHeight)
    }
    if (theme.heading3TextLetterSpacing !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(3, theme.heading3TextLetterSpacing)
    }
    // H4
    if (theme.heading4BackgroundColor !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(4, theme.heading4BackgroundColor)
    }
    let heading4MarginTop: number = 0.0
    let heading4MarginRight: number = 0.0
    let heading4MarginBottom: number = 0.0
    let heading4MarginLeft: number = 0.0
    if (theme.heading4MarginTop !== undefined) {
      heading4MarginTop = theme.heading4MarginTop
    }
    if (theme.heading4MarginRight !== undefined) {
      heading4MarginRight = theme.heading4MarginRight
    }
    if (theme.heading4MarginBottom !== undefined) {
      heading4MarginBottom = theme.heading4MarginBottom
    }
    if (theme.heading4MarginLeft !== undefined) {
      heading4MarginLeft = theme.heading4MarginLeft
    }
    cjMarkdownTheme.setMarginForDesignateHeading(4, heading4MarginTop, heading4MarginRight, heading4MarginBottom, heading4MarginLeft)

    let heading4PaddingTop: number = 0.0
    let heading4PaddingRight: number = 0.0
    let heading4PaddingBottom: number = 0.0
    let heading4PaddingLeft: number = 0.0
    if (theme.heading4PaddingTop !== undefined) {
      heading4PaddingTop = theme.heading4PaddingTop
    }
    if (theme.heading4PaddingRight !== undefined) {
      heading4PaddingRight = theme.heading4PaddingRight
    }
    if (theme.heading4PaddingBottom !== undefined) {
      heading4PaddingBottom = theme.heading4PaddingBottom
    }
    if (theme.heading4PaddingLeft !== undefined) {
      heading4PaddingLeft = theme.heading4PaddingLeft
    }
    cjMarkdownTheme.setPaddingForDesignateHeading(4, heading4PaddingTop, heading4PaddingRight, heading4PaddingBottom, heading4PaddingLeft)
    if (theme.heading4TextFontColor !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(4, theme.heading4TextFontColor)
    }
    if (theme.heading4TextFontSize !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(4, theme.heading4TextFontSize)
    }
    if (theme.heading4TextFontStyle !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(4, theme.heading4TextFontStyle)
    }
    if (theme.heading4TextFontWeight !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(4, theme.heading4TextFontWeight)
    }
    if (theme.heading4TextFontFamily !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(4, theme.heading4TextFontFamily)
    }
    if (theme.heading4TextLineHeight !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(4, theme.heading4TextLineHeight)
    }
    if (theme.heading4TextLetterSpacing !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(4, theme.heading4TextLetterSpacing)
    }
    // H5
    if (theme.heading5BackgroundColor !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(5, theme.heading5BackgroundColor)
    }
    let heading5MarginTop: number = 0.0
    let heading5MarginRight: number = 0.0
    let heading5MarginBottom: number = 0.0
    let heading5MarginLeft: number = 0.0
    if (theme.heading5MarginTop !== undefined) {
      heading5MarginTop = theme.heading5MarginTop
    }
    if (theme.heading5MarginRight !== undefined) {
      heading5MarginRight = theme.heading5MarginRight
    }
    if (theme.heading5MarginBottom !== undefined) {
      heading5MarginBottom = theme.heading5MarginBottom
    }
    if (theme.heading5MarginLeft !== undefined) {
      heading5MarginLeft = theme.heading5MarginLeft
    }
    cjMarkdownTheme.setMarginForDesignateHeading(5, heading5MarginTop, heading5MarginRight, heading5MarginBottom, heading5MarginLeft)

    let heading5PaddingTop: number = 0.0
    let heading5PaddingRight: number = 0.0
    let heading5PaddingBottom: number = 0.0
    let heading5PaddingLeft: number = 0.0
    if (theme.heading5PaddingTop !== undefined) {
      heading5PaddingTop = theme.heading5PaddingTop
    }
    if (theme.heading5PaddingRight !== undefined) {
      heading5PaddingRight = theme.heading5PaddingRight
    }
    if (theme.heading5PaddingBottom !== undefined) {
      heading5PaddingBottom = theme.heading5PaddingBottom
    }
    if (theme.heading5PaddingLeft !== undefined) {
      heading5PaddingLeft = theme.heading5PaddingLeft
    }
    cjMarkdownTheme.setPaddingForDesignateHeading(5, heading5PaddingTop, heading5PaddingRight, heading5PaddingBottom, heading5PaddingLeft)
    if (theme.heading5TextFontColor !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(5, theme.heading5TextFontColor)
    }
    if (theme.heading5TextFontSize !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(5, theme.heading5TextFontSize)
    }
    if (theme.heading5TextFontStyle !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(5, theme.heading5TextFontStyle)
    }
    if (theme.heading5TextFontWeight !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(5, theme.heading5TextFontWeight)
    }
    if (theme.heading5TextFontFamily !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(5, theme.heading5TextFontFamily)
    }
    if (theme.heading5TextLineHeight !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(5, theme.heading5TextLineHeight)
    }
    if (theme.heading5TextLetterSpacing !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(5, theme.heading5TextLetterSpacing)
    }
    // H6
    if (theme.heading6BackgroundColor !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(6, theme.heading6BackgroundColor)
    }
    let heading6MarginTop: number = 0.0
    let heading6MarginRight: number = 0.0
    let heading6MarginBottom: number = 0.0
    let heading6MarginLeft: number = 0.0
    if (theme.heading6MarginTop !== undefined) {
      heading6MarginTop = theme.heading6MarginTop
    }
    if (theme.heading6MarginRight !== undefined) {
      heading6MarginRight = theme.heading6MarginRight
    }
    if (theme.heading6MarginBottom !== undefined) {
      heading6MarginBottom = theme.heading6MarginBottom
    }
    if (theme.heading6MarginLeft !== undefined) {
      heading6MarginLeft = theme.heading6MarginLeft
    }
    cjMarkdownTheme.setMarginForDesignateHeading(6, heading6MarginTop, heading6MarginRight, heading6MarginBottom, heading6MarginLeft)

    let heading6PaddingTop: number = 0.0
    let heading6PaddingRight: number = 0.0
    let heading6PaddingBottom: number = 0.0
    let heading6PaddingLeft: number = 0.0
    if (theme.heading6PaddingTop !== undefined) {
      heading6PaddingTop = theme.heading6PaddingTop
    }
    if (theme.heading6PaddingRight !== undefined) {
      heading6PaddingRight = theme.heading6PaddingRight
    }
    if (theme.heading6PaddingBottom !== undefined) {
      heading6PaddingBottom = theme.heading6PaddingBottom
    }
    if (theme.heading6PaddingLeft !== undefined) {
      heading6PaddingLeft = theme.heading6PaddingLeft
    }
    cjMarkdownTheme.setPaddingForDesignateHeading(6, heading6PaddingTop, heading6PaddingRight, heading6PaddingBottom, heading6PaddingLeft)
    if (theme.heading6TextFontColor !== undefined) {
      cjMarkdownTheme.setTextFontColorForDesignateHeading(6, theme.heading6TextFontColor)
    }
    if (theme.heading6TextFontSize !== undefined) {
      cjMarkdownTheme.setTextFontSizeForDesignateHeading(6, theme.heading6TextFontSize)
    }
    if (theme.heading6TextFontStyle !== undefined) {
      cjMarkdownTheme.setTextFontStyleForDesignateHeading(6, theme.heading6TextFontStyle)
    }
    if (theme.heading6TextFontWeight !== undefined) {
      cjMarkdownTheme.setTextFontWeightForDesignateHeading(6, theme.heading6TextFontWeight)
    }
    if (theme.heading6TextFontFamily !== undefined) {
      cjMarkdownTheme.setTextFontFamilyForDesignateHeading(6, theme.heading6TextFontFamily)
    }
    if (theme.heading6TextLineHeight !== undefined) {
      cjMarkdownTheme.setTextLineHeightForDesignateHeading(6, theme.heading6TextLineHeight)
    }
    if (theme.heading6TextLetterSpacing !== undefined) {
      cjMarkdownTheme.setTextLetterSpacingForDesignateHeading(6, theme.heading6TextLetterSpacing)
    }
    return cjMarkdownTheme
  }

  getHtmlUnderlineTheme(theme: MarkdownThemeHtmlUnderline): CJMarkdownHtmlUnderlineTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownHtmlUnderlineTheme()
    if (theme.htmlUnderlineTextFontColor !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextFontColor(theme.htmlUnderlineTextFontColor)
    }
    if (theme.htmlUnderlineTextFontSize !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextFontSize(theme.htmlUnderlineTextFontSize)
    }
    if (theme.htmlUnderlineTextFontStyle !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextFontStyle(theme.htmlUnderlineTextFontStyle)
    }
    if (theme.htmlUnderlineTextFontWeight !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextFontWeight(theme.htmlUnderlineTextFontWeight.toString())
    }
    if (theme.htmlUnderlineTextFontFamily !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextFontFamily(theme.htmlUnderlineTextFontFamily)
    }
    if (theme.htmlUnderlineTextLineHeight !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextLineHeight(theme.htmlUnderlineTextLineHeight)
    }
    if (theme.htmlUnderlineTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextLetterSpacing(theme.htmlUnderlineTextLetterSpacing)
    }
    if (theme.htmlUnderlineTextDecorationColor !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextDecorationColor(theme.htmlUnderlineTextDecorationColor)
    }
    if (theme.htmlUnderlineTextDecorationStyle !== undefined) {
      cjMarkdownTheme.setHtmlUnderlineTextDecorationStyle(theme.htmlUnderlineTextDecorationStyle)
    }
    return cjMarkdownTheme
  }

  getImageTheme(theme: MarkdownThemeImage): CJMarkdownImageTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownImageTheme()
    let imageMarginTop: number = 0.0
    let imageMarginRight: number = 0.0
    let imageMarginBottom: number = 0.0
    let imageMarginLeft: number = 0.0
    if (theme.imageMarginTop !== undefined) {
      imageMarginTop = theme.imageMarginTop
    }
    if (theme.imageMarginRight !== undefined) {
      imageMarginRight = theme.imageMarginRight
    }
    if (theme.imageMarginBottom !== undefined) {
      imageMarginBottom = theme.imageMarginBottom
    }
    if (theme.imageMarginLeft !== undefined) {
      imageMarginLeft = theme.imageMarginLeft
    }
    cjMarkdownTheme.setImageMargin(imageMarginTop, imageMarginRight, imageMarginBottom, imageMarginLeft)

    let imageRadiusTopLeft: number = 0.0
    let imageRadiusTopRight: number = 0.0
    let imageRadiusBottomLeft: number = 0.0
    let imageRadiusBottomRight: number = 0.0
    if (theme.imageRadiusTopLeft !== undefined) {
      imageRadiusTopLeft = theme.imageRadiusTopLeft
    }
    if (theme.imageRadiusTopRight !== undefined) {
      imageRadiusTopRight = theme.imageRadiusTopRight
    }
    if (theme.imageRadiusBottomLeft !== undefined) {
      imageRadiusBottomLeft = theme.imageRadiusBottomLeft
    }
    if (theme.imageRadiusBottomRight !== undefined) {
      imageRadiusBottomRight = theme.imageRadiusBottomRight
    }
    cjMarkdownTheme.setImageBorderRadius(imageRadiusTopLeft, imageRadiusTopRight, imageRadiusBottomLeft, imageRadiusBottomRight)
    if (theme.imageBorderStyle !== undefined) {
      cjMarkdownTheme.setImageBorderStyle(theme.imageBorderStyle)
    }
    if (theme.imageBorderWidth !== undefined) {
      cjMarkdownTheme.setImageBorderWidth(theme.imageBorderWidth)
    }
    if (theme.imageBorderColor !== undefined) {
      cjMarkdownTheme.setImageBorderColor(theme.imageBorderColor)
    }
    if (theme.imageAutoResize !== undefined) {
      cjMarkdownTheme.setImageAutoResize(theme.imageAutoResize)
    }
    if (theme.isImageMixedLayout !== undefined) {
      cjMarkdownTheme.setIsImageMixedLayout(theme.isImageMixedLayout)
    }
    if (theme.imageMaximumWidth !== undefined) {
      cjMarkdownTheme.setImageMaximumWidth(theme.imageMaximumWidth)
    }
    if (theme.imageFixedRatioWidth !== undefined) {
      cjMarkdownTheme.setImageFixedRatioWidth(theme.imageFixedRatioWidth)
    }
    if (theme.imageMaxHeight !== undefined) {
      cjMarkdownTheme.setImageMaxHeight(theme.imageMaxHeight)
    }
    if (theme.imageHeight !== undefined) {
      cjMarkdownTheme.setImageHeight(theme.imageHeight)
    }
    if (theme.imageMaxWidth !== undefined) {
      cjMarkdownTheme.setImageMaxWidth(theme.imageMaxWidth)
    }
    if (theme.imageWidth !== undefined) {
      cjMarkdownTheme.setImageWidth(theme.imageWidth)
    }
    if (theme.imageFitType !== undefined) {
      cjMarkdownTheme.setImageFitType(theme.imageFitType)
    }
    if (theme.imageBottomLayoutMarginTop !== undefined) {
      cjMarkdownTheme.setImageBottomLayoutMarginTop(theme.imageBottomLayoutMarginTop)
    }
    if (theme.imageDownloadButtonVisible !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonVisible(theme.imageDownloadButtonVisible)
    }
    if (theme.imageDownloadButtonWidth !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonWidth(theme.imageDownloadButtonWidth)
    }
    if (theme.imageDownloadButtonHeight !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonHeight(theme.imageDownloadButtonHeight)
    }
    let imageDownloadButtonRadiusTopLeft: number = 22.0
    let imageDownloadButtonRadiusTopRight: number = 22.0
    let imageDownloadButtonRadiusBottomLeft: number = 22.0
    let imageDownloadButtonRadiusBottomRight: number = 22.0
    if (theme.imageDownloadButtonRadiusTopLeft !== undefined) {
      imageDownloadButtonRadiusTopLeft = theme.imageDownloadButtonRadiusTopLeft
    }
    if (theme.imageDownloadButtonRadiusTopRight !== undefined) {
      imageDownloadButtonRadiusTopRight = theme.imageDownloadButtonRadiusTopRight
    }
    if (theme.imageDownloadButtonRadiusBottomLeft !== undefined) {
      imageDownloadButtonRadiusBottomLeft = theme.imageDownloadButtonRadiusBottomLeft
    }
    if (theme.imageDownloadButtonRadiusBottomRight !== undefined) {
      imageDownloadButtonRadiusBottomRight = theme.imageDownloadButtonRadiusBottomRight
    }
    cjMarkdownTheme.setImageDownloadButtonRadius(
      imageDownloadButtonRadiusTopLeft,
      imageDownloadButtonRadiusTopRight,
      imageDownloadButtonRadiusBottomLeft,
      imageDownloadButtonRadiusBottomRight
    )
    if (theme.imageDownloadButtonIconWidth !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonIconWidth(theme.imageDownloadButtonIconWidth)
    }
    if (theme.imageDownloadButtonIconHeight !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonIconHeight(theme.imageDownloadButtonIconHeight)
    }
    if (theme.imageDownloadButtonIconTextGap !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonIconTextGap(theme.imageDownloadButtonIconTextGap)
    }
    if (theme.imageDownloadButtonBackgroundColor !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonBackgroundColor(theme.imageDownloadButtonBackgroundColor)
    }
    if (theme.imageDownloadButtonText !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonText(theme.imageDownloadButtonText)
    }
    if (theme.imageDownloadButtonTextFontColor !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextFontColor(theme.imageDownloadButtonTextFontColor)
    }
    if (theme.imageDownloadButtonTextFontSize !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextFontSize(theme.imageDownloadButtonTextFontSize)
    }
    if (theme.imageDownloadButtonTextFontStyle !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextFontStyle(theme.imageDownloadButtonTextFontStyle)
    }
    if (theme.imageDownloadButtonTextFontWeight !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextFontWeight(theme.imageDownloadButtonTextFontWeight.toString())
    }
    if (theme.imageDownloadButtonTextFontFamily !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextFontFamily(theme.imageDownloadButtonTextFontFamily)
    }
    if (theme.imageDownloadButtonTextLineHeight !== undefined) {
      cjMarkdownTheme.setImageDownloadButtonTextLineHeight(theme.imageDownloadButtonTextLineHeight)
    }
    return cjMarkdownTheme
  }

  getInlineCodeTheme(theme: MarkdownThemeInlineCode): CJMarkdownInlineCodeTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownInlineCodeTheme()
    if (theme.inlineCodeTextFontColor !== undefined) {
      cjMarkdownTheme.setInlineCodeTextFontColor(theme.inlineCodeTextFontColor)
    }
    if (theme.inlineCodeTextFontSize !== undefined) {
      cjMarkdownTheme.setInlineCodeTextFontSize(theme.inlineCodeTextFontSize)
    }
    if (theme.inlineCodeTextFontStyle !== undefined) {
      cjMarkdownTheme.setInlineCodeTextFontStyle(theme.inlineCodeTextFontStyle)
    }
    if (theme.inlineCodeTextFontWeight !== undefined) {
      cjMarkdownTheme.setInlineCodeTextFontWeight(theme.inlineCodeTextFontWeight.toString())
    }
    if (theme.inlineCodeTextFontFamily !== undefined) {
      cjMarkdownTheme.setInlineCodeTextFontFamily(theme.inlineCodeTextFontFamily)
    }
    if (theme.inlineCodeTextLineHeight !== undefined) {
      cjMarkdownTheme.setInlineCodeTextLineHeight(theme.inlineCodeTextLineHeight)
    }
    if (theme.inlineCodeTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setInlineCodeTextLetterSpacing(theme.inlineCodeTextLetterSpacing)
    }
    if (theme.inlineCodeTextBackgroundColor !== undefined) {
      cjMarkdownTheme.setInlineCodeTextBackgroundColor(theme.inlineCodeTextBackgroundColor)
    }
    let inlineCodeTextBackgroundRadiusTopLeft: number = 0.0
    let inlineCodeTextBackgroundRadiusTopRight: number = 0.0
    let inlineCodeTextBackgroundRadiusBottomLeft: number = 0.0
    let inlineCodeTextBackgroundRadiusBottomRight: number = 0.0
    if (theme.inlineCodeTextBackgroundRadiusTopLeft !== undefined) {
      inlineCodeTextBackgroundRadiusTopLeft = theme.inlineCodeTextBackgroundRadiusTopLeft
    }
    if (theme.inlineCodeTextBackgroundRadiusTopRight !== undefined) {
      inlineCodeTextBackgroundRadiusTopRight = theme.inlineCodeTextBackgroundRadiusTopRight
    }
    if (theme.inlineCodeTextBackgroundRadiusBottomLeft !== undefined) {
      inlineCodeTextBackgroundRadiusBottomLeft = theme.inlineCodeTextBackgroundRadiusBottomLeft
    }
    if (theme.inlineCodeTextBackgroundRadiusBottomRight !== undefined) {
      inlineCodeTextBackgroundRadiusBottomRight = theme.inlineCodeTextBackgroundRadiusBottomRight
    }
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
    if (theme.italicTextFontColor !== undefined) {
      cjMarkdownTheme.setItalicTextFontColor(theme.italicTextFontColor)
    }
    if (theme.italicTextFontSize !== undefined) {
      cjMarkdownTheme.setItalicTextFontSize(theme.italicTextFontSize)
    }
    if (theme.italicTextFontWeight !== undefined) {
      cjMarkdownTheme.setItalicTextFontWeight(theme.italicTextFontWeight.toString())
    }
    if (theme.italicTextFontFamily !== undefined) {
      cjMarkdownTheme.setItalicTextFontFamily(theme.italicTextFontFamily)
    }
    if (theme.italicTextLineHeight !== undefined) {
      cjMarkdownTheme.setItalicTextLineHeight(theme.italicTextLineHeight)
    }
    if (theme.italicTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setItalicTextLetterSpacing(theme.italicTextLetterSpacing)
    }
    return cjMarkdownTheme
  }

  getLatexMathTheme(theme: MarkdownThemeLatexMath): CJMarkdownLatexMathTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownLatexMathTheme()
    let latexMathMarginTop: number = 0.0
    let latexMathMarginRight: number = 0.0
    let latexMathMarginBottom: number = 0.0
    let latexMathMarginLeft: number = 0.0
    if (theme.latexMathMarginTop !== undefined) {
      latexMathMarginTop = theme.latexMathMarginTop
    }
    if (theme.latexMathMarginRight !== undefined) {
      latexMathMarginRight = theme.latexMathMarginRight
    }
    if (theme.latexMathMarginBottom !== undefined) {
      latexMathMarginBottom = theme.latexMathMarginBottom
    }
    if (theme.latexMathMarginLeft !== undefined) {
      latexMathMarginLeft = theme.latexMathMarginLeft
    }
    cjMarkdownTheme.setLatexMathMargin(latexMathMarginTop, latexMathMarginRight, latexMathMarginBottom, latexMathMarginLeft)

    let latexMathPaddingTop: number = 0.0
    let latexMathPaddingRight: number = 0.0
    let latexMathPaddingBottom: number = 0.0
    let latexMathPaddingLeft: number = 0.0
    if (theme.latexMathPaddingTop !== undefined) {
      latexMathPaddingTop = theme.latexMathPaddingTop
    }
    if (theme.latexMathPaddingRight !== undefined) {
      latexMathPaddingRight = theme.latexMathPaddingRight
    }
    if (theme.latexMathPaddingBottom !== undefined) {
      latexMathPaddingBottom = theme.latexMathPaddingBottom
    }
    if (theme.latexMathPaddingLeft !== undefined) {
      latexMathPaddingLeft = theme.latexMathPaddingLeft
    }
    cjMarkdownTheme.setLatexMathPadding(latexMathPaddingTop, latexMathPaddingRight, latexMathPaddingBottom, latexMathPaddingLeft)
    if (theme.latexMathDefaultText !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultText(theme.latexMathDefaultText)
    }
    if (theme.latexMathDefaultTextFontColor !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultTextFontColor(theme.latexMathDefaultTextFontColor)
    }
    if (theme.latexMathDefaultTextFontSize !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultTextFontSize(theme.latexMathDefaultTextFontSize)
    }
    if (theme.latexMathDefaultTextFontStyle !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultTextFontStyle(theme.latexMathDefaultTextFontStyle)
    }
    if (theme.latexMathDefaultTextFontWeight !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultTextFontWeight(theme.latexMathDefaultTextFontWeight.toString())
    }
    if (theme.latexMathDefaultTextFontFamily !== undefined) {
      cjMarkdownTheme.setLatexMathDefaultTextFontFamily(theme.latexMathDefaultTextFontFamily)
    }
    if (theme.latexMathTextSize !== undefined) {
      cjMarkdownTheme.setLatexMathTextSize(theme.latexMathTextSize)
    }
    if (theme.latexMathBackgroundColor !== undefined) {
      cjMarkdownTheme.setLatexMathBackgroundColor(theme.latexMathBackgroundColor)
    }
    if (theme.latexMathTextColor !== undefined) {
      cjMarkdownTheme.setLatexMathTextColor(theme.latexMathTextColor)
    }
    if (theme.latexMathColorFormat !== undefined) {
      cjMarkdownTheme.setLatexMathColorFormat(theme.latexMathColorFormat)
    }
    if (theme.latexMathBlockCenter !== undefined) {
      cjMarkdownTheme.setLatexMathBlockCenter(theme.latexMathBlockCenter)
    }
    if (theme.latexMathResPath !== undefined) {
      cjMarkdownTheme.setLatexMathResPath(theme.latexMathResPath)
    }
    return cjMarkdownTheme
  }

  getLinkTheme(theme: MarkdownThemeLink): CJMarkdownLinkTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownLinkTheme()
    if (theme.linkIsIcon !== undefined) {
      cjMarkdownTheme.setLinkIsIcon(theme.linkIsIcon)
    }
    if (theme.linkListIsIcon !== undefined) {
      cjMarkdownTheme.setLinkListIsIcon(theme.linkListIsIcon)
    }
    if (theme.linkTextFontColor !== undefined) {
      cjMarkdownTheme.setLinkTextFontColor(theme.linkTextFontColor)
    }
    if (theme.linkTextFontSize !== undefined) {
      cjMarkdownTheme.setLinkTextFontSize(theme.linkTextFontSize)
    }
    if (theme.linkTextFontStyle !== undefined) {
      cjMarkdownTheme.setLinkTextFontStyle(theme.linkTextFontStyle)
    }
    if (theme.linkTextFontWeight !== undefined) {
      cjMarkdownTheme.setLinkTextFontWeight(theme.linkTextFontWeight.toString())
    }
    if (theme.linkTextFontFamily !== undefined) {
      cjMarkdownTheme.setLinkTextFontFamily(theme.linkTextFontFamily)
    }
    if (theme.linkTextLineHeight !== undefined) {
      cjMarkdownTheme.setLinkTextLineHeight(theme.linkTextLineHeight)
    }
    if (theme.linkTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setLinkTextLetterSpacing(theme.linkTextLetterSpacing)
    }
    if (theme.linkTextDecorationType !== undefined) {
      cjMarkdownTheme.setLinkTextDecorationType(theme.linkTextDecorationType)
    }
    if (theme.linkTextDecorationColor !== undefined) {
      cjMarkdownTheme.setLinkTextDecorationColor(theme.linkTextDecorationColor)
    }
    if (theme.linkTextDecorationStyle !== undefined) {
      cjMarkdownTheme.setLinkTextDecorationStyle(theme.linkTextDecorationStyle)
    }
    if (theme.linkTextBackgroundColor !== undefined) {
      cjMarkdownTheme.setLinkTextBackgroundColor(theme.linkTextBackgroundColor)
    }
    let linkTextBackgroundRadiusTopLeft: number = 0.0
    let linkTextBackgroundRadiusTopRight: number = 0.0
    let linkTextBackgroundRadiusBottomLeft: number = 0.0
    let linkTextBackgroundRadiusBottomRight: number = 0.0
    if (theme.linkTextBackgroundRadiusTopLeft !== undefined) {
      linkTextBackgroundRadiusTopLeft = theme.linkTextBackgroundRadiusTopLeft
    }
    if (theme.linkTextBackgroundRadiusTopRight !== undefined) {
      linkTextBackgroundRadiusTopRight = theme.linkTextBackgroundRadiusTopRight
    }
    if (theme.linkTextBackgroundRadiusBottomLeft !== undefined) {
      linkTextBackgroundRadiusBottomLeft = theme.linkTextBackgroundRadiusBottomLeft
    }
    if (theme.linkTextBackgroundRadiusBottomRight !== undefined) {
      linkTextBackgroundRadiusBottomRight = theme.linkTextBackgroundRadiusBottomRight
    }
    cjMarkdownTheme.setLinkTextBackgroundRadius(
      linkTextBackgroundRadiusTopLeft,
      linkTextBackgroundRadiusTopRight,
      linkTextBackgroundRadiusBottomLeft,
      linkTextBackgroundRadiusBottomRight
    )
    if (theme.linkCircleIconBackgroundColor !== undefined) {
      cjMarkdownTheme.setLinkCircleIconBackgroundColor(theme.linkCircleIconBackgroundColor)
    }
    if (theme.linkCircleIconButtonBackgroundColor !== undefined) {
      cjMarkdownTheme.setLinkCircleIconButtonBackgroundColor(theme.linkCircleIconButtonBackgroundColor)
    }
    if (theme.linkCircleIconTextSize !== undefined) {
      cjMarkdownTheme.setLinkCircleIconTextSize(theme.linkCircleIconTextSize)
    }
    if (theme.linkCircleIconTextColor !== undefined) {
      cjMarkdownTheme.setLinkCircleIconTextColor(theme.linkCircleIconTextColor)
    }
    if (theme.linkCircleIconRadius !== undefined) {
      cjMarkdownTheme.setLinkCircleIconRadius(theme.linkCircleIconRadius)
    }
    if (theme.linkCircleIconMargin !== undefined) {
      cjMarkdownTheme.setLinkCircleIconMargin(theme.linkCircleIconMargin)
    }
    if (theme.linkRectIconBackgroundColor !== undefined) {
      cjMarkdownTheme.setLinkRectIconBackgroundColor(theme.linkRectIconBackgroundColor)
    }
    if (theme.linkRectIconButtonBackgroundColor !== undefined) {
      cjMarkdownTheme.setLinkRectIconButtonBackgroundColor(theme.linkRectIconButtonBackgroundColor)
    }
    if (theme.linkRectIconTextSize !== undefined) {
      cjMarkdownTheme.setLinkRectIconTextSize(theme.linkRectIconTextSize)
    }
    if (theme.linkRectIconTextColor !== undefined) {
      cjMarkdownTheme.setLinkRectIconTextColor(theme.linkRectIconTextColor)
    }
    if (theme.linkRectIconHeight !== undefined) {
      cjMarkdownTheme.setLinkRectIconHeight(theme.linkRectIconHeight)
    }
    if (theme.linkRectIconPadding !== undefined) {
      cjMarkdownTheme.setLinkRectIconPadding(theme.linkRectIconPadding)
    }
    if (theme.linkRectIconRadius !== undefined) {
      cjMarkdownTheme.setLinkRectIconRadius(theme.linkRectIconRadius)
    }
    if (theme.linkRectIconMargin !== undefined) {
      cjMarkdownTheme.setLinkRectIconMargin(theme.linkRectIconMargin)
    }
    if (theme.linkRectToolIconBackgroundColor !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconBackgroundColor(theme.linkRectToolIconBackgroundColor)
    }
    if (theme.linkRectToolIconButtonBackgroundColor !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconButtonBackgroundColor(theme.linkRectToolIconButtonBackgroundColor)
    }
    if (theme.linkRectToolIconTextSize !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconTextSize(theme.linkRectToolIconTextSize)
    }
    if (theme.linkRectToolIconHeight !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconHeight(theme.linkRectToolIconHeight)
    }
    if (theme.linkRectToolIconPadding !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconPadding(theme.linkRectToolIconPadding)
    }
    if (theme.linkRectToolIconBorderWidth !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconBorderWidth(theme.linkRectToolIconBorderWidth)
    }
    if (theme.linkRectToolIconDividingLineWidth !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconDividingLineWidth(theme.linkRectToolIconDividingLineWidth)
    }
    if (theme.linkRectToolIconMargin !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconMargin(theme.linkRectToolIconMargin)
    }
    if (theme.linkRectToolIconLineLeftPadding !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconLineLeftPadding(theme.linkRectToolIconLineLeftPadding)
    }
    if (theme.linkRectToolIconLineRightPadding !== undefined) {
      cjMarkdownTheme.setLinkRectToolIconLineRightPadding(theme.linkRectToolIconLineRightPadding)
    }
    return cjMarkdownTheme
  }

  getOrderedListTheme(theme: MarkdownThemeOrderedList): CJMarkdownOrderedListTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownOrderedListTheme()
    if (theme.orderedListBackgroundColor !== undefined) {
      cjMarkdownTheme.setOrderedListBackgroundColor(theme.orderedListBackgroundColor)
    }
    let orderedListMarginTop: number = 0.0
    let orderedListMarginRight: number = 0.0
    let orderedListMarginBottom: number = 0.0
    let orderedListMarginLeft: number = 8.0
    if (theme.orderedListMarginTop !== undefined) {
      orderedListMarginTop = theme.orderedListMarginTop
    }
    if (theme.orderedListMarginRight !== undefined) {
      orderedListMarginRight = theme.orderedListMarginRight
    }
    if (theme.orderedListMarginBottom !== undefined) {
      orderedListMarginBottom = theme.orderedListMarginBottom
    }
    if (theme.orderedListMarginLeft !== undefined) {
      orderedListMarginLeft = theme.orderedListMarginLeft
    }
    cjMarkdownTheme.setOrderedListMargin(
      orderedListMarginTop,
      orderedListMarginRight,
      orderedListMarginBottom,
      orderedListMarginLeft
    )
    let orderedListPaddingTop: number = 0.0
    let orderedListPaddingRight: number = 0.0
    let orderedListPaddingBottom: number = 0.0
    let orderedListPaddingLeft: number = 0.0
    if (theme.orderedListPaddingTop !== undefined) {
      orderedListPaddingTop = theme.orderedListPaddingTop
    }
    if (theme.orderedListPaddingRight !== undefined) {
      orderedListPaddingRight = theme.orderedListPaddingRight
    }
    if (theme.orderedListPaddingBottom !== undefined) {
      orderedListPaddingBottom = theme.orderedListPaddingBottom
    }
    if (theme.orderedListPaddingLeft !== undefined) {
      orderedListPaddingLeft = theme.orderedListPaddingLeft
    }
    cjMarkdownTheme.setOrderedListPadding(
      orderedListPaddingTop,
      orderedListPaddingRight,
      orderedListPaddingBottom,
      orderedListPaddingLeft
    )
    if (theme.orderedListChildSpacing !== undefined) {
      cjMarkdownTheme.setOrderedListChildSpacing(theme.orderedListChildSpacing)
    }
    if (theme.orderedListChildChildSpacing !== undefined) {
      cjMarkdownTheme.setOrderedListChildChildSpacing(theme.orderedListChildChildSpacing)
    }
    if (theme.orderedListMarkerSpacing !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerSpacing(theme.orderedListMarkerSpacing)
    }
    if (theme.orderedListMarkerTextFontColor !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextFontColor(theme.orderedListMarkerTextFontColor)
    }
    if (theme.orderedListMarkerTextFontSize !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextFontSize(theme.orderedListMarkerTextFontSize)
    }
    if (theme.orderedListMarkerTextFontStyle !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextFontStyle(theme.orderedListMarkerTextFontStyle)
    }
    if (theme.orderedListMarkerTextFontWeight !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextFontWeight(theme.orderedListMarkerTextFontWeight.toString())
    }
    if (theme.orderedListMarkerTextFontFamily !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextFontFamily(theme.orderedListMarkerTextFontFamily)
    }
    if (theme.orderedListMarkerTextLineHeight !== undefined) {
      cjMarkdownTheme.setOrderedListMarkerTextLineHeight(theme.orderedListMarkerTextLineHeight)
    }
    return cjMarkdownTheme
  }

  getParagraphTheme(theme: MarkdownThemeParagraph): CJMarkdownParagraphTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownParagraphTheme()
    if (theme.paragraphBackgroundColor !== undefined) {
      cjMarkdownTheme.setParagraphBackgroundColor(theme.paragraphBackgroundColor)
    }
    let paragraphMarginTop: number = 0.0
    let paragraphMarginRight: number = 0.0
    let paragraphMarginBottom: number = 0.0
    let paragraphMarginLeft: number = 0.0
    if (theme.paragraphMarginTop !== undefined) {
      paragraphMarginTop = theme.paragraphMarginTop
    }
    if (theme.paragraphMarginRight !== undefined) {
      paragraphMarginRight = theme.paragraphMarginRight
    }
    if (theme.paragraphMarginBottom !== undefined) {
      paragraphMarginBottom = theme.paragraphMarginBottom
    }
    if (theme.paragraphMarginLeft !== undefined) {
      paragraphMarginLeft = theme.paragraphMarginLeft
    }
    cjMarkdownTheme.setParagraphMargin(paragraphMarginTop, paragraphMarginRight, paragraphMarginBottom, paragraphMarginLeft)

    let paragraphPaddingTop: number = 0.0
    let paragraphPaddingRight: number = 0.0
    let paragraphPaddingBottom: number = 0.0
    let paragraphPaddingLeft: number = 0.0
    if (theme.paragraphPaddingTop !== undefined) {
      paragraphPaddingTop = theme.paragraphPaddingTop
    }
    if (theme.paragraphPaddingRight !== undefined) {
      paragraphPaddingRight = theme.paragraphPaddingRight
    }
    if (theme.paragraphPaddingBottom !== undefined) {
      paragraphPaddingBottom = theme.paragraphPaddingBottom
    }
    if (theme.paragraphPaddingLeft !== undefined) {
      paragraphPaddingLeft = theme.paragraphPaddingLeft
    }
    cjMarkdownTheme.setParagraphPadding(paragraphPaddingTop, paragraphPaddingRight, paragraphPaddingBottom, paragraphPaddingLeft)
    if (theme.paragraphTextFontColor !== undefined) {
      cjMarkdownTheme.setParagraphTextFontColor(theme.paragraphTextFontColor)
    }
    if (theme.paragraphTextFontSize !== undefined) {
      cjMarkdownTheme.setParagraphTextFontSize(theme.paragraphTextFontSize)
    }
    if (theme.paragraphTextFontStyle !== undefined) {
      console.error("paragraphTextFontStyle-----------------> " + theme.paragraphTextFontStyle)
      cjMarkdownTheme.setParagraphTextFontStyle(theme.paragraphTextFontStyle)
    }
    if (theme.paragraphTextFontWeight !== undefined) {
      console.error("paragraphTextFontWeight-----------------> " + theme.paragraphTextFontWeight)
      cjMarkdownTheme.setParagraphTextFontWeight(theme.paragraphTextFontWeight.toString())
    }
    if (theme.paragraphTextFontFamily !== undefined) {
      cjMarkdownTheme.setParagraphTextFontFamily(theme.paragraphTextFontFamily)
    }
    if (theme.paragraphTextLineHeight !== undefined) {
      cjMarkdownTheme.setParagraphTextLineHeight(theme.paragraphTextLineHeight)
    }
    if (theme.paragraphTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setParagraphTextLetterSpacing(theme.paragraphTextLetterSpacing)
    }
    return cjMarkdownTheme
  }

  getStrikethroughTheme(theme: MarkdownThemeStrikethrough): CJMarkdownStrikethroughTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownStrikethroughTheme()
    if (theme.strikethroughTextFontColor !== undefined) {
      cjMarkdownTheme.setStrikethroughTextFontColor(theme.strikethroughTextFontColor)
    }
    if (theme.strikethroughTextFontSize !== undefined) {
      cjMarkdownTheme.setStrikethroughTextFontSize(theme.strikethroughTextFontSize)
    }
    if (theme.strikethroughTextFontStyle !== undefined) {
      cjMarkdownTheme.setStrikethroughTextFontStyle(theme.strikethroughTextFontStyle)
    }
    if (theme.strikethroughTextFontWeight !== undefined) {
      cjMarkdownTheme.setStrikethroughTextFontWeight(theme.strikethroughTextFontWeight.toString())
    }
    if (theme.strikethroughTextFontFamily !== undefined) {
      cjMarkdownTheme.setStrikethroughTextFontFamily(theme.strikethroughTextFontFamily)
    }
    if (theme.strikethroughTextLineHeight !== undefined) {
      cjMarkdownTheme.setStrikethroughTextLineHeight(theme.strikethroughTextLineHeight)
    }
    if (theme.strikethroughTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setStrikethroughTextLetterSpacing(theme.strikethroughTextLetterSpacing)
    }
    if (theme.strikethroughTextDecorationColor !== undefined) {
      cjMarkdownTheme.setStrikethroughTextDecorationColor(theme.strikethroughTextDecorationColor)
    }
    if (theme.strikethroughTextDecorationStyle !== undefined) {
      cjMarkdownTheme.setStrikethroughTextDecorationStyle(theme.strikethroughTextDecorationStyle)
    }
    return cjMarkdownTheme
  }

  getSubTheme(theme: MarkdownThemeSub): CJMarkdownSubTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownSubTheme()
    if (theme.subTextFontColor !== undefined) {
      cjMarkdownTheme.setSubTextFontColor(theme.subTextFontColor)
    }
    if (theme.subTextFontSize !== undefined) {
      cjMarkdownTheme.setSubTextFontSize(theme.subTextFontSize)
    }
    if (theme.subTextFontStyle !== undefined) {
      cjMarkdownTheme.setSubTextFontStyle(theme.subTextFontStyle)
    }
    if (theme.subTextFontWeight !== undefined) {
      cjMarkdownTheme.setSubTextFontWeight(theme.subTextFontWeight.toString())
    }
    if (theme.subTextFontFamily !== undefined) {
      cjMarkdownTheme.setSubTextFontFamily(theme.subTextFontFamily)
    }
    if (theme.subTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setSubTextLetterSpacing(theme.subTextLetterSpacing)
    }
    if (theme.subTextBaselineOffset !== undefined) {
      cjMarkdownTheme.setSubTextBaselineOffset(theme.subTextBaselineOffset)
    }
    return cjMarkdownTheme
  }

  getSupTheme(theme: MarkdownThemeSup): CJMarkdownSupTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownSupTheme()
    if (theme.supTextFontColor !== undefined) {
      cjMarkdownTheme.setSupTextFontColor(theme.supTextFontColor)
    }
    if (theme.supTextFontSize !== undefined) {
      cjMarkdownTheme.setSupTextFontSize(theme.supTextFontSize)
    }
    if (theme.supTextFontStyle !== undefined) {
      cjMarkdownTheme.setSupTextFontStyle(theme.supTextFontStyle)
    }
    if (theme.supTextFontWeight !== undefined) {
      cjMarkdownTheme.setSupTextFontWeight(theme.supTextFontWeight.toString())
    }
    if (theme.supTextFontFamily !== undefined) {
      cjMarkdownTheme.setSupTextFontFamily(theme.supTextFontFamily)
    }
    if (theme.supTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setSupTextLetterSpacing(theme.supTextLetterSpacing)
    }
    if (theme.supTextBaselineOffset !== undefined) {
      cjMarkdownTheme.setSupTextBaselineOffset(theme.supTextBaselineOffset)
    }
    return cjMarkdownTheme
  }

  getTableTheme(theme: MarkdownThemeTable): CJMarkdownTableTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownTableTheme()
    if (theme.tableTitleBackgroundColor !== undefined) {
      cjMarkdownTheme.setTableTitleBackgroundColor(theme.tableTitleBackgroundColor)
    }
    if (theme.tableContentOddRowBackgroundColor !== undefined) {
      cjMarkdownTheme.setTableContentOddRowBackgroundColor(theme.tableContentOddRowBackgroundColor)
    }
    if (theme.tableContentEvenRowBackgroundColor !== undefined) {
      cjMarkdownTheme.setTableContentEvenRowBackgroundColor(theme.tableContentEvenRowBackgroundColor)
    }
    let tableMarginTop: number = 0.0
    let tableMarginRight: number = 0.0
    let tableMarginBottom: number = 0.0
    let tableMarginLeft: number = 0.0
    if (theme.tableMarginTop !== undefined) {
      tableMarginTop = theme.tableMarginTop
    }
    if (theme.tableMarginRight !== undefined) {
      tableMarginRight = theme.tableMarginRight
    }
    if (theme.tableMarginBottom !== undefined) {
      tableMarginBottom = theme.tableMarginBottom
    }
    if (theme.tableMarginLeft !== undefined) {
      tableMarginLeft = theme.tableMarginLeft
    }
    cjMarkdownTheme.setTableMargin(tableMarginTop, tableMarginRight, tableMarginBottom, tableMarginLeft)

    let tablePaddingTop: number = 0.0
    let tablePaddingRight: number = 0.0
    let tablePaddingBottom: number = 0.0
    let tablePaddingLeft: number = 0.0
    if (theme.tablePaddingTop !== undefined) {
      tablePaddingTop = theme.tablePaddingTop
    }
    if (theme.tablePaddingRight !== undefined) {
      tablePaddingRight = theme.tablePaddingRight
    }
    if (theme.tablePaddingBottom !== undefined) {
      tablePaddingBottom = theme.tablePaddingBottom
    }
    if (theme.tablePaddingLeft !== undefined) {
      tablePaddingLeft = theme.tablePaddingLeft
    }
    cjMarkdownTheme.setTablePadding(tablePaddingTop, tablePaddingRight, tablePaddingBottom, tablePaddingLeft)

    let tableCellPaddingTop: number = 4.0
    let tableCellPaddingRight: number = 4.0
    let tableCellPaddingBottom: number = 4.0
    let tableCellPaddingLeft: number = 4.0
    if (theme.tableCellPaddingTop !== undefined) {
      tableCellPaddingTop = theme.tableCellPaddingTop
    }
    if (theme.tableCellPaddingRight !== undefined) {
      tableCellPaddingRight = theme.tableCellPaddingRight
    }
    if (theme.tableCellPaddingBottom !== undefined) {
      tableCellPaddingBottom = theme.tableCellPaddingBottom
    }
    if (theme.tableCellPaddingLeft !== undefined) {
      tableCellPaddingLeft = theme.tableCellPaddingLeft
    }
    cjMarkdownTheme.setTableCellPadding(tableCellPaddingTop, tableCellPaddingRight, tableCellPaddingBottom, tableCellPaddingLeft)
    if (theme.tableBorderStyle !== undefined) {
      cjMarkdownTheme.setTableBorderStyle(theme.tableBorderStyle)
    }
    if (theme.tableBorderWidth !== undefined) {
      cjMarkdownTheme.setTableBorderWidth(theme.tableBorderWidth)
    }
    if (theme.tableBorderColor !== undefined) {
      cjMarkdownTheme.setTableBorderColor(theme.tableBorderColor)
    }
    let tableRadiusTopLeft: number = 5.0
    let tableRadiusTopRight: number = 5.0
    let tableRadiusBottomLeft: number = 5.0
    let tableRadiusBottomRight: number = 5.0
    if (theme.tableRadiusTopLeft !== undefined) {
      tableRadiusTopLeft = theme.tableRadiusTopLeft
    }
    if (theme.tableRadiusTopRight !== undefined) {
      tableRadiusTopRight = theme.tableRadiusTopRight
    }
    if (theme.tableRadiusBottomLeft !== undefined) {
      tableRadiusBottomLeft = theme.tableRadiusBottomLeft
    }
    if (theme.tableRadiusBottomRight !== undefined) {
      tableRadiusBottomRight = theme.tableRadiusBottomRight
    }
    cjMarkdownTheme.setTableRadius(tableRadiusTopLeft, tableRadiusTopRight, tableRadiusBottomLeft, tableRadiusBottomRight)
    if (theme.tableScrollBarState !== undefined) {
      cjMarkdownTheme.setTableScrollBarState(theme.tableScrollBarState)
    }
    if (theme.tableScrollBarColor !== undefined) {
      cjMarkdownTheme.setTableScrollBarColor(theme.tableScrollBarColor)
    }
    if (theme.tableMinCellWidth !== undefined) {
      cjMarkdownTheme.setTableMinCellWidth(theme.tableMinCellWidth)
    }
    if (theme.tableMaxCellWidth !== undefined) {
      cjMarkdownTheme.setTableMaxCellWidth(theme.tableMaxCellWidth)
    }
    if (theme.tableFirstColumnIsBold !== undefined) {
      cjMarkdownTheme.setTableFirstColumnIsBold(theme.tableFirstColumnIsBold)
    }
    if (theme.tableTitleTextFontColor !== undefined) {
      cjMarkdownTheme.setTableTitleTextFontColor(theme.tableTitleTextFontColor)
    }
    if (theme.tableTitleTextFontSize !== undefined) {
      cjMarkdownTheme.setTableTitleTextFontSize(theme.tableTitleTextFontSize)
    }
    if (theme.tableTitleTextFontStyle !== undefined) {
      cjMarkdownTheme.setTableTitleTextFontStyle(theme.tableTitleTextFontStyle)
    }
    if (theme.tableTitleTextFontWeight !== undefined) {
      cjMarkdownTheme.setTableTitleTextFontWeight(theme.tableTitleTextFontWeight.toString())
    }
    if (theme.tableTitleTextFontFamily !== undefined) {
      cjMarkdownTheme.setTableTitleTextFontFamily(theme.tableTitleTextFontFamily)
    }
    if (theme.tableTitleTextLineHeight !== undefined) {
      cjMarkdownTheme.setTableTitleTextLineHeight(theme.tableTitleTextLineHeight)
    }
    if (theme.tableTitleTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setTableTitleTextLetterSpacing(theme.tableTitleTextLetterSpacing)
    }
    if (theme.tableContentTextFontColor !== undefined) {
      cjMarkdownTheme.setTableContentTextFontColor(theme.tableContentTextFontColor)
    }
    if (theme.tableContentTextFontSize !== undefined) {
      cjMarkdownTheme.setTableContentTextFontSize(theme.tableContentTextFontSize)
    }
    if (theme.tableContentTextFontStyle !== undefined) {
      cjMarkdownTheme.setTableContentTextFontStyle(theme.tableContentTextFontStyle)
    }
    if (theme.tableContentTextFontWeight !== undefined) {
      cjMarkdownTheme.setTableContentTextFontWeight(theme.tableContentTextFontWeight.toString())
    }
    if (theme.tableContentTextFontFamily !== undefined) {
      cjMarkdownTheme.setTableContentTextFontFamily(theme.tableContentTextFontFamily)
    }
    if (theme.tableContentTextLineHeight !== undefined) {
      cjMarkdownTheme.setTableContentTextLineHeight(theme.tableContentTextLineHeight)
    }
    if (theme.tableContentTextLetterSpacing !== undefined) {
      cjMarkdownTheme.setTableContentTextLetterSpacing(theme.tableContentTextLetterSpacing)
    }
    return cjMarkdownTheme
  }

  getVideoTheme(theme: MarkdownThemeVideo): CJMarkdownVideoTheme | undefined {
    if (global_customLib === undefined) {
      return undefined
    }
    let cjMarkdownTheme = new global_customLib.CJMarkdownVideoTheme()
    if (theme.videoBackgroundColor !== undefined) {
      cjMarkdownTheme.setVideoBackgroundColor(theme.videoBackgroundColor)
    }
    let videoMarginTop: number = 0.0
    let videoMarginRight: number = 0.0
    let videoMarginBottom: number = 0.0
    let videoMarginLeft: number = 0.0
    if (theme.videoMarginTop !== undefined) {
      videoMarginTop = theme.videoMarginTop
    }
    if (theme.videoMarginRight !== undefined) {
      videoMarginRight = theme.videoMarginRight
    }
    if (theme.videoMarginBottom !== undefined) {
      videoMarginBottom = theme.videoMarginBottom
    }
    if (theme.videoMarginLeft !== undefined) {
      videoMarginLeft = theme.videoMarginLeft
    }
    cjMarkdownTheme.setVideoMargin(videoMarginTop, videoMarginRight, videoMarginBottom, videoMarginLeft)

    let videoPaddingTop: number = 0.0
    let videoPaddingRight: number = 0.0
    let videoPaddingBottom: number = 0.0
    let videoPaddingLeft: number = 0.0
    if (theme.videoPaddingTop !== undefined) {
      videoPaddingTop = theme.videoPaddingTop
    }
    if (theme.videoPaddingRight !== undefined) {
      videoPaddingRight = theme.videoPaddingRight
    }
    if (theme.videoPaddingBottom !== undefined) {
      videoPaddingBottom = theme.videoPaddingBottom
    }
    if (theme.videoPaddingLeft !== undefined) {
      videoPaddingLeft = theme.videoPaddingLeft
    }
    cjMarkdownTheme.setVideoPadding(videoPaddingTop, videoPaddingRight, videoPaddingBottom, videoPaddingLeft)

    let videoRadiusTopLeft: number = 10.0
    let videoRadiusTopRight: number = 10.0
    let videoRadiusBottomLeft: number = 10.0
    let videoRadiusBottomRight: number = 10.0
    if (theme.videoRadiusTopLeft !== undefined) {
      videoRadiusTopLeft = theme.videoRadiusTopLeft
    }
    if (theme.videoRadiusTopRight !== undefined) {
      videoRadiusTopRight = theme.videoRadiusTopRight
    }
    if (theme.videoRadiusBottomLeft !== undefined) {
      videoRadiusBottomLeft = theme.videoRadiusBottomLeft
    }
    if (theme.videoRadiusBottomRight !== undefined) {
      videoRadiusBottomRight = theme.videoRadiusBottomRight
    }
    cjMarkdownTheme.setVideoBorderRadius(videoRadiusTopLeft, videoRadiusTopRight, videoRadiusBottomLeft, videoRadiusBottomRight)
    if (theme.videoImageFitType !== undefined) {
      cjMarkdownTheme.setVideoImageFitType(theme.videoImageFitType)
    }
    if (theme.videoBorderStyle !== undefined) {
      cjMarkdownTheme.setVideoBorderStyle(theme.videoBorderStyle)
    }
    if (theme.videoBorderWidth !== undefined) {
      cjMarkdownTheme.setVideoBorderWidth(theme.videoBorderWidth)
    }
    if (theme.videoBorderColor !== undefined) {
      cjMarkdownTheme.setVideoBorderColor(theme.videoBorderColor)
    }
    if (theme.videoTimeTextFontColor !== undefined) {
      cjMarkdownTheme.setVideoTimeTextFontColor(theme.videoTimeTextFontColor)
    }
    if (theme.videoTimeTextFontSize !== undefined) {
      cjMarkdownTheme.setVideoTimeTextFontSize(theme.videoTimeTextFontSize)
    }
    if (theme.videoTimeTextFontStyle !== undefined) {
      cjMarkdownTheme.setVideoTimeTextFontStyle(theme.videoTimeTextFontStyle)
    }
    if (theme.videoTimeTextFontWeight !== undefined) {
      cjMarkdownTheme.setVideoTimeTextFontWeight(theme.videoTimeTextFontWeight.toString())
    }
    if (theme.videoTimeTextFontFamily !== undefined) {
      cjMarkdownTheme.setVideoTimeTextFontFamily(theme.videoTimeTextFontFamily)
    }
    if (theme.videoTimeTextLineHeight !== undefined) {
      cjMarkdownTheme.setVideoTimeTextLineHeight(theme.videoTimeTextLineHeight)
    }
    if (theme.videoTimeTextMarginRight !== undefined) {
      cjMarkdownTheme.setVideoTimeTextMarginRight(theme.videoTimeTextMarginRight)
    }
    if (theme.videoTimeTextMarginBottom !== undefined) {
      cjMarkdownTheme.setVideoTimeTextMarginBottom(theme.videoTimeTextMarginBottom)
    }
    if (theme.videoBottomLayoutVisible !== undefined) {
      cjMarkdownTheme.setVideoBottomLayoutVisible(theme.videoBottomLayoutVisible)
    }
    if (theme.videoBottomLayoutMarginTop !== undefined) {
      cjMarkdownTheme.setVideoBottomLayoutMarginTop(theme.videoBottomLayoutMarginTop)
    }
    if (theme.videoPlayIconWidth !== undefined) {
      cjMarkdownTheme.setVideoPlayIconWidth(theme.videoPlayIconWidth)
    }
    if (theme.videoPlayIconHeight !== undefined) {
      cjMarkdownTheme.setVideoPlayIconHeight(theme.videoPlayIconHeight)
    }
    if (theme.videoPlayIconFitType !== undefined) {
      cjMarkdownTheme.setVideoPlayIconFitType(theme.videoPlayIconFitType)
    }
    if (theme.videoReleaseButtonVisible !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonVisible(theme.videoReleaseButtonVisible)
    }
    if (theme.videoReleaseButtonBackgroundColor !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonBackgroundColor(theme.videoReleaseButtonBackgroundColor)
    }
    if (theme.videoReleaseButtonWidth !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonWidth(theme.videoReleaseButtonWidth)
    }
    if (theme.videoReleaseButtonHeight !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonHeight(theme.videoReleaseButtonHeight)
    }
    let videoReleaseButtonRadiusTopLeft: number = 22.0
    let videoReleaseButtonRadiusTopRight: number = 22.0
    let videoReleaseButtonRadiusBottomLeft: number = 22.0
    let videoReleaseButtonRadiusBottomRight: number = 22.0
    if (theme.videoReleaseButtonRadiusTopLeft !== undefined) {
      videoReleaseButtonRadiusTopLeft = theme.videoReleaseButtonRadiusTopLeft
    }
    if (theme.videoReleaseButtonRadiusTopRight !== undefined) {
      videoReleaseButtonRadiusTopRight = theme.videoReleaseButtonRadiusTopRight
    }
    if (theme.videoReleaseButtonRadiusBottomLeft !== undefined) {
      videoReleaseButtonRadiusBottomLeft = theme.videoReleaseButtonRadiusBottomLeft
    }
    if (theme.videoReleaseButtonRadiusBottomRight !== undefined) {
      videoReleaseButtonRadiusBottomRight = theme.videoReleaseButtonRadiusBottomRight
    }
    cjMarkdownTheme.setVideoReleaseButtonRadius(
      videoReleaseButtonRadiusTopLeft,
      videoReleaseButtonRadiusTopRight,
      videoReleaseButtonRadiusBottomLeft,
      videoReleaseButtonRadiusBottomRight
    )
    if (theme.videoReleaseButtonIconWidth !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonIconWidth(theme.videoReleaseButtonIconWidth)
    }
    if (theme.videoReleaseButtonIconHeight !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonIconHeight(theme.videoReleaseButtonIconHeight)
    }
    if (theme.videoReleaseButtonIconTextGap !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonIconTextGap(theme.videoReleaseButtonIconTextGap)
    }
    if (theme.videoReleaseButtonText !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonText(theme.videoReleaseButtonText)
    }
    if (theme.videoReleaseButtonTextFontColor !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextFontColor(theme.videoReleaseButtonTextFontColor)
    }
    if (theme.videoReleaseButtonTextFontSize !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextFontSize(theme.videoReleaseButtonTextFontSize)
    }
    if (theme.videoReleaseButtonTextFontStyle !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextFontStyle(theme.videoReleaseButtonTextFontStyle)
    }
    if (theme.videoReleaseButtonTextFontWeight !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextFontWeight(theme.videoReleaseButtonTextFontWeight.toString())
    }
    if (theme.videoReleaseButtonTextFontFamily !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextFontFamily(theme.videoReleaseButtonTextFontFamily)
    }
    if (theme.videoReleaseButtonTextLineHeight !== undefined) {
      cjMarkdownTheme.setVideoReleaseButtonTextLineHeight(theme.videoReleaseButtonTextLineHeight)
    }
    if (theme.videoDownloadButtonVisible !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonVisible(theme.videoDownloadButtonVisible)
    }
    if (theme.videoDownloadButtonBackgroundColor !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonBackgroundColor(theme.videoDownloadButtonBackgroundColor)
    }
    if (theme.videoDownloadButtonWidth !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonWidth(theme.videoDownloadButtonWidth)
    }
    if (theme.videoDownloadButtonHeight !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonHeight(theme.videoDownloadButtonHeight)
    }
    let videoDownloadButtonRadiusTopLeft: number = 22.0
    let videoDownloadButtonRadiusTopRight: number = 22.0
    let videoDownloadButtonRadiusBottomLeft: number = 22.0
    let videoDownloadButtonRadiusBottomRight: number = 22.0
    if (theme.videoDownloadButtonRadiusTopLeft !== undefined) {
      videoDownloadButtonRadiusTopLeft = theme.videoDownloadButtonRadiusTopLeft
    }
    if (theme.videoDownloadButtonRadiusTopRight !== undefined) {
      videoDownloadButtonRadiusTopRight = theme.videoDownloadButtonRadiusTopRight
    }
    if (theme.videoDownloadButtonRadiusBottomLeft !== undefined) {
      videoDownloadButtonRadiusBottomLeft = theme.videoDownloadButtonRadiusBottomLeft
    }
    if (theme.videoDownloadButtonRadiusBottomRight !== undefined) {
      videoDownloadButtonRadiusBottomRight = theme.videoDownloadButtonRadiusBottomRight
    }
    cjMarkdownTheme.setVideoDownloadButtonRadius(
      videoDownloadButtonRadiusTopLeft,
      videoDownloadButtonRadiusTopRight,
      videoDownloadButtonRadiusBottomLeft,
      videoDownloadButtonRadiusBottomRight
    )
    if (theme.videoDownloadButtonIconWidth !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonIconWidth(theme.videoDownloadButtonIconWidth)
    }
    if (theme.videoDownloadButtonIconHeight !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonIconHeight(theme.videoDownloadButtonIconHeight)
    }
    if (theme.videoDownloadButtonIconTextGap !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonIconTextGap(theme.videoDownloadButtonIconTextGap)
    }
    if (theme.videoDownloadButtonText !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonText(theme.videoDownloadButtonText)
    }
    if (theme.videoDownloadButtonTextFontColor !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextFontColor(theme.videoDownloadButtonTextFontColor)
    }
    if (theme.videoDownloadButtonTextFontSize !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextFontSize(theme.videoDownloadButtonTextFontSize)
    }
    if (theme.videoDownloadButtonTextFontStyle !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextFontStyle(theme.videoDownloadButtonTextFontStyle)
    }
    if (theme.videoDownloadButtonTextFontWeight !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextFontWeight(theme.videoDownloadButtonTextFontWeight.toString())
    }
    if (theme.videoDownloadButtonTextFontFamily !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextFontFamily(theme.videoDownloadButtonTextFontFamily)
    }
    if (theme.videoDownloadButtonTextLineHeight !== undefined) {
      cjMarkdownTheme.setVideoDownloadButtonTextLineHeight(theme.videoDownloadButtonTextLineHeight)
    }
    return cjMarkdownTheme
  }
}
