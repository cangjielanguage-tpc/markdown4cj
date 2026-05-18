import { titleComponent } from '../component/BaseComponent'
import {
  CJMarkdown,
  MarkdownConfiguration,
  MarkdownPlugin,
  MarkdownScroller,
  MarkdownTheme
} from '@cangjie-tpc/markdown_hybrid'
import { getFileContextStr, getFileListStr } from '../utils/FileUtils'
import hilog from '@ohos.hilog'
import { ConfigurationConstant } from '@kit.AbilityKit'

@Entry
@Component
struct SwitchDataPage {
  scroller: Scroller = new Scroller() // 滑动控制器
  @StorageProp('safeTop') safeTop: number = 0 // 顶部导航栏高度
  markdownScroller: MarkdownScroller = new MarkdownScroller() // Markdown的控制器
  @StorageProp('currentColorMode') @Watch('onColorModeChange') currentColorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT // 深浅色模式
  @State markdownConfiguration: MarkdownConfiguration = new MarkdownConfiguration() // markdown配置
  @State markdownTheme: MarkdownTheme = new MarkdownTheme() // markdown主题
  @State markdownPlugin: MarkdownPlugin = new MarkdownPlugin() // markdown插件
  @State isRefresh: boolean = true // 刷新标志
  rawFilePath: string = "033_FullTextSwitch" // rawfile路径
  @State folderList: Array<string> = new Array<string>() // rawfile文件夹列表
  @State mdList: Array<string> = new Array<string>() // markdown文档列表
  @State content: string = "" // markdown文本
  i: number = 0

  aboutToAppear(): void {
    this.markdownPlugin = this.setPlugin()
    this.markdownTheme = this.setMarkdownTheme()
    this.markdownConfiguration = this.setMarkdownConfig()
    this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
    for (let index = 0; index < this.folderList.length; index++) {
      const element = `${this.rawFilePath}/${this.folderList[index]}`
      this.mdList.push(getFileContextStr(element))
    }
  }

  build() {
    Column() {
      titleComponent(
        "文本切换测试用例",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Button("点击切换markdown文本")
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
            if(this.i > this.mdList.length -1){
              this.i = 0
            }
            this.content = this.mdList[this.i]
            this.i++
          }
        )
      Scroll(this.scroller) {
        Column() {
          if (this.isRefresh) {
            this.MarkdownBlock()
          } else {
            this.MarkdownBlock()
          }
        }
      }
      .align(Alignment.TopStart)
      .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  MarkdownBlock(){
    CJMarkdown({
      content: this.content,
      isInputEnded: true,
      incrementalAnalysis: false,
      listScroller: this.markdownScroller,
      config: this.setMarkdownConfig(),
      plugin: this.setPlugin()
    })
  }

  onColorModeChange(): void {
    // 根据 this.currentColorMode 更新 UI 或状态栏
    if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      // 浅色模式处理
      this.markdownTheme.setDefaultTheme()
      this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
      hilog.error(1, 'onColorModeChange', '浅色模式')
    } else {
      // 深色模式处理
      this.markdownTheme.setDarculaTheme()
      this.markdownConfiguration.setMarkdownTheme(this.markdownTheme)
      hilog.error(1, 'onColorModeChange', '深色模式')
    }
    this.isRefresh = !this.isRefresh
  }

  setMarkdownConfig(): MarkdownConfiguration {
    let config = new MarkdownConfiguration()
    config.setLinkCallback(this.linkCallBack.bind(this))
    config.setImageCallback(this.imageCallback.bind(this))
    config.setAudioCallback(this.audioCallback.bind(this))
    config.setVideoCallback(this.videoCallback.bind(this))
    config.setVideoImageCallback(this.videoImageCallback.bind(this))
    config.setCodeCopyCallback(this.codeCopyCallback.bind(this))
    config.setCodeFullScreenCallback(this.codeFullScreenCallback.bind(this))
    config.setLatexImageCallback(this.latexCallBack.bind(this))
    config.setTocIndexCallback(this.tocIndexCallback.bind(this))
    config.setFootnoteCallback(this.footnoteCallback.bind(this))
    return config
  }

  setMarkdownTheme(): MarkdownTheme {
    let theme = new MarkdownTheme()
    if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      theme.setDefaultTheme()
    } else {
      theme.setDarculaTheme()
    }

    theme.setCodeFullScreenIcon($r('app.media.startIcon'))
    theme.setCodeCopyIcon($r('app.media.startIcon'))
    theme.setAudioIcon($r('app.media.startIcon'))
    theme.setVideoImage($r('app.media.place_holder'))
    theme.setPlayCircleFillIcon($r('app.media.play_circle_fill'))
    theme.setBannerImage($r('app.media.place_holder'))
    theme.setImageResource($r('app.media.place_holder'))
    theme.setVideoReleaseImage($r('app.media.video_release'))
    theme.setVideoDownloadImage($r('app.media.video_download'))
    theme.setImageDownloadImage($r('app.media.video_download'))

    return theme
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

  linkCallBack(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  imageCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
  }

  audioCallback(url: string): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  videoCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
  }

  videoImageCallback(url: string, cb: (imageUrl: string, aspectRatio: number, time: number) => void): void {
    hilog.error(1, "1", `---url:${url}`)
  }

  codeCopyCallback(code: string): void {
    hilog.error(1, "1", `---code:${code}`)
  }

  codeFullScreenCallback(code: string, type: string | undefined): void {
    hilog.error(1, "1", `---code:${code},type:${type}`)
  }

  latexCallBack(data: ArrayBuffer, heightNumber: number, widthNumber: number): void {
    hilog.error(1, "1", `---data.size:${data.byteLength},heightNumber:${heightNumber},widthNumber:${widthNumber}`)
  }

  tocIndexCallback(y: number | undefined): void {
    if(y !==undefined){
      hilog.error(1, "1", `---y:${y}`)
      let rect = this.markdownScroller.getItemRect(y)
      this.scroller.scrollTo({xOffset:0, yOffset: rect.getItemRectY()})
    }
  }

  footnoteCallback(y: number | undefined): void {
    if(y !==undefined){
      hilog.error(1, "1", `---y:${y}`)
      let rect = this.markdownScroller.getItemRect(y)
      this.scroller.scrollTo({xOffset:0, yOffset: rect.getItemRectY()})
    }
  }
}