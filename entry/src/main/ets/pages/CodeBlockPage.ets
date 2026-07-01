import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  borderStyleListGeneraData,
  colorListGeneralData,
  fontStyleListGeneraData,
  fontWeightListGeneraData,
  lineOrBorderWidthListGeneraData,
  marginListGeneralData,
  paddingListGeneralData,
  radiusListGeneraData,
  spaceListGeneralData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  timeListGeneralData,
  widthOrHeightListGeneralData
} from '../model/GeneralData'
import { CodeBlockData } from '../model/CodeBlockData'

@Entry
@Component
struct CodeBlockPage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') // 顶部导航栏高度
  safeTop: number = 0
  // rawfile路径
  rawFilePath: string = "011_CodeBlock"
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
  // 增量加载每次间隔时间列表
  timeList: Array<number> = timeListGeneralData
  @State // 增量加载每次间隔时间
  time: number = 50
  // 增量每次增量文本数量列表
  textNumberList: Array<number> = textNumberListGeneralData
  @State // 增量每次增量文本数量
  textNumber: number = 10
  // 是否同步解析Markdown文本列表
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  @State // 是否同步解析Markdown文本
  isMarkdownParserSync: boolean = false
  // 是否打开长按复制粘贴效果列表
  isOnCopyList: Array<boolean> = booleanListGeneralData
  @State // 是否打开长按复制粘贴效果
  isOnCopy: boolean = false
  // markdown全局上外边距列表
  blockMarginTopList: Array<number> = marginListGeneralData
  @State // markdown全局上外边距
  blockMarginTop: number = 0
  // markdown全局右外边距列表
  blockMarginRightList: Array<number> = marginListGeneralData
  @State // markdown全局右外边距
  blockMarginRight: number = 0
  // markdown全局下外边距列表
  blockMarginBottomList: Array<number> = marginListGeneralData
  @State // markdown全局下外边距
  blockMarginBottom: number = 0
  // markdown全局左外边距列表
  blockMarginLeftList: Array<number> = marginListGeneralData
  @State // markdown全局左外边距
  blockMarginLeft: number = 0
  // 模块间上下间距列表
  markdownBlockSpacingList: Array<number> = marginListGeneralData
  @State // 模块间上下间距
  markdownBlockSpacing: number = 8
  // 软换行是否换行列表
  isLineBreakList: Array<boolean> = booleanListGeneralData
  @State // 软换行是否换行
  isLineBreak: boolean = false
  // 背景颜色列表
  globalBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 背景颜色
  globalBackgroundColor: ResourceColor | undefined = undefined
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  @State // 是否允许markdown控件自身响应滑动
  openGestureSwipe: boolean = false
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State // 是否开启响应滑动测试
  openGestureSwipeTest: boolean = false
  // ---------------- 专有
  // 是否格式化围栏代码块内容列表
  codeBlockIsCodeFormatList: Array<boolean> = booleanListGeneralData
  @State // 是否格式化围栏代码块内容
  codeBlockIsCodeFormat: boolean = false
  // 代码深浅色模式列表
  codeBlockIsDarkList: Array<boolean> = booleanListGeneralData
  @State // 代码深浅色模式
  codeBlockIsDark: boolean = false
  // codeformat是否用制表符列表
  codeBlockUseTabList: Array<boolean> = booleanListGeneralData
  @State // codeformat是否用制表符
  codeBlockUseTab: boolean = false
  // codeformat空格缩进数量列表
  codeBlockIndentWidthList: Array<Length> = [0, 2, 4, 6, 8, 10]
  @State // codeformat空格缩进数量
  codeBlockIndentWidth: Length = 4
  // 围栏代码块代码高亮是否同步解析列表
  codeBlockParserSyncList: Array<boolean> = booleanListGeneralData
  @State // 围栏代码块代码高亮是否同步解析
  codeBlockParserSync: boolean = false
  // 代码块背景颜色列表
  codeBlockBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 代码块背景颜色
  codeBlockBackgroundColor: ResourceColor | undefined = undefined
  // 代码块上外边距列表
  codeBlockMarginTopList: Array<Length> = marginListGeneralData
  @State // 代码块上外边距
  codeBlockMarginTop: Length = 0.0
  // 代码块右外边距列表
  codeBlockMarginRightList: Array<Length> = marginListGeneralData
  @State // 代码块右外边距
  codeBlockMarginRight: Length = 0.0
  // 代码块下外边距列表
  codeBlockMarginBottomList: Array<Length> = marginListGeneralData
  @State // 代码块下外边距
  codeBlockMarginBottom: Length = 0.0
  // 代码块左外边距列表
  codeBlockMarginLeftList: Array<Length> = marginListGeneralData
  @State // 代码块左外边距
  codeBlockMarginLeft: Length = 0.0
  // 代码块上内边距列表
  codeBlockPaddingTopList: Array<Length> = paddingListGeneralData
  @State // 代码块上内边距
  codeBlockPaddingTop: Length = 0.0
  // 代码块右内边距列表
  codeBlockPaddingRightList: Array<Length> = paddingListGeneralData
  @State // 代码块右内边距
  codeBlockPaddingRight: Length = 8.0
  // 代码块下内边距列表
  codeBlockPaddingBottomList: Array<Length> = paddingListGeneralData
  @State // 代码块下内边距
  codeBlockPaddingBottom: Length = 8.0
  // 代码块左内边距列表
  codeBlockPaddingLeftList: Array<Length> = paddingListGeneralData
  @State // 代码块左内边距
  codeBlockPaddingLeft: Length = 0.0
  // 代码块边框样式列表
  codeBlockBorderStyleList: Array<BorderStyle> = borderStyleListGeneraData
  @State // 代码块边框样式
  codeBlockBorderStyle: BorderStyle = BorderStyle.Solid
  // 代码块边框宽度列表
  codeBlockBorderWidthList: Array<Length> = lineOrBorderWidthListGeneraData
  @State // 代码块边框宽度
  codeBlockBorderWidth: Length = 0.0
  // 代码块边框颜色列表
  codeBlockBorderColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 代码块边框颜色
  codeBlockBorderColor: ResourceColor | undefined = undefined
  // 代码块边框左上圆角列表
  codeBlockRadiusTopLeftList: Array<Length> = radiusListGeneraData
  @State // 代码块边框左上圆角
  codeBlockRadiusTopLeft: Length = 8.0
  // 代码块边框右上圆角列表
  codeBlockRadiusTopRightList: Array<Length> = radiusListGeneraData
  @State // 代码块边框右上圆角
  codeBlockRadiusTopRight: Length = 8.0
  // 代码块边框左下圆角列表
  codeBlockRadiusBottomLeftList: Array<Length> = radiusListGeneraData
  @State // 代码块边框左下圆角
  codeBlockRadiusBottomLeft: Length = 8.0
  // 代码块边框右下圆角列表
  codeBlockRadiusBottomRightList: Array<Length> = radiusListGeneraData
  @State // 代码块边框右下圆角
  codeBlockRadiusBottomRight: Length = 8.0
  // 代码块类型和代码块内容间距列表
  codeBlockTitleLayoutMarginBottomList: Array<Length> = marginListGeneralData
  @State // 代码块类型和代码块内容间距
  codeBlockTitleLayoutMarginBottom: Length = 0.0
  // 代码块类型左边距列表
  codeBlockTypeTextMarginLeftList: Array<Length> = marginListGeneralData
  @State // 代码块类型左边距
  codeBlockTypeTextMarginLeft: Length = 8.0
  // 代码块没有代码类型时默认显示文本列表
  codeBlockTypeTextList: Array<string> = ['Code', '代码', '']
  @State // 代码块没有代码类型时默认显示文本
  codeBlockTypeText: string = 'Code'
  // 代码块类型文本颜色列表
  codeBlockTypeTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 代码块类型文本颜色
  codeBlockTypeTextFontColor: ResourceColor | undefined = undefined
  // 代码块类型文本尺寸列表
  codeBlockTypeTextFontSizeList: Array<number | string | Resource | undefined> = textSizeListGeneralData
  @State // 代码块类型文本尺寸
  codeBlockTypeTextFontSize: number | string | Resource | undefined = undefined
  // 代码块类型文本字体样式列表
  codeBlockTypeTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 代码块类型文本字体样式
  codeBlockTypeTextFontStyle: FontStyle | undefined = undefined
  // 代码块类型文本字体粗细列表
  codeBlockTypeTextFontWeightList: Array<FontWeight | undefined> = fontWeightListGeneraData
  @State // 代码块类型文本字体粗细
  codeBlockTypeTextFontWeight: FontWeight | undefined = undefined
  // 代码块类型文本字体列表
  codeBlockTypeTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 代码块类型文本字体
  codeBlockTypeTextFontFamily: string | undefined = undefined
  // 代码块类型文本行高列表
  codeBlockTypeTextLineHeightList: Array<number | string | Resource | undefined> = textLineHeightListGeneralData
  @State // 代码块类型文本行高
  codeBlockTypeTextLineHeight: number | string | Resource | undefined = undefined
  // 代码块代码复制和代码全屏间距列表
  codeBlockCopyFullScreenSpacingList: Array<number> = spaceListGeneralData
  @State // 代码块代码复制和代码全屏间距
  codeBlockCopyFullScreenSpacing: number = 5
  // 代码块代码复制按钮是否显示列表
  codeBlockCopyButtonIsShowList: Array<boolean> = booleanListGeneralData
  @State // 代码块代码复制按钮是否显示
  codeBlockCopyButtonIsShow: boolean = true
  // 代码块代码复制文本是否显示列表
  codeBlockCopyTextIsShowList: Array<boolean> = booleanListGeneralData
  @State // 代码块代码复制文本是否显示
  codeBlockCopyTextIsShow: boolean = true
  // 代码块代码复制按钮默认图标列表
  codeBlockCopyIconList: Array<Resource | undefined> = [undefined, $r('app.media.startIcon')]
  @State // 代码块代码复制按钮默认图标
  codeBlockCopyIcon: Resource | undefined = undefined
  // 代码块代码复制图标宽度列表
  codeBlockCopyIconWidthList: Array<Length> = widthOrHeightListGeneralData
  @State // 代码块代码复制图标宽度
  codeBlockCopyIconWidth: Length = 24.0
  // 代码块代码复制图标高度列表
  codeBlockCopyIconHeightList: Array<Length> = widthOrHeightListGeneralData
  @State // 代码块代码复制图标高度
  codeBlockCopyIconHeight: Length = 24.0
  // 代码块代码复制图标和文本间距列表
  codeBlockCopyIconTextSpacingList: Array<number> = spaceListGeneralData
  @State // 代码块代码复制图标和文本间距
  codeBlockCopyIconTextSpacing: number = 5
  // 代码块代码复制默认文本内容列表
  codeBlockCopyTextList: Array<string> = ['Copy', '复制', '']
  @State // 代码块代码复制默认文本内容
  codeBlockCopyText: string = 'Copy'
  // 代码块代码复制文本颜色列表
  codeBlockCopyTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 代码块代码复制文本颜色
  codeBlockCopyTextFontColor: ResourceColor | undefined = undefined
  // 代码块代码复制文本尺寸列表
  codeBlockCopyTextFontSizeList: Array<number | string | Resource | undefined> = textSizeListGeneralData
  @State // 代码块代码复制文本尺寸
  codeBlockCopyTextFontSize: number | string | Resource | undefined = undefined
  // 代码块代码复制文本字体样式列表
  codeBlockCopyTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 代码块代码复制文本字体样式
  codeBlockCopyTextFontStyle: FontStyle | undefined = undefined
  // 代码块代码复制文本字体粗细列表
  codeBlockCopyTextFontWeightList: Array<FontWeight | undefined> = fontWeightListGeneraData
  @State // 代码块代码复制文本字体粗细
  codeBlockCopyTextFontWeight: FontWeight | undefined = undefined
  // 代码块代码复制文本字体列表
  codeBlockCopyTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 代码块代码复制文本字体
  codeBlockCopyTextFontFamily: string | undefined = undefined
  // 代码块代码复制文本行高列表
  codeBlockCopyTextLineHeightList: Array<number | string | Resource | undefined> = textLineHeightListGeneralData
  @State // 代码块代码复制文本行高
  codeBlockCopyTextLineHeight: number | string | Resource | undefined = undefined
  // 代码块代码全屏按钮是否显示列表
  codeBlockFullScreenButtonIsShowList: Array<boolean> = booleanListGeneralData
  @State // 代码块代码全屏按钮是否显示
  codeBlockFullScreenButtonIsShow: boolean = true
  // 代码块代码全屏文本是否显示列表
  codeBlockFullScreenTextIsShowList: Array<boolean> = booleanListGeneralData
  @State // 代码块代码全屏文本是否显示
  codeBlockFullScreenTextIsShow: boolean = true
  // 代码块代码全屏按钮默认图标列表
  codeBlockFullScreenIconList: Array<Resource | undefined> = [undefined, $r('app.media.startIcon')]
  @State // 代码块代码全屏按钮默认图标
  codeBlockFullScreenIcon: Resource | undefined = undefined
  // 代码块代码全屏图标宽度列表
  codeBlockFullScreenIconWidthList: Array<Length> = widthOrHeightListGeneralData
  @State // 代码块代码全屏图标宽度
  codeBlockFullScreenIconWidth: Length = 24.0
  // 代码块代码全屏图标高度列表
  codeBlockFullScreenIconHeightList: Array<Length> = widthOrHeightListGeneralData
  @State // 代码块代码全屏图标高度
  codeBlockFullScreenIconHeight: Length = 24.0
  // 代码块代码全屏图标和文本间距列表
  codeBlockFullScreenIconTextSpacingList: Array<number> = spaceListGeneralData
  @State // 代码块代码全屏图标和文本间距
  codeBlockFullScreenIconTextSpacing: number = 5
  // 代码块代码全屏默认文本内容列表
  codeBlockFullScreenTextList: Array<string> = ['Full Screen', '全屏', '']
  @State // 代码块代码全屏默认文本内容
  codeBlockFullScreenText: string = 'Full Screen'
  // 代码块代码全屏文本颜色列表
  codeBlockFullScreenTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 代码块代码全屏文本颜色
  codeBlockFullScreenTextFontColor: ResourceColor | undefined = undefined
  // 代码块代码全屏文本尺寸列表
  codeBlockFullScreenTextFontSizeList: Array<number | string | Resource | undefined> = textSizeListGeneralData
  @State // 代码块代码全屏文本尺寸
  codeBlockFullScreenTextFontSize: number | string | Resource | undefined = undefined
  // 代码块代码全屏文本字体样式列表
  codeBlockFullScreenTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 代码块代码全屏文本字体样式
  codeBlockFullScreenTextFontStyle: FontStyle | undefined = undefined
  // 代码块代码全屏文本字体粗细列表
  codeBlockFullScreenTextFontWeightList: Array<FontWeight | undefined> = fontWeightListGeneraData
  @State // 代码块代码全屏文本字体粗细
  codeBlockFullScreenTextFontWeight: FontWeight | undefined = undefined
  // 代码块代码全屏文本字体列表
  codeBlockFullScreenTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 代码块代码全屏文本字体
  codeBlockFullScreenTextFontFamily: string | undefined = undefined
  // 代码块代码全屏文本行高列表
  codeBlockFullScreenTextLineHeightList: Array<number | string | Resource | undefined> = textLineHeightListGeneralData
  @State // 代码块代码全屏文本行高
  codeBlockFullScreenTextLineHeight: number | string | Resource | undefined = undefined
  // 代码块代码行号是否显示列表
  codeBlockLineNumberIsShowList: Array<boolean> = booleanListGeneralData
  @State // 代码块代码行号是否显示
  codeBlockLineNumberIsShow: boolean = true
  // 代码块代码行号左内边距列表
  codeBlockLineNumberTextPaddingLeftList: Array<Length> = spaceListGeneralData
  @State // 代码块代码行号左内边距
  codeBlockLineNumberTextPaddingLeft: Length = 8.0
  // 代码块代码行号文本颜色列表
  codeBlockLineNumberTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 代码块代码行号文本颜色
  codeBlockLineNumberTextFontColor: ResourceColor | undefined = undefined
  // 代码块代码行号文本尺寸列表
  codeBlockLineNumberTextFontSizeList: Array<number | string | Resource | undefined> = textSizeListGeneralData
  @State // 代码块代码行号文本尺寸
  codeBlockLineNumberTextFontSize: number | string | Resource | undefined = undefined
  // 代码块代码行号文本字体样式列表
  codeBlockLineNumberTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 代码块代码行号文本字体样式
  codeBlockLineNumberTextFontStyle: FontStyle | undefined = undefined
  // 代码块代码行号文本字体粗细列表
  codeBlockLineNumberTextFontWeightList: Array<FontWeight | undefined> = fontWeightListGeneraData
  @State // 代码块代码行号文本字体粗细
  codeBlockLineNumberTextFontWeight: FontWeight | undefined = undefined
  // 代码块代码行号文本字体列表
  codeBlockLineNumberTextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State // 代码块代码行号文本字体
  codeBlockLineNumberTextFontFamily: string | undefined = undefined
  // 代码块代码行号文本行高列表
  codeBlockLineNumberTextLineHeightList: Array<number | string | Resource | undefined> = textLineHeightListGeneralData
  @State // 代码块代码行号文本行高
  codeBlockLineNumberTextLineHeight: number | string | Resource | undefined = undefined
  // 代码块代码行号和代码块中间分割线颜色列表
  codeBlockDividerColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 代码块代码行号和代码块中间分割线颜色
  codeBlockDividerColor: ResourceColor | undefined = undefined
  // 代码块代码行号和代码块中间分割线宽度列表
  codeBlockDividerStrokeWidthList: Array<Length> = lineOrBorderWidthListGeneraData
  @State // 代码块代码行号和代码块中间分割线宽度
  codeBlockDividerStrokeWidth: Length = 0.5
  // 代码块代码行号和分割线间距列表
  codeBlockLineNumberDividerSpacingList: Array<number> = spaceListGeneralData
  @State // 代码块代码行号和分割线间距
  codeBlockLineNumberDividerSpacing: number = 8
  // 代码块文本颜色列表
  codeBlockTextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State // 代码块文本颜色
  codeBlockTextFontColor: ResourceColor | undefined = undefined
  // 代码块代码文本右外边距列表
  codeBlockTextMarginRightList: Array<Length> = marginListGeneralData
  @State // 代码块代码文本右外边距
  codeBlockTextMarginRight: Length = 8.0
  // 代码块代码文本左外边距列表
  codeBlockTextMarginLeftList: Array<Length> = marginListGeneralData
  @State // 代码块代码文本左外边距
  codeBlockTextMarginLeft: Length = 8.0
  // 代码块文本尺寸列表
  codeBlockTextFontSizeList: Array<number | string | Resource> = textSizeListGeneralData
  @State // 代码块文本尺寸
  codeBlockTextFontSize: number | string | Resource = 13.0
  // 代码块文本字体样式列表
  codeBlockTextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State // 代码块文本字体样式
  codeBlockTextFontStyle: FontStyle = FontStyle.Normal
  // 代码块文本字体粗细列表
  codeBlockTextFontWeightList: Array<number | FontWeight> = fontWeightListGeneraData
  @State // 代码块文本字体粗细
  codeBlockTextFontWeight: number | FontWeight = FontWeight.Normal
  // 代码块文本字体列表
  codeBlockTextFontFamilyList: Array<string | Resource> = textTypefaceListGeneralData
  @State // 代码块文本字体
  codeBlockTextFontFamily: string | Resource = 'HarmonyOS Sans'
  // 代码块文本行高列表
  codeBlockTextLineHeightList: Array<number | string | Resource> = textLineHeightListGeneralData
  @State // 代码块文本行高
  codeBlockTextLineHeight: number | string | Resource = 22.0
  // 代码块文本字符间距列表
  codeBlockTextLetterSpacingList: Array<number> = spaceListGeneralData
  @State // 代码块文本字符间距
  codeBlockTextLetterSpacing: number = 0

  @State // 配置数据内容
  codeBlockData: CodeBlockData = new CodeBlockData()
  heightMD: number = 30 * 2 // 乘以行数
  @State isExpanded1: boolean = false // 控制展开/折叠状态 - 通用样式配置
  @State isExpanded2: boolean = false // 控制展开/折叠状态 - 边距和边框
  @State isExpanded3: boolean = false // 控制展开/折叠状态 - 类型文本
  @State isExpanded4: boolean = false // 控制展开/折叠状态 - 复制相关
  @State isExpanded5: boolean = false // 控制展开/折叠状态 - 全屏相关
  @State isExpanded6: boolean = false // 控制展开/折叠状态 - 代码块行号
  @State isExpanded7: boolean = false // 控制展开/折叠状态 - 代码块文本

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "代码块配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // md文档展示部分
      Column() {
        GridRow({
          columns: 4,
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
                .fontColor('#FFFFFFFF')
                .backgroundColor('#FFEE82EE')
                .height(25).width('100%')
                .padding(5)
                .borderRadius(5)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Clip })
                .onClick(() => {
                  // ---------- 通用
                  this.codeBlockData._isFull = this.isFull
                  this.codeBlockData._incrementalAnalysis = this.incrementalAnalysis
                  this.codeBlockData._time = this.time
                  this.codeBlockData._textNumber = this.textNumber
                  this.codeBlockData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.codeBlockData._isOnCopy = this.isOnCopy
                  this.codeBlockData._blockMarginTop = this.blockMarginTop
                  this.codeBlockData._blockMarginRight = this.blockMarginRight
                  this.codeBlockData._blockMarginBottom = this.blockMarginBottom
                  this.codeBlockData._blockMarginLeft = this.blockMarginLeft
                  this.codeBlockData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.codeBlockData._isLineBreak = this.isLineBreak
                  this.codeBlockData._backgroundColor = this.globalBackgroundColor
                  this.codeBlockData._openGestureSwipe = this.openGestureSwipe
                  this.codeBlockData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.codeBlockData._pagePath = `${this.rawFilePath}/${item}`

                  // ---------- 专有
                  this.codeBlockData.codeBlockIsDark = this.codeBlockIsDark
                  this.codeBlockData.codeBlockIsCodeFormat = this.codeBlockIsCodeFormat
                  this.codeBlockData.codeBlockUseTab = this.codeBlockUseTab
                  this.codeBlockData.codeBlockIndentWidth = this.codeBlockIndentWidth
                  this.codeBlockData.codeBlockParserSync = this.codeBlockParserSync
                  this.codeBlockData._codeBlockBackgroundColor = this.codeBlockBackgroundColor
                  this.codeBlockData.codeBlockMarginTop = this.codeBlockMarginTop
                  this.codeBlockData.codeBlockMarginRight = this.codeBlockMarginRight
                  this.codeBlockData.codeBlockMarginBottom = this.codeBlockMarginBottom
                  this.codeBlockData.codeBlockMarginLeft = this.codeBlockMarginLeft
                  this.codeBlockData.codeBlockPaddingTop = this.codeBlockPaddingTop
                  this.codeBlockData.codeBlockPaddingRight = this.codeBlockPaddingRight
                  this.codeBlockData.codeBlockPaddingBottom = this.codeBlockPaddingBottom
                  this.codeBlockData.codeBlockPaddingLeft = this.codeBlockPaddingLeft
                  this.codeBlockData.codeBlockBorderStyle = this.codeBlockBorderStyle
                  this.codeBlockData.codeBlockBorderWidth = this.codeBlockBorderWidth
                  this.codeBlockData.codeBlockBorderColor = this.codeBlockBorderColor
                  this.codeBlockData.codeBlockRadiusTopLeft = this.codeBlockRadiusTopLeft
                  this.codeBlockData.codeBlockRadiusTopRight = this.codeBlockRadiusTopRight
                  this.codeBlockData.codeBlockRadiusBottomLeft = this.codeBlockRadiusBottomLeft
                  this.codeBlockData.codeBlockRadiusBottomRight = this.codeBlockRadiusBottomRight
                  this.codeBlockData.codeBlockTitleLayoutMarginBottom = this.codeBlockTitleLayoutMarginBottom
                  this.codeBlockData.codeBlockTypeTextMarginLeft = this.codeBlockTypeTextMarginLeft
                  this.codeBlockData.codeBlockTypeText = this.codeBlockTypeText
                  this.codeBlockData.codeBlockTypeTextFontColor = this.codeBlockTypeTextFontColor
                  this.codeBlockData.codeBlockTypeTextFontSize = this.codeBlockTypeTextFontSize
                  this.codeBlockData.codeBlockTypeTextFontStyle = this.codeBlockTypeTextFontStyle
                  this.codeBlockData.codeBlockTypeTextFontWeight = this.codeBlockTypeTextFontWeight
                  this.codeBlockData.codeBlockTypeTextFontFamily = this.codeBlockTypeTextFontFamily
                  this.codeBlockData.codeBlockTypeTextLineHeight = this.codeBlockTypeTextLineHeight
                  this.codeBlockData.codeBlockCopyFullScreenSpacing = this.codeBlockCopyFullScreenSpacing
                  this.codeBlockData.codeBlockCopyButtonIsShow = this.codeBlockCopyButtonIsShow
                  this.codeBlockData.codeBlockCopyTextIsShow = this.codeBlockCopyTextIsShow
                  this.codeBlockData.codeBlockCopyIcon = this.codeBlockCopyIcon
                  this.codeBlockData.codeBlockCopyIconWidth = this.codeBlockCopyIconWidth
                  this.codeBlockData.codeBlockCopyIconHeight = this.codeBlockCopyIconHeight
                  this.codeBlockData.codeBlockCopyIconTextSpacing = this.codeBlockCopyIconTextSpacing
                  this.codeBlockData.codeBlockCopyText = this.codeBlockCopyText
                  this.codeBlockData.codeBlockCopyTextFontColor = this.codeBlockCopyTextFontColor
                  this.codeBlockData.codeBlockCopyTextFontSize = this.codeBlockCopyTextFontSize
                  this.codeBlockData.codeBlockCopyTextFontStyle = this.codeBlockCopyTextFontStyle
                  this.codeBlockData.codeBlockCopyTextFontWeight = this.codeBlockCopyTextFontWeight
                  this.codeBlockData.codeBlockCopyTextFontFamily = this.codeBlockCopyTextFontFamily
                  this.codeBlockData.codeBlockCopyTextLineHeight = this.codeBlockCopyTextLineHeight
                  this.codeBlockData.codeBlockFullScreenButtonIsShow = this.codeBlockFullScreenButtonIsShow
                  this.codeBlockData.codeBlockFullScreenTextIsShow = this.codeBlockFullScreenTextIsShow
                  this.codeBlockData.codeBlockFullScreenIcon = this.codeBlockFullScreenIcon
                  this.codeBlockData.codeBlockFullScreenIconWidth = this.codeBlockFullScreenIconWidth
                  this.codeBlockData.codeBlockFullScreenIconHeight = this.codeBlockFullScreenIconHeight
                  this.codeBlockData.codeBlockFullScreenIconTextSpacing = this.codeBlockFullScreenIconTextSpacing
                  this.codeBlockData.codeBlockFullScreenText = this.codeBlockFullScreenText
                  this.codeBlockData.codeBlockFullScreenTextFontColor = this.codeBlockFullScreenTextFontColor
                  this.codeBlockData.codeBlockFullScreenTextFontSize = this.codeBlockFullScreenTextFontSize
                  this.codeBlockData.codeBlockFullScreenTextFontStyle = this.codeBlockFullScreenTextFontStyle
                  this.codeBlockData.codeBlockFullScreenTextFontWeight = this.codeBlockFullScreenTextFontWeight
                  this.codeBlockData.codeBlockFullScreenTextFontFamily = this.codeBlockFullScreenTextFontFamily
                  this.codeBlockData.codeBlockFullScreenTextLineHeight = this.codeBlockFullScreenTextLineHeight
                  this.codeBlockData.codeBlockLineNumberIsShow = this.codeBlockLineNumberIsShow
                  this.codeBlockData.codeBlockLineNumberTextPaddingLeft = this.codeBlockLineNumberTextPaddingLeft
                  this.codeBlockData.codeBlockLineNumberTextFontColor = this.codeBlockLineNumberTextFontColor
                  this.codeBlockData.codeBlockLineNumberTextFontSize = this.codeBlockLineNumberTextFontSize
                  this.codeBlockData.codeBlockLineNumberTextFontStyle = this.codeBlockLineNumberTextFontStyle
                  this.codeBlockData.codeBlockLineNumberTextFontWeight = this.codeBlockLineNumberTextFontWeight
                  this.codeBlockData.codeBlockLineNumberTextFontFamily = this.codeBlockLineNumberTextFontFamily
                  this.codeBlockData.codeBlockLineNumberTextLineHeight = this.codeBlockLineNumberTextLineHeight
                  this.codeBlockData.codeBlockDividerColor = this.codeBlockDividerColor
                  this.codeBlockData.codeBlockDividerStrokeWidth = this.codeBlockDividerStrokeWidth
                  this.codeBlockData.codeBlockLineNumberDividerSpacing = this.codeBlockLineNumberDividerSpacing
                  this.codeBlockData.codeBlockTextFontColor = this.codeBlockTextFontColor
                  this.codeBlockData.codeBlockTextMarginRight = this.codeBlockTextMarginRight
                  this.codeBlockData.codeBlockTextMarginLeft = this.codeBlockTextMarginLeft
                  this.codeBlockData.codeBlockTextFontSize = this.codeBlockTextFontSize
                  this.codeBlockData.codeBlockTextFontStyle = this.codeBlockTextFontStyle
                  this.codeBlockData.codeBlockTextFontWeight = this.codeBlockTextFontWeight
                  this.codeBlockData.codeBlockTextFontFamily = this.codeBlockTextFontFamily
                  this.codeBlockData.codeBlockTextLineHeight = this.codeBlockTextLineHeight
                  this.codeBlockData.codeBlockTextLetterSpacing = this.codeBlockTextLetterSpacing
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/CodeBlockDetailsPage", params: this.codeBlockData })
                })
            }
          })
        }.width('100%').height('100%')
      }.padding({ top: 5, bottom: 5 }).width('100%').height(this.heightMD)

      Scroll() {
        Column() {
          // 通用样式配置
          Column() {
            Row() {
              Text("通用样式配置")
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
                  titleStr: "markdown全局上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginTopList,
                  allData: this.blockMarginTop
                })
                BaseTabComponent({
                  titleStr: "markdown全局右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginRightList,
                  allData: this.blockMarginRight
                })
                BaseTabComponent({
                  titleStr: "markdown全局下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginBottomList,
                  allData: this.blockMarginBottom
                })
                BaseTabComponent({
                  titleStr: "markdown全局左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.blockMarginLeftList,
                  allData: this.blockMarginLeft
                })
                BaseTabComponent({
                  titleStr: "模块间上下间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.markdownBlockSpacingList,
                  allData: this.markdownBlockSpacing
                })
                BaseTabComponent({
                  titleStr: "背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.globalBackgroundColorList,
                  allData: this.globalBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "是否开启响应滑动测试 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.openGestureSwipeTestList,
                  allData: this.openGestureSwipeTest
                })
                BaseTabComponent({
                  titleStr: "是否允许markdown控件自身响应滑动 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.openGestureSwipeList,
                  allData: this.openGestureSwipe
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

          // 边距和边框
          Column() {
            Row() {
              Text("代码块边距和边框")
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
                BaseTabComponent({
                  titleStr: "代码块背景颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.codeBlockBackgroundColorList,
                  allData: this.codeBlockBackgroundColor
                })
                BaseTabComponent({
                  titleStr: "代码块上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockMarginTopList,
                  allData: this.codeBlockMarginTop
                })
                BaseTabComponent({
                  titleStr: "代码块右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockMarginRightList,
                  allData: this.codeBlockMarginRight
                })
                BaseTabComponent({
                  titleStr: "代码块下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockMarginBottomList,
                  allData: this.codeBlockMarginBottom
                })
                BaseTabComponent({
                  titleStr: "代码块左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockMarginLeftList,
                  allData: this.codeBlockMarginLeft
                })
                BaseTabComponent({
                  titleStr: "代码块上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockPaddingTopList,
                  allData: this.codeBlockPaddingTop
                })
                BaseTabComponent({
                  titleStr: "代码块右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockPaddingRightList,
                  allData: this.codeBlockPaddingRight
                })
                BaseTabComponent({
                  titleStr: "代码块下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockPaddingBottomList,
                  allData: this.codeBlockPaddingBottom
                })
                BaseTabComponent({
                  titleStr: "代码块左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockPaddingLeftList,
                  allData: this.codeBlockPaddingLeft
                })
                BaseTabComponent({
                  titleStr: "代码块边框样式 - ",
                  typeEnum: TypeEnum.IS_BORDER_STYLE,
                  allListData: this.codeBlockBorderStyleList,
                  allData: this.codeBlockBorderStyle
                })
                BaseTabComponent({
                  titleStr: "代码块边框宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockBorderWidthList,
                  allData: this.codeBlockBorderWidth
                })
                BaseTabComponent({
                  titleStr: "代码块边框颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.codeBlockBorderColorList,
                  allData: this.codeBlockBorderColor
                })
                BaseTabComponent({
                  titleStr: "代码块边框左上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockRadiusTopLeftList,
                  allData: this.codeBlockRadiusTopLeft
                })
                BaseTabComponent({
                  titleStr: "代码块边框右上圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockRadiusTopRightList,
                  allData: this.codeBlockRadiusTopRight
                })
                BaseTabComponent({
                  titleStr: "代码块边框左下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockRadiusBottomLeftList,
                  allData: this.codeBlockRadiusBottomLeft
                })
                BaseTabComponent({
                  titleStr: "代码块边框右下圆角 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockRadiusBottomRightList,
                  allData: this.codeBlockRadiusBottomRight
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

          // 类型文本
          Column() {
            Row() {
              Text("代码块类型文本")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded3 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded3 = !this.isExpanded3
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded3 = !this.isExpanded3
            })

            if (this.isExpanded3) {
              Column() {
                BaseTabComponent({
                  titleStr: "代码块类型和代码块内容间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockTitleLayoutMarginBottomList,
                  allData: this.codeBlockTitleLayoutMarginBottom
                })
                BaseTabComponent({
                  titleStr: "代码块类型左边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockTypeTextMarginLeftList,
                  allData: this.codeBlockTypeTextMarginLeft
                })
                BaseTabComponent({
                  titleStr: "代码块没有代码类型时默认显示文本 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.codeBlockTypeTextList,
                  allData: this.codeBlockTypeText
                })
                BaseTabComponent({
                  titleStr: "代码块类型文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.codeBlockTypeTextFontColorList,
                  allData: this.codeBlockTypeTextFontColor
                })
                BaseTabComponent({
                  titleStr: "代码块类型文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockTypeTextFontSizeList,
                  allData: this.codeBlockTypeTextFontSize
                })
                BaseTabComponent({
                  titleStr: "代码块类型文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.codeBlockTypeTextFontStyleList,
                  allData: this.codeBlockTypeTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "代码块类型文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.codeBlockTypeTextFontWeightList,
                  allData: this.codeBlockTypeTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "代码块类型文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.codeBlockTypeTextFontFamilyList,
                  allData: this.codeBlockTypeTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "代码块类型文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockTypeTextLineHeightList,
                  allData: this.codeBlockTypeTextLineHeight
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

          // 复制相关
          Column() {
            Row() {
              Text("代码块复制相关")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded4 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded4 = !this.isExpanded4
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded4 = !this.isExpanded4
            })

            if (this.isExpanded4) {
              Column() {
                BaseTabComponent({
                  titleStr: "代码块代码复制和代码全屏间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockCopyFullScreenSpacingList,
                  allData: this.codeBlockCopyFullScreenSpacing
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制按钮是否显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.codeBlockCopyButtonIsShowList,
                  allData: this.codeBlockCopyButtonIsShow
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制文本是否显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.codeBlockCopyTextIsShowList,
                  allData: this.codeBlockCopyTextIsShow
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制按钮默认图标 - ",
                  typeEnum: TypeEnum.IS_RESOURCE,
                  allListData: this.codeBlockCopyIconList,
                  allData: this.codeBlockCopyIcon
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制图标宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockCopyIconWidthList,
                  allData: this.codeBlockCopyIconWidth
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制图标高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockCopyIconHeightList,
                  allData: this.codeBlockCopyIconHeight
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制图标和文本间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockCopyIconTextSpacingList,
                  allData: this.codeBlockCopyIconTextSpacing
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制默认文本内容 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.codeBlockCopyTextList,
                  allData: this.codeBlockCopyText
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.codeBlockCopyTextFontColorList,
                  allData: this.codeBlockCopyTextFontColor
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockCopyTextFontSizeList,
                  allData: this.codeBlockCopyTextFontSize
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.codeBlockCopyTextFontStyleList,
                  allData: this.codeBlockCopyTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.codeBlockCopyTextFontWeightList,
                  allData: this.codeBlockCopyTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.codeBlockCopyTextFontFamilyList,
                  allData: this.codeBlockCopyTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "代码块代码复制文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockCopyTextLineHeightList,
                  allData: this.codeBlockCopyTextLineHeight
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

          // 全屏相关
          Column() {
            Row() {
              Text("代码块全屏相关")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded5 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded5 = !this.isExpanded5
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded5 = !this.isExpanded5
            })

            if (this.isExpanded5) {
              Column() {
                BaseTabComponent({
                  titleStr: "代码块代码全屏按钮是否显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.codeBlockFullScreenButtonIsShowList,
                  allData: this.codeBlockFullScreenButtonIsShow
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏文本是否显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.codeBlockFullScreenTextIsShowList,
                  allData: this.codeBlockFullScreenTextIsShow
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏按钮默认图标 - ",
                  typeEnum: TypeEnum.IS_RESOURCE,
                  allListData: this.codeBlockFullScreenIconList,
                  allData: this.codeBlockFullScreenIcon
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏图标宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockFullScreenIconWidthList,
                  allData: this.codeBlockFullScreenIconWidth
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏图标高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockFullScreenIconHeightList,
                  allData: this.codeBlockFullScreenIconHeight
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏图标和文本间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockFullScreenIconTextSpacingList,
                  allData: this.codeBlockFullScreenIconTextSpacing
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏默认文本内容 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.codeBlockFullScreenTextList,
                  allData: this.codeBlockFullScreenText
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.codeBlockFullScreenTextFontColorList,
                  allData: this.codeBlockFullScreenTextFontColor
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockFullScreenTextFontSizeList,
                  allData: this.codeBlockFullScreenTextFontSize
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.codeBlockFullScreenTextFontStyleList,
                  allData: this.codeBlockFullScreenTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.codeBlockFullScreenTextFontWeightList,
                  allData: this.codeBlockFullScreenTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.codeBlockFullScreenTextFontFamilyList,
                  allData: this.codeBlockFullScreenTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "代码块代码全屏文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockFullScreenTextLineHeightList,
                  allData: this.codeBlockFullScreenTextLineHeight
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

          // 代码块行号
          Column() {
            Row() {
              Text("代码块行号")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded6 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded6 = !this.isExpanded6
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded6 = !this.isExpanded6
            })

            if (this.isExpanded6) {
              Column() {
                BaseTabComponent({
                  titleStr: "代码块代码行号是否显示 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.codeBlockLineNumberIsShowList,
                  allData: this.codeBlockLineNumberIsShow
                })
                BaseTabComponent({
                  titleStr: "代码块代码行号左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockLineNumberTextPaddingLeftList,
                  allData: this.codeBlockLineNumberTextPaddingLeft
                })
                BaseTabComponent({
                  titleStr: "代码块代码行号文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.codeBlockLineNumberTextFontColorList,
                  allData: this.codeBlockLineNumberTextFontColor
                })
                BaseTabComponent({
                  titleStr: "代码块代码行号文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockLineNumberTextFontSizeList,
                  allData: this.codeBlockLineNumberTextFontSize
                })
                BaseTabComponent({
                  titleStr: "代码块代码行号文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.codeBlockLineNumberTextFontStyleList,
                  allData: this.codeBlockLineNumberTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "代码块代码行号文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.codeBlockLineNumberTextFontWeightList,
                  allData: this.codeBlockLineNumberTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "代码块代码行号文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.codeBlockLineNumberTextFontFamilyList,
                  allData: this.codeBlockLineNumberTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "代码块代码行号文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockLineNumberTextLineHeightList,
                  allData: this.codeBlockLineNumberTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "代码块代码行号和代码块中间分割线颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.codeBlockDividerColorList,
                  allData: this.codeBlockDividerColor
                })
                BaseTabComponent({
                  titleStr: "代码块代码行号和代码块中间分割线宽度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockDividerStrokeWidthList,
                  allData: this.codeBlockDividerStrokeWidth
                })
                BaseTabComponent({
                  titleStr: "代码块代码行号和分割线间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockLineNumberDividerSpacingList,
                  allData: this.codeBlockLineNumberDividerSpacing
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

          // 代码块文本
          Column() {
            Row() {
              Text("代码块文本")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .fontWeight(FontWeight.Bold)
                .layoutWeight(1)
              Text(this.isExpanded7 ? "▲" : "▼")
                .fontSize(16)
                .fontColor('#FFF5F5F5')
                .padding({ right: 20 })
                .onClick(() => {
                  this.isExpanded7 = !this.isExpanded7
                })
            }
            .width('100%')
            .padding(5)
            .margin(5)
            .onClick(() => {
              this.isExpanded7 = !this.isExpanded7
            })

            if (this.isExpanded7) {
              Column() {
                BaseTabComponent({
                  titleStr: "是否格式化围栏代码块内容 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.codeBlockIsCodeFormatList,
                  allData: this.codeBlockIsCodeFormat
                })
                BaseTabComponent({
                  titleStr: "代码深浅色模式 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.codeBlockIsDarkList,
                  allData: this.codeBlockIsDark
                })
                BaseTabComponent({
                  titleStr: "codeformat是否用制表符 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.codeBlockUseTabList,
                  allData: this.codeBlockUseTab
                })
                BaseTabComponent({
                  titleStr: "codeformat空格缩进数量 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockIndentWidthList,
                  allData: this.codeBlockIndentWidth
                })
                BaseTabComponent({
                  titleStr: "围栏代码块代码高亮是否同步解析 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.codeBlockParserSyncList,
                  allData: this.codeBlockParserSync
                })
                BaseTabComponent({
                  titleStr: "代码块文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.codeBlockTextFontColorList,
                  allData: this.codeBlockTextFontColor
                })
                BaseTabComponent({
                  titleStr: "代码块代码文本右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockTextMarginRightList,
                  allData: this.codeBlockTextMarginRight
                })
                BaseTabComponent({
                  titleStr: "代码块代码文本左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockTextMarginLeftList,
                  allData: this.codeBlockTextMarginLeft
                })
                BaseTabComponent({
                  titleStr: "代码块文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockTextFontSizeList,
                  allData: this.codeBlockTextFontSize
                })
                BaseTabComponent({
                  titleStr: "代码块文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.codeBlockTextFontStyleList,
                  allData: this.codeBlockTextFontStyle
                })
                BaseTabComponent({
                  titleStr: "代码块文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.codeBlockTextFontWeightList,
                  allData: this.codeBlockTextFontWeight
                })
                BaseTabComponent({
                  titleStr: "代码块文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.codeBlockTextFontFamilyList,
                  allData: this.codeBlockTextFontFamily
                })
                BaseTabComponent({
                  titleStr: "代码块文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockTextLineHeightList,
                  allData: this.codeBlockTextLineHeight
                })
                BaseTabComponent({
                  titleStr: "代码块文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.codeBlockTextLetterSpacingList,
                  allData: this.codeBlockTextLetterSpacing
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
    .backgroundColor('#FFEAEAEA')
    .height("90%")
  }
}