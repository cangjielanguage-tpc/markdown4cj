import { Context } from "@kit.AbilityKit"

export declare class CJMarkdownPlugin {
  setIsBlockAudioPlugin(isBlockAudioPlugin: boolean): void

  setIsBlockVideoPlugin(isBlockVideoPlugin: boolean): void

  setIsCodeListPlugin(isCodeListPlugin: boolean): void

  setIsFootnotePlugin(isFootnotePlugin: boolean): void

  setIsHtmlPlugin(isHtmlPlugin: boolean): void

  setIsTablePlugin(isTablePlugin: boolean): void

  setIsTocPlugin(isTocPlugin: boolean): void

  setIsTaskListPlugin(isTaskListPlugin: boolean): void

  setIsStrikethroughPlugin(isStrikethroughPlugin: boolean): void

  setIsLinkifyPlugin(isLinkifyPlugin: boolean): void

  setIsLinkViewPlugin(isLinkViewPlugin: boolean): void

  setIsLatexMathPlugin(isLatexMathPlugin: boolean): void

  setIsImageStylePlugin(isImageStylePlugin: boolean): void

  setIsImageSlidePlugin(isImageSlidePlugin: boolean): void

  setIsImageTextMixPlugin(isImageTextMixPlugin: boolean): void

  setIsImageCollectPlugin(isImageCollectPlugin: boolean): void

  setIsDescListPlugin(isDescListPlugin: boolean): void

  setIsHeadIDPlugin(isHeadIDPlugin: boolean): void
}

export declare class CJMarkdownTheme {
  setIsOnCopy(isOnCopy: boolean): void

  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): void

  setIsLinkStyle(isLinkStyle: boolean): void

  setIsListLinkStyle(isListLinkStyle: boolean): void

  setLinkColor(linkColor: number): void

  setIsLinkSize(isLinkSize: boolean): void

  setLinkSize(linkSize: number): void

  setLinkBackGroupColor(linkBackGroupColor: number): void

  setIsLinkUnderlined(isLinkUnderlined: boolean): void

  setLinkCircleImageBackGroupColor(linkCircleImageBackGroupColor: number): void

  setLinkCircleImageButtonBackGroupColor(linkCircleImageButtonBackGroupColor: number): void

  setLinkCircleImageTextSize(linkCircleImageTextSize: number): void

  setLinkCircleImageTextColor(linkCircleImageTextColor: number): void

  setLinkCircleImageRadius(linkCircleImageRadius: number): void

  setLinkCircleImageMargin(linkCircleImageMargin: number): void

  setLinkRectImageBackGroupColor(linkRectImageBackGroupColor: number): void

  setLinkRectImageButtonBackGroupColor(linkRectImageButtonBackGroupColor: number): void

  setLinkRectImageTextSize(linkRectImageTextSize: number): void

  setLinkRectImageTextColor(linkRectImageTextColor: number): void

  setLinkRectImageHeight(linkRectImageHeight: number): void

  setLinkRectImagePadding(linkRectImagePadding: number): void

  setLinkRectImageRadius(linkRectImageRadius: number): void

  setLinkRectImageMargin(linkRectImageMargin: number): void

  setLinkRectToolImageBackGroupColor(linkRectToolImageBackGroupColor: number): void

  setLinkRectToolImageButtonBackGroupColor(linkRectToolImageButtonBackGroupColor: number): void

  setLinkRectToolImageTextSize(linkRectToolImageTextSize: number): void

  setLinkRectToolImageHeight(linkRectToolImageHeight: number): void

  setLinkRectToolImagePadding(linkRectToolImagePadding: number): void

  setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: number): void

  setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: number): void

  setLinkRectToolImageMargin(linkRectToolImageMargin: number): void

  setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: number): void

  setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: number): void

  setBlockQuoteLeftMargin(blockQuoteLeftMargin: number): void

  setBlockQuoteRightMargin(blockQuoteRightMargin: number): void

  setBlockQuoteWidth(blockQuoteWidth: number): void

  setBlockQuoteColor(blockQuoteColor: number): void

  setBlockQuoteBackGroupColor(blockQuoteBackGroupColor: number): void

  setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: number): void

  setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: number): void

  setBlockLeftMargin(blockLeftMargin: number): void

  setBlockRightMargin(blockRightMargin: number): void

  setOrderedListItemPrefixBold(orderedListItemPrefixBold: boolean): void

  setOrderedListItemColor(orderedListItemColor: number): void

  setOrderedListItemSize(orderedListItemSize: number): void

  setOrderedListItemLineHeight(orderedListItemLineHeight: number): void

  setBulletListItemCircle(bulletListItemCircle: boolean): void

  setBulletListItemColor(bulletListItemColor: number): void

  setBulletListItemSize(bulletListItemSize: number): void

  setBulletListItemLineHeight(bulletListItemLineHeight: number): void

  setTaskListItemLength(taskListItemLength: number): void

  setIsCodeStyle(isCodeStyle: boolean): void

  setCodeTextColor(codeTextColor: number): void

  setCodeBackgroundColor(codeBackgroundColor: number): void

  setCodeTextSize(codeTextSize: number): void

  setCodeTypeface(codeTypeface: string): void

  setCodeLeftAndRightPadding(codeLeftAndRightPadding: number): void

  setCodeHeight(codeHeight: number): void

  setCodeBlockTextColor(codeBlockTextColor: number): void

  setCodeBlockTypeTextColor(codeBlockTypeTextColor: number): void

  setCodeBlockTypeTextStr(codeBlockTypeTextStr: string): void

  setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: number): void

  setCodeBlockIconTextHide(codeBlockIconTextHide: boolean): void

  setCodeBlockLineNumberHide(codeBlockLineNumberHide: boolean): void

  setCodeBlockBackgroundColor(codeBlockBackgroundColor: number): void

  setCodeMultilineMargin(codeMultilineMargin: number): void

  setCodeBlockTypeface(codeBlockTypeface: string): void

  setCodeBlockTextSize(codeBlockTextSize: number): void

  setCodeBlockLineHeight(codeBlockLineHeight: number): void

  setCodeBlockRadius(codeBlockRadius: number): void

  setIsCodeFullScreen(isCodeFullScreen: boolean): void

  setIconWidthAndHeight(iconWidthAndHeight: number): void

  setCodeListTitleTextSize(codeListTitleTextSize: number): void

  setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: number): void

  setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: number): void

  setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: number): void

  setCodeListTitleSelectBackGroupColor(codeListTitleSelectBackGroupColor: number): void

  setCodeListTitleUnSelectBackGroupColor(codeListTitleUnSelectBackGroupColor: number): void

  setIsSeparateCodeBlock(isSeparateCodeBlock: boolean): void

  setSeparateCodeBlockWidth(separateCodeBlockWidth: number): void

  setSeparateCodeIsBottom(separateCodeIsBottom: boolean): void

  setHeadingBreakHeight(headingBreakHeight: number): void

  setHeadingBreakColor(headingBreakColor: number): void

  setHeadingTypeface(headingTypeface: string): void

  setHeadingTopMargins(headingTopMargins: number): void

  setHeadingBottomMargins(headingBottomMargins: number): void

  setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<number>): void

  setHeadingTextColor(headingTextColor: number): void

  setHeadingTextWordSpace(headingTextWordSpace: number): void

  setHeadingTextLineHeight1(headingTextLineHeight1: number): void

  setHeadingTextLineHeight2(headingTextLineHeight2: number): void

  setHeadingTextLineHeight3(headingTextLineHeight3: number): void

  setHeadingTextLineHeight4(headingTextLineHeight4: number): void

  setHeadingTextLineHeight5(headingTextLineHeight5: number): void

  setHeadingTextLineHeight6(headingTextLineHeight6: number): void

  setParagraphTopMargins(paragraphTopMargins: number): void

  setParagraphBottomMargins(paragraphBottomMargins: number): void

  setParagraphTextSize(paragraphTextSize: number): void

  setParagraphTextColor(paragraphTextColor: number): void

  setParagraphTextWordSpace(paragraphTextWordSpace: number): void

  setParagraphTextLineHeight(paragraphTextLineHeight: number): void

  setParagraphTypeface(paragraphTypeface: string): void

  setThematicBreakColor(thematicBreakColor: number): void

  setThematicBreakHeight(thematicBreakHeight: number): void

  setThematicBreakTopMargin(thematicBreakTopMargin: number): void

  setThematicBreakBottomMargin(thematicBreakBottomMargin: number): void

  setIsLineBreak(isLineBreak: boolean): void

  setLatexDefaultText(latexMathTextSize: boolean): void

  setLatexMathTextSize(latexMathTextSize: number): void

  setLatexMathBackGroupColor(latexMathBackGroupColor: number): void

  setLatexMathTextColor(latexMathTextColor: number): void

  setLatexMathColorFormat(latexMathColorFormat: number): void

  setLatexMathBlockCenter(latexMathBlockCenter: boolean): void

  setLatexMathResStr(latexMathResStr: string): void

  setAudioShadowColor(audioShadowColor: number): void

  setAudioBorderColor(audioBorderColor: number): void

  setAudioBorderWidth(audioBorderWidth: number): void

  setAudioBorderRadius(audioBorderRadius: number): void

  setAudioButtonBackgroundColor(audioButtonBackgroundColor: number): void

  setAudioButtonTextColor(audioButtonTextColor: number): void

  setAudioButtonTextSize(audioButtonTextSize: number): void

  setAudioButtonText(audioButtonText: string): void

  setAudioButtonBorderRadius(audioButtonBorderRadius: number): void

  setAudioTitleTextSize(audioTitleTextSize: number): void

  setAudioTitleTextColor(audioTitleTextColor: number): void

  setAudioTitleTextLineHeight(audioTitleTextLineHeight: number): void

  setAudioTypeTextSize(audioTypeTextSize: number): void

  setAudioTypeTextColor(audioTypeTextColor: number): void

  setAudioTypeTextLineHeight(audioTypeTextLineHeight: number): void

  setAudioMarginTop(audioMarginTop: number): void

  setAudioMarginBottom(audioMarginBottom: number): void

  setVideoBorderRadius(videoBorderRadius: number): void

  setVideoTimeTextColor(videoTimeTextColor: number): void

  setVideoTimeTextSize(videoTimeTextSize: number): void

  setVideoTimeTextMarginRight(videoTimeTextMarginRight: number): void

  setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: number): void

  setVideoMarginTop(videoMarginTop: number): void

  setVideoMarginBottom(videoMarginBottom: number): void

  setImageFitType(imageFitType: number): void

  setImageMaximumWidth(imageMaximumWidth: number): void

  setImageFixedRatioWidth(imageFixedRatioWidth: number): void

  setImageBorderRadius(imageBorderRadius: number): void

  setIsAutoResize(isAutoResize: boolean): void

  setImageMarginTop(imageMarginTop: number): void

  setImageMarginBottom(imageMarginBottom: number): void

  setTableCellPadding(tableCellPadding: number): void

  setTableBorderColor(tableBorderColor: number): void

  setTableBorderWidth(tableBorderWidth: number): void

  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): void

  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): void

  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): void

  setTableTextLineHeight(tableTextLineHeight: number): void

  setTableRadius(tableRadius: number): void

  setTableMinTextWidth(tableMinTextWidth: number): void

  setTableMaxTextWidth(tableMaxTextWidth: number): void

  setTableFirstColumnBold(tableFirstColumnBold: boolean): void

  setIsDark(isDark: boolean): void

  setStrikethroughColor(strikethroughColor: number): void

  setDescListTermAndDefMargins(descListTermAndDefMargins: number): void

  setDescListDefIndentation(descListDefIndentation: number): void

  setDescListDefMargins(descListDefMargins: number): void
}

export declare class CJMarkdownConfig {
  setLinkCallback(cb: (funcArg0: string) => void): void

  setTextCopyCallback(cb: (funcArg0: string) => void): void

  setImageCallback(cb: (funcArg0: string, funcArg1: Array<string>) => void): void

  setAudioCallback(cb: (funcArg0: string) => void): void

  setVideoCallback(cb: (funcArg0: string, funcArg1: Array<string>) => void): void

  setVideoImageCallback(cb: (funcArg0: string, funcArg1: (funcArgfuncArg0: string, funcArgfuncArg1: number, funcArgfuncArg2: number) => void) => void): void

  setCodeCopyCallback(cb: (funcArg0: string) => void): void

  setCodeFullScreenCallback(cb: (funcArg0: string, funcArg1: string | undefined) => void): void

  setLatexImageCallback(cb: (funcArg0: ArrayBuffer, funcArg1: number, funcArg2: number) => void): void

  setLatexStrCallback(cb: (funcArg0: string) => string): void

  setTocIndexCallback(cb: (funcArg0: number | undefined) => void): void

  setFootnoteCallback(cb: (funcArg0: number | undefined) => void): void

  setCJMarkdownTheme(cjMarkdownTheme: CJMarkdownTheme): void
}

export declare interface CustomLib {
  CJMarkdownConfig: { new(): CJMarkdownConfig }
  CJMarkdownTheme: { new(): CJMarkdownTheme }
  CJMarkdownPlugin: { new(): CJMarkdownPlugin }

  setGlobalContext(context: Context): void

  getLoadCJPage(mdStr: string, cfg: CJMarkdownConfig, plugin: CJMarkdownPlugin): (input: string) => void

  registerImgPreprocessCallback(cb: (url: string) => Promise<ArrayBuffer|undefined>): void
}