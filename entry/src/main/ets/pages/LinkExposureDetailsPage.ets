import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import {
  CJMarkdown,
  MarkdownConfiguration,
  MarkdownExposureEvent,
  MarkdownPlugin,
  MarkdownTheme,
  TableTheme
} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { LinkExposureData } from '../model/LinkExposureData'
import { ConfigurationConstant } from '@kit.AbilityKit'

/**
 * 屏幕曝光事件列表项（ArkTS要求named interface）
 */
interface ExposureLogItem {
  seq: number // 序号
  visible: boolean // true=显示 false=消失
  url: string // 链接url
}

@Entry
@Component
struct LinkExposureDetailsPage {
  // ---------- 通用
  scroller: Scroller = new Scroller() // 滑动控制器
  markdownScroller: Scroller = new Scroller() // Markdown的控制器
  eventScroller: Scroller = new Scroller() // 屏幕事件列表控制器
  @StorageProp('safeTop') safeTop: number = 0
  @StorageProp('currentColorMode') currentColorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
  @State fileStr: string = ""
  @State content: string = ""
  @State markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State markdownPlugin: MarkdownPlugin = new MarkdownPlugin()
  @State markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  // ---------- 曝光测试配置
  @State exposureThreshold: number = 0.5
  @State tableStickyHeader: boolean = false
  @State isLinkifyPlugin: boolean = false
  // ---------- 屏幕事件列表（最近50条）
  @State exposureEvents: ExposureLogItem[] = []
  private eventSeq: number = 0

  aboutToAppear(): void {
    try {
      let data: LinkExposureData = router.getParams() as LinkExposureData
      this.fileStr = getFileContextStr(data._pagePath)
      this.exposureThreshold = data._exposureThreshold
      this.tableStickyHeader = data._tableStickyHeader
      this.isLinkifyPlugin = data._isLinkifyPlugin
    } catch (e) {
    }
    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = this.setMarkdownConfig()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
    this.content = this.fileStr
  }

  build() {
    Column() {
      titleComponent("链接曝光测试", 0xFF317AFF, true, this.safeTop)
      // 主体：Markdown渲染区
      Scroll(this.scroller) {
        Column() {
          CJMarkdown({
            content: this.content,
            scroller: this.markdownScroller,
            config: this.markdownConfiguration,
            plugin: this.markdownPlugin
          })
        }
      }
      .align(Alignment.TopStart)
      .layoutWeight(1)

      // 底部：屏幕实时曝光事件列表
      Column() {
        Text(`曝光事件（最近${this.exposureEvents.length}条，阈值${this.exposureThreshold}）`)
          .fontSize(12)
          .fontColor(0xFF333333)
          .width('100%')
          .padding({ left: 8, top: 4, bottom: 4 })
          .backgroundColor(0xFFEEEEEE)
        List({ scroller: this.eventScroller }) {
          ForEach(this.exposureEvents, (item: ExposureLogItem) => {
            ListItem() {
              Text(`[${item.seq}] ${item.visible ? '显示' : '消失'} ${item.url}`)
                .fontSize(11)
                .fontColor(item.visible ? 0xFF2E7D32 : 0xFFC62828)
                .width('100%')
                .padding({ left: 8, top: 2, bottom: 2 })
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
          }, (item: ExposureLogItem) => `${item.seq}-${item.visible}-${item.url}`)
        }
        .width('100%')
        .layoutWeight(1)
        .onScrollIndex(() => {
          // 新事件后自动滚到底
        })
      }
      .width('100%')
      .height(180)
      .backgroundColor(0xFFFAFAFA)
      .border({ width: { top: 1 }, color: 0xFFCCCCCC })
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    config.setLinkCallback(this.linkCallBack.bind(this)) // 链接点击回调
    config.setElementExposureCallback(this.elementExposureCallBack.bind(this)) // 元素曝光回调
    config.setExposureThreshold(this.exposureThreshold) // 曝光阈值
    return config
  }

  setMarkdownTheme(): MarkdownTheme {
    let theme = new MarkdownTheme()
    if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      theme.setDefaultTheme()
    } else {
      theme.setDarculaTheme()
    }
    // 表格吸顶（曝光测试关键开关）
    let tableTheme = new TableTheme()
    tableTheme.setTableStickyHeader(this.tableStickyHeader)
    theme.setTableTheme(tableTheme)
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsTablePlugin(true) // 表格插件（表格内链接曝光必备）
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    plugin.setIsDescListPlugin(true) // 定义列表插件
    if (this.isLinkifyPlugin) {
      plugin.setIsLinkifyPlugin(true) // 链接自动解析插件（纯文本URL转链接）
    }
    return plugin
  }

  /**
   * 链接点击回调
   */
  linkCallBack(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  /**
   * 元素曝光回调：链接显示/消失时触发
   * 同时打hilog + push到屏幕事件列表（限最近50条）
   */
  elementExposureCallBack(event: MarkdownExposureEvent): void {
    hilog.error(1, "1", `---elementExposure type:${event.type} visible:${event.visible} data:${event.data}`)
    const item: ExposureLogItem = {
      seq: ++this.eventSeq,
      visible: event.visible,
      url: event.data
    }
    // 拼接 + 限最近50条（重新赋值确保@State触发更新）
    let next: ExposureLogItem[] = this.exposureEvents.concat([item])
    if (next.length > 50) {
      // 保留最近50条（删头部多余的）
      next = next.slice(next.length - 50)
    }
    this.exposureEvents = next
    // 刷新后下一帧滚到底
    setTimeout(() => {
      try {
        this.eventScroller.scrollEdge(Edge.Bottom)
      } catch (e) {
      }
    }, 0)
  }
}
