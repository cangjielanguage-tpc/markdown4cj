import { NodeView } from "../model/NodeView"
import { CodeBlockTheme } from "../theme/CodeBlockTheme"
import { CodeLineComponent } from "./MarkdownCodeLine"
import { CodeTitleComponent } from "./MarkdownCodeTitle"

/**
 * 缩进代码块控件
 */
@Component
export struct MarkdownCodeIndented {
  @ObjectLink @Watch('refreshData') node: NodeView // 缩进代码块自身节点数据
  @ObjectLink codeBlockTheme: CodeBlockTheme // 代码块样式
  codeCopyCallback?: (code: string) => void // 代码复制点击事件
  codeFullScreenCallback?: (code: string, language: string | undefined) => void // 代码全屏点击事件
  @State codeText: string = "" // 代码内容
  @State info: string | undefined = undefined // 代码类型
  private lines: number = 0 // 代码行数
  @State lineArray: Array<number> = new Array<number>() // 代码行数显示数据列表
  // 内容签名缓存：增量/流式场景 @Watch 因节点其他 observed 属性变化触发时，
  // 代码原文/语言未变则 split+行号重建结果恒相同，可整体跳过
  private signedCodeText: string | undefined = undefined // 上次处理的代码原文（undefined=尚未初始化，首次必执行）
  private signedCodeInfo: string | undefined = undefined // 上次代码语言

  aboutToAppear(): void {
    this.refreshData()
  }

  build() {
    Column() {
      CodeTitleComponent({
        codeText: this.codeText,
        info: this.info ?? '',
        codeBlockTheme: this.codeBlockTheme,
        codeCopyCallback: this.codeCopyCallback,
        codeFullScreenCallback: this.codeFullScreenCallback
      })
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
      Text(this.codeText)
        .fontFamily(this.codeBlockTheme.codeBlockTextFontFamily)
        .fontSize(this.codeBlockTheme.codeBlockTextFontSize)
        .fontWeight(this.codeBlockTheme.codeBlockTextFontWeight)
        .fontStyle(this.codeBlockTheme.codeBlockTextFontStyle)
        .fontColor(this.codeBlockTheme.codeBlockTextFontColor)
        .lineHeight(this.codeBlockTheme.codeBlockTextLineHeight)
        .textAlign(TextAlign.Start)
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
   * 增量/流式优化：代码原文与语言均未变时直接返回，
   * 避免每次 @Watch 触发都重跑 split + 行号数组重建（结果恒相同）
   */
  refreshData() {
    const newText = this.node.nodeText
    const newInfo = this.node.codeInfo
    if (this.signedCodeText !== undefined &&
      newText === this.signedCodeText && newInfo === this.signedCodeInfo) {
      return
    }
    this.signedCodeText = newText
    this.signedCodeInfo = newInfo
    this.codeText = newText
    this.info = newInfo
    let arr = this.codeText.split("\n") // 代码块数据分割，nodeText已去除末尾换行，无需再pop
    this.lines = arr.length
    let lineArr: number[] = []
    for (let i = 1; i <= this.lines; i++) {
      lineArr.push(i)
    }
    this.lineArray = lineArr
  }
}
