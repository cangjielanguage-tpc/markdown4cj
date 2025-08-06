/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from './BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown'
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
  mdStr: string = ""
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
        "标题测试用例",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Button("点击加载markdown")
        .height(40)// 高度
        .width("80%")// 宽度
        .type(ButtonType.Capsule)// 圆角
        .margin({ top: 5, bottom: 5 })// 外边距
        .fontColor(0xFFFFFFFF)// 文本颜色
        .backgroundColor(0xFF317AFF)// 背景颜色
        .align(Alignment.Center)// 内容对齐方式
        .fontSize(16)// 字体大小
        .onClick(
          () => {
            // 点击动作触发该方法调用
            if (this.isFull) {
              this.mdStr = this.fileStr
            } else {
              let index = 0
              let id = setInterval(() => {
                this.mdStr = this.mdStr + this.fileStr[index]
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
            mdStr: this.mdStr,
            isFull: this.isFull,
            cfg: this.setMarkdownConfig(),
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
    theme.setTableCellPadding(this.tableCellPadding)
    theme.setTableBorderColor(this.tableBorderColor)
    theme.setTableBorderWidth(this.tableBorderWidth)
    theme.setTableOddRowBackgroundColor(this.tableOddRowBackgroundColor)
    theme.setTableEvenRowBackgroundColor(this.tableEvenRowBackgroundColor)
    theme.setTableHeaderRowBackgroundColor(this.tableHeaderRowBackgroundColor)
    theme.setTableTextLineHeight(this.tableTextLineHeight)
    theme.setTableRadius(this.tableRadius)
    theme.setTableMinTextWidth(this.tableMinTextWidth)
    theme.setTableMaxTextWidth(this.tableMaxTextWidth)
    theme.setTableFirstColumnBold(this.tableFirstColumnBold)
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true)
    plugin.setIsLatexMathPlugin(true)
    return plugin
  }
}