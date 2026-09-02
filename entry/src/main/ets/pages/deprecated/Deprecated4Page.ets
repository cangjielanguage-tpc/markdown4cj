import { titleComponent } from '../../component/BaseComponent'
import { getFileListStr } from '../../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../../component/BaseTabComponent'
import { TypeEnum } from '../../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  marginListGeneralData,
  textNumberListGeneralData,
  timeListGeneralData
} from '../../model/GeneralData'
import { DeprecatedData } from '../../model/DeprecatedData'

// 数学公式、图片配置
@Entry
@Component
struct Deprecated4Page {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // 顶部导航栏高度
  @StorageProp('safeTop') safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "104_Deprecated"
  // rawfile文件夹列表
  @State folderList: Array<string> = new Array<string>()
  // 是否全量加载Markdown文本列表
  isFullList: Array<boolean> = booleanListGeneralData
  // 是否全量加载Markdown文本
  @State isFull: boolean = true
  // 是否增量解析Markdown文本列表
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  // 是否增量解析Markdown文本
  @State incrementalAnalysis: boolean = false
  // 增量加载每次间隔时间列表
  timeList: Array<number> = timeListGeneralData
  // 增量加载每次间隔时间
  @State time: number = 50
  // 增量每次增量文本数量列表
  textNumberList: Array<number> = textNumberListGeneralData
  // 增量每次增量文本数量
  @State textNumber: number = 10
  // 是否同步解析Markdown文本列表
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  // 是否同步解析Markdown文本
  @State isMarkdownParserSync: boolean = false
  // 是否打开长按复制粘贴效果列表
  isOnCopyList: Array<boolean> = booleanListGeneralData
  // 是否打开长按复制粘贴效果
  @State isOnCopy: boolean = false
  // Markdown文本第一个模块上边距列表
  blockFirstTopMarginList: Array<number> = marginListGeneralData
  // Markdown文本第一个模块上边距
  @State blockFirstTopMargin: number = 8
  // Markdown文本最后一个模块下边距列表
  blockLastBottomMarginList: Array<number> = marginListGeneralData
  // Markdown文本最后一个模块下边距
  @State blockLastBottomMargin: number = 8
  // Markdown文本模块间上下间距列表
  blockTopAndBottomMarginsList: Array<number> = marginListGeneralData
  // Markdown文本模块间上下间距
  @State blockTopAndBottomMargins: number = 8
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  // 是否允许markdown控件自身响应滑动
  @State openGestureSwipe: boolean = false
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipeTest: boolean = false // 是否开启响应滑动测试

  // ---------------- 数学公式配置
  // 数学公式未加载状态是否显示文字列表
  latexDefaultTextList: Array<boolean> = booleanListGeneralData
  @State latexDefaultText: boolean = true // 数学公式未加载状态是否显示文字
  // 数学公式文本大小列表
  latexMathTextSizeList: Array<number> = textNumberListGeneralData
  @State latexMathTextSize: number = 16 // 数学公式文本大小
  // 块结构的数学公式是否居中列表
  latexMathBlockCenterList: Array<boolean> = booleanListGeneralData
  @State latexMathBlockCenter: boolean = false // 块结构的数学公式是否居中
  // 数学公式字体路径列表
  latexMathResStrList: Array<string> = ["/data/storage/el1/bundle/entry/resources/resfile/res"]
  @State latexMathResStr: string = "/data/storage/el1/bundle/entry/resources/resfile/res" // 数学公式字体路径
  // 数学公式背景色列表
  latexMathBackGroupColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State latexMathBackGroupColor: number = 0x00000000 // 数学公式背景色
  // 数学公式文本颜色列表
  latexMathTextColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State latexMathTextColor: number = 0xFF000000 // 数学公式文本颜色
  // 数学公式生成图片格式列表
  // latexMathColorFormatList: Array<LatexMathColorFormat> = [LatexMathColorFormat.COLOR_FORMAT_BGRA_8888, LatexMathColorFormat.COLOR_FORMAT_RGB_565]
  // @State latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888 // 数学公式生成图片格式

  // ---------------- 图片配置
  // 图片默认占位图
  imageResourceList: Array<Resource | undefined> = [undefined]
  @State imageResource: Resource | undefined = undefined // 图片默认占位图
  // 图片下载默认图标
  imageDownloadImageList: Array<Resource | undefined> = [undefined]
  @State imageDownloadImage: Resource | undefined = undefined // 图片下载默认图标
  // 图片缩放类型列表
  imageFitTypeList: Array<ImageFit> = [ImageFit.Contain, ImageFit.Cover, ImageFit.Fill]
  @State imageFitType: ImageFit = ImageFit.Contain // 图片缩放类型
  // 图片最大宽度百分比列表
  imageMaximumWidthList: Array<number> = [0.5, 0.7, 0.8, 1.0, 1.2]
  @State imageMaximumWidth: number = 1 // 图片最大宽度百分比
  // 图片固定宽度百分比列表
  imageFixedRatioWidthList: Array<number | undefined> = [undefined, 0.3, 0.5, 0.7, 1.0]
  @State imageFixedRatioWidth: number | undefined = undefined // 图片固定宽度百分比
  // 图片最大高度列表
  imageMaxHeightList: Array<number | undefined> = [undefined, 200, 300, 400, 500]
  @State imageMaxHeight: number | undefined = undefined // 图片最大高度
  // 图片最大宽度列表
  imageMaxWidthList: Array<number | undefined> = [undefined, 300, 400, 500, 600]
  @State imageMaxWidth: number | undefined = undefined // 图片最大宽度
  // 图片圆角大小列表
  imageBorderRadiusList: Array<number> = [0, 4, 8, 12, 16]
  @State imageBorderRadius: number = 0 // 图片圆角大小
  // 图片边框宽度列表
  imageBorderWidthList: Array<number> = [0, 1, 2, 3, 4]
  @State imageBorderWidth: number = 0 // 图片边框宽度
  // 图片边框颜色列表
  imageBorderColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State imageBorderColor: number = 0xFF000000 // 图片边框颜色
  // 网络图片是否压缩列表
  isAutoResizeList: Array<boolean> = booleanListGeneralData
  @State isAutoResize: boolean = true // 网络图片是否压缩
  // 图片上边距列表
  imageMarginTopList: Array<number> = marginListGeneralData
  @State imageMarginTop: number = 10 // 图片上边距
  // 图片下边距列表
  imageMarginBottomList: Array<number> = marginListGeneralData
  @State imageMarginBottom: number = 10 // 图片下边距
  // 图片是否有下载按钮列表
  isImageDownloadList: Array<boolean> = booleanListGeneralData
  @State isImageDownload: boolean = false // 图片是否有下载按钮
  // 是否图文混排列表
  isImageMixedLayoutList: Array<boolean> = booleanListGeneralData
  @State isImageMixedLayout: boolean = true // 是否图文混排
  // 图片下载按钮图片宽度和高度列表
  imageDownloadImageWidthHeightList: Array<number> = [15, 16, 18, 20, 22]
  @State imageDownloadImageWidthHeight: number = 18 // 图片下载按钮图片宽度和高度
  // 图片下载按钮宽度列表
  imageDownloadWidthList: Array<number> = [200, 250, 296, 350, 400]
  @State imageDownloadWidth: number = 296 // 图片下载按钮宽度
  // 图片下载按钮高度列表
  imageDownloadHeightList: Array<number> = [40, 42, 44, 46, 48]
  @State imageDownloadHeight: number = 44 // 图片下载按钮高度
  // 图片下载按钮圆角列表
  imageDownloadRadiusList: Array<number> = [18, 20, 22, 24, 26]
  @State imageDownloadRadius: number = 22 // 图片下载按钮圆角
  // 图片下载按钮文本内容列表
  imageDownloadTextList: Array<string> = ["下载图片", "保存图片"]
  @State imageDownloadText: string = "下载图片" // 图片下载按钮文本内容
  // 图片下载按钮文本大小列表
  imageDownloadTexSizeList: Array<number> = textNumberListGeneralData
  @State imageDownloadTexSize: number = 16 // 图片下载按钮文本大小
  // 图片下载按钮文本颜色列表
  imageDownloadTexColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State imageDownloadTexColor: number = 0xE6000000 // 图片下载按钮文本颜色
  // 图片下载按钮背景颜色列表
  imageDownloadBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State imageDownloadBackgroundColor: number = 0xFFF5F5F5 // 图片下载按钮背景颜色

  @State deprecatedData: DeprecatedData = new DeprecatedData() // 配置数据内容

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "数学公式图片配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll() {
        Column() {
          // ------------ 通用配置
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
            titleStr: "增量加载每次间隔时间 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.timeList,
            allData: this.time
          })
          BaseTabComponent({
            titleStr: "增量每次增量文本数量 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.textNumberList,
            allData: this.textNumber
          })
          BaseTabComponent({
            titleStr: "是否同步解析Markdown文本 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isMarkdownParserSyncList,
            allData: this.isMarkdownParserSync
          })
          BaseTabComponent({
            titleStr: "是否打开长按复制粘贴效果 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isOnCopyList,
            allData: this.isOnCopy
          })
          BaseTabComponent({
            titleStr: "Markdown文本第一个模块上边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockFirstTopMarginList,
            allData: this.blockFirstTopMargin
          })
          BaseTabComponent({
            titleStr: "Markdown文本最后一个模块下边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockLastBottomMarginList,
            allData: this.blockLastBottomMargin
          })
          BaseTabComponent({
            titleStr: "Markdown文本模块间上下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockTopAndBottomMarginsList,
            allData: this.blockTopAndBottomMargins
          })
          BaseTabComponent({
            titleStr: "是否允许markdown控件自身响应滑动 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.openGestureSwipeList,
            allData: this.openGestureSwipe
          })
          BaseTabComponent({
            titleStr: "是否开启响应滑动测试 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.openGestureSwipeTestList,
            allData: this.openGestureSwipeTest
          })

          // ------------ 数学公式配置
          BaseTabComponent({
            titleStr: "数学公式未加载状态是否显示文字 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.latexDefaultTextList,
            allData: this.latexDefaultText
          })
          BaseTabComponent({
            titleStr: "数学公式文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.latexMathTextSizeList,
            allData: this.latexMathTextSize
          })
          BaseTabComponent({
            titleStr: "数学公式背景色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.latexMathBackGroupColorList,
            allData: this.latexMathBackGroupColor
          })
          BaseTabComponent({
            titleStr: "数学公式文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.latexMathTextColorList,
            allData: this.latexMathTextColor
          })
          BaseTabComponent({
            titleStr: "块结构的数学公式是否居中 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.latexMathBlockCenterList,
            allData: this.latexMathBlockCenter
          })
          BaseTabComponent({
            titleStr: "数学公式字体路径 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.latexMathResStrList,
            allData: this.latexMathResStr
          })
          // BaseTabComponent({
          //   titleStr: "数学公式生成图片格式 - ",
          //   typeEnum: TypeEnum.IS_STRING,
          //   allListData: this.latexMathColorFormatList,
          //   allData: this.latexMathColorFormat
          // })

          // ------------ 图片配置
          BaseTabComponent({
            titleStr: "图片适应类型 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.imageFitTypeList,
            allData: this.imageFitType
          })
          BaseTabComponent({
            titleStr: "图片最大宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageMaximumWidthList,
            allData: this.imageMaximumWidth
          })
          BaseTabComponent({
            titleStr: "图片固定比例宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageFixedRatioWidthList,
            allData: this.imageFixedRatioWidth
          })
          BaseTabComponent({
            titleStr: "图片最大高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageMaxHeightList,
            allData: this.imageMaxHeight
          })
          BaseTabComponent({
            titleStr: "图片最大宽度限制 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageMaxWidthList,
            allData: this.imageMaxWidth
          })
          BaseTabComponent({
            titleStr: "图片边框圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageBorderRadiusList,
            allData: this.imageBorderRadius
          })
          BaseTabComponent({
            titleStr: "图片边框宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageBorderWidthList,
            allData: this.imageBorderWidth
          })
          BaseTabComponent({
            titleStr: "图片边框颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.imageBorderColorList,
            allData: this.imageBorderColor
          })
          BaseTabComponent({
            titleStr: "是否自动调整大小 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isAutoResizeList,
            allData: this.isAutoResize
          })
          BaseTabComponent({
            titleStr: "图片上边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageMarginTopList,
            allData: this.imageMarginTop
          })
          BaseTabComponent({
            titleStr: "图片下边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageMarginBottomList,
            allData: this.imageMarginBottom
          })
          BaseTabComponent({
            titleStr: "是否图片下载 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isImageDownloadList,
            allData: this.isImageDownload
          })
          BaseTabComponent({
            titleStr: "是否图片混合布局 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isImageMixedLayoutList,
            allData: this.isImageMixedLayout
          })
          // 图片下载按钮配置
          BaseTabComponent({
            titleStr: "图片下载图片宽高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageDownloadImageWidthHeightList,
            allData: this.imageDownloadImageWidthHeight
          })
          BaseTabComponent({
            titleStr: "图片下载宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageDownloadWidthList,
            allData: this.imageDownloadWidth
          })
          BaseTabComponent({
            titleStr: "图片下载高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageDownloadHeightList,
            allData: this.imageDownloadHeight
          })
          BaseTabComponent({
            titleStr: "图片下载圆角 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageDownloadRadiusList,
            allData: this.imageDownloadRadius
          })
          BaseTabComponent({
            titleStr: "图片下载文本 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.imageDownloadTextList,
            allData: this.imageDownloadText
          })
          BaseTabComponent({
            titleStr: "图片下载文本大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.imageDownloadTexSizeList,
            allData: this.imageDownloadTexSize
          })
          BaseTabComponent({
            titleStr: "图片下载文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.imageDownloadTexColorList,
            allData: this.imageDownloadTexColor
          })
          BaseTabComponent({
            titleStr: "图片下载背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.imageDownloadBackgroundColorList,
            allData: this.imageDownloadBackgroundColor
          })

          List() {
            ForEach(this.folderList, (item: string, index: number) => {
              ListItem() {
                Button(`${index + 1}、${item}`)
                  .height(40)
                  .width('80%')
                  .type(ButtonType.Capsule)
                  .fontColor(0xFFFFFFFF)
                  .backgroundColor(0xFF317AFF)
                  .margin({ top: 5, bottom: 5 })
                  .align(Alignment.Center)
                  .fontSize(16)
                  .onClick(() => {
                    // ---------- 通用配置
                    this.deprecatedData._isFull = this.isFull
                    this.deprecatedData._incrementalAnalysis = this.incrementalAnalysis
                    this.deprecatedData._time = this.time
                    this.deprecatedData._textNumber = this.textNumber
                    this.deprecatedData._isMarkdownParserSync = this.isMarkdownParserSync
                    this.deprecatedData._isOnCopy = this.isOnCopy
                    this.deprecatedData._blockFirstTopMargin = this.blockFirstTopMargin
                    this.deprecatedData._blockLastBottomMargin = this.blockLastBottomMargin
                    this.deprecatedData._blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.deprecatedData._openGestureSwipe = this.openGestureSwipe
                    this.deprecatedData._openGestureSwipeTest = this.openGestureSwipeTest

                    // ---------- 数学公式配置
                    this.deprecatedData._latexDefaultText = this.latexDefaultText
                    this.deprecatedData._latexMathTextSize = this.latexMathTextSize
                    this.deprecatedData._latexMathBackGroupColor = this.latexMathBackGroupColor
                    this.deprecatedData._latexMathTextColor = this.latexMathTextColor
                    this.deprecatedData._latexMathBlockCenter = this.latexMathBlockCenter
                    this.deprecatedData._latexMathResStr = this.latexMathResStr
                    // this.deprecatedData._latexMathColorFormat = this.latexMathColorFormat

                    // ---------- 图片配置
                    this.deprecatedData._imageResource = this.imageResource
                    this.deprecatedData._imageDownloadImage = this.imageDownloadImage
                    this.deprecatedData._imageFitType = this.imageFitType
                    this.deprecatedData._imageMaximumWidth = this.imageMaximumWidth
                    this.deprecatedData._imageFixedRatioWidth = this.imageFixedRatioWidth
                    this.deprecatedData._imageMaxHeight = this.imageMaxHeight
                    this.deprecatedData._imageMaxWidth = this.imageMaxWidth
                    this.deprecatedData._imageBorderRadius = this.imageBorderRadius
                    this.deprecatedData._imageBorderWidth = this.imageBorderWidth
                    this.deprecatedData._imageBorderColor = this.imageBorderColor
                    this.deprecatedData._isAutoResize = this.isAutoResize
                    this.deprecatedData._imageMarginTop = this.imageMarginTop
                    this.deprecatedData._imageMarginBottom = this.imageMarginBottom
                    this.deprecatedData._isImageDownload = this.isImageDownload
                    this.deprecatedData._isImageMixedLayout = this.isImageMixedLayout
                    this.deprecatedData._imageDownloadImageWidthHeight = this.imageDownloadImageWidthHeight
                    this.deprecatedData._imageDownloadWidth = this.imageDownloadWidth
                    this.deprecatedData._imageDownloadHeight = this.imageDownloadHeight
                    this.deprecatedData._imageDownloadRadius = this.imageDownloadRadius
                    this.deprecatedData._imageDownloadText = this.imageDownloadText
                    this.deprecatedData._imageDownloadTexSize = this.imageDownloadTexSize
                    this.deprecatedData._imageDownloadTexColor = this.imageDownloadTexColor
                    this.deprecatedData._imageDownloadBackgroundColor = this.imageDownloadBackgroundColor

                    this.deprecatedData._pagePath = `${this.rawFilePath}/${item}`

                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/deprecated/Deprecated4DetailsPage", params: this.deprecatedData })
                  })
              }
            })
          }
          // 设置ListItem在List交叉轴方向的布局方式
          .alignListItem(ListItemAlign.Center)
        }
        .padding({ bottom: 100 })
      }
    }
    .backgroundColor($r('app.color.page_background'))
    .height("100%")
  }
}
