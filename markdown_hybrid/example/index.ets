/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme} from '../Index'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct DemoDetailsPage {
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
  fileStr: string = "### 标题1\n" +
    "\n" +
    "# 1级标题\n" +
    "\n" +
    "### 标题2\n" +
    "\n" +
    "## 2级标题\n" +
    "\n" +
    "### 标题3\n" +
    "\n" +
    "### 3级标题\n" +
    "\n" +
    "### 标题4\n" +
    "\n" +
    "#### 4级标题\n" +
    "\n" +
    "### 标题5\n" +
    "\n" +
    "##### 5级标题\n" +
    "\n" +
    "### 标题6\n" +
    "\n" +
    "###### 6级标题\n" +
    "\n" +
    "### 标题7\n" +
    "\n" +
    "### 正常标题\n" +
    "\n" +
    "### 标题8\n" +
    "\n" +
    "Heading level 1\n" +
    "===============\n" +
    "\n" +
    "### 标题9\n" +
    "\n" +
    "Heading level 2\n" +
    "---------------\n" +
    "\n" +
    "### 标题10\n" +
    "\n" +
    "Heading level 1\n" +
    "=\n" +
    "\n" +
    "### 标题11\n" +
    "\n" +
    "Heading level 2\n"
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
   * 增量加载延迟
   */
  time: number = 50

  build() {
    Column() {
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
      .padding({ bottom: 200 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    let theme = new MarkdownTheme()
    theme.setContext(getContext(this))
    config.setMarkdownTheme(theme)
    return config
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsLatexMathPlugin(true) // 数学公式插件
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsLinkifyPlugin(true, []) // 自动链接插件
    plugin.setIsBlockAudioPlugin(true) // 音频插件
    plugin.setIsBlockVideoPlugin(true) // 视频插件
    plugin.setIsImageCollectPlugin(true) // 图片视频列表url集合列表解析插件
    plugin.setIsImageTextMixPlugin(true) // 图文不混排插件
    plugin.setIsImageSlidePlugin(true) // 图片banner
    plugin.setIsCodeListPlugin(true) // 代码块列表
    plugin.setIsImageStylePlugin(true) // 图片样式
    plugin.setIsTocPlugin(true) // TOC插件
    plugin.setIsFootnotePlugin(true) // 脚注
    plugin.setIsHtmlPlugin(true) // Html插件
    plugin.setIsLinkViewPlugin(true) // 链接单独块解析插件
    return plugin
  }
}
