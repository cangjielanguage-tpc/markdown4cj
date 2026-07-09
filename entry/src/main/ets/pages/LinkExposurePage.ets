import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import { booleanListGeneralData } from '../model/GeneralData'
import { LinkExposureData } from '../model/LinkExposureData'

/**
 * 链接曝光测试配置页（第38项）
 * 选md文件 + 曝光阈值/表格吸顶/链接自动解析 三开关 → 跳详情页
 */
@Entry
@Component
struct LinkExposurePage {
  @StorageProp('safeTop') safeTop: number = 0
  rawFilePath: string = "038_LinkExposure"
  @State folderList: Array<string> = []
  @State linkExposureData: LinkExposureData = new LinkExposureData()

  // 曝光测试开关
  exposureThresholdList: Array<number> = [0, 0.3, 0.5, 0.8, 1.0]
  @State exposureThreshold: number = 0.5
  tableStickyHeaderList: Array<boolean> = booleanListGeneralData
  @State tableStickyHeader: boolean = false
  isLinkifyPluginList: Array<boolean> = booleanListGeneralData
  @State isLinkifyPlugin: boolean = false

  // 文件按钮区高度：每行 25 + 行间 gutter 5 + 上下 padding 10。按文件数算行数自适应，
  // 避免文件多于 3 个时第二行被固定高度裁掉、按钮渲染进下方 Scroll 区被抢点击事件。
  private fileRowHeight: number = 25
  private fileRowGutter: number = 5
  private getFileAreaHeight(): number {
    const rows: number = Math.max(1, Math.ceil(this.folderList.length / 3))
    return rows * this.fileRowHeight + (rows - 1) * this.fileRowGutter + 10
  }

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent("链接曝光配置", 0xFF317AFF, true, this.safeTop)

      // md文件选择
      Column() {
        GridRow({
          columns: 3,
          gutter: { x: 5, y: 5 },
          breakpoints: { value: ['400vp', '600vp', '800vp'], reference: BreakpointsReference.ComponentSize },
          direction: GridRowDirection.Row
        }) {
          ForEach(this.folderList, (item: string) => {
            GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 }, offset: 0, order: 0 }) {
              Text(`${item}`)
                .fontSize(12)
                .fontColor('#FFFFFFFF')
                .backgroundColor('#FF2196F3')
                .height(25).width('100%')
                .padding(5)
                .borderRadius(5)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Clip })
                .onClick(() => {
                  this.linkExposureData._pagePath = `${this.rawFilePath}/${item}`
                  this.linkExposureData._exposureThreshold = this.exposureThreshold
                  this.linkExposureData._tableStickyHeader = this.tableStickyHeader
                  this.linkExposureData._isLinkifyPlugin = this.isLinkifyPlugin
                  router.pushUrl({ url: "pages/LinkExposureDetailsPage", params: this.linkExposureData })
                })
            }
          }, (item: string) => item)
        }.width('100%').height('100%')
      }.padding({ top: 5, bottom: 5 }).width('100%').height(this.getFileAreaHeight())

      // 开关配置
      Scroll() {
        Column() {
          Column() {
            Text("曝光测试配置")
              .fontSize(16)
              .fontColor('#FF333333')
              .width('100%')
              .padding({ left: 10, top: 8, bottom: 8 })
            BaseTabComponent({
              titleStr: "曝光阈值（0=露一点即报，1=完全可见才报） - ",
              typeEnum: TypeEnum.IS_NUMBER,
              allListData: this.exposureThresholdList,
              allData: this.exposureThreshold
            })
            BaseTabComponent({
              titleStr: "表格标题行吸顶 - ",
              typeEnum: TypeEnum.IS_BOOLEAN,
              allListData: this.tableStickyHeaderList,
              allData: this.tableStickyHeader
            })
            BaseTabComponent({
              titleStr: "链接自动解析插件（纯文本URL转链接） - ",
              typeEnum: TypeEnum.IS_BOOLEAN,
              allListData: this.isLinkifyPluginList,
              allData: this.isLinkifyPlugin
            })
          }.width('100%').padding({ left: 10, right: 10, bottom: 20 })

          // 使用说明
          Column() {
            Text("使用说明")
              .fontSize(14)
              .fontColor('#FF333333')
              .width('100%')
              .padding({ left: 0, top: 4, bottom: 4 })
            Text("1. 选md文件进入详情页，滚动Markdown内容\n2. 屏幕底部实时显示曝光事件（显示=绿/消失=红）\n3. 001_段落=垂直滚动验证；002_表格=横向滚动+吸顶验证；003_混合=全场景\n4. 阈值0.5=链接50%面积可见才报，水平+垂直双向裁剪\n5. hilog同步输出 ---elementExposure 行")
              .fontSize(12)
              .fontColor('#FF666666')
              .width('100%')
              .padding({ left: 0, top: 4, bottom: 4 })
          }.width('100%').padding({ left: 10, right: 10 })
        }
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
    }
    .alignItems(HorizontalAlign.Center)
  }
}
