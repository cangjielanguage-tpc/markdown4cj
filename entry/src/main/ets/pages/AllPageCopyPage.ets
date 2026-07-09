import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseMDData } from '../model/BaseMDData'

@Entry
@Component
struct AllPageCopyPage {
  // ---------------- 通用
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  @State // rawfile文件夹列表（存储完整相对路径如 "001_Heading/001_Heading.md"）
  folderList: Array<string> = new Array<string>()
  @State isFull: boolean = true
  @State incrementalAnalysis: boolean = false
  @State time: number = 50
  @State textNumber: number = 10
  @State isMarkdownParserSync: boolean = false
  @State isOnCopy: boolean = false
  @State blockMarginTop: number = 0
  @State blockMarginRight: number = 0
  @State blockMarginBottom: number = 0
  @State blockMarginLeft: number = 0
  @State markdownBlockSpacing: number = 8
  @State isLineBreak: boolean = false
  @State globalBackgroundColor: ResourceColor | undefined = undefined
  @State openGestureSwipe: boolean = false
  @State openGestureSwipeTest: boolean = false
  @State baseMDData: BaseMDData = new BaseMDData() // 数据

  aboutToAppear(): void {
    let allFiles: Array<string> = []
    let rootEntries = getFileListStr("") // 获取rawfile根目录下所有条目
    for (let entry of rootEntries) {
      if (entry.indexOf('.') === -1 && entry.indexOf('LargeData') === -1) { // 无扩展名，视为目录
        let subFiles = getFileListStr(`${entry}/`) // 获取目录下文件列表
        for (let subFile of subFiles) {
          if (subFile.endsWith('.md')) {
            allFiles.push(`${entry}/${subFile}`)
          }
        }
      }
    }
    this.folderList = allFiles
  }

  build() {
    Column() {
      titleComponent(
        "全文复制测试页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // md文档展示部分
      Grid() {
        ForEach(this.folderList, (item: string, index: number) => {
          GridItem() {
            Text(`${item}`)
              .fontSize(10)
              .fontColor('#FFFFFFFF')
              .backgroundColor('#FF2196F3')
              .height(25)
              .padding(5)
              .borderRadius(5)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Clip })
              .onClick(() => {
                  // ---------- 通用
                  this.baseMDData._isFull = this.isFull
                  this.baseMDData._incrementalAnalysis = this.incrementalAnalysis
                  this.baseMDData._time = this.time
                  this.baseMDData._textNumber = this.textNumber
                  this.baseMDData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.baseMDData._isOnCopy = this.isOnCopy
                  this.baseMDData._blockMarginTop = this.blockMarginTop
                  this.baseMDData._blockMarginRight = this.blockMarginRight
                  this.baseMDData._blockMarginBottom = this.blockMarginBottom
                  this.baseMDData._blockMarginLeft = this.blockMarginLeft
                  this.baseMDData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.baseMDData._isLineBreak = this.isLineBreak
                  this.baseMDData._backgroundColor = this.globalBackgroundColor
                  this.baseMDData._openGestureSwipe = this.openGestureSwipe
                  this.baseMDData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.baseMDData._pagePath = item
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/AllPageCopyDetailsPage", params: this.baseMDData })
              })
          }
        })
      }
      .constraintSize({ maxHeight: 200 })
      .columnsGap(5)
      .rowsGap(5)
      .maxCount(5)
      .minCount(3)
      .cellLength(30)
      .layoutDirection(GridDirection.Row)
      .padding(5)
      .width('100%')
      .layoutWeight(1)
    }
    .backgroundColor('#FFEAEAEA')
    .height("100%")
  }
}