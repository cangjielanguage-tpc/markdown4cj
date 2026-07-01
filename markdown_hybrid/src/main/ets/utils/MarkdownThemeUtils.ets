import { GlobalTheme } from "../theme/GlobalTheme"
import { BlockQuoteTheme } from "../theme/BlockQuoteTheme"
import { HeadingTheme } from "../theme/HeadingTheme"
import { NodeView } from "../model/NodeView"
import { SubTheme } from "../theme/SubTheme"
import { InlineCodeTheme } from "../theme/InlineCodeTheme"
import { SupTheme } from "../theme/SupTheme"
import { BoldTheme } from "../theme/BoldTheme"
import { ItalicTheme } from "../theme/ItalicTheme"
import { StrikethroughTheme } from "../theme/StrikethroughTheme"
import { HighlightTheme } from "../theme/HighlightTheme"
import { HtmlUnderlineTheme } from "../theme/HtmlUnderlineTheme"
import { LinkTheme } from "../theme/LinkTheme"
import { FootnoteRefTheme } from "../theme/FootnoteRefTheme"
import { TableTheme } from "../theme/TableTheme"
import { ParagraphTheme } from "../theme/ParagraphTheme"
import { DefinitionListTheme } from "../theme/DefinitionListTheme"
import { LengthUnit } from "@kit.ArkUI"
import { COLOR_TRANSPARENT } from "../base/Constants"
import { OrderedListTheme } from "../theme/OrderedListTheme"
import { BulletListTheme } from "../theme/BulletListTheme"
import { FootnoteDefTheme } from "../theme/FootnoteDefTheme"

/**
 * 获取文本字体族
 *
 * @param nodeView NodeView
 * @param subTheme 下标样式
 * @param supTheme 上标样式
 * @param inlineCodeTheme 内联代码样式
 * @param boldTheme 加粗样式
 * @param italicTheme 斜体样式
 * @param strikethroughTheme 删除线样式
 * @param highlightTheme 高亮样式
 * @param htmlUnderlineTheme 下划线样式
 * @param linkTheme 链接样式
 * @param footnoteRefTheme 脚注引用样式
 * @param headingTheme 标题样式
 * @param tableTheme 表格样式
 * @param paragraphTheme 段落样式
 * @return 文本字体族
 */
export function spanFontFamily(
  nodeView: NodeView,
  subTheme: SubTheme,
  supTheme: SupTheme,
  inlineCodeTheme: InlineCodeTheme,
  boldTheme: BoldTheme,
  italicTheme: ItalicTheme,
  strikethroughTheme: StrikethroughTheme,
  highlightTheme: HighlightTheme,
  htmlUnderlineTheme: HtmlUnderlineTheme,
  linkTheme: LinkTheme,
  footnoteRefTheme: FootnoteRefTheme,
  headingTheme: HeadingTheme,
  tableTheme: TableTheme,
  paragraphTheme: ParagraphTheme
): string | Resource {
  if (nodeView.isSubNode && subTheme.subTextFontFamily !== undefined) {
    return subTheme.subTextFontFamily! // 下标
  }
  if (nodeView.isSupNode && supTheme.supTextFontFamily !== undefined) {
    return supTheme.supTextFontFamily! // 上标
  }
  if (nodeView.isInLineCode && inlineCodeTheme.inlineCodeTextFontFamily !== undefined) {
    return inlineCodeTheme.inlineCodeTextFontFamily! // 内联代码
  }
  if (nodeView.isStrongEmphasis && boldTheme.boldTextFontFamily !== undefined) {
    return boldTheme.boldTextFontFamily! // 加粗
  }
  if (nodeView.isEmphasis && italicTheme.italicTextFontFamily !== undefined) {
    return italicTheme.italicTextFontFamily! // 斜体
  }
  if (nodeView.isStrikethrough &&
    strikethroughTheme.strikethroughTextFontFamily !== undefined) {
    return strikethroughTheme.strikethroughTextFontFamily! // 删除线
  }
  if (nodeView.isHighlight && highlightTheme.highlightTextFontFamily !== undefined) {
    return highlightTheme.highlightTextFontFamily! // 高亮
  }
  if (nodeView.isUnderlineNode &&
    htmlUnderlineTheme.htmlUnderlineTextFontFamily !== undefined) {
    return htmlUnderlineTheme.htmlUnderlineTextFontFamily! // 下划线
  }
  if (nodeView.isLink && linkTheme.linkTextFontFamily !== undefined) {
    return linkTheme.linkTextFontFamily! // 链接
  }
  if (nodeView.isFootnote && footnoteRefTheme.footnoteRefTextFontFamily !== undefined) {
    return footnoteRefTheme.footnoteRefTextFontFamily! // 脚注引用
  }
  if (nodeView.isHeading) {
    return headingFontFamily(nodeView.headingLevel, headingTheme) // 标题
  }
  if (nodeView.isTable) {
    if (nodeView.isTableHead) {
      return tableTheme.tableTitleTextFontFamily // 表格标题
    }
    return tableTheme.tableContentTextFontFamily // 表格内容
  }
  return paragraphTheme.paragraphTextFontFamily // 段落
}

/**
 * 获取不同等级标题文本字体族
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题文本字体族
 */
export function headingFontFamily(
  level: number,
  headingTheme: HeadingTheme
): string | Resource {
  switch (level) {
    case 1:
      return headingTheme.heading1TextFontFamily
    case 2:
      return headingTheme.heading2TextFontFamily
    case 3:
      return headingTheme.heading3TextFontFamily
    case 4:
      return headingTheme.heading4TextFontFamily
    case 5:
      return headingTheme.heading5TextFontFamily
    case 6:
      return headingTheme.heading6TextFontFamily
    default:
      return headingTheme.heading6TextFontFamily
  }
}


/**
 * 获取文本字体大小
 *
 * @param nodeView NodeView
 * @param subTheme 下标样式
 * @param supTheme 上标样式
 * @param inlineCodeTheme 内联代码样式
 * @param boldTheme 加粗样式
 * @param italicTheme 斜体样式
 * @param strikethroughTheme 删除线样式
 * @param highlightTheme 高亮样式
 * @param htmlUnderlineTheme 下划线样式
 * @param linkTheme 链接样式
 * @param footnoteRefTheme 脚注引用样式
 * @param headingTheme 标题样式
 * @param tableTheme 表格样式
 * @param paragraphTheme 段落样式
 * @return 文本字体大小
 */
export function spanFontSize(
  nodeView: NodeView,
  subTheme: SubTheme,
  supTheme: SupTheme,
  inlineCodeTheme: InlineCodeTheme,
  boldTheme: BoldTheme,
  italicTheme: ItalicTheme,
  strikethroughTheme: StrikethroughTheme,
  highlightTheme: HighlightTheme,
  htmlUnderlineTheme: HtmlUnderlineTheme,
  linkTheme: LinkTheme,
  footnoteRefTheme: FootnoteRefTheme,
  headingTheme: HeadingTheme,
  tableTheme: TableTheme,
  paragraphTheme: ParagraphTheme
): number | string | Resource {
  if (nodeView.isSubNode) {
    return subTheme.subTextFontSize // 下标
  }
  if (nodeView.isSupNode) {
    return supTheme.supTextFontSize // 上标
  }
  if (nodeView.isFontNode && nodeView.fontNodeSize !== undefined) {
    return nodeView.fontNodeSize // FontNode
  }
  if (nodeView.isSpanNode && nodeView.spanNodeSize !== undefined) {
    return nodeView.spanNodeSize // SpanNode
  }
  if (nodeView.isInLineCode && inlineCodeTheme.inlineCodeTextFontSize !== undefined) {
    return inlineCodeTheme.inlineCodeTextFontSize! // 内联代码
  }
  if (nodeView.isStrongEmphasis && boldTheme.boldTextFontSize !== undefined) {
    return boldTheme.boldTextFontSize! // 加粗
  }
  if (nodeView.isEmphasis && italicTheme.italicTextFontSize !== undefined) {
    return italicTheme.italicTextFontSize! // 斜体
  }
  if (nodeView.isStrikethrough && strikethroughTheme.strikethroughTextFontSize !== undefined) {
    return strikethroughTheme.strikethroughTextFontSize! // 删除线
  }
  if (nodeView.isHighlight && highlightTheme.highlightTextFontSize !== undefined) {
    return highlightTheme.highlightTextFontSize! // 高亮
  }
  if (nodeView.isUnderlineNode && htmlUnderlineTheme.htmlUnderlineTextFontSize !== undefined) {
    return htmlUnderlineTheme.htmlUnderlineTextFontSize! // 下划线
  }
  if (nodeView.isLink && linkTheme.linkTextFontSize !== undefined) {
    return linkTheme.linkTextFontSize! // 链接
  }
  if (nodeView.isFootnote && footnoteRefTheme.footnoteRefTextFontSize !== undefined) {
    return footnoteRefTheme.footnoteRefTextFontSize! // 脚注引用
  }
  if (nodeView.isHeading) {
    return headingTextSize(nodeView.headingLevel, headingTheme) // 标题
  }
  if (nodeView.isTable) {
    if (nodeView.isTableHead) {
      return tableTheme.tableTitleTextFontSize // 表格标题
    }
    return tableTheme.tableContentTextFontSize // 表格内容
  }
  return paragraphTheme.paragraphTextFontSize // 段落
}

/**
 * 获取不同等级标题文本字体大小
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题文本字体大小
 */
export function headingTextSize(
  level: number,
  headingTheme: HeadingTheme
): number | string | Resource {
  switch (level) {
    case 1:
      return headingTheme.heading1TextFontSize
    case 2:
      return headingTheme.heading2TextFontSize
    case 3:
      return headingTheme.heading3TextFontSize
    case 4:
      return headingTheme.heading4TextFontSize
    case 5:
      return headingTheme.heading5TextFontSize
    case 6:
      return headingTheme.heading6TextFontSize
    default:
      return headingTheme.heading6TextFontSize
  }
}

/**
 * 获取文本的字体粗细
 *
 * @param nodeView NodeView
 * @param isTableFirst 表格第一列是否加粗
 * @param subTheme 下标样式
 * @param supTheme 上标样式
 * @param inlineCodeTheme 内联代码样式
 * @param boldTheme 加粗样式
 * @param italicTheme 斜体样式
 * @param strikethroughTheme 删除线样式
 * @param highlightTheme 高亮样式
 * @param htmlUnderlineTheme 下划线样式
 * @param linkTheme 链接样式
 * @param footnoteRefTheme 脚注引用样式
 * @param headingTheme 标题样式
 * @param tableTheme 表格样式
 * @param paragraphTheme 段落样式
 * @param definitionListTheme 定义列表样式
 * @return 文本的字体粗细
 */
export function spanFontWeight(
  nodeView: NodeView,
  isTableFirst: boolean,
  subTheme: SubTheme,
  supTheme: SupTheme,
  inlineCodeTheme: InlineCodeTheme,
  boldTheme: BoldTheme,
  italicTheme: ItalicTheme,
  strikethroughTheme: StrikethroughTheme,
  highlightTheme: HighlightTheme,
  htmlUnderlineTheme: HtmlUnderlineTheme,
  linkTheme: LinkTheme,
  footnoteRefTheme: FootnoteRefTheme,
  headingTheme: HeadingTheme,
  tableTheme: TableTheme,
  paragraphTheme: ParagraphTheme,
  definitionListTheme: DefinitionListTheme
): number | FontWeight {
  if (nodeView.isSpanNode) {
    if (nodeView.spanNodeWeight !== undefined) {
      return nodeView.spanNodeWeight // SpanNode
    }
  }
  if (nodeView.isSubNode && subTheme.subTextFontWeight !== undefined) {
    return subTheme.subTextFontWeight! // 下标
  }
  if (nodeView.isSupNode && supTheme.supTextFontWeight !== undefined) {
    return supTheme.supTextFontWeight! // 上标
  }
  if (nodeView.isInLineCode && inlineCodeTheme.inlineCodeTextFontWeight !== undefined) {
    return inlineCodeTheme.inlineCodeTextFontWeight! // 内联代码
  }
  if (nodeView.isStrongEmphasis) {
    return boldTheme.boldTextFontWeight // 加粗
  }
  if (nodeView.isEmphasis && italicTheme.italicTextFontWeight !== undefined) {
    return italicTheme.italicTextFontWeight! // 斜体
  }
  if (nodeView.isStrikethrough &&
    strikethroughTheme.strikethroughTextFontWeight !== undefined) {
    return strikethroughTheme.strikethroughTextFontWeight! // 删除线
  }
  if (nodeView.isHighlight && highlightTheme.highlightTextFontWeight !== undefined) {
    return highlightTheme.highlightTextFontWeight! // 高亮
  }
  if (nodeView.isUnderlineNode &&
    htmlUnderlineTheme.htmlUnderlineTextFontWeight !== undefined) {
    return htmlUnderlineTheme.htmlUnderlineTextFontWeight! // 下划线
  }
  if (nodeView.isLink && linkTheme.linkTextFontWeight !== undefined) {
    return linkTheme.linkTextFontWeight! // 链接
  }
  if (nodeView.isFootnote && footnoteRefTheme.footnoteRefTextFontWeight !== undefined) {
    return footnoteRefTheme.footnoteRefTextFontWeight! // 脚注引用
  }
  if (nodeView.isHeading) {
    return headingFontWeight(nodeView.headingLevel, headingTheme) // 标题
  }
  if (nodeView.isTable) {
    if (nodeView.isTableHead || isTableFirst) {
      return tableTheme.tableTitleTextFontWeight // 表格标题
    }
    return tableTheme.tableContentTextFontWeight // 表格内容
  }
  if (nodeView.isDescTerm) {
    return definitionListTheme.definitionListTermTextFontWeight // 定义列表术语
  }
  return paragraphTheme.paragraphTextFontWeight // 段落
}

/**
 * 获取不同等级标题文本的字体粗细
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题文本的字体粗细
 */
export function headingFontWeight(
  level: number,
  headingTheme: HeadingTheme
): number | FontWeight {
  switch (level) {
    case 1:
      return headingTheme.heading1TextFontWeight
    case 2:
      return headingTheme.heading2TextFontWeight
    case 3:
      return headingTheme.heading3TextFontWeight
    case 4:
      return headingTheme.heading4TextFontWeight
    case 5:
      return headingTheme.heading5TextFontWeight
    case 6:
      return headingTheme.heading6TextFontWeight
    default:
      return headingTheme.heading6TextFontWeight
  }
}

/**
 * 获取文本字体样式
 *
 * @param nodeView NodeView
 * @param subTheme 下标样式
 * @param supTheme 上标样式
 * @param inlineCodeTheme 内联代码样式
 * @param boldTheme 加粗样式
 * @param strikethroughTheme 删除线样式
 * @param highlightTheme 高亮样式
 * @param htmlUnderlineTheme 下划线样式
 * @param linkTheme 链接样式
 * @param footnoteRefTheme 脚注引用样式
 * @param headingTheme 标题样式
 * @param tableTheme 表格样式
 * @param paragraphTheme 段落样式
 * @param definitionListTheme 定义列表样式
 * @return 文本字体样式
 */
export function spanFontStyle(
  nodeView: NodeView,
  subTheme: SubTheme,
  supTheme: SupTheme,
  inlineCodeTheme: InlineCodeTheme,
  boldTheme: BoldTheme,
  strikethroughTheme: StrikethroughTheme,
  highlightTheme: HighlightTheme,
  htmlUnderlineTheme: HtmlUnderlineTheme,
  linkTheme: LinkTheme,
  footnoteRefTheme: FootnoteRefTheme,
  headingTheme: HeadingTheme,
  tableTheme: TableTheme,
  paragraphTheme: ParagraphTheme,
  definitionListTheme: DefinitionListTheme
): FontStyle {
  if (nodeView.isSubNode && subTheme.subTextFontStyle !== undefined) {
    return subTheme.subTextFontStyle! // 下标
  }
  if (nodeView.isSupNode && supTheme.supTextFontStyle !== undefined) {
    return supTheme.supTextFontStyle! // 上标
  }
  if (nodeView.isInLineCode && inlineCodeTheme.inlineCodeTextFontStyle !== undefined) {
    return inlineCodeTheme.inlineCodeTextFontStyle! // 内联代码
  }
  if (nodeView.isStrongEmphasis && boldTheme.boldTextFontStyle !== undefined) {
    return boldTheme.boldTextFontStyle! // 加粗
  }
  if (nodeView.isEmphasis) {
    return FontStyle.Italic // 斜体
  }
  if (nodeView.isStrikethrough && strikethroughTheme.strikethroughTextFontStyle !== undefined) {
    return strikethroughTheme.strikethroughTextFontStyle! // 删除线
  }
  if (nodeView.isHighlight && highlightTheme.highlightTextFontStyle !== undefined) {
    return highlightTheme.highlightTextFontStyle! // 高亮
  }
  if (nodeView.isUnderlineNode && htmlUnderlineTheme.htmlUnderlineTextFontStyle !== undefined) {
    return htmlUnderlineTheme.htmlUnderlineTextFontStyle! // 下划线
  }
  if (nodeView.isLink && linkTheme.linkTextFontStyle !== undefined) {
    return linkTheme.linkTextFontStyle! // 链接
  }
  if (nodeView.isFootnote && footnoteRefTheme.footnoteRefTextFontStyle !== undefined) {
    return footnoteRefTheme.footnoteRefTextFontStyle! // 脚注引用
  }
  if (nodeView.isHeading) {
    return headingFontStyle(nodeView.headingLevel, headingTheme) // 标题
  }
  if (nodeView.isTable) {
    if (nodeView.isTableHead) {
      return tableTheme.tableTitleTextFontStyle // 表格标题
    }
    return tableTheme.tableContentTextFontStyle // 表格内容
  }
  if (nodeView.isDescTerm) {
    return definitionListTheme.definitionListTermTextFontStyle // 定义列表术语
  }
  return paragraphTheme.paragraphTextFontStyle // 段落
}

/**
 * 获取不同等级标题文本字体样式
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题文本字体样式
 */
export function headingFontStyle(
  level: number,
  headingTheme: HeadingTheme
): FontStyle {
  switch (level) {
    case 1:
      return headingTheme.heading1TextFontStyle
    case 2:
      return headingTheme.heading2TextFontStyle
    case 3:
      return headingTheme.heading3TextFontStyle
    case 4:
      return headingTheme.heading4TextFontStyle
    case 5:
      return headingTheme.heading5TextFontStyle
    case 6:
      return headingTheme.heading6TextFontStyle
    default:
      return headingTheme.heading6TextFontStyle
  }
}

/**
 * 获取文本字体颜色
 *
 * @param nodeView NodeView
 * @param subTheme 下标样式
 * @param supTheme 上标样式
 * @param inlineCodeTheme 内联代码样式
 * @param boldTheme 加粗样式
 * @param italicTheme 斜体样式
 * @param strikethroughTheme 删除线样式
 * @param highlightTheme 高亮样式
 * @param htmlUnderlineTheme 下划线样式
 * @param linkTheme 链接样式
 * @param footnoteRefTheme 脚注引用样式
 * @param headingTheme 标题样式
 * @param tableTheme 表格样式
 * @param paragraphTheme 段落样式
 * @return 文本字体颜色
 */
export function spanFontColor(
  nodeView: NodeView,
  subTheme: SubTheme,
  supTheme: SupTheme,
  inlineCodeTheme: InlineCodeTheme,
  boldTheme: BoldTheme,
  italicTheme: ItalicTheme,
  strikethroughTheme: StrikethroughTheme,
  highlightTheme: HighlightTheme,
  htmlUnderlineTheme: HtmlUnderlineTheme,
  linkTheme: LinkTheme,
  footnoteRefTheme: FootnoteRefTheme,
  headingTheme: HeadingTheme,
  tableTheme: TableTheme,
  paragraphTheme: ParagraphTheme
): ResourceColor {
  if (nodeView.isSubNode && subTheme.subTextFontColor !== undefined) {
    return subTheme.subTextFontColor! // 下标
  }
  if (nodeView.isSupNode && supTheme.supTextFontColor !== undefined) {
    return supTheme.supTextFontColor! // 上标
  }
  if (nodeView.isFontNode && nodeView.fontNodeColor !== undefined) {
    return nodeView.fontNodeColor // FontNode
  }
  if (nodeView.isSpanNode && nodeView.spanNodeColor !== undefined) {
    return nodeView.spanNodeColor // SpanNode
  }
  if (nodeView.isInLineCode && inlineCodeTheme.inlineCodeTextFontColor !== undefined) {
    return inlineCodeTheme.inlineCodeTextFontColor! // 内联代码
  }
  if (nodeView.isStrongEmphasis && boldTheme.boldTextFontColor !== undefined) {
    return boldTheme.boldTextFontColor! // 加粗
  }
  if (nodeView.isEmphasis && italicTheme.italicTextFontColor !== undefined) {
    return italicTheme.italicTextFontColor! // 斜体
  }
  if (nodeView.isStrikethrough && strikethroughTheme.strikethroughTextFontColor !== undefined) {
    return strikethroughTheme.strikethroughTextFontColor! // 删除线
  }
  if (nodeView.isHighlight && highlightTheme.highlightTextFontColor !== undefined) {
    return highlightTheme.highlightTextFontColor! // 高亮
  }
  if (nodeView.isUnderlineNode && htmlUnderlineTheme.htmlUnderlineTextFontColor !== undefined) {
    return htmlUnderlineTheme.htmlUnderlineTextFontColor! // 下划线
  }
  if (nodeView.isLink) {
    return linkTheme.linkTextFontColor // 链接
  }
  if (nodeView.isFootnote) {
    return footnoteRefTheme.footnoteRefTextFontColor // 脚注引用
  }
  if (nodeView.isHeading) {
    return headColor(nodeView.headingLevel, headingTheme) // 标题
  }
  if (nodeView.isTable) {
    if (nodeView.isTableHead) {
      return tableTheme.tableTitleTextFontColor // 表格标题
    }
    return tableTheme.tableContentTextFontColor // 表格内容
  }
  return paragraphTheme.paragraphTextFontColor // 段落和其他
}

/**
 * 获取不同等级标题文本字体颜色
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题文本字体颜色
 */
export function headColor(
  level: number,
  headingTheme: HeadingTheme
): ResourceColor {
  switch (level) {
    case 1:
      return headingTheme.heading1TextFontColor
    case 2:
      return headingTheme.heading2TextFontColor
    case 3:
      return headingTheme.heading3TextFontColor
    case 4:
      return headingTheme.heading4TextFontColor
    case 5:
      return headingTheme.heading5TextFontColor
    case 6:
      return headingTheme.heading6TextFontColor
    default:
      return headingTheme.heading6TextFontColor
  }
}

/**
 * 获取文本字符间距
 *
 * @param nodeView NodeView
 * @param subTheme 下标样式
 * @param supTheme 上标样式
 * @param inlineCodeTheme 内联代码样式
 * @param boldTheme 加粗样式
 * @param italicTheme 斜体样式
 * @param strikethroughTheme 删除线样式
 * @param highlightTheme 高亮样式
 * @param htmlUnderlineTheme 下划线样式
 * @param linkTheme 链接样式
 * @param footnoteRefTheme 脚注引用样式
 * @param headingTheme 标题样式
 * @param tableTheme 表格样式
 * @param paragraphTheme 段落样式
 * @return 文本字符间距
 */
export function spanLetterSpacing(
  nodeView: NodeView,
  subTheme: SubTheme,
  supTheme: SupTheme,
  inlineCodeTheme: InlineCodeTheme,
  boldTheme: BoldTheme,
  italicTheme: ItalicTheme,
  strikethroughTheme: StrikethroughTheme,
  highlightTheme: HighlightTheme,
  htmlUnderlineTheme: HtmlUnderlineTheme,
  linkTheme: LinkTheme,
  footnoteRefTheme: FootnoteRefTheme,
  headingTheme: HeadingTheme,
  tableTheme: TableTheme,
  paragraphTheme: ParagraphTheme
): number {
  if (nodeView.isSubNode && subTheme.subTextLetterSpacing !== undefined) {
    return subTheme.subTextLetterSpacing! // 下标
  }
  if (nodeView.isSupNode && supTheme.supTextLetterSpacing !== undefined) {
    return supTheme.supTextLetterSpacing! // 上标
  }
  if (nodeView.isInLineCode && inlineCodeTheme.inlineCodeTextLetterSpacing !== undefined) {
    return inlineCodeTheme.inlineCodeTextLetterSpacing! // 内联代码
  }
  if (nodeView.isStrongEmphasis && boldTheme.boldTextLetterSpacing !== undefined) {
    return boldTheme.boldTextLetterSpacing! // 加粗
  }
  if (nodeView.isEmphasis && italicTheme.italicTextLetterSpacing !== undefined) {
    return italicTheme.italicTextLetterSpacing! // 斜体
  }
  if (nodeView.isStrikethrough &&
    strikethroughTheme.strikethroughTextLetterSpacing !== undefined) {
    return strikethroughTheme.strikethroughTextLetterSpacing! // 删除线
  }
  if (nodeView.isHighlight && highlightTheme.highlightTextLetterSpacing !== undefined) {
    return highlightTheme.highlightTextLetterSpacing! // 高亮
  }
  if (nodeView.isUnderlineNode &&
    htmlUnderlineTheme.htmlUnderlineTextLetterSpacing !== undefined) {
    return htmlUnderlineTheme.htmlUnderlineTextLetterSpacing! // 下划线
  }
  if (nodeView.isLink && linkTheme.linkTextLetterSpacing !== undefined) {
    return linkTheme.linkTextLetterSpacing! // 链接
  }
  if (nodeView.isFootnote && footnoteRefTheme.footnoteRefTextLetterSpacing !== undefined) {
    return footnoteRefTheme.footnoteRefTextLetterSpacing! // 脚注引用
  }
  if (nodeView.isHeading) {
    return headLetterSpacing(nodeView.headingLevel, headingTheme) // 标题
  }
  if (nodeView.isTable) {
    if (nodeView.isTableHead) {
      return tableTheme.tableTitleTextLetterSpacing // 表格标题
    }
    return tableTheme.tableContentTextLetterSpacing // 表格内容
  }
  return paragraphTheme.paragraphTextLetterSpacing // 段落
}

/**
 * 获取不同等级标题文本字符间距
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 文本字符间距
 */
export function headLetterSpacing(
  level: number,
  headingTheme: HeadingTheme
): number {
  switch (level) {
    case 1:
      return headingTheme.heading1TextLetterSpacing
    case 2:
      return headingTheme.heading2TextLetterSpacing
    case 3:
      return headingTheme.heading3TextLetterSpacing
    case 4:
      return headingTheme.heading4TextLetterSpacing
    case 5:
      return headingTheme.heading5TextLetterSpacing
    case 6:
      return headingTheme.heading6TextLetterSpacing
    default:
      return headingTheme.heading6TextLetterSpacing
  }
}

/**
 * 获取文本装饰线样式及其颜色
 *
 * @param nodeView NodeView
 * @param strikethroughTheme 删除线样式
 * @param htmlUnderlineTheme 下划线样式
 * @param linkTheme 链接样式
 * @param footnoteRefTheme 脚注引用样式
 * @return 文本装饰线样式及其颜色
 */
export function spanDecoration(
  nodeView: NodeView,
  strikethroughTheme: StrikethroughTheme,
  htmlUnderlineTheme: HtmlUnderlineTheme,
  linkTheme: LinkTheme,
  footnoteRefTheme: FootnoteRefTheme,
): DecorationStyleInterface {
  if (nodeView.isStrikethrough) {
    return {
      type: TextDecorationType.LineThrough,
      color: strikethroughTheme.strikethroughTextDecorationColor,
      style: strikethroughTheme.strikethroughTextDecorationStyle
    }
  }
  if (nodeView.isUnderlineNode) {
    return {
      type: TextDecorationType.Underline,
      color: htmlUnderlineTheme.htmlUnderlineTextDecorationColor,
      style: htmlUnderlineTheme.htmlUnderlineTextDecorationStyle
    }
  }
  if (nodeView.isLink) {
    return {
      type: linkTheme.linkTextDecorationType,
      color: linkTheme.linkTextDecorationColor,
      style: linkTheme.linkTextDecorationStyle
    }
  }
  if (nodeView.isFootnote) {
    return {
      type: footnoteRefTheme.footnoteRefTextDecorationType,
      color: footnoteRefTheme.footnoteRefTextDecorationColor,
      style: footnoteRefTheme.footnoteRefTextDecorationStyle
    }
  }
  return {
    type: TextDecorationType.None,
    color: COLOR_TRANSPARENT,
    style: TextDecorationStyle.SOLID
  }
}

/**
 * 获取文本背景颜色及圆角
 *
 * @param nodeView NodeView
 * @param inlineCodeTheme 内联代码样式
 * @param highlightTheme 高亮样式
 * @param linkTheme 链接样式
 * @param footnoteRefTheme 脚注引用样式
 * @return 文本背景颜色及圆角
 */
export function spanBackgroundColor(
  nodeView: NodeView,
  inlineCodeTheme: InlineCodeTheme,
  highlightTheme: HighlightTheme,
  linkTheme: LinkTheme,
  footnoteRefTheme: FootnoteRefTheme
): TextBackgroundStyle {
  if (nodeView.isInLineCode) {
    // 内联代码
    return {
      color: inlineCodeTheme.inlineCodeTextBackgroundColor,
      radius: {
        topLeft: inlineCodeTheme.inlineCodeTextBackgroundRadiusTopLeft,
        topRight: inlineCodeTheme.inlineCodeTextBackgroundRadiusTopRight,
        bottomLeft: inlineCodeTheme.inlineCodeTextBackgroundRadiusBottomLeft,
        bottomRight: inlineCodeTheme.inlineCodeTextBackgroundRadiusBottomRight,
      }
    }
  }
  if (nodeView.isHighlight) {
    // 高亮
    return {
      color: highlightTheme.highlightTextBackgroundColor,
      radius: {
        topLeft: highlightTheme.highlightTextBackgroundRadiusTopLeft,
        topRight: highlightTheme.highlightTextBackgroundRadiusTopRight,
        bottomLeft: highlightTheme.highlightTextBackgroundRadiusBottomLeft,
        bottomRight: highlightTheme.highlightTextBackgroundRadiusBottomRight,
      }
    }
  }
  if (nodeView.isLink) {
    // 链接
    return {
      color: linkTheme.linkTextBackgroundColor,
      radius: {
        topLeft: linkTheme.linkTextBackgroundRadiusTopLeft,
        topRight: linkTheme.linkTextBackgroundRadiusTopRight,
        bottomLeft: linkTheme.linkTextBackgroundRadiusBottomLeft,
        bottomRight: linkTheme.linkTextBackgroundRadiusBottomRight,
      }
    }
  }
  if (nodeView.isFootnote) {
    // 脚注引用
    return {
      color: footnoteRefTheme.footnoteRefTextBackgroundColor,
      radius: {
        topLeft: footnoteRefTheme.footnoteRefTextBackgroundRadiusTopLeft,
        topRight: footnoteRefTheme.footnoteRefTextBackgroundRadiusTopRight,
        bottomLeft: footnoteRefTheme.footnoteRefTextBackgroundRadiusBottomLeft,
        bottomRight: footnoteRefTheme.footnoteRefTextBackgroundRadiusBottomRight,
      }
    }
  }
  // 其他
  return {
    color: COLOR_TRANSPARENT,
    radius: {
      topLeft: 0.0,
      topRight: 0.0,
      bottomLeft: 0.0,
      bottomRight: 0.0,
    }
  }
}

/**
 * 获取文本基线的偏移量
 *
 * @param nodeView NodeView
 * @param subTheme 下标样式
 * @param supTheme 上标样式
 * @return 文本基线的偏移量
 */
export function spanBaselineOffset(
  nodeView: NodeView,
  subTheme: SubTheme,
  supTheme: SupTheme
): LengthMetrics {
  if (nodeView.isSubNode) {
    // 下标
    return {
      value: subTheme.subTextBaselineOffset,
      unit: LengthUnit.VP
    }
  }
  if (nodeView.isSupNode) {
    // 上标
    return {
      value: supTheme.supTextBaselineOffset,
      unit: LengthUnit.VP
    }
  }
  // 其他
  return {
    value: 0.0,
    unit: LengthUnit.VP
  }
}

/**
 * 获取文本行高
 *
 * @param nodeView NodeView
 * @param inlineCodeTheme 内联代码样式
 * @param boldTheme 加粗样式
 * @param italicTheme 斜体样式
 * @param strikethroughTheme 删除线样式
 * @param highlightTheme 高亮样式
 * @param htmlUnderlineTheme 下划线样式
 * @param linkTheme 链接样式
 * @param footnoteRefTheme 脚注引用样式
 * @param headingTheme 标题样式
 * @param tableTheme 表格样式
 * @param paragraphTheme 段落样式
 * @return 文本行高
 */
export function spanLineHeight(
  nodeView: NodeView,
  inlineCodeTheme: InlineCodeTheme,
  boldTheme: BoldTheme,
  italicTheme: ItalicTheme,
  strikethroughTheme: StrikethroughTheme,
  highlightTheme: HighlightTheme,
  htmlUnderlineTheme: HtmlUnderlineTheme,
  linkTheme: LinkTheme,
  footnoteRefTheme: FootnoteRefTheme,
  headingTheme: HeadingTheme,
  tableTheme: TableTheme,
  paragraphTheme: ParagraphTheme
): number | string | Resource {
  if (nodeView.isInLineCode && inlineCodeTheme.inlineCodeTextLineHeight !== undefined) {
    return inlineCodeTheme.inlineCodeTextLineHeight! // 内联代码
  }
  if (nodeView.isStrongEmphasis && boldTheme.boldTextLineHeight !== undefined) {
    return boldTheme.boldTextLineHeight! // 加粗
  }
  if (nodeView.isEmphasis && italicTheme.italicTextLineHeight !== undefined) {
    return italicTheme.italicTextLineHeight! // 斜体
  }
  if (nodeView.isStrikethrough &&
    strikethroughTheme.strikethroughTextLineHeight !== undefined) {
    return strikethroughTheme.strikethroughTextLineHeight! // 删除线
  }
  if (nodeView.isHighlight && highlightTheme.highlightTextLineHeight !== undefined) {
    return highlightTheme.highlightTextLineHeight! // 高亮
  }
  if (nodeView.isUnderlineNode &&
    htmlUnderlineTheme.htmlUnderlineTextLineHeight !== undefined) {
    return htmlUnderlineTheme.htmlUnderlineTextLineHeight! // 下划线
  }
  if (nodeView.isLink && linkTheme.linkTextLineHeight !== undefined) {
    return linkTheme.linkTextLineHeight! // 链接
  }
  if (nodeView.isFootnote && footnoteRefTheme.footnoteRefTextLineHeight !== undefined) {
    return footnoteRefTheme.footnoteRefTextLineHeight! // 脚注引用
  }
  if (nodeView.isHeading) {
    return headLineHeight(nodeView.headingLevel, headingTheme) // 标题
  }
  if (nodeView.isTable) {
    if (nodeView.isTableHead) {
      return tableTheme.tableTitleTextLineHeight // 表格标题
    }
    return tableTheme.tableContentTextLineHeight // 表格内容
  }
  return paragraphTheme.paragraphTextLineHeight // 段落
}

/**
 * 获取标题文本行高
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题文本行高
 */
export function headLineHeight(
  level: number,
  headingTheme: HeadingTheme
): number | string | Resource {
  switch (level) {
    case 1:
      return headingTheme.heading1TextLineHeight
    case 2:
      return headingTheme.heading2TextLineHeight
    case 3:
      return headingTheme.heading3TextLineHeight
    case 4:
      return headingTheme.heading4TextLineHeight
    case 5:
      return headingTheme.heading5TextLineHeight
    case 6:
      return headingTheme.heading6TextLineHeight
    default:
      return headingTheme.heading6TextLineHeight
  }
}

/**
 * 获取不同等级标题背景颜色
 *
 * @param level 标题等级
 * @param globalTheme 全局样式
 * @param blockQuoteTheme 块引用样式
 * @param headingTheme 标题样式
 * @param isQuote 是否在块引用中
 * @return 标题背景颜色
 */
export function headingBackgroundColor(
  level: number | undefined,
  globalTheme: GlobalTheme,
  blockQuoteTheme: BlockQuoteTheme,
  headingTheme: HeadingTheme,
  isQuote: boolean
): ResourceColor {
  if (isQuote) {
    return blockQuoteTheme.blockQuoteBackgroundColor
  }
  switch (level) {
    case 1:
      return headingTheme.heading1BackgroundColor ?? globalTheme.backgroundColor
    case 2:
      return headingTheme.heading2BackgroundColor ?? globalTheme.backgroundColor
    case 3:
      return headingTheme.heading3BackgroundColor ?? globalTheme.backgroundColor
    case 4:
      return headingTheme.heading4BackgroundColor ?? globalTheme.backgroundColor
    case 5:
      return headingTheme.heading5BackgroundColor ?? globalTheme.backgroundColor
    case 6:
      return headingTheme.heading6BackgroundColor ?? globalTheme.backgroundColor
    default:
      return globalTheme.backgroundColor
  }
}

/**
 * 获取不同等级标题上外边距
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题上外边距
 */
export function headingMarginTop(
  level: number | undefined,
  headingTheme: HeadingTheme
): Length {
  switch (level) {
    case 1:
      return headingTheme.heading1MarginTop
    case 2:
      return headingTheme.heading2MarginTop
    case 3:
      return headingTheme.heading3MarginTop
    case 4:
      return headingTheme.heading4MarginTop
    case 5:
      return headingTheme.heading5MarginTop
    case 6:
      return headingTheme.heading6MarginTop
    default:
      return headingTheme.heading6MarginTop
  }
}

/**
 * 获取不同等级标题右外边距
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题右外边距
 */
export function headingMarginRight(
  level: number | undefined,
  headingTheme: HeadingTheme
): Length {
  switch (level) {
    case 1:
      return headingTheme.heading1MarginRight
    case 2:
      return headingTheme.heading2MarginRight
    case 3:
      return headingTheme.heading3MarginRight
    case 4:
      return headingTheme.heading4MarginRight
    case 5:
      return headingTheme.heading5MarginRight
    case 6:
      return headingTheme.heading6MarginRight
    default:
      return headingTheme.heading6MarginRight
  }
}

/**
 * 获取不同等级标题下外边距
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题下外边距
 */
export function headingMarginBottom(
  level: number | undefined,
  headingTheme: HeadingTheme
): Length {
  switch (level) {
    case 1:
      return headingTheme.heading1MarginBottom
    case 2:
      return headingTheme.heading2MarginBottom
    case 3:
      return headingTheme.heading3MarginBottom
    case 4:
      return headingTheme.heading4MarginBottom
    case 5:
      return headingTheme.heading5MarginBottom
    case 6:
      return headingTheme.heading6MarginBottom
    default:
      return headingTheme.heading6MarginBottom
  }
}

/**
 * 获取不同等级标题左外边距
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题左外边距
 */
export function headingMarginLeft(
  level: number | undefined,
  headingTheme: HeadingTheme
): Length {
  switch (level) {
    case 1:
      return headingTheme.heading1MarginLeft
    case 2:
      return headingTheme.heading2MarginLeft
    case 3:
      return headingTheme.heading3MarginLeft
    case 4:
      return headingTheme.heading4MarginLeft
    case 5:
      return headingTheme.heading5MarginLeft
    case 6:
      return headingTheme.heading6MarginLeft
    default:
      return headingTheme.heading6MarginLeft
  }
}

/**
 * 获取不同等级标题上内边距
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题上内边距
 */
export function headingPaddingTop(
  level: number | undefined,
  headingTheme: HeadingTheme
): Length {
  switch (level) {
    case 1:
      return headingTheme.heading1PaddingTop
    case 2:
      return headingTheme.heading2PaddingTop
    case 3:
      return headingTheme.heading3PaddingTop
    case 4:
      return headingTheme.heading4PaddingTop
    case 5:
      return headingTheme.heading5PaddingTop
    case 6:
      return headingTheme.heading6PaddingTop
    default:
      return headingTheme.heading6PaddingTop
  }
}

/**
 * 获取不同等级标题右内边距
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题右内边距
 */
export function headingPaddingRight(
  level: number | undefined,
  headingTheme: HeadingTheme
): Length {
  switch (level) {
    case 1:
      return headingTheme.heading1PaddingRight
    case 2:
      return headingTheme.heading2PaddingRight
    case 3:
      return headingTheme.heading3PaddingRight
    case 4:
      return headingTheme.heading4PaddingRight
    case 5:
      return headingTheme.heading5PaddingRight
    case 6:
      return headingTheme.heading6PaddingRight
    default:
      return headingTheme.heading6PaddingRight
  }
}

/**
 * 获取不同等级标题下内边距
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题下内边距
 */
export function headingPaddingBottom(
  level: number | undefined,
  headingTheme: HeadingTheme
): Length {
  switch (level) {
    case 1:
      return headingTheme.heading1PaddingBottom
    case 2:
      return headingTheme.heading2PaddingBottom
    case 3:
      return headingTheme.heading3PaddingBottom
    case 4:
      return headingTheme.heading4PaddingBottom
    case 5:
      return headingTheme.heading5PaddingBottom
    case 6:
      return headingTheme.heading6PaddingBottom
    default:
      return headingTheme.heading6PaddingBottom
  }
}

/**
 * 获取不同等级标题左内边距
 *
 * @param level 标题等级
 * @param headingTheme 标题样式
 * @return 标题左内边距
 */
export function headingPaddingLeft(
  level: number | undefined,
  headingTheme: HeadingTheme
): Length {
  switch (level) {
    case 1:
      return headingTheme.heading1PaddingLeft
    case 2:
      return headingTheme.heading2PaddingLeft
    case 3:
      return headingTheme.heading3PaddingLeft
    case 4:
      return headingTheme.heading4PaddingLeft
    case 5:
      return headingTheme.heading5PaddingLeft
    case 6:
      return headingTheme.heading6PaddingLeft
    default:
      return headingTheme.heading6PaddingLeft
  }
}

/**
 * 设置段落背景颜色
 *
 * @param globalTheme 全局样式
 * @param blockQuoteTheme 块引用样式
 * @param paragraphTheme 段落样式
 * @param isQuote 是否在块引用中
 * @return 段落背景颜色
 */
export function paragraphBackgroundColor(
  globalTheme: GlobalTheme,
  blockQuoteTheme: BlockQuoteTheme,
  paragraphTheme: ParagraphTheme,
  isQuote: boolean
): ResourceColor {
  if (isQuote) {
    return blockQuoteTheme.blockQuoteBackgroundColor // 块引用中的段落
  }
  return paragraphTheme.paragraphBackgroundColor ?? globalTheme.backgroundColor
}

/**
 * 设置有序/无序/任务列表背景颜色
 *
 * @param isOrdered 是否是有序列表
 * @param blockQuoteTheme 块引用样式
 * @param orderedListTheme 有序列表样式
 * @param bulletListTheme 无序列表样式
 * @param globalTheme 全局样式
 * @param nodeView NodeView
 * @return 有序/无序/任务列表背景颜色
 */
export function listBackgroundColor(
  isOrdered: boolean,
  blockQuoteTheme: BlockQuoteTheme,
  orderedListTheme: OrderedListTheme,
  bulletListTheme: BulletListTheme,
  globalTheme: GlobalTheme,
  nodeView: NodeView
): ResourceColor {
  if (nodeView.isQuote) {
    return blockQuoteTheme.blockQuoteBackgroundColor // 块引用中的列表
  }
  if (isOrdered) {
    return orderedListTheme.orderedListBackgroundColor ?? globalTheme.backgroundColor // 有序列表
  } else {
    return bulletListTheme.bulletListBackgroundColor ?? globalTheme.backgroundColor // 无序列表
  }
}

/**
 * 设置脚注背景颜色
 *
 * @param blockQuoteTheme 块引用样式
 * @param footnoteDefTheme 脚注定义样式
 * @param globalTheme 全局样式
 * @param isQuote 是否在块引用中
 * @return 脚注背景颜色
 */
export function footnoteBackgroundColor(
  blockQuoteTheme: BlockQuoteTheme,
  footnoteDefTheme: FootnoteDefTheme,
  globalTheme: GlobalTheme,
  isQuote: boolean
): ResourceColor {
  if (isQuote) {
    return blockQuoteTheme.blockQuoteBackgroundColor // 块引用中的脚注
  }
  return footnoteDefTheme.footnoteDefBackgroundColor ?? globalTheme.backgroundColor
}

/**
 * 表格格子背景颜色
 *
 * @param node 节点视图
 * @param blockQuoteTheme 块引用样式
 * @param tableTheme 表格样式
 * @param isQuote 是否在块引用中
 * @param rowCount 第几行
 * @return 背景颜色
 */
export function tableCellBackgroundColor(
  node: NodeView,
  blockQuoteTheme: BlockQuoteTheme,
  tableTheme: TableTheme,
  isQuote: boolean,
  rowCount: number
): ResourceColor {
  if (isQuote) {
    return blockQuoteTheme.blockQuoteBackgroundColor // 引用
  }
  if (node.isTableHead) {
    return tableTheme.tableTitleBackgroundColor // 表格标题
  }
  if (rowCount % 2 == 0) {
    return tableTheme.tableContentEvenRowBackgroundColor // 表格内容偶数行
  }
  return tableTheme.tableContentOddRowBackgroundColor // 表格内容奇数行
}