import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseMDData } from '../model/BaseMDData'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import { booleanListGeneralData, textNumberListGeneralData } from '../model/GeneralData'

/**
 * 超链接曝光配置页面
 */
@Entry
@Component
struct LinkExposurePage {
  // ---------------- 通用
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop')
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "038_LinkExposure"
  @State
  folderList: Array<string> = new Array<string>()
  isFullList: Array<boolean> = booleanListGeneralData
  @State
  isFull: boolean = true
  textNumberList: Array<number> = textNumberListGeneralData
  @State
  textNumber: number = 10
  // 曝光阈值列表
  exposureThresholdList: Array<number> = [0, 0.1, 0.2, 0.3, 0.5, 0.8, 1]
  @State // 曝光可见阈值(0~1)
  exposureThreshold: number = 0.5
  heightMD: number = 30
  @State
  baseData: BaseMDData = new BaseMDData()
  @State isExpanded1: boolean = false

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "超链接曝光配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // md文档选择部分
      Column() {
        GridRow({
          columns: 3,
          gutter: { x: 5, y: 5 },
          breakpoints: {
            value: ['400vp', '600vp', '800vp'],
            reference: BreakpointsReference.ComponentSize
          },
          direction: GridRowDirection.Row
        }) {
          ForEach(this.folderList, (item: string, index: number) => {
            GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 }, offset: 0, order: 0 }) {
              Text(`${item}`)
                .fontSize(12)
                .fontColor(0xFFFFFFFF)
                .backgroundColor(0xFF2196F3)
                .height(25)
                .padding(5)
                .borderRadius(5)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Clip })
                .onClick(() => {
                  this.baseData._isFull = this.isFull
                  this.baseData._textNumber = this.textNumber
                  this.baseData._pagePath = `${this.rawFilePath}/${item}`
                  router.pushUrl({ url: "pages/LinkExposureDetailsPage", params: this.baseData })
                })
            }
          })
        }.width('100%').height('100%')
      }.padding({ top: 5, bottom: 5 }).width('100%').height(this.heightMD)

      Scroll() {
        Column() {
          Column() {
            Row() {
              Text("曝光配置")
                .fontSize(16)
                .fontColor(0xFFF5F5F5)
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded1 ? "▲" : "▼")
                .fontSize(16)
                .fontColor(0xFFF5F5F5)
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
                  titleStr: "是否全量加载Markdown文本 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isFullList,
                  allData: this.isFull
                })
                BaseTabComponent({
                  titleStr: "曝光阈值（0=露一点即报，1=完全可见才报） - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.exposureThresholdList,
                  allData: this.exposureThreshold
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
        }
        .padding({ top: 10, bottom: 100 })
      }
    }
    .backgroundColor(0xFFEAEAEA)
    .height("90%")
  }
}
