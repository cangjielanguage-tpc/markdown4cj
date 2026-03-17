/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { TableData } from './TablePage'

@Entry
@Component
struct TableDetailsPage {
  /**
   * 滑动控制器
   */
  scroller: Scroller = new Scroller()
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  /**
   * 文件文本
   */
  @State
  fileStr: string = ""
  /**
   * markdown文本
   */
  @State
  content: string = ""
  /**
   * 是否全量加载
   */
  @State
  isFull: boolean = true
  /**
   * markdown是否增量解析(true:增量解析,false:全量解析)
   */
  @State
  incrementalAnalysis: boolean = false
  /**
   * 增量加载每次间隔时间 - 毫秒
   */
  @State
  time: number = 50
  /**
   * 增量每次增量文本数量
   */
  @State
  textNumber: number = 10
  /**
   * 表格内容内边距
   */
  @State
  tableCellPadding: number = 4.0
  /**
   * 表格边框颜色
   */
  @State
  tableBorderColor: number = 0xFF000000
  /**
   * 表格边框宽度
   */
  @State
  tableBorderWidth: number = 1.0
  /**
   * 表格奇数行背景色
   */
  @State
  tableOddRowBackgroundColor: number = 0xFFFFFFFF
  /**
   * 表格偶数行背景色
   */
  @State
  tableEvenRowBackgroundColor: number = 0xFFE0E0E0
  /**
   * 表格头背景色
   */
  @State
  tableHeaderRowBackgroundColor: number = 0xFFFFFFFF
  /**
   * 表格文本行高
   */
  @State
  tableTextLineHeight: number = 22.0
  /**
   * 表格圆角
   */
  @State
  tableRadius: number = 5.0
  /**
   * 表格最小宽度
   */
  @State
  tableMinTextWidth: number = 50.0
  /**
   * 表格最大宽度
   */
  @State
  tableMaxTextWidth: number = 300.0
  /**
   * 表格第一列是否加粗
   */
  @State
  tableFirstColumnBold: boolean = false
  /**
   * 流式输入是否输入结束(true:结束输入,false:持续输入)
   */
  @State
  isInputEnded: boolean = false
  /**
   * markdown是否同步解析
   */
  @State
  isMarkdownParserSync: boolean = false
  /**
   * 是否开启打字机效果
   */
  @State
  typeWriterOpen: boolean = false
  /**
   * 打字机效果颜色
   */
  @State
  typeWriterColor: number = 0xFFFF0000
  /**
   * 是否打开长按复制粘贴
   */
  @State
  isOnCopy: boolean = false
  /**
   * markdown第一个模块上边距
   */
  @State
  blockFirstTopMargin: number = 8.0
  /**
   * markdown最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8.0
  /**
   * 模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8.0

  aboutToAppear(): void {
    try {
      let tableData: TableData = router.getParams() as TableData
      this.fileStr = getFileContextStr(tableData._pagePath)
      this.isFull = tableData._isFull
      this.incrementalAnalysis = tableData._incrementalAnalysis
      this.time = tableData._time
      this.textNumber = tableData._textNumber
      this.tableCellPadding = tableData._tableCellPadding
      this.tableBorderColor = tableData._tableBorderColor
      this.tableBorderWidth = tableData._tableBorderWidth
      this.tableOddRowBackgroundColor = tableData._tableOddRowBackgroundColor
      this.tableEvenRowBackgroundColor = tableData._tableEvenRowBackgroundColor
      this.tableHeaderRowBackgroundColor = tableData._tableHeaderRowBackgroundColor
      this.tableTextLineHeight = tableData._tableTextLineHeight
      this.tableRadius = tableData._tableRadius
      this.tableMinTextWidth = tableData._tableMinTextWidth
      this.tableMaxTextWidth = tableData._tableMaxTextWidth
      this.tableFirstColumnBold = tableData._tableFirstColumnBold
      this.isMarkdownParserSync = tableData._isMarkdownParserSync
      this.typeWriterOpen = tableData._typeWriterOpen
      this.typeWriterColor = tableData._typeWriterColor
      this.isOnCopy = tableData._isOnCopy
      this.blockFirstTopMargin = tableData._blockFirstTopMargin
      this.blockLastBottomMargin = tableData._blockLastBottomMargin
      this.blockTopAndBottomMargins = tableData._blockTopAndBottomMargins
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "表格测试用例",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Button("点击加载markdown")
        .height(40)
        .width("80%")
        .type(ButtonType.Capsule)
        .margin({ top: 5, bottom: 5 })
        .fontColor(0xFFFFFFFF)
        .backgroundColor(0xFF317AFF)
        .align(Alignment.Center)
        .fontSize(16)
        .onClick(
          () => {
            if (this.isFull) {
              this.isInputEnded = true
              this.content = this.fileStr
            } else {
              this.isInputEnded = false
              let index = 0
              let id = setInterval(() => {
                this.content = this.content + this.fileStr.substring(this.content.length, index)
                this.scroller.scrollEdge(Edge.Bottom)
                if (index >= this.fileStr.length) {
                  this.isInputEnded = true
                  clearInterval(id)
                }
                if (this.fileStr.length > index + this.textNumber) {
                  index = index + this.textNumber
                } else {
                  index = this.fileStr.length
                }
              }, this.time)
            }
          }
        )
      Scroll(this.scroller) {
        Column() {
          CJMarkdown({
            content: this.content,
            isInputEnded: this.isInputEnded,
            incrementalAnalysis: this.incrementalAnalysis,
            config: this.setMarkdownConfig(),
            plugin: this.setPlugin()
          })
        }
      }
      .padding({ bottom: 200 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setContext(getContext(this)) // 上下文
    theme.setTableCellPadding(this.tableCellPadding) // 表格内容内边距
    theme.setTableBorderColor(this.tableBorderColor) // 表格边框颜色
    theme.setTableBorderWidth(this.tableBorderWidth) // 表格边框宽度
    theme.setTableOddRowBackgroundColor(this.tableOddRowBackgroundColor) // 表格奇数行背景色
    theme.setTableEvenRowBackgroundColor(this.tableEvenRowBackgroundColor) // 表格偶数行背景色
    theme.setTableHeaderRowBackgroundColor(this.tableHeaderRowBackgroundColor) // 表格头背景色
    theme.setTableTextLineHeight(this.tableTextLineHeight) // 表格文本行高
    theme.setTableRadius(this.tableRadius) // 表格圆角
    theme.setTableMinTextWidth(this.tableMinTextWidth) // 表格最小宽度
    theme.setTableMaxTextWidth(this.tableMaxTextWidth) // 表格最大宽度
    theme.setTableFirstColumnBold(this.tableFirstColumnBold) // 表格第一列是否加粗
    theme.setTableScrollBarShow(true) // 设置显示滚动条
    theme.setTableScrollBarColor(0xFFFFD700) // 设置滚动条颜色
    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setTypeWriterOpen(this.typeWriterOpen) // 是否开启打字机效果
    theme.setTypeWriterColor(this.typeWriterColor) // 打字机效果颜色
    theme.setIsOnCopy(this.isOnCopy) // 是否打开长按复制粘贴
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin) // markdown第一个模块上边距
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin) // markdown最后一个模块下边距
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins) // 模块间上下间距
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsHtmlPlugin(true) // HTML插件
    return plugin
  }
}