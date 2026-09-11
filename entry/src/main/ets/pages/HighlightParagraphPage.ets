import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseMDData } from '../model/BaseMDData'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import { booleanListGeneralData, timeListGeneralData, textNumberListGeneralData } from '../model/GeneralData'

/**
 * 段落高亮配置页面
 */
@Entry
@Component
struct HighlightParagraphPage {
  // ---------------- 通用
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "002_Paragraph"
  @State // rawfile文件夹列表
  folderList: Array<string> = new Array<string>()
  // 是否全量加载Markdown文本列表
  isFullList: Array<boolean> = booleanListGeneralData
  @State // 是否全量加载Markdown文本
  isFull: boolean = true
  // 是否增量解析Markdown文本列表
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  @State // 是否增量解析Markdown文本
  incrementalAnalysis: boolean = false
  // 是否启用解析节流列表
  enableParseThrottleList: Array<boolean> = booleanListGeneralData
  @State // 是否启用解析节流
  enableParseThrottle: boolean = false
  // 解析节流间隔列表
  parseThrottleMsList: Array<number> = timeListGeneralData
  @State // 解析节流间隔（ms）
  parseThrottleMs: number = 200
  // 增量加载每次间隔时间列表
  timeList: Array<number> = timeListGeneralData
  @State // 增量加载每次间隔时间
  time: number = 50
  // 增量每次增量文本数量列表
  textNumberList: Array<number> = textNumberListGeneralData
  @State // 增量每次增量文本数量
  textNumber: number = 10
  @State // 配置数据内容
  baseData: BaseMDData = new BaseMDData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "段落高亮配置页面",
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
                  router.pushUrl({ url: "pages/HighlightParagraphDetailsPage", params: this.baseData })
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
          // 通用配置
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

  @State isExpanded1: boolean = false
}
