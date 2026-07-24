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

// 链接配置
@Entry
@Component
struct Deprecated1Page {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  // 顶部导航栏高度
  @StorageProp('safeTop') safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "101_Deprecated"
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

  // ---------------- 资源图标配置
  // banner默认占位图
  bannerImageList: Array<Resource | undefined> = [undefined]
  @State bannerImage: Resource | undefined = undefined // banner默认占位图

  // ---------------- 其他配置
  // 软换行是否换行列
  isLineBreakList: Array<boolean> = booleanListGeneralData
  @State isLineBreak: boolean = false // 软换行是否换行
  // 下划线颜色列表
  underlineColorList: Array<number | undefined> = colorListGeneralData
  @State underlineColor: number = 0xFF191919 // 下划线颜色
  // 下划线样式列表
  underlineStyleList: Array<TextDecorationStyle> = [TextDecorationStyle.SOLID, TextDecorationStyle.DOUBLE, TextDecorationStyle.DASHED, TextDecorationStyle.DOTTED, TextDecorationStyle.WAVY]
  @State underlineStyle: TextDecorationStyle = TextDecorationStyle.SOLID // 下划线样式

  // ---------------- 链接配置
  // 链接是否是图片显示列表
  isLinkStyleList: Array<boolean> = booleanListGeneralData
  @State isLinkStyle: boolean = false // 链接是否是图片显示
  // 列表中的单行链接是否是图片显示列表
  isListLinkStyleList: Array<boolean> = booleanListGeneralData
  @State isListLinkStyle: boolean = false // 列表中的单行链接是否是图片显示
  // 文本格式链接文本颜色列表
  linkColorList: Array<number | undefined> = colorListGeneralData
  @State linkColor: number = 0xFF0000FF // 文本格式链接文本颜色
  // 文本格式链接文字大小列表
  isLinkSizeList: Array<boolean> = booleanListGeneralData
  @State isLinkSize: boolean = true // 文本格式链接文字大小
  // 文本格式链接文字大小值列表
  linkSizeList: Array<number> = textNumberListGeneralData
  @State linkSize: number = 14 // 文本格式链接文字大小
  // 文本格式链接文字行高列表
  linkLineHeightList: Array<number> = textNumberListGeneralData
  @State linkLineHeight: number = 20 // 文本格式链接文字行高
  // 文本格式链接背景颜色列表
  linkBackGroupColorList: Array<number | undefined> = colorListGeneralData
  @State linkBackGroupColor: number = 0x00000000 // 文本格式链接背景颜色
  // 文本格式是否显示链接下划线列表
  isLinkUnderlinedList: Array<boolean> = booleanListGeneralData
  @State isLinkUnderlined: boolean = true // 文本格式是否显示链接下划线
  // 圆形图片格式链接主题背景颜色列表
  linkCircleImageBackGroupColorList: Array<number | undefined> = colorListGeneralData
  @State linkCircleImageBackGroupColor: number = 0x00000000 // 圆形图片格式链接主题背景颜色
  // 圆形图片格式链接控件背景颜色列表
  linkCircleImageButtonBackGroupColorList: Array<number | undefined> = colorListGeneralData
  @State linkCircleImageButtonBackGroupColor: number = 0xFF000000 // 圆形图片格式链接控件背景颜色
  // 圆形图片格式链接文字大小列表
  linkCircleImageTextSizeList: Array<number> = textNumberListGeneralData
  @State linkCircleImageTextSize: number = 14 // 圆形图片格式链接文字大小
  // 圆形图片格式链接文字颜色列表
  linkCircleImageTextColorList: Array<number | undefined> = colorListGeneralData
  @State linkCircleImageTextColor: number = 0xFFFFFFFF // 圆形图片格式链接文字颜色
  // 圆形图片格式链接半径列表
  linkCircleImageRadiusList: Array<number> = [10, 15, 20, 25, 30]
  @State linkCircleImageRadius: number = 20 // 圆形图片格式链接半径
  // 圆形图片格式链接左右外边距列表
  linkCircleImageMarginList: Array<number> = marginListGeneralData
  @State linkCircleImageMargin: number = 6 // 圆形图片格式链接左右外边距
  // 圆角矩形图片格式链接主题背景颜色列表
  linkRectImageBackGroupColorList: Array<number | undefined> = colorListGeneralData
  @State linkRectImageBackGroupColor: number = 0x00000000 // 圆角矩形图片格式链接主题背景颜色
  // 圆角矩形图片格式链接控件背景颜色列表
  linkRectImageButtonBackGroupColorList: Array<number | undefined> = colorListGeneralData
  @State linkRectImageButtonBackGroupColor: number = 0xFF000000 // 圆角矩形图片格式链接控件背景颜色
  // 圆角矩形图片格式链接文字大小列表
  linkRectImageTextSizeList: Array<number> = textNumberListGeneralData
  @State linkRectImageTextSize: number = 14 // 圆角矩形图片格式链接文字大小
  // 圆角矩形图片格式链接文字颜色列表
  linkRectImageTextColorList: Array<number | undefined> = colorListGeneralData
  @State linkRectImageTextColor: number = 0xFFFFFFFF // 圆角矩形图片格式链接文字颜色
  // 圆角矩形图片格式链接控件高度列表
  linkRectImageHeightList: Array<number> = [15, 18, 20, 22, 25]
  @State linkRectImageHeight: number = 20 // 圆角矩形图片格式链接控件高度
  // 圆角矩形图片格式链接左右内边距列表
  linkRectImagePaddingList: Array<number> = marginListGeneralData
  @State linkRectImagePadding: number = 6 // 圆角矩形图片格式链接左右内边距
  // 圆角矩形图片格式链接圆角半径列表
  linkRectImageRadiusList: Array<number> = [3, 4, 5, 6, 8]
  @State linkRectImageRadius: number = 6 // 圆角矩形图片格式链接圆角半径
  // 圆角矩形图片格式链接左右外边距列表
  linkRectImageMarginList: Array<number> = marginListGeneralData
  @State linkRectImageMargin: number = 6 // 圆角矩形图片格式链接左右外边距
  // 空心圆角矩形图片格式链接主题背景颜色列表
  linkRectToolImageBackGroupColorList: Array<number | undefined> = colorListGeneralData
  @State linkRectToolImageBackGroupColor: number = 0x00000000 // 空心圆角矩形图片格式链接主题背景颜色
  // 空心圆角矩形图片格式链接控件背景颜色列表
  linkRectToolImageButtonBackGroupColorList: Array<number | undefined> = colorListGeneralData
  @State linkRectToolImageButtonBackGroupColor: number = 0xFFFFFFFF // 空心圆角矩形图片格式链接控件背景颜色
  // 空心圆角矩形图片格式链接文字大小列表
  linkRectToolImageTextSizeList: Array<number> = textNumberListGeneralData
  @State linkRectToolImageTextSize: number = 14 // 空心圆角矩形图片格式链接文字大小
  // 空心圆角矩形图片格式链接控件高度列表
  linkRectToolImageHeightList: Array<number> = [18, 19, 20, 21, 22]
  @State linkRectToolImageHeight: number = 21 // 空心圆角矩形图片格式链接控件高度
  // 空心圆角矩形图片格式链接左右内边距列表
  linkRectToolImagePaddingList: Array<number> = marginListGeneralData
  @State linkRectToolImagePadding: number = 6 // 空心圆角矩形图片格式链接左右内边距
  // 空心圆角矩形图片格式链接边框宽度列表
  linkRectToolImageBorderWidthList: Array<number> = [0, 1, 2, 3, 4]
  @State linkRectToolImageBorderWidth: number = 1 // 空心圆角矩形图片格式链接边框宽度
  // 空心圆角矩形图片格式链接分割线宽度列表
  linkRectToolImageDividingLineWidthList: Array<number> = [0, 1, 2, 3, 4]
  @State linkRectToolImageDividingLineWidth: number = 1 // 空心圆角矩形图片格式链接分割线宽度
  // 空心圆角矩形图片格式链接左右外边距列表
  linkRectToolImageMarginList: Array<number> = marginListGeneralData
  @State linkRectToolImageMargin: number = 6 // 空心圆角矩形图片格式链接左右外边距
  // 空心圆角矩形图片格式分割线和文本左边距列表
  linkRectToolImageLineLeftPaddingList: Array<number> = [0, 1, 2, 3, 4]
  @State linkRectToolImageLineLeftPadding: number = 3 // 空心圆角矩形图片格式分割线和文本左边距
  // 空心圆角矩形图片格式分割线和文本右边距列表
  linkRectToolImageLineRightPaddingList: Array<number> = [0, 1, 2, 3, 4]
  @State linkRectToolImageLineRightPadding: number = 3 // 空心圆角矩形图片格式分割线和文本右边距

  @State deprecatedData: DeprecatedData = new DeprecatedData() // 配置数据内容

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "链接配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll() {
        Column() {
          // ------------ 资源图标配置
          BaseTabComponent({
            titleStr: "banner默认占位图 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.bannerImageList,
            allData: this.bannerImage
          })

          // ------------ 其他配置
          BaseTabComponent({
            titleStr: "软换行是否换行 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isLineBreakList,
            allData: this.isLineBreak
          })
          BaseTabComponent({
            titleStr: "下划线颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.underlineColorList,
            allData: this.underlineColor
          })
          BaseTabComponent({
            titleStr: "下划线样式 - ",
            typeEnum: TypeEnum.IS_STRING,
            allListData: this.underlineStyleList,
            allData: this.underlineStyle
          })

          // ------------ 链接配置
          BaseTabComponent({
            titleStr: "链接是否是图片显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isLinkStyleList,
            allData: this.isLinkStyle
          })
          BaseTabComponent({
            titleStr: "列表中的单行链接是否是图片显示 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isListLinkStyleList,
            allData: this.isListLinkStyle
          })
          BaseTabComponent({
            titleStr: "文本格式链接文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkColorList,
            allData: this.linkColor
          })
          BaseTabComponent({
            titleStr: "文本格式链接文字大小 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isLinkSizeList,
            allData: this.isLinkSize
          })
          BaseTabComponent({
            titleStr: "文本格式链接文字大小值 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkSizeList,
            allData: this.linkSize
          })
          BaseTabComponent({
            titleStr: "文本格式链接文字行高 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkLineHeightList,
            allData: this.linkLineHeight
          })
          BaseTabComponent({
            titleStr: "文本格式链接背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkBackGroupColorList,
            allData: this.linkBackGroupColor
          })
          BaseTabComponent({
            titleStr: "文本格式是否显示链接下划线 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isLinkUnderlinedList,
            allData: this.isLinkUnderlined
          })
          // 圆形图片格式链接配置
          BaseTabComponent({
            titleStr: "圆形图片格式链接主题背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkCircleImageBackGroupColorList,
            allData: this.linkCircleImageBackGroupColor
          })
          BaseTabComponent({
            titleStr: "圆形图片格式链接控件背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkCircleImageButtonBackGroupColorList,
            allData: this.linkCircleImageButtonBackGroupColor
          })
          BaseTabComponent({
            titleStr: "圆形图片格式链接文字大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkCircleImageTextSizeList,
            allData: this.linkCircleImageTextSize
          })
          BaseTabComponent({
            titleStr: "圆形图片格式链接文字颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkCircleImageTextColorList,
            allData: this.linkCircleImageTextColor
          })
          BaseTabComponent({
            titleStr: "圆形图片格式链接半径 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkCircleImageRadiusList,
            allData: this.linkCircleImageRadius
          })
          BaseTabComponent({
            titleStr: "圆形图片格式链接左右外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkCircleImageMarginList,
            allData: this.linkCircleImageMargin
          })
          // 圆角矩形图片格式链接配置
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接主题背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkRectImageBackGroupColorList,
            allData: this.linkRectImageBackGroupColor
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接控件背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkRectImageButtonBackGroupColorList,
            allData: this.linkRectImageButtonBackGroupColor
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接文字大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectImageTextSizeList,
            allData: this.linkRectImageTextSize
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接文字颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkRectImageTextColorList,
            allData: this.linkRectImageTextColor
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接控件高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectImageHeightList,
            allData: this.linkRectImageHeight
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接左右内边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectImagePaddingList,
            allData: this.linkRectImagePadding
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接圆角半径 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectImageRadiusList,
            allData: this.linkRectImageRadius
          })
          BaseTabComponent({
            titleStr: "圆角矩形图片格式链接左右外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectImageMarginList,
            allData: this.linkRectImageMargin
          })
          // 空心圆角矩形图片格式链接配置
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接主题背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkRectToolImageBackGroupColorList,
            allData: this.linkRectToolImageBackGroupColor
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接控件背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.linkRectToolImageButtonBackGroupColorList,
            allData: this.linkRectToolImageButtonBackGroupColor
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接文字大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageTextSizeList,
            allData: this.linkRectToolImageTextSize
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接控件高度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageHeightList,
            allData: this.linkRectToolImageHeight
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接左右内边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImagePaddingList,
            allData: this.linkRectToolImagePadding
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接边框宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageBorderWidthList,
            allData: this.linkRectToolImageBorderWidth
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接分割线宽度 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageDividingLineWidthList,
            allData: this.linkRectToolImageDividingLineWidth
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式链接左右外边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageMarginList,
            allData: this.linkRectToolImageMargin
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式分割线和文本左边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageLineLeftPaddingList,
            allData: this.linkRectToolImageLineLeftPadding
          })
          BaseTabComponent({
            titleStr: "空心圆角矩形图片格式分割线和文本右边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.linkRectToolImageLineRightPaddingList,
            allData: this.linkRectToolImageLineRightPadding
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
                    // ---------- 资源图标配置
                    this.deprecatedData.bannerImage = this.bannerImage

                    // ---------- 其他配置
                    this.deprecatedData.isLineBreak = this.isLineBreak
                    this.deprecatedData.underlineColor = this.underlineColor
                    this.deprecatedData.underlineStyle = this.underlineStyle

                    // ---------- 链接配置
                    this.deprecatedData.isLinkStyle = this.isLinkStyle
                    this.deprecatedData.isListLinkStyle = this.isListLinkStyle
                    this.deprecatedData.linkColor = this.linkColor
                    this.deprecatedData.isLinkSize = this.isLinkSize
                    this.deprecatedData.linkSize = this.linkSize
                    this.deprecatedData.linkLineHeight = this.linkLineHeight
                    this.deprecatedData.linkBackGroupColor = this.linkBackGroupColor
                    this.deprecatedData.isLinkUnderlined = this.isLinkUnderlined
                    // 圆形图片格式链接配置
                    this.deprecatedData.linkCircleImageBackGroupColor = this.linkCircleImageBackGroupColor
                    this.deprecatedData.linkCircleImageButtonBackGroupColor = this.linkCircleImageButtonBackGroupColor
                    this.deprecatedData.linkCircleImageTextSize = this.linkCircleImageTextSize
                    this.deprecatedData.linkCircleImageTextColor = this.linkCircleImageTextColor
                    this.deprecatedData.linkCircleImageRadius = this.linkCircleImageRadius
                    this.deprecatedData.linkCircleImageMargin = this.linkCircleImageMargin
                    // 圆角矩形图片格式链接配置
                    this.deprecatedData.linkRectImageBackGroupColor = this.linkRectImageBackGroupColor
                    this.deprecatedData.linkRectImageButtonBackGroupColor = this.linkRectImageButtonBackGroupColor
                    this.deprecatedData.linkRectImageTextSize = this.linkRectImageTextSize
                    this.deprecatedData.linkRectImageTextColor = this.linkRectImageTextColor
                    this.deprecatedData.linkRectImageHeight = this.linkRectImageHeight
                    this.deprecatedData.linkRectImagePadding = this.linkRectImagePadding
                    this.deprecatedData.linkRectImageRadius = this.linkRectImageRadius
                    this.deprecatedData.linkRectImageMargin = this.linkRectImageMargin
                    // 空心圆角矩形图片格式链接配置
                    this.deprecatedData.linkRectToolImageBackGroupColor = this.linkRectToolImageBackGroupColor
                    this.deprecatedData.linkRectToolImageButtonBackGroupColor = this.linkRectToolImageButtonBackGroupColor
                    this.deprecatedData.linkRectToolImageTextSize = this.linkRectToolImageTextSize
                    this.deprecatedData.linkRectToolImageHeight = this.linkRectToolImageHeight
                    this.deprecatedData.linkRectToolImagePadding = this.linkRectToolImagePadding
                    this.deprecatedData.linkRectToolImageBorderWidth = this.linkRectToolImageBorderWidth
                    this.deprecatedData.linkRectToolImageDividingLineWidth = this.linkRectToolImageDividingLineWidth
                    this.deprecatedData.linkRectToolImageMargin = this.linkRectToolImageMargin
                    this.deprecatedData.linkRectToolImageLineLeftPadding = this.linkRectToolImageLineLeftPadding
                    this.deprecatedData.linkRectToolImageLineRightPadding = this.linkRectToolImageLineRightPadding

                    this.deprecatedData.pagePath = `${this.rawFilePath}/${item}`

                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/deprecated/Deprecated1DetailsPage", params: this.deprecatedData })
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
