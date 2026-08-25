import { CJMarkdown,
  CustomViewRegistry,
  MarkdownConfiguration, MarkdownPlugin,
  MarkdownTheme } from '@cangjie-tpc/markdown_arkui'
import { SDUIView } from 'sdui'
import { titleComponent } from '../component/BaseComponent'
import { router } from '@kit.ArkUI'
import { getFileContextStr } from '../utils/FileUtils'
import { BaseMDData } from '../model/BaseMDData'
import { ConfigurationConstant } from '@kit.AbilityKit'

/**
 * SDUI卡片混合渲染详情页
 *
 * 1. 注册 <sdui> 标签名（markdown_arkui CustomViewRegistry 全局注册表，控制解析层拦截）
 * 2. 开启 HtmlPlugin（HtmlBlock 是 <sdui> 标签的解析载体）
 * 3. CJMarkdown 渲染混合文档：普通markdown段正常渲染，
 *    <sdui data='...'></sdui> 块经 customTagViewComponent 回调本页Builder渲染SDUI原生卡片
 */
@Entry
@Component
struct SduiCardDetailsPage {
  // ---------- 通用
  scroller: Scroller = new Scroller() // 滑动控制器
  markdownScroller: Scroller = new Scroller() // Markdown的控制器
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  @StorageProp('currentColorMode') // 深浅色模式
  currentColorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
  @State // markdown文本
  content: string = ""
  @State // markdown配置
  markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration()
  @State // markdown主题
  markdownTheme: MarkdownTheme = new MarkdownTheme()
  @State // markdown插件
  markdownPlugin: MarkdownPlugin = new MarkdownPlugin()

  /**
   * <sdui data='SDUI JSON'></sdui> 标签的渲染Builder
   * 从 data 属性取出 SDUI DSL JSON，交给 SDUIView（Cangjie解析 + Yoga布局 + CAPI原生渲染）
   */
  @Builder
  SduiTagViewBuilder(tag: string, attrs: Record<string, string>, content: string) { /* cjlint-ignore !G.FUN.02 */
    if (tag === 'sdui') {
      Column() {
        SDUIView({ json: attrs['data'] ?? '' })
      }
    }
  }

  aboutToAppear(): void {
    // 注册 <sdui> 标签名（幂等）：解析层据此拦截 <sdui> HTML块
    CustomViewRegistry.register('sdui')

    let baseMDData: BaseMDData = router.getParams() as BaseMDData
    this.content = getFileContextStr(baseMDData._pagePath)

    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = new MarkdownConfiguration()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
  }

  build() {
    Column() {
      titleComponent(
        "SDUI卡片混合渲染",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll(this.scroller) {
        Column() {
          CJMarkdown({
            content: this.content,
            scroller: this.markdownScroller,
            config: this.markdownConfiguration,
            plugin: this.markdownPlugin,
            customTagViewComponent: this.SduiTagViewBuilder
          })
        }
      }
      .align(Alignment.TopStart)
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
  }

  setMarkdownTheme(): MarkdownTheme {
    let theme = new MarkdownTheme()
    if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      theme.setDefaultTheme()
    } else {
      theme.setDarculaTheme()
    }
    return theme
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin()
    plugin.setIsHtmlPlugin(true) // HtmlPlugin：HtmlBlock 是 <sdui> 标签的解析载体
    plugin.setIsTablePlugin(true) // 表格插件
    plugin.setIsStrikethroughPlugin(true) // 删除线插件
    plugin.setIsTaskListPlugin(true) // 任务列表插件
    return plugin
  }
}
