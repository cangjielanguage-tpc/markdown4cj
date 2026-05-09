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
}

export declare class CJMarkdownTheme {
  setCJMarkdownGlobalTheme(cjMarkdownGlobalTheme: CJMarkdownGlobalTheme): void

  setCJMarkdownAudioTheme(cjMarkdownAudioTheme: CJMarkdownAudioTheme): void

  setCJMarkdownBulletListTheme(cjMarkdownBulletListTheme: CJMarkdownBulletListTheme): void

  setCJMarkdownBoldTheme(cjMarkdownBoldTheme: CJMarkdownBoldTheme): void

  setCJMarkdownDefinitionListTheme(cjMarkdownDefinitionListTheme: CJMarkdownDefinitionListTheme): void

  setCJMarkdownDividerTheme(cjMarkdownDividerTheme: CJMarkdownDividerTheme): void

  setCJMarkdownFootnoteDefTheme(cjMarkdownFootnoteDefTheme: CJMarkdownFootnoteDefTheme): void

  setCJMarkdownFootnoteRefTheme(cjMarkdownFootnoteRefTheme: CJMarkdownFootnoteRefTheme): void

  setCJMarkdownLatexMathTheme(cjMarkdownLatexMathTheme: CJMarkdownLatexMathTheme): void

  setCJMarkdownHtmlUnderlineTheme(cjMarkdownHtmlUnderlineTheme: CJMarkdownHtmlUnderlineTheme): void

  setCJMarkdownItalicTheme(cjMarkdownItalicTheme: CJMarkdownItalicTheme): void

  setCJMarkdownStrikethroughTheme(cjMarkdownStrikethroughTheme: CJMarkdownStrikethroughTheme): void

  setCJMarkdownSubTheme(cjMarkdownSubTheme: CJMarkdownSubTheme): void

  setCJMarkdownSupTheme(cjMarkdownSupTheme: CJMarkdownSupTheme): void

  setCJMarkdownInlineCodeTheme(cjMarkdownInlineCodeTheme: CJMarkdownInlineCodeTheme): void

  setCJMarkdownLinkTheme(cjMarkdownLinkTheme: CJMarkdownLinkTheme): void

  setCJMarkdownOrderedListTheme(cjMarkdownOrderedListTheme: CJMarkdownOrderedListTheme): void

  setCJMarkdownParagraphTheme(cjMarkdownParagraphTheme: CJMarkdownParagraphTheme): void

  setCJMarkdownVideoTheme(cjMarkdownVideoTheme: CJMarkdownVideoTheme): void

  setCJMarkdownTableTheme(cjMarkdownTableTheme: CJMarkdownTableTheme): void

  setCJMarkdownBlockQuoteTheme(cjMarkdownBlockQuoteTheme: CJMarkdownBlockQuoteTheme): void

  setCJMarkdownBannerTheme(cjMarkdownBannerTheme: CJMarkdownBannerTheme): void

  setCJMarkdownImageTheme(cjMarkdownImageTheme: CJMarkdownImageTheme): void

  setCJMarkdownHeadingTheme(cjMarkdownHeadingTheme: CJMarkdownHeadingTheme): void

  setCJMarkdownCodeBlockTheme(cjMarkdownCodeBlockTheme: CJMarkdownCodeBlockTheme): void
}

export declare class CJMarkdownGlobalTheme {
  setIsMarkdownParserSync(isSync: boolean): void

  setIsOnCopy(onCopy: boolean): void

  setBackgroundColor(color: number): void

  setBlockSpacing(spacing: number): void

  setGlobalAllMargin(margin: number): void

  setGlobalMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setIsLineBreak(isLineBreak: boolean): void

  setOpenGestureSwipe(openGestureSwipe: boolean): void
}

export declare class CJMarkdownAudioTheme {
  setAudioBackgroundColor(color: number): void

  setAudioAllMargin(margin: number): void

  setAudioMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setAudioAllPadding(padding: number): void

  setAudioPadding(top?: number, right?: number, bottom?: number, left?: number): void

  setAudioBorderStyle(borderStyle: number): void

  setAudioBorderWidth(borderWidth: number): void

  setAudioBorderColor(borderColor: number): void

  setAudioBorderAllRadius(radius: number): void

  setAudioBorderRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setAudioShadowRadius(radius: number): void

  setAudioShadowOffsetX(offsetX: number): void

  setAudioShadowOffsetY(offsetY: number): void

  setAudioShadowColor(color: number): void

  setAudioIconWidth(width: number): void

  setAudioIconHeight(height: number): void

  setAudioIconAllRadius(radius: number): void

  setAudioIconRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setAudioIconFitType(fitType: number): void

  setAudioTitleToTypeSpacing(spacing: number): void

  setAudioButtonWidth(width: number): void

  setAudioButtonHeight(height: number): void

  setAudioButtonBackgroundColor(color: number): void

  setAudioButtonBorderStyle(borderStyle: number): void

  setAudioButtonBorderWidth(borderWidth: number): void

  setAudioButtonBorderColor(borderColor: number): void

  setAudioButtonAllRadius(radius: number): void

  setAudioButtonRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setAudioButtonText(text: string): void

  setAudioButtonTextFontColor(color: number): void

  setAudioButtonTextFontSize(size: number): void

  setAudioButtonTextFontStyle(style: number): void

  setAudioButtonTextFontWeight(weight: number): void

  setAudioButtonTextFontFamily(family: string): void

  setAudioButtonTextLineHeight(height: number): void

  setAudioTitleTextFontColor(color: number): void

  setAudioTitleTextFontSize(size: number): void

  setAudioTitleTextFontStyle(style: number): void

  setAudioTitleTextFontWeight(weight: number): void

  setAudioTitleTextFontFamily(family: string): void

  setAudioTitleTextLineHeight(height: number): void

  setAudioTypeTextFontColor(color: number): void

  setAudioTypeTextFontSize(size: number): void

  setAudioTypeTextFontStyle(style: number): void

  setAudioTypeTextFontWeight(weight: number): void

  setAudioTypeTextFontFamily(family: string): void

  setAudioTypeTextLineHeight(height: number): void
}

export declare class CJMarkdownBannerTheme {
  setBannerAllMargin(margin: number): void

  setBannerMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setBannerAllPadding(padding: number): void

  setBannerPadding(top?: number, right?: number, bottom?: number, left?: number): void
}

export declare class CJMarkdownBlockQuoteTheme {
  setBlockQuoteBackgroundColor(color: number): void

  setBlockQuoteAllMargin(margin: number): void

  setBlockQuoteMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setBlockQuoteAllPadding(padding: number): void

  setBlockQuotePadding(top?: number, right?: number, bottom?: number, left?: number): void

  setBlockQuoteAllRadius(radius: number): void

  setBlockQuoteRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setBlockQuoteLeftBorderWidth(width: number): void

  setBlockQuoteLeftBorderColor(color: number): void

  setBlockQuoteBorderContentSpacing(spacing: number): void

  setBlockQuoteChildSpacing(spacing: number): void
}

export declare class CJMarkdownBoldTheme {
  setBoldTextFontColor(color: number): void

  setBoldTextFontSize(size: number): void

  setBoldTextFontStyle(style: number): void

  setBoldTextFontWeight(weight: number): void

  setBoldTextFontFamily(family: string): void

  setBoldTextLineHeight(lineHeight: number): void

  setBoldTextLetterSpacing(spacing: number): void
}

export declare class CJMarkdownBulletListTheme {
  setBulletListBackgroundColor(color: number): void

  setBulletListAllMargin(margin: number): void

  setBulletListMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setBulletListAllPadding(padding: number): void

  setBulletListPadding(top?: number, right?: number, bottom?: number, left?: number): void

  setBulletListChildSpacing(spacing: number): void

  setBulletListChildChildSpacing(spacing: number): void

  setBulletListBulletSpacing(spacing: number): void

  setBulletListBulletIsCircle(isCircle: boolean): void

  setBulletListBulletTextFontColor(color: number): void

  setBulletListBulletTextFontSize(size: number): void

  setBulletListBulletTextFontStyle(style: number): void

  setBulletListBulletTextFontWeight(weight: number): void

  setBulletListBulletTextFontFamily(family: string): void

  setBulletListBulletTextLineHeight(lineHeight: number): void

  setBulletListCheckboxSpacing(spacing: number): void

  setBulletListCheckboxWidth(width: number): void

  setBulletListCheckboxHeight(height: number): void

  setBulletListCheckboxSelectedColor(color: number): void

  setBulletListCheckboxShape(shape: number): void
}

export declare class CJMarkdownCodeBlockTheme {
  setCodeBlockIsDark(isDark: boolean): void

  setCodeBlockIsCodeFormat(isCodeFormat: boolean): void

  setCodeBlockUseTab(useTab: boolean): void

  setCodeBlockIndentWidth(indentWidth: number): void

  setCodeBlockParserSync(parserSync: boolean): void

  setCodeBlockBackgroundColor(color: number): void

  setCodeBlockAllMargin(margin: number): void

  setCodeBlockMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setCodeBlockAllPadding(padding: number): void

  setCodeBlockPadding(top?: number, right?: number, bottom?: number, left?: number): void

  setCodeBlockBorderStyle(borderStyle: number): void

  setCodeBlockBorderWidth(borderWidth: number): void

  setCodeBlockBorderColor(borderColor: number): void

  setCodeBlockAllRadius(radius: number): void

  setCodeBlockRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setCodeBlockTitleLayoutMarginBottom(marginBottom: number): void

  setCodeBlockTypeTextMarginLeft(marginLeft: number): void

  setCodeBlockTypeText(text: string): void

  setCodeBlockTypeTextFontColor(color: number): void

  setCodeBlockTypeTextFontSize(size: number): void

  setCodeBlockTypeTextFontStyle(style: number): void

  setCodeBlockTypeTextFontWeight(weight: number): void

  setCodeBlockTypeTextFontFamily(family: string): void

  setCodeBlockTypeTextLineHeight(height: number): void

  setCodeBlockCopyFullScreenSpacing(spacing: number): void

  setCodeBlockCopyButtonIsShow(isShow: boolean): void

  setCodeBlockCopyTextIsShow(isShow: boolean): void

  setCodeBlockCopyIconWidth(width: number): void

  setCodeBlockCopyIconHeight(height: number): void

  setCodeBlockCopyIconTextSpacing(spacing: number): void

  setCodeBlockCopyText(text: string): void

  setCodeBlockCopyTextFontColor(color: number): void

  setCodeBlockCopyTextFontSize(size: number): void

  setCodeBlockCopyTextFontStyle(style: number): void

  setCodeBlockCopyTextFontWeight(weight: number): void

  setCodeBlockCopyTextFontFamily(family: string): void

  setCodeBlockCopyTextLineHeight(height: number): void

  setCodeBlockFullScreenButtonIsShow(isShow: boolean): void

  setCodeBlockFullScreenTextIsShow(isShow: boolean): void

  setCodeBlockFullScreenIconWidth(width: number): void

  setCodeBlockFullScreenIconHeight(height: number): void

  setCodeBlockFullScreenIconTextSpacing(spacing: number): void

  setCodeBlockFullScreenText(text: string): void

  setCodeBlockFullScreenTextFontColor(color: number): void

  setCodeBlockFullScreenTextFontSize(size: number): void

  setCodeBlockFullScreenTextFontStyle(style: number): void

  setCodeBlockFullScreenTextFontWeight(weight: number): void

  setCodeBlockFullScreenTextFontFamily(family: string): void

  setCodeBlockFullScreenTextLineHeight(height: number): void

  setCodeBlockLineNumberIsShow(isShow: boolean): void

  setCodeBlockLineNumberTextPaddingLeft(left: number): void

  setCodeBlockLineNumberTextFontColor(color: number): void

  setCodeBlockLineNumberTextFontSize(size: number): void

  setCodeBlockLineNumberTextFontStyle(style: number): void

  setCodeBlockLineNumberTextFontWeight(weight: number): void

  setCodeBlockLineNumberTextFontFamily(family: string): void

  setCodeBlockLineNumberTextLineHeight(height: number): void

  setCodeBlockDividerColor(color: number): void

  setCodeBlockDividerStrokeWidth(strokeWidth: number): void

  setCodeBlockLineNumberDividerSpacing(spacing: number): void

  setCodeBlockTextFontColor(color: number): void

  setCodeBlockTextMarginRight(marginRight: number): void

  setCodeBlockTextMarginLeft(marginLeft: number): void

  setCodeBlockTextFontSize(size: number): void

  setCodeBlockTextFontStyle(style: number): void

  setCodeBlockTextFontWeight(weight: number): void

  setCodeBlockTextFontFamily(family: string): void

  setCodeBlockTextLineHeight(height: number): void

  setCodeBlockTextLetterSpacing(spacing: number): void

  setCodeBlockListTitleTextSize(size: number): void

  setCodeBlockListTitleSelectTextSize(size: number): void

  setCodeBlockListTitleSelectTextColor(color: number): void

  setCodeBlockListTitleUnselectTextColor(color: number): void

  setCodeBlockListTitleSelectBackgroundColor(color: number): void

  setCodeBlockListTitleUnselectBackgroundColor(color: number): void

  setCodeBlockIsSeparate(isSeparate: boolean): void

  setCodeBlockSeparateWidth(width: number): void

  setCodeBlockSeparateIsBottom(isBottom: boolean): void
}

export declare class CJMarkdownDefinitionListTheme {
  setDefinitionListAllMargin(margin: number): void

  setDefinitionListMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setDefinitionListAllPadding(padding: number): void

  setDefinitionListPadding(top?: number, right?: number, bottom?: number, left?: number): void

  setDefinitionListBackgroundColor(color: number): void

  setDefinitionListTermToDescriptionSpacing(spacing: number): void

  setDefinitionListTermTextFontWeight(weight: number): void

  setDefinitionListTermTextFontStyle(style: number): void

  setDefinitionListDescriptionItemSpacing(spacing: number): void

  setDefinitionListDescriptionIndent(indent: number): void
}

export declare class CJMarkdownDividerTheme {
  setDividerAllMargin(margin: number): void

  setDividerMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setDividerAllPadding(padding: number): void

  setDividerPadding(top?: number, right?: number, bottom?: number, left?: number): void

  setDividerColor(color: number): void

  setDividerStrokeWidth(strokeWidth: number): void

  setDividerStyle(style: number): void
}

export declare class CJMarkdownFootnoteDefTheme {
  setFootnoteDefBackgroundColor(color: number): void

  setFootnoteDefAllMargin(margin: number): void

  setFootnoteDefMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setFootnoteDefAllPadding(padding: number): void

  setFootnoteDefPadding(top?: number, right?: number, bottom?: number, left?: number): void
}

export declare class CJMarkdownFootnoteRefTheme {
  setFootnoteRefTextFontColor(color: number): void

  setFootnoteRefTextFontSize(size: number): void

  setFootnoteRefTextFontStyle(style: number): void

  setFootnoteRefTextFontWeight(weight: number): void

  setFootnoteRefTextFontFamily(family: string): void

  setFootnoteRefTextLineHeight(lineHeight: number): void

  setFootnoteRefTextLetterSpacing(spacing: number): void

  setFootnoteRefTextDecorationType(decorationType: number): void

  setFootnoteRefTextDecorationColor(color: number): void

  setFootnoteRefTextDecorationStyle(style: number): void

  setFootnoteRefTextBackgroundColor(color: number): void

  setFootnoteRefTextBackgroundAllRadius(radius: number): void

  setFootnoteRefTextBackgroundRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void
}

export declare class CJMarkdownHeadingTheme {
  setBackgroundColorForAllHeading(color: number): void

  setBackgroundColorForEachHeading(colorList: number[]): void

  setBackgroundColorForDesignateHeading(level: number, color: number): void

  setAllMarginForAllHeading(margin: number): void

  setMarginForAllHeadingEachLevel(top?: number, right?: number, bottom?: number, left?: number): void

  setMarginForEachHeading(marginList: number[]): void

  setAllMarginForDesignateHeading(level: number, margin: number): void

  setMarginForEachHeadingDetail(top: number[], right: number[], bottom: number[], left: number[]): void

  setMarginForDesignateHeading(level: number, top?: number, right?: number, bottom?: number, left?: number): void

  setAllPaddingForAllHeading(padding: number): void

  setPaddingForAllHeadingEachLevel(top?: number, right?: number, bottom?: number, left?: number): void

  setPaddingForEachHeading(paddingList: number[]): void

  setAllPaddingForDesignateHeading(level: number, padding: number): void

  setPaddingForEachHeadingDetail(top: number[], right: number[], bottom: number[], left: number[]): void

  setPaddingForDesignateHeading(level: number, top?: number, right?: number, bottom?: number, left?: number): void

  setTextFontColorForAllHeading(color: number): void

  setTextFontColorForEachHeading(colorList: number[]): void

  setTextFontColorForDesignateHeading(level: number, color: number): void

  setTextFontSizeForAllHeading(size: number): void

  setTextFontSizeForEachHeading(sizeList: number[]): void

  setTextFontSizeForDesignateHeading(level: number, size: number): void

  setTextFontStyleForAllHeading(style: number): void

  setTextFontStyleForEachHeading(styleList: number[]): void

  setTextFontStyleForDesignateHeading(level: number, style: number): void

  setTextFontWeightForAllHeading(weight: number): void

  setTextFontWeightForEachHeading(weightList: number[]): void

  setTextFontWeightForDesignateHeading(level: number, weight: number): void

  setTextFontFamilyForAllHeading(family: string): void

  setTextFontFamilyForEachHeading(familyList: string[]): void

  setTextFontFamilyForDesignateHeading(level: number, family: string): void

  setTextLineHeightForAllHeading(lineHeight: number): void

  setTextLineHeightForEachHeading(lineHeightList: number[]): void

  setTextLineHeightForDesignateHeading(level: number, lineHeight: number): void

  setTextLetterSpacingForAllHeading(spacing: number): void

  setTextLetterSpacingForEachHeading(spacingList: number[]): void

  setTextLetterSpacingForDesignateHeading(level: number, spacing: number): void

  setUnderlineHeightForAllHeading(height: number): void

  setUnderlineHeightForDesignateHeading(level: number, height: number): void

  setUnderlineColorForAllHeading(color: number): void

  setUnderlineColorForDesignateHeading(level: number, color: number): void

  setUnderlineSpacingForAllHeading(spacing: number): void

  setUnderlineSpacingForDesignateHeading(level: number, spacing: number): void
}

export declare class CJMarkdownHtmlUnderlineTheme {
  setHtmlUnderlineTextFontColor(color: number): void

  setHtmlUnderlineTextFontSize(size: number): void

  setHtmlUnderlineTextFontStyle(style: number): void

  setHtmlUnderlineTextFontWeight(weight: number): void

  setHtmlUnderlineTextFontFamily(family: string): void

  setHtmlUnderlineTextLineHeight(lineHeight: number): void

  setHtmlUnderlineTextLetterSpacing(spacing: number): void

  setHtmlUnderlineTextDecorationColor(color: number): void

  setHtmlUnderlineTextDecorationStyle(style: number): void
}

export declare class CJMarkdownImageTheme {
  setImageAllMargin(margin: number): void

  setImageMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setImageBorderAllRadius(radius: number): void

  setImageBorderRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setImageBorderStyle(borderStyle: number): void

  setImageBorderWidth(borderWidth: number): void

  setImageBorderColor(borderColor: number): void

  setImageAutoResize(imageAutoResize: boolean): void

  setIsImageMixedLayout(mixedLayout: boolean): void

  setImageMaximumWidth(maximumWidth: number): void

  setImageFixedRatioWidth(fixedRatioWidth: number): void

  setImageMaxHeight(maxHeight: number): void

  setImageHeight(height: number): void

  setImageMaxWidth(maxWidth: number): void

  setImageWidth(width: number): void

  setImageFitType(fitType: number): void

  setImageBottomLayoutMarginTop(marginTop: number): void

  setImageDownloadButtonVisible(visible: boolean): void

  setImageDownloadButtonWidth(width: number): void

  setImageDownloadButtonHeight(height: number): void

  setImageDownloadButtonAllRadius(radius: number): void

  setImageDownloadButtonRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setImageDownloadButtonIconWidth(width: number): void

  setImageDownloadButtonIconHeight(height: number): void

  setImageDownloadButtonIconTextGap(gap: number): void

  setImageDownloadButtonBackgroundColor(color: number): void

  setImageDownloadButtonText(text: string): void

  setImageDownloadButtonTextFontColor(color: number): void

  setImageDownloadButtonTextFontSize(size: number): void

  setImageDownloadButtonTextFontStyle(style: number): void

  setImageDownloadButtonTextFontWeight(weight: number): void

  setImageDownloadButtonTextFontFamily(family: string): void

  setImageDownloadButtonTextLineHeight(lineHeight: number): void
}

export declare class CJMarkdownInlineCodeTheme {
  setInlineCodeTextFontColor(color: number): void

  setInlineCodeTextFontSize(size: number): void

  setInlineCodeTextFontStyle(style: number): void

  setInlineCodeTextFontWeight(weight: number): void

  setInlineCodeTextFontFamily(family: string): void

  setInlineCodeTextLineHeight(lineHeight: number): void

  setInlineCodeTextLetterSpacing(spacing: number): void

  setInlineCodeTextBackgroundColor(color: number): void

  setInlineCodeTextBackgroundAllRadius(radius: number): void

  setInlineCodeTextBackgroundRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void
}

export declare class CJMarkdownItalicTheme {
  setItalicTextFontColor(color: number): void

  setItalicTextFontSize(size: number): void

  setItalicTextFontWeight(weight: number): void

  setItalicTextFontFamily(family: string): void

  setItalicTextLineHeight(lineHeight: number): void

  setItalicTextLetterSpacing(spacing: number): void
}

export declare class CJMarkdownLatexMathTheme {
  setLatexMathDefaultText(showDefaultText: boolean): void

  setLatexMathDefaultTextFontColor(color: number): void

  setLatexMathDefaultTextFontSize(size: number): void

  setLatexMathDefaultTextFontStyle(style: number): void

  setLatexMathDefaultTextFontWeight(weight: number): void

  setLatexMathDefaultTextFontFamily(family: string): void

  setLatexMathTextSize(size: number): void

  setLatexMathBackgroundColor(color: number): void

  setLatexMathTextColor(color: number): void

  setLatexMathColorFormat(format: number): void

  setLatexMathBlockCenter(center: boolean): void

  setLatexMathResPath(path: string): void

  setLatexMathAllMargin(margin: number): void

  setLatexMathMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setLatexMathAllPadding(padding: number): void

  setLatexMathPadding(top?: number, right?: number, bottom?: number, left?: number): void
}

export declare class CJMarkdownLinkTheme {
  setLinkIsIcon(isIcon: boolean): void

  setLinkListIsIcon(isIcon: boolean): void

  setLinkTextFontColor(color: number): void

  setLinkTextFontSize(size: number): void

  setLinkTextFontStyle(style: number): void

  setLinkTextFontWeight(weight: number): void

  setLinkTextFontFamily(family: string): void

  setLinkTextLineHeight(lineHeight: number): void

  setLinkTextLetterSpacing(spacing: number): void

  setLinkTextDecorationType(decorationType: number): void

  setLinkTextDecorationColor(color: number): void

  setLinkTextDecorationStyle(style: number): void

  setLinkTextBackgroundColor(color: number): void

  setLinkTextBackgroundAllRadius(radius: number): void

  setLinkTextBackgroundRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setLinkCircleIconBackgroundColor(color: number): void

  setLinkCircleIconButtonBackgroundColor(color: number): void

  setLinkCircleIconTextSize(size: number): void

  setLinkCircleIconTextColor(color: number): void

  setLinkCircleIconRadius(radius: number): void

  setLinkCircleIconMargin(margin: number): void

  setLinkRectIconBackgroundColor(color: number): void

  setLinkRectIconButtonBackgroundColor(color: number): void

  setLinkRectIconTextSize(size: number): void

  setLinkRectIconTextColor(color: number): void

  setLinkRectIconHeight(height: number): void

  setLinkRectIconPadding(padding: number): void

  setLinkRectIconRadius(radius: number): void

  setLinkRectIconMargin(margin: number): void

  setLinkRectToolIconBackgroundColor(color: number): void

  setLinkRectToolIconButtonBackgroundColor(color: number): void

  setLinkRectToolIconTextSize(size: number): void

  setLinkRectToolIconHeight(height: number): void

  setLinkRectToolIconPadding(padding: number): void

  setLinkRectToolIconBorderWidth(width: number): void

  setLinkRectToolIconDividingLineWidth(width: number): void

  setLinkRectToolIconMargin(margin: number): void

  setLinkRectToolIconLineLeftPadding(padding: number): void

  setLinkRectToolIconLineRightPadding(padding: number): void
}

export declare class CJMarkdownOrderedListTheme {
  setOrderedListBackgroundColor(color: number): void

  setOrderedListAllMargin(margin: number): void

  setOrderedListMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setOrderedListAllPadding(padding: number): void

  setOrderedListPadding(top?: number, right?: number, bottom?: number, left?: number): void

  setOrderedListChildSpacing(spacing: number): void

  setOrderedListChildChildSpacing(spacing: number): void

  setOrderedListMarkerSpacing(spacing: number): void

  setOrderedListMarkerTextFontColor(color: number): void

  setOrderedListMarkerTextFontSize(size: number): void

  setOrderedListMarkerTextFontStyle(style: number): void

  setOrderedListMarkerTextFontWeight(weight: number): void

  setOrderedListMarkerTextFontFamily(family: string): void

  setOrderedListMarkerTextLineHeight(lineHeight: number): void
}

export declare class CJMarkdownParagraphTheme {
  setParagraphBackgroundColor(color: number): void

  setParagraphAllMargin(margin: number): void

  setParagraphMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setParagraphAllPadding(padding: number): void

  setParagraphPadding(top?: number, right?: number, bottom?: number, left?: number): void

  setParagraphTextFontColor(color: number): void

  setParagraphTextFontSize(size: number): void

  setParagraphTextFontStyle(style: number): void

  setParagraphTextFontWeight(weight: number): void

  setParagraphTextFontFamily(family: string): void

  setParagraphTextLineHeight(lineHeight: number): void

  setParagraphTextLetterSpacing(spacing: number): void
}

export declare class CJMarkdownStrikethroughTheme {
  setStrikethroughTextFontColor(color: number): void

  setStrikethroughTextFontSize(size: number): void

  setStrikethroughTextFontStyle(style: number): void

  setStrikethroughTextFontWeight(weight: number): void

  setStrikethroughTextFontFamily(family: string): void

  setStrikethroughTextLineHeight(lineHeight: number): void

  setStrikethroughTextLetterSpacing(spacing: number): void

  setStrikethroughTextDecorationColor(color: number): void

  setStrikethroughTextDecorationStyle(style: number): void
}

export declare class CJMarkdownSubTheme {
  setSubTextFontColor(color: number): void

  setSubTextFontSize(size: number): void

  setSubTextFontStyle(style: number): void

  setSubTextFontWeight(weight: number): void

  setSubTextFontFamily(family: string): void

  setSubTextLetterSpacing(spacing: number): void

  setSubTextBaselineOffset(offset: number): void
}

export declare class CJMarkdownSupTheme {
  setSupTextFontColor(color: number): void

  setSupTextFontSize(size: number): void

  setSupTextFontStyle(style: number): void

  setSupTextFontWeight(weight: number): void

  setSupTextFontFamily(family: string): void

  setSupTextLetterSpacing(spacing: number): void

  setSupTextBaselineOffset(offset: number): void
}

export declare class CJMarkdownTableTheme {
  setTableTitleBackgroundColor(color: number): void

  setTableContentOddRowBackgroundColor(color: number): void

  setTableContentEvenRowBackgroundColor(color: number): void

  setTableAllMargin(margin: number): void

  setTableMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setTableAllPadding(padding: number): void

  setTablePadding(top?: number, right?: number, bottom?: number, left?: number): void

  setTableCellAllPadding(padding: number): void

  setTableCellPadding(top?: number, right?: number, bottom?: number, left?: number): void

  setTableBorderStyle(style: number): void

  setTableBorderWidth(width: number): void

  setTableBorderColor(color: number): void

  setTableAllRadius(radius: number): void

  setTableRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setTableScrollBarState(state: number): void

  setTableScrollBarColor(color: number): void

  setTableMinCellWidth(width: number): void

  setTableMaxCellWidth(width: number): void

  setTableFirstColumnIsBold(isBold: boolean): void

  setTableTitleTextFontColor(color: number): void

  setTableTitleTextFontSize(size: number): void

  setTableTitleTextFontStyle(style: number): void

  setTableTitleTextFontWeight(weight: number): void

  setTableTitleTextFontFamily(family: string): void

  setTableTitleTextLineHeight(lineHeight: number): void

  setTableTitleTextLetterSpacing(spacing: number): void

  setTableContentTextFontColor(color: number): void

  setTableContentTextFontSize(size: number): void

  setTableContentTextFontStyle(style: number): void

  setTableContentTextFontWeight(weight: number): void

  setTableContentTextFontFamily(family: string): void

  setTableContentTextLineHeight(lineHeight: number): void

  setTableContentTextLetterSpacing(spacing: number): void
}

export declare class CJMarkdownVideoTheme {
  setVideoBackgroundColor(color: number): void

  setVideoAllMargin(margin: number): void

  setVideoMargin(top?: number, right?: number, bottom?: number, left?: number): void

  setVideoAllPadding(padding: number): void

  setVideoPadding(top?: number, right?: number, bottom?: number, left?: number): void

  setVideoBorderAllRadius(radius: number): void

  setVideoBorderRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setVideoBorderStyle(borderStyle: number): void

  setVideoBorderWidth(borderWidth: number): void

  setVideoBorderColor(borderColor: number): void

  setVideoImageFitType(fitType: number): void

  setVideoTimeTextFontColor(color: number): void

  setVideoTimeTextFontSize(size: number): void

  setVideoTimeTextFontStyle(style: number): void

  setVideoTimeTextFontWeight(weight: number): void

  setVideoTimeTextFontFamily(family: string): void

  setVideoTimeTextLineHeight(lineHeight: number): void

  setVideoTimeTextMarginRight(margin: number): void

  setVideoTimeTextMarginBottom(margin: number): void

  setVideoBottomLayoutVisible(visible: boolean): void

  setVideoBottomLayoutMarginTop(marginTop: number): void

  setVideoPlayIconWidth(width: number): void

  setVideoPlayIconHeight(height: number): void

  setVideoPlayIconFitType(fitType: number): void

  setVideoReleaseButtonVisible(visible: boolean): void

  setVideoReleaseButtonBackgroundColor(color: number): void

  setVideoReleaseButtonWidth(width: number): void

  setVideoReleaseButtonHeight(height: number): void

  setVideoReleaseButtonAllRadius(radius: number): void

  setVideoReleaseButtonRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setVideoReleaseButtonIconWidth(width: number): void

  setVideoReleaseButtonIconHeight(height: number): void

  setVideoReleaseButtonIconTextGap(gap: number): void

  setVideoReleaseButtonText(text: string): void

  setVideoReleaseButtonTextFontColor(color: number): void

  setVideoReleaseButtonTextFontSize(size: number): void

  setVideoReleaseButtonTextFontStyle(style: number): void

  setVideoReleaseButtonTextFontWeight(weight: number): void

  setVideoReleaseButtonTextFontFamily(family: string): void

  setVideoReleaseButtonTextLineHeight(lineHeight: number): void

  setVideoDownloadButtonVisible(visible: boolean): void

  setVideoDownloadButtonBackgroundColor(color: number): void

  setVideoDownloadButtonWidth(width: number): void

  setVideoDownloadButtonHeight(height: number): void

  setVideoDownloadButtonAllRadius(radius: number): void

  setVideoDownloadButtonRadius(topLeft?: number, topRight?: number, bottomLeft?: number, bottomRight?: number): void

  setVideoDownloadButtonIconWidth(width: number): void

  setVideoDownloadButtonIconHeight(height: number): void

  setVideoDownloadButtonIconTextGap(gap: number): void

  setVideoDownloadButtonText(text: string): void

  setVideoDownloadButtonTextFontColor(color: number): void

  setVideoDownloadButtonTextFontSize(size: number): void

  setVideoDownloadButtonTextFontStyle(style: number): void

  setVideoDownloadButtonTextFontWeight(weight: number): void

  setVideoDownloadButtonTextFontFamily(family: string): void

  setVideoDownloadButtonTextLineHeight(lineHeight: number): void
}

export declare class CJMarkdownConfig {
  setLinkCallback(cb: (funcArg0: string) => void): void

  setTextCopyCallback(cb: (funcArg0: string) => void): void

  setImageCallback(cb: (funcArg0: string, funcArg1: Array<string>) => void): void

  setImageDownloadCallback(cb: (string) => void): void

  setAudioCallback(cb: (funcArg0: string) => void): void

  setVideoCallback(cb: (funcArg0: string, funcArg1: Array<string>) => void): void

  setVideoImageCallback(cb: (funcArg0: string, funcArg1: (funcArg0: string, funcArg1: number, funcArg2: number) => void) => void): void

  setVideoReleaseCallback(cb: (funcArg0: string) => void): void

  setVideoDownloadCallback(cb: (funcArg0: string) => void): void

  setCodeCopyCallback(cb: (funcArg0: string) => void): void

  setCodeFullScreenCallback(cb: (funcArg0: string, funcArg1: string | undefined) => void): void

  setLatexImageCallback(cb: (funcArg0: ArrayBuffer, funcArg1: number, funcArg2: number) => void): void

  setLatexStrCallback(cb: (funcArg0: string) => string): void

  setTocIndexCallback(cb: (funcArg0: number | undefined) => void): void

  setFootnoteCallback(cb: (funcArg0: number | undefined) => void): void

  setNodeString(nodeString: CJNodeViewStringBuilder): void

  setCJMarkdownTheme(cjMarkdownTheme: CJMarkdownTheme): void
}

export declare class CJNodeViewStringBuilder {
  toString(): string
}

export declare class CJMarkdownScroller {

  scrollBy(xOffset: number, yOffset: number): void

  scrollToIndex(value: number): void

  scrollEdge(value: number): void

  isAtEnd(): boolean

  getItemRect(index: number): CJRectResult

  currentYOffset(): number
}

export declare class CJRectResult {
  getItemRectX(): number

  getItemRectY(): number

  getItemRectWidth(): number

  getItemRectHeight(): number
}

export declare interface CustomLib {
  CJMarkdownConfig: {new (): CJMarkdownConfig}

  CJMarkdownPlugin: {new (): CJMarkdownPlugin}

  CJNodeViewStringBuilder: {new (): CJNodeViewStringBuilder}

  CJMarkdownScroller: {new (): CJMarkdownScroller}

  CJRectResult: {new (x: number, y: number, width: number, height: number): CJRectResult}

  CJMarkdownTheme: {new (): CJMarkdownTheme}

  CJMarkdownGlobalTheme: {new (): CJMarkdownGlobalTheme}

  CJMarkdownAudioTheme: {new (): CJMarkdownAudioTheme}

  CJMarkdownBannerTheme: {new (): CJMarkdownBannerTheme}

  CJMarkdownBlockQuoteTheme: {new (): CJMarkdownBlockQuoteTheme}

  CJMarkdownBoldTheme: {new (): CJMarkdownBoldTheme}

  CJMarkdownBulletListTheme: {new (): CJMarkdownBulletListTheme}

  CJMarkdownCodeBlockTheme: {new (): CJMarkdownCodeBlockTheme}

  CJMarkdownDefinitionListTheme: {new (): CJMarkdownDefinitionListTheme}

  CJMarkdownDividerTheme: {new (): CJMarkdownDividerTheme}

  CJMarkdownFootnoteDefTheme: {new (): CJMarkdownFootnoteDefTheme}

  CJMarkdownFootnoteRefTheme: {new (): CJMarkdownFootnoteRefTheme}

  CJMarkdownHeadingTheme: {new (): CJMarkdownHeadingTheme}

  CJMarkdownHtmlUnderlineTheme: {new (): CJMarkdownHtmlUnderlineTheme}

  CJMarkdownImageTheme: {new (): CJMarkdownImageTheme}

  CJMarkdownInlineCodeTheme: {new (): CJMarkdownInlineCodeTheme}

  CJMarkdownItalicTheme: {new (): CJMarkdownItalicTheme}

  CJMarkdownLatexMathTheme: {new (): CJMarkdownLatexMathTheme}

  CJMarkdownLinkTheme: {new (): CJMarkdownLinkTheme}

  CJMarkdownOrderedListTheme: {new (): CJMarkdownOrderedListTheme}

  CJMarkdownParagraphTheme: {new (): CJMarkdownParagraphTheme}

  CJMarkdownStrikethroughTheme: {new (): CJMarkdownStrikethroughTheme}

  CJMarkdownSubTheme: {new (): CJMarkdownSubTheme}

  CJMarkdownSupTheme: {new (): CJMarkdownSupTheme}

  CJMarkdownTableTheme: {new (): CJMarkdownTableTheme}

  CJMarkdownVideoTheme: {new (): CJMarkdownVideoTheme}

  setGlobalContext(context?: Context): void

  getLoadCJPage(mdStr: string, isInputEnded: boolean, incrementalAnalysis: boolean, cfg: CJMarkdownConfig, plugin: CJMarkdownPlugin, listScroller?: CJMarkdownScroller): (input: string, isInputEnded: boolean, incrementalAnalysis: boolean) => void

  registerImgPreprocessCallback(cb?: (url: string) => Promise<ArrayBuffer|undefined>): void

  getCJResource(
    codeFullScreenIcon?: resourceManager.Resource,
    codeCopyIcon?: resourceManager.Resource,
    audioIcon?: resourceManager.Resource,
    videoImage?: resourceManager.Resource,
    playCircleFillIcon?: resourceManager.Resource,
    bannerImage?: resourceManager.Resource,
    imageResource?: resourceManager.Resource,
    videoReleaseImage?: resourceManager.Resource,
    videoDownloadImage?: resourceManager.Resource,
    imageDownloadImage?: resourceManager.Resource,
  ): void
}