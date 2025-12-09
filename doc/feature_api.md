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
    * @param markdownAIConfiguration 传入markdown配置选项
    * @param markdownPlugin 传入markdown插件
    * @param adBuilder 传入广告布局
    * @param videoBuilder 传入视频布局
    * @param audioBuilder 传入音频布局
    */
    MarkdownComponent(
        output: String,
        markdownAIConfiguration!: MarkdownAIConfiguration,
        markdownPlugin: Markdown,
        @BuilderParam adBuilder: (NodeView) -> Unit,
        @BuilderParam videoBuilder: (NodeView, MarkdownConfiguration, (String) -> Unit) -> Unit,
        @BuilderParam audioBuilder: (NodeView, MarkdownConfiguration) -> Unit
    )
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
     * 设置文本复制的点击事件
     *
     * @param textCopyCallback 文本复制的点击事件 (String:复制文本)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTextCopyCallback(textCopyCallback: (String) -> Unit): MarkdownConfigurationBuilder

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
     * @param imageCallback 图片点击回调接口 (String:图片链接，图片和视频链接列表)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setImageCallback(imageCallback: (String, ArrayList<String>) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置图片替换事件
     *
     * @param imageCallbackCallback 图片替换回调接口 (String:图片链接 -> ?Array<UInt8>:图片数据)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setImageCallbackCallback(imageCallbackCallback: (String) -> ?Array<UInt8>): MarkdownConfigurationBuilder

    /**
     * 设置音频的点击事件
     *
     * @param audioCallback 音频点击回调接口 (String:音频链接)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setAudioCallback(audioCallback: (String) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置视频的点击事件
     *
     * @param videoCallback 视频点击回调接口 (String:视频ID，图片和视频链接列表)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setVideoCallback(videoCallback: (String, ArrayList<String>) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置视频的图片替换回调
     *
     * @param videoImageCallback 视频的图片替换回调接口 - 图片url、宽高比、视频时长
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setVideoImageCallback(videoImageCallback: (String, (String, Float64, Int64) -> Unit) -> Unit): MarkdownConfigurationBuilder

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
     * 设置获取markdown全部文本
     *
     * @param nodeString markdown全部文本对象
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setNodeString(nodeString: (NodeViewStringBuilder) -> Unit): MarkdownConfigurationBuilder

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
 * 1：上下文 - 本地图片rawfile需要上下文。混合项目是stageContext，仓颉项目是abilityContext
 * 2：是否打开长按复制粘贴功能、每个模块之间上下间距
 * 3：链接 - 链接是否是图片显示、列表中的单行链接是否是图片显示
 *          文本链接：文本格式链接文本颜色、是否按照链接文字字体大小显示文本、文本格式链接文字大小、文本格式链接背景颜色、文本格式是否显示链接下划线
 *          圆形图片链接：圆形图片格式链接主题背景颜色、圆形图片格式链接控件背景颜色、圆形图片格式链接文字大小、圆形图片格式链接文字颜色、圆形图片格式链接半径、圆形图片格式链接左右外边距
 *          圆角矩形图片链接：圆角矩形图片格式链接主题背景颜色、圆角矩形图片格式链接控件背景颜色、圆角矩形图片格式链接文字大小、圆角矩形图片格式链接文字颜色、圆角矩形图片格式链接控件高度、圆角矩形图片格式链接左右内边距、圆角矩形图片格式链接圆角半径、圆角矩形图片格式链接左右外边距
 *          空心圆角矩形图片链接：空心圆角矩形图片格式链接主题背景颜色、空心圆角矩形图片格式链接控件背景颜色、空心圆角矩形图片格式链接文字大小、空心圆角矩形图片格式链接控件高度、空心圆角矩形图片格式链接左右内边距、空心圆角矩形图片格式链接边框宽度、空心圆角矩形图片格式链接分割线宽度、空心圆角矩形图片格式链接左右外边距、空心圆角矩形图片格式分割线和文本左边距、空心圆角矩形图片格式分割线和文本右边距
 * 4：列表 - 块引用：块引用左边距、块引用右边距、块引用左边线条宽度、块引用左边线条颜色、块引用背景颜色、块引用子模块上下间距
 *          有序/无序/任务列表子模块上下间距、有序/无序/任务列表左边距、有序/无序/任务列表右边距
 *          有序列表：有序列表前缀文本是否加粗、有序列表前缀文本颜色、有序列表前缀文本大小、有序列表前缀文本行高
 *          无序列表：无序列表前缀是否全部是实心圆型、无序列表前缀文本颜色、无序列表前缀文本大小、无序列表前缀文本行高
 *          任务列表：任务列表选择框宽高
 * 5：代码 - 内联代码是否是图片显示
 *          文本/图片格式内联代码文本颜色、文本/图片格式内联代码背景颜色、文本/图片格式内联代码文本大小
 *          文本格式内联代码：文本格式内联代码文本字体
 *          图片格式内联代码：图片格式内联代码文本左右边距、图片格式内联代码文本高度
 *          缩进/围栏/组合/单独代码块代码文本颜色、缩进/围栏/组合/单独代码块代码类型文本颜色、缩进/围栏/组合/单独代码块代码类型文本、缩进/围栏/组合/单独代码块代码类型和代码块距离、缩进/围栏/组合/单独代码块代码复制/全屏文字是否显示、缩进/围栏/组合/单独代码块代码行号是否显示、缩进/围栏/组合/单独代码块背景颜色、缩进/围栏/组合/单独代码块左边距、缩进/围栏/组合/单独代码块字体、缩进/围栏/组合/单独代码块代码文本大小、缩进/围栏/组合/单独代码块代码文本行高、缩进/围栏/组合/单独代码块圆角大小、缩进/围栏/组合/单独代码块代码全屏按钮是否显示、缩进/围栏/组合/单独代码块代码全屏/复制按钮宽高、缩进/围栏/组合/单独代码块代码全屏按钮默认图标、缩进/围栏/组合/单独代码块代码复制按钮默认图标
 *          组合代码块：组合代码块未选中标题字体大小、组合代码块选中标题字体大小、组合代码块选中标题文本颜色、组合代码块未选中标题文本颜色、组合代码块选中标题背景颜色、组合代码块未选中标题背景颜色
 *          单独代码块：是否单独代码块显示、单独代码块行号宽度、单独代码块是否居底显示
 * 6：标题 - H1/H2标题下分割线高度、H1/H2标题下分割线颜色
 *          标题文本字体、标题模块上间距、标题模块下间距、标题文本大小数组、标题文本颜色、标题文本字间距、一级标题文本行高、二级标题文本行高、三级标题文本行高、四级标题文本行高、五级标题文本行高、六级标题文本行高
 * 7：段落 - 段落模块上间距、段落模块下间距、段落文本大小、段落文本颜色、段落文本字间距、段落文本行高、段落文本字体
 * 8：分割线 - 分割线颜色、分割线高度、分割线上部外边距、分割线下部外边距
 * 9：软换行 - 软换行是否换行
 * 10：数学公式 - 数学公式未加载状态是否显示文字、数学公式文本大小、数学公式背景色、数学公式文本颜色、数学公式生成图片格式、块结构的数学公式是否居中、数学公式字体路径
 * 11：音频 - 音频图标、音频阴影颜色值、音频边框颜色、音频边框粗细、音频边框圆角、音频按钮背景颜色、音频按钮文字颜色、音频按钮文字大小、音频按钮文字内容、音频按钮圆角大小、音频标题文字大小、音频标题文字颜色、音频标题文字行高、音频类型文字大小、音频类型文字颜色、音频类型文字行高、音频上边距、音频下边距
 * 12：视频 - 视频默认占位图、视频播放按钮默认图标、视频圆角大小、视频时间文本颜色、视频时间文本大小、视频时间文本居右边距、视频时间文本居底边距、视频上边距、视频下边距
 * 13：图片Banner - 图片banner默认占位图
 * 14：图片 - 图片基于自身宽度缩放百分比、图片基于父布局宽度缩放百分比、图片圆角大小、图片缩放类型、图片默认占位图、网络图片是否压缩、图片上边距、图片下边距
 * 15：表格 - 表格内容内边距、表格边框颜色、表格边框宽度、表格奇数行背景色、表格偶数行背景色、表格头背景色、表格文本行高、表格圆角大小、表格一格最小宽度、表格一格最大宽度、表格第一列是否加粗
 * 16：代码高亮 - markdown代码高亮样式
 * 17：删除线 - 删除线颜色
 * 18：定义列表 - 定义列表术语和定义行之间间距、定义列表定义行缩进、定义列表定义行间距
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

**注：鉴于性能考虑，对builder的非法参数不做处理**

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
     * 设置markdown上下文 - 互操作
     *
     * @param stageContext markdown上下文 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setStageContext(stageContext: StageContext): MarkdownThemeBuilder

    /**
     * 设置markdown上下文 - 仓颉
     *
     * @param abilityContext markdown上下文 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAbilityContext(abilityContext: AbilityContext): MarkdownThemeBuilder

    /**
     * 设置是否打开长按复制粘贴
     *
     * @param isOnCopy 是否打开长按复制粘贴 - 默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsOnCopy(isOnCopy: Bool): MarkdownThemeBuilder

    /**
     * 设置模块间上下间距
     *
     * @param blockTopAndBottomMargins 模块间上下间距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockTopAndBottomMargins(blockTopAndBottomMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置链接是否是图片显示
     *
     * @param isLinkStyle 链接是否是图片显示 - true：图片显示；false：文本显示。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsLinkStyle(isLinkStyle: Bool): MarkdownThemeBuilder

    /**
     * 设置列表中的单行链接是否是图片显示
     *
     * @param isListLinkStyle 列表中的单行链接是否是图片显示 - true：图片显示；false：文本显示。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsListLinkStyle(isListLinkStyle: Bool): MarkdownThemeBuilder

    /**
     * 设置文本格式链接文本颜色
     *
     * @param linkColor 文本格式链接文本颜色 - 默认0XFF0000FF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkColor(linkColor: Color): MarkdownThemeBuilder

    /**
     * 设置是否按照链接文本字体大小显示文本
     *
     * @param isLinkSize 是否按照链接文本字体大小显示文本 - true：显示链接字体文本大小；false：跟随标题段落大小显示。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsLinkSize(isLinkSize: Bool): MarkdownThemeBuilder

    /**
     * 设置文本格式链接文字大小
     *
     * @param linkSize 文本格式链接文字大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkSize(linkSize: Float64): MarkdownThemeBuilder

    /**
     * 设置文本格式链接背景颜色
     *
     * @param linkBackGroupColor 文本格式链接背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkBackGroupColor(linkBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置文本格式是否显示链接下划线
     *
     * @param isLinkUnderlined 文本格式是否显示链接下划线 - true：显示下划线；false：不显示下划线。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsLinkUnderlined(isLinkUnderlined: Bool): MarkdownThemeBuilder

    /**
     * 设置圆形图片格式链接主题背景颜色
     *
     * @param linkCircleImageBackGroupColor 圆形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageBackGroupColor(linkCircleImageBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置圆形图片格式链接控件背景颜色
     *
     * @param linkCircleImageButtonBackGroupColor 圆形图片格式链接控件背景颜色 - 默认0XFF000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageButtonBackGroupColor(linkCircleImageButtonBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置圆形图片格式链接文字大小
     *
     * @param linkCircleImageTextSize 圆形图片格式链接文字大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageTextSize(linkCircleImageTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置圆形图片格式链接文字颜色
     *
     * @param linkCircleImageTextColor 圆形图片格式链接文字颜色 - 默认0XFFFFFFFF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageTextColor(linkCircleImageTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置圆形图片格式链接半径
     *
     * @param linkCircleImageRadius 圆形图片格式链接半径 - 默认20.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageRadius(linkCircleImageRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置圆形图片格式链接左右外边距
     *
     * @param linkCircleImageMargin 圆形图片格式链接左右外边距 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkCircleImageMargin(linkCircleImageMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置圆角矩形图片格式链接主题背景颜色
     *
     * @param linkRectImageBackGroupColor 圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageBackGroupColor(linkRectImageBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置圆角矩形图片格式链接控件背景颜色
     *
     * @param linkRectImageButtonBackGroupColor 圆角矩形图片格式链接控件背景颜色 - 默认0XFF000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageButtonBackGroupColor(linkRectImageButtonBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 圆角矩形图片格式链接文字大小
     *
     * @param linkRectImageTextSize 圆角矩形图片格式链接文字大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageTextSize(linkRectImageTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置圆角矩形图片格式链接文字颜色
     *
     * @param linkRectImageTextColor 圆角矩形图片格式链接文字颜色 - 默认0XFFFFFFFF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageTextColor(linkRectImageTextColor: Color): MarkdownThemeBuilder

    /**
     * 圆角矩形图片格式链接控件高度
     *
     * @param linkRectImageHeight 圆角矩形图片格式链接控件高度 - 默认20.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageHeight(linkRectImageHeight: Float64): MarkdownThemeBuilder

    /**
     * 圆角矩形图片格式链接左右内边距
     *
     * @param linkRectImagePadding 圆角矩形图片格式链接左右内边距 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImagePadding(linkRectImagePadding: Float64): MarkdownThemeBuilder

    /**
     * 圆角矩形图片格式链接圆角半径
     *
     * @param linkRectImageRadius 圆角矩形图片格式链接圆角半径 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageRadius(linkRectImageRadius: Float64): MarkdownThemeBuilder

    /**
     * 圆角矩形图片格式链接左右外边距
     *
     * @param linkRectImageMargin 圆角矩形图片格式链接左右外边距 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectImageMargin(linkRectImageMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形图片格式链接主题背景颜色
     *
     * @param linkRectToolImageBackGroupColor 空心圆角矩形图片格式链接主题背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageBackGroupColor(linkRectToolImageBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形图片格式链接控件背景颜色
     *
     * @param linkRectToolImageButtonBackGroupColor 空心圆角矩形图片格式链接控件背景颜色 - 默认OXFFFFFFFF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageButtonBackGroupColor(linkRectToolImageButtonBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形图片格式链接文字大小
     *
     * @param linkRectToolImageTextSize 空心圆角矩形图片格式链接文字大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageTextSize(linkRectToolImageTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形图片格式链接控件高度
     *
     * @param linkRectToolImageHeight 空心圆角矩形图片格式链接控件高度 - 默认21.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageHeight(linkRectToolImageHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形图片格式链接左右内边距
     *
     * @param linkRectToolImagePadding 空心圆角矩形图片格式链接左右内边距 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImagePadding(linkRectToolImagePadding: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形图片格式链接边框宽度
     *
     * @param linkRectToolImageBorderWidth 空心圆角矩形图片格式链接边框宽度 - 默认1.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageBorderWidth(linkRectToolImageBorderWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形图片格式链接分割线宽度
     *
     * @param linkRectToolImageDividingLineWidth 空心圆角矩形图片格式链接分割线宽度 - 默认1.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageDividingLineWidth(linkRectToolImageDividingLineWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形图片格式链接左右外边距
     *
     * @param linkRectToolImageMargin 空心圆角矩形图片格式链接左右外边距 - 默认6.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageMargin(linkRectToolImageMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形图片格式分割线和文本左边距
     *
     * @param linkRectToolImageLineLeftPadding 空心圆角矩形图片格式分割线和文本左边距 - 默认3.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageLineLeftPadding(linkRectToolImageLineLeftPadding: Float64): MarkdownThemeBuilder

    /**
     * 设置空心圆角矩形图片格式分割线和文本右边距
     *
     * @param linkRectToolImageLineRightPadding 空心圆角矩形图片格式分割线和文本右边距 - 默认3.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkRectToolImageLineRightPadding(linkRectToolImageLineRightPadding: Float64): MarkdownThemeBuilder

    /**
     * 设置块引用左边距
     *
     * @param blockQuoteLeftMargin 块引用左边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteLeftMargin(blockQuoteLeftMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置块引用右边距
     *
     * @param blockQuoteRightMargin 块引用右边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteRightMargin(blockQuoteRightMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置块引用左边线条宽度
     *
     * @param blockQuoteWidth 块引用左边线条宽度 - 默认1.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteWidth(blockQuoteWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置块引用左边线条颜色
     *
     * @param blockQuoteColor 块引用左边线条颜色 - 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteColor(blockQuoteColor: Color): MarkdownThemeBuilder

    /**
     * 设置块引用背景颜色
     *
     * @param blockQuoteBackGroupColor 块引用背景颜色 - 默认0XFFEAEAEA
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteBackGroupColor(blockQuoteBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置块引用子模块上下间距
     *
     * @param blockQuoteTopAndBottomMargins 块引用子模块上下间距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteTopAndBottomMargins(blockQuoteTopAndBottomMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置有序列表、无序列表、任务列表子模块上下间距
     *
     * @param blockOrderedAndBulletTopAndBottomMargins 有序列表、无序列表、任务列表子模块上下间距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockOrderedAndBulletTopAndBottomMargins(blockOrderedAndBulletTopAndBottomMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置有序列表、无序列表、任务列表左边距
     *
     * @param blockLeftMargin 有序列表、无序列表、任务列表左边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockLeftMargin(blockLeftMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置有序列表、无序列表、任务列表右边距
     *
     * @param blockRightMargin 有序列表、无序列表、任务列表右边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockRightMargin(blockRightMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置有序列表前缀文本是否加粗
     *
     * @param orderedListItemPrefixBold 有序列表前缀文本是否加粗 - true：加粗；false：不加粗。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListItemPrefixBold(orderedListItemPrefixBold: Bool): MarkdownThemeBuilder

    /**
     * 设置有序列表前缀文本颜色
     *
     * @param orderedListItemColor 有序列表前缀文本颜色 - 默认OXFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListItemColor(orderedListItemColor: Color): MarkdownThemeBuilder

    /**
     * 设置有序列表前缀文本大小
     *
     * @param orderedListItemSize 有序列表前缀文本大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListItemSize(orderedListItemSize: Float64): MarkdownThemeBuilder

    /**
     * 设置有序列表前缀文本行高
     *
     * @param orderedListItemLineHeight 有序列表前缀文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListItemLineHeight(orderedListItemLineHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置无序列表前缀是否为实心圆型
     *
     * @param bulletListItemCircle 无序列表前缀是否为实心圆型 - 默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListItemCircle(bulletListItemCircle: Bool): MarkdownThemeBuilder

    /**
     * 设置无序列表前缀文本颜色
     *
     * @param bulletListItemColor 无序列表前缀文本颜色 - 默认OXFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListItemColor(bulletListItemColor: Color): MarkdownThemeBuilder

    /**
     * 设置无序列表前缀文本大小
     *
     * @param bulletListItemSize 无序列表前缀文本大小 - 默认4.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListItemSize(bulletListItemSize: Float64): MarkdownThemeBuilder

    /**
     * 设置无序列表前缀文本行高
     *
     * @param bulletListItemLineHeight 无序列表前缀文本行高 - 默认18.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListItemLineHeight(bulletListItemLineHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置任务列表选择框宽高
     *
     * @param taskListItemLength 任务列表选择框宽高 - 默认15.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTaskListItemLength(taskListItemLength: Float64): MarkdownThemeBuilder

    /**
     * 设置内联代码是否是图片显示
     *
     * @param isCodeStyle 内联代码是否是图片显示 - true：图片化显示；false：不图片化显示。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsCodeStyle(isCodeStyle: Bool): MarkdownThemeBuilder

    /**
     * 设置文本、图片格式内联代码文本颜色
     *
     * @param codeTextColor 文本、图片格式内联代码文本颜色 - 默认OXFF000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTextColor(codeTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置文本、图片格式内联代码背景颜色
     *
     * @param codeBackgroundColor 文本、图片格式内联代码背景颜色 - 默认OXFFEAEAEA
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBackgroundColor(codeBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置文本、图片格式内联代码文本大小
     *
     * @param codeTextSize 文本、图片格式内联代码文本大小 - 默认13.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTextSize(codeTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置文本格式内联代码文本字体
     *
     * @param codeTypeface 文本格式内联代码文本字体 - 默认"HarmonyOS Sans"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTypeface(codeTypeface: String): MarkdownThemeBuilder

    /**
     * 设置图片格式内联代码文本左右边距
     *
     * @param codeLeftAndRightPadding 图片格式内联代码文本左右边距 - 默认4.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeLeftAndRightPadding(codeLeftAndRightPadding: Float64): MarkdownThemeBuilder

    /**
     * 设置图片格式内联代码文本高度
     *
     * @param codeHeight 图片格式内联代码文本高度 - 默认20.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeHeight(codeHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块代码文本颜色
     *
     * @param codeBlockTextColor 代码块代码文本颜色 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTextColor(codeBlockTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置代码块代码类型文本颜色
     *
     * @param codeBlockTypeTextColor 代码块代码类型文本颜色 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTypeTextColor(codeBlockTypeTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置代码块代码类型文本
     *
     * @param codeBlockTypeTextStr 代码块代码类型文本 - 默认""
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTypeTextStr(codeBlockTypeTextStr: String): MarkdownThemeBuilder

    /**
     * 设置代码类型和代码块距离
     *
     * @param codeBlockTypeTextPadding 代码类型和代码块距离 - 默认0.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTypeTextPadding(codeBlockTypeTextPadding: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块复制、全屏图片文字是否显示
     *
     * @param codeBlockIconTextHide 代码块复制、全屏图片文字是否显示 - true：显示；false：不显示。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockIconTextHide(codeBlockIconTextHide: Bool): MarkdownThemeBuilder

    /**
     * 设置代码块代码行号是否显示
     *
     * @param codeBlockLineNumberHide 代码块代码行号是否显示 - true：显示；false：不显示。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockLineNumberHide(codeBlockLineNumberHide: Bool): MarkdownThemeBuilder

    /**
     * 设置代码块背景颜色
     *
     * @param codeBlockBackgroundColor 代码块背景颜色 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockBackgroundColor(codeBlockBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置代码块左边距
     *
     * @param codeMultilineMargin 代码块左边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeMultilineMargin(codeMultilineMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块字体
     *
     * @param codeBlockTypeface 代码块字体 - 默认"HarmonyOS Sans"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTypeface(codeBlockTypeface: String): MarkdownThemeBuilder

    /**
     * 设置代码块代码文本大小
     *
     * @param codeBlockTextSize 代码块代码文本大小 -  默认13.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTextSize(codeBlockTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块代码文本行高
     *
     * @param codeBlockLineHeight 代码块代码文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockLineHeight(codeBlockLineHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块控件圆角大小
     *
     * @param codeBlockRadius 代码块控件圆角大小 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockRadius(codeBlockRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块代码全屏按钮是否显示
     *
     * @param isCodeFullScreen 代码块代码全屏按钮是否显示 - true：显示；false：不显示。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsCodeFullScreen(isCodeFullScreen: Bool): MarkdownThemeBuilder

    /**
     * 设置代码块代码全屏、代码复制按钮宽高
     *
     * @param iconWidthAndHeight 代码块代码全屏、代码复制按钮宽高 - 默认24.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIconWidthAndHeight(iconWidthAndHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块代码全屏按钮默认图标
     *
     * @param codeFullScreenIcon 代码块代码全屏按钮默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeFullScreenIcon(codeFullScreenIcon: AppResource): MarkdownThemeBuilder

    /**
     * 设置代码块代码复制按钮默认图标
     *
     * @param codeCopyIcon 代码块代码复制按钮默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeCopyIcon(codeCopyIcon: AppResource): MarkdownThemeBuilder

    /**
     * 设置组合代码未选中标题字体大小
     *
     * @param codeListTitleTextSize 组合代码未选中标题字体大小 - 默认13.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleTextSize(codeListTitleTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置组合代码选中标题字体大小
     *
     * @param codeListTitleSelectTextSize 组合代码选中标题字体大小 - 默认13.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleSelectTextSize(codeListTitleSelectTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置组合代码选中标题文本颜色
     *
     * @param codeListTitleSelectTextColor 组合代码选中标题文本颜色 - 默认Color.RED
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置组合代码未选中标题文本颜色
     *
     * @param codeListTitleUnSelectTextColor 组合代码未选中标题文本颜色 - 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置组合代码选中标题背景颜色
     *
     * @param codeListTitleSelectBackGroupColor 组合代码选中标题背景颜色 - 默认Color.GRAY
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleSelectBackGroupColor(codeListTitleSelectBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置组合代码未选中标题背景颜色
     *
     * @param codeListTitleUnSelectBackGroupColor 组合代码未选中标题背景颜色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleUnSelectBackGroupColor(codeListTitleUnSelectBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置是否单独代码块显示
     *
     * @param isSeparateCodeBlock 是否单独代码块显示 - true：显示；false：不显示。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsSeparateCodeBlock(isSeparateCodeBlock: Bool): MarkdownThemeBuilder

    /**
     * 设置单独代码块行号宽度
     *
     * @param separateCodeBlockWidth 单独代码块行号宽度 - 默认50.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSeparateCodeBlockWidth(separateCodeBlockWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置单独代码块是否居底显示
     *
     * @param separateCodeIsBottom 单独代码块是否居底显示 - 默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSeparateCodeIsBottom(separateCodeIsBottom: Bool): MarkdownThemeBuilder

    /**
     * 设置H1、H2标题下分割线高度
     *
     * @param headingBreakHeight H1、H2标题下分割线高度 - 默认0.5vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBreakHeight(headingBreakHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置H1、H2标题下分割线颜色
     *
     * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBreakColor(headingBreakColor: Color): MarkdownThemeBuilder

    /**
     * 设置标题文本字体
     *
     * @param headingTypeface 标题文本字体 - 默认"HarmonyOS Sans"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTypeface(headingTypeface: String): MarkdownThemeBuilder

    /**
     * 设置标题模块上间距
     *
     * @param headingTopMargins 标题模块上间距 - 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTopMargins(headingTopMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置标题模块下间距
     *
     * @param headingBottomMargins 标题模块下间距 - 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBottomMargins(headingBottomMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置标题文本大小数组
     *
     * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<Float64>): MarkdownThemeBuilder

    /**
     * 设置标题文本颜色
     *
     * @param headingTextColor 标题文本颜色 - 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextColor(headingTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置标题文本字间距
     *
     * @param headingTextWordSpace 标题文本字间距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextWordSpace(headingTextWordSpace: Float64): MarkdownThemeBuilder

    /**
     * 设置一级标题文本行高
     *
     * @param headingTextLineHeight1 一级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineHeight1(headingTextLineHeight1: Float64): MarkdownThemeBuilder

    /**
     * 设置二级标题文本行高
     *
     * @param headingTextLineHeight2 二级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineHeight2(headingTextLineHeight2: Float64): MarkdownThemeBuilder

    /**
     * 设置三级标题文本行高
     *
     * @param headingTextLineHeight3 三级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineHeight3(headingTextLineHeight3: Float64): MarkdownThemeBuilder

    /**
     * 设置四级标题文本行高
     *
     * @param headingTextLineHeight4 四级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineHeight4(headingTextLineHeight4: Float64): MarkdownThemeBuilder

    /**
     * 设置五级标题文本行高
     *
     * @param headingTextLineHeight5 五级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineHeight5(headingTextLineHeight5: Float64): MarkdownThemeBuilder

    /**
     * 设置六级标题文本行高
     *
     * @param headingTextLineHeight1 六级标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextLineHeight6(headingTextLineHeight6: Float64): MarkdownThemeBuilder

    /**
     * 设置段落模块上间距
     *
     * @param paragraphTopMargins 段落模块上间距 - 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTopMargins(paragraphTopMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置段落模块下间距
     *
     * @param paragraphBottomMargins 段落模块下间距 - 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphBottomMargins(paragraphBottomMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置段落文本大小
     *
     * @param paragraphTextSize 段落文本大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextSize(paragraphTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置段落文本颜色
     *
     * @param paragraphTextColor 段落文本颜色 - 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextColor(paragraphTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置段落文本字间距
     *
     * @param paragraphTextWordSpace 段落文本字间距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextWordSpace(paragraphTextWordSpace: Float64): MarkdownThemeBuilder

    /**
     * 设置段落文本行高
     *
     * @param paragraphTextLineHeight 段落文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextLineHeight(paragraphTextLineHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置段落文本字体
     *
     * @param paragraphTypeface 段落文本字体 - 默认"HarmonyOS Sans"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTypeface(paragraphTypeface: String): MarkdownThemeBuilder

    /**
     * 设置分割线颜色
     *
     * @param thematicBreakColor 分割线颜色 - 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setThematicBreakColor(thematicBreakColor: Color): MarkdownThemeBuilder

    /**
     * 设置分割线高度
     *
     * @param thematicBreakHeight 分割线高度 - 默认0.5vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setThematicBreakHeight(thematicBreakHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置分割线上部外边距
     *
     * @param thematicBreakTopMargin 分割线上部外边距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setThematicBreakTopMargin(thematicBreakTopMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置分割线下部外边距
     *
     * @param thematicBreakBottomMargin 分割线下部外边距 - 默认0.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setThematicBreakBottomMargin(thematicBreakBottomMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置软换行是否换行
     *
     * @param isLineBreak 软换行是否换行 - true：换行；false：不换行。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsLineBreak(isLineBreak: Bool): MarkdownThemeBuilder

    /**
     * 设置数学公式未加载状态是否显示文字
     *
     * @param latexDefaultText 数学公式未加载状态是否显示文字 - 默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexDefaultText(latexDefaultText: Bool): MarkdownThemeBuilder

    /**
     * 设置数学公式文本大小
     *
     * @param latexMathTextSize 数学公式文本大小 - 默认16.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTextSize(latexMathTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置数学公式背景色
     *
     * @param latexMathBackGroupColor 数学公式背景色 - 默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathBackGroupColor(latexMathBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置数学公式文本颜色
     *
     * @param latexMathTextColor 数学公式文本颜色 - 默认0xFF000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTextColor(latexMathTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置数学公式生成图片格式
     *
     * @param latexMathColorFormat 数学公式生成图片格式 - 默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): MarkdownThemeBuilder

    /**
     * 设置块结构的数学公式是否居中
     *
     * @param latexMathBlockCenter 块结构的数学公式是否居中 - true：居中；false：不居中。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathBlockCenter(latexMathBlockCenter: Bool): MarkdownThemeBuilder

    /**
     * 设置数学公式字体路径
     *
     * @param latexMathResStr 数学公式字体路径 默认 "/data/storage/el1/bundle/entry/resources/resfile/res"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathResStr(latexMathResStr: String): MarkdownThemeBuilder

    /**
     * 设置音频图标
     *
     * @param audioIcon 音频图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioIcon(audioIcon: AppResource): MarkdownThemeBuilder

    /**
     * 设置音频阴影颜色值
     *
     * @param audioShadowColor 音频阴影颜色值 - 默认0x1A000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioShadowColor(audioShadowColor: Color): MarkdownThemeBuilder

    /**
     * 设置音频边框颜色
     *
     * @param audioBorderColor 音频边框颜色 - 默认0x33000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioBorderColor(audioBorderColor: Color): MarkdownThemeBuilder

    /**
     * 设置音频边框粗细
     *
     * @param audioBorderWidth 音频边框粗细 - 默认0.5vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioBorderWidth(audioBorderWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置音频边框圆角
     *
     * @param audioBorderRadius 音频边框圆角 - 默认12.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioBorderRadius(audioBorderRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置音频按钮背景颜色
     *
     * @param audioButtonBackgroundColor 音频按钮背景颜色- 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioButtonBackgroundColor(audioButtonBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置音频按钮文字颜色
     *
     * @param audioButtonTextColor 音频按钮文字颜色 - 默认Color.WHITE
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioButtonTextColor(audioButtonTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置音频按钮文字大小
     *
     * @param audioButtonTextSize 音频按钮文字大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioButtonTextSize(audioButtonTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置音频按钮文字内容
     *
     * @param audioButtonText 音频按钮文字内容 - 默认"立即播放"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioButtonText(audioButtonText: String): MarkdownThemeBuilder

    /**
     * 设置音频按钮圆角
     *
     * @param audioButtonBorderRadius 音频按钮圆角 - 默认16.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioButtonBorderRadius(audioButtonBorderRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置音频标题文字大小
     *
     * @param audioTitleTextSize 音频标题文字大小 - 默认15.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioTitleTextSize(audioTitleTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置音频标题文字颜色
     *
     * @param audioTitleTextColor音频标题文字颜色 - 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioTitleTextColor(audioTitleTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置音频标题文字行高
     *
     * @param audioTitleTextLineHeight 音频标题文字行高 - 默认20.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioTitleTextLineHeight(audioTitleTextLineHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置音频类型文字大小
     *
     * @param audioTypeTextSize 音频类型文字大小 - 默认11.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioTypeTextSize(audioTypeTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置音频类型文字颜色
     *
     * @param audioTypeTextColor 音频类型文字颜色 - 默认0X80000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioTypeTextColor(audioTypeTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置音频类型文字行高
     *
     * @param audioTypeTextLineHeight 音频类型文字行高 - 默认15.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioTypeTextLineHeight(audioTypeTextLineHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置音频上边距
     *
     * @param audioMarginTop 音频上边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioMarginTop(audioMarginTop: Float64): MarkdownThemeBuilder

    /**
     * 设置音频下边距
     *
     * @param audioMarginBottom 音频下边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioMarginBottom(audioMarginBottom: Float64): MarkdownThemeBuilder

    /**
     * 设置视频默认占位图
     *
     * @param videoImage 视频默认占位图 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoImage(videoImage: AppResource): MarkdownThemeBuilder

    /**
     * 设置视频播放按钮默认图标
     *
     * @param playCircleFillIcon 视频播放按钮默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setPlayCircleFillIcon(playCircleFillIcon: AppResource): MarkdownThemeBuilder

    /**
     * 设置视频圆角
     *
     * @param videoBorderRadius 视频圆角 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoBorderRadius(videoBorderRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置视频时间文本颜色
     *
     * @param videoTimeTextColor 视频时间文本颜色 - 默认Color.WHITE
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoTimeTextColor(videoTimeTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置视频时间文本大小
     *
     * @param videoTimeTextSize 视频时间文本大小 - 默认14.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoTimeTextSize(videoTimeTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置视频时间文本居右边距
     *
     * @param videoTimeTextMarginRight 视频时间文本居右边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoTimeTextMarginRight(videoTimeTextMarginRight: Float64): MarkdownThemeBuilder

    /**
     * 设置视频时间文本居底边距
     *
     * @param videoTimeTextMarginBottom 视频时间文本居底边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoTimeTextMarginBottom(videoTimeTextMarginBottom: Float64): MarkdownThemeBuilder

    /**
     * 设置视频上边距
     *
     * @param videoMarginTop 视频上边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoMarginTop(videoMarginTop: Float64): MarkdownThemeBuilder

    /**
     * 设置视频下边距
     *
     * @param videoMarginBottom 视频下边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoMarginBottom(videoMarginBottom: Float64): MarkdownThemeBuilder

    /**
     * 设置图片banner默认占位图
     *
     * @param bannerImage 图片banner占位图 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBannerImage(bannerImage: AppResource): MarkdownThemeBuilder

    /**
     * 设置图片基于自身宽度缩放百分比
     *
     * @param imageMaximumWidth 图片基于自身宽度缩放百分比 - 默认1.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageMaximumWidth(imageMaximumWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置图片基于父布局宽度缩放百分比
     *
     * @param imageFixedRatioWidth 图片基于父布局宽度缩放百分比 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageFixedRatioWidth(imageFixedRatioWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置图片圆角
     *
     * @param imageBorderRadius 图片圆角 - 默认0.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageBorderRadius(imageBorderRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置图片缩放类型
     *
     * @param imageFitType 图片缩放类型 - 默认ImageFit.Contain
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageFitType(imageFitType: ImageFit): MarkdownThemeBuilder

    /**
     * 设置图片默认占位图
     *
     * @param imageResource 图片默认占位图 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageResource(imageResource: AppResource): MarkdownThemeBuilder

    /**
     * 设置网络图片是否压缩
     *
     * @param isAutoResize 网络图片是否压缩 - true：压缩；false：不压缩。默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsAutoResize(isAutoResize: Bool): MarkdownThemeBuilder

    /**
     * 设置图片上边距
     *
     * @param imageMarginTop 图片上边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageMarginTop(imageMarginTop: Float64): MarkdownThemeBuilder

    /**
     * 设置图片下边距
     *
     * @param imageMarginBottom 图片下边距 - 默认10.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageMarginBottom(imageMarginBottom: Float64): MarkdownThemeBuilder

    /**
     * 设置表格内容内边距
     *
     * @param tableCellPadding 表格内容内边距 - 默认4.0vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableCellPadding(tableCellPadding: Float64): MarkdownThemeBuilder

    /**
     * 设置表格边框颜色
     *
     * @param tableBorderColor 表格边框颜色 - 默认0XFF000000
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableBorderColor(tableBorderColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格边框宽度
     *
     * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableBorderWidth(tableBorderWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置表格奇数行背景色
     *
     * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0XFFFFFFFF
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableOddRowBackgroundColor(tableOddRowBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格偶数行背景色
     *
     * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0XFFE0E0E0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格头背景色
     *
     * @param tableHeaderRowBackgroundColor 表格头背景色 - 默认0XFFFFFFFF
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格文本行高
     *
     * @param tableTextLineHeight 表格文本行高 - 默认22.0vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableTextLineHeight(tableTextLineHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置表格圆角
     *
     * @param tableRadius 表格圆角 - 默认5.0vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableRadius(tableRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置表格最小宽度
     *
     * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableMinTextWidth(tableMinTextWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置表格最大宽度
     *
     * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableMaxTextWidth(tableMaxTextWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置表格第一列是否加粗
     *
     * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableFirstColumnBold(tableFirstColumnBold: Bool): MarkdownThemeBuilder

    /**
     * 设置markdown代码高亮样式
     *
     * @param PrismTheme markdown代码高亮样式 - 默认PrismThemeDarkula.create()
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setPrismTheme(prismTheme: PrismTheme): MarkdownThemeBuilder

    /**
     * 设置删除线颜色
     *
     * @param strikethroughColor 删除线颜色 默认0XFF191919
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setStrikethroughColor(strikethroughColor: Color): MarkdownThemeBuilder

    /**
     * 设置定义列表术语和定义行之间间距
     *
     * @param descListTermAndDefMargins 定义列表术语和定义行之间间距 默认8.0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setDescListTermAndDefMargins(descListTermAndDefMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置定义列表定义行缩进
     *
     * @param descListDefIndentation 定义列表定义行缩进 默认8.0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setDescListDefIndentation(descListDefIndentation: Float64): MarkdownThemeBuilder

    /**
     * 设置定义列表定义行间距
     *
     * @param descListDefMargins 定义列表定义行间距 默认8.0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setDescListDefMargins(descListDefMargins: Float64): MarkdownThemeBuilder

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

### class PrismThemeBase

主题抽象基类

```cangjie
/**
 * prism 主题抽象基类
 */
public abstract open class PrismThemeBase <: PrismTheme {
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

### class PrismColor

围栏代码块高亮枚举类

```cangjie
/**
 * 围栏代码块高亮枚举类
 */
public enum PrismColor <: Hashable & Equatable<PrismColor> {
    COMMENT | // 注释内容
    PROLOG | // Prolog 语言中的特定语法结构（如谓词定义）
    DOCTYPE | // 文档类型声明: 如 HTML 的 <!DOCTYPE html>
    CDATA | // XML/HTML 中的字符数据块，用于包裹无需解析的原始文本
    PUNCTUATION | // 标点符号
    PROPERTY | // CSS/SCSS 中的属性名
    TAG | // HTML/XML 标签
    BOOLEAN | // 布尔值（true/false）
    NUMBER | // 数值内容
    CONSTANT | // 常量
    SYMBOL | // 符号或特殊符号
    DELETED | // 版本控制差异中标记为删除的代码行或片段
    SELECTOR | // CSS/SCSS 选择器
    ATTR_NAME | // HTML/XML 属性的名称
    STRING | // 单引号或双引号包裹的内容
    CHAR | // 字符字面量，如 char c = 'A'
    BUILTIN | // 语言内置的函数或类型
    INSERTED | // 版本控制差异中标记为新增的代码行或片段
    OPERATOR | // 运算符
    URL | // 代码中的 URL 字符串
    ENTITY | // HTML/XML 实体
    ATRULE | // CSS 预处理器
    ATTR_VALUE | // HTML/XML 属性的值
    KEYWORD | // 语言的关键字
    FUNCTION | // 函数名或方法名
    CLASS_NAME | // 类名
    REGEX | // 正则表达式模式
    IMPORTANT | // CSS 中的 !important 关键字
    VARIABLE | // 变量名
    DELIMITER | // 代码中的分隔符号
    ANNOTATION | // 代码中的注解或装饰性标记
    ESCAPE_SEQ | // 转义序列
    GENERIC_METHOD | // 泛型方法声明
    PSEUDO_ELEMENT | // CSS 伪元素
    PSEUDO_CLASS | // CSS 伪类
    CLASS | // HTML/CSS/TypeScript 等的类名
    ID | // CSS 中的 ID 选择器
    ATTRIBUTE | // 属性名称(如 HTML 的 id="main" 或 XML 的 attr="value")
    HEXCODE | // 十六进制颜色值
    COMMAND | // 命令行工具指令
    PARAMETER | // 函数或方法的参数名
    COORD | // 坐标数值，SVG/XML 或图形处理代码
    COMMIT_SHA1 | // 版本控制中的提交哈希值
    SPOCK_BLOCK | // Groovy 的 Spock 测试框架中的测试块
    NULL | // 空值标识
    NAMESPACE | // 命名空间
    SHEBANG | // 脚本文件开头的 #! 行
    DEFAULT // 其它值

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

解析和呈现markdown

```cangjie
/**
 * 解析和呈现markdown
 */
public abstract class Markdown {
    /**
     * 创建一个 Markdown 实例，并注册 CorePlugin 插件
     */
    public static func create(): Markdown

    /**
     * 创建一个 MarkdownBuilder 实例, 并注册 CorePlugin 插件
     */
    public static func builder(): MarkdownBuilder

    /**
     * 创建一个 MarkdownBuilder 实例，未注册插件
     */
    public static func builderNoCore(): MarkdownBuilder

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

markdown生成器

```cangjie
/**
 * markdown生成器
 */
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
    public var blockQuote: Bool = false
    /* 是否被Emphasis修饰 */
    public var emphasis: Bool = false
    /* 是否被StrongEmphasis修饰 */
    public var strongEmphasis: Bool = false
    /* 是否被Link修饰 */
    public var link: ?Link = None
    /* 是否属于BulletList */
    public var bulletList: Bool = false
    /* 属于第几层OrderedListItem -1:无效 >=0:深度 */
    public var depth: Int = -1
    /* 属于第几位OrderedListItem -1:无效 >=0:序号 */
    public var order: Int = -1
    public var orderedList: ?Int = None
    /* 属于第几层BulletListItem -1:无效 >=0:深度 */
    public var bulletListDepth: Int = -1
    /* ListItem中可包含多个Block，但只有第一个Block有列表符号 */
    public var listMark: Bool = false
    // 本身Node节点
    public var node: Node
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

### Markdown音频插件

```cangjie
public class BlockAudioPlugin <: AbstractMarkdownPlugin {
    public static func create(): BlockAudioPlugin
}
```

### Markdown节点唯一ID插件 - 流式输入显示前置条件 - 插件需要放在最后加载

```cangjie
public class NodeIdPlugin <: AbstractMarkdownPlugin {
    public static func create(): NodeIdPlugin
}
```

### Markdown视频插件

```cangjie
public class BlockVideoPlugin <: AbstractMarkdownPlugin {
    public static func create(): BlockVideoPlugin
}
```

### Markdown代码列表插件

```cangjie
public class CodeListPlugin <: AbstractMarkdownPlugin {
    public static func create(): CodeListPlugin
}
```

### Markdown定义列表插件

```cangjie
public class DescListPlugin <: AbstractMarkdownPlugin {
    public static func create(): DescListPlugin
}
```

### Markdown脚注插件

```cangjie
public class FootnotePlugin <: AbstractMarkdownPlugin {
    public static func create(): FootnotePlugin
}
```

### MarkdownHTML插件

```cangjie
public class HtmlPlugin <: AbstractMarkdownPlugin {
    public static func create(): HtmlPlugin
}
```

### Markdown标题ID插件

```cangjie
public class IdHeadingPlugin <: AbstractMarkdownPlugin {
    public static func create(): IdHeadingPlugin
}
```

### Markdown图片URL全部添加到图片点击回调集合插件

```cangjie
public class ImageCollectPlugin <: AbstractMarkdownPlugin {
    public static func create(): ImageCollectPlugin
}
```

### Markdown图片Banner插件

```cangjie
public class ImageSlidePlugin <: AbstractMarkdownPlugin {
    public static func create(): ImageSlidePlugin
}
```

### Markdown图片Style插件

```cangjie
public class ImageStylePlugin <: AbstractMarkdownPlugin {
    public static func create(): ImageStylePlugin
}
```

### Markdown不图文混排插件 - 加载之后没有图文混排，图片单独一行

```cangjie
public class ImageTextMixPlugin <: AbstractMarkdownPlugin {
    public static func create(): ImageTextMixPlugin
}
```

### Markdown数学公式插件

```cangjie
public class LatexMathPluginV2 <: AbstractMarkdownPlugin {
    public static func create(): LatexMathPluginV2
}
```

### Markdown链接作为单独节点不解析插件 - 链接图片化前提条件

```cangjie
public class LinkViewPlugin <: AbstractMarkdownPlugin {
    public static func create(): LinkViewPlugin
}
```

### Markdown自动网址链接插件

```cangjie
public class LinkifyPlugin <: AbstractMarkdownPlugin {
    public static func create(): LinkifyPlugin
}
```

### Markdown删除线插件

```cangjie
public class StrikethroughPlugin <: AbstractMarkdownPlugin {
    public static func create(): StrikethroughPlugin
}
```

### Markdown表格插件

```cangjie
public class TablePlugin <: AbstractMarkdownPlugin {
    public static func create(): TablePlugin
}
```

### Markdown任务列表插件

```cangjie
public class TaskListPlugin <: AbstractMarkdownPlugin {
    public static func create(): TaskListPlugin
}
```

### Markdown TOC列表插件

```cangjie
public class TocPlugin <: AbstractMarkdownPlugin {
    public static func create(): TocPlugin
}
```

### Markdown全量文本对象

```cangjie
public class NodeViewStringBuilder <: ToString {
    /**
     * 提取纯文本
     * - 处理缩进
     * - 处理行内节点
     * - 处理行内节点间隔
     * - block: 尾插换行
     */
    public func toString(): String
}
```

