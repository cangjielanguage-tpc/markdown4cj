/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from './FileUtils'
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
   * 增量加载延迟
   */
  time: number = 50

  aboutToAppear(): void {
    try {
      let tableData: TableData = router.getParams() as TableData
      this.fileStr = getFileContextStr(tableData._pagePath)
      this.isFull = tableData._isFull
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
              this.content = this.fileStr
            } else {
              let index = 0
              let id = setInterval(() => {
                this.content = this.content + this.fileStr[index]
                this.scroller.scrollEdge(Edge.Bottom)
                if (index === this.fileStr.length - 1) {
                  clearInterval(id)
                }
                index++
              }, this.time)
            }
          }
        )
      Scroll(this.scroller) {
        Column() {
          CJMarkdown({
            content: this.content,
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