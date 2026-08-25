import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseMDData } from '../model/BaseMDData'

/**
 * SDUI卡片接入列表页
 *
 * markdown 通过自定义标签 <sdui data='SDUI JSON'></sdui> 接入 SDUI 引擎，
 * 列表页展示用例文档，点击进入详情页查看混合渲染效果。
 */
@Entry
@Component
struct SduiCardPage {
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "037_SduiCard"
  @State // rawfile文件夹列表
  folderList: Array<string> = new Array<string>()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`) // 获取rawfile文件列表
  }

  build() {
    Column() {
      titleComponent(
        "SDUI卡片接入测试",
        0xFF317AFF,
        true,
        this.safeTop
      )

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
                  let baseMDData: BaseMDData = new BaseMDData()
                  baseMDData._pagePath = `${this.rawFilePath}/${item}`
                  router.pushUrl({ url: "pages/SduiCardDetailsPage", params: baseMDData })
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
      .backgroundColor('#FFEAEAEA')
    }
    .backgroundColor('#FFEAEAEA')
    .height("90%")
  }
}
