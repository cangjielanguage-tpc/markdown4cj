import { codeStringToColorString, PrismBlock, PrismNode, PrismRes } from "@cangjie-tpc/prism_hybrid"
import { NodeView } from "../model/NodeView"
import { CodeBlockTheme } from "../theme/CodeBlockTheme"
import { CodeLineComponent } from "./MarkdownCodeLine"
import { codeTitle } from "./MarkdownCodeTitle"

/**
 * 围栏代码块控件
 */
@Component
export struct MarkdownCodeFenced {
  @ObjectLink @Watch('refreshData') node: NodeView // 围栏代码块自身节点数据
  @ObjectLink codeBlockTheme: CodeBlockTheme // 代码块样式
  codeCopyCallback?: (code: string) => void // 代码复制点击事件
  codeFullScreenCallback?: (code: string, language: string | undefined) => void // 代码全屏点击事件
  @State codeText: string = "" // 代码内容
  @State info: string | undefined = undefined // 代码类型
  @State lineArray: Array<number> = new Array<number>() // 代码行数显示数据列表
  @State prismBlocks: Array<PrismBlock> = new Array<PrismBlock>() // 高亮代码块列表
  @State defaultFontColor: number = 0 // 默认文本颜色
  private isAlive: boolean = false // 组件是否存活

  aboutToAppear(): void {
    this.isAlive = true
    this.refreshData()
  }

  aboutToDisappear(): void {
    this.isAlive = false
  }

  build() {
    Column() {
      codeTitle(this.codeText, this.info, this.codeBlockTheme, this.codeCopyCallback, this.codeFullScreenCallback)
      Row() {
        CodeLineComponent({ lineArray: this.lineArray, codeBlockTheme: this.codeBlockTheme })
        this.codeBlockComponent()
      }
    }
    .borderRadius({
      topLeft: this.codeBlockTheme.codeBlockRadiusTopLeft,
      topRight: this.codeBlockTheme.codeBlockRadiusTopRight,
      bottomLeft: this.codeBlockTheme.codeBlockRadiusBottomLeft,
      bottomRight: this.codeBlockTheme.codeBlockRadiusBottomRight
    })
    .borderColor(this.codeBlockTheme.codeBlockBorderColor)
    .borderWidth(this.codeBlockTheme.codeBlockBorderWidth)
    .borderStyle(this.codeBlockTheme.codeBlockBorderStyle)
    .backgroundColor(this.codeBlockTheme.codeBlockBackgroundColor)
    .padding({
      top: this.codeBlockTheme.codeBlockPaddingTop,
      right: this.codeBlockTheme.codeBlockPaddingRight,
      bottom: this.codeBlockTheme.codeBlockPaddingBottom,
      left: this.codeBlockTheme.codeBlockPaddingLeft
    })
    .margin({
      top: this.codeBlockTheme.codeBlockMarginTop,
      right: this.codeBlockTheme.codeBlockMarginRight,
      bottom: this.codeBlockTheme.codeBlockMarginBottom,
      left: this.codeBlockTheme.codeBlockMarginLeft
    })
  }

  /**
   * 代码块文本内容部分
   */
  @Builder
  codeBlockComponent() {
    Scroll() {
      if (this.prismBlocks.length > 0) {
        Column() {
          ForEach(
            this.prismBlocks,
            (block: PrismBlock, index: number) => {
              Text() {
                ForEach(
                  Array.from(block.getList()),
                  (node: PrismNode) => {
                    Span(node.text)
                      .fontColor(node.color ?? this.defaultFontColor)
                      .letterSpacing(this.codeBlockTheme.codeBlockTextLetterSpacing)
                  }
                )
              }
              .fontFamily(this.codeBlockTheme.codeBlockTextFontFamily)
              .fontSize(this.codeBlockTheme.codeBlockTextFontSize)
              .fontWeight(this.codeBlockTheme.codeBlockTextFontWeight)
              .fontStyle(this.codeBlockTheme.codeBlockTextFontStyle)
              .lineHeight(this.codeBlockTheme.codeBlockTextLineHeight)
              .textAlign(TextAlign.Start)
            },
            (block: PrismBlock, index: number) => {
              return `${index}-${block.getText()}`
            }
          )
        }
      } else {
        Text(this.codeText)
          .fontFamily(this.codeBlockTheme.codeBlockTextFontFamily)
          .fontSize(this.codeBlockTheme.codeBlockTextFontSize)
          .fontWeight(this.codeBlockTheme.codeBlockTextFontWeight)
          .fontStyle(this.codeBlockTheme.codeBlockTextFontStyle)
          .fontColor(this.codeBlockTheme.codeBlockCopyTextFontColor ?? this.codeBlockTheme.codeBlockTextFontColor)
          .lineHeight(this.codeBlockTheme.codeBlockTextLineHeight)
          .textAlign(TextAlign.Start)
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .align(Alignment.Start)
    .layoutWeight(1)
    .margin({
      left: this.codeBlockTheme.codeBlockTextMarginLeft,
      right: this.codeBlockTheme.codeBlockTextMarginRight
    })
  }

  /**
   * 刷新数据
   */
  refreshData(): void {
    this.codeText = this.node.nodeText
    this.info = this.node.codeInfo
    let arr = this.codeText.split("\n") // 代码块数据分割
    if (arr.length > 1 && arr[arr.length - 1] === "") {
      arr.pop()
    }
    let lineArr: number[] = []
    for (let i = 1; i <= arr.length; i++) {
      lineArr.push(i)
    }
    this.lineArray = lineArr
    this.parseCode()
  }

  /**
   * 异步解析代码高亮
   */
  async parseCode(): Promise<void> {
    if (this.codeText.length === 0) {
      this.prismBlocks = []
      return
    }
    let isDarkula: boolean = this.codeBlockTheme.codeBlockIsDark ?? false
    let info: string | undefined = (this.info !== undefined && this.info.length > 0) ? this.info : undefined
    try {
      let prismRes: PrismRes = await codeStringToColorString(this.codeText, info, isDarkula)
      if (!this.isAlive) {
        return
      }
      this.defaultFontColor = prismRes.getDefaultFontColor()
      this.prismBlocks = Array.from(prismRes.getListColor())
    } catch (e) {
      if (!this.isAlive) {
        return
      }
      this.prismBlocks = []
    }
  }
}
