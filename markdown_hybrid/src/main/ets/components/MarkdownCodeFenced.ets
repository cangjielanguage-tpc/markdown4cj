import { codeStringToColorString, PrismBlock, PrismNode, PrismRes } from "@cangjie-tpc/prism_hybrid"
import { CodeFormatTS } from "@cangjie-tpc/codeformat_hybrid"
import { NodeView } from "../model/NodeView"
import { CodeBlockTheme } from "../theme/CodeBlockTheme"
import { CodeLineComponent } from "./MarkdownCodeLine"
import { CodeTitleComponent } from "./MarkdownCodeTitle"

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
  private parseVersion: number = 0 // 解析版本号，每次解析递增
  private appliedVersion: number = 0 // 已应用的版本号，用于丢弃过期的异步解析结果
  private timerId: number = -1 // setTimeout定时器ID
  private codeFormatTS: CodeFormatTS | null = null // 代码格式化工具实例

  aboutToAppear(): void {
    this.isAlive = true
    this.refreshData()
  }

  aboutToDisappear(): void {
    this.isAlive = false
    if (this.timerId !== -1) {
      clearTimeout(this.timerId)
      this.timerId = -1
    }
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
      .alignItems(VerticalAlign.Top)
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
   * 不使用if/else切换高亮/原始文本，避免分支不刷新
   */
  @Builder
  codeBlockComponent() {
    Scroll() {
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
          (block: PrismBlock, index: number) => {
            return `${index}-${block.getText()}`
          }
        )

        Text(this.codeText)
          .fontFamily(this.codeBlockTheme.codeBlockTextFontFamily)
          .fontSize(this.codeBlockTheme.codeBlockTextFontSize)
          .fontWeight(this.codeBlockTheme.codeBlockTextFontWeight)
          .fontStyle(this.codeBlockTheme.codeBlockTextFontStyle)
          .fontColor(this.codeBlockTheme.codeBlockTextFontColor)
          .lineHeight(this.codeBlockTheme.codeBlockTextLineHeight)
          .textAlign(TextAlign.Start)
          .visibility(this.prismBlocks.length === 0 ? Visibility.Visible : Visibility.None)
      }
      .alignItems(HorizontalAlign.Start)
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
    if (this.codeBlockTheme.codeBlockIsCodeFormat) {
      this.codeText = this.formatCode(this.info, this.codeText)
    }
    let arr = this.codeText.split("\n") // 代码块数据分割
    if (arr.length > 1 && arr[arr.length - 1] === "") {
      arr.pop()
    }
    let lineArr: number[] = []
    for (let i = 1; i <= arr.length; i++) {
      lineArr.push(i)
    }
    this.lineArray = lineArr
    if (this.codeBlockTheme.codeBlockParserSync) {
      this.parseCodeSync()
    } else {
      this.parseCodeAsync()
    }
  }

  /**
   * 代码格式化
   * 根据codeBlockUseTab选择Tab或空格缩进，失败时返回原始代码
   */
  private formatCode(info: string | undefined, code: string): string {
    try {
      if (this.codeFormatTS === null) {
        this.codeFormatTS = new CodeFormatTS(true)
      }
      if (this.codeBlockTheme.codeBlockUseTab) {
        return this.codeFormatTS.codeFormatWithTab(info, code)
      }
      return this.codeFormatTS.codeFormatWithWhiteSpace(info, code, Number(this.codeBlockTheme.codeBlockIndentWidth))
    } catch (e) {
      return code
    }
  }

  /**
   * 异步解析代码高亮（codeBlockParserSync=false时使用）
   * 使用.then()回调，不阻塞UI线程
   */
  parseCodeAsync(): void {
    if (this.codeText.length === 0) {
      this.prismBlocks = []
      return
    }
    this.parseVersion++ // 版本号递增
    const currentVersion = this.parseVersion
    let info: string | undefined = undefined
    if (this.info !== undefined) {
      if (this.info.length > 0) {
        info = this.info
      }
    }
    if (this.timerId !== -1) {
      clearTimeout(this.timerId)
      this.timerId = -1
    }
    this.timerId = setTimeout(() => {
      this.timerId = -1
      if (!this.isAlive || currentVersion <= this.appliedVersion) {
        return
      }
      codeStringToColorString(this.codeText, info, this.codeBlockTheme.codeBlockIsDark).then((prismRes: PrismRes) => {
        if (!this.isAlive || currentVersion <= this.appliedVersion) {
          return
        }
        this.defaultFontColor = prismRes.getDefaultFontColor()
        this.prismBlocks = Array.from(prismRes.getListColor())
        this.appliedVersion = currentVersion
      }).catch(() => {
        if (!this.isAlive || currentVersion <= this.appliedVersion) {
          return
        }
        this.prismBlocks = []
        this.appliedVersion = currentVersion
      })
    }, 0)
  }

  /**
   * 同步解析代码高亮（codeBlockParserSync=true时使用）
   * 使用await，在UI线程执行
   */
  async parseCodeSync(): Promise<void> {
    if (this.codeText.length === 0) {
      this.prismBlocks = []
      return
    }
    this.parseVersion++ // 版本号递增
    const currentVersion = this.parseVersion
    let info: string | undefined = undefined
    if (this.info !== undefined) {
      if (this.info.length > 0) {
        info = this.info
      }
    }
    try {
      let prismRes: PrismRes = await codeStringToColorString(this.codeText, info, this.codeBlockTheme.codeBlockIsDark)
      if (!this.isAlive || currentVersion <= this.appliedVersion) {
        return
      }
      this.defaultFontColor = prismRes.getDefaultFontColor()
      this.prismBlocks = Array.from(prismRes.getListColor())
      this.appliedVersion = currentVersion
    } catch (e) {
      if (!this.isAlive || currentVersion <= this.appliedVersion) {
        return
      }
      this.prismBlocks = []
      this.appliedVersion = currentVersion
    }
  }
}
