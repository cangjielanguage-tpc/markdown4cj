import { PrismBlock, PrismNode } from "@cangjie-tpc/prism_hybrid"
import { CodeBlockData } from "../model/CodeBlockData"
import { CodeBlockTheme } from "../theme/CodeBlockTheme"

/**
 * 单个代码块文本内容组件
 * 使用@Component + @ObjectLink实现原地更新：
 * - 当CodeBlockData.blocks被重新赋值时，@ObjectLink触发本组件刷新，不销毁重建
 * - 外层ForEach key使用稳定索引，不再依赖blocks.length
 */
@Component
export struct MarkdownCodeBlockTextItem {
  @ObjectLink data: CodeBlockData // 高亮数据（可观察）
  @ObjectLink codeBlockTheme: CodeBlockTheme // 代码块样式
  @Prop idx: number // 本代码块在列表中的索引
  @Prop idxSelect: number // 当前选中的索引
  @Prop rawText: string // 原始代码文本（未高亮，作为fallback显示）

  build() {
    Column() {
      ForEach(
        this.data.blocks,
        (block: PrismBlock, lineIdx: number) => {
          Text() {
            ForEach(
              Array.from(block.getList()),
              (node: PrismNode) => {
                Span(node.text)
                  .fontColor(node.color ?? this.data.defaultFontColor)
                  .letterSpacing(this.codeBlockTheme.codeBlockTextLetterSpacing)
              },
              (node: PrismNode, nodeIdx: number) => `${nodeIdx}-${node.text}-${node.color}`
            )
          }
          .fontFamily(this.codeBlockTheme.codeBlockTextFontFamily)
          .fontSize(this.codeBlockTheme.codeBlockTextFontSize)
          .fontWeight(this.codeBlockTheme.codeBlockTextFontWeight)
          .fontStyle(this.codeBlockTheme.codeBlockTextFontStyle)
          .lineHeight(this.codeBlockTheme.codeBlockTextLineHeight)
          .textAlign(TextAlign.Start)
        },
        (block: PrismBlock, lineIdx: number) => `${lineIdx}-${block.getText()}`
      )

      Text(this.rawText)
        .fontFamily(this.codeBlockTheme.codeBlockTextFontFamily)
        .fontSize(this.codeBlockTheme.codeBlockTextFontSize)
        .fontWeight(this.codeBlockTheme.codeBlockTextFontWeight)
        .fontStyle(this.codeBlockTheme.codeBlockTextFontStyle)
        .fontColor(this.codeBlockTheme.codeBlockTextFontColor)
        .lineHeight(this.codeBlockTheme.codeBlockTextLineHeight)
        .textAlign(TextAlign.Start)
        .visibility(this.data.blocks.length === 0 ? Visibility.Visible : Visibility.None)
    }
    .alignItems(HorizontalAlign.Start)
    .visibility(this.idx === this.idxSelect ? Visibility.Visible : Visibility.None)
  }
}