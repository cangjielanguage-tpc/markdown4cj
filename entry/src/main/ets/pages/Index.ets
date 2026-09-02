import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme} from '@cangjie-tpc/markdown_arkui'
import { COLOR_RED } from '../base/Constants';

@Entry
@Component
struct DemoPage {
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  /**
   * md文本
   */
  @State message: string = '### 标题1\n' +
    '\n' +
    '# 1级标题\n' +
    '\n' +
    '### 标题2\n' +
    '\n' +
    '## 2级标题\n' +
    '\n' +
    '### 标题3\n' +
    '\n' +
    '### 3级标题\n' +
    '\n' +
    '### 标题4\n' +
    '\n' +
    '#### 4级标题\n' +
    '\n' +
    '### 标题5\n' +
    '\n' +
    '##### 5级标题\n' +
    '\n' +
    '### 标题6\n' +
    '\n' +
    '###### 6级标题\n' +
    '\n' +
    '### 标题7\n' +
    '\n' +
    '### 正常标题\n' +
    '\n' +
    '### 标题8\n' +
    '\n' +
    'Heading level 1\n' +
    '===============\n' +
    '\n' +
    '### 标题9\n' +
    '\n' +
    'Heading level 2\n' +
    '---------------\n' +
    '\n' +
    '### 标题10\n' +
    '\n' +
    'Heading level 1\n' +
    '=\n' +
    '\n' +
    '### 标题11\n' +
    '\n' +
    'Heading level 2\n' +
    '-\n';

  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()

  indexList: Array<string> = []
  @State indexCount: number = 0

  aboutToAppear(): void {
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
  }

  build() {
    Column() {
      Row() {
        Button('获取' + this.indexCount)
          .onClick(() => {
            this.indexList = this.setMarkdownTheme3()
            this.indexCount = this.indexList.length
          })
        Button('第一')
          .onClick(() => {
            this.setMarkdownTheme(this.indexList[0])
          })
        Button('第二')
          .onClick(() => {
            this.setMarkdownTheme(this.indexList[1])
          })
        Button('最后')
          .onClick(() => {
            this.setMarkdownTheme(this.indexList[this.indexList.length - 1])
          })
        Button('清除第二')
          .onClick(() => {
            this.setMarkdownTheme2(this.indexList[1])
          })
      }

      Column() {
        CJMarkdown({
          content: this.message,
          config: this.markdownConfiguration,
          plugin: this.markdownPlugin
        })
      }
    }
    .padding({ left: 10, right: 10, top: this.safeTop })
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  setMarkdownTheme(h: string): void {
    this.markdownConfiguration.markdownHighlightParagraph.setParagraphHighlight(h, COLOR_RED)
  }

  setMarkdownTheme2(h: string): void {
    this.markdownConfiguration.markdownHighlightParagraph.clearParagraphHighlight(h)
  }

  setMarkdownTheme3(): Array<string> {
    return this.markdownConfiguration.markdownHighlightParagraph.getAllParagraphItems()
  }
}