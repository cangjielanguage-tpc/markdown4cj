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
  private parseVersion: number = 0 // 解析版本号
  private timerIds: number[] = [] // setTimeout定时器ID列表

  aboutToAppear(): void {
    this.isAlive = true
    this.refreshData()
  }

  aboutToDisappear(): void {
    this.isAlive = false
    for (let i = 0; i < this.timerIds.length; i++) {
      clearTimeout(this.timerIds[i])
    }
    this.timerIds = []
  }

  build() {
    Row() {
      Column() {
        this.codeBlockTitleComponent()
        Column() {
          CodeTitleComponent({
            codeText: this.strText.length > 0 ? this.strText[this.idxSelect] : '',
            info: this.strInfoText.length > 0 ? this.strInfoText[this.idxSelect] : '',
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
    // Clear stale pending timers (parseVersion guards correctness, safe to cancel)
    if (this.timerIds.length > 0) {
      for (let i = 0; i < this.timerIds.length; i++) {
        clearTimeout(this.timerIds[i])
      }
      this.timerIds = []
    }
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
   * @param changedIndices 变化的索引数组
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

    if (changedIndices.length === 0) {
      return
    }

    // 仅在真正需要解析时递增版本号
    // 避免changedIndices为空时递增parseVersion导致正在进行的有效解析结果被丢弃
    this.parseVersion++
    const currentVersion = this.parseVersion

    if (this.codeBlockTheme.codeBlockParserSync) {
      this.parseChangedCodeSync(changedIndices, currentVersion)
    } else {
      this.parseChangedCodeAsync(changedIndices, currentVersion)
    }
  }

  /**
   * 异步解析变化的代码块高亮
   * 原地修改CodeBlockData.blocks属性，@ObjectLink触发子组件原地刷新
   *
   * @param changedIndices 变化的索引数组
   */
  parseChangedCodeAsync(changedIndices: number[], currentVersion: number): void {
    for (let i = 0; i < changedIndices.length; i++) {
      let idx = changedIndices[i]
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
      let timerId = setTimeout(() => {
        if (!this.isAlive || currentVersion < this.parseVersion) {
          return
        }
        codeStringToColorString(codeText, info, this.codeBlockTheme.codeBlockIsDark).then((prismRes: PrismRes) => {
          if (!this.isAlive || currentVersion < this.parseVersion) {
            return
          }
          if (idx >= this.blocksDataList.length) {
            return
          }
          // 原地修改CodeBlockData属性，@ObjectLink触发子组件刷新（不重建）
          this.blocksDataList[idx].blocks = Array.from(prismRes.getListColor())
          this.blocksDataList[idx].defaultFontColor = prismRes.getDefaultFontColor()
        }).catch(() => {
          console.error('CodeBlockList codeStringToColorString failed')
        })
      }, 0)
      this.timerIds.push(timerId)
    }
  }

  /**
   * 同步解析变化的代码块高亮
   * 原地修改CodeBlockData.blocks属性，@ObjectLink触发子组件原地刷新
   *
   * @param changedIndices 变化的索引数组
   * @return Promise<void>，解析完成后resolve
   */
  async parseChangedCodeSync(changedIndices: number[], currentVersion: number): Promise<void> {
    for (let i = 0; i < changedIndices.length; i++) {
      let idx = changedIndices[i]
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
        if (!this.isAlive || currentVersion < this.parseVersion) {
          break
        }
        let prismRes: PrismRes = await codeStringToColorString(codeText, info, this.codeBlockTheme.codeBlockIsDark)
        if (!this.isAlive || currentVersion < this.parseVersion) {
          break
        }
        if (idx >= this.blocksDataList.length) {
          break
        }
        // 原地修改CodeBlockData属性，@ObjectLink触发子组件刷新（不重建）
        this.blocksDataList[idx].blocks = Array.from(prismRes.getListColor())
        this.blocksDataList[idx].defaultFontColor = prismRes.getDefaultFontColor()
      } catch (e) {
        console.error('CodeBlockList parseNextBlockAsync failed: ' + JSON.stringify(e))
      }
    }
  }
}
