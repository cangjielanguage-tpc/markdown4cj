import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  fontStyleListGeneraData,
  fontWeightListGeneraData,
  lineOrBorderWidthListGeneraData,
  marginListGeneralData,
  spaceListGeneralData,
  textLineHeightListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  textTypefaceListGeneralData,
  textWordSpaceListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { TitleData } from '../model/TitleData'

@Entry
@Component
struct TitlePage {
  // ---------------- 通用
  // 滑动控制器
  scroller: Scroller = new Scroller()
  @StorageProp('safeTop') safeTop: number = 0 // 顶部导航栏高度
  // rawfile路径
  rawFilePath: string = "001_Heading"
  @State folderList: Array<string> = new Array<string>() // rawfile文件夹列表
  // 是否全量加载Markdown文本列表
  isFullList: Array<boolean> = booleanListGeneralData
  @State isFull: boolean = true // 是否全量加载Markdown文本
  // 是否增量解析Markdown文本列表
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  @State incrementalAnalysis: boolean = false // 是否增量解析Markdown文本
  // 是否启用解析节流列表
  enableParseThrottleList: Array<boolean> = booleanListGeneralData
  @State enableParseThrottle: boolean = false // 是否启用解析节流
  // 解析节流间隔列表
  parseThrottleMsList: Array<number> = timeListGeneralData
  @State parseThrottleMs: number = 200 // 解析节流间隔（ms）
  // 增量加载每次间隔时间列表
  timeList: Array<number> = timeListGeneralData
  @State time: number = 50 // 增量加载每次间隔时间
  // 增量每次增量文本数量列表
  textNumberList: Array<number> = textNumberListGeneralData
  @State textNumber: number = 10 // 增量每次增量文本数量
  // 是否同步解析Markdown文本列表
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  @State isMarkdownParserSync: boolean = false // 是否同步解析Markdown文本
  // 是否打开长按复制粘贴效果列表
  isOnCopyList: Array<boolean> = booleanListGeneralData
  @State isOnCopy: boolean = false // 是否打开长按复制粘贴效果
  // markdown全局上外边距列表
  blockMarginTopList: Array<number> = marginListGeneralData
  @State blockMarginTop: number = 0 // markdown全局上外边距
  // markdown全局右外边距列表
  blockMarginRightList: Array<number> = marginListGeneralData
  @State blockMarginRight: number = 0 // markdown全局右外边距
  // markdown全局下外边距列表
  blockMarginBottomList: Array<number> = marginListGeneralData
  @State blockMarginBottom: number = 0 // markdown全局下外边距
  // markdown全局左外边距列表
  blockMarginLeftList: Array<number> = marginListGeneralData
  @State blockMarginLeft: number = 0 // markdown全局左外边距
  // 模块间上下间距列表
  markdownBlockSpacingList: Array<number> = marginListGeneralData
  @State markdownBlockSpacing: number = 8 // 模块间上下间距
  // 软换行是否换行列表
  isLineBreakList: Array<boolean> = booleanListGeneralData
  @State isLineBreak: boolean = false // 软换行是否换行
  // 背景颜色列表
  globalBackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State globalBackgroundColor: ResourceColor | undefined = undefined // 背景颜色
  // 是否允许markdown控件自身响应滑动列表
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipe: boolean = false // 是否允许markdown控件自身响应滑动
  // 是否开启响应滑动测试列表
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  @State openGestureSwipeTest: boolean = false // 是否开启响应滑动测试
  // ---------------- 专有
  // 一级标题背景颜色列表
  heading1BackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading1BackgroundColor: ResourceColor | undefined = undefined // 一级标题背景颜色
  // 一级标题上外边距列表
  heading1MarginTopList: Array<number> = marginListGeneralData
  @State heading1MarginTop: number = 0 // 一级标题上外边距
  // 一级标题右外边距列表
  heading1MarginRightList: Array<number> = marginListGeneralData
  @State heading1MarginRight: number = 0 // 一级标题右外边距
  // 一级标题下外边距列表
  heading1MarginBottomList: Array<number> = marginListGeneralData
  @State heading1MarginBottom: number = 0 // 一级标题下外边距
  // 一级标题左外边距列表
  heading1MarginLeftList: Array<number> = marginListGeneralData
  @State heading1MarginLeft: number = 0 // 一级标题左外边距
  // 一级标题上内边距列表
  heading1PaddingTopList: Array<number> = marginListGeneralData
  @State heading1PaddingTop: number = 0 // 一级标题上内边距
  // 一级标题右内边距列表
  heading1PaddingRightList: Array<number> = marginListGeneralData
  @State heading1PaddingRight: number = 0 // 一级标题右内边距
  // 一级标题下内边距列表
  heading1PaddingBottomList: Array<number> = marginListGeneralData
  @State heading1PaddingBottom: number = 0 // 一级标题下内边距
  // 一级标题左内边距列表
  heading1PaddingLeftList: Array<number> = marginListGeneralData
  @State heading1PaddingLeft: number = 0 // 一级标题左内边距
  // 一级标题文本颜色列表
  heading1TextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading1TextFontColor: ResourceColor | undefined = undefined // 一级标题文本颜色
  // 一级标题文本尺寸列表
  heading1TextFontSizeList: Array<number> = textSizeListGeneralData
  @State heading1TextFontSize: number = 20 // 一级标题文本尺寸
  // 一级标题文本字体样式列表
  heading1TextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State heading1TextFontStyle: FontStyle = FontStyle.Normal // 一级标题文本字体样式
  // 一级标题文本字体粗细列表
  heading1TextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State heading1TextFontWeight: FontWeight = FontWeight.Bold // 一级标题文本字体粗细
  // 一级标题文本字体列表
  heading1TextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State heading1TextFontFamily: string = 'HarmonyOS Sans' // 一级标题文本字体
  // 一级标题文本行高列表
  heading1TextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State heading1TextLineHeight: number = 22 // 一级标题文本行高
  // 一级标题文本字符间距列表
  heading1TextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State heading1TextLetterSpacing: number = 0.0 // 一级标题文本字符间距
  // 一级标题下划线高度列表
  heading1UnderlineHeightList: Array<number> = lineOrBorderWidthListGeneraData
  @State heading1UnderlineHeight: number = 0.5 // 一级标题下划线高度
  // 一级标题下划线颜色列表
  heading1UnderlineColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading1UnderlineColor: ResourceColor | undefined = undefined // 一级标题下划线颜色
  // 一级标题距离标题文本间距列表
  heading1UnderlineSpacingList: Array<number> = spaceListGeneralData
  @State heading1UnderlineSpacing: number = 0 // 一级标题距离标题文本间距
  // 二级标题背景颜色列表
  heading2BackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading2BackgroundColor: ResourceColor | undefined = undefined // 二级标题背景颜色
  // 二级标题上外边距列表
  heading2MarginTopList: Array<number> = marginListGeneralData
  @State heading2MarginTop: number = 0 // 二级标题上外边距
  // 二级标题右外边距列表
  heading2MarginRightList: Array<number> = marginListGeneralData
  @State heading2MarginRight: number = 0 // 二级标题右外边距
  // 二级标题下外边距列表
  heading2MarginBottomList: Array<number> = marginListGeneralData
  @State heading2MarginBottom: number = 0 // 二级标题下外边距
  // 二级标题左外边距列表
  heading2MarginLeftList: Array<number> = marginListGeneralData
  @State heading2MarginLeft: number = 0 // 二级标题左外边距
  // 二级标题上内边距列表
  heading2PaddingTopList: Array<number> = marginListGeneralData
  @State heading2PaddingTop: number = 0 // 二级标题上内边距
  // 二级标题右内边距列表
  heading2PaddingRightList: Array<number> = marginListGeneralData
  @State heading2PaddingRight: number = 0 // 二级标题右内边距
  // 二级标题下内边距列表
  heading2PaddingBottomList: Array<number> = marginListGeneralData
  @State heading2PaddingBottom: number = 0 // 二级标题下内边距
  // 二级标题左内边距列表
  heading2PaddingLeftList: Array<number> = marginListGeneralData
  @State heading2PaddingLeft: number = 0 // 二级标题左内边距
  // 二级标题文本颜色列表
  heading2TextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading2TextFontColor: ResourceColor | undefined = undefined // 二级标题文本颜色
  // 二级标题文本尺寸列表
  heading2TextFontSizeList: Array<number> = textSizeListGeneralData
  @State heading2TextFontSize: number = 17 // 二级标题文本尺寸
  // 二级标题文本字体样式列表
  heading2TextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State heading2TextFontStyle: FontStyle = FontStyle.Normal // 二级标题文本字体样式
  // 二级标题文本字体粗细列表
  heading2TextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State heading2TextFontWeight: FontWeight = FontWeight.Bold // 二级标题文本字体粗细
  // 二级标题文本字体列表
  heading2TextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State heading2TextFontFamily: string = 'HarmonyOS Sans' // 二级标题文本字体
  // 二级标题文本行高列表
  heading2TextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State heading2TextLineHeight: number = 22 // 二级标题文本行高
  // 二级标题文本字符间距列表
  heading2TextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State heading2TextLetterSpacing: number = 0.0 // 二级标题文本字符间距
  // 二级标题下划线高度列表
  heading2UnderlineHeightList: Array<number> = lineOrBorderWidthListGeneraData
  @State heading2UnderlineHeight: number = 0.5 // 二级标题下划线高度
  // 二级标题下划线颜色列表
  heading2UnderlineColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading2UnderlineColor: ResourceColor | undefined = undefined // 二级标题下划线颜色
  // 二级标题距离标题文本间距列表
  heading2UnderlineSpacingList: Array<number> = spaceListGeneralData
  @State heading2UnderlineSpacing: number = 0 // 二级标题距离标题文本间距
  // 三级标题背景颜色列表
  heading3BackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading3BackgroundColor: ResourceColor | undefined = undefined // 三级标题背景颜色
  // 三级标题上外边距列表
  heading3MarginTopList: Array<number> = marginListGeneralData
  @State heading3MarginTop: number = 0 // 三级标题上外边距
  // 三级标题右外边距列表
  heading3MarginRightList: Array<number> = marginListGeneralData
  @State heading3MarginRight: number = 0 // 三级标题右外边距
  // 三级标题下外边距列表
  heading3MarginBottomList: Array<number> = marginListGeneralData
  @State heading3MarginBottom: number = 0 // 三级标题下外边距
  // 三级标题左外边距列表
  heading3MarginLeftList: Array<number> = marginListGeneralData
  @State heading3MarginLeft: number = 0 // 三级标题左外边距
  // 三级标题上内边距列表
  heading3PaddingTopList: Array<number> = marginListGeneralData
  @State heading3PaddingTop: number = 0 // 三级标题上内边距
  // 三级标题右内边距列表
  heading3PaddingRightList: Array<number> = marginListGeneralData
  @State heading3PaddingRight: number = 0 // 三级标题右内边距
  // 三级标题下内边距列表
  heading3PaddingBottomList: Array<number> = marginListGeneralData
  @State heading3PaddingBottom: number = 0 // 三级标题下内边距
  // 三级标题左内边距列表
  heading3PaddingLeftList: Array<number> = marginListGeneralData
  @State heading3PaddingLeft: number = 0 // 三级标题左内边距
  // 三级标题文本颜色列表
  heading3TextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading3TextFontColor: ResourceColor | undefined = undefined // 三级标题文本颜色
  // 三级标题文本尺寸列表
  heading3TextFontSizeList: Array<number> = textSizeListGeneralData
  @State heading3TextFontSize: number = 16 // 三级标题文本尺寸
  // 三级标题文本字体样式列表
  heading3TextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State heading3TextFontStyle: FontStyle = FontStyle.Normal // 三级标题文本字体样式
  // 三级标题文本字体粗细列表
  heading3TextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State heading3TextFontWeight: FontWeight = FontWeight.Bold // 三级标题文本字体粗细
  // 三级标题文本字体列表
  heading3TextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State heading3TextFontFamily: string = 'HarmonyOS Sans' // 三级标题文本字体
  // 三级标题文本行高列表
  heading3TextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State heading3TextLineHeight: number = 22 // 三级标题文本行高
  // 三级标题文本字符间距列表
  heading3TextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State heading3TextLetterSpacing: number = 0.0 // 三级标题文本字符间距
  // 四级标题背景颜色列表
  heading4BackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading4BackgroundColor: ResourceColor | undefined = undefined // 四级标题背景颜色
  // 四级标题上外边距列表
  heading4MarginTopList: Array<number> = marginListGeneralData
  @State heading4MarginTop: number = 0 // 四级标题上外边距
  // 四级标题右外边距列表
  heading4MarginRightList: Array<number> = marginListGeneralData
  @State heading4MarginRight: number = 0 // 四级标题右外边距
  // 四级标题下外边距列表
  heading4MarginBottomList: Array<number> = marginListGeneralData
  @State heading4MarginBottom: number = 0 // 四级标题下外边距
  // 四级标题左外边距列表
  heading4MarginLeftList: Array<number> = marginListGeneralData
  @State heading4MarginLeft: number = 0 // 四级标题左外边距
  // 四级标题上内边距列表
  heading4PaddingTopList: Array<number> = marginListGeneralData
  @State heading4PaddingTop: number = 0 // 四级标题上内边距
  // 四级标题右内边距列表
  heading4PaddingRightList: Array<number> = marginListGeneralData
  @State heading4PaddingRight: number = 0 // 四级标题右内边距
  // 四级标题下内边距列表
  heading4PaddingBottomList: Array<number> = marginListGeneralData
  @State heading4PaddingBottom: number = 0 // 四级标题下内边距
  // 四级标题左内边距列表
  heading4PaddingLeftList: Array<number> = marginListGeneralData
  @State heading4PaddingLeft: number = 0 // 四级标题左内边距
  // 四级标题文本颜色列表
  heading4TextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading4TextFontColor: ResourceColor | undefined = undefined // 四级标题文本颜色
  // 四级标题文本尺寸列表
  heading4TextFontSizeList: Array<number> = textSizeListGeneralData
  @State heading4TextFontSize: number = 15 // 四级标题文本尺寸
  // 四级标题文本字体样式列表
  heading4TextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State heading4TextFontStyle: FontStyle = FontStyle.Normal // 四级标题文本字体样式
  // 四级标题文本字体粗细列表
  heading4TextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State heading4TextFontWeight: FontWeight = FontWeight.Bold // 四级标题文本字体粗细
  // 四级标题文本字体列表
  heading4TextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State heading4TextFontFamily: string = 'HarmonyOS Sans' // 四级标题文本字体
  // 四级标题文本行高列表
  heading4TextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State heading4TextLineHeight: number = 22 // 四级标题文本行高
  // 四级标题文本字符间距列表
  heading4TextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State heading4TextLetterSpacing: number = 0.0 // 四级标题文本字符间距
  // 五级标题背景颜色列表
  heading5BackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading5BackgroundColor: ResourceColor | undefined = undefined // 五级标题背景颜色
  // 五级标题上外边距列表
  heading5MarginTopList: Array<number> = marginListGeneralData
  @State heading5MarginTop: number = 0 // 五级标题上外边距
  // 五级标题右外边距列表
  heading5MarginRightList: Array<number> = marginListGeneralData
  @State heading5MarginRight: number = 0 // 五级标题右外边距
  // 五级标题下外边距列表
  heading5MarginBottomList: Array<number> = marginListGeneralData
  @State heading5MarginBottom: number = 0 // 五级标题下外边距
  // 五级标题左外边距列表
  heading5MarginLeftList: Array<number> = marginListGeneralData
  @State heading5MarginLeft: number = 0 // 五级标题左外边距
  // 五级标题上内边距列表
  heading5PaddingTopList: Array<number> = marginListGeneralData
  @State heading5PaddingTop: number = 0 // 五级标题上内边距
  // 五级标题右内边距列表
  heading5PaddingRightList: Array<number> = marginListGeneralData
  @State heading5PaddingRight: number = 0 // 五级标题右内边距
  // 五级标题下内边距列表
  heading5PaddingBottomList: Array<number> = marginListGeneralData
  @State heading5PaddingBottom: number = 0 // 五级标题下内边距
  // 五级标题左内边距列表
  heading5PaddingLeftList: Array<number> = marginListGeneralData
  @State heading5PaddingLeft: number = 0 // 五级标题左内边距
  // 五级标题文本颜色列表
  heading5TextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading5TextFontColor: ResourceColor | undefined = undefined // 五级标题文本颜色
  // 五级标题文本尺寸列表
  heading5TextFontSizeList: Array<number> = textSizeListGeneralData
  @State heading5TextFontSize: number = 15 // 五级标题文本尺寸
  // 五级标题文本字体样式列表
  heading5TextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State heading5TextFontStyle: FontStyle = FontStyle.Normal // 五级标题文本字体样式
  // 五级标题文本字体粗细列表
  heading5TextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State heading5TextFontWeight: FontWeight = FontWeight.Bold // 五级标题文本字体粗细
  // 五级标题文本字体列表
  heading5TextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State heading5TextFontFamily: string = 'HarmonyOS Sans' // 五级标题文本字体
  // 五级标题文本行高列表
  heading5TextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State heading5TextLineHeight: number = 22 // 五级标题文本行高
  // 五级标题文本字符间距列表
  heading5TextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State heading5TextLetterSpacing: number = 0.0 // 五级标题文本字符间距
  // 六级标题背景颜色列表
  heading6BackgroundColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading6BackgroundColor: ResourceColor | undefined = undefined // 六级标题背景颜色
  // 六级标题上外边距列表
  heading6MarginTopList: Array<number> = marginListGeneralData
  @State heading6MarginTop: number = 0 // 六级标题上外边距
  // 六级标题右外边距列表
  heading6MarginRightList: Array<number> = marginListGeneralData
  @State heading6MarginRight: number = 0 // 六级标题右外边距
  // 六级标题下外边距列表
  heading6MarginBottomList: Array<number> = marginListGeneralData
  @State heading6MarginBottom: number = 0 // 六级标题下外边距
  // 六级标题左外边距列表
  heading6MarginLeftList: Array<number> = marginListGeneralData
  @State heading6MarginLeft: number = 0 // 六级标题左外边距
  // 六级标题上内边距列表
  heading6PaddingTopList: Array<number> = marginListGeneralData
  @State heading6PaddingTop: number = 0 // 六级标题上内边距
  // 六级标题右内边距列表
  heading6PaddingRightList: Array<number> = marginListGeneralData
  @State heading6PaddingRight: number = 0 // 六级标题右内边距
  // 六级标题下内边距列表
  heading6PaddingBottomList: Array<number> = marginListGeneralData
  @State heading6PaddingBottom: number = 0 // 六级标题下内边距
  // 六级标题左内边距列表
  heading6PaddingLeftList: Array<number> = marginListGeneralData
  @State heading6PaddingLeft: number = 0 // 六级标题左内边距
  // 六级标题文本颜色列表
  heading6TextFontColorList: Array<ResourceColor | undefined> = colorListGeneralData
  @State heading6TextFontColor: ResourceColor | undefined = undefined // 六级标题文本颜色
  // 六级标题文本尺寸列表
  heading6TextFontSizeList: Array<number> = textSizeListGeneralData
  @State heading6TextFontSize: number = 13 // 六级标题文本尺寸
  // 六级标题文本字体样式列表
  heading6TextFontStyleList: Array<FontStyle> = fontStyleListGeneraData
  @State heading6TextFontStyle: FontStyle = FontStyle.Normal // 六级标题文本字体样式
  // 六级标题文本字体粗细列表
  heading6TextFontWeightList: Array<FontWeight> = fontWeightListGeneraData
  @State heading6TextFontWeight: FontWeight = FontWeight.Bold // 六级标题文本字体粗细
  // 六级标题文本字体列表
  heading6TextFontFamilyList: Array<string> = textTypefaceListGeneralData
  @State heading6TextFontFamily: string = 'HarmonyOS Sans' // 六级标题文本字体
  // 六级标题文本行高列表
  heading6TextLineHeightList: Array<number> = textLineHeightListGeneralData
  @State heading6TextLineHeight: number = 22 // 六级标题文本行高
  // 六级标题文本字符间距列表
  heading6TextLetterSpacingList: Array<number> = textWordSpaceListGeneralData
  @State heading6TextLetterSpacing: number = 0.0 // 六级标题文本字符间距
  @State titleData: TitleData = new TitleData() // 配置数据内容
  heightMD: number = 30 * 1 // 乘以行数
  @State isExpanded1: boolean = false // 控制展开/折叠状态
  @State isExpanded2: boolean = false // 控制展开/折叠状态 - 一级标题
  @State isExpanded3: boolean = false // 控制展开/折叠状态 - 二级标题
  @State isExpanded4: boolean = false // 控制展开/折叠状态 - 三级标题
  @State isExpanded5: boolean = false // 控制展开/折叠状态 - 四级标题
  @State isExpanded6: boolean = false // 控制展开/折叠状态 - 五级标题
  @State isExpanded7: boolean = false // 控制展开/折叠状态 - 六级标题

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "标题配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )

      // md文档展示部分
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
                .fontColor('#FFFFFFFF')
                .backgroundColor('#FF2196F3')
                .height(25).width('100%')
                .padding(5)
                .borderRadius(5)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Clip })
                .onClick(() => {
                  // ---------- 通用
                  this.titleData._isFull = this.isFull
                  this.titleData._incrementalAnalysis = this.incrementalAnalysis
                  this.titleData._enableParseThrottle = this.enableParseThrottle
                  this.titleData._parseThrottleMs = this.parseThrottleMs
                  this.titleData._time = this.time
                  this.titleData._textNumber = this.textNumber
                  this.titleData._isMarkdownParserSync = this.isMarkdownParserSync
                  this.titleData._isOnCopy = this.isOnCopy
                  this.titleData._blockMarginTop = this.blockMarginTop
                  this.titleData._blockMarginRight = this.blockMarginRight
                  this.titleData._blockMarginBottom = this.blockMarginBottom
                  this.titleData._blockMarginLeft = this.blockMarginLeft
                  this.titleData._markdownBlockSpacing = this.markdownBlockSpacing
                  this.titleData._isLineBreak = this.isLineBreak
                  this.titleData._backgroundColor = this.globalBackgroundColor
                  this.titleData._openGestureSwipe = this.openGestureSwipe
                  this.titleData._openGestureSwipeTest = this.openGestureSwipeTest
                  this.titleData._pagePath = `${this.rawFilePath}/${item}`
                  // ---------- 专有 - 一级标题
                  this.titleData._heading1BackgroundColor = this.heading1BackgroundColor
                  this.titleData._heading1MarginTop = this.heading1MarginTop
                  this.titleData._heading1MarginRight = this.heading1MarginRight
                  this.titleData._heading1MarginBottom = this.heading1MarginBottom
                  this.titleData._heading1MarginLeft = this.heading1MarginLeft
                  this.titleData._heading1PaddingTop = this.heading1PaddingTop
                  this.titleData._heading1PaddingRight = this.heading1PaddingRight
                  this.titleData._heading1PaddingBottom = this.heading1PaddingBottom
                  this.titleData._heading1PaddingLeft = this.heading1PaddingLeft
                  this.titleData._heading1TextFontColor = this.heading1TextFontColor
                  this.titleData._heading1TextFontSize = this.heading1TextFontSize
                  this.titleData._heading1TextFontStyle = this.heading1TextFontStyle
                  this.titleData._heading1TextFontWeight = this.heading1TextFontWeight
                  this.titleData._heading1TextFontFamily = this.heading1TextFontFamily
                  this.titleData._heading1TextLineHeight = this.heading1TextLineHeight
                  this.titleData._heading1TextLetterSpacing = this.heading1TextLetterSpacing
                  this.titleData._heading1UnderlineHeight = this.heading1UnderlineHeight
                  this.titleData._heading1UnderlineColor = this.heading1UnderlineColor
                  this.titleData._heading1UnderlineSpacing = this.heading1UnderlineSpacing
                  // ---------- 专有 - 二级标题
                  this.titleData._heading2BackgroundColor = this.heading2BackgroundColor
                  this.titleData._heading2MarginTop = this.heading2MarginTop
                  this.titleData._heading2MarginRight = this.heading2MarginRight
                  this.titleData._heading2MarginBottom = this.heading2MarginBottom
                  this.titleData._heading2MarginLeft = this.heading2MarginLeft
                  this.titleData._heading2PaddingTop = this.heading2PaddingTop
                  this.titleData._heading2PaddingRight = this.heading2PaddingRight
                  this.titleData._heading2PaddingBottom = this.heading2PaddingBottom
                  this.titleData._heading2PaddingLeft = this.heading2PaddingLeft
                  this.titleData._heading2TextFontColor = this.heading2TextFontColor
                  this.titleData._heading2TextFontSize = this.heading2TextFontSize
                  this.titleData._heading2TextFontStyle = this.heading2TextFontStyle
                  this.titleData._heading2TextFontWeight = this.heading2TextFontWeight
                  this.titleData._heading2TextFontFamily = this.heading2TextFontFamily
                  this.titleData._heading2TextLineHeight = this.heading2TextLineHeight
                  this.titleData._heading2TextLetterSpacing = this.heading2TextLetterSpacing
                  this.titleData._heading2UnderlineHeight = this.heading2UnderlineHeight
                  this.titleData._heading2UnderlineColor = this.heading2UnderlineColor
                  this.titleData._heading2UnderlineSpacing = this.heading2UnderlineSpacing
                  // ---------- 专有 - 三级标题
                  this.titleData._heading3BackgroundColor = this.heading3BackgroundColor
                  this.titleData._heading3MarginTop = this.heading3MarginTop
                  this.titleData._heading3MarginRight = this.heading3MarginRight
                  this.titleData._heading3MarginBottom = this.heading3MarginBottom
                  this.titleData._heading3MarginLeft = this.heading3MarginLeft
                  this.titleData._heading3PaddingTop = this.heading3PaddingTop
                  this.titleData._heading3PaddingRight = this.heading3PaddingRight
                  this.titleData._heading3PaddingBottom = this.heading3PaddingBottom
                  this.titleData._heading3PaddingLeft = this.heading3PaddingLeft
                  this.titleData._heading3TextFontColor = this.heading3TextFontColor
                  this.titleData._heading3TextFontSize = this.heading3TextFontSize
                  this.titleData._heading3TextFontStyle = this.heading3TextFontStyle
                  this.titleData._heading3TextFontWeight = this.heading3TextFontWeight
                  this.titleData._heading3TextFontFamily = this.heading3TextFontFamily
                  this.titleData._heading3TextLineHeight = this.heading3TextLineHeight
                  this.titleData._heading3TextLetterSpacing = this.heading3TextLetterSpacing
                  // ---------- 专有 - 四级标题
                  this.titleData._heading4BackgroundColor = this.heading4BackgroundColor
                  this.titleData._heading4MarginTop = this.heading4MarginTop
                  this.titleData._heading4MarginRight = this.heading4MarginRight
                  this.titleData._heading4MarginBottom = this.heading4MarginBottom
                  this.titleData._heading4MarginLeft = this.heading4MarginLeft
                  this.titleData._heading4PaddingTop = this.heading4PaddingTop
                  this.titleData._heading4PaddingRight = this.heading4PaddingRight
                  this.titleData._heading4PaddingBottom = this.heading4PaddingBottom
                  this.titleData._heading4PaddingLeft = this.heading4PaddingLeft
                  this.titleData._heading4TextFontColor = this.heading4TextFontColor
                  this.titleData._heading4TextFontSize = this.heading4TextFontSize
                  this.titleData._heading4TextFontStyle = this.heading4TextFontStyle
                  this.titleData._heading4TextFontWeight = this.heading4TextFontWeight
                  this.titleData._heading4TextFontFamily = this.heading4TextFontFamily
                  this.titleData._heading4TextLineHeight = this.heading4TextLineHeight
                  this.titleData._heading4TextLetterSpacing = this.heading4TextLetterSpacing
                  // ---------- 专有 - 五级标题
                  this.titleData._heading5BackgroundColor = this.heading5BackgroundColor
                  this.titleData._heading5MarginTop = this.heading5MarginTop
                  this.titleData._heading5MarginRight = this.heading5MarginRight
                  this.titleData._heading5MarginBottom = this.heading5MarginBottom
                  this.titleData._heading5MarginLeft = this.heading5MarginLeft
                  this.titleData._heading5PaddingTop = this.heading5PaddingTop
                  this.titleData._heading5PaddingRight = this.heading5PaddingRight
                  this.titleData._heading5PaddingBottom = this.heading5PaddingBottom
                  this.titleData._heading5PaddingLeft = this.heading5PaddingLeft
                  this.titleData._heading5TextFontColor = this.heading5TextFontColor
                  this.titleData._heading5TextFontSize = this.heading5TextFontSize
                  this.titleData._heading5TextFontStyle = this.heading5TextFontStyle
                  this.titleData._heading5TextFontWeight = this.heading5TextFontWeight
                  this.titleData._heading5TextFontFamily = this.heading5TextFontFamily
                  this.titleData._heading5TextLineHeight = this.heading5TextLineHeight
                  this.titleData._heading5TextLetterSpacing = this.heading5TextLetterSpacing
                  // ---------- 专有 - 六级标题
                  this.titleData._heading6BackgroundColor = this.heading6BackgroundColor
                  this.titleData._heading6MarginTop = this.heading6MarginTop
                  this.titleData._heading6MarginRight = this.heading6MarginRight
                  this.titleData._heading6MarginBottom = this.heading6MarginBottom
                  this.titleData._heading6MarginLeft = this.heading6MarginLeft
                  this.titleData._heading6PaddingTop = this.heading6PaddingTop
                  this.titleData._heading6PaddingRight = this.heading6PaddingRight
                  this.titleData._heading6PaddingBottom = this.heading6PaddingBottom
                  this.titleData._heading6PaddingLeft = this.heading6PaddingLeft
                  this.titleData._heading6TextFontColor = this.heading6TextFontColor
                  this.titleData._heading6TextFontSize = this.heading6TextFontSize
                  this.titleData._heading6TextFontStyle = this.heading6TextFontStyle
                  this.titleData._heading6TextFontWeight = this.heading6TextFontWeight
                  this.titleData._heading6TextFontFamily = this.heading6TextFontFamily
                  this.titleData._heading6TextLineHeight = this.heading6TextLineHeight
                  this.titleData._heading6TextLetterSpacing = this.heading6TextLetterSpacing
                  // ---------- 跳转到详情
                  router.pushUrl({ url: "pages/TitleDetailsPage", params: this.titleData })
                })
            }
          })
        }.width('100%').height('100%')
      }.padding({ top: 5, bottom: 5 }).width('100%').height(this.heightMD)

      Scroll() {
        Column() {
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
                  titleStr: "是否启用解析节流 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.enableParseThrottleList,
                  allData: this.enableParseThrottle
                })
                BaseTabComponent({
                  titleStr: "解析节流间隔（ms） - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.parseThrottleMsList,
                  allData: this.parseThrottleMs
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
                  titleStr: "软换行是否换行 - ",
                  typeEnum: TypeEnum.IS_BOOLEAN,
                  allListData: this.isLineBreakList,
                  allData: this.isLineBreak
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

          // 一级标题
          Column() {
            Row() {
              Text("一级标题")
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
                  titleStr: "一级标题上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1MarginTopList,
                  allData: this.heading1MarginTop
                })
                BaseTabComponent({
                  titleStr: "一级标题右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1MarginRightList,
                  allData: this.heading1MarginRight
                })
                BaseTabComponent({
                  titleStr: "一级标题下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1MarginBottomList,
                  allData: this.heading1MarginBottom
                })
                BaseTabComponent({
                  titleStr: "一级标题左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1MarginLeftList,
                  allData: this.heading1MarginLeft
                })
                BaseTabComponent({
                  titleStr: "一级标题上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1PaddingTopList,
                  allData: this.heading1PaddingTop
                })
                BaseTabComponent({
                  titleStr: "一级标题右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1PaddingRightList,
                  allData: this.heading1PaddingRight
                })
                BaseTabComponent({
                  titleStr: "一级标题下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1PaddingBottomList,
                  allData: this.heading1PaddingBottom
                })
                BaseTabComponent({
                  titleStr: "一级标题左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1PaddingLeftList,
                  allData: this.heading1PaddingLeft
                })
                BaseTabComponent({
                  titleStr: "一级标题文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.heading1TextFontColorList,
                  allData: this.heading1TextFontColor
                })
                BaseTabComponent({
                  titleStr: "一级标题文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1TextFontSizeList,
                  allData: this.heading1TextFontSize
                })
                BaseTabComponent({
                  titleStr: "一级标题文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.heading1TextFontStyleList,
                  allData: this.heading1TextFontStyle
                })
                BaseTabComponent({
                  titleStr: "一级标题文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.heading1TextFontWeightList,
                  allData: this.heading1TextFontWeight
                })
                BaseTabComponent({
                  titleStr: "一级标题文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.heading1TextFontFamilyList,
                  allData: this.heading1TextFontFamily
                })
                BaseTabComponent({
                  titleStr: "一级标题文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1TextLineHeightList,
                  allData: this.heading1TextLineHeight
                })
                BaseTabComponent({
                  titleStr: "一级标题文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1TextLetterSpacingList,
                  allData: this.heading1TextLetterSpacing
                })
                BaseTabComponent({
                  titleStr: "一级标题下划线高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1UnderlineHeightList,
                  allData: this.heading1UnderlineHeight
                })
                BaseTabComponent({
                  titleStr: "一级标题下划线颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.heading1UnderlineColorList,
                  allData: this.heading1UnderlineColor
                })
                BaseTabComponent({
                  titleStr: "一级标题距离标题文本间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading1UnderlineSpacingList,
                  allData: this.heading1UnderlineSpacing
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

          // 二级标题
          Column() {
            Row() {
              Text("二级标题")
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
                  titleStr: "二级标题上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2MarginTopList,
                  allData: this.heading2MarginTop
                })
                BaseTabComponent({
                  titleStr: "二级标题右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2MarginRightList,
                  allData: this.heading2MarginRight
                })
                BaseTabComponent({
                  titleStr: "二级标题下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2MarginBottomList,
                  allData: this.heading2MarginBottom
                })
                BaseTabComponent({
                  titleStr: "二级标题左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2MarginLeftList,
                  allData: this.heading2MarginLeft
                })
                BaseTabComponent({
                  titleStr: "二级标题上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2PaddingTopList,
                  allData: this.heading2PaddingTop
                })
                BaseTabComponent({
                  titleStr: "二级标题右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2PaddingRightList,
                  allData: this.heading2PaddingRight
                })
                BaseTabComponent({
                  titleStr: "二级标题下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2PaddingBottomList,
                  allData: this.heading2PaddingBottom
                })
                BaseTabComponent({
                  titleStr: "二级标题左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2PaddingLeftList,
                  allData: this.heading2PaddingLeft
                })
                BaseTabComponent({
                  titleStr: "二级标题文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.heading2TextFontColorList,
                  allData: this.heading2TextFontColor
                })
                BaseTabComponent({
                  titleStr: "二级标题文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2TextFontSizeList,
                  allData: this.heading2TextFontSize
                })
                BaseTabComponent({
                  titleStr: "二级标题文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.heading2TextFontStyleList,
                  allData: this.heading2TextFontStyle
                })
                BaseTabComponent({
                  titleStr: "二级标题文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.heading2TextFontWeightList,
                  allData: this.heading2TextFontWeight
                })
                BaseTabComponent({
                  titleStr: "二级标题文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.heading2TextFontFamilyList,
                  allData: this.heading2TextFontFamily
                })
                BaseTabComponent({
                  titleStr: "二级标题文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2TextLineHeightList,
                  allData: this.heading2TextLineHeight
                })
                BaseTabComponent({
                  titleStr: "二级标题文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2TextLetterSpacingList,
                  allData: this.heading2TextLetterSpacing
                })
                BaseTabComponent({
                  titleStr: "二级标题下划线高度 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2UnderlineHeightList,
                  allData: this.heading2UnderlineHeight
                })
                BaseTabComponent({
                  titleStr: "二级标题下划线颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.heading2UnderlineColorList,
                  allData: this.heading2UnderlineColor
                })
                BaseTabComponent({
                  titleStr: "二级标题距离标题文本间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading2UnderlineSpacingList,
                  allData: this.heading2UnderlineSpacing
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

          // 三级标题
          Column() {
            Row() {
              Text("三级标题")
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
                  titleStr: "三级标题上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading3MarginTopList,
                  allData: this.heading3MarginTop
                })
                BaseTabComponent({
                  titleStr: "三级标题右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading3MarginRightList,
                  allData: this.heading3MarginRight
                })
                BaseTabComponent({
                  titleStr: "三级标题下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading3MarginBottomList,
                  allData: this.heading3MarginBottom
                })
                BaseTabComponent({
                  titleStr: "三级标题左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading3MarginLeftList,
                  allData: this.heading3MarginLeft
                })
                BaseTabComponent({
                  titleStr: "三级标题上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading3PaddingTopList,
                  allData: this.heading3PaddingTop
                })
                BaseTabComponent({
                  titleStr: "三级标题右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading3PaddingRightList,
                  allData: this.heading3PaddingRight
                })
                BaseTabComponent({
                  titleStr: "三级标题下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading3PaddingBottomList,
                  allData: this.heading3PaddingBottom
                })
                BaseTabComponent({
                  titleStr: "三级标题左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading3PaddingLeftList,
                  allData: this.heading3PaddingLeft
                })
                BaseTabComponent({
                  titleStr: "三级标题文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.heading3TextFontColorList,
                  allData: this.heading3TextFontColor
                })
                BaseTabComponent({
                  titleStr: "三级标题文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading3TextFontSizeList,
                  allData: this.heading3TextFontSize
                })
                BaseTabComponent({
                  titleStr: "三级标题文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.heading3TextFontStyleList,
                  allData: this.heading3TextFontStyle
                })
                BaseTabComponent({
                  titleStr: "三级标题文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.heading3TextFontWeightList,
                  allData: this.heading3TextFontWeight
                })
                BaseTabComponent({
                  titleStr: "三级标题文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.heading3TextFontFamilyList,
                  allData: this.heading3TextFontFamily
                })
                BaseTabComponent({
                  titleStr: "三级标题文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading3TextLineHeightList,
                  allData: this.heading3TextLineHeight
                })
                BaseTabComponent({
                  titleStr: "三级标题文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading3TextLetterSpacingList,
                  allData: this.heading3TextLetterSpacing
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

          // 四级标题
          Column() {
            Row() {
              Text("四级标题")
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
                  titleStr: "四级标题上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading4MarginTopList,
                  allData: this.heading4MarginTop
                })
                BaseTabComponent({
                  titleStr: "四级标题右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading4MarginRightList,
                  allData: this.heading4MarginRight
                })
                BaseTabComponent({
                  titleStr: "四级标题下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading4MarginBottomList,
                  allData: this.heading4MarginBottom
                })
                BaseTabComponent({
                  titleStr: "四级标题左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading4MarginLeftList,
                  allData: this.heading4MarginLeft
                })
                BaseTabComponent({
                  titleStr: "四级标题上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading4PaddingTopList,
                  allData: this.heading4PaddingTop
                })
                BaseTabComponent({
                  titleStr: "四级标题右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading4PaddingRightList,
                  allData: this.heading4PaddingRight
                })
                BaseTabComponent({
                  titleStr: "四级标题下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading4PaddingBottomList,
                  allData: this.heading4PaddingBottom
                })
                BaseTabComponent({
                  titleStr: "四级标题左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading4PaddingLeftList,
                  allData: this.heading4PaddingLeft
                })
                BaseTabComponent({
                  titleStr: "四级标题文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.heading4TextFontColorList,
                  allData: this.heading4TextFontColor
                })
                BaseTabComponent({
                  titleStr: "四级标题文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading4TextFontSizeList,
                  allData: this.heading4TextFontSize
                })
                BaseTabComponent({
                  titleStr: "四级标题文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.heading4TextFontStyleList,
                  allData: this.heading4TextFontStyle
                })
                BaseTabComponent({
                  titleStr: "四级标题文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.heading4TextFontWeightList,
                  allData: this.heading4TextFontWeight
                })
                BaseTabComponent({
                  titleStr: "四级标题文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.heading4TextFontFamilyList,
                  allData: this.heading4TextFontFamily
                })
                BaseTabComponent({
                  titleStr: "四级标题文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading4TextLineHeightList,
                  allData: this.heading4TextLineHeight
                })
                BaseTabComponent({
                  titleStr: "四级标题文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading4TextLetterSpacingList,
                  allData: this.heading4TextLetterSpacing
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

          // 五级标题
          Column() {
            Row() {
              Text("五级标题")
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
                  titleStr: "五级标题上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading5MarginTopList,
                  allData: this.heading5MarginTop
                })
                BaseTabComponent({
                  titleStr: "五级标题右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading5MarginRightList,
                  allData: this.heading5MarginRight
                })
                BaseTabComponent({
                  titleStr: "五级标题下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading5MarginBottomList,
                  allData: this.heading5MarginBottom
                })
                BaseTabComponent({
                  titleStr: "五级标题左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading5MarginLeftList,
                  allData: this.heading5MarginLeft
                })
                BaseTabComponent({
                  titleStr: "五级标题上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading5PaddingTopList,
                  allData: this.heading5PaddingTop
                })
                BaseTabComponent({
                  titleStr: "五级标题右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading5PaddingRightList,
                  allData: this.heading5PaddingRight
                })
                BaseTabComponent({
                  titleStr: "五级标题下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading5PaddingBottomList,
                  allData: this.heading5PaddingBottom
                })
                BaseTabComponent({
                  titleStr: "五级标题左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading5PaddingLeftList,
                  allData: this.heading5PaddingLeft
                })
                BaseTabComponent({
                  titleStr: "五级标题文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.heading5TextFontColorList,
                  allData: this.heading5TextFontColor
                })
                BaseTabComponent({
                  titleStr: "五级标题文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading5TextFontSizeList,
                  allData: this.heading5TextFontSize
                })
                BaseTabComponent({
                  titleStr: "五级标题文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.heading5TextFontStyleList,
                  allData: this.heading5TextFontStyle
                })
                BaseTabComponent({
                  titleStr: "五级标题文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.heading5TextFontWeightList,
                  allData: this.heading5TextFontWeight
                })
                BaseTabComponent({
                  titleStr: "五级标题文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.heading5TextFontFamilyList,
                  allData: this.heading5TextFontFamily
                })
                BaseTabComponent({
                  titleStr: "五级标题文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading5TextLineHeightList,
                  allData: this.heading5TextLineHeight
                })
                BaseTabComponent({
                  titleStr: "五级标题文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading5TextLetterSpacingList,
                  allData: this.heading5TextLetterSpacing
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

          // 六级标题
          Column() {
            Row() {
              Text("六级标题")
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
                  titleStr: "六级标题上外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading6MarginTopList,
                  allData: this.heading6MarginTop
                })
                BaseTabComponent({
                  titleStr: "六级标题右外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading6MarginRightList,
                  allData: this.heading6MarginRight
                })
                BaseTabComponent({
                  titleStr: "六级标题下外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading6MarginBottomList,
                  allData: this.heading6MarginBottom
                })
                BaseTabComponent({
                  titleStr: "六级标题左外边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading6MarginLeftList,
                  allData: this.heading6MarginLeft
                })
                BaseTabComponent({
                  titleStr: "六级标题上内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading6PaddingTopList,
                  allData: this.heading6PaddingTop
                })
                BaseTabComponent({
                  titleStr: "六级标题右内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading6PaddingRightList,
                  allData: this.heading6PaddingRight
                })
                BaseTabComponent({
                  titleStr: "六级标题下内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading6PaddingBottomList,
                  allData: this.heading6PaddingBottom
                })
                BaseTabComponent({
                  titleStr: "六级标题左内边距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading6PaddingLeftList,
                  allData: this.heading6PaddingLeft
                })
                BaseTabComponent({
                  titleStr: "六级标题文本颜色 - ",
                  typeEnum: TypeEnum.IS_COLOR,
                  allListData: this.heading6TextFontColorList,
                  allData: this.heading6TextFontColor
                })
                BaseTabComponent({
                  titleStr: "六级标题文本尺寸 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading6TextFontSizeList,
                  allData: this.heading6TextFontSize
                })
                BaseTabComponent({
                  titleStr: "六级标题文本字体样式 - ",
                  typeEnum: TypeEnum.IS_FONT_STYLE,
                  allListData: this.heading6TextFontStyleList,
                  allData: this.heading6TextFontStyle
                })
                BaseTabComponent({
                  titleStr: "六级标题文本字体粗细 - ",
                  typeEnum: TypeEnum.IS_FONT_WEIGHT,
                  allListData: this.heading6TextFontWeightList,
                  allData: this.heading6TextFontWeight
                })
                BaseTabComponent({
                  titleStr: "六级标题文本字体 - ",
                  typeEnum: TypeEnum.IS_STRING,
                  allListData: this.heading6TextFontFamilyList,
                  allData: this.heading6TextFontFamily
                })
                BaseTabComponent({
                  titleStr: "六级标题文本行高 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading6TextLineHeightList,
                  allData: this.heading6TextLineHeight
                })
                BaseTabComponent({
                  titleStr: "六级标题文本字符间距 - ",
                  typeEnum: TypeEnum.IS_NUMBER,
                  allListData: this.heading6TextLetterSpacingList,
                  allData: this.heading6TextLetterSpacing
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