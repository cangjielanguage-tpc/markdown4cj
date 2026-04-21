/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
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
        if (this.config.markdownTheme.context !== undefined) {
          global_customLib.setGlobalContext(this.config.markdownTheme.context)
        }
        global_customLib.getCJResource(
          this.config.markdownTheme.markdownThemeAudio.audioIcon,
          this.config.markdownTheme.markdownThemeBanner.bannerPlaceholder,
          this.config.markdownTheme.markdownThemeCodeBlock.codeBlockCopyIcon,
          this.config.markdownTheme.markdownThemeCodeBlock.codeBlockFullScreenIcon,
          this.config.markdownTheme.markdownThemeImage.imagePlaceholder,
          this.config.markdownTheme.markdownThemeImage.imageDownloadButtonIcon,
          this.config.markdownTheme.markdownThemeVideo.videoPlaceholder,
          this.config.markdownTheme.markdownThemeVideo.videoPlayIcon,
          this.config.markdownTheme.markdownThemeVideo.videoReleaseButtonIcon,
          this.config.markdownTheme.markdownThemeVideo.videoDownloadButtonIcon,
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

        if (this.config.markdownTheme.isDark !== undefined) {
          cjMarkdownTheme.setIsDark(this.config.markdownTheme.isDark)
        }
      }
    }
    return cjMarkdownTheme
  }

  getAudioTheme(theme: MarkdownThemeAudio): CJMarkdownAudioTheme | undefined {
    let cjMarkdownTheme = new CJMarkdownAudioTheme()
    if (theme.audioBackgroundColor !== undefined) {
      cjMarkdownTheme.setAudioBackgroundColor(theme.audioBackgroundColor)
    }
    cjMarkdownTheme.setAudioMargin(theme.audioMarginTop, theme.audioMarginRight, theme.audioMarginBottom, theme.audioMarginLeft)
    cjMarkdownTheme.setAudioPadding(theme.audioPaddingTop, theme.audioPaddingRight, theme.audioPaddingBottom, theme.audioPaddingLeft)
    if (theme.audioBorderStyle !== undefined) {
      cjMarkdownTheme.setAudioBorderStyle(theme.audioBorderStyle)
    }
    if (theme.audioBorderWidth !== undefined) {
      cjMarkdownTheme.setAudioBorderWidth(theme.audioBorderWidth)
    }
    if (theme.audioBorderColor !== undefined) {
      cjMarkdownTheme.setAudioBorderColor(theme.audioBorderColor)
    }
    cjMarkdownTheme.setAudioRadius(theme.audioRadiusTopLeft, theme.audioRadiusTopRight, theme.audioRadiusBottomLeft, theme.audioRadiusBottomRight)
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
    cjMarkdownTheme.setAudioButtonRadius(theme.audioButtonRadiusTopLeft, theme.audioButtonRadiusTopRight, theme.audioButtonRadiusBottomLeft, theme.audioButtonRadiusBottomRight)
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
      cjMarkdownTheme.setAudioButtonTextFontWeight(theme.audioButtonTextFontWeight)
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
    cjMarkdownTheme.setAudioIconRadius(
      theme.audioIconRadiusTopLeft,
      theme.audioIconRadiusTopRight,
      theme.audioIconRadiusBottomLeft,
      theme.audioIconRadiusBottomRight
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
      cjMarkdownTheme.setAudioTitleTextFontWeight(theme.audioTitleTextFontWeight)
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
      cjMarkdownTheme.setAudioTypeTextFontWeight(theme.audioTypeTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownBannerTheme()
    cjMarkdownTheme.setBannerMargin(theme.bannerMarginTop, theme.bannerMarginRight, theme.bannerMarginBottom, theme.bannerMarginLeft)
    cjMarkdownTheme.setBannerPadding(theme.bannerPaddingTop, theme.bannerPaddingRight, theme.bannerPaddingBottom, theme.bannerPaddingLeft)
    return cjMarkdownTheme
  }

  getBlockQuoteTheme(theme: MarkdownThemeBlockQuote): CJMarkdownBlockQuoteTheme | undefined {
    let cjMarkdownTheme = new CJMarkdownBlockQuoteTheme()
    if (theme.blockQuoteBackgroundColor !== undefined) {
      cjMarkdownTheme.setBlockQuoteBackgroundColor(theme.blockQuoteBackgroundColor)
    }
    cjMarkdownTheme.setBlockQuoteMargin(theme.blockQuoteMarginTop, theme.blockQuoteMarginRight, theme.blockQuoteMarginBottom, theme.blockQuoteMarginLeft)
    cjMarkdownTheme.setBlockQuotePadding(theme.blockQuotePaddingTop, theme.blockQuotePaddingRight, theme.blockQuotePaddingBottom, theme.blockQuotePaddingLeft)
    cjMarkdownTheme.setBlockQuoteRadius(theme.blockQuoteRadiusTopLeft, theme.blockQuoteRadiusTopRight, theme.blockQuoteRadiusBottomLeft, theme.blockQuoteRadiusBottomRight)
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
    let cjMarkdownTheme = new CJMarkdownBoldTheme()
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
      cjMarkdownTheme.setBoldTextFontWeight(theme.boldTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownBulletListTheme()
    if (theme.bulletListBackgroundColor !== undefined) {
      cjMarkdownTheme.setBulletListBackgroundColor(theme.bulletListBackgroundColor)
    }
    cjMarkdownTheme.setBulletListMargin(theme.bulletListMarginTop, theme.bulletListMarginRight, theme.bulletListMarginBottom, theme.bulletListMarginLeft)
    cjMarkdownTheme.setBulletListPadding(theme.bulletListPaddingTop, theme.bulletListPaddingRight, theme.bulletListPaddingBottom, theme.bulletListPaddingLeft)
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
      cjMarkdownTheme.setBulletListBulletTextFontWeight(theme.bulletListBulletTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownCodeBlockTheme()
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
    cjMarkdownTheme.setCodeBlockMargin(theme.codeBlockMarginTop, theme.codeBlockMarginRight, theme.codeBlockMarginBottom, theme.codeBlockMarginLeft)
    cjMarkdownTheme.setCodeBlockPadding(theme.codeBlockPaddingTop, theme.codeBlockPaddingRight, theme.codeBlockPaddingBottom, theme.codeBlockPaddingLeft)
    if (theme.codeBlockBorderStyle !== undefined) {
      cjMarkdownTheme.setCodeBlockBorderStyle(theme.codeBlockBorderStyle)
    }
    if (theme.codeBlockBorderWidth !== undefined) {
      cjMarkdownTheme.setCodeBlockBorderWidth(theme.codeBlockBorderWidth)
    }
    if (theme.codeBlockBorderColor !== undefined) {
      cjMarkdownTheme.setCodeBlockBorderColor(theme.codeBlockBorderColor)
    }
    cjMarkdownTheme.setCodeBlockRadius(theme.codeBlockRadiusTopLeft, theme.codeBlockRadiusTopRight, theme.codeBlockRadiusBottomLeft, theme.codeBlockRadiusBottomRight)
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
      cjMarkdownTheme.setCodeBlockTypeTextFontWeight(theme.codeBlockTypeTextFontWeight)
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
      cjMarkdownTheme.setCodeBlockCopyTextFontWeight(theme.codeBlockCopyTextFontWeight)
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
      cjMarkdownTheme.setCodeBlockFullScreenTextFontWeight(theme.codeBlockFullScreenTextFontWeight)
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
      cjMarkdownTheme.setCodeBlockLineNumberTextFontWeight(theme.codeBlockLineNumberTextFontWeight)
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
      cjMarkdownTheme.setCodeBlockTextFontWeight(theme.codeBlockTextFontWeight)
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
    if (theme.codeBlockListTitleUnSelectTextColor !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleUnSelectTextColor(theme.codeBlockListTitleUnSelectTextColor)
    }
    if (theme.codeBlockListTitleSelectBackgroupColor !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleSelectBackGroupColor(theme.codeBlockListTitleSelectBackgroupColor)
    }
    if (theme.codeBlockListTitleUnSelectBackgroupColor !== undefined) {
      cjMarkdownTheme.setCodeBlockListTitleUnSelectBackGroupColor(theme.codeBlockListTitleUnSelectBackgroupColor)
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
    let cjMarkdownTheme = new CJMarkdownDefinitionListTheme()
    if (theme.definitionListBackgroundColor !== undefined) {
      cjMarkdownTheme.setDefinitionListBackgroundColor(theme.definitionListBackgroundColor)
    }
    cjMarkdownTheme.setDefinitionListMargin(theme.definitionListMarginTop, theme.definitionListMarginRight, theme.definitionListMarginBottom, theme.definitionListMarginLeft)
    cjMarkdownTheme.setDefinitionListPadding(theme.definitionListPaddingTop, theme.definitionListPaddingRight, theme.definitionListPaddingBottom, theme.definitionListPaddingLeft)
    if (theme.definitionListTermToDescriptionSpacing !== undefined) {
      cjMarkdownTheme.setDefinitionListTermToDescriptionSpacing(theme.definitionListTermToDescriptionSpacing)
    }
    if (theme.definitionListTermTextFontWeight !== undefined) {
      cjMarkdownTheme.setDefinitionListTermTextFontWeight(theme.definitionListTermTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownDividerTheme()
    cjMarkdownTheme.setDividerMargin(theme.dividerMarginTop, theme.dividerMarginRight, theme.dividerMarginBottom, theme.dividerMarginLeft)
    cjMarkdownTheme.setDividerPadding(theme.dividerPaddingTop, theme.dividerPaddingRight, theme.dividerPaddingBottom, theme.dividerPaddingLeft)
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
    let cjMarkdownTheme = new CJMarkdownFootnoteDefTheme()
    if (theme.footnoteDefBackgroundColor !== undefined) {
      cjMarkdownTheme.setFootnoteDefBackgroundColor(theme.footnoteDefBackgroundColor)
    }
    cjMarkdownTheme.setFootnoteDefMargin(theme.footnoteDefMarginTop, theme.footnoteDefMarginRight, theme.footnoteDefMarginBottom, theme.footnoteDefMarginLeft)
    cjMarkdownTheme.setFootnoteDefPadding(theme.footnoteDefPaddingTop, theme.footnoteDefPaddingRight, theme.footnoteDefPaddingBottom, theme.footnoteDefPaddingLeft)
    return cjMarkdownTheme
  }

  getFootnoteRefTheme(theme: MarkdownThemeFootnoteRef): CJMarkdownFootnoteRefTheme | undefined {
    let cjMarkdownTheme = new CJMarkdownFootnoteRefTheme()
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
      cjMarkdownTheme.setFootnoteRefTextFontWeight(theme.footnoteRefTextFontWeight)
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
    cjMarkdownTheme.setFootnoteRefTextBackgroundRadius(
      theme.footnoteRefTextBackgroundRadiusTopLeft,
      theme.footnoteRefTextBackgroundRadiusTopRight,
      theme.footnoteRefTextBackgroundRadiusBottomLeft,
      theme.footnoteRefTextBackgroundRadiusBottomRight
    )
    return cjMarkdownTheme
  }

  getGlobalTheme(theme: MarkdownThemeGlobal): CJMarkdownGlobalTheme | undefined {
    let cjMarkdownTheme = new CJMarkdownGlobalTheme()
    if (theme.isMarkdownParserSync !== undefined) {
      cjMarkdownTheme.setIsMarkdownParserSync(theme.isMarkdownParserSync)
    }
    if (theme.isOnCopy !== undefined) {
      cjMarkdownTheme.setIsOnCopy(theme.isOnCopy)
    }
    cjMarkdownTheme.setMargin(theme.blockMarginTop, theme.blockMarginRight, theme.blockMarginBottom, theme.blockMarginLeft)
    if (theme.markdownBlockSpacing !== undefined) {
      cjMarkdownTheme.setMarkdownBlockSpacing(theme.markdownBlockSpacing)
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
    let cjMarkdownTheme = new CJMarkdownHeadingTheme()
    // H1
    if (theme.heading1BackgroundColor !== undefined) {
      cjMarkdownTheme.setBackgroundColorForDesignateHeading(1, theme.heading1BackgroundColor)
    }
    cjMarkdownTheme.setMarginForDesignateHeadingDetail(1, theme.heading1MarginTop, theme.heading1MarginRight, theme.heading1MarginBottom, theme.heading1MarginLeft)
    cjMarkdownTheme.setPaddingForDesignateHeadingDetail(1, theme.heading1PaddingTop, theme.heading1PaddingRight, theme.heading1PaddingBottom, theme.heading1PaddingLeft)
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
    cjMarkdownTheme.setMarginForDesignateHeadingDetail(2, theme.heading2MarginTop, theme.heading2MarginRight, theme.heading2MarginBottom, theme.heading2MarginLeft)
    cjMarkdownTheme.setPaddingForDesignateHeadingDetail(2, theme.heading2PaddingTop, theme.heading2PaddingRight, theme.heading2PaddingBottom, theme.heading2PaddingLeft)
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
    cjMarkdownTheme.setMarginForDesignateHeadingDetail(3, theme.heading3MarginTop, theme.heading3MarginRight, theme.heading3MarginBottom, theme.heading3MarginLeft)
    cjMarkdownTheme.setPaddingForDesignateHeadingDetail(3, theme.heading3PaddingTop, theme.heading3PaddingRight, theme.heading3PaddingBottom, theme.heading3PaddingLeft)
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
    cjMarkdownTheme.setMarginForDesignateHeadingDetail(4, theme.heading4MarginTop, theme.heading4MarginRight, theme.heading4MarginBottom, theme.heading4MarginLeft)
    cjMarkdownTheme.setPaddingForDesignateHeadingDetail(4, theme.heading4PaddingTop, theme.heading4PaddingRight, theme.heading4PaddingBottom, theme.heading4PaddingLeft)
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
    cjMarkdownTheme.setMarginForDesignateHeadingDetail(5, theme.heading5MarginTop, theme.heading5MarginRight, theme.heading5MarginBottom, theme.heading5MarginLeft)
    cjMarkdownTheme.setPaddingForDesignateHeadingDetail(5, theme.heading5PaddingTop, theme.heading5PaddingRight, theme.heading5PaddingBottom, theme.heading5PaddingLeft)
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
    cjMarkdownTheme.setMarginForDesignateHeadingDetail(6, theme.heading6MarginTop, theme.heading6MarginRight, theme.heading6MarginBottom, theme.heading6MarginLeft)
    cjMarkdownTheme.setPaddingForDesignateHeadingDetail(6, theme.heading6PaddingTop, theme.heading6PaddingRight, theme.heading6PaddingBottom, theme.heading6PaddingLeft)
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
    let cjMarkdownTheme = new CJMarkdownHtmlUnderlineTheme()
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
      cjMarkdownTheme.setHtmlUnderlineTextFontWeight(theme.htmlUnderlineTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownImageTheme()
    cjMarkdownTheme.setImageMargin(theme.imageMarginTop, theme.imageMarginRight, theme.imageMarginBottom, theme.imageMarginLeft)
    cjMarkdownTheme.setImageRadius(theme.imageRadiusTopLeft, theme.imageRadiusTopRight, theme.imageRadiusBottomLeft, theme.imageRadiusBottomRight)
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
    cjMarkdownTheme.setImageDownloadButtonRadius(
      theme.imageDownloadButtonRadiusTopLeft,
      theme.imageDownloadButtonRadiusTopRight,
      theme.imageDownloadButtonRadiusBottomLeft,
      theme.imageDownloadButtonRadiusBottomRight
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
      cjMarkdownTheme.setImageDownloadButtonTextFontWeight(theme.imageDownloadButtonTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownInlineCodeTheme()
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
      cjMarkdownTheme.setInlineCodeTextFontWeight(theme.inlineCodeTextFontWeight)
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
    cjMarkdownTheme.setInlineCodeTextBackgroundRadius(
      theme.inlineCodeTextBackgroundRadiusTopLeft,
      theme.inlineCodeTextBackgroundRadiusTopRight,
      theme.inlineCodeTextBackgroundRadiusBottomLeft,
      theme.inlineCodeTextBackgroundRadiusBottomRight
    )
    return cjMarkdownTheme
  }

  getItalicTheme(theme: MarkdownThemeItalic): CJMarkdownItalicTheme | undefined {
    let cjMarkdownTheme = new CJMarkdownItalicTheme()
    if (theme.italicTextFontColor !== undefined) {
      cjMarkdownTheme.setItalicTextFontColor(theme.italicTextFontColor)
    }
    if (theme.italicTextFontSize !== undefined) {
      cjMarkdownTheme.setItalicTextFontSize(theme.italicTextFontSize)
    }
    if (theme.italicTextFontWeight !== undefined) {
      cjMarkdownTheme.setItalicTextFontWeight(theme.italicTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownLatexMathTheme()
    cjMarkdownTheme.setLatexMathMargin(theme.latexMathMarginTop, theme.latexMathMarginRight, theme.latexMathMarginBottom, theme.latexMathMarginLeft)
    cjMarkdownTheme.setLatexMathPadding(theme.latexMathPaddingTop, theme.latexMathPaddingRight, theme.latexMathPaddingBottom, theme.latexMathPaddingLeft)
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
      cjMarkdownTheme.setLatexMathDefaultTextFontWeight(theme.latexMathDefaultTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownLinkTheme()
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
      cjMarkdownTheme.setLinkTextFontWeight(theme.linkTextFontWeight)
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
    cjMarkdownTheme.setLinkTextBackgroundRadius(
      theme.linkTextBackgroundRadiusTopLeft,
      theme.linkTextBackgroundRadiusTopRight,
      theme.linkTextBackgroundRadiusBottomLeft,
      theme.linkTextBackgroundRadiusBottomRight
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
  let cjMarkdownTheme = new CJMarkdownOrderedListTheme()
  if (theme.orderedListBackgroundColor !== undefined) {
    cjMarkdownTheme.setOrderedListBackgroundColor(theme.orderedListBackgroundColor)
  }
  cjMarkdownTheme.setOrderedListMargin(
    theme.orderedListMarginTop,
    theme.orderedListMarginRight,
    theme.orderedListMarginBottom,
    theme.orderedListMarginLeft
  )
  cjMarkdownTheme.setOrderedListPadding(
    theme.orderedListPaddingTop,
    theme.orderedListPaddingRight,
    theme.orderedListPaddingBottom,
    theme.orderedListPaddingLeft
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
    cjMarkdownTheme.setOrderedListMarkerTextFontWeight(theme.orderedListMarkerTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownParagraphTheme()
    if (theme.paragraphBackgroundColor !== undefined) {
      cjMarkdownTheme.setParagraphBackgroundColor(theme.paragraphBackgroundColor)
    }
    cjMarkdownTheme.setParagraphMargin(
      theme.paragraphMarginTop,
      theme.paragraphMarginRight,
      theme.paragraphMarginBottom,
      theme.paragraphMarginLeft
    )
    cjMarkdownTheme.setParagraphPadding(
      theme.paragraphPaddingTop,
      theme.paragraphPaddingRight,
      theme.paragraphPaddingBottom,
      theme.paragraphPaddingLeft
    )
    if (theme.paragraphTextFontColor !== undefined) {
      cjMarkdownTheme.setParagraphTextFontColor(theme.paragraphTextFontColor)
    }
    if (theme.paragraphTextFontSize !== undefined) {
      cjMarkdownTheme.setParagraphTextFontSize(theme.paragraphTextFontSize)
    }
    if (theme.paragraphTextFontStyle !== undefined) {
      cjMarkdownTheme.setParagraphTextFontStyle(theme.paragraphTextFontStyle)
    }
    if (theme.paragraphTextFontWeight !== undefined) {
      cjMarkdownTheme.setParagraphTextFontWeight(theme.paragraphTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownStrikethroughTheme()
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
      cjMarkdownTheme.setStrikethroughTextFontWeight(theme.strikethroughTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownSubTheme()
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
      cjMarkdownTheme.setSubTextFontWeight(theme.subTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownSupTheme()
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
      cjMarkdownTheme.setSupTextFontWeight(theme.supTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownTableTheme()
    if (theme.tableTitleBackgroundColor !== undefined) {
      cjMarkdownTheme.setTableTitleBackgroundColor(theme.tableTitleBackgroundColor)
    }
    if (theme.tableContentOddRowBackgroundColor !== undefined) {
      cjMarkdownTheme.setTableContentOddRowBackgroundColor(theme.tableContentOddRowBackgroundColor)
    }
    if (theme.tableContentEvenRowBackgroundColor !== undefined) {
      cjMarkdownTheme.setTableContentEvenRowBackgroundColor(theme.tableContentEvenRowBackgroundColor)
    }
    cjMarkdownTheme.setTableMargin(
      theme.tableMarginTop,
      theme.tableMarginRight,
      theme.tableMarginBottom,
      theme.tableMarginLeft
    )
    cjMarkdownTheme.setTablePadding(
      theme.tablePaddingTop,
      theme.tablePaddingRight,
      theme.tablePaddingBottom,
      theme.tablePaddingLeft
    )
    cjMarkdownTheme.setTableCellPadding(
      theme.tableCellPaddingTop,
      theme.tableCellPaddingRight,
      theme.tableCellPaddingBottom,
      theme.tableCellPaddingLeft
    )
    if (theme.tableBorderStyle !== undefined) {
      cjMarkdownTheme.setTableBorderStyle(theme.tableBorderStyle)
    }
    if (theme.tableBorderWidth !== undefined) {
      cjMarkdownTheme.setTableBorderWidth(theme.tableBorderWidth)
    }
    if (theme.tableBorderColor !== undefined) {
      cjMarkdownTheme.setTableBorderColor(theme.tableBorderColor)
    }
    cjMarkdownTheme.setTableRadius(
      theme.tableRadiusTopLeft,
      theme.tableRadiusTopRight,
      theme.tableRadiusBottomLeft,
      theme.tableRadiusBottomRight
    )
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
      cjMarkdownTheme.setTableTitleTextFontWeight(theme.tableTitleTextFontWeight)
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
      cjMarkdownTheme.setTableContentTextFontWeight(theme.tableContentTextFontWeight)
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
    let cjMarkdownTheme = new CJMarkdownVideoTheme()
    if (theme.videoBackgroundColor !== undefined) {
      cjMarkdownTheme.setVideoBackgroundColor(theme.videoBackgroundColor)
    }
    cjMarkdownTheme.setVideoMargin(
      theme.videoMarginTop,
      theme.videoMarginRight,
      theme.videoMarginBottom,
      theme.videoMarginLeft
    )
    cjMarkdownTheme.setVideoPadding(
      theme.videoPaddingTop,
      theme.videoPaddingRight,
      theme.videoPaddingBottom,
      theme.videoPaddingLeft
    )
    cjMarkdownTheme.setVideoRadius(
      theme.videoRadiusTopLeft,
      theme.videoRadiusTopRight,
      theme.videoRadiusBottomLeft,
      theme.videoRadiusBottomRight
    )
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
      cjMarkdownTheme.setVideoTimeTextFontWeight(theme.videoTimeTextFontWeight)
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
    cjMarkdownTheme.setVideoReleaseButtonRadius(
      theme.videoReleaseButtonRadiusTopLeft,
      theme.videoReleaseButtonRadiusTopRight,
      theme.videoReleaseButtonRadiusBottomLeft,
      theme.videoReleaseButtonRadiusBottomRight
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
      cjMarkdownTheme.setVideoReleaseButtonTextFontWeight(theme.videoReleaseButtonTextFontWeight)
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
    cjMarkdownTheme.setVideoDownloadButtonRadius(
      theme.videoDownloadButtonRadiusTopLeft,
      theme.videoDownloadButtonRadiusTopRight,
      theme.videoDownloadButtonRadiusBottomLeft,
      theme.videoDownloadButtonRadiusBottomRight
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
      cjMarkdownTheme.setVideoDownloadButtonTextFontWeight(theme.videoDownloadButtonTextFontWeight)
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
