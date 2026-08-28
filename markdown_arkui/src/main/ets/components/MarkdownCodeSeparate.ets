import { codeStringToColorString, PrismBlock, PrismNode, PrismRes } from "@cangjie-tpc/prism_hybrid"
import { NodeView } from "../model/NodeView"
import { CodeBlockTheme } from "../theme/CodeBlockTheme"
import { CodeTitleComponent } from "./MarkdownCodeTitle"

/**
 * 单独代码块控件
 *
 * 当codeBlockIsSeparate=true时，MarkdownComponent以此控件渲染首个代码块节点。
 * 与MarkdownCodeFenced的差异：内部List垂直滚动（长代码不撑高外层）、行号与代码滚动同步、
 * reachBottom自动居底（流式输出场景）。
 */
@Component
export struct MarkdownCodeSeparate {
  @ObjectLink @Watch('refreshData') node: NodeView // 代码块自身节点数据
  @ObjectLink codeBlockTheme: CodeBlockTheme // 代码块样式
  codeCopyCallback?: (code: string) => void // 代码复制点击事件
  codeFullScreenCallback?: (code: string, language: string | undefined) => void // 代码全屏点击事件
  @State codeText: string = "" // 代码内容
  @State info: string | undefined = undefined // 代码类型
  @State lineArray: Array<number> = [] // 行号列表
  @State rawLines: Array<string> = [] // 原始代码行（高亮解析前的回退数据）
  @State prismBlocks: Array<PrismBlock> = [] // 高亮代码块列表（每行一个PrismBlock）
  @State defaultFontColor: number = 0 // 默认文本颜色
  @State reachBottom: boolean = true // 是否在布局末尾
  private isAlive: boolean = false // 组件是否存活
  private chatTouch: boolean = false // 手指是否触摸
  private parseVersion: number = 0 // 解析版本号，每次解析递增
  private appliedVersion: number = 0 // 已应用的版本号，用于丢弃过期的异步解析结果
  private timerId: number = -1 // setTimeout定时器ID
  private lineScroller: Scroller = new Scroller() // 行号list控制器
  private codeScroller: Scroller = new Scroller() // 代码list控制器

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
        // 行号
        List({ scroller: this.lineScroller }) {
          ForEach(
            this.lineArray,
            (num: number) => {
              ListItem() {
                Text(num.toString())
                  .fontFamily(this.codeBlockTheme.codeBlockLineNumberTextFontFamily ??
                  this.codeBlockTheme.codeBlockTextFontFamily)
                  .fontSize(this.codeBlockTheme.codeBlockLineNumberTextFontSize ??
                  this.codeBlockTheme.codeBlockTextFontSize)
                  .fontWeight(this.codeBlockTheme.codeBlockLineNumberTextFontWeight ??
                  this.codeBlockTheme.codeBlockTextFontWeight)
                  .fontStyle(this.codeBlockTheme.codeBlockLineNumberTextFontStyle ??
                  this.codeBlockTheme.codeBlockTextFontStyle)
                  .fontColor(this.codeBlockTheme.codeBlockLineNumberTextFontColor ??
                  this.codeBlockTheme.codeBlockTextFontColor)
                  .lineHeight(this.codeBlockTheme.codeBlockLineNumberTextLineHeight ??
                  this.codeBlockTheme.codeBlockTextLineHeight)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .textAlign(TextAlign.End)
              }
            },
            (num: number) => num.toString()
          )
        }
        .width(this.codeBlockTheme.codeBlockSeparateWidth)
        .padding({
          right: this.codeBlockTheme.codeBlockLineNumberDividerSpacing,
          left: this.codeBlockTheme.codeBlockLineNumberTextPaddingLeft
        })
        .borderWidth({ right: this.codeBlockTheme.codeBlockDividerStrokeWidth })
        .borderColor(this.codeBlockTheme.codeBlockDividerColor ?? this.codeBlockTheme.codeBlockTextFontColor)
        .borderStyle(BorderStyle.Solid)
        .height('100%')
        .scrollBar(BarState.Off)
        .alignListItem(ListItemAlign.End)
        .enabled(false)

        // 代码区（横向滚动容器 + 纵向行列表）
        Scroll() {
          Column() {
            List({ scroller: this.codeScroller }) {
              if (this.prismBlocks.length > 0) {
                ForEach(
                  this.prismBlocks,
                  (block: PrismBlock, index: number) => {
                    ListItem() {
                      if (block.getList().length > 0) {
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
                      } else {
                        Text(" ")
                          .fontFamily(this.codeBlockTheme.codeBlockTextFontFamily)
                          .fontSize(this.codeBlockTheme.codeBlockTextFontSize)
                          .lineHeight(this.codeBlockTheme.codeBlockTextLineHeight)
                      }
                    }
                  },
                  (block: PrismBlock, index: number) => `${index}-${block.getText()}`
                )
              } else {
                ForEach(
                  this.rawLines,
                  (line: string, index: number) => {
                    ListItem() {
                      Text(line.length > 0 ? line : " ")
                        .fontFamily(this.codeBlockTheme.codeBlockTextFontFamily)
                        .fontSize(this.codeBlockTheme.codeBlockTextFontSize)
                        .fontWeight(this.codeBlockTheme.codeBlockTextFontWeight)
                        .fontStyle(this.codeBlockTheme.codeBlockTextFontStyle)
                        .fontColor(this.codeBlockTheme.codeBlockTextFontColor)
                        .lineHeight(this.codeBlockTheme.codeBlockTextLineHeight)
                        .textAlign(TextAlign.Start)
                    }
                  },
                  (line: string, index: number) => `${index}-${line}`
                )
              }
            }
            .height('100%')
            .layoutWeight(1)
            .scrollBar(BarState.Off)
            .edgeEffect(EdgeEffect.None)
            .onReachEnd(() => {
              this.reachBottom = true
            })
            .onScroll((scrollOffset: number) => {
              const offset = this.codeScroller.currentOffset()
              this.lineScroller.scrollTo({ xOffset: 0, yOffset: offset.yOffset })
              this.checkScroll(scrollOffset)
            })
            .onTouch((event: TouchEvent) => {
              this.chatOnTouch(event)
            })
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .align(Alignment.Start)
        .height('100%')
        .layoutWeight(1)
        .margin({
          left: this.codeBlockTheme.codeBlockTextMarginLeft,
          right: this.codeBlockTheme.codeBlockTextMarginRight
        })
      }
      .layoutWeight(1)
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
   * 刷新数据
   */
  refreshData(): void {
    this.codeText = this.node.nodeText
    this.info = this.node.codeInfo
    let arr = this.codeText.split("\n") // 代码块数据分割，nodeText已去除末尾换行，无需再pop
    let lineArr: number[] = []
    for (let i = 1; i <= arr.length; i++) {
      lineArr.push(i)
    }
    this.lineArray = lineArr
    this.rawLines = arr
    if (this.codeBlockTheme.codeBlockParserSync) {
      this.parseCodeSync()
    } else {
      this.parseCodeAsync()
    }
  }

  /**
   * 异步解析代码高亮（codeBlockParserSync=false时使用）
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
        this.scrollChatIfAtBottom()
      }).catch((e: Error) => {
        console.error('CodeSeparate codeStringToColorString failed: ' + (e instanceof Error ? e.stack : String(e)))
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
      this.scrollChatIfAtBottom()
    } catch (e) {
      console.error('CodeSeparate codeStringToColorString sync failed: ' + (e instanceof Error ? e.stack : String(e)))
      if (!this.isAlive || currentVersion <= this.appliedVersion) {
        return
      }
      this.prismBlocks = []
      this.appliedVersion = currentVersion
    }
  }

  /**
   * 是否滑动到底部
   */
  scrollChatIfAtBottom(): void {
    if (this.codeBlockTheme.codeBlockSeparateIsBottom && this.reachBottom) {
      this.scroll2Bottom()
    }
  }

  /**
   * 滑动到底部
   */
  scroll2Bottom(): void {
    this.codeScroller.scrollEdge(Edge.Bottom)
  }

  /**
   * 判断滑动距离和是否手指触摸
   *
   * @param offset 偏移量
   */
  checkScroll(offset: number): void {
    if (offset < -0.5 && this.chatTouch) {
      this.reachBottom = false
    }
  }

  /**
   * 手指触摸判断
   *
   * @param event 触摸事件
   */
  chatOnTouch(event: TouchEvent): void {
    if (event.type === TouchType.Down) {
      this.chatTouch = true
    } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
      this.chatTouch = false
    }
  }
}
