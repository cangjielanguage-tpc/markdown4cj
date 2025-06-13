# Markdown API

## UI使用接口

### class MarkdownComponent

Markdown预览自定义控件

```cangjie
/**
 * Markdown预览自定义控件
 */
@Component
public class MarkdownComponent {
    /**
    * 初始化Markdown自定义控件
    *
    * @param output 传入markdown文档内容
    * @param isFull 是否全量加载模式 - true：全量加载，false：增量加载。默认全量加载
    * @param markdownConfiguration 传入markdown配置选项
    */
    MarkdownComponent(output: String, isFull!: Bool, markdownConfiguration!: MarkdownConfiguration)
}
```

## Markdown配置接口

### class MarkdownConfiguration

Markdown配置

```cangjie
/**
 * markdown配置
 */
public class MarkdownConfiguration {
    /**
     * 创建Config对象
     *
     * @return MarkdownConfiguration 创建空的MarkdownConfiguration对象
     */
    public static func create(): MarkdownConfiguration

    /**
     * 创建一个空的builder对象
     *
     * @return MarkdownConfigurationBuilder 创建空的MarkdownConfigurationBuilder对象
     */
    public static func emptyBuilder(): MarkdownConfigurationBuilder

    /**
     * 通过已有的Config创建builder对象
     *
     * @param copyFrom MarkdownConfiguration对象
     * @return MarkdownConfigurationBuilder 创建MarkdownConfigurationBuilder对象
     */
    public static func builder(copyFrom: MarkdownConfiguration): MarkdownConfigurationBuilder
}
```

### class MarkdownConfigurationBuilder

MarkdownConfiguration Builder

```cangjie
/**
 * MarkdownConfiguration Builder
 */
public class MarkdownConfigurationBuilder {
    /**
     * 设置markdown默认样式
     *
     * @param markdownTheme Markdown基础样式
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setMarkdownTheme(markdownTheme: MarkdownTheme): MarkdownConfigurationBuilder

    /**
     * 设置markdown核心解析器
     *
     * @param markdownPlugin markdown核心解析器
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setMarkdownParser(markdownParser: Markdown): MarkdownConfigurationBuilder

    /**
     * 设置链接的点击事件
     *
     * @param linkCallback 链接点击回调接口 (String:链接)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setLinkCallback(linkCallback: (String) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置图片的点击事件
     *
     * @param imageCallback 图片点击回调接口 (String:图片链接)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setImageCallback(imageCallback: (String) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置视频的点击事件
     *
     * @param videoCallback 视频点击回调接口 (String:视频ID)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setVideoCallback(videoCallback: (String) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置视频的图片替换回调
     *
     * @param videoImageCallback 视频的图片替换回调接口
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setVideoImageCallback(videoImageCallback: (String, (String) -> Unit) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置代码复制按钮的点击事件
     *
     * @param codeCopyCallback 代码复制点击回调接口 (String:代码内容型)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setCodeCopyCallback(codeCopyCallback: (String) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置代码全屏按钮的点击事件
     *
     * @param codeFullScreenCallback 代码全屏点击回调接口 (String:代码内容,Option<String>:代码类型)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setCodeFullScreenCallback(codeFullScreenCallback: (String, Option<String>) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置数学公式图片点击事件
     *
     * @param latexImageCallback 数学公式图片点击回调接口 (Array<UInt8>:图片数据,Length:高度,Length:宽度)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setLatexImageCallbackCallback(latexImageCallback: (Array<UInt8>, Length, Length) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置数学公式数据处理事件
     *
     * @param latexStrCallback 数学公式数据处理回调接口 (参数String:数学公式的内容,返回值String:数学公式处理之后的内容)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setLatexStrCallback(latexStrCallback: (String) -> String): MarkdownConfigurationBuilder

    /**
     * 设置TOC跳转指定位置
     *
     * @param tocIndexCallback TOC跳转指定位置接口 (?Float64:位置距离)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTocIndexCallback(tocIndexCallback: (?Float64) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置脚注跳转指定位置
     *
     * @param footnoteCallback 脚注跳转指定位置接口 (?Float64:位置距离)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setFootnoteCallback(footnoteCallback: (?Float64) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置超大数据跳转页面显示全部数据
     *
     * @param listBigDataCallback 超大数据跳转页面显示全部数据接口 (NodeView:NodeView数据,Float64:上外边距,Float64:下外边距,Float64:控件宽度)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setListBigDataCallback(listBigDataCallback: ?(NodeView, Float64, Float64, Float64) -> Unit): MarkdownConfigurationBuilder

    /**
     * 返回Config对象
     *
     * @return MarkdownConfiguration MarkdownConfiguration对象
     */
    public func build(): MarkdownConfiguration
}
```

## Markdown基础样式配置类

### class MarkdownTheme

Markdown用户可设置的样式

```cangjie
/**
 * Markdown用户可设置的样式
 * 1：上下文 - 本地图片rawfile需要上下文混合项目是stageContext，仓颉项目是abilityContext
 * 2：每个模块之间上下间距
 * 3：链接 - 链接包含（纯文本显示、图片显示）
 *          链接文本颜色、链接字体大小、链接背景颜色、是否显示链接下划线、
 *          链接是否是图片显示、
 *          圆形链接主题背景颜色、圆形链接控件背景颜色、圆形链接文字大小、圆形链接文字颜色、圆形链接半径、圆形链接左右外边距、
 *          圆角矩形链接主题背景颜色、圆角矩形链接控件背景颜色、圆角矩形链接文字大小、圆角矩形链接文字颜色、圆角矩形链接控件高度、圆角矩形链接左右内边距、圆角矩形链接圆角半径、圆角矩形链接左右外边距、
 *          空心圆角矩形链接主题背景颜色、空心圆角矩形链接控件背景颜色、空心圆角矩形链接控件边框颜色、空心圆角矩形链接控件分割线颜色、空心圆角矩形链接文字大小、空心圆角矩形链接文字颜色、空心圆角矩形链接控件高度、空心圆角矩形链接左右内边距、空心圆角矩形链接边框宽度、空心圆角矩形链接分割线宽度、空心圆角矩形链接左右外边距、空心圆角矩形链接分割线和文本左边距、空心圆角矩形链接分割线和文本右边距
 * 4：列表 - 列表包含（块引用、有序列表、无序列表、任务列表、TOC列表）
 *          列表左边距、列表展示的数量
 *          块引用左边线条宽度、块引用左边线条颜色、块引用背景颜色、块引用每个模块之间上下间距、
 *          有序列表列表项的颜色、有序列表项的文本大小、有序列表项文本行高、有序列表无序列表任务列表每个模块之间上下间距
 *          无序列表项的颜色、无序列表项的文本大小、无列表项文本行高、
 *          任务列表项的宽高、任务列表项的上下间距
 * 5：代码 - 代码包含（内联代码、缩进代码、围栏代码、组合代码）（代码块有缩进代码、围栏代码、组合代码）
 *          内联代码文本颜色、内联代码背景颜色、内联代码文本字体、内联代码文本大小、
 *          代码块系列文本颜色、代码块系列背景颜色、代码块系列左边距、代码块系列字体、代码块系列文本大小、代码块系列行高、代码块圆角
 *          是否显示代码全屏按钮、代码全屏按钮和代码复制按钮的宽高、代码全屏按钮默认图标、代码复制按钮默认图标
 *          组合代码未选中标题字体大小、组合代码选中标题字体大小、组合代码标题选中文本颜色、组合代码标题未选中文本颜色、组合代码标题选中背景颜色、组合代码标题未选中背景颜色
 * 6：标题 - （1-6级标题）
 *          H1和H2标题下分割线高度、H1和H2标题下分割线颜色、标题元素字体、标题文本大小数组、标题文本颜色、标题文本字间距、
 *          一级标题文本行高、二级标题文本行高、三级标题文本行高、四级标题文本行高、五级标题文本行高、六级标题文本行高
 * 7：段落 - 段落文本大小、段落文本颜色、段落文本字间距、段落文本行高
 * 8：分割线 - 分割线颜色、分割线高度
 * 9：软换行 - 软换行是否换行
 * 10：数学公式 - 数学公式文字大小、数学公式行距、数学公式背景色、数学公式字体颜色、数学公式生成图片格式、数学公式资源目录路径
 * 11：视频 - 视频默认占位图、视频播放按钮默认图标
 * 12：图片Banner - 图片banner默认占位图
 * 13：图片 - 图片宽度边距、图片默认占位图、网络图片是否压缩
 * 14：按钮 - 按钮文字内容、按钮文字字体大小、按钮文字颜色、按钮背景颜色、按钮高度、按钮上下边距
 * 15：表格 - 表格内容内边距、表格边框颜色、表格边框宽度、表格奇数行背景色、表格偶数行背景色、表格头背景色、表格文本行高、表格圆角、表格一格最小宽度、表格一格最大宽度
 * 16：代码高亮 - markdown代码高亮样式
 */
public class MarkdownTheme {
    /**
     * 创建Theme对象
     *
     * @return MarkdownTheme 创建空的MarkdownTheme对象
     */
    public static func create(): MarkdownTheme

    /**
     * 创建一个空的builder对象
     *
     * @return MarkdownThemeBuilder 创建空的MarkdownThemeBuilder对象
     */
    public static func emptyBuilder(): MarkdownThemeBuilder

    /**
     * 创建默认的Theme对象
     *
     * @return MarkdownTheme 创建默认的MarkdownTheme对象
     */
    public static func createDefaultBuilder(): MarkdownThemeBuilder

    /**
     * 创建暗色的Theme对象
     *
     * @return MarkdownTheme 创建暗色的MarkdownTheme对象
     */
    public static func createDarkulaBuilder(): MarkdownThemeBuilder

    /**
     * 通过已有的Theme创建builder对象
     *
     * @param copyFrom MarkdownTheme对象
     * @return MarkdownThemeBuilder 创建MarkdownThemeBuilder对象
     */
    public static func builder(copyFrom: MarkdownTheme): MarkdownThemeBuilder
}
```

### class MarkdownThemeBuilder

MarkdownTheme Builder

```cangjie
/**
 * MarkdownTheme Builder
 */
public class MarkdownThemeBuilder {
    /**
     * 设置浅色主题整体样式
     *
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setDefaultTheme(): MarkdownThemeBuilder

    /**
     * 设置深色主题整体样式
     *
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setDarkulaTheme(): MarkdownThemeBuilder

    /**
     * 设置上下文
     *
     * @param stageContext 上下文
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setStageContext(stageContext: StageContext): MarkdownThemeBuilder

    /**
     * 设置上下文
     *
     * @param abilityContext 上下文
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAbilityContext(abilityContext: AbilityContext): MarkdownThemeBuilder

    /**
     * 设置每个模块之间上下间距
     *
     * @param blockTopAndBottomMargins 模块上下间距距离默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockTopAndBottomMargins(blockTopAndBottomMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置链接颜色
     *
     * @param linkColor 链接的颜色默认0x0000FF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkColor(linkColor: Color): MarkdownThemeBuilder

    /**
     * 设置链接文字大小
     *
     * @param LinkSize 链接文字大小，单位默认vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkSize(linkSize: Float64): MarkdownThemeBuilder

    /**
     * 设置链接背景颜色
     *
     * @param linkBackGroupColor 链接的背景颜色默认0x000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkBackGroupColor(linkBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置是否显示链接下划线
     *
     * @param isLinkUnderlined 是否显示链接的下划线true：显示链接下划线，false：不显示链接下划线默认显示链接下划线
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsLinkUnderlined(isLinkUnderlined: Bool): MarkdownThemeBuilder

    /**
     * 设置链接是否是图片显示
     *
     * @param isLinkStyle 链接是否是图片显示true：图片显示，false：文本显示
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsLinkStyle(isLinkStyle: Bool): MarkdownThemeBuilder

    /**
     * 设置圆形链接主题背景颜色
     *
     * @param linkCircleImageBackGroupColor 圆形链接主题背景颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageBackGroupColor(linkCircleImageBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置圆形链接控件背景颜色
     *
     * @param linkCircleImageButtonBackGroupColor 圆形链接控件背景颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageButtonBackGroupColor(linkCircleImageButtonBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置圆形链接文字大小 - 单位fp
     *
     * @param linkCircleImageTextSize 圆形链接文字大小 - 单位fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageTextSize(linkCircleImageTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置圆形链接文字颜色
     *
     * @param linkCircleImageTextColor 圆形链接文字颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageTextColor(linkCircleImageTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置圆形链接半径 - 单位vp
     *
     * @param linkCircleImageRadius 圆形链接半径 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageRadius(linkCircleImageRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置圆形链接左右边距 - 单位vp
     *
     * @param linkCircleImageMargin 圆形链接半径 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageMargin(linkCircleImageMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置圆角矩形链接主题背景颜色
     *
     * @param linkRectImageBackGroupColor 圆角矩形链接主题背景颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageBackGroupColor(linkRectImageBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置圆角矩形链接控件背景颜色
     *
     * @param linkRectImageButtonBackGroupColor 圆角矩形链接控件背景颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageButtonBackGroupColor(linkRectImageButtonBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置圆角矩形链接文字大小 - 单位fp
     *
     * @param linkRectImageTextSize 圆角矩形链接文字大小 - 单位fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageTextSize(linkRectImageTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置圆角矩形链接文字颜色
     *
     * @param linkRectImageTextColor 圆角矩形链接文字颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageTextColor(linkRectImageTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置圆角矩形链接控件高度 - 单位vp
     *
     * @param linkRectImageHeight 圆角矩形链接控件高度 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageHeight(linkRectImageHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置圆角矩形链接左右边距 - 单位vp
     *
     * @param linkRectImagePadding 圆角矩形链接左右边距 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImagePadding(linkRectImagePadding: Float64): MarkdownThemeBuilder

    /**
     * 设置圆角矩形链接圆角半径 - 单位vp
     *
     * @param linkRectImageRadius 圆角矩形链接圆角半径 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageRadius(linkRectImageRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置圆角矩形链接左右边距 - 单位vp
     *
     * @param linkRectImageMargin 圆形链接半径 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageMargin(linkRectImageMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形链接主题背景颜色
     *
     * @param linkRectToolImageBackGroupColor 空心圆角矩形链接主题背景颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageBackGroupColor(linkRectToolImageBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形链接控件背景颜色
     *
     * @param linkRectToolImageButtonBackGroupColor 空心圆角矩形链接控件背景颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageButtonBackGroupColor(linkRectToolImageButtonBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形链接控件边框颜色
     *
     * @param linkRectToolImageButtonBorderColor 空心圆角矩形链接控件边框颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageButtonBorderColor(linkRectToolImageButtonBorderColor: Color): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形链接控件分割线颜色
     *
     * @param linkRectToolImageButtonDividingLineColor 空心圆角矩形链接控件分割线颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageButtonDividingLineColor(linkRectToolImageButtonDividingLineColor: Color): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形链接文字大小 - 单位fp
     *
     * @param linkRectToolImageTextSize 空心圆角矩形链接文字大小 - 单位fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageTextSize(linkRectToolImageTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形链接文字颜色
     *
     * @param linkRectToolImageTextColor 空心圆角矩形链接文字颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageTextColor(linkRectToolImageTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形链接控件高度 - 单位vp
     *
     * @param linkRectToolImageHeight 空心圆角矩形链接控件高度 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageHeight(linkRectToolImageHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形链接左右边距 - 单位vp
     *
     * @param linkRectToolImagePadding 空心圆角矩形链接左右边距 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImagePadding(linkRectToolImagePadding: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形链接边框宽度 - 单位vp
     *
     * @param linkRectToolImageBorderWidth 空心圆角矩形链接边框宽度 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setlinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形链接分割线宽度 - 单位vp
     *
     * @param linkRectToolImageDividingLineWidth 空心圆角矩形链接分割线宽度 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形链接左右边距 - 单位vp
     *
     * @param linkRectToolImageMargin 圆形链接半径 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageMargin(linkRectToolImageMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形分割线和文本左边距 - 单位vp
     *
     * @param linkRectToolImageLineLeftPadding 空心圆角矩形分割线和文本左边距 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形分割线和文本右边距 - 单位vp
     *
     * @param linkRectToolImageLineRightPadding 空心圆角矩形分割线和文本右边距 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: Float64): MarkdownThemeBuilder

    /**
     * 设置有序列表、无序列表、任务列表、块引用左边距
     *
     * @param blockMargin 左边距默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockMargin(blockMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置块引用左边线条宽度
     *
     * @param blockQuoteWidth 块引用左线条宽度.默认1.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteWidth(blockQuoteWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置块引用左边线条颜色
     *
     * @param blockQuoteColor 块引用左线条颜色默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteColor(blockQuoteColor: Color): MarkdownThemeBuilder

    /**
     * 设置块引用背景颜色
     *
     * @param blockQuoteBackGroupClor 块引用左线条颜色默认0xFFFFFF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteBackGroupColor(blockQuoteBackGroupClor: Color): MarkdownThemeBuilder

    /**
     * 设置块引用模块间距
     *
     * @param blockQuoteTopAndBottomMargins 模块间距
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置有序列表项的颜色
     *
     * @param orderedListItemColor 有序列表项的颜色默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListItemColor(orderedListItemColor: Color): MarkdownThemeBuilder

    /**
     * 设置有序列表项的字体大小
     *
     * @param orderedListItemSize 有序列表项的字体大小默认14.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListItemSize(orderedListItemSize: Float64): MarkdownThemeBuilder

    /**
     * 设置有序列表项文本行高
     *
     * @param orderedListItemLineheight 有序列表项文本行高默认22.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListItemLineheight(orderedListItemLineheight: Float64): MarkdownThemeBuilder
    
    /**
     * 设置有序列表无序列表任务列表模块间距
     *
     * @param blockOrderedAndBulletTopAndBottomMargins 模块间距
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置无序列表项的颜色
     *
     * @param bulletListItemColor 无序列表项的颜色默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListItemColor(bulletListItemColor: Color): MarkdownThemeBuilder

    /**
     * 设置无序列表项的字体大小
     *
     * @param bulletListItemSize 无序列表项的字体大小默认14.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListItemSize(bulletListItemSize: Float64): MarkdownThemeBuilder

    /**
     * 设置无列表项文本行高
     *
     * @param bulletListItemLineheight 无列表项文本行高默认18.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListItemLineheight(bulletListItemLineheight: Float64): MarkdownThemeBuilder

    /**
     * 设置任务列表项的宽高
     *
     * @param taskListItemLength 任务列表项的宽高默认15.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTaskListItemLength(taskListItemLength: Float64): MarkdownThemeBuilder

    /**
     * 设置任务列表前缀间距
     *
     * @param taskListTopAndBottomMargins 任务列表前缀间距
     * @return MarkdownAIThemeBuilder MarkdownAIThemeBuilder对象
     */
    public func setTaskListTopAndBottomMargins(taskListTopAndBottomMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置列表展示的数量
     *
     * @param listNumber 列表展示的数量默认1000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setListNumber(listNumber: Int64): MarkdownThemeBuilder

    /**
     * 设置内联代码文本颜色
     *
     * @param codeTextColor 内联代码文本颜色默认0x000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTextColor(codeTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置内联代码背景颜色
     *
     * @param codeBackgroundColor 内联代码背景颜色默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBackgroundColor(codeBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置内联代码文本字体
     *
     * @param codeTypeface 内联代码文本字体默认HarmonyOS Sans
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTypeface(codeTypeface: String): MarkdownThemeBuilder

    /**
     * 设置内联代码文本大小
     *
     * @param codeTextSize 内联代码文本大小默认13.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTextSize(codeTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）文本颜色
     *
     * @param codeBlockTextColor 代码块系列文本颜色默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTextColor(codeBlockTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）背景颜色
     *
     * @param codeBlockBackgroundColor 代码块系列背景颜色默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockBackgroundColor(codeBlockBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）左边距
     *
     * @param codeMultilineMargin 代码块系列左边距默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeMultilineMargin(codeMultilineMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）字体
     *
     * @param codeBlockTypeface 代码块系列字体默认HarmonyOS Sans
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTypeface(codeBlockTypeface: String): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）文本大小
     *
     * @param codeBlockTextSize 代码块系列文本大小默认13.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTextSize(codeBlockTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）行高
     *
     * @param codeBlockLineheight 代码块系列（缩进代码、围栏代码、组合代码）行高默认22.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockLineheight(codeBlockLineheight: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）圆角
     *
     * @param codeBlockRadius 代码块系列（缩进代码、围栏代码、组合代码）圆角
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockRadius(codeBlockRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置是否显示代码全屏按钮
     *
     * @param isCodeFullScreen 是否显示代码全屏按钮true：显示代码全屏按钮，false：不显示代码全屏按钮默认显示代码全屏按钮
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsCodeFullScreen(isCodeFullScreen: Bool): MarkdownThemeBuilder

    /**
     * 设置代码全屏按钮和代码复制按钮宽高
     *
     * @param iconWidthAndHeight 代码全屏按钮和代码复制按钮宽高
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIconWidthAndHeight(iconWidthAndHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置代码全屏按钮默认图标
     *
     * @param codeFullScreenIcon 代码全屏按钮图标默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeFullScreenIcon(codeFullScreenIcon: CJResource): MarkdownThemeBuilder

    /**
     * 设置代码复制按钮默认图标
     *
     * @param codeCopyIcon 代码复制按钮图标默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeCopyIcon(codeCopyIcon: CJResource): MarkdownThemeBuilder

    /**
     * 设置组合代码标题字体大小
     *
     * @param codeListTitleTextSize 组合代码标题字体大小默认13.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleTextSize(codeListTitleTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置组合代码标题选中文本颜色
     *
     * @param codeListTitleSelectTextColor 组合代码标题选中文本颜色默认Color.RED
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置组合代码标题未选中文本颜色
     *
     * @param codeListTitleUnSelectTextColor 组合代码标题未选中文本颜色默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置组合代码标题选中背景颜色
     *
     * @param codeListTitleSelectBackgroupColor 组合代码标题选中背景颜色默认Color.GRAY
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleSelectBackgroupColor(codeListTitleSelectBackgroupColor: Color): MarkdownThemeBuilder
    
    /**
     * 设置组合代码标题未选中背景颜色
     *
     * @param codeListTitleUnSelectBackgroupColor 组合代码标题未选中背景颜色默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleUnSelectBackgroupColor(codeListTitleUnSelectBackgroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置H1、H2标题下分割线高度
     *
     * @param headingBreakHeight H1、H2标题下分割线高度默认0.5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBreakHeight(headingBreakHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置H1、H2标题下分割线颜色
     *
     * @param headingBreakColor H1、H2标题下分割线颜色默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBreakColor(headingBreakColor: Color): MarkdownThemeBuilder

    /**
     * 设置标题元素字体
     *
     * @param headingTypeface 标题元素字体默认HarmonyOS Sans
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTypeface(headingTypeface: String): MarkdownThemeBuilder

    /**
     * 设置标题文本大小数组
     *
     * @param headingTextSizeMultipliers 标题文本大小数组默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<Float64>): MarkdownThemeBuilder

    /**
     * 设置标题字体颜色
     *
     * @param headingTextColor 标题字体颜色默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextColor(headingTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置标题字体字间距
     *
     * @param headingTextWordSpace 标题字体字间距默认0.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextWordSpace(headingTextWordSpace: Float64): MarkdownThemeBuilder

    /**
     * 设置一级标题文本行高
     *
     * @param headingTextLineheight1 一级标题文本行高默认22.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineheight1(headingTextLineheight1: Float64): MarkdownThemeBuilder

    /**
     * 设置二级标题文本行高
     *
     * @param headingTextLineheight2 二级标题文本行高默认22.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineheight2(headingTextLineheight2: Float64): MarkdownThemeBuilder

    /**
     * 设置三级标题文本行高
     *
     * @param headingTextLineheight3 三级标题文本行高默认22.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineheight3(headingTextLineheight3: Float64): MarkdownThemeBuilder

    /**
     * 设置四级标题文本行高
     *
     * @param headingTextLineheight4 四级标题文本行高默认22.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineheight4(headingTextLineheight4: Float64): MarkdownThemeBuilder

    /**
     * 设置五级标题文本行高
     *
     * @param headingTextLineheight5 五级标题文本行高默认22.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineheight5(headingTextLineheight5: Float64): MarkdownThemeBuilder

    /**
     * 设置六级标题文本行高
     *
     * @param headingTextLineheight1 六级标题文本行高默认22.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineheight6(headingTextLineheight6: Float64): MarkdownThemeBuilder

    /**
     * 设置段落字体大小
     *
     * @param paragraphTextSize 段落字体大小默认14.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextSize(paragraphTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置段落字体颜色
     *
     * @param paragraphTextColor 段落字体颜色默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextColor(paragraphTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置段落文本字间距
     *
     * @param paragraphTextWordSpace 段落字体字间距默认0.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextWordSpace(paragraphTextWordSpace: Float64): MarkdownThemeBuilder

    /**
     * 设置段落文本行高
     *
     * @param paragraphTextLineheight 段落文本行高默认22.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextLineheight(paragraphTextLineheight: Float64): MarkdownThemeBuilder

    /**
     * 设置分割线颜色
     *
     * @param thematicBreakColor 分割线颜色默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setThematicBreakColor(thematicBreakColor: Color): MarkdownThemeBuilder

    /**
     * 设置分割线高度
     *
     * @param thematicBreakHeight 分割线高度默认0.5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setThematicBreakHeight(thematicBreakHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置软换行是否换行
     *
     * @param isLineBreak 软换行是否换行true：软换行换行，false：软换行不换行默认软换行不换行
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsLineBreak(isLineBreak: Bool): MarkdownThemeBuilder

    /**
     * 设置数学公式文字大小(px)
     *
     * @param latexMathTextSize 数学公式文字大小(px)默认48.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTextSize(latexMathTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置数学公式行距
     *
     * @param latexMathTextLineSpacing 数学公式行距默认10.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTextLineSpacing(latexMathTextLineSpacing: Float64): MarkdownThemeBuilder

    /**
     * 设置数学公式背景色
     *
     * @param latexMathBackGroupColor 数学公式背景色默认0x00FFFFFF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathBackGroupColor(latexMathBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置数学公式字体颜色
     *
     * @param latexMathTextColor 数学公式字体颜色默认0xFF000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTextColor(latexMathTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置数学公式生成图片格式
     *
     * @param latexMathColorFormat 数学公式生成图片格式默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): MarkdownThemeBuilder

    /**
     * 设置数学公式资源路径
     *
     * @param resPath 数学公式资源路径默认"/data/storage/el1/bundle/entry/resources/resfile/res"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setResPath(resPath: String): MarkdownThemeBuilder

    /**
     * 设置视频默认占位图
     *
     * @param videoImage 视频默认占位图默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoImage(videoImage: CJResource): MarkdownThemeBuilder

    /**
     * 设置视频播放按钮默认图标
     *
     * @param playCircleFillIcon 视频播放按钮图标默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setPlayCircleFillIcon(playCircleFillIcon: CJResource): MarkdownThemeBuilder

    /**
     * 设置图片banner默认占位图
     *
     * @param bannerImage 图片banner占位图默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBannerImage(bannerImage: CJResource): MarkdownThemeBuilder

    /**
     * 设置图片宽度边距 - 计算屏幕宽度需要减去padding的宽度，单位vp
     *
     * @param imagePadding 图片宽度边距默认40vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImagePadding(imagePadding: Int64): MarkdownThemeBuilder

    /**
     * 设置图片默认占位图
     *
     * @param imageResource 图片占位图默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageResource(imageResource: CJResource): MarkdownThemeBuilder

    /**
     * 设置是否压缩图片
     *
     * @param isAutoResize 是否压缩图片true：压缩，false：不压缩默认压缩
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsAutoResize(isAutoResize: Bool): MarkdownThemeBuilder

    /**
     * 设置按钮文字内容
     *
     * @param buttonTextStr 按钮文字内容
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setButtonTextStr(buttonTextStr: String): MarkdownThemeBuilder

    /**
     * 设置按钮文字字体大小 - 单位fp
     *
     * @param buttonTextSize 按钮文字字体大小 - 单位fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setButtonTextSize(buttonTextSize: Int64): MarkdownThemeBuilder

    /**
     * 设置按钮文字颜色
     *
     * @param buttonTextColor 按钮文字颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setButtonTextColor(buttonTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置按钮背景颜色
     *
     * @param buttonTextBackgroupColor 按钮背景颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setButtonTextBackgroupColor(buttonTextBackgroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置按钮高度 - 单位vp
     *
     * @param buttonTextHeight 按钮高度 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setButtonTextHeight(buttonTextHeight: Int64): MarkdownThemeBuilder

    /**
     * 设置按钮上下边距 - 单位vp
     *
     * @param buttonTextMargin 按钮上下边距 - 单位vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setButtonTextMargine(buttonTextMargin: Int64): MarkdownThemeBuilder

    /**
     * 设置表格内容内边距 - 单位vp
     *
     * @param tableCellPadding 表格内容内边距 - 单位vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableCellPadding(tableCellPadding: Float64): MarkdownThemeBuilder

    /**
     * 设置表格边框颜色
     *
     * @param tableBorderColor 表格边框颜色
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableBorderColor(tableBorderColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格边框宽度 -单位vp
     *
     * @param tableBorderWidth 表格边框宽度 -单位vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableBorderWidth(tableBorderWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置表格奇数行背景色
     *
     * @param tableOddRowBackgroundColor 表格奇数行背景色
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableOddRowBackgroundColor(tableOddRowBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格偶数行背景色
     *
     * @param tableEvenRowBackgroundColor 表格偶数行背景色
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格头背景色
     *
     * @param tableHeaderRowBackgroundColor 表格头背景色
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格行高
     *
     * @param tableTextLineheight 行高 - 单位vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableTextLineheight(tableTextLineheight: Float64): MarkdownThemeBuilder

    /**
     * 设置表格圆角 - 单位vp
     *
     * @param tableRadius 表格圆角 - 单位vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableRadius(tableRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置表格最小宽度 - 单位vp
     *
     * @param tableMinTextWidth 表格最小宽度 - 单位vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableMinTextWidth(tableMinTextWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置表格最大宽度 - 单位vp
     *
     * @param tableMaxTextWidth 表格最大宽度 - 单位vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableMaxTextWidth(tableMaxTextWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置markdown代码高亮样式
     *
     * @param PrismTheme 高亮样式
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setPrismTheme(prismTheme: PrismTheme): MarkdownThemeBuilder

    /**
     * 返回Theme对象
     *
     * @return MarkdownTheme MarkdownTheme对象
     */
    public func build(): MarkdownTheme
}
```

## 代码高亮配置类

### interface PrismTheme

高亮主题接口

```cangjie
/**
 * prism 主题接口
 */
public interface PrismTheme {
    /**
     * 获取背景色
     *
     * @return UInt32 返回背景色
     */
    func background(): Color

    /**
     * 设置背景色
     *
     * @param bg 背景色值
     */
    func setBackground(bg: Color): Unit

    /**
     * 获取文本颜色
     *
     * @return UInt32 返回文本颜色
     */
    func textColor(): Color

    /**
     * 设置文本颜色
     *
     * @param text 文本颜色
     */
    func setTextColor(text: Color): Unit

    /**
     * 获取字段颜色存储集合
     *
     * @return HashMap<PrismColor, Color> 返回颜色存储集合
     */
    func getColorMap(): HashMap<PrismColor, Color>

    /**
     * 自定义设置字段颜色存储集合
     *
     * @param HashMap<PrismColor, Color> 颜色存储集合
     */
    func setColorMap(colorMap: HashMap<PrismColor, Color>): Unit
}
```

### class PrismThemeDefault

高亮默认主题(白色主题)

```cangjie
/**
 *  prism 默认主题类
 */
public class PrismThemeDefault <: PrismThemeBase {
    /**
     * 创建 PrismThemeDefault 对象的静态方法
     *
     * @return 返回一个默认背景色的主题
     */
    public static func create(): PrismThemeDefault

    /**
     * 获取背景色
     *
     * @return 返回背景色
     */
    public func background(): Color

    /**
     * 设置背景色
     *
     * @param bg 背景色值
     */
    public func setBackground(bg: Color): Unit

    /**
     * 获取默认文本颜色
     *
     * @return 返回文本颜色
     */
    public func textColor(): Color

    /**
     * 设置文本颜色
     *
     * @param text 文本颜色
     */
    public func setTextColor(text: Color): Unit

    /**
     * 获取颜色存储集合
     *
     * @return HashMap<PrismColor, Color> 返回颜色存储集合
     */
    public open override func getColorMap(): HashMap<PrismColor, Color>

    /**
     * 自定义设置颜色存储集合
     *
     * @param HashMap<PrismColor, Color> 颜色存储集合
     */
    public open override func setColorMap(colorMap: HashMap<PrismColor, Color>): Unit
}
```

### class PrismThemeDarkula

高亮暗黑主题(黑色主题)

```cangjie
/**
 *  prism 暗黑主题类
 */
public class PrismThemeDarkula <: PrismThemeBase {
    /**
     * 创建 PrismThemeDarkula 对象的静态方法
     *
     * @return 返回一个默认背景色的暗黑主题
     */
    public static func create(): PrismThemeDarkula

    /**
     * 获取背景色
     *
     * @return 返回背景色
     */
    public func background(): Color

    /**
     * 设置背景色
     *
     * @param bg 背景色值
     */
    public func setBackground(bg: Color): Unit

    /**
     * 获取默认文本颜色
     *
     * @return 返回文本颜色
     */
    public func textColor(): Color

    /**
     * 设置文本颜色
     *
     * @param text 文本颜色
     */
    public func setTextColor(text: Color): Unit

    /**
     * 获取颜色存储集合
     *
     * @return HashMap<PrismColor, Color> 返回颜色存储集合
     */
    public open override func getColorMap(): HashMap<PrismColor, Color>

    /**
     * 自定义设置颜色存储集合
     *
     * @param HashMap<PrismColor, Color> 颜色存储集合
     */
    public open override func setColorMap(colorMap: HashMap<PrismColor, Color>): Unit
}
```

### enum PrismColor

标识枚举

```cangjie
/**
 * 围栏代码块高亮枚举类
 */
public enum PrismColor <: Hashable & Equatable<PrismColor> {
    COMMENT |
    PROLOG |
    DOCTYPE |
    CDATA |
    PUNCTUATION |
    PROPERTY |
    TAG |
    BOOLEAN |
    NUMBER |
    CONSTANT |
    SYMBOL |
    DELETED |
    SELECTOR |
    ATTR_NAME |
    STRING |
    CHAR |
    BUILTIN |
    INSERTED |
    OPERATOR |
    URL |
    ENTITY |
    ATRULE |
    ATTR_VALUE |
    KEYWORD |
    FUNCTION |
    CLASS_NAME |
    REGEX |
    IMPORTANT |
    VARIABLE |
    DELIMITER |
    ANNOTATION |
    ESCAPE_SEQ |
    GENERIC_METHOD |
    PSEUDO_ELEMENT |
    PSEUDO_CLASS |
    CLASS |
    ID |
    ATTRIBUTE |
    HEXCODE |
    COMMAND |
    PARAMETER |
    COORD |
    COMMIT_SHA1 |
    SPOCK_BLOCK |
    NULL |
    NAMESPACE |
    SHEBANG |
    DEFAULT

    public operator func ==(that: PrismColor): Bool

    public operator func !=(that: PrismColor): Bool

    public static func fromString(str: String): PrismColor

    public func toString(): String

    @OverflowWrapping
    public func hashCode(): Int64
}
```

## Markdown 核心解析器

markdown核心解析器通过调用commonmark4cj库进行解析  
支持对commonmark解析器的扩展  
同样支持对自身的扩展  

### class Markdown

```cangjie
public abstract class Markdown {
    /**
     * 创建一个 Markdown 实例，并注册 CorePlugin 插件
     */
    public static func create(): Markdown {
        return builder().usePlugin(CorePlugin.create()).build()
    }

    /**
     *  创建一个 MarkdownBuilder 实例, 并注册 CorePlugin 插件
     */
    public static func builder(): MarkdownBuilder {
        return MarkdownBuilderImpl().usePlugin(CorePlugin.create())
    }

    /**
     * 创建一个 MarkdownBuilder 实例，未注册插件
     */
    public static func builderNoCore(): MarkdownBuilder {
        return MarkdownBuilderImpl()
    }

    /**
     * 解析 markdown 字符串
     * @param input markdown 字符串
     * @return 返回节点树的根节点
     */
    public func parse(input: String): Node

    /**
     * 将节点树渲染成 NodeView
     * @param node 节点树的根节点
     * @return 返回 NodeView
     */
    public func render(node: Node): NodeView

    /**
     * 解析 markdown 字符串，并渲染成 NodeView
     * @param input markdown 字符串
     * @return 返回 NodeView
     */
    public func toMarkdown(input: String): NodeView

    /**
     * 是否启用插件
     * @param plugin 插件id
     * @return true 启用，false 未启用
     */
    public func hasPlugin(plugin: String): Bool

    /**
     * 获取插件
     * @param plugin 插件id
     * @return MarkdownPlugin
     */
    public func getPlugin(plugin: String): ?MarkdownPlugin

    /**
     * 获取插件
     * @param plugin 插件id
     * @return MarkdownPlugin
     * @throws IllegalStateException 插件未找到异常
     */
    public func requirePlugin(pluginType: String): MarkdownPlugin

    /**
     * 获取所有已注册的插件
     */
    public func getPlugins(): ArrayList<MarkdownPlugin>
}
```

### class MarkdownBuilder

```cangjie
public interface MarkdownBuilder {
    /**
     * 注册插件
     * @param plugin 插件
     * @return MarkdownBuilder
     */
    func usePlugin(plugin: MarkdownPlugin): MarkdownBuilder

    /**
     * 注册插件
     * @param plugins 插件列表
     * @return MarkdownBuilder
     */
    func usePlugins(plugins: Iterable<MarkdownPlugin>): MarkdownBuilder

    /**
     * 当渲染 NodeView 异常, 是否退化至纯文本, 默认true
     * @param fallbackToRawInputWhenEmpty true 退化至纯文本，false 抛出异常
     */
    func fallbackToRawInputWhenEmpty(fallbackToRawInputWhenEmpty: Bool): MarkdownBuilder

    /**
     * 构建 Markdown 实例
     */
    func build(): Markdown
}
```

### Markdown解析器插件

```cangjie
public interface MarkdownPlugin <: Hashable & Equatable<MarkdownPlugin> & ToString {
    /**
     * 插件id
     */
    func getClassType(): String

    /**
     * 配置commonmark解析器 
     * @param builder commonmark.ParserBuilder
     */
    func configureParser(builder: ParserBuilder): Unit

    /**
     * 配置commonmark遍历器
     * @param builder commonmark.MarkdownVisitorBuilder
     */
    func configureVisitor(builder: MarkdownVisitorBuilder): Unit

    /**
     * parse前 处理markdown文本
     * @param markdown markdown文本
     * @return 处理后的markdown文本
     */
    func processMarkdown(markdown: String): String

    /**
     * parse后/render前 处理Node
     * @param node node树root节点
     */
    func beforeRender(node: Node): Unit

    /**
     * render后 处理Node
     * @param node    node树root节点
     * @param visitor 当前遍历器
     */
    func afterRender(node: Node, visitor: MarkdownVisitor): Unit
}
```

### 用于渲染Component的NodeView数据结构

```cangjie
public class NodeView <: ToString {
    /* BlockQuote深度 -1:无效 >=0:深度 */
    public var blockQuoteDepth: Int = -1
    /* 是否被BlockQuote修饰 */
    public var blockQuote: ?BlockQuote = None
    /* 是否被Emphasis修饰 */
    public var emphasis: ?Emphasis = None
    /* 是否被StrongEmphasis修饰 */
    public var strongEmphasis: ?StrongEmphasis = None
    /* 是否被Link修饰 */
    public var link: ?Link = None
    /* 是否属于BulletList */
    public var bulletList: ?BulletList = None
    /* 属于第几层OrderedListItem -1:无效 >=0:深度 */
    public var depth: Int = -1
    /* 属于第几位OrderedListItem -1:无效 >=0:序号 */
    public var order: Int = -1
    public var orderedList: ?OrderedList = None
    /* 属于第几层BulletListItem -1:无效 >=0:深度 */
    public var bulletListDepth: Int = -1
    /* ListItem中可包含多个Block，但只有第一个Block有列表符号 */
    public var listMark: Bool = false
    // 本身Node节点
    public let node: Node
    // Node节点开始结束标志 -1:无效 0:开始 1:结束
    var startend = -1
    // 是否为Node开始
    public prop isNodeStart: Bool
    // 是否为Node结束
    public prop isNodeEnd: Bool
    // 子节点列表
    public let children: ArrayList<NodeView> = ArrayList<NodeView>()
    // NodeViewTree中的上级NodeView
    public var collector: ?NodeView = None
    // 供插件使用的自定义属性
    public var props: ?HashMap<String, Any> = None
    // 所有上级列表节点 用于ListItem中第一个Block前的列表符号绘制
    public var list: ArrayList<NodeView> = EMPTY_LIST
}
```
