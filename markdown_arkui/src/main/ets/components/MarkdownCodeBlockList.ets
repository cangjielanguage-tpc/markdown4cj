import { codeStringToColorString, PrismRes } from "@cangjie-tpc/prism_hybrid"
import { CodeBlockData } from "../model/CodeBlockData"
import { NodeView } from "../model/NodeView"
import { CodeBlockTheme } from "../theme/CodeBlockTheme"
import { MarkdownCodeBlockTextItem } from "./MarkdownCodeBlockTextItem"
import { CodeLineComponent } from "./MarkdownCodeLine"
import { CodeTitleComponent } from "./MarkdownCodeTitle"

/**
 * 围栏代码块列表切换控件
 * 支持多个代码块通过Tab切换显示
 */
@Component
export struct MarkdownCodeBlockList {
  @ObjectLink @Watch('refreshData') node: NodeView // 代码块列表节点数据
  @ObjectLink codeBlockTheme: CodeBlockTheme // 代码块样式
  codeCopyCallback?: (code: string) => void // 代码复制点击事件
  codeFullScreenCallback?: (code: string, language: string | undefined) => void // 代码全屏点击事件
  @State idxSelect: number = 0 // 选中索引
  @State strInfos: string[] = [] // 代码类型列表标题（Tab）
  @State strText: string[] = [] // 代码内容列表
  @State strInfoText: string[] = [] // 代码真实类型列表
  @State lineArray: number[] = [] // 当选中代码行号列表
  @State blocksDataList: Array<CodeBlockData> = [] // 所有代码块的高亮数据（@Observed，子组件@ObjectLink原地监听）
  private isAlive: boolean = false // 组件是否存活
  private timerId: number = -1 // 单个setTimeout定时器ID（与MarkdownCodeFenced一致）
  // 待解析索引累积：changedIndices先并入pending，定时器回调一次性take-all解析。
  // 必须累积——单定时器"清旧调度新"时，尚未解析的旧索引若不保留会被永久漏掉
  // （流式中块A变化后、定时器触发前块B又变化：清掉旧调度只解析B，A的高亮永不更新）
  private pendingParseIndices: Set<number> = new Set<number>()

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
    Row() {
      Column() {
        this.codeBlockTitleComponent()
        Column() {
          CodeTitleComponent({
            codeText: this.strText.length > 0 ? this.strText[this.idxSelect] : '',
            info: this.strInfoText.length > 0 ? this.strInfoText[this.idxSelect] : '',
            showTypeText: false,
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
      }
      .layoutWeight(1)
    }
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
   * 代码块列表标题（Tab切换栏）
   */
  @Builder
  codeBlockTitleComponent() {
    Scroll() {
      Row() {
        ForEach(
          this.strInfos,
          (item: string, idx: number) => {
            Text(item)
              .fontColor(idx === this.idxSelect
                ? this.codeBlockTheme.codeBlockListTitleSelectTextColor
                : this.codeBlockTheme.codeBlockListTitleUnselectTextColor)
              .backgroundColor(idx === this.idxSelect
                ? this.codeBlockTheme.codeBlockListTitleSelectBackgroundColor
                : this.codeBlockTheme.codeBlockListTitleUnselectBackgroundColor)
              .maxLines(1)
              .fontSize(idx === this.idxSelect
                ? this.codeBlockTheme.codeBlockListTitleSelectTextSize
                : this.codeBlockTheme.codeBlockListTitleTextSize)
              .padding({
                left: 14,
                right: 14,
                top: 5,
                bottom: 5
              })
              .onClick(() => {
                this.idxSelect = idx
                this.updateLineArray()
              })
          },
          (item: string, idx: number) => `${idx}-${item}`
        )
      }
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .align(Alignment.Start)
    .margin({ bottom: this.codeBlockTheme.codeBlockTitleLayoutMarginBottom })
  }

  /**
   * 代码内容部分（水平滚动）
   * 外层ForEach使用稳定key=${idx}：
   * - 新代码块追加时仅新增项，不重建已有项
   * - 已有项的高亮更新通过CodeBlockData(@Observed)→@ObjectLink原地刷新
   */
  @Builder
  codeBlockComponent() {
    Scroll() {
      Column() {
        ForEach(
          this.blocksDataList,
          (data: CodeBlockData, idx: number) => {
            MarkdownCodeBlockTextItem({
              data: data,
              codeBlockTheme: this.codeBlockTheme,
              idx: idx,
              idxSelect: this.idxSelect,
              rawText: this.strText.length > idx ? this.strText[idx] : ''
            })
          },
          (data: CodeBlockData, idx: number) => `${idx}`
        )
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
   * 刷新数据：从node子节点提取代码块列表
   * 仅对内容变化的代码块重新解析高亮，避免闪烁
   */
  refreshData(): void {
    let infos: string[] = []
    let texts: string[] = []
    let infoTexts: string[] = []
    for (let i = 0; i < this.node.children.length; i++) {
      let child = this.node.children[i]
      texts.push(child.nodeText)
      infoTexts.push(child.codeInfo ?? '')
      infos.push(child.codeInfo ?? '')
    }
    if (this.node.codeListTab !== undefined) {
      if (this.node.codeListTab.length > 0) {
        infos = this.node.codeListTab
      }
    }

    // 检测哪些代码块内容发生了变化（文本或语言）
    let changedIndices: number[] = []
    for (let i = 0; i < texts.length; i++) {
      let textChanged = i >= this.strText.length || this.strText[i] !== texts[i]
      let infoChanged = i >= this.strInfoText.length || this.strInfoText[i] !== infoTexts[i]
      if (textChanged || infoChanged) {
        changedIndices.push(i)
      }
    }

    this.strText = texts
    this.strInfoText = infoTexts
    this.strInfos = infos

    // 仅在选中索引越界时重置（避免流式输入时Tab频繁跳回第一个）
    if (this.idxSelect >= this.strText.length) {
      this.idxSelect = 0
    }
    this.updateLineArray()
    this.parseChangedCode(changedIndices)
  }

  /**
   * 更新行号数组（基于当前选中代码块）
   */
  updateLineArray(): void {
    let code = this.strText.length > this.idxSelect ? this.strText[this.idxSelect] : ''
    let arr = code.split('\n') // nodeText已去除末尾换行，无需再pop
    let lineArr: number[] = []
    for (let i = 1; i <= arr.length; i++) {
      lineArr.push(i)
    }
    this.lineArray = lineArr
  }

  /**
   * 解析变化的代码块高亮
   * 调整blocksDataList大小后，原地修改CodeBlockData属性触发子组件@ObjectLink刷新
   *
   * 单定时器+增量解析：changedIndices并入pendingParseIndices，回调中只解析变化块
   * （原生prism调用从每轮全量O(N)降为只解析变化块，流式追加第N块不再重解析前N-1块）。
   * pending跨多次refreshData累积——定时器被新调度清掉时未解析的旧索引不丢失。
   * 源文本比对保证过期解析结果（流式期间文本已变化）不应用。
   *
   * @param changedIndices 本次内容（文本/语言）发生变化的代码块索引
   */
  parseChangedCode(changedIndices: number[]): void {
    // 调整数组大小：保留已有CodeBlockData实例（保持@ObjectLink绑定），新增空的
    let dataList: Array<CodeBlockData> = []
    for (let i = 0; i < this.strText.length; i++) {
      if (i < this.blocksDataList.length) {
        dataList.push(this.blocksDataList[i])
      } else {
        dataList.push(new CodeBlockData())
      }
    }
    this.blocksDataList = dataList

    for (let i = 0; i < changedIndices.length; i++) {
      this.pendingParseIndices.add(changedIndices[i])
    }
    if (this.pendingParseIndices.size === 0) {
      return
    }

    // 单定时器：清旧调度新（与MarkdownCodeFenced一致的模式）；旧调度未解析的
    // 索引仍在pending中，新回调会取走继续解析
    if (this.timerId !== -1) {
      clearTimeout(this.timerId)
      this.timerId = -1
    }
    if (this.codeBlockTheme.codeBlockParserSync) {
      this.parseChangedCodeSync()
    } else {
      this.parseChangedCodeAsync()
    }
  }

  /**
   * 异步解析变化的代码块高亮
   * 单定时器回调中一次性take-all取走pendingParseIndices逐个解析，原地修改
   * CodeBlockData.blocks属性，@ObjectLink触发子组件原地刷新。
   * 源文本比对防止流式期间过期解析结果应用。
   */
  parseChangedCodeAsync(): void {
    this.timerId = setTimeout(() => {
      this.timerId = -1
      if (!this.isAlive) {
        return
      }
      // take-all取走全部待解析索引：本轮调度到触发之间新并入的索引一并处理；
      // 取走后新refreshData的变化索引重新累积到pending，由下一次调度解析，
      // 不会丢失也不会与本轮重复
      const indices: number[] = Array.from(this.pendingParseIndices)
      this.pendingParseIndices.clear()
      for (let i = 0; i < indices.length; i++) {
        const idx: number = indices[i]
        // 索引入队后strText可能收缩（内容整体替换为更少块），越界索引直接跳过
        if (idx < 0 || idx >= this.strText.length) {
          continue
        }
        let codeText = this.strText[idx]
        if (codeText.length === 0) {
          continue
        }
        let info: string | undefined = undefined
        const infoText: string | undefined = this.strInfoText[idx]
        if (infoText !== undefined) {
          if (infoText.length > 0) {
            info = infoText
          }
        }
        codeStringToColorString(codeText, info, this.codeBlockTheme.codeBlockIsDark).then((prismRes: PrismRes) => {
          if (!this.isAlive) {
            return
          }
          // 流式期间文本可能已变化，比对源文本，过期解析结果丢弃；
          // 丢弃后该块的新文本必经refreshData重新入pending，由下一轮解析补上
          if (idx >= this.strText.length || this.strText[idx] !== codeText) {
            return
          }
          if (idx >= this.blocksDataList.length) {
            return
          }
          // 原地修改CodeBlockData属性，@ObjectLink触发子组件刷新（不重建）
          this.blocksDataList[idx].blocks = Array.from(prismRes.getListColor())
          this.blocksDataList[idx].defaultFontColor = prismRes.getDefaultFontColor()
        }).catch((e: Error) => {
          console.error('CodeBlockList codeStringToColorString failed: ' + (e instanceof Error ? e.stack : String(e)))
        })
      }
    }, 0)
  }

  /**
   * 同步解析变化的代码块高亮
   * 一次性take-all取走pendingParseIndices逐个await解析，原地修改CodeBlockData.blocks属性，
   * @ObjectLink触发子组件原地刷新。源文本比对防止await期间文本变化后应用过期结果。
   *
   * @return Promise<void>，解析完成后resolve
   */
  async parseChangedCodeSync(): Promise<void> {
    // 同步取走全部待解析索引（原子）：本轮await期间新的refreshData会把新变化索引
    // 重新累积到pending并可能并发启动下一轮，两轮解析的索引集不相交，不会重复解析
    const indices: number[] = Array.from(this.pendingParseIndices)
    this.pendingParseIndices.clear()
    for (let i = 0; i < indices.length; i++) {
      const idx: number = indices[i]
      // 索引入队后strText可能收缩，越界索引直接跳过
      if (idx < 0 || idx >= this.strText.length) {
        continue
      }
      let codeText = this.strText[idx]
      if (codeText.length === 0) {
        continue
      }
      let info: string | undefined = undefined
      const infoText: string | undefined = this.strInfoText[idx]
      if (infoText !== undefined) {
        if (infoText.length > 0) {
          info = infoText
        }
      }
      try {
        if (!this.isAlive) {
          break
        }
        let prismRes: PrismRes = await codeStringToColorString(codeText, info, this.codeBlockTheme.codeBlockIsDark)
        if (!this.isAlive) {
          break
        }
        // await期间本idx文本可能又变化，比对源文本，过期解析结果跳过；
        // 丢弃后该块的新文本必经refreshData重新入pending，由下一轮解析补上
        if (idx >= this.strText.length || this.strText[idx] !== codeText) {
          continue
        }
        if (idx >= this.blocksDataList.length) {
          continue
        }
        // 原地修改CodeBlockData属性，@ObjectLink触发子组件刷新（不重建）
        this.blocksDataList[idx].blocks = Array.from(prismRes.getListColor())
        this.blocksDataList[idx].defaultFontColor = prismRes.getDefaultFontColor()
      } catch (e) {
        console.error('CodeBlockList parseChangedCodeSync failed: ' + (e instanceof Error ? e.stack : String(e)))
      }
    }
  }
}
