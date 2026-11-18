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
  rawFilePath: string = "037_LinkExposure"
  @State folderList: Array<string> = []
  @State linkExposureData: LinkExposureData = new LinkExposureData()
  @State isExpanded1: boolean = false // 控制展开/折叠状态
  @State isExpanded2: boolean = false // 控制展开/折叠状态

  // 曝光测试开关
  exposureThresholdList: Array<number> = [0, 0.3, 0.5, 0.8, 1.0]
  @State exposureThreshold: number = 0.5
  tableStickyHeaderList: Array<boolean> = booleanListGeneralData
  @State tableStickyHeader: boolean = false
  isLinkifyPluginList: Array<boolean> = booleanListGeneralData
  @State isLinkifyPlugin: boolean = false

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent("链接曝光配置", 0xFF317AFF, true, this.safeTop)
      // md文档展示部分
      Column() {
        Scroll() {
          Grid() {
            ForEach(this.folderList, (item: string) => {
              GridItem() {
                Text(`${item}`)
                  .fontSize(12)
                  .fontColor('#FFFFFFFF')
                  .backgroundColor('#FF2196F3')
                  .height(25)
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
          }
          .columnsGap(5)
          .rowsGap(5)
          .maxCount(5)
          .minCount(1)
          .cellLength(30)
          .layoutDirection(GridDirection.Row)
          .padding(5)
        }
        .constraintSize({ maxHeight: 200 })
        .width('100%')
        .backgroundColor(0xFFEAEAEA)
      }

      Scroll() {
        Column() {
          Column() {
            Row() {
              Text("曝光测试配置")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded1 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded1 = !this.isExpanded1
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded1 = !this.isExpanded1
            })

            if (this.isExpanded1) {
              Column() {
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
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)

          Column() {
            Row() {
              Text("使用说明")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded2 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded2 = !this.isExpanded2
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded2 = !this.isExpanded2
            })

            if (this.isExpanded2) {
              Column() {
                Text("1. 选md文件进入详情页，滚动Markdown内容\n2. 屏幕底部实时显示曝光事件（显示=绿/消失=红）\n3. 001_段落=垂直滚动验证；002_表格=横向滚动+吸顶验证；003_混合=全场景\n4. 阈值0.5=链接50%面积可见才报，水平+垂直双向裁剪\n5. hilog同步输出 ---elementExposure 行")
                  .fontSize(12)
                  .fontColor('#FFFFFFFF')
                  .width('100%')
                  .padding({ top: 4, bottom: 4 })
              }
              .width('100%')
              .padding({ bottom: 5, left: 5, right: 5 })
              .margin({ bottom: 5, left: 5, right: 5 })
            }
          }
          .width('100%')
          .margin(5)
          .borderRadius(5)
          .backgroundColor(0xFF317AFF)
        }
      }
      .layoutWeight(1)
      .align(Alignment.TopStart)
    }
    .backgroundColor('#FFEAEAEA')
    .height("100%")
  }
}
