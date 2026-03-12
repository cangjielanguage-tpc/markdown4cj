/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { NodeController, FrameNode } from '@kit.ArkUI';
import {
  CJMarkdownConfig,
  CJMarkdownTheme,
  CJMarkdownPlugin,
  getLoadCJPage,
  registerImgPreprocessCallback,
  setGlobalContext,
  getCJResource,
  CJMarkdownScroller
} from 'libmarkdown.so';

class CJNodeController extends NodeController {
  rootNode?: FrameNode = undefined
  public callbackCJ: (input: string, isInputEnded: boolean, incrementalAnalysis: boolean) => void = (input: string, isInputEnded: boolean, incrementalAnalysis: boolean) => {
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
      this.callbackCJ = getLoadCJPage(this.mdStr, this.isInputEnded, this.incrementalAnalysis, this.config, this.plugin, this.listScroller)
    }
    return this.rootNode
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
      this.markdownNode = new CJNodeController(this.content, this.isInputEnded, this.incrementalAnalysis, this.getConfig(), this.getPlugin(), this.listScroller?.getScroller())
    }
  }

  build() {
    if (this.useCangjieComponent) {
      NodeContainer(this.markdownNode)
    } else {
      this.customContains()
    }
  }

  getConfig(): CJMarkdownConfig {
    let cjMarkdownConfig: CJMarkdownConfig = new CJMarkdownConfig()
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
        registerImgPreprocessCallback(this.config.imageCallbackCallback)
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

  getTheme(): CJMarkdownTheme {
    let cjMarkdownTheme: CJMarkdownTheme = new CJMarkdownTheme()
    if (this.config !== undefined) {
      if (this.config.markdownTheme !== undefined) {
        if (this.config.markdownTheme.context !== undefined) {
          setGlobalContext(this.config.markdownTheme.context)
        }
        getCJResource(
          this.config.markdownTheme.codeFullScreenIcon,
          this.config.markdownTheme.codeCopyIcon,
          this.config.markdownTheme.audioIcon,
          this.config.markdownTheme.videoImage,
          this.config.markdownTheme.playCircleFillIcon,
          this.config.markdownTheme.bannerImage,
          this.config.markdownTheme.imageResource,
          this.config.markdownTheme.videoReleaseImage,
          this.config.markdownTheme.videoDownloadImage,
          this.config.markdownTheme.imageDownloadImage
        )

        if (this.config.markdownTheme.isMarkdownParserSync !== undefined) {
          cjMarkdownTheme.setIsMarkdownParserSync(this.config.markdownTheme.isMarkdownParserSync)
        }
        if (this.config.markdownTheme.typeWriterOpen !== undefined) {
          cjMarkdownTheme.setTypeWriterOpen(this.config.markdownTheme.typeWriterOpen)
        }
        if (this.config.markdownTheme.typeWriterColor !== undefined) {
          cjMarkdownTheme.setTypeWriterColor(this.config.markdownTheme.typeWriterColor)
        }
        if (this.config.markdownTheme.isOnCopy !== undefined) {
          cjMarkdownTheme.setIsOnCopy(this.config.markdownTheme.isOnCopy)
        }
        if (this.config.markdownTheme.blockFirstTopMargin !== undefined) {
          cjMarkdownTheme.setBlockFirstTopMargin(this.config.markdownTheme.blockFirstTopMargin)
        }
        if (this.config.markdownTheme.blockLastBottomMargin !== undefined) {
          cjMarkdownTheme.setBlockLastBottomMargin(this.config.markdownTheme.blockLastBottomMargin)
        }
        if (this.config.markdownTheme.blockTopAndBottomMargins !== undefined) {
          cjMarkdownTheme.setBlockTopAndBottomMargins(this.config.markdownTheme.blockTopAndBottomMargins)
        }
        if (this.config.markdownTheme.isLinkStyle !== undefined) {
          cjMarkdownTheme.setIsLinkStyle(this.config.markdownTheme.isLinkStyle)
        }
        if (this.config.markdownTheme.isListLinkStyle !== undefined) {
          cjMarkdownTheme.setIsListLinkStyle(this.config.markdownTheme.isListLinkStyle)
        }
        if (this.config.markdownTheme.linkColor !== undefined) {
          cjMarkdownTheme.setLinkColor(this.config.markdownTheme.linkColor)
        }
        if (this.config.markdownTheme.isLinkSize !== undefined) {
          cjMarkdownTheme.setIsLinkSize(this.config.markdownTheme.isLinkSize)
        }
        if (this.config.markdownTheme.linkSize !== undefined) {
          cjMarkdownTheme.setLinkSize(this.config.markdownTheme.linkSize)
        }
        if (this.config.markdownTheme.linkLineHeight !== undefined) {
          cjMarkdownTheme.setLinkLineHeight(this.config.markdownTheme.linkLineHeight)
        }
        if (this.config.markdownTheme.linkBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkBackGroupColor(this.config.markdownTheme.linkBackGroupColor)
        }
        if (this.config.markdownTheme.isLinkUnderlined !== undefined) {
          cjMarkdownTheme.setIsLinkUnderlined(this.config.markdownTheme.isLinkUnderlined)
        }
        if (this.config.markdownTheme.linkCircleImageBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkCircleImageBackGroupColor(this.config.markdownTheme.linkCircleImageBackGroupColor)
        }
        if (this.config.markdownTheme.linkCircleImageButtonBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkCircleImageButtonBackGroupColor(this.config.markdownTheme.linkCircleImageButtonBackGroupColor)
        }
        if (this.config.markdownTheme.linkCircleImageTextSize !== undefined) {
          cjMarkdownTheme.setLinkCircleImageTextSize(this.config.markdownTheme.linkCircleImageTextSize)
        }
        if (this.config.markdownTheme.linkCircleImageTextColor !== undefined) {
          cjMarkdownTheme.setLinkCircleImageTextColor(this.config.markdownTheme.linkCircleImageTextColor)
        }
        if (this.config.markdownTheme.linkCircleImageRadius !== undefined) {
          cjMarkdownTheme.setLinkCircleImageRadius(this.config.markdownTheme.linkCircleImageRadius)
        }
        if (this.config.markdownTheme.linkCircleImageMargin !== undefined) {
          cjMarkdownTheme.setLinkCircleImageMargin(this.config.markdownTheme.linkCircleImageMargin)
        }
        if (this.config.markdownTheme.linkRectImageBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkRectImageBackGroupColor(this.config.markdownTheme.linkRectImageBackGroupColor)
        }
        if (this.config.markdownTheme.linkRectImageButtonBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkRectImageButtonBackGroupColor(this.config.markdownTheme.linkRectImageButtonBackGroupColor)
        }
        if (this.config.markdownTheme.linkRectImageTextSize !== undefined) {
          cjMarkdownTheme.setLinkRectImageTextSize(this.config.markdownTheme.linkRectImageTextSize)
        }
        if (this.config.markdownTheme.linkRectImageTextColor !== undefined) {
          cjMarkdownTheme.setLinkRectImageTextColor(this.config.markdownTheme.linkRectImageTextColor)
        }
        if (this.config.markdownTheme.linkRectImageHeight !== undefined) {
          cjMarkdownTheme.setLinkRectImageHeight(this.config.markdownTheme.linkRectImageHeight)
        }
        if (this.config.markdownTheme.linkRectImagePadding !== undefined) {
          cjMarkdownTheme.setLinkRectImagePadding(this.config.markdownTheme.linkRectImagePadding)
        }
        if (this.config.markdownTheme.linkRectImageRadius !== undefined) {
          cjMarkdownTheme.setLinkRectImageRadius(this.config.markdownTheme.linkRectImageRadius)
        }
        if (this.config.markdownTheme.linkRectImageMargin !== undefined) {
          cjMarkdownTheme.setLinkRectImageMargin(this.config.markdownTheme.linkRectImageMargin)
        }
        if (this.config.markdownTheme.linkRectToolImageBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageBackGroupColor(this.config.markdownTheme.linkRectToolImageBackGroupColor)
        }
        if (this.config.markdownTheme.linkRectToolImageButtonBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageButtonBackGroupColor(this.config.markdownTheme.linkRectToolImageButtonBackGroupColor)
        }
        if (this.config.markdownTheme.linkRectToolImageTextSize !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageTextSize(this.config.markdownTheme.linkRectToolImageTextSize)
        }
        if (this.config.markdownTheme.linkRectToolImageHeight !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageHeight(this.config.markdownTheme.linkRectToolImageHeight)
        }
        if (this.config.markdownTheme.linkRectToolImagePadding !== undefined) {
          cjMarkdownTheme.setLinkRectToolImagePadding(this.config.markdownTheme.linkRectToolImagePadding)
        }
        if (this.config.markdownTheme.linkRectToolImageBorderWidth !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageBorderWidth(this.config.markdownTheme.linkRectToolImageBorderWidth)
        }
        if (this.config.markdownTheme.linkRectToolImageDividingLineWidth !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageDividingLineWidth(this.config.markdownTheme.linkRectToolImageDividingLineWidth)
        }
        if (this.config.markdownTheme.linkRectToolImageMargin !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageMargin(this.config.markdownTheme.linkRectToolImageMargin)
        }
        if (this.config.markdownTheme.linkRectToolImageLineLeftPadding !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageLineLeftPadding(this.config.markdownTheme.linkRectToolImageLineLeftPadding)
        }
        if (this.config.markdownTheme.linkRectToolImageLineRightPadding !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageLineRightPadding(this.config.markdownTheme.linkRectToolImageLineRightPadding)
        }
        if (this.config.markdownTheme.blockQuoteLeftMargin !== undefined) {
          cjMarkdownTheme.setBlockQuoteLeftMargin(this.config.markdownTheme.blockQuoteLeftMargin)
        }
        if (this.config.markdownTheme.blockQuoteRightMargin !== undefined) {
          cjMarkdownTheme.setBlockQuoteRightMargin(this.config.markdownTheme.blockQuoteRightMargin)
        }
        if (this.config.markdownTheme.blockQuoteWidth !== undefined) {
          cjMarkdownTheme.setBlockQuoteWidth(this.config.markdownTheme.blockQuoteWidth)
        }
        if (this.config.markdownTheme.blockQuoteColor !== undefined) {
          cjMarkdownTheme.setBlockQuoteColor(this.config.markdownTheme.blockQuoteColor)
        }
        if (this.config.markdownTheme.blockQuoteBackGroupColor !== undefined) {
          cjMarkdownTheme.setBlockQuoteBackGroupColor(this.config.markdownTheme.blockQuoteBackGroupColor)
        }
        if (this.config.markdownTheme.blockQuoteTopAndBottomMargins !== undefined) {
          cjMarkdownTheme.setBlockQuoteTopAndBottomMargins(this.config.markdownTheme.blockQuoteTopAndBottomMargins)
        }
        if (this.config.markdownTheme.blockOrderedAndBulletTopAndBottomMargins !== undefined) {
          cjMarkdownTheme.setBlockOrderedAndBulletTopAndBottomMargins(this.config.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
        }
        if (this.config.markdownTheme.blockLeftMargin !== undefined) {
          cjMarkdownTheme.setBlockLeftMargin(this.config.markdownTheme.blockLeftMargin)
        }
        if (this.config.markdownTheme.blockRightMargin !== undefined) {
          cjMarkdownTheme.setBlockRightMargin(this.config.markdownTheme.blockRightMargin)
        }
        if (this.config.markdownTheme.orderedListItemPrefixBold !== undefined) {
          cjMarkdownTheme.setOrderedListItemPrefixBold(this.config.markdownTheme.orderedListItemPrefixBold)
        }
        if (this.config.markdownTheme.orderedListItemColor !== undefined) {
          cjMarkdownTheme.setOrderedListItemColor(this.config.markdownTheme.orderedListItemColor)
        }
        if (this.config.markdownTheme.orderedListItemSize !== undefined) {
          cjMarkdownTheme.setOrderedListItemSize(this.config.markdownTheme.orderedListItemSize)
        }
        if (this.config.markdownTheme.orderedListItemLineHeight !== undefined) {
          cjMarkdownTheme.setOrderedListItemLineHeight(this.config.markdownTheme.orderedListItemLineHeight)
        }
        if (this.config.markdownTheme.bulletListItemCircle !== undefined) {
          cjMarkdownTheme.setBulletListItemCircle(this.config.markdownTheme.bulletListItemCircle)
        }
        if (this.config.markdownTheme.bulletListItemColor !== undefined) {
          cjMarkdownTheme.setBulletListItemColor(this.config.markdownTheme.bulletListItemColor)
        }
        if (this.config.markdownTheme.bulletListItemSize !== undefined) {
          cjMarkdownTheme.setBulletListItemSize(this.config.markdownTheme.bulletListItemSize)
        }
        if (this.config.markdownTheme.bulletListItemLineHeight !== undefined) {
          cjMarkdownTheme.setBulletListItemLineHeight(this.config.markdownTheme.bulletListItemLineHeight)
        }
        if (this.config.markdownTheme.taskListItemLength !== undefined) {
          cjMarkdownTheme.setTaskListItemLength(this.config.markdownTheme.taskListItemLength)
        }
        if (this.config.markdownTheme.isCodeFormat !== undefined) {
          cjMarkdownTheme.setIsCodeFormat(this.config.markdownTheme.isCodeFormat)
        }
        if (this.config.markdownTheme.codeTextColor !== undefined) {
          cjMarkdownTheme.setCodeTextColor(this.config.markdownTheme.codeTextColor)
        }
        if (this.config.markdownTheme.codeBackgroundColor !== undefined) {
          cjMarkdownTheme.setCodeBackgroundColor(this.config.markdownTheme.codeBackgroundColor)
        }
        if (this.config.markdownTheme.codeTextSize !== undefined) {
          cjMarkdownTheme.setCodeTextSize(this.config.markdownTheme.codeTextSize)
        }
        if (this.config.markdownTheme.codeTypeface !== undefined) {
          cjMarkdownTheme.setCodeTypeface(this.config.markdownTheme.codeTypeface)
        }
        if (this.config.markdownTheme.isCodeBlockParserSync !== undefined) {
          cjMarkdownTheme.setIsCodeBlockParserSync(this.config.markdownTheme.isCodeBlockParserSync)
        }
        if (this.config.markdownTheme.codeBlockTextColor !== undefined) {
          cjMarkdownTheme.setCodeBlockTextColor(this.config.markdownTheme.codeBlockTextColor)
        }
        if (this.config.markdownTheme.codeBlockTypeTextColor !== undefined) {
          cjMarkdownTheme.setCodeBlockTypeTextColor(this.config.markdownTheme.codeBlockTypeTextColor)
        }
        if (this.config.markdownTheme.codeBlockTypeTextStr !== undefined) {
          cjMarkdownTheme.setCodeBlockTypeTextStr(this.config.markdownTheme.codeBlockTypeTextStr)
        }
        if (this.config.markdownTheme.codeBlockTypeTextPadding !== undefined) {
          cjMarkdownTheme.setCodeBlockTypeTextPadding(this.config.markdownTheme.codeBlockTypeTextPadding)
        }
        if (this.config.markdownTheme.codeBlockIconTextHide !== undefined) {
          cjMarkdownTheme.setCodeBlockIconTextHide(this.config.markdownTheme.codeBlockIconTextHide)
        }
        if (this.config.markdownTheme.codeBlockLineNumberHide !== undefined) {
          cjMarkdownTheme.setCodeBlockLineNumberHide(this.config.markdownTheme.codeBlockLineNumberHide)
        }
        if (this.config.markdownTheme.codeBlockBackgroundColor !== undefined) {
          cjMarkdownTheme.setCodeBlockBackgroundColor(this.config.markdownTheme.codeBlockBackgroundColor)
        }
        if (this.config.markdownTheme.codeMultilineMargin !== undefined) {
          cjMarkdownTheme.setCodeMultilineMargin(this.config.markdownTheme.codeMultilineMargin)
        }
        if (this.config.markdownTheme.codeBlockTypeface !== undefined) {
          cjMarkdownTheme.setCodeBlockTypeface(this.config.markdownTheme.codeBlockTypeface)
        }
        if (this.config.markdownTheme.codeBlockTextSize !== undefined) {
          cjMarkdownTheme.setCodeBlockTextSize(this.config.markdownTheme.codeBlockTextSize)
        }
        if (this.config.markdownTheme.codeBlockLineHeight !== undefined) {
          cjMarkdownTheme.setCodeBlockLineHeight(this.config.markdownTheme.codeBlockLineHeight)
        }
        if (this.config.markdownTheme.codeBlockRadius !== undefined) {
          cjMarkdownTheme.setCodeBlockRadius(this.config.markdownTheme.codeBlockRadius)
        }
        if (this.config.markdownTheme.isCodeFullScreen !== undefined) {
          cjMarkdownTheme.setIsCodeFullScreen(this.config.markdownTheme.isCodeFullScreen)
        }
        if (this.config.markdownTheme.iconWidthAndHeight !== undefined) {
          cjMarkdownTheme.setIconWidthAndHeight(this.config.markdownTheme.iconWidthAndHeight)
        }
        if (this.config.markdownTheme.codeListTitleTextSize !== undefined) {
          cjMarkdownTheme.setCodeListTitleTextSize(this.config.markdownTheme.codeListTitleTextSize)
        }
        if (this.config.markdownTheme.codeListTitleSelectTextSize !== undefined) {
          cjMarkdownTheme.setCodeListTitleSelectTextSize(this.config.markdownTheme.codeListTitleSelectTextSize)
        }
        if (this.config.markdownTheme.codeListTitleSelectTextColor !== undefined) {
          cjMarkdownTheme.setCodeListTitleSelectTextColor(this.config.markdownTheme.codeListTitleSelectTextColor)
        }
        if (this.config.markdownTheme.codeListTitleUnSelectTextColor !== undefined) {
          cjMarkdownTheme.setCodeListTitleUnSelectTextColor(this.config.markdownTheme.codeListTitleUnSelectTextColor)
        }
        if (this.config.markdownTheme.codeListTitleSelectBackGroupColor !== undefined) {
          cjMarkdownTheme.setCodeListTitleSelectBackGroupColor(this.config.markdownTheme.codeListTitleSelectBackGroupColor)
        }
        if (this.config.markdownTheme.codeListTitleUnSelectBackGroupColor !== undefined) {
          cjMarkdownTheme.setCodeListTitleUnSelectBackGroupColor(this.config.markdownTheme.codeListTitleUnSelectBackGroupColor)
        }
        if (this.config.markdownTheme.isSeparateCodeBlock !== undefined) {
          cjMarkdownTheme.setIsSeparateCodeBlock(this.config.markdownTheme.isSeparateCodeBlock)
        }
        if (this.config.markdownTheme.separateCodeBlockWidth !== undefined) {
          cjMarkdownTheme.setSeparateCodeBlockWidth(this.config.markdownTheme.separateCodeBlockWidth)
        }
        if (this.config.markdownTheme.separateCodeIsBottom !== undefined) {
          cjMarkdownTheme.setSeparateCodeIsBottom(this.config.markdownTheme.separateCodeIsBottom)
        }
        if (this.config.markdownTheme.headingBreakHeight !== undefined) {
          cjMarkdownTheme.setHeadingBreakHeight(this.config.markdownTheme.headingBreakHeight)
        }
        if (this.config.markdownTheme.headingTypeface !== undefined) {
          cjMarkdownTheme.setHeadingTypeface(this.config.markdownTheme.headingTypeface)
        }
        if (this.config.markdownTheme.headingTopMargins !== undefined) {
          cjMarkdownTheme.setHeadingTopMargins(this.config.markdownTheme.headingTopMargins)
        }
        if (this.config.markdownTheme.headingBottomMargins !== undefined) {
          cjMarkdownTheme.setHeadingBottomMargins(this.config.markdownTheme.headingBottomMargins)
        }
        if (this.config.markdownTheme.headingTextSize1 !== undefined) {
          cjMarkdownTheme.setHeadingTextSize1(this.config.markdownTheme.headingTextSize1)
        }
        if (this.config.markdownTheme.headingTextSize2 !== undefined) {
          cjMarkdownTheme.setHeadingTextSize2(this.config.markdownTheme.headingTextSize2)
        }
        if (this.config.markdownTheme.headingTextSize3 !== undefined) {
          cjMarkdownTheme.setHeadingTextSize3(this.config.markdownTheme.headingTextSize3)
        }
        if (this.config.markdownTheme.headingTextSize4 !== undefined) {
          cjMarkdownTheme.setHeadingTextSize4(this.config.markdownTheme.headingTextSize4)
        }
        if (this.config.markdownTheme.headingTextSize5 !== undefined) {
          cjMarkdownTheme.setHeadingTextSize5(this.config.markdownTheme.headingTextSize5)
        }
        if (this.config.markdownTheme.headingTextSize6 !== undefined) {
          cjMarkdownTheme.setHeadingTextSize6(this.config.markdownTheme.headingTextSize6)
        }
        if (this.config.markdownTheme.headingTextWordSpace !== undefined) {
          cjMarkdownTheme.setHeadingTextWordSpace(this.config.markdownTheme.headingTextWordSpace)
        }
        if (this.config.markdownTheme.headingTextLineHeight1 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight1(this.config.markdownTheme.headingTextLineHeight1)
        }
        if (this.config.markdownTheme.headingTextLineHeight2 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight2(this.config.markdownTheme.headingTextLineHeight2)
        }
        if (this.config.markdownTheme.headingTextLineHeight3 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight3(this.config.markdownTheme.headingTextLineHeight3)
        }
        if (this.config.markdownTheme.headingTextLineHeight4 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight4(this.config.markdownTheme.headingTextLineHeight4)
        }
        if (this.config.markdownTheme.headingTextLineHeight5 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight5(this.config.markdownTheme.headingTextLineHeight5)
        }
        if (this.config.markdownTheme.headingTextLineHeight6 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight6(this.config.markdownTheme.headingTextLineHeight6)
        }
        if (this.config.markdownTheme.headingTextColor1 !== undefined) {
          cjMarkdownTheme.setHeadingTextColor1(this.config.markdownTheme.headingTextColor1)
        }
        if (this.config.markdownTheme.headingTextColor2 !== undefined) {
          cjMarkdownTheme.setHeadingTextColor2(this.config.markdownTheme.headingTextColor2)
        }
        if (this.config.markdownTheme.headingTextColor3 !== undefined) {
          cjMarkdownTheme.setHeadingTextColor3(this.config.markdownTheme.headingTextColor3)
        }
        if (this.config.markdownTheme.headingTextColor4 !== undefined) {
          cjMarkdownTheme.setHeadingTextColor4(this.config.markdownTheme.headingTextColor4)
        }
        if (this.config.markdownTheme.headingTextColor5 !== undefined) {
          cjMarkdownTheme.setHeadingTextColor5(this.config.markdownTheme.headingTextColor5)
        }
        if (this.config.markdownTheme.headingTextColor6 !== undefined) {
          cjMarkdownTheme.setHeadingTextColor6(this.config.markdownTheme.headingTextColor6)
        }
        if (this.config.markdownTheme.paragraphTopMargins !== undefined) {
          cjMarkdownTheme.setParagraphTopMargins(this.config.markdownTheme.paragraphTopMargins)
        }
        if (this.config.markdownTheme.paragraphBottomMargins !== undefined) {
          cjMarkdownTheme.setParagraphBottomMargins(this.config.markdownTheme.paragraphBottomMargins)
        }
        if (this.config.markdownTheme.paragraphTextSize !== undefined) {
          cjMarkdownTheme.setParagraphTextSize(this.config.markdownTheme.paragraphTextSize)
        }
        if (this.config.markdownTheme.paragraphTextColor !== undefined) {
          cjMarkdownTheme.setParagraphTextColor(this.config.markdownTheme.paragraphTextColor)
        }
        if (this.config.markdownTheme.paragraphTextWordSpace !== undefined) {
          cjMarkdownTheme.setParagraphTextWordSpace(this.config.markdownTheme.paragraphTextWordSpace)
        }
        if (this.config.markdownTheme.paragraphTextLineHeight !== undefined) {
          cjMarkdownTheme.setParagraphTextLineHeight(this.config.markdownTheme.paragraphTextLineHeight)
        }
        if (this.config.markdownTheme.paragraphTypeface !== undefined) {
          cjMarkdownTheme.setParagraphTypeface(this.config.markdownTheme.paragraphTypeface)
        }
        if (this.config.markdownTheme.thematicBreakColor !== undefined) {
          cjMarkdownTheme.setThematicBreakColor(this.config.markdownTheme.thematicBreakColor)
        }
        if (this.config.markdownTheme.thematicBreakHeight !== undefined) {
          cjMarkdownTheme.setThematicBreakHeight(this.config.markdownTheme.thematicBreakHeight)
        }
        if (this.config.markdownTheme.thematicBreakTopMargin !== undefined) {
          cjMarkdownTheme.setThematicBreakTopMargin(this.config.markdownTheme.thematicBreakTopMargin)
        }
        if (this.config.markdownTheme.thematicBreakBottomMargin !== undefined) {
          cjMarkdownTheme.setThematicBreakBottomMargin(this.config.markdownTheme.thematicBreakBottomMargin)
        }
        if (this.config.markdownTheme.isLineBreak !== undefined) {
          cjMarkdownTheme.setIsLineBreak(this.config.markdownTheme.isLineBreak)
        }
        if (this.config.markdownTheme.latexDefaultText !== undefined) {
          cjMarkdownTheme.setLatexDefaultText(this.config.markdownTheme.latexDefaultText)
        }
        if (this.config.markdownTheme.latexMathTextSize !== undefined) {
          cjMarkdownTheme.setLatexMathTextSize(this.config.markdownTheme.latexMathTextSize)
        }
        if (this.config.markdownTheme.latexMathBackGroupColor !== undefined) {
          cjMarkdownTheme.setLatexMathBackGroupColor(this.config.markdownTheme.latexMathBackGroupColor)
        }
        if (this.config.markdownTheme.latexMathTextColor !== undefined) {
          cjMarkdownTheme.setLatexMathTextColor(this.config.markdownTheme.latexMathTextColor)
        }
        if (this.config.markdownTheme.latexMathColorFormat !== undefined) {
          cjMarkdownTheme.setLatexMathColorFormat(this.config.markdownTheme.latexMathColorFormat)
        }
        if (this.config.markdownTheme.latexMathBlockCenter !== undefined) {
          cjMarkdownTheme.setLatexMathBlockCenter(this.config.markdownTheme.latexMathBlockCenter)
        }
        if (this.config.markdownTheme.latexMathResStr !== undefined) {
          cjMarkdownTheme.setLatexMathResStr(this.config.markdownTheme.latexMathResStr)
        }
        if (this.config.markdownTheme.audioShadowColor !== undefined) {
          cjMarkdownTheme.setAudioShadowColor(this.config.markdownTheme.audioShadowColor)
        }
        if (this.config.markdownTheme.audioBorderColor !== undefined) {
          cjMarkdownTheme.setAudioBorderColor(this.config.markdownTheme.audioBorderColor)
        }
        if (this.config.markdownTheme.audioBorderWidth !== undefined) {
          cjMarkdownTheme.setAudioBorderWidth(this.config.markdownTheme.audioBorderWidth)
        }
        if (this.config.markdownTheme.audioBorderRadius !== undefined) {
          cjMarkdownTheme.setAudioBorderRadius(this.config.markdownTheme.audioBorderRadius)
        }
        if (this.config.markdownTheme.audioButtonBackgroundColor !== undefined) {
          cjMarkdownTheme.setAudioButtonBackgroundColor(this.config.markdownTheme.audioButtonBackgroundColor)
        }
        if (this.config.markdownTheme.audioButtonTextColor !== undefined) {
          cjMarkdownTheme.setAudioButtonTextColor(this.config.markdownTheme.audioButtonTextColor)
        }
        if (this.config.markdownTheme.audioButtonTextSize !== undefined) {
          cjMarkdownTheme.setAudioButtonTextSize(this.config.markdownTheme.audioButtonTextSize)
        }
        if (this.config.markdownTheme.audioButtonText !== undefined) {
          cjMarkdownTheme.setAudioButtonText(this.config.markdownTheme.audioButtonText)
        }
        if (this.config.markdownTheme.audioButtonBorderRadius !== undefined) {
          cjMarkdownTheme.setAudioButtonBorderRadius(this.config.markdownTheme.audioButtonBorderRadius)
        }
        if (this.config.markdownTheme.audioTitleTextSize !== undefined) {
          cjMarkdownTheme.setAudioTitleTextSize(this.config.markdownTheme.audioTitleTextSize)
        }
        if (this.config.markdownTheme.audioTitleTextColor !== undefined) {
          cjMarkdownTheme.setAudioTitleTextColor(this.config.markdownTheme.audioTitleTextColor)
        }
        if (this.config.markdownTheme.blockTopAndBottomMargins !== undefined) {
          cjMarkdownTheme.setBlockTopAndBottomMargins(this.config.markdownTheme.blockTopAndBottomMargins)
        }
        if (this.config.markdownTheme.blockTopAndBottomMargins !== undefined) {
          cjMarkdownTheme.setBlockTopAndBottomMargins(this.config.markdownTheme.blockTopAndBottomMargins)
        }
        if (this.config.markdownTheme.audioTitleTextLineHeight !== undefined) {
          cjMarkdownTheme.setAudioTitleTextLineHeight(this.config.markdownTheme.audioTitleTextLineHeight)
        }
        if (this.config.markdownTheme.audioTypeTextSize !== undefined) {
          cjMarkdownTheme.setAudioTypeTextSize(this.config.markdownTheme.audioTypeTextSize)
        }
        if (this.config.markdownTheme.audioTypeTextColor !== undefined) {
          cjMarkdownTheme.setAudioTypeTextColor(this.config.markdownTheme.audioTypeTextColor)
        }
        if (this.config.markdownTheme.audioTypeTextLineHeight !== undefined) {
          cjMarkdownTheme.setAudioTypeTextLineHeight(this.config.markdownTheme.audioTypeTextLineHeight)
        }
        if (this.config.markdownTheme.audioMarginTop !== undefined) {
          cjMarkdownTheme.setAudioMarginTop(this.config.markdownTheme.audioMarginTop)
        }
        if (this.config.markdownTheme.audioMarginBottom !== undefined) {
          cjMarkdownTheme.setAudioMarginBottom(this.config.markdownTheme.audioMarginBottom)
        }
        if (this.config.markdownTheme.videoBorderRadius !== undefined) {
          cjMarkdownTheme.setVideoBorderRadius(this.config.markdownTheme.videoBorderRadius)
        }
        if (this.config.markdownTheme.videoTimeTextColor !== undefined) {
          cjMarkdownTheme.setVideoTimeTextColor(this.config.markdownTheme.videoTimeTextColor)
        }
        if (this.config.markdownTheme.videoTimeTextSize !== undefined) {
          cjMarkdownTheme.setVideoTimeTextSize(this.config.markdownTheme.videoTimeTextSize)
        }
        if (this.config.markdownTheme.videoTimeTextMarginRight !== undefined) {
          cjMarkdownTheme.setVideoTimeTextMarginRight(this.config.markdownTheme.videoTimeTextMarginRight)
        }
        if (this.config.markdownTheme.videoTimeTextMarginBottom !== undefined) {
          cjMarkdownTheme.setVideoTimeTextMarginBottom(this.config.markdownTheme.videoTimeTextMarginBottom)
        }
        if (this.config.markdownTheme.videoMarginTop !== undefined) {
          cjMarkdownTheme.setVideoMarginTop(this.config.markdownTheme.videoMarginTop)
        }
        if (this.config.markdownTheme.videoMarginBottom !== undefined) {
          cjMarkdownTheme.setVideoMarginBottom(this.config.markdownTheme.videoMarginBottom)
        }
        if (this.config.markdownTheme.isVideoBottomLayout !== undefined) {
          cjMarkdownTheme.setIsVideoBottomLayout(this.config.markdownTheme.isVideoBottomLayout)
        }
        if (this.config.markdownTheme.videoReleaseImageWidthHeight !== undefined) {
          cjMarkdownTheme.setVideoReleaseImageWidthHeight(this.config.markdownTheme.videoReleaseImageWidthHeight)
        }
        if (this.config.markdownTheme.videoReleaseWidth !== undefined) {
          cjMarkdownTheme.setVideoReleaseWidth(this.config.markdownTheme.videoReleaseWidth)
        }
        if (this.config.markdownTheme.videoReleaseHeight !== undefined) {
          cjMarkdownTheme.setVideoReleaseHeight(this.config.markdownTheme.videoReleaseHeight)
        }
        if (this.config.markdownTheme.videoReleaseRadius !== undefined) {
          cjMarkdownTheme.setVideoReleaseRadius(this.config.markdownTheme.videoReleaseRadius)
        }
        if (this.config.markdownTheme.videoReleaseText !== undefined) {
          cjMarkdownTheme.setVideoReleaseText(this.config.markdownTheme.videoReleaseText)
        }
        if (this.config.markdownTheme.videoReleaseTexSize !== undefined) {
          cjMarkdownTheme.setVideoReleaseTexSize(this.config.markdownTheme.videoReleaseTexSize)
        }
        if (this.config.markdownTheme.videoReleaseTexColor !== undefined) {
          cjMarkdownTheme.setVideoReleaseTexColor(this.config.markdownTheme.videoReleaseTexColor)
        }
        if (this.config.markdownTheme.videoReleaseBackgroundColor !== undefined) {
          cjMarkdownTheme.setVideoReleaseBackgroundColor(this.config.markdownTheme.videoReleaseBackgroundColor)
        }
        if (this.config.markdownTheme.videoDownloadImageWidthHeight !== undefined) {
          cjMarkdownTheme.setVideoDownloadImageWidthHeight(this.config.markdownTheme.videoDownloadImageWidthHeight)
        }
        if (this.config.markdownTheme.videoDownloadWidth !== undefined) {
          cjMarkdownTheme.setVideoDownloadWidth(this.config.markdownTheme.videoDownloadWidth)
        }
        if (this.config.markdownTheme.videoDownloadHeight !== undefined) {
          cjMarkdownTheme.setVideoDownloadHeight(this.config.markdownTheme.videoDownloadHeight)
        }
        if (this.config.markdownTheme.videoDownloadRadius !== undefined) {
          cjMarkdownTheme.setVideoDownloadRadius(this.config.markdownTheme.videoDownloadRadius)
        }
        if (this.config.markdownTheme.videoDownloadText !== undefined) {
          cjMarkdownTheme.setVideoDownloadText(this.config.markdownTheme.videoDownloadText)
        }
        if (this.config.markdownTheme.videoDownloadTexSize !== undefined) {
          cjMarkdownTheme.setVideoDownloadTexSize(this.config.markdownTheme.videoDownloadTexSize)
        }
        if (this.config.markdownTheme.videoDownloadTexColor !== undefined) {
          cjMarkdownTheme.setVideoDownloadTexColor(this.config.markdownTheme.videoDownloadTexColor)
        }
        if (this.config.markdownTheme.videoDownloadBackgroundColor !== undefined) {
          cjMarkdownTheme.setVideoDownloadBackgroundColor(this.config.markdownTheme.videoDownloadBackgroundColor)
        }
        if (this.config.markdownTheme.imageFitType !== undefined) {
          cjMarkdownTheme.setImageFitType(this.config.markdownTheme.imageFitType)
        }
        if (this.config.markdownTheme.imageMaximumWidth !== undefined) {
          cjMarkdownTheme.setImageMaximumWidth(this.config.markdownTheme.imageMaximumWidth)
        }
        if (this.config.markdownTheme.imageFixedRatioWidth !== undefined) {
          cjMarkdownTheme.setImageFixedRatioWidth(this.config.markdownTheme.imageFixedRatioWidth)
        }
        if (this.config.markdownTheme.imageMaxHeight !== undefined) {
          cjMarkdownTheme.setImageMaxHeight(this.config.markdownTheme.imageMaxHeight)
        }
        if (this.config.markdownTheme.imageMaxWidth !== undefined) {
          cjMarkdownTheme.setImageMaxWidth(this.config.markdownTheme.imageMaxWidth)
        }
        if (this.config.markdownTheme.imageBorderRadius !== undefined) {
          cjMarkdownTheme.setImageBorderRadius(this.config.markdownTheme.imageBorderRadius)
        }
        if (this.config.markdownTheme.imageBorderWidth !== undefined) {
          cjMarkdownTheme.setImageBorderWidth(this.config.markdownTheme.imageBorderWidth)
        }
        if (this.config.markdownTheme.imageBorderColor !== undefined) {
          cjMarkdownTheme.setImageBorderColor(this.config.markdownTheme.imageBorderColor)
        }
        if (this.config.markdownTheme.isAutoResize !== undefined) {
          cjMarkdownTheme.setIsAutoResize(this.config.markdownTheme.isAutoResize)
        }
        if (this.config.markdownTheme.imageMarginTop !== undefined) {
          cjMarkdownTheme.setImageMarginTop(this.config.markdownTheme.imageMarginTop)
        }
        if (this.config.markdownTheme.imageMarginBottom !== undefined) {
          cjMarkdownTheme.setImageMarginBottom(this.config.markdownTheme.imageMarginBottom)
        }
        if (this.config.markdownTheme.isImageDownload !== undefined) {
          cjMarkdownTheme.setIsImageDownload(this.config.markdownTheme.isImageDownload)
        }
        if (this.config.markdownTheme.isImageMixedLayout !== undefined) {
          cjMarkdownTheme.setIsImageMixedLayout(this.config.markdownTheme.isImageMixedLayout)
        }
        if (this.config.markdownTheme.imageDownloadImageWidthHeight !== undefined) {
          cjMarkdownTheme.setImageDownloadImageWidthHeight(this.config.markdownTheme.imageDownloadImageWidthHeight)
        }
        if (this.config.markdownTheme.imageDownloadWidth !== undefined) {
          cjMarkdownTheme.setImageDownloadWidth(this.config.markdownTheme.imageDownloadWidth)
        }
        if (this.config.markdownTheme.imageDownloadHeight !== undefined) {
          cjMarkdownTheme.setImageDownloadHeight(this.config.markdownTheme.imageDownloadHeight)
        }
        if (this.config.markdownTheme.imageDownloadRadius !== undefined) {
          cjMarkdownTheme.setImageDownloadRadius(this.config.markdownTheme.imageDownloadRadius)
        }
        if (this.config.markdownTheme.imageDownloadText !== undefined) {
          cjMarkdownTheme.setImageDownloadText(this.config.markdownTheme.imageDownloadText)
        }
        if (this.config.markdownTheme.imageDownloadTexSize !== undefined) {
          cjMarkdownTheme.setImageDownloadTexSize(this.config.markdownTheme.imageDownloadTexSize)
        }
        if (this.config.markdownTheme.imageDownloadTexColor !== undefined) {
          cjMarkdownTheme.setImageDownloadTexColor(this.config.markdownTheme.imageDownloadTexColor)
        }
        if (this.config.markdownTheme.imageDownloadBackgroundColor !== undefined) {
          cjMarkdownTheme.setImageDownloadBackgroundColor(this.config.markdownTheme.imageDownloadBackgroundColor)
        }
        if (this.config.markdownTheme.tableCellPadding !== undefined) {
          cjMarkdownTheme.setTableCellPadding(this.config.markdownTheme.tableCellPadding)
        }
        if (this.config.markdownTheme.tableBorderColor !== undefined) {
          cjMarkdownTheme.setTableBorderColor(this.config.markdownTheme.tableBorderColor)
        }
        if (this.config.markdownTheme.tableBorderWidth !== undefined) {
          cjMarkdownTheme.setTableBorderWidth(this.config.markdownTheme.tableBorderWidth)
        }
        if (this.config.markdownTheme.tableOddRowBackgroundColor !== undefined) {
          cjMarkdownTheme.setTableOddRowBackgroundColor(this.config.markdownTheme.tableOddRowBackgroundColor)
        }
        if (this.config.markdownTheme.tableEvenRowBackgroundColor !== undefined) {
          cjMarkdownTheme.setTableEvenRowBackgroundColor(this.config.markdownTheme.tableEvenRowBackgroundColor)
        }
        if (this.config.markdownTheme.tableHeaderRowBackgroundColor !== undefined) {
          cjMarkdownTheme.setTableHeaderRowBackgroundColor(this.config.markdownTheme.tableHeaderRowBackgroundColor)
        }
        if (this.config.markdownTheme.tableTitleTextColor !== undefined) {
          cjMarkdownTheme.setTableTitleTextColor(this.config.markdownTheme.tableTitleTextColor)
        }
        if (this.config.markdownTheme.tableTitleTextSize !== undefined) {
          cjMarkdownTheme.setTableTitleTextSize(this.config.markdownTheme.tableTitleTextSize)
        }
        if (this.config.markdownTheme.tableTitleLineHeight !== undefined) {
          cjMarkdownTheme.setTableTitleLineHeight(this.config.markdownTheme.tableTitleLineHeight)
        }
        if (this.config.markdownTheme.tableContentTextColor !== undefined) {
          cjMarkdownTheme.setTableContentTextColor(this.config.markdownTheme.tableContentTextColor)
        }
        if (this.config.markdownTheme.tableContentTextSize !== undefined) {
          cjMarkdownTheme.setTableContentTextSize(this.config.markdownTheme.tableContentTextSize)
        }
        if (this.config.markdownTheme.tableTextLineHeight !== undefined) {
          cjMarkdownTheme.setTableTextLineHeight(this.config.markdownTheme.tableTextLineHeight)
        }
        if (this.config.markdownTheme.tableRadius !== undefined) {
          cjMarkdownTheme.setTableRadius(this.config.markdownTheme.tableRadius)
        }
        if (this.config.markdownTheme.tableMinTextWidth !== undefined) {
          cjMarkdownTheme.setTableMinTextWidth(this.config.markdownTheme.tableMinTextWidth)
        }
        if (this.config.markdownTheme.tableMaxTextWidth !== undefined) {
          cjMarkdownTheme.setTableMaxTextWidth(this.config.markdownTheme.tableMaxTextWidth)
        }
        if (this.config.markdownTheme.tableFirstColumnBold !== undefined) {
          cjMarkdownTheme.setTableFirstColumnBold(this.config.markdownTheme.tableFirstColumnBold)
        }
        if (this.config.markdownTheme.tableScrollBarShow !== undefined) {
          cjMarkdownTheme.setTableScrollBarShow(this.config.markdownTheme.tableScrollBarShow)
        }
        if (this.config.markdownTheme.tableScrollBarColor !== undefined) {
          cjMarkdownTheme.setTableScrollBarColor(this.config.markdownTheme.tableScrollBarColor)
        }
        if (this.config.markdownTheme.isDark !== undefined) {
          cjMarkdownTheme.setIsDark(this.config.markdownTheme.isDark)
        }
        if (this.config.markdownTheme.strikethroughColor !== undefined) {
          cjMarkdownTheme.setStrikethroughColor(this.config.markdownTheme.strikethroughColor)
        }
        if (this.config.markdownTheme.descListTermAndDefMargins !== undefined) {
          cjMarkdownTheme.setDescListTermAndDefMargins(this.config.markdownTheme.descListTermAndDefMargins)
        }
        if (this.config.markdownTheme.descListDefIndentation !== undefined) {
          cjMarkdownTheme.setDescListDefIndentation(this.config.markdownTheme.descListDefIndentation)
        }
        if (this.config.markdownTheme.descListDefMargins !== undefined) {
          cjMarkdownTheme.setDescListDefMargins(this.config.markdownTheme.descListDefMargins)
        }
        if (this.config.markdownTheme.subTextColor !== undefined) {
          cjMarkdownTheme.setSubTextColor(this.config.markdownTheme.subTextColor)
        }
        if (this.config.markdownTheme.subTextSize !== undefined) {
          cjMarkdownTheme.setSubTextSize(this.config.markdownTheme.subTextSize)
        }
        if (this.config.markdownTheme.subOffsetDist !== undefined) {
          cjMarkdownTheme.setSubOffsetDist(this.config.markdownTheme.subOffsetDist)
        }
        if (this.config.markdownTheme.supTextColor !== undefined) {
          cjMarkdownTheme.setSupTextColor(this.config.markdownTheme.supTextColor)
        }
        if (this.config.markdownTheme.supTextSize !== undefined) {
          cjMarkdownTheme.setSupTextSize(this.config.markdownTheme.supTextSize)
        }
        if (this.config.markdownTheme.supOffsetDist !== undefined) {
          cjMarkdownTheme.setSupOffsetDist(this.config.markdownTheme.supOffsetDist)
        }
        if (this.config.markdownTheme.underlineColor !== undefined) {
          cjMarkdownTheme.setUnderlineColor(this.config.markdownTheme.underlineColor)
        }
        if (this.config.markdownTheme.underlineStyle !== undefined) {
          cjMarkdownTheme.setUnderlineStyle(this.config.markdownTheme.underlineStyle)
        }
      }
    }
    return cjMarkdownTheme
  }

  getPlugin(): CJMarkdownPlugin {
    let cjMarkdownPlugin: CJMarkdownPlugin = new CJMarkdownPlugin()
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
}

/**
 * markdown配置
 */
export class MarkdownConfiguration {
  /**
   * 链接的点击事件
   */
  linkCallback?: (funcArg0: string) => void = undefined
  /**
   * 文本复制的点击事件
   */
  textCopyCallback?: (funcArg0: string) => void = undefined
  /**
   * 图片的点击事件
   */
  imageCallback?: (funcArg0: string, funcArg1: Array<string>) => void = undefined
  /**
   * 图片替换事件
   */
  imageCallbackCallback?: (funcArg0: string) => Promise<ArrayBuffer | undefined> = undefined
  /**
   * 图片下载的点击事件
   */
  imageDownloadCallback?: (funcArg0: string) => void = undefined
  /**
   * 音频的点击事件
   */
  audioCallback?: (funcArg0: string) => void = undefined
  /**
   * 视频的点击事件
   */
  videoCallback?: (funcArg0: string, funcArg1: Array<string>) => void = undefined
  /**
   * 视频的图片替换回调
   */
  videoImageCallback?: (funcArg0: string, funcArg1: (funcArgfuncArg0: string, funcArgfuncArg1: number, funcArgfuncArg2: number) => void) => void = undefined
  /**
   * 视频发布的点击事件
   */
  videoReleaseCallback?: (funcArg0: string) => void = undefined
  /**
   * 视频下载的点击事件
   */
  videoDownloadCallback?: (funcArg0: string) => void = undefined
  /**
   * 代码复制按钮的点击事件
   */
  codeCopyCallback?: (funcArg0: string) => void = undefined
  /**
   * 代码全屏按钮的点击事件
   */
  codeFullScreenCallback?: (funcArg0: string, funcArg1: string | undefined) => void = undefined
  /**
   * 数学公式图片点击事件
   */
  latexImageCallback?: (funcArg0: ArrayBuffer, funcArg1: number, funcArg2: number) => void = undefined
  /**
   * 数学公式数据处理事件
   */
  latexStrCallback?: (funcArg0: string) => string = undefined
  /**
   * TOC跳转指定位置
   */
  tocIndexCallback?: (funcArg0: number | undefined) => void = undefined
  /**
   * 脚注跳转指定位置
   */
  footnoteCallback?: (funcArg0: number | undefined) => void = undefined
  /**
   * markdown默认样式
   */
  markdownTheme?: MarkdownTheme = undefined

  /**
   * 设置链接点击回调
   *
   * @param cb 链接点击回调(funcArg0：链接url)
   */
  setLinkCallback(cb: (funcArg0: string) => void): void {
    this.linkCallback = cb
  }

  /**
   * 设置文本复制的点击事件
   *
   * @param cb 文本复制的点击事件(funcArg0：复制的文本)
   */
  setTextCopyCallback(cb: (funcArg0: string) => void): void {
    this.textCopyCallback = cb
  }

  /**
   * 设置图片点击回调
   *
   * @param cb 图片点击回调。 (funcArg0：图片url,funcArg1:所有图片和视频连接集合 --- 需要加载图片视频列表url集合列表解析插件)
   */
  setImageCallback(cb: (funcArg0: string, funcArg1: Array<string>) => void): void {
    this.imageCallback = cb
  }

  /**
   * 设置图片替换事件
   *
   * @param cb 图片替换事件。 (funcArg0：图片url 返回值是替换的图片数据)
   */
  setImageCallbackCallback(cb: (funcArg0: string) => Promise<ArrayBuffer | undefined>): void {
    this.imageCallbackCallback = cb
  }

  /**
   * 设置图片下载的点击事件
   *
   * @param cb 图片下载的点击事件。 (funcArg0：图片url)
   */
  setImageDownloadCallback(cb: (funcArg0: string) => void): void {
    this.imageDownloadCallback = cb
  }

  /**
   * 设置音频点击回调
   *
   * @param cb 音频点击回调(funcArg0：音频url) --- 需要加载音频解析插件
   */
  setAudioCallback(cb: (funcArg0: string) => void): void {
    this.audioCallback = cb
  }

  /**
   * 设置视频点击回调
   *
   * @param cb 视频点击回调。 (funcArg0：视频url,funcArg1:所有图片和视频连接集合 --- 需要加载图片视频列表url集合列表解析插件) --- 需要加载视频解析插件
   */
  setVideoCallback(cb: (funcArg0: string, funcArg1: Array<string>) => void): void {
    this.videoCallback = cb
  }

  /**
   * 设置视频占位图和宽高比和视频时长的回调
   *
   * @param cb 视频视频占位图和宽高比和视频时长回调。 (funcArg0：视频url,funcArg1:视频占位图和宽高比和视频时长回调 (funcArgfuncArg0:视频首帧图,funcArgfuncArg1:图片宽高比,funcArgfuncArg2,视频时长)) --- 需要加载视频解析插件
   */
  setVideoImageCallback(cb: (funcArg0: string, funcArg1: (funcArgfuncArg0: string, funcArgfuncArg1: number, funcArgfuncArg2: number) => void) => void): void {
    this.videoImageCallback = cb
  }

  /**
   * 设置视频发布的点击事件
   *
   * @param cb 视频发布的点击事件(funcArg0：视频url) --- 需要加载视频解析插件
   */
  setVideoReleaseCallback(cb: (funcArg0: string) => void): void {
    this.videoReleaseCallback = cb
  }

  /**
   * 设置视频下载的点击事件
   *
   * @param cb 视频下载的点击事件(funcArg0：视频url) --- 需要加载视频解析插件
   */
  setVideoDownloadCallback(cb: (funcArg0: string) => void): void {
    this.videoDownloadCallback = cb
  }

  /**
   * 设置代码复制点击回调
   *
   * @param cb 代码复制点击回调(funcArg0：代码内容)
   */
  setCodeCopyCallback(cb: (funcArg0: string) => void): void {
    this.codeCopyCallback = cb
  }

  /**
   * 设置代码全屏点击回调
   *
   * @param cb 代码全屏点击回调(funcArg0：代码内容, funcArg1:代码类型)
   */
  setCodeFullScreenCallback(cb: (funcArg0: string, funcArg1: string | undefined) => void): void {
    this.codeFullScreenCallback = cb
  }

  /**
   * 设置数学公式点击回调
   *
   * @param cb 数学公式点击回调(funcArg0：数学公式图片数组数据, funcArg1:图片高度, funcArg2:图片宽度) --- 需要加载数学公式解析插件
   */
  setLatexImageCallback(cb: (funcArg0: ArrayBuffer, funcArg1: number, funcArg2: number) => void): void {
    this.latexImageCallback = cb
  }

  /**
   * 设置数学公式公式预处理回调
   *
   * @param cb 数学公式公式预处理回调(funcArg0：数学公式文本内容,return：处理过后的数学公式文本) --- 需要加载数学公式解析插件
   */
  setLatexStrCallback(cb: (funcArg0: string) => string): void {
    this.latexStrCallback = cb
  }

  /**
   * 设置TOC点击回调
   *
   * @param cb TOC点击回调(funcArg0：偏移量) --- 需要加载TOC解析插件
   */
  setTocIndexCallback(cb: (funcArg0: number | undefined) => void): void {
    this.tocIndexCallback = cb
  }

  /**
   * 设置脚注点击回调
   *
   * @param cb 脚注点击回调(funcArg0：偏移量) --- 需要加载脚注解析插件
   */
  setFootnoteCallback(cb: (funcArg0: number | undefined) => void): void {
    this.footnoteCallback = cb
  }

  /**
   * 设置markdown样式
   *
   * @param markdownTheme markdown样式
   */
  setMarkdownTheme(markdownTheme: MarkdownTheme): void {
    this.markdownTheme = markdownTheme
  }
}

/**
 * Markdown用户可设置的样式
 */
export class MarkdownTheme {
  /**
   * 上下文
   */
  context?: Context = undefined
  /**
   * 代码块全屏图片icon
   */
  codeFullScreenIcon?: Resource = undefined
  /**
   * 代码块复制图片icon
   */
  codeCopyIcon?: Resource = undefined
  /**
   * 音频图片icon
   */
  audioIcon?: Resource = undefined
  /**
   * 视频默认占位图
   */
  videoImage?: Resource = undefined
  /**
   * 视频播放按钮icon
   */
  playCircleFillIcon?: Resource = undefined
  /**
   * banner默认占位图
   */
  bannerImage?: Resource = undefined
  /**
   * 图片默认占位图
   */
  imageResource?: Resource = undefined
  /**
   * 视频发布默认图标
   */
  videoReleaseImage?: Resource = undefined
  /**
   * 视频下载默认图标
   */
  videoDownloadImage?: Resource = undefined
  /**
   * 图片下载默认图标
   */
  imageDownloadImage?: Resource = undefined
  /**
   * markdown是否同步解析
   */
  isMarkdownParserSync?: boolean = undefined
  /**
   * 是否开启打字机效果
   */
  typeWriterOpen?: boolean = undefined
  /**
   * 打字机效果颜色
   */
  typeWriterColor?: number = undefined
  /**
   * 是否打开长按复制粘贴
   */
  isOnCopy?: boolean = undefined
  /**
   * markdown第一个模块上边距
   */
  blockFirstTopMargin?: number = undefined
  /**
   * markdown最后一个模块下边距
   */
  blockLastBottomMargin?: number = undefined
  /**
   * 模块间上下间距
   */
  blockTopAndBottomMargins?: number = undefined
  /**
   * 链接是否是图片显示
   */
  isLinkStyle?: boolean = undefined
  /**
   * 列表中的单行链接是否是图片显示
   */
  isListLinkStyle?: boolean = undefined
  /**
   * 文本格式链接文本颜色
   */
  linkColor?: number = undefined
  /**
   * 文本格式链接文字大小
   */
  isLinkSize?: boolean = undefined
  /**
   * 文本格式链接文字大小
   */
  linkSize?: number = undefined
  /**
   * 文本格式链接文字行高
   */
  linkLineHeight?: number = undefined
  /**
   * 文本格式链接背景颜色
   */
  linkBackGroupColor?: number = undefined
  /**
   * 文本格式是否显示链接下划线
   */
  isLinkUnderlined?: boolean = undefined
  /**
   * 圆形图片格式链接主题背景颜色
   */
  linkCircleImageBackGroupColor?: number = undefined
  /**
   * 圆形图片格式链接控件背景颜色
   */
  linkCircleImageButtonBackGroupColor?: number = undefined
  /**
   * 圆形图片格式链接文字大小
   */
  linkCircleImageTextSize?: number = undefined
  /**
   * 圆形图片格式链接文字颜色
   */
  linkCircleImageTextColor?: number = undefined
  /**
   * 圆形图片格式链接半径
   */
  linkCircleImageRadius?: number = undefined
  /**
   * 圆形图片格式链接左右外边距
   */
  linkCircleImageMargin?: number = undefined
  /**
   * 圆角矩形图片格式链接主题背景颜色
   */
  linkRectImageBackGroupColor?: number = undefined
  /**
   * 圆角矩形图片格式链接控件背景颜色
   */
  linkRectImageButtonBackGroupColor?: number = undefined
  /**
   * 圆角矩形图片格式链接文字大小
   */
  linkRectImageTextSize?: number = undefined
  /**
   * 圆角矩形图片格式链接文字颜色
   */
  linkRectImageTextColor?: number = undefined
  /**
   * 圆角矩形图片格式链接控件高度
   */
  linkRectImageHeight?: number = undefined
  /**
   * 圆角矩形图片格式链接左右内边距
   */
  linkRectImagePadding?: number = undefined
  /**
   * 圆角矩形图片格式链接圆角半径
   */
  linkRectImageRadius?: number = undefined
  /**
   * 圆角矩形图片格式链接左右外边距
   */
  linkRectImageMargin?: number = undefined
  /**
   * 空心圆角矩形图片格式链接主题背景颜色
   */
  linkRectToolImageBackGroupColor?: number = undefined
  /**
   * 空心圆角矩形图片格式链接控件背景颜色
   */
  linkRectToolImageButtonBackGroupColor?: number = undefined
  /**
   * 空心圆角矩形图片格式链接文字大小
   */
  linkRectToolImageTextSize?: number = undefined
  /**
   * 空心圆角矩形图片格式链接控件高度
   */
  linkRectToolImageHeight?: number = undefined
  /**
   * 空心圆角矩形图片格式链接左右内边距
   */
  linkRectToolImagePadding?: number = undefined
  /**
   * 空心圆角矩形图片格式链接边框宽度
   */
  linkRectToolImageBorderWidth?: number = undefined
  /**
   * 空心圆角矩形图片格式链接分割线宽度
   */
  linkRectToolImageDividingLineWidth?: number = undefined
  /**
   * 空心圆角矩形图片格式链接左右外边距
   */
  linkRectToolImageMargin?: number = undefined
  /**
   * 空心圆角矩形图片格式分割线和文本左边距
   */
  linkRectToolImageLineLeftPadding?: number = undefined
  /**
   * 空心圆角矩形图片格式分割线和文本右边距
   */
  linkRectToolImageLineRightPadding?: number = undefined
  /**
   * 块引用左边距
   */
  blockQuoteLeftMargin?: number = undefined
  /**
   * 块引用右边距
   */
  blockQuoteRightMargin?: number = undefined
  /**
   * 块引用左边线条宽度
   */
  blockQuoteWidth?: number = undefined
  /**
   * 块引用左边线条颜色
   */
  blockQuoteColor?: number = undefined
  /**
   * 块引用背景颜色
   */
  blockQuoteBackGroupColor?: number = undefined
  /**
   * 块引用子模块上下间距
   */
  blockQuoteTopAndBottomMargins?: number = undefined
  /**
   * 有序列表、无序列表、任务列表子模块上下间距
   */
  blockOrderedAndBulletTopAndBottomMargins?: number = undefined
  /**
   * 有序列表、无序列表、任务列表左边距
   */
  blockLeftMargin?: number = undefined
  /**
   * 有序列表、无序列表、任务列表右边距
   */
  blockRightMargin?: number = undefined
  /**
   * 有序列表前缀文本是否加粗
   */
  orderedListItemPrefixBold?: boolean = undefined
  /**
   * 有序列表前缀文本颜色
   */
  orderedListItemColor?: number = undefined
  /**
   * 有序列表前缀文本大小
   */
  orderedListItemSize?: number = undefined
  /**
   * 有序列表前缀文本行高
   */
  orderedListItemLineHeight?: number = undefined
  /**
   * 无序列表前缀是否全部是实心圆型
   */
  bulletListItemCircle?: boolean = undefined
  /**
   * 无序列表前缀文本颜色
   */
  bulletListItemColor?: number = undefined
  /**
   * 无序列表前缀文本大小
   */
  bulletListItemSize?: number = undefined
  /**
   * 无序列表前缀文本行高
   */
  bulletListItemLineHeight?: number = undefined
  /**
   * 任务列表选择框宽高
   */
  taskListItemLength?: number = undefined
  /**
   * 设置是否格式化代码块内容
   */
  isCodeFormat?: boolean = undefined
  /**
   * 内联代码文本颜色
   */
  codeTextColor?: number = undefined
  /**
   * 内联代码背景颜色
   */
  codeBackgroundColor?: number = undefined
  /**
   * 内联代码文本大小
   */
  codeTextSize?: number = undefined
  /**
   * 内联代码文本字体
   */
  codeTypeface?: string = undefined
  /**
   * 围栏代码块代码高亮是否同步解析
   */
  isCodeBlockParserSync?: boolean = undefined
  /**
   * 代码块代码文本颜色
   */
  codeBlockTextColor?: number = undefined
  /**
   * 代码块代码类型文本颜色
   */
  codeBlockTypeTextColor?: number = undefined
  /**
   * 代码块代码类型文本
   */
  codeBlockTypeTextStr?: string = undefined
  /**
   * 代码类型和代码块距离
   */
  codeBlockTypeTextPadding?: number = undefined
  /**
   * 代码块复制、全屏图片文字是否显示
   */
  codeBlockIconTextHide?: boolean = undefined
  /**
   * 代码块代码行号是否显示
   */
  codeBlockLineNumberHide?: boolean = undefined
  /**
   * 代码块背景颜色
   */
  codeBlockBackgroundColor?: number = undefined
  /**
   * 代码块左边距
   */
  codeMultilineMargin?: number = undefined
  /**
   * 代码块字体
   */
  codeBlockTypeface?: string = undefined
  /**
   * 代码块代码文本大小
   */
  codeBlockTextSize?: number = undefined
  /**
   * 代码块代码文本行高
   */
  codeBlockLineHeight?: number = undefined
  /**
   * 代码块控件圆角大小
   */
  codeBlockRadius?: number = undefined
  /**
   * 代码块代码全屏按钮是否显示
   */
  isCodeFullScreen?: boolean = undefined
  /**
   * 代码块代码全屏、代码复制按钮宽高
   */
  iconWidthAndHeight?: number = undefined
  /**
   * 组合代码未选中标题字体大小
   */
  codeListTitleTextSize?: number = undefined
  /**
   * 组合代码选中标题字体大小
   */
  codeListTitleSelectTextSize?: number = undefined
  /**
   * 组合代码选中标题文本颜色
   */
  codeListTitleSelectTextColor?: number = undefined
  /**
   * 组合代码未选中标题文本颜色
   */
  codeListTitleUnSelectTextColor?: number = undefined
  /**
   * 组合代码选中标题背景颜色
   */
  codeListTitleSelectBackGroupColor?: number = undefined
  /**
   * 组合代码未选中标题背景颜色
   */
  codeListTitleUnSelectBackGroupColor?: number = undefined
  /**
   * 是否单独代码块显示
   */
  isSeparateCodeBlock?: boolean = undefined
  /**
   * 单独代码块行号宽度
   */
  separateCodeBlockWidth?: number = undefined
  /**
   * 单独代码块是否居底显示
   */
  separateCodeIsBottom?: boolean = undefined
  /**
   * H1、H2标题下分割线高度
   */
  headingBreakHeight?: number = undefined
  /**
   * 标题文本字体
   */
  headingTypeface?: string = undefined
  /**
   * 标题模块上间距
   */
  headingTopMargins?: number = undefined
  /**
   * 标题模块下间距
   */
  headingBottomMargins?: number = undefined
  /**
   * 一级标题文本大小
   */
  headingTextSize1?: number = undefined
  /**
   * 二级标题文本大小
   */
  headingTextSize2?: number = undefined
  /**
   * 三级标题文本大小
   */
  headingTextSize3?: number = undefined
  /**
   * 四级标题文本大小
   */
  headingTextSize4?: number = undefined
  /**
   * 五级标题文本大小
   */
  headingTextSize5?: number = undefined
  /**
   * 六级标题文本大小
   */
  headingTextSize6?: number = undefined
  /**
   * 标题文本字间距
   */
  headingTextWordSpace?: number = undefined
  /**
   * 一级标题文本行高
   */
  headingTextLineHeight1?: number = undefined
  /**
   * 二级标题文本行高
   */
  headingTextLineHeight2?: number = undefined
  /**
   * 三级标题文本行高
   */
  headingTextLineHeight3?: number = undefined
  /**
   * 四级标题文本行高
   */
  headingTextLineHeight4?: number = undefined
  /**
   * 五级标题文本行高
   */
  headingTextLineHeight5?: number = undefined
  /**
   * 六级标题文本行高
   */
  headingTextLineHeight6?: number = undefined
  /**
   * 一级标题文本颜色
   */
  headingTextColor1?: number = undefined
  /**
   * H1标题下分割线颜色
   */
  headingBreakColor1?: number = undefined
  /**
   * 二级标题文本颜色
   */
  headingTextColor2?: number = undefined
  /**
   * H2标题下分割线颜色
   */
  headingBreakColor2?: number = undefined
  /**
   * 三级标题文本颜色
   */
  headingTextColor3?: number = undefined
  /**
   * 四级标题文本颜色
   */
  headingTextColor4?: number = undefined
  /**
   * 五级标题文本颜色
   */
  headingTextColor5?: number = undefined
  /**
   * 六级标题文本颜色
   */
  headingTextColor6?: number = undefined
  /**
   * 段落模块上间距
   */
  paragraphTopMargins?: number = undefined
  /**
   * 段落模块下间距
   */
  paragraphBottomMargins?: number = undefined
  /**
   * 段落文本大小
   */
  paragraphTextSize?: number = undefined
  /**
   * 段落文本颜色
   */
  paragraphTextColor?: number = undefined
  /**
   * 段落文本字间距
   */
  paragraphTextWordSpace?: number = undefined
  /**
   * 段落文本行高
   */
  paragraphTextLineHeight?: number = undefined
  /**
   * 段落文本字体
   */
  paragraphTypeface?: string = undefined
  /**
   * 分割线颜色
   */
  thematicBreakColor?: number = undefined
  /**
   * 分割线高度
   */
  thematicBreakHeight?: number = undefined
  /**
   * 分割线上部外边距
   */
  thematicBreakTopMargin?: number = undefined
  /**
   * 分割线下部外边距
   */
  thematicBreakBottomMargin?: number = undefined
  /**
   * 软换行是否换行
   */
  isLineBreak?: boolean = undefined
  /**
   * 数学公式未加载状态是否显示文字
   */
  latexDefaultText?: boolean = undefined
  /**
   * 数学公式文本大小
   */
  latexMathTextSize?: number = undefined
  /**
   * 数学公式背景色
   */
  latexMathBackGroupColor?: number = undefined
  /**
   * 数学公式文本颜色
   */
  latexMathTextColor?: number = undefined
  /**
   * 数学公式生成图片格式
   */
  latexMathColorFormat?: LatexMathColorFormat = undefined
  /**
   * 块结构的数学公式是否居中
   */
  latexMathBlockCenter?: boolean = undefined
  /**
   * 数学公式字体路径
   */
  latexMathResStr?: string = undefined
  /**
   * 音频阴影颜色值
   */
  audioShadowColor?: number = undefined
  /**
   * 音频边框颜色
   */
  audioBorderColor?: number = undefined
  /**
   * 音频边框粗细
   */
  audioBorderWidth?: number = undefined
  /**
   * 音频边框圆角
   */
  audioBorderRadius?: number = undefined
  /**
   * 音频按钮背景颜色
   */
  audioButtonBackgroundColor?: number = undefined
  /**
   * 音频按钮文字颜色
   */
  audioButtonTextColor?: number = undefined
  /**
   * 音频按钮文字大小
   */
  audioButtonTextSize?: number = undefined
  /**
   * 音频按钮文字内容
   */
  audioButtonText?: string = undefined
  /**
   * 音频按钮圆角
   */
  audioButtonBorderRadius?: number = undefined
  /**
   * 音频标题文字大小
   */
  audioTitleTextSize?: number = undefined
  /**
   * 音频标题文字颜色
   */
  audioTitleTextColor?: number = undefined
  /**
   * 音频标题文字行高
   */
  audioTitleTextLineHeight?: number = undefined
  /**
   * 音频类型文字大小
   */
  audioTypeTextSize?: number = undefined
  /**
   * 音频类型文字颜色
   */
  audioTypeTextColor?: number = undefined
  /**
   * 音频类型文字行高
   */
  audioTypeTextLineHeight?: number = undefined
  /**
   * 音频上边距
   */
  audioMarginTop?: number = undefined
  /**
   * 音频下边距
   */
  audioMarginBottom?: number = undefined
  /**
   * 视频圆角
   */
  videoBorderRadius?: number = undefined
  /**
   * 视频时间文本颜色
   */
  videoTimeTextColor?: number = undefined
  /**
   * 视频时间文本大小
   */
  videoTimeTextSize?: number = undefined
  /**
   * 视频时间文本居右边距
   */
  videoTimeTextMarginRight?: number = undefined
  /**
   * 视频时间文本居底边距
   */
  videoTimeTextMarginBottom?: number = undefined
  /**
   * 视频上边距
   */
  videoMarginTop?: number = undefined
  /**
   * 视频下边距
   */
  videoMarginBottom?: number = undefined
  /**
   * 视频发布/下载按钮布局是否显示
   */
  isVideoBottomLayout?: boolean = undefined
  /**
   * 视频发布按钮图片宽度和高度
   */
  videoReleaseImageWidthHeight?: number = undefined
  /**
   * 视频发布按钮宽度
   */
  videoReleaseWidth?: number = undefined
  /**
   * 视频发布按钮高度
   */
  videoReleaseHeight?: number = undefined
  /**
   * 视频发布按钮圆角
   */
  videoReleaseRadius?: number = undefined
  /**
   * 视频发布按钮文本内容
   */
  videoReleaseText?: string = undefined
  /**
   * 视频发布按钮文本大小
   */
  videoReleaseTexSize?: number = undefined
  /**
   * 视频发布按钮文本颜色
   */
  videoReleaseTexColor?: number = undefined
  /**
   * 视频发布按钮背景颜色
   */
  videoReleaseBackgroundColor?: number = undefined
  /**
   * 视频下载按钮图片宽度和高度
   */
  videoDownloadImageWidthHeight?: number = undefined
  /**
   * 视频下载按钮宽度
   */
  videoDownloadWidth?: number = undefined
  /**
   * 视频下载按钮高度
   */
  videoDownloadHeight?: number = undefined
  /**
   * 视频下载按钮圆角
   */
  videoDownloadRadius?: number = undefined
  /**
   * 视频下载按钮文本内容
   */
  videoDownloadText?: string = undefined
  /**
   * 视频下载按钮文本大小
   */
  videoDownloadTexSize?: number = undefined
  /**
   * 视频下载按钮文本颜色
   */
  videoDownloadTexColor?: number = undefined
  /**
   * 视频下载按钮背景颜色
   */
  videoDownloadBackgroundColor?: number = undefined
  /**
   * 图片缩放类型
   */
  imageFitType?: ImageFitType = undefined
  /**
   * 图片最大宽度百分比
   */
  imageMaximumWidth?: number = undefined
  /**
   * 图片固定宽度百分比
   */
  imageFixedRatioWidth?: number = undefined
  /**
   * 图片最大高度
   */
  imageMaxHeight?: number = undefined
  /**
   * 图片最大宽度
   */
  imageMaxWidth?: number = undefined
  /**
   * 图片圆角大小
   */
  imageBorderRadius?: number = undefined
  /**
   * 图片圆角大小
   */
  imageBorderWidth?: number = undefined
  /**
   * 图片圆角大小
   */
  imageBorderColor?: number = undefined
  /**
   * 网络图片是否压缩
   */
  isAutoResize?: boolean = undefined
  /**
   * 图片上边距
   */
  imageMarginTop?: number = undefined
  /**
   * 图片下边距
   */
  imageMarginBottom?: number = undefined
  /**
   * 图片是否有下载按钮
   */
  isImageDownload?: boolean = undefined
  /**
   * 是否图文混排
   */
  isImageMixedLayout?: boolean = undefined
  /**
   * 图片下载按钮图片宽度和高度
   */
  imageDownloadImageWidthHeight?: number = undefined
  /**
   * 图片下载按钮宽度
   */
  imageDownloadWidth?: number = undefined
  /**
   * 图片下载按钮高度
   */
  imageDownloadHeight?: number = undefined
  /**
   * 图片下载按钮圆角
   */
  imageDownloadRadius?: number = undefined
  /**
   * 图片下载按钮文本内容
   */
  imageDownloadText?: string = undefined
  /**
   * 图片下载按钮文本大小
   */
  imageDownloadTexSize?: number = undefined
  /**
   * 图片下载按钮文本颜色
   */
  imageDownloadTexColor?: number = undefined
  /**
   * 图片下载按钮背景颜色
   */
  imageDownloadBackgroundColor?: number = undefined
  /**
   * 表格内容内边距
   */
  tableCellPadding?: number = undefined
  /**
   * 表格边框颜色
   */
  tableBorderColor?: number = undefined
  /**
   * 表格边框宽度
   */
  tableBorderWidth?: number = undefined
  /**
   * 表格奇数行背景色
   */
  tableOddRowBackgroundColor?: number = undefined
  /**
   * 表格偶数行背景色
   */
  tableEvenRowBackgroundColor?: number = undefined
  /**
   * 表格头背景色
   */
  tableHeaderRowBackgroundColor?: number = undefined
  /**
   * 表格头文本颜色
   */
  tableTitleTextColor?: number = undefined
  /**
   * 表格头文本大小
   */
  tableTitleTextSize?: number = undefined
  /**
   * 表格头文本行高
   */
  tableTitleLineHeight?: number = undefined
  /**
   * 表格内容文本颜色
   */
  tableContentTextColor?: number = undefined
  /**
   * 表格内容文本大小
   */
  tableContentTextSize?: number = undefined
  /**
   * 表格文本行高
   */
  tableTextLineHeight?: number = undefined
  /**
   * 表格圆角
   */
  tableRadius?: number = undefined
  /**
   * 表格最小宽度
   */
  tableMinTextWidth?: number = undefined
  /**
   * 表格最大宽度
   */
  tableMaxTextWidth?: number = undefined
  /**
   * 表格第一列是否加粗
   */
  tableFirstColumnBold?: boolean = undefined
  /**
   * 表格是否显示滚动条
   */
  tableScrollBarShow?: boolean = undefined
  /**
   * 表格滚动条颜色
   */
  tableScrollBarColor?: number = undefined
  /**
   * 代码深浅色模式
   */
  isDark?: boolean = undefined
  /**
   * 删除线颜色
   */
  strikethroughColor?: number = undefined
  /**
   * 删除线样式
   */
  strikethroughStyle?: TextDecorationStyle = undefined
  /**
   * 定义列表定义行缩进
   */
  descListTermAndDefMargins?: number = undefined
  /**
   * 定义列表定义行缩进
   */
  descListDefIndentation?: number = undefined
  /**
   * 定义列表定义行间距
   */
  descListDefMargins?: number = undefined
  /**
   * 下标字体颜色
   */
  subTextColor?: number = undefined
  /**
   * 下标字体大小
   */
  subTextSize?: number = undefined
  /**
   * 下标偏移距离
   */
  subOffsetDist?: number = undefined
  /**
   * 上标字体颜色
   */
  supTextColor?: number = undefined
  /**
   * 上标字体大小
   */
  supTextSize?: number = undefined
  /**
   * 上标偏移距离
   */
  supOffsetDist?: number = undefined
  /**
   * 下划线颜色
   */
  underlineColor?: number = undefined
  /**
   * 下划线样式
   */
  underlineStyle?: TextDecorationStyle = undefined

  /**
   * 设置上下文
   *
   * @param context 上下文
   */
  setContext(context: Context): void {
    this.context = context
  }

  /**
   * 设置代码块全屏图片icon
   *
   * @param codeFullScreenIcon 代码块全屏图片icon
   */
  setCodeFullScreenIcon(codeFullScreenIcon: Resource): void {
    this.codeFullScreenIcon = codeFullScreenIcon
  }

  /**
   * 设置代码块复制图片icon
   *
   * @param codeCopyIcon 代码块复制图片icon
   */
  setCodeCopyIcon(codeCopyIcon: Resource): void {
    this.codeCopyIcon = codeCopyIcon
  }

  /**
   * 设置音频图片icon
   *
   * @param audioIcon 音频图片icon
   */
  setAudioIcon(audioIcon: Resource): void {
    this.audioIcon = audioIcon
  }

  /**
   * 设置视频默认占位图
   *
   * @param videoImage 视频默认占位图
   */
  setVideoImage(videoImage: Resource): void {
    this.videoImage = videoImage
  }

  /**
   * 设置视频播放按钮icon
   *
   * @param playCircleFillIcon 视频播放按钮icon
   */
  setPlayCircleFillIcon(playCircleFillIcon: Resource): void {
    this.playCircleFillIcon = playCircleFillIcon
  }

  /**
   * 设置banner占位图
   *
   * @param bannerImage banner占位图
   */
  setBannerImage(bannerImage: Resource): void {
    this.bannerImage = bannerImage
  }

  /**
   * 设置图片占位图
   *
   * @param imageResource 图片占位图
   */
  setImageResource(imageResource: Resource): void {
    this.imageResource = imageResource
  }

  /**
   * 设置视频发布默认图标
   *
   * @param videoReleaseImage 视频发布默认图标
   */
  setVideoReleaseImage(videoReleaseImage: Resource): void {
    this.videoReleaseImage = videoReleaseImage
  }

  /**
   * 设置视频下载默认图标
   *
   * @param videoDownloadImage 视频下载默认图标
   */
  setVideoDownloadImage(videoDownloadImage: Resource): void {
    this.videoDownloadImage = videoDownloadImage
  }

  /**
   * 设置图片下载默认图标
   *
   * @param imageDownloadImage 图片下载默认图标
   */
  setImageDownloadImage(imageDownloadImage: Resource): void {
    this.imageDownloadImage = imageDownloadImage
  }

  /**
   * 设置markdown是否同步解析
   *
   * @param isMarkdownParserSync markdown是否同步解析 - 默认false
   */
  setIsMarkdownParserSync(isMarkdownParserSync: boolean): void {
    this.isMarkdownParserSync = isMarkdownParserSync
  }

  /**
   * 设置是否显示打字机效果
   *
   * @param typeWriterOpen 是否显示打字机效果 - true：显示；false：不显示。默认true
   */
  setTypeWriterOpen(typeWriterOpen: boolean): void {
    this.typeWriterOpen = typeWriterOpen
  }

  /**
   * 设置打字机效果颜色
   *
   * @param typeWriterColor 打字机效果颜色 - 默认RED
   */
  setTypeWriterColor(typeWriterColor: number): void {
    this.typeWriterColor = typeWriterColor
  }

  /**
   * 设置是否打开长按复制粘贴
   *
   * @param isOnCopy 是否打开长按复制粘贴 - 默认true
   */
  setIsOnCopy(isOnCopy: boolean): void {
    this.isOnCopy = isOnCopy
  }

  /**
   * 设置markdown第一个模块上边距
   *
   * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
   */
  setBlockFirstTopMargin(blockFirstTopMargin: number): void {
    this.blockFirstTopMargin = blockFirstTopMargin
  }

  /**
   * 设置markdown最后一个模块下边距
   *
   * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
   */
  setBlockLastBottomMargin(blockLastBottomMargin: number): void {
    this.blockLastBottomMargin = blockLastBottomMargin
  }

  /**
   * 设置模块间上下间距
   *
   * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
   */
  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): void {
    this.blockTopAndBottomMargins = blockTopAndBottomMargins
  }

  /**
   * 设置链接是否是图片显示
   *
   * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   */
  setIsLinkStyle(isLinkStyle: boolean): void {
    this.isLinkStyle = isLinkStyle
  }

  /**
   * 设置列表中的单行链接是否是图片显示
   *
   * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
   */
  setIsListLinkStyle(isListLinkStyle: boolean): void {
    this.isListLinkStyle = isListLinkStyle
  }

  /**
   * 设置文本格式链接文本颜色
   *
   * @param linkColor 文本格式链接文本颜色 - 默认0XFF0000FF
   */
  setLinkColor(linkColor: number): void {
    this.linkColor = linkColor
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
    this.linkSize = linkSize
  }

  /**
   * 设置文本格式链接文字行高
   *
   * @param linkLineHeight 文本格式链接文字行高
   */
  setLinkLineHeight(linkLineHeight: number): void {
    this.linkLineHeight = linkLineHeight
  }

  /**
   * 设置文本格式链接背景颜色
   *
   * @param linkBackGroupColor 文本格式链接背景颜色 - 默认0XFF000000
   */
  setLinkBackGroupColor(linkBackGroupColor: number): void {
    this.linkBackGroupColor = linkBackGroupColor
  }

  /**
   * 设置文本格式是否显示链接下划线
   *
   * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
   */
  setIsLinkUnderlined(isLinkUnderlined: boolean): void {
    this.isLinkUnderlined = isLinkUnderlined
  }

  /**
   * 设置圆形图片格式链接主题背景颜色
   *
   * @param linkCircleImageBackGroupColor 圆形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkCircleImageBackGroupColor(linkCircleImageBackGroupColor: number): void {
    this.linkCircleImageBackGroupColor = linkCircleImageBackGroupColor
  }

  /**
   * 设置圆形图片格式链接控件背景颜色
   *
   * @param linkCircleImageButtonBackGroupColor 圆形图片格式链接控件背景颜色 - 默认0XFF000000
   */
  setLinkCircleImageButtonBackGroupColor(linkCircleImageButtonBackGroupColor: number): void {
    this.linkCircleImageButtonBackGroupColor = linkCircleImageButtonBackGroupColor
  }

  /**
   * 设置圆形图片格式链接文字大小
   *
   * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkCircleImageTextSize(linkCircleImageTextSize: number): void {
    this.linkCircleImageTextSize = linkCircleImageTextSize
  }

  /**
   * 设置圆形图片格式链接文字颜色
   *
   * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0XFFFFFFFF
   */
  setLinkCircleImageTextColor(linkCircleImageTextColor: number): void {
    this.linkCircleImageTextColor = linkCircleImageTextColor
  }

  /**
   * 设置圆形图片格式链接半径
   *
   * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
   */
  setLinkCircleImageRadius(linkCircleImageRadius: number): void {
    this.linkCircleImageRadius = linkCircleImageRadius
  }

  /**
   * 设置圆形图片格式链接左右外边距
   *
   * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkCircleImageMargin(linkCircleImageMargin: number): void {
    this.linkCircleImageMargin = linkCircleImageMargin
  }

  /**
   * 设置圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectImageBackGroupColor 圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkRectImageBackGroupColor(linkRectImageBackGroupColor: number): void {
    this.linkRectImageBackGroupColor = linkRectImageBackGroupColor
  }

  /**
   * 设置圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectImageButtonBackGroupColor 圆角矩形图片格式链接控件背景颜色 - 默认0XFF000000
   */
  setLinkRectImageButtonBackGroupColor(linkRectImageButtonBackGroupColor: number): void {
    this.linkRectImageButtonBackGroupColor = linkRectImageButtonBackGroupColor
  }

  /**
   * 圆角矩形图片格式链接文字大小
   *
   * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkRectImageTextSize(linkRectImageTextSize: number): void {
    this.linkRectImageTextSize = linkRectImageTextSize
  }

  /**
   * 设置圆角矩形图片格式链接文字颜色
   *
   * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0XFFFFFFFF
   */
  setLinkRectImageTextColor(linkRectImageTextColor: number): void {
    this.linkRectImageTextColor = linkRectImageTextColor
  }

  /**
   * 圆角矩形图片格式链接控件高度
   *
   * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
   */
  setLinkRectImageHeight(linkRectImageHeight: number): void {
    this.linkRectImageHeight = linkRectImageHeight
  }

  /**
   * 圆角矩形图片格式链接左右内边距
   *
   * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
   */
  setLinkRectImagePadding(linkRectImagePadding: number): void {
    this.linkRectImagePadding = linkRectImagePadding
  }

  /**
   * 圆角矩形图片格式链接圆角半径
   *
   * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
   */
  setLinkRectImageRadius(linkRectImageRadius: number): void {
    this.linkRectImageRadius = linkRectImageRadius
  }

  /**
   * 圆角矩形图片格式链接左右外边距
   *
   * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkRectImageMargin(linkRectImageMargin: number): void {
    this.linkRectImageMargin = linkRectImageMargin
  }

  /**
   * 设置空心圆角矩形图片格式链接主题背景颜色
   *
   * @param linkRectToolImageBackGroupColor 空心圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
   */
  setLinkRectToolImageBackGroupColor(linkRectToolImageBackGroupColor: number): void {
    this.linkRectToolImageBackGroupColor = linkRectToolImageBackGroupColor
  }

  /**
   * 设置空心圆角矩形图片格式链接控件背景颜色
   *
   * @param linkRectToolImageButtonBackGroupColor 空心圆角矩形图片格式链接控件背景颜色 - 默认OXFFFFFFFF
   */
  setLinkRectToolImageButtonBackGroupColor(linkRectToolImageButtonBackGroupColor: number): void {
    this.linkRectToolImageButtonBackGroupColor = linkRectToolImageButtonBackGroupColor
  }

  /**
   * 设置空心圆角矩形图片格式链接文字大小
   *
   * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
   */
  setLinkRectToolImageTextSize(linkRectToolImageTextSize: number): void {
    this.linkRectToolImageTextSize = linkRectToolImageTextSize
  }

  /**
   * 设置空心圆角矩形图片格式链接控件高度
   *
   * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
   */
  setLinkRectToolImageHeight(linkRectToolImageHeight: number): void {
    this.linkRectToolImageHeight = linkRectToolImageHeight
  }

  /**
   * 设置空心圆角矩形图片格式链接左右内边距
   *
   * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
   */
  setLinkRectToolImagePadding(linkRectToolImagePadding: number): void {
    this.linkRectToolImagePadding = linkRectToolImagePadding
  }

  /**
   * 设置空心圆角矩形图片格式链接边框宽度
   *
   * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
   */
  setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: number): void {
    this.linkRectToolImageBorderWidth = linkRectToolImageBorderWidth
  }

  /**
   * 设置空心圆角矩形图片格式链接分割线宽度
   *
   * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
   */
  setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: number): void {
    this.linkRectToolImageDividingLineWidth = linkRectToolImageDividingLineWidth
  }

  /**
   * 设置空心圆角矩形图片格式链接左右外边距
   *
   * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
   */
  setLinkRectToolImageMargin(linkRectToolImageMargin: number): void {
    this.linkRectToolImageMargin = linkRectToolImageMargin
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本左边距
   *
   * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
   */
  setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: number): void {
    this.linkRectToolImageLineLeftPadding = linkRectToolImageLineLeftPadding
  }

  /**
   * 设置空心圆角矩形图片格式分割线和文本右边距
   *
   * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
   */
  setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: number): void {
    this.linkRectToolImageLineRightPadding = linkRectToolImageLineRightPadding
  }

  /**
   * 设置块引用左边距
   *
   * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
   */
  setBlockQuoteLeftMargin(blockQuoteLeftMargin: number): void {
    this.blockQuoteLeftMargin = blockQuoteLeftMargin
  }

  /**
   * 设置块引用右边距
   *
   * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
   */
  setBlockQuoteRightMargin(blockQuoteRightMargin: number): void {
    this.blockQuoteRightMargin = blockQuoteRightMargin
  }

  /**
   * 设置块引用左边线条宽度
   *
   * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
   */
  setBlockQuoteWidth(blockQuoteWidth: number): void {
    this.blockQuoteWidth = blockQuoteWidth
  }

  /**
   * 设置块引用左边线条颜色
   *
   * @param blockQuoteColor 块引用左边线条颜色 - 默认0XFF191919
   */
  setBlockQuoteColor(blockQuoteColor: number): void {
    this.blockQuoteColor = blockQuoteColor
  }

  /**
   * 设置块引用背景颜色
   *
   * @param blockQuoteBackGroupColor 块引用背景颜色 - 默认0XFFEAEAEA
   */
  setBlockQuoteBackGroupColor(blockQuoteBackGroupColor: number): void {
    this.blockQuoteBackGroupColor = blockQuoteBackGroupColor
  }

  /**
   * 设置块引用子模块上下间距
   *
   * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
   */
  setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: number): void {
    this.blockQuoteTopAndBottomMargins = blockQuoteTopAndBottomMargins
  }

  /**
   * 设置有序列表、无序列表、任务列表子模块上下间距
   *
   * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
   */
  setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: number): void {
    this.blockOrderedAndBulletTopAndBottomMargins = blockOrderedAndBulletTopAndBottomMargins
  }

  /**
   * 设置有序列表、无序列表、任务列表左边距
   *
   * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
   */
  setBlockLeftMargin(blockLeftMargin: number): void {
    this.blockLeftMargin = blockLeftMargin
  }

  /**
   * 设置有序列表、无序列表、任务列表右边距
   *
   * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
   */
  setBlockRightMargin(blockRightMargin: number): void {
    this.blockRightMargin = blockRightMargin
  }

  /**
   * 设置有序列表前缀文本是否加粗
   *
   * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
   */
  setOrderedListItemPrefixBold(orderedListItemPrefixBold: boolean): void {
    this.orderedListItemPrefixBold = orderedListItemPrefixBold
  }

  /**
   * 设置有序列表前缀文本颜色
   *
   * @param orderedListItemColor 有序列表前缀文本颜色 - 默认OXFF191919
   */
  setOrderedListItemColor(orderedListItemColor: number): void {
    this.orderedListItemColor = orderedListItemColor
  }

  /**
   * 设置有序列表前缀文本大小
   *
   * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
   */
  setOrderedListItemSize(orderedListItemSize: number): void {
    this.orderedListItemSize = orderedListItemSize
  }

  /**
   * 设置有序列表前缀文本行高
   *
   * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
   */
  setOrderedListItemLineHeight(orderedListItemLineHeight: number): void {
    this.orderedListItemLineHeight = orderedListItemLineHeight
  }

  /**
   * 设置无序列表前缀是否全部是实心圆型
   *
   * @param orderedListItemLineHeight 无序列表前缀是否全部是实心圆型 - 默认false
   */
  setBulletListItemCircle(bulletListItemCircle: boolean): void {
    this.bulletListItemCircle = bulletListItemCircle
  }

  /**
   * 设置无序列表前缀文本颜色
   *
   * @param bulletListItemColor 无序列表前缀文本颜色 - 默认OXFF191919
   */
  setBulletListItemColor(bulletListItemColor: number): void {
    this.bulletListItemColor = bulletListItemColor
  }

  /**
   * 设置无序列表前缀文本大小
   *
   * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
   */
  setBulletListItemSize(bulletListItemSize: number): void {
    this.bulletListItemSize = bulletListItemSize
  }

  /**
   * 设置无序列表前缀文本行高
   *
   * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
   */
  setBulletListItemLineHeight(bulletListItemLineHeight: number): void {
    this.bulletListItemLineHeight = bulletListItemLineHeight
  }

  /**
   * 设置任务列表选择框宽高
   *
   * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
   */
  setTaskListItemLength(taskListItemLength: number): void {
    this.taskListItemLength = taskListItemLength
  }

  /**
   * 设置是否格式化代码块内容
   *
   * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块内容；false：不格式化代码块内容。默认false
   */
  setIsCodeFormat(isCodeFormat: boolean): void {
    this.isCodeFormat = isCodeFormat
  }

  /**
   * 设置内联代码文本颜色
   *
   * @param codeTextColor 内联代码文本颜色 - 默认OXFF000000
   */
  setCodeTextColor(codeTextColor: number): void {
    this.codeTextColor = codeTextColor
  }

  /**
   * 设置内联代码背景颜色
   *
   * @param codeBackgroundColor 内联代码背景颜色 - 默认OXFFEAEAEA
   */
  setCodeBackgroundColor(codeBackgroundColor: number): void {
    this.codeBackgroundColor = codeBackgroundColor
  }

  /**
   * 设置内联代码文本大小
   *
   * @param codeTextSize 内联代码文本大小 - 默认13.0fp
   */
  setCodeTextSize(codeTextSize: number): void {
    this.codeTextSize = codeTextSize
  }

  /**
   * 设置内联代码文本字体
   *
   * @param codeTypeface 内联代码文本字体 - 默认"HarmonyOS Sans"
   */
  setCodeTypeface(codeTypeface: string): void {
    this.codeTypeface = codeTypeface
  }

  /**
   * 设置围栏代码块代码高亮是否同步解析
   *
   * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
   */
  setIsCodeBlockParserSync(isCodeBlockParserSync: boolean): void {
    this.isCodeBlockParserSync = isCodeBlockParserSync
  }

  /**
   * 设置代码块代码文本颜色
   *
   * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
   */
  setCodeBlockTextColor(codeBlockTextColor: number): void {
    this.codeBlockTextColor = codeBlockTextColor
  }

  /**
   * 设置代码块代码类型文本颜色
   *
   * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
   */
  setCodeBlockTypeTextColor(codeBlockTypeTextColor: number): void {
    this.codeBlockTypeTextColor = codeBlockTypeTextColor
  }

  /**
   * 设置代码块代码类型文本
   *
   * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
   */
  setCodeBlockTypeTextStr(codeBlockTypeTextStr: string): void {
    this.codeBlockTypeTextStr = codeBlockTypeTextStr
  }

  /**
   * 设置代码类型和代码块距离
   *
   * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
   */
  setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: number): void {
    this.codeBlockTypeTextPadding = codeBlockTypeTextPadding
  }

  /**
   * 设置代码块复制、全屏图片文字是否显示
   *
   * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
   */
  setCodeBlockIconTextHide(codeBlockIconTextHide: boolean): void {
    this.codeBlockIconTextHide = codeBlockIconTextHide
  }

  /**
   * 设置代码块代码行号是否显示
   *
   * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
   */
  setCodeBlockLineNumberHide(codeBlockLineNumberHide: boolean): void {
    this.codeBlockLineNumberHide = codeBlockLineNumberHide
  }

  /**
   * 设置代码块背景颜色
   *
   * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
   */
  setCodeBlockBackgroundColor(codeBlockBackgroundColor: number): void {
    this.codeBlockBackgroundColor = codeBlockBackgroundColor
  }

  /**
   * 设置代码块左边距
   *
   * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
   */
  setCodeMultilineMargin(codeMultilineMargin: number): void {
    this.codeMultilineMargin = codeMultilineMargin
  }

  /**
   * 设置代码块字体
   *
   * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
   */
  setCodeBlockTypeface(codeBlockTypeface: string): void {
    this.codeBlockTypeface = codeBlockTypeface
  }

  /**
   * 设置代码块代码文本大小
   *
   * @param codeBlockTextSize 代码块代码文本大小 -  默认13.0fp
   */
  setCodeBlockTextSize(codeBlockTextSize: number): void {
    this.codeBlockTextSize = codeBlockTextSize
  }

  /**
   * 设置代码块代码文本行高
   *
   * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
   */
  setCodeBlockLineHeight(codeBlockLineHeight: number): void {
    this.codeBlockLineHeight = codeBlockLineHeight
  }

  /**
   * 设置代码块控件圆角大小
   *
   * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
   */
  setCodeBlockRadius(codeBlockRadius: number): void {
    this.codeBlockRadius = codeBlockRadius
  }

  /**
   * 设置代码块代码全屏按钮是否显示
   *
   * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
   */
  setIsCodeFullScreen(isCodeFullScreen: boolean): void {
    this.isCodeFullScreen = isCodeFullScreen
  }

  /**
   * 设置代码块代码全屏、代码复制按钮宽高
   *
   * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
   */
  setIconWidthAndHeight(iconWidthAndHeight: number): void {
    this.iconWidthAndHeight = iconWidthAndHeight
  }

  /**
   * 设置组合代码未选中标题字体大小
   *
   * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
   */
  setCodeListTitleTextSize(codeListTitleTextSize: number): void {
    this.codeListTitleTextSize = codeListTitleTextSize
  }

  /**
   * 设置组合代码选中标题字体大小
   *
   * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
   */
  setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: number): void {
    this.codeListTitleSelectTextSize = codeListTitleSelectTextSize
  }

  /**
   * 设置组合代码选中标题文本颜色
   *
   * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认Color.RED
   */
  setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: number): void {
    this.codeListTitleSelectTextColor = codeListTitleSelectTextColor
  }

  /**
   * 设置组合代码未选中标题文本颜色
   *
   * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认Color.BLACK
   */
  setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: number): void {
    this.codeListTitleUnSelectTextColor = codeListTitleUnSelectTextColor
  }

  /**
   * 设置组合代码选中标题背景颜色
   *
   * @param codeListTitleSelectBackGroupColor 组合代码选中标题背景颜色 - 默认Color.GRAY
   */
  setCodeListTitleSelectBackGroupColor(codeListTitleSelectBackGroupColor: number): void {
    this.codeListTitleSelectBackGroupColor = codeListTitleSelectBackGroupColor
  }

  /**
   * 设置组合代码未选中标题背景颜色
   *
   * @param codeListTitleUnSelectBackGroupColor 组合代码未选中标题背景颜色 - 默认Color.TRANSPARENT
   */
  setCodeListTitleUnSelectBackGroupColor(codeListTitleUnSelectBackGroupColor: number): void {
    this.codeListTitleUnSelectBackGroupColor = codeListTitleUnSelectBackGroupColor
  }

  /**
   * 设置是否单独代码块显示
   *
   * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
   */
  setIsSeparateCodeBlock(isSeparateCodeBlock: boolean): void {
    this.isSeparateCodeBlock = isSeparateCodeBlock
  }

  /**
   * 设置单独代码块行号宽度
   *
   * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
   */
  setSeparateCodeBlockWidth(separateCodeBlockWidth: number): void {
    this.separateCodeBlockWidth = separateCodeBlockWidth
  }

  /**
   * 设置单独代码块是否居底显示
   *
   * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
   */
  setSeparateCodeIsBottom(separateCodeIsBottom: boolean): void {
    this.separateCodeIsBottom = separateCodeIsBottom
  }

  /**
   * 设置H1、H2标题下分割线高度
   *
   * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
   */
  setHeadingBreakHeight(headingBreakHeight: number): void {
    this.headingBreakHeight = headingBreakHeight
  }

  /**
   * 设置标题文本字体
   *
   * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
   */
  setHeadingTypeface(headingTypeface: string): void {
    this.headingTypeface = headingTypeface
  }

  /**
   * 设置标题模块上间距
   *
   * @param headingTopMargins 标题模块上间距 - 默认8.0
   */
  setHeadingTopMargins(headingTopMargins: number): void {
    this.headingTopMargins = headingTopMargins
  }

  /**
   * 设置标题模块下间距
   *
   * @param headingBottomMargins 标题模块下间距 - 默认8.0
   */
  setHeadingBottomMargins(headingBottomMargins: number): void {
    this.headingBottomMargins = headingBottomMargins
  }

  /**
   * 设置一级标题文本大小
   *
   * @param headingTextSize1 一级标题文本大小 - 默认20.0
   */
  setHeadingTextSize1(headingTextSize1: number): void {
    this.headingTextSize1 = headingTextSize1
  }

  /**
   * 设置二级标题文本大小
   *
   * @param headingTextSize2 二级标题文本大小 - 默认17.0
   */
  setHeadingTextSize2(headingTextSize2: number): void {
    this.headingTextSize2 = headingTextSize2
  }

  /**
   * 设置三级标题文本大小
   *
   * @param headingTextSize3 三级标题文本大小 - 默认16.0
   */
  setHeadingTextSize3(headingTextSize3: number): void {
    this.headingTextSize3 = headingTextSize3
  }

  /**
   * 设置四级标题文本大小
   *
   * @param headingTextSize4 四级标题文本大小 - 默认15.0
   */
  setHeadingTextSize4(headingTextSize4: number): void {
    this.headingTextSize4 = headingTextSize4
  }

  /**
   * 设置五级标题文本大小
   *
   * @param headingTextSize5 五级标题文本大小 - 默认15.0
   */
  setHeadingTextSize5(headingTextSize5: number): void {
    this.headingTextSize5 = headingTextSize5
  }

  /**
   * 设置六级标题文本大小
   *
   * @param headingTextSize6 六级标题文本大小 - 默认13.0
   */
  setHeadingTextSize6(headingTextSize6: number): void {
    this.headingTextSize6 = headingTextSize6
  }

  /**
   * 设置标题文本字间距
   *
   * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
   */
  setHeadingTextWordSpace(headingTextWordSpace: number): void {
    this.headingTextWordSpace = headingTextWordSpace
  }

  /**
   * 设置一级标题文本行高
   *
   * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight1(headingTextLineHeight1: number): void {
    this.headingTextLineHeight1 = headingTextLineHeight1
  }

  /**
   * 设置二级标题文本行高
   *
   * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight2(headingTextLineHeight2: number): void {
    this.headingTextLineHeight2 = headingTextLineHeight2
  }

  /**
   * 设置三级标题文本行高
   *
   * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight3(headingTextLineHeight3: number): void {
    this.headingTextLineHeight3 = headingTextLineHeight3
  }

  /**
   * 设置四级标题文本行高
   *
   * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight4(headingTextLineHeight4: number): void {
    this.headingTextLineHeight4 = headingTextLineHeight4
  }

  /**
   * 设置五级标题文本行高
   *
   * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight5(headingTextLineHeight5: number): void {
    this.headingTextLineHeight5 = headingTextLineHeight5
  }

  /**
   * 设置六级标题文本行高
   *
   * @param headingTextLineHeight6 六级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight6(headingTextLineHeight6: number): void {
    this.headingTextLineHeight6 = headingTextLineHeight6
  }

  /**
   * 设置一级标题文本颜色
   *
   * @param headingTextColor1 标题文本颜色
   */
  setHeadingTextColor1(headingTextColor1: number): void {
    this.headingTextColor1 = headingTextColor1
  }

  /**
   * 设置H1标题下分割线颜色
   *
   * @param headingBreakColor1 H1标题下分割线颜色 - 默认0XFF191919
   */
  setHeadingBreakColor1(headingBreakColor1: number): void {
    this.headingBreakColor1 = headingBreakColor1
  }

  /**
   * 设置二级标题文本颜色
   *
   * @param headingTextColor2 标题文本颜色
   */
  setHeadingTextColor2(headingTextColor2: number): void {
    this.headingTextColor2 = headingTextColor2
  }

  /**
   * 设置H2标题下分割线颜色
   *
   * @param headingBreakColor2 H2标题下分割线颜色 - 默认0XFF191919
   */
  setHeadingBreakColor2(headingBreakColor2: number): void {
    this.headingBreakColor2 = headingBreakColor2
  }

  /**
   * 设置三级标题文本颜色
   *
   * @param headingTextColor3 标题文本颜色
   */
  setHeadingTextColor3(headingTextColor3: number): void {
    this.headingTextColor3 = headingTextColor3
  }

  /**
   * 设置四级标题文本颜色
   *
   * @param headingTextColor4 标题文本颜色
   */
  setHeadingTextColor4(headingTextColor4: number): void {
    this.headingTextColor4 = headingTextColor4
  }

  /**
   * 设置五级标题文本颜色
   *
   * @param headingTextColor5 标题文本颜色
   */
  setHeadingTextColor5(headingTextColor5: number): void {
    this.headingTextColor5 = headingTextColor5
  }

  /**
   * 设置六级标题文本颜色
   *
   * @param headingTextColor6 标题文本颜色
   */
  setHeadingTextColor6(headingTextColor6: number): void {
    this.headingTextColor6 = headingTextColor6
  }

  /**
   * 设置段落模块上间距
   *
   * @param paragraphTopMargins 段落模块上间距 - 默认8.0vp
   */
  setParagraphTopMargins(paragraphTopMargins: number): void {
    this.paragraphTopMargins = paragraphTopMargins
  }

  /**
   * 设置段落模块下间距
   *
   * @param paragraphBottomMargins 段落模块下间距 - 默认8.0vp
   */
  setParagraphBottomMargins(paragraphBottomMargins: number): void {
    this.paragraphBottomMargins = paragraphBottomMargins
  }

  /**
   * 设置段落文本大小
   *
   * @param paragraphTextSize 段落文本大小 - 默认14.0fp
   */
  setParagraphTextSize(paragraphTextSize: number): void {
    this.paragraphTextSize = paragraphTextSize
  }

  /**
   * 设置段落文本颜色
   *
   * @param paragraphTextColor 段落文本颜色 - 默认0XFF191919
   */
  setParagraphTextColor(paragraphTextColor: number): void {
    this.paragraphTextColor = paragraphTextColor
  }

  /**
   * 设置段落文本字间距
   *
   * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
   */
  setParagraphTextWordSpace(paragraphTextWordSpace: number): void {
    this.paragraphTextWordSpace = paragraphTextWordSpace
  }

  /**
   * 设置段落文本行高
   *
   * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
   */
  setParagraphTextLineHeight(paragraphTextLineHeight: number): void {
    this.paragraphTextLineHeight = paragraphTextLineHeight
  }

  /**
   * 设置段落文本字体
   *
   * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
   */
  setParagraphTypeface(paragraphTypeface: string): void {
    this.paragraphTypeface = paragraphTypeface
  }

  /**
   * 设置分割线颜色
   *
   * @param thematicBreakColor 分割线颜色 - 默认0XFF191919
   */
  setThematicBreakColor(thematicBreakColor: number): void {
    this.thematicBreakColor = thematicBreakColor
  }

  /**
   * 设置分割线高度
   *
   * @param thematicBreakHeight 分割线高度 - 默认0.5vp
   */
  setThematicBreakHeight(thematicBreakHeight: number): void {
    this.thematicBreakHeight = thematicBreakHeight
  }

  /**
   * 设置分割线上部外边距
   *
   * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
   */
  setThematicBreakTopMargin(thematicBreakTopMargin: number): void {
    this.thematicBreakTopMargin = thematicBreakTopMargin
  }

  /**
   * 设置分割线下部外边距
   *
   * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
   */
  setThematicBreakBottomMargin(thematicBreakBottomMargin: number): void {
    this.thematicBreakBottomMargin = thematicBreakBottomMargin
  }

  /**
   * 设置软换行是否换行
   *
   * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
   */
  setIsLineBreak(isLineBreak: boolean): void {
    this.isLineBreak = isLineBreak
  }

  /**
   * 设置数学公式未加载状态是否显示文字
   *
   * @param latexDefaultText 数学公式未加载状态是否显示文字 - 默认true
   */
  setLatexDefaultText(latexDefaultText: boolean): void {
    this.latexDefaultText = latexDefaultText
  }

  /**
   * 设置数学公式文本大小
   *
   * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
   */
  setLatexMathTextSize(latexMathTextSize: number): void {
    this.latexMathTextSize = latexMathTextSize
  }

  /**
   * 设置数学公式背景色
   *
   * @param latexMathBackGroupColor 数学公式背景色 - 默认Color.TRANSPARENT
   */
  setLatexMathBackGroupColor(latexMathBackGroupColor: number): void {
    this.latexMathBackGroupColor = latexMathBackGroupColor
  }

  /**
   * 设置数学公式文本颜色
   *
   * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
   */
  setLatexMathTextColor(latexMathTextColor: number): void {
    this.latexMathTextColor = latexMathTextColor
  }

  /**
   * 设置数学公式生成图片格式
   *
   * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
   */
  setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): void {
    this.latexMathColorFormat = latexMathColorFormat
  }

  /**
   * 设置块结构的数学公式是否居中
   *
   * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认false
   */
  setLatexMathBlockCenter(latexMathBlockCenter: boolean): void {
    this.latexMathBlockCenter = latexMathBlockCenter
  }

  /**
   * 设置数学公式字体路径
   *
   * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
   */
  setLatexMathResStr(latexMathResStr: string): void {
    this.latexMathResStr = latexMathResStr
  }

  /**
   * 设置音频阴影颜色值
   *
   * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
   */
  setAudioShadowColor(audioShadowColor: number): void {
    this.audioShadowColor = audioShadowColor
  }

  /**
   * 设置音频边框颜色
   *
   * @param audioBorderColor 音频边框颜色 - 默认0x33000000
   */
  setAudioBorderColor(audioBorderColor: number): void {
    this.audioBorderColor = audioBorderColor
  }

  /**
   * 设置音频边框粗细
   *
   * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
   */
  setAudioBorderWidth(audioBorderWidth: number): void {
    this.audioBorderWidth = audioBorderWidth
  }

  /**
   * 设置音频边框圆角
   *
   * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
   */
  setAudioBorderRadius(audioBorderRadius: number): void {
    this.audioBorderRadius = audioBorderRadius
  }

  /**
   * 设置音频按钮背景颜色
   *
   * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认Color.BLACK
   */
  setAudioButtonBackgroundColor(audioButtonBackgroundColor: number): void {
    this.audioButtonBackgroundColor = audioButtonBackgroundColor
  }

  /**
   * 设置音频按钮文字颜色
   *
   * @param audioButtonTextColor 音频按钮文字颜色 - 默认Color.WHITE
   */
  setAudioButtonTextColor(audioButtonTextColor: number): void {
    this.audioButtonTextColor = audioButtonTextColor
  }

  /**
   * 设置音频按钮文字大小
   *
   * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
   */
  setAudioButtonTextSize(audioButtonTextSize: number): void {
    this.audioButtonTextSize = audioButtonTextSize
  }

  /**
   * 设置音频按钮文字内容
   *
   * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
   */
  setAudioButtonText(audioButtonText: string): void {
    this.audioButtonText = audioButtonText
  }

  /**
   * 设置音频按钮圆角
   *
   * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
   */
  setAudioButtonBorderRadius(audioButtonBorderRadius: number): void {
    this.audioButtonBorderRadius = audioButtonBorderRadius
  }

  /**
   * 设置音频标题文字大小
   *
   * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
   */
  setAudioTitleTextSize(audioTitleTextSize: number): void {
    this.audioTitleTextSize = audioTitleTextSize
  }

  /**
   * 设置音频标题文字颜色
   *
   * @param audioTitleTextColor音频标题文字颜色 - 默认Color.BLACK
   */
  setAudioTitleTextColor(audioTitleTextColor: number): void {
    this.audioTitleTextColor = audioTitleTextColor
  }

  /**
   * 设置音频标题文字行高
   *
   * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
   */
  setAudioTitleTextLineHeight(audioTitleTextLineHeight: number): void {
    this.audioTitleTextLineHeight = audioTitleTextLineHeight
  }

  /**
   * 设置音频类型文字大小
   *
   * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
   */
  setAudioTypeTextSize(audioTypeTextSize: number): void {
    this.audioTypeTextSize = audioTypeTextSize
  }

  /**
   * 设置音频类型文字颜色
   *
   * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
   */
  setAudioTypeTextColor(audioTypeTextColor: number): void {
    this.audioTypeTextColor = audioTypeTextColor
  }

  /**
   * 设置音频类型文字行高
   *
   * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
   */
  setAudioTypeTextLineHeight(audioTypeTextLineHeight: number): void {
    this.audioTypeTextLineHeight = audioTypeTextLineHeight
  }

  /**
   * 设置音频上边距
   *
   * @param audioMarginTop 音频上边距 - 默认10.0vp
   */
  setAudioMarginTop(audioMarginTop: number): void {
    this.audioMarginTop = audioMarginTop
  }

  /**
   * 设置音频下边距
   *
   * @param audioMarginBottom 音频下边距 - 默认10.0vp
   */
  setAudioMarginBottom(audioMarginBottom: number): void {
    this.audioMarginBottom = audioMarginBottom
  }

  /**
   * 设置视频圆角
   *
   * @param videoBorderRadius 视频圆角 - 默认10.0vp
   */
  setVideoBorderRadius(videoBorderRadius: number): void {
    this.videoBorderRadius = videoBorderRadius
  }

  /**
   * 设置视频时间文本颜色
   *
   * @param videoTimeTextColor 视频时间文本颜色 - 默认Color.WHITE
   */
  setVideoTimeTextColor(videoTimeTextColor: number): void {
    this.videoTimeTextColor = videoTimeTextColor
  }

  /**
   * 设置视频时间文本大小
   *
   * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
   */
  setVideoTimeTextSize(videoTimeTextSize: number): void {
    this.videoTimeTextSize = videoTimeTextSize
  }

  /**
   * 设置视频时间文本居右边距
   *
   * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
   */
  setVideoTimeTextMarginRight(videoTimeTextMarginRight: number): void {
    this.videoTimeTextMarginRight = videoTimeTextMarginRight
  }

  /**
   * 设置视频时间文本居底边距
   *
   * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
   */
  setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: number): void {
    this.videoTimeTextMarginBottom = videoTimeTextMarginBottom
  }

  /**
   * 设置视频上边距
   *
   * @param videoMarginTop 视频上边距 - 默认10.0vp
   */
  setVideoMarginTop(videoMarginTop: number): void {
    this.videoMarginTop = videoMarginTop
  }

  /**
   * 设置视频下边距
   *
   * @param videoMarginBottom 视频下边距 - 默认10.0vp
   */
  setVideoMarginBottom(videoMarginBottom: number): void {
    this.videoMarginBottom = videoMarginBottom
  }

  /**
   * 设置视频发布/下载按钮布局是否显示
   *
   * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默认false不显示
   */
  setIsVideoBottomLayout(isVideoBottomLayout: boolean): void {
    this.isVideoBottomLayout = isVideoBottomLayout
  }

  /**
   * 设置视频发布按钮图片宽度和高度
   *
   * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
   */
  setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: number): void {
    this.videoReleaseImageWidthHeight = videoReleaseImageWidthHeight
  }

  /**
   * 设置视频发布按钮宽度
   *
   * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
   */
  setVideoReleaseWidth(videoReleaseWidth: number): void {
    this.videoReleaseWidth = videoReleaseWidth
  }

  /**
   * 设置视频发布按钮高度
   *
   * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
   */
  setVideoReleaseHeight(videoReleaseHeight: number): void {
    this.videoReleaseHeight = videoReleaseHeight
  }

  /**
   * 设置视频发布按钮圆角
   *
   * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
   */
  setVideoReleaseRadius(videoReleaseRadius: number): void {
    this.videoReleaseRadius = videoReleaseRadius
  }

  /**
   * 设置视频发布按钮文本内容
   *
   * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
   */
  setVideoReleaseText(videoReleaseText: string): void {
    this.videoReleaseText = videoReleaseText
  }

  /**
   * 设置视频发布按钮文本大小
   *
   * @param videoReleaseTexSize 视频发布按钮文本大小 - 默认16.0vp
   */
  setVideoReleaseTexSize(videoReleaseTexSize: number): void {
    this.videoReleaseTexSize = videoReleaseTexSize
  }

  /**
   * 设置视频发布按钮文本颜色
   *
   * @param videoReleaseTexColor 视频发布按钮文本颜色 - 默认0xE6000000
   */
  setVideoReleaseTexColor(videoReleaseTexColor: number): void {
    this.videoReleaseTexColor = videoReleaseTexColor
  }

  /**
   * 设置视频发布按钮背景颜色
   *
   * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
   */
  setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: number): void {
    this.videoReleaseBackgroundColor = videoReleaseBackgroundColor
  }

  /**
   * 设置视频下载按钮图片宽度和高度
   *
   * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
   */
  setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: number): void {
    this.videoDownloadImageWidthHeight = videoDownloadImageWidthHeight
  }

  /**
   * 设置视频下载按钮宽度
   *
   * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
   */
  setVideoDownloadWidth(videoDownloadWidth: number): void {
    this.videoDownloadWidth = videoDownloadWidth
  }

  /**
   * 设置视频下载按钮高度
   *
   * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
   */
  setVideoDownloadHeight(videoDownloadHeight: number): void {
    this.videoDownloadHeight = videoDownloadHeight
  }

  /**
   * 设置视频下载按钮圆角
   *
   * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
   */
  setVideoDownloadRadius(videoDownloadRadius: number): void {
    this.videoDownloadRadius = videoDownloadRadius
  }

  /**
   * 设置视频下载按钮文本内容
   *
   * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
   */
  setVideoDownloadText(videoDownloadText: string): void {
    this.videoDownloadText = videoDownloadText
  }

  /**
   * 设置视频下载按钮文本大小
   *
   * @param videoDownloadTexSize 视频下载按钮文本大小 - 默认16.0vp
   */
  setVideoDownloadTexSize(videoDownloadTexSize: number): void {
    this.videoDownloadTexSize = videoDownloadTexSize
  }

  /**
   * 设置视频下载按钮文本颜色
   *
   * @param videoDownloadTexColor 视频下载按钮文本颜色 - 默认0xE6000000
   */
  setVideoDownloadTexColor(videoDownloadTexColor: number): void {
    this.videoDownloadTexColor = videoDownloadTexColor
  }

  /**
   * 设置视频下载按钮背景颜色
   *
   * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
   */
  setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: number): void {
    this.videoDownloadBackgroundColor = videoDownloadBackgroundColor
  }

  /**
   * 设置图片缩放类型
   *
   * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
   */
  setImageFitType(imageFitType: ImageFitType): void {
    this.imageFitType = imageFitType
  }

  /**
   * 设置图片基于自身宽度缩放百分比
   *
   * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
   */
  setImageMaximumWidth(imageMaximumWidth: number): void {
    this.imageMaximumWidth = imageMaximumWidth
  }

  /**
   * 设置图片基于父布局宽度缩放百分比
   *
   * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
   */
  setImageFixedRatioWidth(imageFixedRatioWidth: number): void {
    this.imageFixedRatioWidth = imageFixedRatioWidth
  }

  /**
   * 设置图片最大高度
   *
   * @param imageMaxHeight 图片最大高度 - 默认None
   */
  setImageMaxHeight(imageMaxHeight: number): void {
    this.imageMaxHeight = imageMaxHeight
  }

  /**
   * 设置图片最大宽度
   *
   * @param imageMaxWidth 图片最大宽度 - 默认None
   */
  setImageMaxWidth(imageMaxWidth: number): void {
    this.imageMaxWidth = imageMaxWidth
  }

  /**
   * 设置图片圆角大小
   *
   * @param imageBorderRadius 图片圆角大小 - 默认0.0vp
   */
  setImageBorderRadius(imageBorderRadius: number): void {
    this.imageBorderRadius = imageBorderRadius
  }

  /**
   * 设置图片边框宽度
   *
   * @param imageBorderWidth 图片边框宽度 - 默认0.0vp
   */
  setImageBorderWidth(imageBorderWidth: number): void {
    this.imageBorderWidth = imageBorderWidth
  }

  /**
   * 设置图片边框颜色
   *
   * @param imageBorderColor 图片边框颜色 - 默认Color.BLACK
   */
  setImageBorderColor(imageBorderColor: number): void {
    this.imageBorderColor = imageBorderColor
  }

  /**
   * 设置网络图片是否压缩
   *
   * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
   */
  setIsAutoResize(isAutoResize: boolean): void {
    this.isAutoResize = isAutoResize
  }

  /**
   * 设置图片上边距
   *
   * @param imageMarginTop 图片上边距 - 默认10.0vp
   */
  setImageMarginTop(imageMarginTop: number): void {
    this.imageMarginTop = imageMarginTop
  }

  /**
   * 设置图片下边距
   *
   * @param imageMarginBottom 图片下边距 - 默认10.0vp
   */
  setImageMarginBottom(imageMarginBottom: number): void {
    this.imageMarginBottom = imageMarginBottom
  }

  /**
   * 设置图片是否有下载按钮
   *
   * @param isImageDownload 图片是否有下载按钮 - 默认false
   */
  setIsImageDownload(isImageDownload: boolean): void {
    this.isImageDownload = isImageDownload
  }

  /**
   * 设置是否图文混排
   *
   * @param isImageMixedLayout 是否图文混排 - 默认true
   */
  setIsImageMixedLayout(isImageMixedLayout: boolean): void {
    this.isImageMixedLayout = isImageMixedLayout
  }

  /**
   * 设置图片下载按钮图片宽度和高度
   *
   * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
   */
  setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: number): void {
    this.imageDownloadImageWidthHeight = imageDownloadImageWidthHeight
  }

  /**
   * 设置图片下载按钮宽度
   *
   * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
   */
  setImageDownloadWidth(imageDownloadWidth: number): void {
    this.imageDownloadWidth = imageDownloadWidth
  }

  /**
   * 设置图片下载按钮高度
   *
   * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
   */
  setImageDownloadHeight(imageDownloadHeight: number): void {
    this.imageDownloadHeight = imageDownloadHeight
  }

  /**
   * 设置图片下载按钮圆角
   *
   * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
   */
  setImageDownloadRadius(imageDownloadRadius: number): void {
    this.imageDownloadRadius = imageDownloadRadius
  }

  /**
   * 设置图片下载按钮文本内容
   *
   * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
   */
  setImageDownloadText(imageDownloadText: string): void {
    this.imageDownloadText = imageDownloadText
  }

  /**
   * 设置图片下载按钮文本大小
   *
   * @param imageDownloadTexSize 图片下载按钮文本大小 - 默认16.0
   */
  setImageDownloadTexSize(imageDownloadTexSize: number): void {
    this.imageDownloadTexSize = imageDownloadTexSize
  }

  /**
   * 设置图片下载按钮文本颜色
   *
   * @param imageDownloadTexColor 图片下载按钮文本颜色 - 默认0XE6000000
   */
  setImageDownloadTexColor(imageDownloadTexColor: number): void {
    this.imageDownloadTexColor = imageDownloadTexColor
  }

  /**
   * 设置图片下载按钮背景颜色
   *
   * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0XFFF5F5F5
   */
  setImageDownloadBackgroundColor(imageDownloadBackgroundColor: number): void {
    this.imageDownloadBackgroundColor = imageDownloadBackgroundColor
  }

  /**
   * 设置表格内容内边距
   *
   * @param tableCellPadding 表格内容内边距 - 默认4.0vp
   */
  setTableCellPadding(tableCellPadding: number): void {
    this.tableCellPadding = tableCellPadding
  }

  /**
   * 设置表格边框颜色
   *
   * @param tableBorderColor 表格边框颜色 - 默认0XFF000000
   */
  setTableBorderColor(tableBorderColor: number): void {
    this.tableBorderColor = tableBorderColor
  }

  /**
   * 设置表格边框宽度
   *
   * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
   */
  setTableBorderWidth(tableBorderWidth: number): void {
    this.tableBorderWidth = tableBorderWidth
  }

  /**
   * 设置表格奇数行背景色
   *
   * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0XFFFFFFFF
   */
  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): void {
    this.tableOddRowBackgroundColor = tableOddRowBackgroundColor
  }

  /**
   * 设置表格偶数行背景色
   *
   * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0XFFE0E0E0
   */
  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): void {
    this.tableEvenRowBackgroundColor = tableEvenRowBackgroundColor
  }

  /**
   * 设置表格头背景色
   *
   * @param tableHeaderRowBackgroundColor 表格头背景色 - 默认0XFFFFFFFF
   */
  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): void {
    this.tableHeaderRowBackgroundColor = tableHeaderRowBackgroundColor
  }

  /**
   * 设置表格头文本颜色
   *
   * @param tableTitleTextColor 表格头文本颜色 - 默认0XFF191919
   */
  setTableTitleTextColor(tableTitleTextColor: number): void {
    this.tableTitleTextColor = tableTitleTextColor
  }

  /**
   * 设置表格头文本大小
   *
   * @param tableTitleTextSize 表格头文本大小 - 默认14.0vp
   */
  setTableTitleTextSize(tableTitleTextSize: number): void {
    this.tableTitleTextSize = tableTitleTextSize
  }

  /**
   * 设置表格头文本行高
   *
   * @param tableTitleLineHeight 表格头文本行高 - 默认22.0vp
   */
  setTableTitleLineHeight(tableTitleLineHeight: number): void {
    this.tableTitleLineHeight = tableTitleLineHeight
  }

  /**
   * 设置表格内容文本颜色
   *
   * @param tableContentTextColor 表格内容文本颜色 - 默认0XFF191919
   */
  setTableContentTextColor(tableContentTextColor: number): void {
    this.tableContentTextColor = tableContentTextColor
  }

  /**
   * 设置表格内容文本大小
   *
   * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
   */
  setTableContentTextSize(tableContentTextSize: number): void {
    this.tableContentTextSize = tableContentTextSize
  }

  /**
   * 设置表格文本行高
   *
   * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
   */
  setTableTextLineHeight(tableTextLineHeight: number): void {
    this.tableTextLineHeight = tableTextLineHeight
  }

  /**
   * 设置表格圆角
   *
   * @param tableRadius 表格圆角 - 默认5.0vp
   */
  setTableRadius(tableRadius: number): void {
    this.tableRadius = tableRadius
  }

  /**
   * 设置表格最小宽度
   *
   * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
   */
  setTableMinTextWidth(tableMinTextWidth: number): void {
    this.tableMinTextWidth = tableMinTextWidth
  }

  /**
   * 设置表格最大宽度
   *
   * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
   */
  setTableMaxTextWidth(tableMaxTextWidth: number): void {
    this.tableMaxTextWidth = tableMaxTextWidth
  }

  /**
   * 设置表格第一列是否加粗
   *
   * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
   */
  setTableFirstColumnBold(tableFirstColumnBold: boolean): void {
    this.tableFirstColumnBold = tableFirstColumnBold
  }

  /**
   * 设置表格是否显示滚动条
   *
   * @param tableScrollBarShow 表格是否显示滚动条 - true：显示；false：不显示。默认false
   */
  setTableScrollBarShow(tableScrollBarShow: boolean): void {
    this.tableScrollBarShow = tableScrollBarShow
  }

  /**
   * 设置表格滚动条颜色
   *
   * @param tableScrollBarColor 表格滚动条颜色
   */
  setTableScrollBarColor(tableScrollBarColor: number): void {
    this.tableScrollBarColor = tableScrollBarColor
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
    this.strikethroughColor = strikethroughColor
  }

  /**
   * 设置定义列表术语和定义行之间间距
   *
   * @param descListTermAndDefMargins 定义列表定义行缩进 默认8.0
   */
  setDescListTermAndDefMargins(descListTermAndDefMargins: number): void {
    this.descListTermAndDefMargins = descListTermAndDefMargins
  }

  /**
   * 设置定义列表定义行缩进
   *
   * @param descListDefIndentation 定义列表定义行缩进 默认8.0
   */
  setDescListDefIndentation(descListDefIndentation: number): void {
    this.descListDefIndentation = descListDefIndentation
  }

  /**
   * 设置定义列表定义行间距
   *
   * @param descListDefMargins 定义列表定义行间距 默认8.0
   */
  setDescListDefMargins(descListDefMargins: number): void {
    this.descListDefMargins = descListDefMargins
  }

  /**
   * 设置下标字体颜色
   *
   * @param subTextColor 下标字体颜色 默认0XFF191919
   */
  setSubTextColor(subTextColor: number): void {
    this.subTextColor = subTextColor
  }

  /**
   * 设置下标字体大小
   *
   * @param subTextSize 下标字体大小 默认8.0
   */
  setSubTextSize(subTextSize: number): void {
    this.subTextSize = subTextSize
  }

  /**
   * 设置下标偏移距离
   *
   * @param subOffsetDist 下标偏移距离 默认0.0
   */
  setSubOffsetDist(subOffsetDist: number): void {
    this.subOffsetDist = subOffsetDist
  }

  /**
   * 设置上标字体颜色
   *
   * @param supTextColor 上标字体颜色 默认0XFF191919
   */
  setSupTextColor(supTextColor: number): void {
    this.supTextColor = supTextColor
  }

  /**
   * 设置上标字体大小
   *
   * @param supTextSize 上标字体大小 默认8.0
   */
  setSupTextSize(supTextSize: number): void {
    this.supTextSize = supTextSize
  }

  /**
   * 设置上标偏移距离
   *
   * @param supOffsetDist 上标偏移距离 默认6.0
   */
  setSupOffsetDist(supOffsetDist: number): void {
    this.supOffsetDist = supOffsetDist
  }

  /**
   * 设置下划线颜色
   *
   * @param underlineColor 下划线颜色 默认0XFF191919
   */
  setUnderlineColor(underlineColor: number): void {
    this.underlineColor = underlineColor
  }

  /**
   * 设置下划线样式
   *
   * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
   */
  setUnderlineStyle(underlineStyle: TextDecorationStyle): void {
    console.error("--------------> underlineStyle:" + underlineStyle)
    this.underlineStyle = underlineStyle
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
 * Markdown插件配置
 */
export class MarkdownPlugin {
  /**
   * 是否加载音频解析插件
   */
  isBlockAudioPlugin: boolean = false
  /**
   * 是否加载视频解析插件
   */
  isBlockVideoPlugin: boolean = false
  /**
   * 是否加载代码列表解析插件
   */
  isCodeListPlugin: boolean = false
  /**
   * 是否加载脚注解析插件
   */
  isFootnotePlugin: boolean = false
  /**
   * 是否加载html解析插件
   */
  isHtmlPlugin: boolean = false
  /**
   * 是否加载表格解析插件
   */
  isTablePlugin: boolean = false
  /**
   * 是否加载toc解析插件
   */
  isTocPlugin: boolean = false
  /**
   * 是否加载任务列表解析插件
   */
  isTaskListPlugin: boolean = false
  /**
   * 是否加载删除线解析插件
   */
  isStrikethroughPlugin: boolean = false
  /**
   * 是否加载链接自动解析插件
   */
  isLinkifyPlugin: boolean = false
  /**
   * 正则列表
   */
  regs: Array<string> = []
  /**
   * 是否加载链接单独解析插件
   */
  isLinkViewPlugin: boolean = false
  /**
   * 是否加载数学公式解析插件
   */
  isLatexMathPlugin: boolean = false
  /**
   * 是否加载图片自定义样式解析插件
   */
  isImageStylePlugin: boolean = false
  /**
   * 是否加载图片banner解析插件
   */
  isImageSlidePlugin: boolean = false
  /**
   * 是否加载图片单独提取到block解析插件
   */
  isImageTextMixPlugin: boolean = false
  /**
   * 是否加载图片视频列表url集合列表解析插件
   */
  isImageCollectPlugin: boolean = false
  /**
   * 是否加载定义列表解析插件
   */
  isDescListPlugin: boolean = false
  /**
   * 是否加载标题ID解析插件
   */
  isHeadIDPlugin: boolean = false
  /**
   * 是否加载下标解析插件
   */
  isSubPlugin: boolean = false
  /**
   * 是否加载上标解析插件
   */
  isSupPlugin: boolean = false
  /**
   * 是否加载emoji解析插件
   */
  isEmojiPlugin: boolean = false
  /**
   * emoji解析插件是否精简加载
   */
  isEmojiLight: boolean = false

  /**
   * 设置音频插件
   *
   * @param isBlockAudioPlugin 是否设置音频插件 - true：设置音频插件；false：不设置音频插件。默认false
   */
  setIsBlockAudioPlugin(isBlockAudioPlugin: boolean): void {
    this.isBlockAudioPlugin = isBlockAudioPlugin
  }

  /**
   * 设置视频插件
   *
   * @param isBlockVideoPlugin 是否设置视频插件 - true：设置视频插件；false：不设置视频插件。默认false
   */
  setIsBlockVideoPlugin(isBlockVideoPlugin: boolean): void {
    this.isBlockVideoPlugin = isBlockVideoPlugin
  }

  /**
   * 设置组合代码快列表插件
   *
   * @param isCodeListPlugin 是否设置组合代码快列表插件 - true：设置组合代码快列表插件；false：不设置组合代码快列表插件。默认false
   */
  setIsCodeListPlugin(isCodeListPlugin: boolean): void {
    this.isCodeListPlugin = isCodeListPlugin
  }

  /**
   * 设置脚注插件
   *
   * @param isFootnotePlugin 是否设置脚注插件 - true：设置脚注插件；false：不设置脚注插件。默认false
   */
  setIsFootnotePlugin(isFootnotePlugin: boolean): void {
    this.isFootnotePlugin = isFootnotePlugin
  }

  /**
   * 设置HTML插件
   *
   * @param isHtmlPlugin 是否设置HTML插件 - true：设置HTML插件；false：不设置HTML插件。默认false
   */
  setIsHtmlPlugin(isHtmlPlugin: boolean): void {
    this.isHtmlPlugin = isHtmlPlugin
  }

  /**
   * 设置表格插件
   *
   * @param isTablePlugin 是否设置表格插件 - true：设置表格插件；false：不设置表格插件。默认false
   */
  setIsTablePlugin(isTablePlugin: boolean): void {
    this.isTablePlugin = isTablePlugin
  }

  /**
   * 设置TOC插件
   *
   * @param isTocPlugin 是否设置TOC插件 - true：设置TOC插件；false：不设置TOC插件。默认false
   */
  setIsTocPlugin(isTocPlugin: boolean): void {
    this.isTocPlugin = isTocPlugin
  }

  /**
   * 设置任务列表插件
   *
   * @param isTaskListPlugin 是否设置任务列表插件 - true：设置任务列表插件；false：不设置任务列表插件。默认false
   */
  setIsTaskListPlugin(isTaskListPlugin: boolean): void {
    this.isTaskListPlugin = isTaskListPlugin
  }

  /**
   * 设置删除线插件
   *
   * @param isStrikethroughPlugin 是否设置删除线插件 - true：设置删除线插件；false：不设置删除线插件。默认false
   */
  setIsStrikethroughPlugin(isStrikethroughPlugin: boolean): void {
    this.isStrikethroughPlugin = isStrikethroughPlugin
  }

  /**
   * 设置链接自动加载插件
   *
   * @param isLinkifyPlugin 是否设置链接自动加载插件 - true：设置链接自动加载插件；false：不设置链接自动加载插件。默认false
   * @param regs 正则列表
   */
  setIsLinkifyPlugin(isLinkifyPlugin: boolean, regs: Array<string>): void {
    this.isLinkifyPlugin = isLinkifyPlugin
    this.regs = regs
  }

  /**
   * 设置链接块状化插件
   *
   * @param isLinkViewPlugin 是否设置链接块状化插件 - true：设置链接块状化插件；false：不设置链接块状化插件。默认false
   */
  setIsLinkViewPlugin(isLinkViewPlugin: boolean): void {
    this.isLinkViewPlugin = isLinkViewPlugin
  }

  /**
   * 设置数学公式插件
   *
   * @param isLatexMathPlugin 是否设置数学公式插件 - true：设置数学公式插件；false：不设置数学公式插件。默认false
   */
  setIsLatexMathPlugin(isLatexMathPlugin: boolean): void {
    this.isLatexMathPlugin = isLatexMathPlugin
  }

  /**
   * 设置图片样式插件
   *
   * @param isImageStylePlugin 是否设置图片样式插件 - true：设置图片样式插件；false：不设置图片样式插件。默认false
   */
  setIsImageStylePlugin(isImageStylePlugin: boolean): void {
    this.isImageStylePlugin = isImageStylePlugin
  }

  /**
   * 设置图片幻灯片（Banner）插件
   *
   * @param isImageSlidePlugin 是否设置图片幻灯片（Banner）插件 - true：设置图片幻灯片（Banner）插件；false：不设置图片幻灯片（Banner）插件。默认false
   */
  setIsImageSlidePlugin(isImageSlidePlugin: boolean): void {
    this.isImageSlidePlugin = isImageSlidePlugin
  }

  /**
   * 设置图片不混排插件
   *
   * @param isImageTextMixPlugin 是否图片不混排插件 - true：图片混排；false：图片不混排。默认true
   */
  setIsImageTextMixPlugin(isImageTextMixPlugin: boolean): void {
    this.isImageTextMixPlugin = isImageTextMixPlugin
  }

  /**
   * 设置图片视频url集合列表插件
   *
   * @param isImageCollectPlugin 是否设置图片视频url集合列表插件 - true：设置图片视频url集合列表插件；false：不设置图片视频url集合列表插件。默认false
   */
  setIsImageCollectPlugin(isImageCollectPlugin: boolean): void {
    this.isImageCollectPlugin = isImageCollectPlugin
  }

  /**
   * 设置是否加载定义列表解析插件
   *
   * @param isDescListPlugin 是否加载定义列表解析插件 - true：设置加载定义列表解析插件；false：不设置加载定义列表解析插件。默认false
   */
  setIsDescListPlugin(isDescListPlugin: boolean): void {
    this.isDescListPlugin = isDescListPlugin
  }

  /**
   * 设置是否加载标题ID解析插件
   *
   * @param isHeadIDPlugin 是否加载标题ID解析插件 - true：设置加载标题ID解析插件；false：不设置加载标题ID解析插件。默认false
   */
  setIsHeadIDPlugin(isHeadIDPlugin: boolean): void {
    this.isHeadIDPlugin = isHeadIDPlugin
  }

  /**
   * 设置是否加载下标解析插件
   *
   * @param isSubPlugin 是否加载下标解析插件 - true：设置加载下标解析插件；false：不设置加载下标解析插件。默认false
   */
  setIsSubPlugin(isSubPlugin: boolean): void {
    this.isSubPlugin = isSubPlugin
  }

  /**
   * 设置是否加载上标解析插件
   *
   * @param isSupPlugin 是否加载上标解析插件 - true：设置加载上标解析插件；false：不设置加载上标解析插件。默认false
   */
  setIsSupPlugin(isSupPlugin: boolean): void {
    this.isSupPlugin = isSupPlugin
  }

  /**
   * 设置是否加载emoji解析插件
   *
   * @param isEmojiPlugin 是否加载上标解析插件 - true：设置加载上标解析插件件；false：不设置加载上标解析插件。默认false
   * @param isEmojiLight 是否加载精简emoji表情 - true：加载精简emoji表情；false：不加载精简emoji表情。默认true
   */
  setIsEmojiPlugin(isEmojiPlugin: boolean, isEmojiLight: boolean): void {
    this.isEmojiPlugin = isEmojiPlugin
    this.isEmojiLight = isEmojiLight
  }
}

/**
 * Markdown滑动控制器
 */
export class MarkdownScroller {
  private scroller?: CJMarkdownScroller = undefined

  /**
   * 构造函数
   */
  constructor() {
    this.scroller = new CJMarkdownScroller()
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
   * 获取内部CJMarkdownScroller实例
   *
   * @returns CJMarkdownScroller实例
   */
  getScroller(): CJMarkdownScroller {
    if (this.scroller === undefined) {
      this.scroller = new CJMarkdownScroller()
    }
    return this.scroller
  }
}
