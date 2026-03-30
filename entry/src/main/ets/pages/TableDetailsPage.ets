/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { TableData } from '../model/TableData'

@Entry
@Component
struct TableDetailsPage {
  /**
   * 滑动控制器
   */
  scroller: Scroller = new Scroller()
  /**
   * Markdown的控制器
   */
  markdownScroller: MarkdownScroller = new MarkdownScroller()
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop')
  safeTop: number = 0
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
   * 是否全量加载Markdown文本
   */
  @State
  isFull: boolean = true
  /**
   * 是否增量解析Markdown文本
   */
  @State
  incrementalAnalysis: boolean = false
  /**
   * 增量加载每次间隔时间
   */
  @State
  time: number = 50
  /**
   * 增量每次增量文本数量
   */
  @State
  textNumber: number = 10
  /**
   * 是否同步解析Markdown文本
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
  typeWriterColor: number | undefined = undefined
  /**
   * 是否打开长按复制粘贴效果
   */
  @State
  isOnCopy: boolean = false
  /**
   * Markdown文本第一个模块上边距
   */
  @State
  blockFirstTopMargin: number = 8
  /**
   * Markdown文本最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8
  /**
   * Markdown文本模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8
  /**
   * 是否允许markdown控件自身响应滑动
   */
  @State
  openGestureSwipe: boolean = false
  /**
   * 是否开启响应滑动测试
   */
  @State
  openGestureSwipeTest: boolean = false
  /**
   * 流式输入是否输入结束(true:结束输入,false:持续输入)
   */
  @State
  isInputEnded: boolean = false

  // ---------- 专有
  /**
   * 表格内容内边距
   */
  @State
  tableCellPadding: number = 4.0
  /**
   * 表格边框颜色
   */
  @State
  tableBorderColor: number | undefined = undefined
  /**
   * 表格边框宽度
   */
  @State
  tableBorderWidth: number = 1.0
  /**
   * 表格奇数行背景色
   */
  @State
  tableOddRowBackgroundColor: number | undefined = undefined
  /**
   * 表格偶数行背景色
   */
  @State
  tableEvenRowBackgroundColor: number | undefined = undefined
  /**
   * 表格标题背景色
   */
  @State
  tableHeaderRowBackgroundColor: number | undefined = undefined
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
   * 表格标题文本行高
   */
  @State
  tableTitleLineHeight: number = 22
  /**
   * 表格标题文本大小
   */
  @State
  tableTitleTextSize: number = 14
  /**
   * 表格标题文本颜色
   */
  @State
  tableTitleTextColor: number | undefined = undefined
  /**
   * 表格内容文本行高
   */
  @State
  tableContentTextLineHeight: number = 22
  /**
   * 表格内容文本大小
   */
  @State
  tableContentTextSize: number = 14
  /**
   * 表格内容文本颜色
   */
  @State
  tableContentTextColor: number | undefined = undefined
  /**
   * 是否显示滚动条
   */
  @State
  tableScrollBarShow: boolean = false
  /**
   * 表格滚动条颜色
   */
  @State
  tableScrollBarColor: number | undefined = undefined

  aboutToAppear(): void {
    try {
      let tableData: TableData = router.getParams() as TableData
      this.fileStr = getFileContextStr(tableData._pagePath)
      // ---------- 通用
      this.isFull = tableData._isFull
      this.incrementalAnalysis = tableData._incrementalAnalysis
      this.time = tableData._time
      this.textNumber = tableData._textNumber
      this.isMarkdownParserSync = tableData._isMarkdownParserSync
      this.typeWriterOpen = tableData._typeWriterOpen
      this.typeWriterColor = tableData._typeWriterColor
      this.isOnCopy = tableData._isOnCopy
      this.blockFirstTopMargin = tableData._blockFirstTopMargin
      this.blockLastBottomMargin = tableData._blockLastBottomMargin
      this.blockTopAndBottomMargins = tableData._blockTopAndBottomMargins
      this.openGestureSwipe = tableData._openGestureSwipe
      this.openGestureSwipeTest = tableData._openGestureSwipeTest
      // ---------- 专有
      this.tableCellPadding = tableData._tableCellPadding
      this.tableBorderColor = tableData._tableBorderColor
      this.tableBorderWidth = tableData._tableBorderWidth
      this.tableOddRowBackgroundColor = tableData._tableOddRowBackgroundColor
      this.tableEvenRowBackgroundColor = tableData._tableEvenRowBackgroundColor
      this.tableHeaderRowBackgroundColor = tableData._tableHeaderRowBackgroundColor
      this.tableRadius = tableData._tableRadius
      this.tableMinTextWidth = tableData._tableMinTextWidth
      this.tableMaxTextWidth = tableData._tableMaxTextWidth
      this.tableFirstColumnBold = tableData._tableFirstColumnBold
      this.tableTitleLineHeight = tableData._tableTitleLineHeight
      this.tableTitleTextSize = tableData._tableTitleTextSize
      this.tableTitleTextColor = tableData._tableTitleTextColor
      this.tableContentTextLineHeight = tableData._tableContentTextLineHeight
      this.tableContentTextSize = tableData._tableContentTextSize
      this.tableContentTextColor = tableData._tableContentTextColor
      this.tableScrollBarShow = tableData._tableScrollBarShow
      this.tableScrollBarColor = tableData._tableScrollBarColor
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
        if (this.openGestureSwipeTest) { // 允许滑动响应测试，生效前提高度设置为100%
          Column() {
            CJMarkdown({
              content: this.content,
              isInputEnded: this.isInputEnded,
              incrementalAnalysis: this.incrementalAnalysis,
              listScroller: this.markdownScroller,
              config: this.setMarkdownConfig(),
              plugin: this.setPlugin()
            })
          }.height("100%")
        } else {
          Column() {
            CJMarkdown({
              content: this.content,
              isInputEnded: this.isInputEnded,
              incrementalAnalysis: this.incrementalAnalysis,
              listScroller: this.markdownScroller,
              config: this.setMarkdownConfig(),
              plugin: this.setPlugin()
            })
          }
        }
      }
      .align(Alignment.TopStart)
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setContext(getContext(this)) // 上下文

    theme.setIsMarkdownParserSync(this.isMarkdownParserSync) // markdown是否同步解析
    theme.setTypeWriterOpen(this.typeWriterOpen) // 是否开启打字机效果
    if (this.typeWriterColor !== undefined) {
      theme.setTypeWriterColor(this.typeWriterColor) // 打字机效果颜色
    }
    theme.setIsOnCopy(this.isOnCopy) // 是否打开长按复制粘贴
    theme.setBlockFirstTopMargin(this.blockFirstTopMargin) // markdown第一个模块上边距
    theme.setBlockLastBottomMargin(this.blockLastBottomMargin) // markdown最后一个模块下边距
    theme.setBlockTopAndBottomMargins(this.blockTopAndBottomMargins) // 模块间上下间距
    theme.setOpenGestureSwipe(this.openGestureSwipe) // 是否允许markdown控件自身响应滑动

    theme.setTableCellPadding(this.tableCellPadding) // 表格内容内边距
    if (this.tableBorderColor !== undefined) {
      theme.setTableBorderColor(this.tableBorderColor) // 表格边框颜色
    }
    theme.setTableBorderWidth(this.tableBorderWidth) // 表格边框宽度
    if (this.tableOddRowBackgroundColor !== undefined) {
      theme.setTableOddRowBackgroundColor(this.tableOddRowBackgroundColor) // 表格奇数行背景色
    }
    if (this.tableEvenRowBackgroundColor !== undefined) {
      theme.setTableEvenRowBackgroundColor(this.tableEvenRowBackgroundColor) // 表格偶数行背景色
    }
    if (this.tableHeaderRowBackgroundColor !== undefined) {
      theme.setTableHeaderRowBackgroundColor(this.tableHeaderRowBackgroundColor) // 表格标题背景色
    }
    theme.setTableRadius(this.tableRadius) // 表格圆角
    theme.setTableMinTextWidth(this.tableMinTextWidth) // 表格最小宽度
    theme.setTableMaxTextWidth(this.tableMaxTextWidth) // 表格最大宽度
    theme.setTableFirstColumnBold(this.tableFirstColumnBold) // 表格第一列是否加粗
    theme.setTableTitleLineHeight(this.tableTitleLineHeight) // 表格标题文本行高
    theme.setTableTitleTextSize(this.tableTitleTextSize) // 表格标题文本大小
    if (this.tableTitleTextColor !== undefined) {
      theme.setTableTitleTextColor(this.tableTitleTextColor) // 表格标题文本颜色
    }
    if (this.tableTitleTextColor !== undefined) {}
    theme.setTableContentTextLineHeight(this.tableContentTextLineHeight) // 表格内容文本行高
    theme.setTableContentTextSize(this.tableContentTextSize) // 表格内容文本大小
    if (this.tableContentTextColor !== undefined) {
      theme.setTableContentTextColor(this.tableContentTextColor) // 表格内容文本颜色
    }
    theme.setTableScrollBarShow(this.tableScrollBarShow) // 表格是否显示滚动条
    if (this.tableScrollBarColor !== undefined) {
      theme.setTableScrollBarColor(this.tableScrollBarColor) // 表格滚动条颜色
    }

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