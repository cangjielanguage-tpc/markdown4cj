/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import { CodeListData } from './CodeListPage'

@Entry
@Component
struct CodeListDetailsPage {
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
   * 组合代码未选中标题字体大小
   */
  codeListTitleTextSize: number = 13
  /**
   * 组合代码选中标题字体大小
   */
  codeListTitleSelectTextSize: number = 13
  /**
   * 组合代码选中标题文本颜色
   */
  codeListTitleSelectTextColor: number = 0xFFFF0000
  /**
   * 组合代码未选中标题文本颜色
   */
  codeListTitleUnSelectTextColor: number = 0xFF000000
  /**
   * 组合代码选中标题背景颜色
   */
  codeListTitleSelectBackGroupColor: number = 0xFF191919
  /**
   * 组合代码未选中标题背景颜色
   */
  codeListTitleUnSelectBackGroupColor: number = 0x00FFFFFF
  /**
   * 增量加载延迟
   */
  time: number = 50
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
  blockFirstTopMargin: number = 8
  /**
   * markdown最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8
  /**
   * 模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8

  aboutToAppear(): void {
    try {
      let codeListData: CodeListData = router.getParams() as CodeListData
      this.fileStr = getFileContextStr(codeListData._pagePath)
      this.isFull = codeListData._isFull
      this.codeListTitleTextSize = codeListData._codeListTitleTextSize
      this.codeListTitleSelectTextSize = codeListData._codeListTitleSelectTextSize
      this.codeListTitleSelectTextColor = codeListData._codeListTitleSelectTextColor
      this.codeListTitleUnSelectTextColor = codeListData._codeListTitleUnSelectTextColor
      this.codeListTitleSelectBackGroupColor = codeListData._codeListTitleSelectBackGroupColor
      this.codeListTitleUnSelectBackGroupColor = codeListData._codeListTitleUnSelectBackGroupColor
      this.isMarkdownParserSync = codeListData._isMarkdownParserSync
      this.typeWriterOpen = codeListData._typeWriterOpen
      this.typeWriterColor = codeListData._typeWriterColor
      this.isOnCopy = codeListData._isOnCopy
      this.blockFirstTopMargin = codeListData._blockFirstTopMargin
      this.blockLastBottomMargin = codeListData._blockLastBottomMargin
      this.blockTopAndBottomMargins = codeListData._blockTopAndBottomMargins
    } catch (e) {
    }
  }

  build() {
    Column() {
      titleComponent(
        "组合代码块测试用例",
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
      .align(Alignment.TopStart)
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setCodeListTitleTextSize(this.codeListTitleTextSize)
    theme.setCodeListTitleSelectTextSize(this.codeListTitleSelectTextSize)
    theme.setCodeListTitleSelectTextColor(this.codeListTitleSelectTextColor)
    theme.setCodeListTitleUnSelectTextColor(this.codeListTitleUnSelectTextColor)
    theme.setCodeListTitleSelectBackGroupColor(this.codeListTitleSelectBackGroupColor)
    theme.setCodeListTitleUnSelectBackGroupColor(this.codeListTitleUnSelectBackGroupColor)
    theme.setCodeFullScreenIcon($r('app.media.startIcon'))
    theme.setCodeCopyIcon($r('app.media.startIcon'))
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
    plugin.setIsCodeListPlugin(true) // 代码块列表
    return plugin
  }
}