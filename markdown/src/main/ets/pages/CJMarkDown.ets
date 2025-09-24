import { NodeController, FrameNode } from '@kit.ArkUI';
import { requireCJLib } from 'libark_interop_loader.so';
import { CustomLib, CJMarkdownConfig, CJMarkdownTheme, CJMarkdownPlugin } from 'libark_interop_api_markdown.so';

export const global_customLib: CustomLib = requireCJLib("libmarkdown.so") as CustomLib

export const global_cjLib: CJLib = requireCJLib("libmarkdown.so") as CJLib

export interface CJLib {
  getCJResource(codeFullScreenIcon?: Resource, codeCopyIcon?: Resource, audioIcon?: Resource, videoImage?: Resource,
    playCircleFillIcon?: Resource, bannerImage?: Resource, imageResource?: Resource): void
}

class CJNodeController extends NodeController {
  rootNode?: FrameNode = undefined
  // public freshCJ: (input: string) => void = (input: string) => {
  //   this.mdStr = input
  // } // 持续输出调用

  public callbackCJ: (input: string) => void = (input: string) => {this.mdStr = input}  // 持续输出调用
  mdStr: string
  cfg?: CJMarkdownConfig
  plugin?: CJMarkdownPlugin

  constructor(input: string, cfg?: CJMarkdownConfig, plugin?: CJMarkdownPlugin) {
    super()
    this.mdStr = input
    this.cfg = cfg
    this.plugin = plugin
  }

  makeNode(ctx: UIContext): FrameNode | null {
    if (this.rootNode === undefined) {
      this.rootNode = new FrameNode(ctx)
      this.callbackCJ = global_customLib.getLoadCJPage(this.mdStr, this.cfg, this.plugin)
    }
    return this.rootNode
  }
}

@Component
export struct CJMarkdown {
  @Prop @Watch('onMarkDownChange') mdStr: string = ''
  @State cfg?: MarkdownConfiguration = undefined
  @State plugin?: MarkdownPlugin = undefined
  private markdownNode: CJNodeController | null = null

  onMarkDownChange():void {
    this.markdownNode?.callbackCJ(this.mdStr)
  }

  aboutToAppear(): void {
    this.markdownNode = new CJNodeController(this.mdStr, this.getConfig(), this.getPlugin())
  }

  build() {
    NodeContainer(this.markdownNode)
  }

  getConfig(): CJMarkdownConfig {
    let cjMarkdownConfig: CJMarkdownConfig = new global_customLib.CJMarkdownConfig()
    if (this.cfg !== undefined) {
      if (this.cfg.linkCallback !== undefined) {
        cjMarkdownConfig.setLinkCallback(this.cfg.linkCallback)
      }
      if (this.cfg.imageCallback !== undefined) {
        cjMarkdownConfig.setImageCallback(this.cfg.imageCallback)
      }
      if (this.cfg.audioCallback !== undefined) {
        cjMarkdownConfig.setAudioCallback(this.cfg.audioCallback)
      }
      if (this.cfg.videoCallback !== undefined) {
        cjMarkdownConfig.setVideoCallback(this.cfg.videoCallback)
      }
      if (this.cfg.videoImageCallback !== undefined) {
        cjMarkdownConfig.setVideoImageCallback(this.cfg.videoImageCallback)
      }
      if (this.cfg.codeCopyCallback !== undefined) {
        cjMarkdownConfig.setCodeCopyCallback(this.cfg.codeCopyCallback)
      }
      if (this.cfg.codeFullScreenCallback !== undefined) {
        cjMarkdownConfig.setCodeFullScreenCallback(this.cfg.codeFullScreenCallback)
      }
      if (this.cfg.latexImageCallback !== undefined) {
        cjMarkdownConfig.setLatexImageCallback(this.cfg.latexImageCallback)
      }
      if (this.cfg.latexStrCallback !== undefined) {
        cjMarkdownConfig.setLatexStrCallback(this.cfg.latexStrCallback)
      }
      if (this.cfg.tocIndexCallback !== undefined) {
        cjMarkdownConfig.setTocIndexCallback(this.cfg.tocIndexCallback)
      }
      if (this.cfg.footnoteCallback !== undefined) {
        cjMarkdownConfig.setFootnoteCallback(this.cfg.footnoteCallback)
      }
    }
    cjMarkdownConfig.setCJMarkdownTheme(this.getTheme())
    return cjMarkdownConfig
  }

  getTheme(): CJMarkdownTheme {
    let cjMarkdownTheme: CJMarkdownTheme = new global_customLib.CJMarkdownTheme()
    if (this.cfg !== undefined) {
      if (this.cfg.markdownTheme !== undefined) {
        if (this.cfg.markdownTheme.context !== undefined) {
          global_customLib.setGlobalContext(this.cfg.markdownTheme.context)
        }
        global_cjLib.getCJResource(
          this.cfg.markdownTheme.codeFullScreenIcon,
          this.cfg.markdownTheme.codeCopyIcon,
          this.cfg.markdownTheme.audioIcon,
          this.cfg.markdownTheme.videoImage,
          this.cfg.markdownTheme.playCircleFillIcon,
          this.cfg.markdownTheme.bannerImage,
          this.cfg.markdownTheme.imageResource
        )
        if (this.cfg.markdownTheme.blockTopAndBottomMargins !== undefined) {
          cjMarkdownTheme.setBlockTopAndBottomMargins(this.cfg.markdownTheme.blockTopAndBottomMargins)
        }
        if (this.cfg.markdownTheme.isLinkStyle !== undefined) {
          cjMarkdownTheme.setIsLinkStyle(this.cfg.markdownTheme.isLinkStyle)
        }
        if (this.cfg.markdownTheme.isListLinkStyle !== undefined) {
          cjMarkdownTheme.setIsListLinkStyle(this.cfg.markdownTheme.isListLinkStyle)
        }
        if (this.cfg.markdownTheme.linkColor !== undefined) {
          cjMarkdownTheme.setLinkColor(this.cfg.markdownTheme.linkColor)
        }
        if (this.cfg.markdownTheme.isLinkSize !== undefined) {
          cjMarkdownTheme.setIsLinkSize(this.cfg.markdownTheme.isLinkSize)
        }
        if (this.cfg.markdownTheme.linkSize !== undefined) {
          cjMarkdownTheme.setLinkSize(this.cfg.markdownTheme.linkSize)
        }
        if (this.cfg.markdownTheme.linkBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkBackGroupColor(this.cfg.markdownTheme.linkBackGroupColor)
        }
        if (this.cfg.markdownTheme.isLinkUnderlined !== undefined) {
          cjMarkdownTheme.setIsLinkUnderlined(this.cfg.markdownTheme.isLinkUnderlined)
        }
        if (this.cfg.markdownTheme.linkCircleImageBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkCircleImageBackGroupColor(this.cfg.markdownTheme.linkCircleImageBackGroupColor)
        }
        if (this.cfg.markdownTheme.linkCircleImageButtonBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkCircleImageButtonBackGroupColor(this.cfg.markdownTheme.linkCircleImageButtonBackGroupColor)
        }
        if (this.cfg.markdownTheme.linkCircleImageTextSize !== undefined) {
          cjMarkdownTheme.setLinkCircleImageTextSize(this.cfg.markdownTheme.linkCircleImageTextSize)
        }
        if (this.cfg.markdownTheme.linkCircleImageTextColor !== undefined) {
          cjMarkdownTheme.setLinkCircleImageTextColor(this.cfg.markdownTheme.linkCircleImageTextColor)
        }
        if (this.cfg.markdownTheme.linkCircleImageRadius !== undefined) {
          cjMarkdownTheme.setLinkCircleImageRadius(this.cfg.markdownTheme.linkCircleImageRadius)
        }
        if (this.cfg.markdownTheme.linkCircleImageMargin !== undefined) {
          cjMarkdownTheme.setLinkCircleImageMargin(this.cfg.markdownTheme.linkCircleImageMargin)
        }
        if (this.cfg.markdownTheme.linkRectImageBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkRectImageBackGroupColor(this.cfg.markdownTheme.linkRectImageBackGroupColor)
        }
        if (this.cfg.markdownTheme.linkRectImageButtonBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkRectImageButtonBackGroupColor(this.cfg.markdownTheme.linkRectImageButtonBackGroupColor)
        }
        if (this.cfg.markdownTheme.linkRectImageTextSize !== undefined) {
          cjMarkdownTheme.setLinkRectImageTextSize(this.cfg.markdownTheme.linkRectImageTextSize)
        }
        if (this.cfg.markdownTheme.linkRectImageTextColor !== undefined) {
          cjMarkdownTheme.setLinkRectImageTextColor(this.cfg.markdownTheme.linkRectImageTextColor)
        }
        if (this.cfg.markdownTheme.linkRectImageHeight !== undefined) {
          cjMarkdownTheme.setLinkRectImageHeight(this.cfg.markdownTheme.linkRectImageHeight)
        }
        if (this.cfg.markdownTheme.linkRectImagePadding !== undefined) {
          cjMarkdownTheme.setLinkRectImagePadding(this.cfg.markdownTheme.linkRectImagePadding)
        }
        if (this.cfg.markdownTheme.linkRectImageRadius !== undefined) {
          cjMarkdownTheme.setLinkRectImageRadius(this.cfg.markdownTheme.linkRectImageRadius)
        }
        if (this.cfg.markdownTheme.linkRectImageMargin !== undefined) {
          cjMarkdownTheme.setLinkRectImageMargin(this.cfg.markdownTheme.linkRectImageMargin)
        }
        if (this.cfg.markdownTheme.linkRectToolImageBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageBackGroupColor(this.cfg.markdownTheme.linkRectToolImageBackGroupColor)
        }
        if (this.cfg.markdownTheme.linkRectToolImageButtonBackGroupColor !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageButtonBackGroupColor(this.cfg.markdownTheme.linkRectToolImageButtonBackGroupColor)
        }
        if (this.cfg.markdownTheme.linkRectToolImageTextSize !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageTextSize(this.cfg.markdownTheme.linkRectToolImageTextSize)
        }
        if (this.cfg.markdownTheme.linkRectToolImageHeight !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageHeight(this.cfg.markdownTheme.linkRectToolImageHeight)
        }
        if (this.cfg.markdownTheme.linkRectToolImagePadding !== undefined) {
          cjMarkdownTheme.setLinkRectToolImagePadding(this.cfg.markdownTheme.linkRectToolImagePadding)
        }
        if (this.cfg.markdownTheme.linkRectToolImageBorderWidth !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageBorderWidth(this.cfg.markdownTheme.linkRectToolImageBorderWidth)
        }
        if (this.cfg.markdownTheme.linkRectToolImageDividingLineWidth !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageDividingLineWidth(this.cfg.markdownTheme.linkRectToolImageDividingLineWidth)
        }
        if (this.cfg.markdownTheme.linkRectToolImageMargin !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageMargin(this.cfg.markdownTheme.linkRectToolImageMargin)
        }
        if (this.cfg.markdownTheme.linkRectToolImageLineLeftPadding !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageLineLeftPadding(this.cfg.markdownTheme.linkRectToolImageLineLeftPadding)
        }
        if (this.cfg.markdownTheme.linkRectToolImageLineRightPadding !== undefined) {
          cjMarkdownTheme.setLinkRectToolImageLineRightPadding(this.cfg.markdownTheme.linkRectToolImageLineRightPadding)
        }
        if (this.cfg.markdownTheme.blockQuoteLeftMargin !== undefined) {
          cjMarkdownTheme.setBlockQuoteLeftMargin(this.cfg.markdownTheme.blockQuoteLeftMargin)
        }
        if (this.cfg.markdownTheme.blockQuoteRightMargin !== undefined) {
          cjMarkdownTheme.setBlockQuoteRightMargin(this.cfg.markdownTheme.blockQuoteRightMargin)
        }
        if (this.cfg.markdownTheme.blockQuoteWidth !== undefined) {
          cjMarkdownTheme.setBlockQuoteWidth(this.cfg.markdownTheme.blockQuoteWidth)
        }
        if (this.cfg.markdownTheme.blockQuoteColor !== undefined) {
          cjMarkdownTheme.setBlockQuoteColor(this.cfg.markdownTheme.blockQuoteColor)
        }
        if (this.cfg.markdownTheme.blockQuoteBackGroupColor !== undefined) {
          cjMarkdownTheme.setBlockQuoteBackGroupColor(this.cfg.markdownTheme.blockQuoteBackGroupColor)
        }
        if (this.cfg.markdownTheme.blockQuoteTopAndBottomMargins !== undefined) {
          cjMarkdownTheme.setBlockQuoteTopAndBottomMargins(this.cfg.markdownTheme.blockQuoteTopAndBottomMargins)
        }
        if (this.cfg.markdownTheme.blockOrderedAndBulletTopAndBottomMargins !== undefined) {
          cjMarkdownTheme.setBlockOrderedAndBulletTopAndBottomMargins(this.cfg.markdownTheme.blockOrderedAndBulletTopAndBottomMargins)
        }
        if (this.cfg.markdownTheme.blockLeftMargin !== undefined) {
          cjMarkdownTheme.setBlockLeftMargin(this.cfg.markdownTheme.blockLeftMargin)
        }
        if (this.cfg.markdownTheme.blockRightMargin !== undefined) {
          cjMarkdownTheme.setBlockRightMargin(this.cfg.markdownTheme.blockRightMargin)
        }
        if (this.cfg.markdownTheme.orderedListItemPrefixBold !== undefined) {
          cjMarkdownTheme.setOrderedListItemPrefixBold(this.cfg.markdownTheme.orderedListItemPrefixBold)
        }
        if (this.cfg.markdownTheme.orderedListItemColor !== undefined) {
          cjMarkdownTheme.setOrderedListItemColor(this.cfg.markdownTheme.orderedListItemColor)
        }
        if (this.cfg.markdownTheme.orderedListItemSize !== undefined) {
          cjMarkdownTheme.setOrderedListItemSize(this.cfg.markdownTheme.orderedListItemSize)
        }
        if (this.cfg.markdownTheme.orderedListItemLineHeight !== undefined) {
          cjMarkdownTheme.setOrderedListItemLineHeight(this.cfg.markdownTheme.orderedListItemLineHeight)
        }
        if (this.cfg.markdownTheme.bulletListItemColor !== undefined) {
          cjMarkdownTheme.setBulletListItemColor(this.cfg.markdownTheme.bulletListItemColor)
        }
        if (this.cfg.markdownTheme.bulletListItemSize !== undefined) {
          cjMarkdownTheme.setBulletListItemSize(this.cfg.markdownTheme.bulletListItemSize)
        }
        if (this.cfg.markdownTheme.bulletListItemLineHeight !== undefined) {
          cjMarkdownTheme.setBulletListItemLineHeight(this.cfg.markdownTheme.bulletListItemLineHeight)
        }
        if (this.cfg.markdownTheme.taskListItemLength !== undefined) {
          cjMarkdownTheme.setTaskListItemLength(this.cfg.markdownTheme.taskListItemLength)
        }
        if (this.cfg.markdownTheme.isCodeStyle !== undefined) {
          cjMarkdownTheme.setIsCodeStyle(this.cfg.markdownTheme.isCodeStyle)
        }
        if (this.cfg.markdownTheme.codeTextColor !== undefined) {
          cjMarkdownTheme.setCodeTextColor(this.cfg.markdownTheme.codeTextColor)
        }
        if (this.cfg.markdownTheme.codeBackgroundColor !== undefined) {
          cjMarkdownTheme.setCodeBackgroundColor(this.cfg.markdownTheme.codeBackgroundColor)
        }
        if (this.cfg.markdownTheme.codeTextSize !== undefined) {
          cjMarkdownTheme.setCodeTextSize(this.cfg.markdownTheme.codeTextSize)
        }
        if (this.cfg.markdownTheme.codeTypeface !== undefined) {
          cjMarkdownTheme.setCodeTypeface(this.cfg.markdownTheme.codeTypeface)
        }
        if (this.cfg.markdownTheme.codeLeftAndRightPadding !== undefined) {
          cjMarkdownTheme.setCodeLeftAndRightPadding(this.cfg.markdownTheme.codeLeftAndRightPadding)
        }
        if (this.cfg.markdownTheme.codeHeight !== undefined) {
          cjMarkdownTheme.setCodeHeight(this.cfg.markdownTheme.codeHeight)
        }
        if (this.cfg.markdownTheme.codeBlockTextColor !== undefined) {
          cjMarkdownTheme.setCodeBlockTextColor(this.cfg.markdownTheme.codeBlockTextColor)
        }
        if (this.cfg.markdownTheme.codeBlockTypeTextColor !== undefined) {
          cjMarkdownTheme.setCodeBlockTypeTextColor(this.cfg.markdownTheme.codeBlockTypeTextColor)
        }
        if (this.cfg.markdownTheme.codeBlockTypeTextStr !== undefined) {
          cjMarkdownTheme.setCodeBlockTypeTextStr(this.cfg.markdownTheme.codeBlockTypeTextStr)
        }
        if (this.cfg.markdownTheme.codeBlockTypeTextPadding !== undefined) {
          cjMarkdownTheme.setCodeBlockTypeTextPadding(this.cfg.markdownTheme.codeBlockTypeTextPadding)
        }
        if (this.cfg.markdownTheme.codeBlockIconTextHide !== undefined) {
          cjMarkdownTheme.setCodeBlockIconTextHide(this.cfg.markdownTheme.codeBlockIconTextHide)
        }
        if (this.cfg.markdownTheme.codeBlockLineNumberHide !== undefined) {
          cjMarkdownTheme.setCodeBlockLineNumberHide(this.cfg.markdownTheme.codeBlockLineNumberHide)
        }
        if (this.cfg.markdownTheme.codeBlockBackgroundColor !== undefined) {
          cjMarkdownTheme.setCodeBlockBackgroundColor(this.cfg.markdownTheme.codeBlockBackgroundColor)
        }
        if (this.cfg.markdownTheme.codeMultilineMargin !== undefined) {
          cjMarkdownTheme.setCodeMultilineMargin(this.cfg.markdownTheme.codeMultilineMargin)
        }
        if (this.cfg.markdownTheme.codeBlockTypeface !== undefined) {
          cjMarkdownTheme.setCodeBlockTypeface(this.cfg.markdownTheme.codeBlockTypeface)
        }
        if (this.cfg.markdownTheme.codeBlockTextSize !== undefined) {
          cjMarkdownTheme.setCodeBlockTextSize(this.cfg.markdownTheme.codeBlockTextSize)
        }
        if (this.cfg.markdownTheme.codeBlockLineHeight !== undefined) {
          cjMarkdownTheme.setCodeBlockLineHeight(this.cfg.markdownTheme.codeBlockLineHeight)
        }
        if (this.cfg.markdownTheme.codeBlockRadius !== undefined) {
          cjMarkdownTheme.setCodeBlockRadius(this.cfg.markdownTheme.codeBlockRadius)
        }
        if (this.cfg.markdownTheme.isCodeFullScreen !== undefined) {
          cjMarkdownTheme.setIsCodeFullScreen(this.cfg.markdownTheme.isCodeFullScreen)
        }
        if (this.cfg.markdownTheme.iconWidthAndHeight !== undefined) {
          cjMarkdownTheme.setIconWidthAndHeight(this.cfg.markdownTheme.iconWidthAndHeight)
        }
        if (this.cfg.markdownTheme.codeListTitleTextSize !== undefined) {
          cjMarkdownTheme.setCodeListTitleTextSize(this.cfg.markdownTheme.codeListTitleTextSize)
        }
        if (this.cfg.markdownTheme.codeListTitleSelectTextSize !== undefined) {
          cjMarkdownTheme.setCodeListTitleSelectTextSize(this.cfg.markdownTheme.codeListTitleSelectTextSize)
        }
        if (this.cfg.markdownTheme.codeListTitleSelectTextColor !== undefined) {
          cjMarkdownTheme.setCodeListTitleSelectTextColor(this.cfg.markdownTheme.codeListTitleSelectTextColor)
        }
        if (this.cfg.markdownTheme.codeListTitleUnSelectTextColor !== undefined) {
          cjMarkdownTheme.setCodeListTitleUnSelectTextColor(this.cfg.markdownTheme.codeListTitleUnSelectTextColor)
        }
        if (this.cfg.markdownTheme.codeListTitleSelectBackGroupColor !== undefined) {
          cjMarkdownTheme.setCodeListTitleSelectBackGroupColor(this.cfg.markdownTheme.codeListTitleSelectBackGroupColor)
        }
        if (this.cfg.markdownTheme.codeListTitleUnSelectBackGroupColor !== undefined) {
          cjMarkdownTheme.setCodeListTitleUnSelectBackGroupColor(this.cfg.markdownTheme.codeListTitleUnSelectBackGroupColor)
        }
        if (this.cfg.markdownTheme.isSeparateCodeBlock !== undefined) {
          cjMarkdownTheme.setIsSeparateCodeBlock(this.cfg.markdownTheme.isSeparateCodeBlock)
        }
        if (this.cfg.markdownTheme.separateCodeBlockWidth !== undefined) {
          cjMarkdownTheme.setSeparateCodeBlockWidth(this.cfg.markdownTheme.separateCodeBlockWidth)
        }
        if (this.cfg.markdownTheme.headingBreakHeight !== undefined) {
          cjMarkdownTheme.setHeadingBreakHeight(this.cfg.markdownTheme.headingBreakHeight)
        }
        if (this.cfg.markdownTheme.headingBreakColor !== undefined) {
          cjMarkdownTheme.setHeadingBreakColor(this.cfg.markdownTheme.headingBreakColor)
        }
        if (this.cfg.markdownTheme.headingTypeface !== undefined) {
          cjMarkdownTheme.setHeadingTypeface(this.cfg.markdownTheme.headingTypeface)
        }
        if (this.cfg.markdownTheme.headingTextSizeMultipliers !== undefined) {
          let multipliers: Array<number> = new Array<number>()
          for (let index = 0; index < this.cfg.markdownTheme.headingTextSizeMultipliers.length; index++) {
            multipliers.push(this.cfg.markdownTheme.headingTextSizeMultipliers[index])
          }
          cjMarkdownTheme.setHeadingTextSizeMultipliers(multipliers)
        }
        if (this.cfg.markdownTheme.headingTextColor !== undefined) {
          cjMarkdownTheme.setHeadingTextColor(this.cfg.markdownTheme.headingTextColor)
        }
        if (this.cfg.markdownTheme.headingTextWordSpace !== undefined) {
          cjMarkdownTheme.setHeadingTextWordSpace(this.cfg.markdownTheme.headingTextWordSpace)
        }
        if (this.cfg.markdownTheme.headingTextLineHeight1 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight1(this.cfg.markdownTheme.headingTextLineHeight1)
        }
        if (this.cfg.markdownTheme.headingTextLineHeight2 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight2(this.cfg.markdownTheme.headingTextLineHeight2)
        }
        if (this.cfg.markdownTheme.headingTextLineHeight3 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight3(this.cfg.markdownTheme.headingTextLineHeight3)
        }
        if (this.cfg.markdownTheme.headingTextLineHeight4 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight4(this.cfg.markdownTheme.headingTextLineHeight4)
        }
        if (this.cfg.markdownTheme.headingTextLineHeight5 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight5(this.cfg.markdownTheme.headingTextLineHeight5)
        }
        if (this.cfg.markdownTheme.headingTextLineHeight6 !== undefined) {
          cjMarkdownTheme.setHeadingTextLineHeight6(this.cfg.markdownTheme.headingTextLineHeight6)
        }
        if (this.cfg.markdownTheme.paragraphTextSize !== undefined) {
          cjMarkdownTheme.setParagraphTextSize(this.cfg.markdownTheme.paragraphTextSize)
        }
        if (this.cfg.markdownTheme.paragraphTextColor !== undefined) {
          cjMarkdownTheme.setParagraphTextColor(this.cfg.markdownTheme.paragraphTextColor)
        }
        if (this.cfg.markdownTheme.paragraphTextWordSpace !== undefined) {
          cjMarkdownTheme.setParagraphTextWordSpace(this.cfg.markdownTheme.paragraphTextWordSpace)
        }
        if (this.cfg.markdownTheme.paragraphTextLineHeight !== undefined) {
          cjMarkdownTheme.setParagraphTextLineHeight(this.cfg.markdownTheme.paragraphTextLineHeight)
        }
        if (this.cfg.markdownTheme.paragraphTypeface !== undefined) {
          cjMarkdownTheme.setParagraphTypeface(this.cfg.markdownTheme.paragraphTypeface)
        }
        if (this.cfg.markdownTheme.thematicBreakColor !== undefined) {
          cjMarkdownTheme.setThematicBreakColor(this.cfg.markdownTheme.thematicBreakColor)
        }
        if (this.cfg.markdownTheme.thematicBreakHeight !== undefined) {
          cjMarkdownTheme.setThematicBreakHeight(this.cfg.markdownTheme.thematicBreakHeight)
        }
        if (this.cfg.markdownTheme.thematicBreakTopMargin !== undefined) {
          cjMarkdownTheme.setThematicBreakTopMargin(this.cfg.markdownTheme.thematicBreakTopMargin)
        }
        if (this.cfg.markdownTheme.thematicBreakBottomMargin !== undefined) {
          cjMarkdownTheme.setThematicBreakBottomMargin(this.cfg.markdownTheme.thematicBreakBottomMargin)
        }
        if (this.cfg.markdownTheme.isLineBreak !== undefined) {
          cjMarkdownTheme.setIsLineBreak(this.cfg.markdownTheme.isLineBreak)
        }
        if (this.cfg.markdownTheme.latexMathTextSize !== undefined) {
          cjMarkdownTheme.setLatexMathTextSize(this.cfg.markdownTheme.latexMathTextSize)
        }
        if (this.cfg.markdownTheme.latexMathBackGroupColor !== undefined) {
          cjMarkdownTheme.setLatexMathBackGroupColor(this.cfg.markdownTheme.latexMathBackGroupColor)
        }
        if (this.cfg.markdownTheme.latexMathTextColor !== undefined) {
          cjMarkdownTheme.setLatexMathTextColor(this.cfg.markdownTheme.latexMathTextColor)
        }
        if (this.cfg.markdownTheme.latexMathColorFormat !== undefined) {
          cjMarkdownTheme.setLatexMathColorFormat(this.cfg.markdownTheme.latexMathColorFormat)
        }
        if (this.cfg.markdownTheme.latexMathBlockCenter !== undefined) {
          cjMarkdownTheme.setLatexMathBlockCenter(this.cfg.markdownTheme.latexMathBlockCenter)
        }
        if (this.cfg.markdownTheme.latexMathResStr !== undefined) {
          cjMarkdownTheme.setLatexMathResStr(this.cfg.markdownTheme.latexMathResStr)
        }
        if (this.cfg.markdownTheme.audioShadowColor !== undefined) {
          cjMarkdownTheme.setAudioShadowColor(this.cfg.markdownTheme.audioShadowColor)
        }
        if (this.cfg.markdownTheme.audioBorderColor !== undefined) {
          cjMarkdownTheme.setAudioBorderColor(this.cfg.markdownTheme.audioBorderColor)
        }
        if (this.cfg.markdownTheme.audioBorderWidth !== undefined) {
          cjMarkdownTheme.setAudioBorderWidth(this.cfg.markdownTheme.audioBorderWidth)
        }
        if (this.cfg.markdownTheme.audioBorderRadius !== undefined) {
          cjMarkdownTheme.setAudioBorderRadius(this.cfg.markdownTheme.audioBorderRadius)
        }
        if (this.cfg.markdownTheme.audioButtonBackgroundColor !== undefined) {
          cjMarkdownTheme.setAudioButtonBackgroundColor(this.cfg.markdownTheme.audioButtonBackgroundColor)
        }
        if (this.cfg.markdownTheme.audioButtonTextColor !== undefined) {
          cjMarkdownTheme.setAudioButtonTextColor(this.cfg.markdownTheme.audioButtonTextColor)
        }
        if (this.cfg.markdownTheme.audioButtonTextSize !== undefined) {
          cjMarkdownTheme.setAudioButtonTextSize(this.cfg.markdownTheme.audioButtonTextSize)
        }
        if (this.cfg.markdownTheme.audioButtonText !== undefined) {
          cjMarkdownTheme.setAudioButtonText(this.cfg.markdownTheme.audioButtonText)
        }
        if (this.cfg.markdownTheme.audioButtonBorderRadius !== undefined) {
          cjMarkdownTheme.setAudioButtonBorderRadius(this.cfg.markdownTheme.audioButtonBorderRadius)
        }
        if (this.cfg.markdownTheme.audioTitleTextSize !== undefined) {
          cjMarkdownTheme.setAudioTitleTextSize(this.cfg.markdownTheme.audioTitleTextSize)
        }
        if (this.cfg.markdownTheme.audioTitleTextColor !== undefined) {
          cjMarkdownTheme.setAudioTitleTextColor(this.cfg.markdownTheme.audioTitleTextColor)
        }
        if (this.cfg.markdownTheme.blockTopAndBottomMargins !== undefined) {
          cjMarkdownTheme.setBlockTopAndBottomMargins(this.cfg.markdownTheme.blockTopAndBottomMargins)
        }
        if (this.cfg.markdownTheme.blockTopAndBottomMargins !== undefined) {
          cjMarkdownTheme.setBlockTopAndBottomMargins(this.cfg.markdownTheme.blockTopAndBottomMargins)
        }
        if (this.cfg.markdownTheme.audioTitleTextLineHeight !== undefined) {
          cjMarkdownTheme.setAudioTitleTextLineHeight(this.cfg.markdownTheme.audioTitleTextLineHeight)
        }
        if (this.cfg.markdownTheme.audioTypeTextSize !== undefined) {
          cjMarkdownTheme.setAudioTypeTextSize(this.cfg.markdownTheme.audioTypeTextSize)
        }
        if (this.cfg.markdownTheme.audioTypeTextColor !== undefined) {
          cjMarkdownTheme.setAudioTypeTextColor(this.cfg.markdownTheme.audioTypeTextColor)
        }
        if (this.cfg.markdownTheme.audioTypeTextLineHeight !== undefined) {
          cjMarkdownTheme.setAudioTypeTextLineHeight(this.cfg.markdownTheme.audioTypeTextLineHeight)
        }
        if (this.cfg.markdownTheme.audioMarginTop !== undefined) {
          cjMarkdownTheme.setAudioMarginTop(this.cfg.markdownTheme.audioMarginTop)
        }
        if (this.cfg.markdownTheme.audioMarginBottom !== undefined) {
          cjMarkdownTheme.setAudioMarginBottom(this.cfg.markdownTheme.audioMarginBottom)
        }
        if (this.cfg.markdownTheme.videoBorderRadius !== undefined) {
          cjMarkdownTheme.setVideoBorderRadius(this.cfg.markdownTheme.videoBorderRadius)
        }
        if (this.cfg.markdownTheme.videoTimeTextColor !== undefined) {
          cjMarkdownTheme.setVideoTimeTextColor(this.cfg.markdownTheme.videoTimeTextColor)
        }
        if (this.cfg.markdownTheme.videoTimeTextSize !== undefined) {
          cjMarkdownTheme.setVideoTimeTextSize(this.cfg.markdownTheme.videoTimeTextSize)
        }
        if (this.cfg.markdownTheme.videoTimeTextMarginRight !== undefined) {
          cjMarkdownTheme.setVideoTimeTextMarginRight(this.cfg.markdownTheme.videoTimeTextMarginRight)
        }
        if (this.cfg.markdownTheme.videoTimeTextMarginBottom !== undefined) {
          cjMarkdownTheme.setVideoTimeTextMarginBottom(this.cfg.markdownTheme.videoTimeTextMarginBottom)
        }
        if (this.cfg.markdownTheme.videoMarginTop !== undefined) {
          cjMarkdownTheme.setVideoMarginTop(this.cfg.markdownTheme.videoMarginTop)
        }
        if (this.cfg.markdownTheme.videoMarginBottom !== undefined) {
          cjMarkdownTheme.setVideoMarginBottom(this.cfg.markdownTheme.videoMarginBottom)
        }
        if (this.cfg.markdownTheme.imagePlaceholder !== undefined) {
          cjMarkdownTheme.setImagePlaceholder(this.cfg.markdownTheme.imagePlaceholder)
        }
        if (this.cfg.markdownTheme.isAutoResize !== undefined) {
          cjMarkdownTheme.setIsAutoResize(this.cfg.markdownTheme.isAutoResize)
        }
        if (this.cfg.markdownTheme.imageMarginTop !== undefined) {
          cjMarkdownTheme.setImageMarginTop(this.cfg.markdownTheme.imageMarginTop)
        }
        if (this.cfg.markdownTheme.imageMarginBottom !== undefined) {
          cjMarkdownTheme.setImageMarginBottom(this.cfg.markdownTheme.imageMarginBottom)
        }
        if (this.cfg.markdownTheme.tableCellPadding !== undefined) {
          cjMarkdownTheme.setTableCellPadding(this.cfg.markdownTheme.tableCellPadding)
        }
        if (this.cfg.markdownTheme.tableBorderColor !== undefined) {
          cjMarkdownTheme.setTableBorderColor(this.cfg.markdownTheme.tableBorderColor)
        }
        if (this.cfg.markdownTheme.tableBorderWidth !== undefined) {
          cjMarkdownTheme.setTableBorderWidth(this.cfg.markdownTheme.tableBorderWidth)
        }
        if (this.cfg.markdownTheme.tableOddRowBackgroundColor !== undefined) {
          cjMarkdownTheme.setTableOddRowBackgroundColor(this.cfg.markdownTheme.tableOddRowBackgroundColor)
        }
        if (this.cfg.markdownTheme.tableEvenRowBackgroundColor !== undefined) {
          cjMarkdownTheme.setTableEvenRowBackgroundColor(this.cfg.markdownTheme.tableEvenRowBackgroundColor)
        }
        if (this.cfg.markdownTheme.tableHeaderRowBackgroundColor !== undefined) {
          cjMarkdownTheme.setTableHeaderRowBackgroundColor(this.cfg.markdownTheme.tableHeaderRowBackgroundColor)
        }
        if (this.cfg.markdownTheme.tableTextLineHeight !== undefined) {
          cjMarkdownTheme.setTableTextLineHeight(this.cfg.markdownTheme.tableTextLineHeight)
        }
        if (this.cfg.markdownTheme.tableRadius !== undefined) {
          cjMarkdownTheme.setTableRadius(this.cfg.markdownTheme.tableRadius)
        }
        if (this.cfg.markdownTheme.tableMinTextWidth !== undefined) {
          cjMarkdownTheme.setTableMinTextWidth(this.cfg.markdownTheme.tableMinTextWidth)
        }
        if (this.cfg.markdownTheme.tableMaxTextWidth !== undefined) {
          cjMarkdownTheme.setTableMaxTextWidth(this.cfg.markdownTheme.tableMaxTextWidth)
        }
        if (this.cfg.markdownTheme.tableFirstColumnBold !== undefined) {
          cjMarkdownTheme.setTableFirstColumnBold(this.cfg.markdownTheme.tableFirstColumnBold)
        }
        if (this.cfg.markdownTheme.isDark !== undefined) {
          cjMarkdownTheme.setIsDark(this.cfg.markdownTheme.isDark)
        }
      }
    }
    return cjMarkdownTheme
  }

  getPlugin(): CJMarkdownPlugin {
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
      cjMarkdownPlugin.setIsLinkifyPlugin(this.plugin.isLinkifyPlugin)
      cjMarkdownPlugin.setIsLinkViewPlugin(this.plugin.isLinkViewPlugin)
      cjMarkdownPlugin.setIsLatexMathPlugin(this.plugin.isLatexMathPlugin)
      cjMarkdownPlugin.setIsImageStylePlugin(this.plugin.isImageStylePlugin)
      cjMarkdownPlugin.setIsImageSlidePlugin(this.plugin.isImageSlidePlugin)
      cjMarkdownPlugin.setIsImageSinglePlugin(this.plugin.isImageSinglePlugin)
      cjMarkdownPlugin.setIsImageCollectPlugin(this.plugin.isImageCollectPlugin)
    }
    return cjMarkdownPlugin
  }
}

export class MarkdownConfiguration {
  /**
   * 链接的点击事件
   */
  linkCallback?: (funcArg0: string) => void = undefined
  /**
   * 图片的点击事件
   */
  imageCallback?: (funcArg0: string, funcArg1: Array<string>) => void = undefined
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
  videoImageCallback?: (funcArg0: string,
    funcArg1: (funcArgfuncArg0: string, funcArgfuncArg1: number, funcArgfuncArg2: number) => void) => void = undefined
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
   * 设置图片点击回调
   *
   * @param cb 图片点击回调。 (funcArg0：图片url,funcArg1:所有图片和视频连接集合 --- 需要加载图片视频列表url集合列表解析插件)
   */
  setImageCallback(cb: (funcArg0: string, funcArg1: Array<string>) => void): void {
    this.imageCallback = cb
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
  setVideoImageCallback(cb: (funcArg0: string,
    funcArg1: (funcArgfuncArg0: string, funcArgfuncArg1: number, funcArgfuncArg2: number) => void) => void): void {
    this.videoImageCallback = cb
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
   * 内联代码是否是图片显示
   */
  isCodeStyle?: boolean = undefined
  /**
   * 文本、图片格式内联代码文本颜色
   */
  codeTextColor?: number = undefined
  /**
   * 文本、图片格式内联代码背景颜色
   */
  codeBackgroundColor?: number = undefined
  /**
   * 文本、图片格式内联代码文本大小
   */
  codeTextSize?: number = undefined
  /**
   * 文本格式内联代码文本字体
   */
  codeTypeface?: string = undefined
  /**
   * 图片格式内联代码文本左右边距
   */
  codeLeftAndRightPadding?: number = undefined
  /**
   * 图片格式内联代码文本高度
   */
  codeHeight?: number = undefined
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
   * H1、H2标题下分割线高度
   */
  headingBreakHeight?: number = undefined
  /**
   * H1、H2标题下分割线颜色
   */
  headingBreakColor?: number = undefined
  /**
   * 标题文本字体
   */
  headingTypeface?: string = undefined
  /**
   * 标题文本大小数组
   */
  headingTextSizeMultipliers?: Array<number> = undefined
  /**
   * 标题文本颜色
   */
  headingTextColor?: number = undefined
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
   * 图片默认占位图 - String
   */
  imagePlaceholder?: string = undefined
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
   * 代码深浅色模式
   */
  isDark?: boolean = undefined

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
   * 设置是否按照链接文本自己大小显示文本
   *
   * @param isLinkSize 是否按照链接文本自己大小显示文本 - true：显示链接自己文本大小；false：跟随标题段落大小显示。默认true
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
   * @param linkCircleImageBackGroupColor 圆形图片格式链接主题背景颜色 - 默认0XFFFFFFFF
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
   * @param linkRectImageBackGroupColor 圆角矩形图片格式链接主题背景颜色 - 默认0XFFFFFFFF
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
   * @param linkRectToolImageBackGroupColor 空心圆角矩形图片格式链接主题背景颜色 - 默认OXFFFFFFFF
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
   * @param blockQuoteBackGroupColor 块引用背景颜色 - 默认0XFFFFFFFF
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
   * 设置内联代码是否是图片显示
   *
   * @param isCodeStyle 内联代码是否是图片显示 - true：图片化显示；false：不图片化显示。默认false
   */
  setIsCodeStyle(isCodeStyle: boolean): void {
    this.isCodeStyle = isCodeStyle
  }

  /**
   * 设置文本、图片格式内联代码文本颜色
   *
   * @param codeTextColor 文本、图片格式内联代码文本颜色 - 默认OXFF000000
   */
  setCodeTextColor(codeTextColor: number): void {
    this.codeTextColor = codeTextColor
  }

  /**
   * 设置文本、图片格式内联代码背景颜色
   *
   * @param codeBackgroundColor 文本、图片格式内联代码背景颜色 - 默认OXFF191919
   */
  setCodeBackgroundColor(codeBackgroundColor: number): void {
    this.codeBackgroundColor = codeBackgroundColor
  }

  /**
   * 设置文本、图片格式内联代码文本大小
   *
   * @param codeTextSize 文本、图片格式内联代码文本大小 - 默认13.0fp
   */
  setCodeTextSize(codeTextSize: number): void {
    this.codeTextSize = codeTextSize
  }

  /**
   * 设置文本格式内联代码文本字体
   *
   * @param codeTypeface 文本格式内联代码文本字体 - 默认"HarmonyOS Sans"
   */
  setCodeTypeface(codeTypeface: string): void {
    this.codeTypeface = codeTypeface
  }

  /**
   * 设置图片格式内联代码文本左右边距
   *
   * @param codeLeftAndRightPadding 图片格式内联代码文本左右边距 - 默认4.0vp
   */
  setCodeLeftAndRightPadding(codeLeftAndRightPadding: number): void {
    this.codeLeftAndRightPadding = codeLeftAndRightPadding
  }

  /**
   * 设置图片格式内联代码文本高度
   *
   * @param codeHeight 图片格式内联代码文本高度 - 默认20.0vp
   */
  setCodeHeight(codeHeight: number): void {
    this.codeHeight = codeHeight
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
   * 设置H1、H2标题下分割线高度
   *
   * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
   */
  setHeadingBreakHeight(headingBreakHeight: number): void {
    this.headingBreakHeight = headingBreakHeight
  }

  /**
   * 设置H1、H2标题下分割线颜色
   *
   * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0XFF191919
   */
  setHeadingBreakColor(headingBreakColor: number): void {
    this.headingBreakColor = headingBreakColor
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
   * 设置标题文本大小数组
   *
   * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
   */
  setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<number>): void {
    this.headingTextSizeMultipliers = headingTextSizeMultipliers
  }

  /**
   * 设置标题文本颜色
   *
   * @param headingTextColor 标题文本颜色 - 默认0XFF191919
   */
  setHeadingTextColor(headingTextColor: number): void {
    this.headingTextColor = headingTextColor
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
   * @param headingTextLineHeight1 六级标题文本行高 - 默认22.0vp
   */
  setHeadingTextLineHeight6(headingTextLineHeight6: number): void {
    this.headingTextLineHeight6 = headingTextLineHeight6
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
   * @param latexMathBackGroupColor 数学公式背景色 - 默认0xFFFFFFFF
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
   * 设置图片默认占位图 - String
   *
   * @param imagePlaceholder 图片默认占位图 - String - 默认None
   */
  setImagePlaceholder(imagePlaceholder: string): void {
    this.imagePlaceholder = imagePlaceholder
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
   * 设置代码块深浅色
   *
   * @param isDark 是否是深色 - true：深色；false：浅色。默认false
   */
  setIsDark(isDark: boolean): void {
    this.isDark = isDark
  }
}

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
  isImageSinglePlugin: boolean = false
  /**
   * 是否加载图片视频列表url集合列表解析插件
   */
  isImageCollectPlugin: boolean = false

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
   */
  setIsLinkifyPlugin(isLinkifyPlugin: boolean): void {
    this.isLinkifyPlugin = isLinkifyPlugin
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
   * 设置单独的图片提到块级别插件
   *
   * @param isImageSinglePlugin 是否设置单独的图片提到块级别插件 - true：设置单独的图片提到块级别插件；false：不设置单独的图片提到块级别插件。默认false
   */
  setIsImageSinglePlugin(isImageSinglePlugin: boolean): void {
    this.isImageSinglePlugin = isImageSinglePlugin
  }

  /**
   * 设置图片视频url集合列表插件
   *
   * @param isImageCollectPlugin 是否设置图片视频url集合列表插件 - true：设置图片视频url集合列表插件；false：不设置图片视频url集合列表插件。默认false
   */
  setIsImageCollectPlugin(isImageCollectPlugin: boolean): void {
    this.isImageCollectPlugin = isImageCollectPlugin
  }
}

