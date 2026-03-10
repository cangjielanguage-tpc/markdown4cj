/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { Context } from "@kit.AbilityKit"
import { resourceManager } from "@kit.LocalizationKit"

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

  setIsLinkifyPlugin(isLinkifyPlugin: boolean, regs: Array<string>): void

  setIsLinkViewPlugin(isLinkViewPlugin: boolean): void

  setIsLatexMathPlugin(isLatexMathPlugin: boolean): void

  setIsImageStylePlugin(isImageStylePlugin: boolean): void

  setIsImageSlidePlugin(isImageSlidePlugin: boolean): void

  setIsImageTextMixPlugin(isImageTextMixPlugin: boolean): void

  setIsImageCollectPlugin(isImageCollectPlugin: boolean): void

  setIsDescListPlugin(isDescListPlugin: boolean): void

  setIsHeadIDPlugin(isHeadIDPlugin: boolean): void

  setIsSubPlugin(isSubPlugin: boolean): void

  setIsSupPlugin(isSupPlugin: boolean): void

  setIsEmojiPlugin(isSupPlugin: boolean, isEmojiLight: boolean): void

  constructor()
}

export declare class CJMarkdownTheme {
  setIsMarkdownParserSync(isMarkdownParserSync: boolean): void

  setTypeWriterOpen(typeWriterOpen: boolean): void

  setTypeWriterColor(typeWriterColor: number): void

  setIsOnCopy(isOnCopy: boolean): void

  setBlockFirstTopMargin(blockFirstTopMargin: number): void

  setBlockLastBottomMargin(blockLastBottomMargin: number): void

  setBlockTopAndBottomMargins(blockTopAndBottomMargins: number): void

  setIsLinkStyle(isLinkStyle: boolean): void

  setIsListLinkStyle(isListLinkStyle: boolean): void

  setLinkColor(linkColor: number): void

  setIsLinkSize(isLinkSize: boolean): void

  setLinkSize(linkSize: number): void

  setLinkLineHeight(linkLineHeight: number): void

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

  setIsCodeFormat(isCodeFormat: boolean): void

  setCodeTextColor(codeTextColor: number): void

  setCodeBackgroundColor(codeBackgroundColor: number): void

  setCodeTextSize(codeTextSize: number): void

  setCodeTypeface(codeTypeface: string): void

  setIsCodeBlockParserSync(isCodeBlockParserSync: boolean): void

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

  setHeadingTextSize1(headingTextSize1: number): void

  setHeadingTextSize2(headingTextSize2: number): void

  setHeadingTextSize3(headingTextSize3: number): void

  setHeadingTextSize4(headingTextSize4: number): void

  setHeadingTextSize5(headingTextSize5: number): void

  setHeadingTextSize6(headingTextSize6: number): void

  setHeadingTextWordSpace(headingTextWordSpace: number): void

  setHeadingTextLineHeight1(headingTextLineHeight1: number): void

  setHeadingTextLineHeight2(headingTextLineHeight2: number): void

  setHeadingTextLineHeight3(headingTextLineHeight3: number): void

  setHeadingTextLineHeight4(headingTextLineHeight4: number): void

  setHeadingTextLineHeight5(headingTextLineHeight5: number): void

  setHeadingTextLineHeight6(headingTextLineHeight6: number): void

  setHeadingTextColor1(headingTextColor1: number): void

  setHeadingTextColor2(headingTextColor2: number): void

  setHeadingTextColor3(headingTextColor3: number): void

  setHeadingTextColor4(headingTextColor4: number): void

  setHeadingTextColor5(headingTextColor5: number): void

  setHeadingTextColor6(headingTextColor6: number): void

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

  setIsVideoBottomLayout(isVideoBottomLayout: boolean): void

  setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: number): void

  setVideoReleaseWidth(videoReleaseWidth: number): void

  setVideoReleaseHeight(videoReleaseHeight: number): void

  setVideoReleaseRadius(videoReleaseRadius: number): void

  setVideoReleaseText(videoReleaseText: string): void

  setVideoReleaseTexSize(videoReleaseTexSize: number): void

  setVideoReleaseTexColor(videoReleaseTexColor: number): void

  setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: number): void

  setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: number): void

  setVideoDownloadWidth(videoDownloadWidth: number): void

  setVideoDownloadHeight(videoDownloadHeight: number): void

  setVideoDownloadRadius(videoDownloadRadius: number): void

  setVideoDownloadText(videoDownloadText: string): void

  setVideoDownloadTexSize(videoDownloadTexSize: number): void

  setVideoDownloadTexColor(videoDownloadTexColor: number): void

  setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: number): void

  setImageFitType(imageFitType: number): void

  setImageMaximumWidth(imageMaximumWidth: number): void

  setImageFixedRatioWidth(imageFixedRatioWidth: number): void

  setImageMaxHeight(imageMaxHeight: number): void

  setImageMaxWidth(imageMaxWidth: number): void

  setImageBorderRadius(imageBorderRadius: number): void

  setImageBorderWidth(imageBorderWidth: number): void

  setImageBorderColor(imageBorderColor: number): void

  setIsAutoResize(isAutoResize: boolean): void

  setImageMarginTop(imageMarginTop: number): void

  setImageMarginBottom(imageMarginBottom: number): void

  setIsImageDownload(isImageDownload: boolean): void

  setIsImageMixedLayout(isImageMixedLayout: boolean): void

  setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: number): void

  setImageDownloadWidth(imageDownloadWidth: number): void

  setImageDownloadHeight(imageDownloadHeight: number): void

  setImageDownloadRadius(imageDownloadRadius: number): void

  setImageDownloadText(imageDownloadText: string): void

  setImageDownloadTexSize(imageDownloadTexSize: number): void

  setImageDownloadTexColor(imageDownloadTexColor: number): void

  setImageDownloadBackgroundColor(imageDownloadBackgroundColor: number): void

  setTableCellPadding(tableCellPadding: number): void

  setTableBorderColor(tableBorderColor: number): void

  setTableBorderWidth(tableBorderWidth: number): void

  setTableOddRowBackgroundColor(tableOddRowBackgroundColor: number): void

  setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: number): void

  setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: number): void

  setTableTitleTextColor(tableTitleTextColor: number): void

  setTableTitleTextSize(tableTitleTextSize: number): void

  setTableTitleLineHeight(tableTitleLineHeight: number): void

  setTableContentTextColor(tableContentTextColor: number): void

  setTableContentTextSize(tableContentTextSize: number): void

  setTableTextLineHeight(tableTextLineHeight: number): void

  setTableRadius(tableRadius: number): void

  setTableMinTextWidth(tableMinTextWidth: number): void

  setTableMaxTextWidth(tableMaxTextWidth: number): void

  setTableFirstColumnBold(tableFirstColumnBold: boolean): void

  setTableScrollBarShow(tableScrollBarShow: boolean): void

  setTableScrollBarColor(tableScrollBarColor: number): void

  setIsDark(isDark: boolean): void

  setStrikethroughColor(strikethroughColor: number): void

  setStrikethroughStyle(strikethroughStyle: number): void

  setDescListTermAndDefMargins(descListTermAndDefMargins: number): void

  setDescListDefIndentation(descListDefIndentation: number): void

  setDescListDefMargins(descListDefMargins: number): void

  setSubTextColor(subTextColor: number): void

  setSubTextSize(subTextSize: number): void

  setSubOffsetDist(subOffsetDist: number): void

  setSupTextColor(supTextColor: number): void

  setSupTextSize(supTextSize: number): void

  setSupOffsetDist(supOffsetDist: number): void

  setUnderlineColor(underlineColor: number): void

  setUnderlineStyle(underlineStyle: number): void

  constructor()
}

export declare class CJMarkdownConfig {
  setLinkCallback(cb: (funcArg0: string) => void): void

  setTextCopyCallback(cb: (funcArg0: string) => void): void

  setImageCallback(cb: (funcArg0: string, funcArg1: Array<string>) => void): void

  setImageDownloadCallback(cb: (string) => void): void

  setAudioCallback(cb: (funcArg0: string) => void): void

  setVideoCallback(cb: (funcArg0: string, funcArg1: Array<string>) => void): void

  setVideoImageCallback(cb: (funcArg0: string, funcArg1: (funcArgfuncArg0: string, funcArgfuncArg1: number, funcArgfuncArg2: number) => void) => void): void

  setVideoReleaseCallback(cb: (funcArg0: string) => void): void

  setVideoDownloadCallback(cb: (funcArg0: string) => void): void

  setCodeCopyCallback(cb: (funcArg0: string) => void): void

  setCodeFullScreenCallback(cb: (funcArg0: string, funcArg1: string | undefined) => void): void

  setLatexImageCallback(cb: (funcArg0: ArrayBuffer, funcArg1: number, funcArg2: number) => void): void

  setLatexStrCallback(cb: (funcArg0: string) => string): void

  setTocIndexCallback(cb: (funcArg0: number | undefined) => void): void

  setFootnoteCallback(cb: (funcArg0: number | undefined) => void): void

  setCJMarkdownTheme(cjMarkdownTheme: CJMarkdownTheme): void

  constructor()
}

export declare class CJMarkdownScroller {
  constructor()

  scrollBy(xOffset: number, yOffset: number): void

  scrollToIndex(value: number): void

  scrollEdge(value: number): void

  isAtEnd(): boolean

  currentYOffset(): number
}

export declare function setGlobalContext(context: Context): void

export declare function getLoadCJPage(mdStr: string, isInputEnded: boolean, incrementalAnalysis: boolean, cfg: CJMarkdownConfig, plugin: CJMarkdownPlugin, listScroller?: CJMarkdownScroller): (input: string, isInputEnded: boolean, incrementalAnalysis: boolean) => void

export declare function registerImgPreprocessCallback(cb: (url: string) => Promise<ArrayBuffer|undefined>): void

export declare function getCJResource(codeFullScreenIcon?: resourceManager.Resource, codeCopyIcon?: resourceManager.Resource, audioIcon?: resourceManager.Resource, videoImage?: resourceManager.Resource, playCircleFillIcon?: resourceManager.Resource, bannerImage?: resourceManager.Resource, imageResource?: resourceManager.Resource, videoReleaseImage?: resourceManager.Resource, videoDownloadImage?: resourceManager.Resource, imageDownloadImage?: resourceManager.Resource): void
