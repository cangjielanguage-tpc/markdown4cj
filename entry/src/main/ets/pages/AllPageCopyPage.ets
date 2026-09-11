import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseMDData } from '../model/BaseMDData'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import { booleanListGeneralData, timeListGeneralData, textNumberListGeneralData } from '../model/GeneralData'

/**
 * 全文复制配置页面
 */
@Entry
@Component
struct AllPageCopyPage {
  // ---------------- 通用
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop')
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "029_Comprehensive"
  @State
  folderList: Array<string> = new Array<string>()
  isFullList: Array<boolean> = booleanListGeneralData
  @State
  isFull: boolean = true
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  @State
  incrementalAnalysis: boolean = false
  // 是否启用解析节流列表
  enableParseThrottleList: Array<boolean> = booleanListGeneralData
  @State // 是否启用解析节流
  enableParseThrottle: boolean = false
  // 解析节流间隔列表
  parseThrottleMsList: Array<number> = timeListGeneralData
  @State // 解析节流间隔（ms）
  parseThrottleMs: number = 200
  timeList: Array<number> = timeListGeneralData
  @State
  time: number = 50
  textNumberList: Array<number> = textNumberListGeneralData
  @State
  textNumber: number = 10
  @State
  baseData: BaseMDData = new BaseMDData()
  @State isExpanded1: boolean = false

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "全文复制配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // md文档选择部分
      Scroll() {
        Grid() {
          ForEach(this.folderList, (item: string, index: number) => {
            GridItem() {
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
                  this.baseData._incrementalAnalysis = this.incrementalAnalysis
                  this.baseData._enableParseThrottle = this.enableParseThrottle
                  this.baseData._parseThrottleMs = this.parseThrottleMs
                  this.baseData._time = this.time
                  this.baseData._textNumber = this.textNumber
                  this.baseData._pagePath = `${this.rawFilePath}/${item}`
                  router.pushUrl({ url: "pages/AllPageCopyDetailsPage", params: this.baseData })
                })
            }
          })
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

      Scroll() {
        Column() {
          Column() {
            Row() {
              Text("通用配置")
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
                  titleStr: "是否增量解析Markdown文本 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.incrementalAnalysisList,
                  allData: this.incrementalAnalysis
                })
                BaseTabComponent({
                  titleStr: "是否启用解析节流 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.enableParseThrottleList,
                  allData: this.enableParseThrottle
                })
                BaseTabComponent({
                  titleStr: "解析节流间隔(ms) - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.parseThrottleMsList,
                  allData: this.parseThrottleMs
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
