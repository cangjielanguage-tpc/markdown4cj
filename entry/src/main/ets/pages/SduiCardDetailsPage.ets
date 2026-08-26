import { CJMarkdown,
  CustomViewRegistry,
  MarkdownConfiguration, MarkdownPlugin,
  MarkdownTheme } from '@cangjie-tpc/markdown_arkui'
import { SDUIView, installSduiHostRegistry } from 'sdui'
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
  @State // SDUI卡片点击次数（click 用例验证）
  sduiClickCount: number = 0
  @State // SDUI卡片最近一次点击的label（data 透传验证）
  sduiClickLabel: string = ""

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
    // 注册SDUI卡片点击action（幂等替换）
    // 注意：native侧固定以 'phase1Callback' 名分发（见 SDUI NativeActionRegistry.nativeActionNameFor），
    // DSL actions里声明的 target/data 通过 payload（action原文JSON）透传，在此解析路由。
    // 点击链路：卡片按钮onClick → Cangjie分发('phase1Callback') → SDUI_HOST_REGISTRY → 此handler
    installSduiHostRegistry().setAction('phase1Callback',
      (payload: string, _meta: string): string => {
        try {
          // payload形如 {"trigger":"onClick","type":"callback","target":"onSduiCardClick","data":{"label":"..."}}
          const action = JSON.parse(payload) as Record<string, Object>
          const target = action['target']
          if (target === 'onSduiCardClick') {
            this.sduiClickCount += 1
            const data = action['data']
            const label = data instanceof Object ? (data as Record<string, Object>)['label'] : undefined
            this.sduiClickLabel = typeof label === 'string' ? label : ''
            this.dispatchSduiCardClick(this.sduiClickLabel)
          }
        } catch (_) {
          // 非本用例的action，忽略
        }
        return `OK_SDUI_CARD_CLICK count=${this.sduiClickCount}`
      })

    // SDUI 标准跳转事件（type=link）：native侧固定以 'phase1Link' 名分发，
    // 跳转目标由 DSL actions.target 声明（本用例为 pages/BlankPage）。
    // 点击链路：卡片按钮onClick → Cangjie分发('phase1Link') → SDUI_HOST_REGISTRY → 此handler执行路由
    installSduiHostRegistry().setAction('phase1Link',
      (payload: string, _meta: string): string => {
        try {
          // payload形如 {"trigger":"onClick","type":"link","target":"pages/BlankPage"}
          const action = JSON.parse(payload) as Record<string, Object>
          const target = action['target']
          if (typeof target === 'string' && target.startsWith('pages/')) {
            this.sduiClickCount += 1
            this.sduiClickLabel = '立即预订(link)'
            router.pushUrl({ url: target })
            return `OK_SDUI_LINK target=${target}`
          }
          return `ERR_LINK_TARGET_UNSUPPORTED target=${target}`
        } catch (_) {
          return 'ERR_LINK_PAYLOAD_INVALID'
        }
      })

    let baseMDData: BaseMDData = router.getParams() as BaseMDData
    this.content = getFileContextStr(baseMDData._pagePath)

    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = new MarkdownConfiguration()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
  }

  /**
   * 按钮点击分发（003用例）：
   * - 查看详情：弹框显示酒店详细信息
   * （立即预订走 type=link 标准跳转事件，由 phase1Link handler 路由）
   */
  private dispatchSduiCardClick(label: string): void {
    if (label === '查看详情') {
      AlertDialog.show({
        title: '外滩景观大酒店',
        message: '房型：黄浦江景房\n权益：免费升房\n价格：¥1288 起\n\n点击来源：SDUI 卡片「查看详情」按钮',
        autoCancel: true,
        alignment: DialogAlignment.Center,
        primaryButton: {
          value: '关闭',
          action: () => {
          }
        }
      })
    }
  }

  build() {
    Column() {
      titleComponent(
        "SDUI卡片混合渲染",
        0xFF317AFF,
        true,
        this.safeTop
      )
      // SDUI卡片点击验证状态栏：点击卡片按钮后计数+label实时更新
      Text(this.sduiClickCount > 0
        ? `点击验证：第${this.sduiClickCount}次 · ${this.sduiClickLabel}`
        : '点击验证：尚未点击（点击下方卡片按钮）')
        .fontSize(13)
        .fontColor(this.sduiClickCount > 0 ? '#FF166534' : '#FF6B7280')
        .backgroundColor(this.sduiClickCount > 0 ? '#FFDCFCE7' : '#FFF3F4F6')
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .borderRadius(6)
        .margin({ top: 8, bottom: 4 })
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
