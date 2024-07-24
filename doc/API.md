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
    * @param mdStr 传入markdown文档内容
    */
    MarkdownComponent(mdStr: mdStr)

    /**
    * 初始化Markdown自定义控件
    *
    * @param mdStr 传入markdown文档内容
    * @param markdownConfiguration 传入markdown配置选项
    */
    MarkdownComponent(mdStr: mdStr, markdownConfiguration!: markdownConfiguration)
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
     * 设置markdown代码高亮样式
     *
     * @param PrismTheme 高亮样式
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setPrismTheme(prismTheme: PrismTheme): MarkdownConfigurationBuilder

    /**
     * 设置markdown表格样式
     *
     * @param tableTheme 表格样式
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableTheme(tableTheme: TableTheme): MarkdownConfigurationBuilder

    /**
     * 设置链接的点击事件
     *
     * @param linkCallback 链接点击回调接口
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setLinkCallback(linkCallback: (String) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置图片的点击事件
     *
     * @param imageCallback 图片点击回调接口
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setImageCallback(imageCallback: (String) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置视频的点击事件
     *
     * @param videoCallback 视频点击回调接口
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
     * @param codeCopyCallback 代码复制点击回调接口
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setCodeCopyCallback(codeCopyCallback: (String) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置代码全屏按钮的点击事件
     *
     * @param codeFullScreenCallback 点吗全屏点击回调接口
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setCodeFullScreenCallback(codeFullScreenCallback: (String, Option<String>) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置数学公式图片点击事件
     *
     * @param latexImageCallback 数学公式图片点击回调接口
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setLatexImageCallbackCallback(latexImageCallback: (Array<UInt8>, Length, Length) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置数学公式数据处理事件
     *
     * @param latexStrCallback 数学公式数据处理回调接口
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setLatexStrCallback(latexStrCallback: (String) -> String): MarkdownConfigurationBuilder

    /**
     * 设置TOC跳转指定位置
     *
     * @param tocIndexCallback TOC跳转指定位置接口
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTocIndexCallback(tocIndexCallback: (?Float64) -> Unit): MarkdownConfigurationBuilder

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
 * 0: 每个模块之间上下间距，上下文
 * 1：链接（连接颜色，是否显示链接下划线）
 * 2：块引用、有序列表、无序列表、任务列表、TOC列表（左边距，块引用左边线条宽度，块引用左边线条颜色，有序列表项的颜色，有序列表项的大小，无序列表项的颜色，无序列表项的大小，任务列表项的宽高）
 * 3：内联代码、缩进代码、围栏代码、组合代码（内联代码文本颜色，内联代码背景颜色，内联代码文本字体，内联代码文本大小，代码块系列（缩进代码、围栏代码、组合代码）文本颜色，代码块系列（缩进代码、围栏代码、组合代码）背景颜色，代码块系列（缩进代码、围栏代码、组合代码）左边距，代码块系列（缩进代码、围栏代码、组合代码）字体，代码块系列（缩进代码、围栏代码、组合代码）文本大小，是否显示代码全屏按钮，代码全屏按钮和代码复制按钮的宽高，代码全屏按钮默认图标，代码复制按钮默认图标，组合代码标题文本大小，组合代码标题选中文本颜色，组合代码标题未选中文本颜色，组合代码标题选中背景颜色，组合代码标题未选中背景颜色）
 * 4：标题（一级标题二级标题下划线高度，一级标题二级标题下划线颜色，标题文字字体，标题文字大小，标题文字颜色）
 * 5：段落（段落字体大小，段落字体颜色）
 * 6：分割线（分割线高度，分割线颜色）
 * 7：软换行（软换行是否换行）
 * 8：数学公式（数学公式文字大小，数学公式行距，数学公式背景色，数学公式字体颜色，数学公式图片格式，数学公式资源目录路径）
 * 9：视频（视频默认占位图，视频播放按钮默认图标）
 * 10：图片Banner（图片banner默认占位图）
 * 11：图片（图片宽度边距 - 计算屏幕宽度需要减去padding的宽度单位vp，图片默认占位图，图片是否压缩）
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
     * 设置上下文
     *
     * @param abilityContext 上下文
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAbilityContext(abilityContext: AbilityContext): MarkdownThemeBuilder

    /**
     * 设置每个模块之间上下间距
     *
     * @param blockTopAndBottomMargins 模块上下间距距离。默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockTopAndBottomMargins(blockTopAndBottomMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置链接颜色
     *
     * @param linkColor 链接的颜色。默认0x0000FF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkColor(linkColor: Color): MarkdownThemeBuilder

    /**
     * 设置是否显示链接下划线
     *
     * @param isLinkUnderlined 是否显示链接的下划线。true：显示链接下划线，false：不显示链接下划线。默认显示链接下划线
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsLinkUnderlined(isLinkUnderlined: Bool): MarkdownThemeBuilder

    /**
     * 设置有序列表、无序列表、任务列表、块引用左边距
     *
     * @param blockMargin 左边距。默认24.0
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
     * @param blockMargin 块引用左线条颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteColor(blockQuoteColor: Color): MarkdownThemeBuilder

    /**
     * 设置有序列表项的颜色
     *
     * @param blockMargin 有序列表项的颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListItemColor(orderedListItemColor: Color): MarkdownThemeBuilder

    /**
     * 设置有序列表项的字体大小
     *
     * @param orderedListItemSize 有序列表项的字体大小。默认14.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListItemSize(orderedListItemSize: Float64): MarkdownThemeBuilder

    /**
     * 设置无序列表项的颜色
     *
     * @param bulletListItemColor 无序列表项的颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListItemColor(bulletListItemColor: Color): MarkdownThemeBuilder

    /**
     * 设置无序列表项的字体大小
     *
     * @param bulletListItemSize 无序列表项的字体大小。默认14.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListItemSize(bulletListItemSize: Float64): MarkdownThemeBuilder

    /**
     * 设置任务列表项的宽高
     *
     * @param taskListItemLength 任务列表项的宽高。默认15.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTaskListItemLength(taskListItemLength: Float64): MarkdownThemeBuilder

    /**
     * 设置内联代码文本颜色
     *
     * @param codeTextColor 内联代码文本颜色。默认0x000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTextColor(codeTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置内联代码背景颜色
     *
     * @param codeBackgroundColor 内联代码背景颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBackgroundColor(codeBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置内联代码文本字体
     *
     * @param codeTypeface 内联代码文本字体。默认HarmonyOS Sans
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTypeface(codeTypeface: String): MarkdownThemeBuilder

    /**
     * 设置内联代码文本大小
     *
     * @param codeTextSize 内联代码文本大小。默认13.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTextSize(codeTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）文本颜色
     *
     * @param codeBlockTextColor 代码块系列文本颜色。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTextColor(codeBlockTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）背景颜色
     *
     * @param codeBlockBackgroundColor 代码块系列背景颜色。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockBackgroundColor(codeBlockBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）左边距
     *
     * @param codeMultilineMargin 代码块系列左边距。默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeMultilineMargin(codeMultilineMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）字体
     *
     * @param codeBlockTypeface 代码块系列字体。默认HarmonyOS Sans
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTypeface(codeBlockTypeface: String): MarkdownThemeBuilder

    /**
     * 设置代码块系列（缩进代码、围栏代码、组合代码）文本大小
     *
     * @param codeBlockTextSize 代码块系列文本大小。默认13.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTextSize(codeBlockTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置是否显示代码全屏按钮
     *
     * @param isCodeFullScreen 是否显示代码全屏按钮。true：显示代码全屏按钮，false：不显示代码全屏按钮。默认显示代码全屏按钮
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
     * @param codeFullScreenIcon 代码全屏按钮图标。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeFullScreenIcon(codeFullScreenIcon: CJResource): MarkdownThemeBuilder

    /**
     * 设置代码复制按钮默认图标
     *
     * @param codeCopyIcon 代码复制按钮图标。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeCopyIcon(codeCopyIcon: CJResource): MarkdownThemeBuilder

    /**
     * 设置组合代码标题字体大小
     *
     * @param codeListTitleTextSize 组合代码标题字体大小。默认13.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleTextSize(codeListTitleTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置组合代码标题选中文本颜色
     *
     * @param codeListTitleSelectTextColor 组合代码标题选中文本颜色。默认Color.RED
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleSelectTextColor(codeListTitleSelectTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置组合代码标题未选中文本颜色
     *
     * @param codeListTitleUnSelectTextColor 组合代码标题未选中文本颜色。默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleUnSelectTextColor(codeListTitleUnSelectTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置组合代码标题选中背景颜色
     *
     * @param codeListTitleSelectBackgroupColor 组合代码标题选中背景颜色。默认Color.GRAY
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleSelectBackgroupColor(codeListTitleSelectBackgroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置组合代码标题未选中背景颜色
     *
     * @param codeListTitleUnSelectBackgroupColor 组合代码标题未选中背景颜色。默认Color.TRANSPARENT
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeListTitleUnSelectBackgroupColor(codeListTitleUnSelectBackgroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置H1、H2标题下分割线高度
     *
     * @param headingBreakHeight H1、H2标题下分割线高度。默认0.5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBreakHeight(headingBreakHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置H1、H2标题下分割线颜色
     *
     * @param headingBreakColor H1、H2标题下分割线颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBreakColor(headingBreakColor: Color): MarkdownThemeBuilder

    /**
     * 设置标题元素字体
     *
     * @param headingTypeface 标题元素字体。默认HarmonyOS Sans
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTypeface(headingTypeface: String): MarkdownThemeBuilder

    /**
     * 设置标题文本大小数组
     *
     * @param headingTextSizeMultipliers 标题文本大小数组。默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<Float64>): MarkdownThemeBuilder

    /**
     * 设置标题字体颜色
     *
     * @param headingTextColor 标题字体颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextColor(headingTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置段落字体大小
     *
     * @param paragraphTextSize 段落字体大小。默认14.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextSize(paragraphTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置段落字体颜色
     *
     * @param paragraphTextColor 段落字体颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTextColor(paragraphTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置分割线颜色
     *
     * @param thematicBreakColor 分割线颜色。默认0x191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setThematicBreakColor(thematicBreakColor: Color): MarkdownThemeBuilder

    /**
     * 设置分割线高度
     *
     * @param thematicBreakHeight 分割线高度。默认0.5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setThematicBreakHeight(thematicBreakHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置软换行是否换行
     *
     * @param isLineBreak 软换行是否换行。true：软换行换行，false：软换行不换行。默认软换行不换行
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsLineBreak(isLineBreak: Bool): MarkdownThemeBuilder

    /**
     * 设置数学公式文字大小(px)
     *
     * @param latexMathTextSize 数学公式文字大小(px)。默认48.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTextSize(latexMathTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置数学公式行距
     *
     * @param latexMathTextLineSpacing 数学公式行距。默认10.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTextLineSpacing(latexMathTextLineSpacing: Float64): MarkdownThemeBuilder

    /**
     * 设置数学公式背景色
     *
     * @param latexMathBackGroupColor 数学公式背景色。默认0x00FFFFFF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathBackGroupColor(latexMathBackGroupColor: Color): MarkdownThemeBuilder

    /**
     * 设置数学公式字体颜色
     *
     * @param latexMathTextColor 数学公式字体颜色。默认0xFF000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTextColor(latexMathTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置数学公式生成图片格式
     *
     * @param latexMathColorFormat 数学公式生成图片格式。默认LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathColorFormat(latexMathColorFormat: LatexMathColorFormat): MarkdownThemeBuilder

    /**
     * 设置数学公式资源路径
     *
     * @param resPath 数学公式资源路径。默认"/data/storage/el1/bundle/entry/resources/resfile/res"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setResPath(resPath: String): MarkdownThemeBuilder

    /**
     * 设置视频默认占位图
     *
     * @param videoImage 视频默认占位图。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoImage(videoImage: CJResource): MarkdownThemeBuilder

    /**
     * 设置视频播放按钮默认图标
     *
     * @param playCircleFillIcon 视频播放按钮图标。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setPlayCircleFillIcon(playCircleFillIcon: CJResource): MarkdownThemeBuilder

    /**
     * 设置图片banner默认占位图
     *
     * @param bannerImage 图片banner占位图。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBannerImage(bannerImage: CJResource): MarkdownThemeBuilder

    /**
     * 设置图片宽度边距 - 计算屏幕宽度需要减去padding的宽度，单位vp
     *
     * @param imagePadding 图片宽度边距。默认40vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImagePadding(imagePadding: Int64): MarkdownThemeBuilder

    /**
     * 设置图片默认占位图
     *
     * @param imageResource 图片占位图。默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageResource(imageResource: CJResource): MarkdownThemeBuilder

    /**
     * 设置是否压缩图片
     *
     * @param isAutoResize 是否压缩图片。true：压缩，false：不压缩。默认压缩
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsAutoResize(isAutoResize: Bool): MarkdownThemeBuilder

    /**
     * 返回Theme对象
     *
     * @return MarkdownTheme MarkdownTheme对象
     */
    public func build(): MarkdownTheme
}
```

## 代码高亮配置类

### class PrismSyntaxHighlight

句法高亮类

```cangjie
public class PrismSyntaxHighlight {
    /**
     * 根据 prism 对象和主题生成句法高亮类
     *
     * @param prism 预定义的 prism 类对象
     * @param theme 预定义主题
     * @return PrismSyntaxHighlight 返回句法高亮类对象
     */
    public static func create(prism: Prism, theme: PrismTheme): PrismSyntaxHighlight

    /**
     * 代码高亮方法
     *
     * @param info 代码语言
     * @param code 代码
     * @return ArrayList<PrismNodesParseRes> 返回通过 prism 库解析后的结果集
     */
    public func highlight(info: ?String, code: String): ArrayList<PrismNodesParseRes>
}
```

### class PrismNodesParseRes

prism解析node处理后的结果对象

```cangjie
public class PrismNodesParseRes {
    /**
     * 转换字符串方法
     *
     * @return String 打印的String
     */
    public func toString(): String
}
```

### interface PrismTheme

高亮主题接口

```cangjie
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
     * @return HashMap<String, Color> 返回颜色存储集合
     */
    func getColorMap(): HashMap<String, Color>

    /**
     * 自定义设置字段颜色存储集合
     *
     * @param HashMap<String, Color> 颜色存储集合
     */
    func setColorMap(colorMap: HashMap<String, Color>): Unit
}
```

### class PrismThemeDefault

高亮默认主题(白色主题)

```cangjie
public class PrismThemeDefault {
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
     * @return HashMap<String, Color> 返回颜色存储集合
     */
    public override open func getColorMap(): HashMap<String, Color>

    /**
     * 自定义设置颜色存储集合
     *
     * @param HashMap<String, Color> 颜色存储集合
     */
    public override open func setColorMap(colorMap: HashMap<String, Color>): Unit
}
```

### class PrismThemeDarkula

高亮暗黑主题(黑色主题)

```cangjie
public class PrismThemeDarkula {
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
     * @return HashMap<String, Color> 返回颜色存储集合
     */
    public override open func getColorMap(): HashMap<String, Color>

    /**
     * 自定义设置颜色存储集合
     *
     * @param HashMap<String, Color> 颜色存储集合
     */
    public override open func setColorMap(colorMap: HashMap<String, Color>): Unit
}
```

### class ColorHashMap

默认主题代码颜色值存储集合

```cangjie
public class ColorHashMap {
    /**
     * ColorHashmap 构造函数
     *
     * @param map 默认或是自定义的 colorMap
     */
    public init(map: HashMap<String, Color>)

    /**
     * 获取 colormap 属性
     *
     * @return HashMap<String, Color> 获取colormap
     */
    public func getColorMap(): HashMap<String, Color>
}
```

## 表格样式配置类

### TableTheme

表格主题类

```cangjie
public class TableTheme {
    /**
     * 创建Theme对象
     *
     * @return 返回表格主题对象
     */
    public static func create(): TableTheme

    /**
     * 创建一个空的builder对象
     *
     * @return 返回空的 TableThemeBuilder 表格构建对象
     */
    public static func emptyBuilder(): TableThemeBuilder

    /**
     * 创建一个带有默认值的builder对象
     *
     * @return 返回 TableThemeBuilder 表格构建对象
     */
    public func asBuilder(): TableThemeBuilder
}
```

### TableThemeBuilder

表格主题构建类

```cangjie
public class TableThemeBuilder {
    /**
     * 设置表格内容内边距
     *
     * @param tableCellPadding 表格内容内边距
     * @return 返回 TableThemeBuilder 表格构建对象
     */
    public func setTableCellPadding(tableCellPadding: Float64): TableThemeBuilder

    /**
     * 设置表格边框颜色
     *
     * @param tableBorderColor 表格边框颜色
     * @return 返回 TableThemeBuilder 表格构建对象
     */
    public func setTableBorderColor(tableBorderColor: Color): TableThemeBuilder

    /**
     * 设置表格边框宽度
     *
     * @param tableBorderWidth 表格边框宽度
     * @return 返回 TableThemeBuilder 表格构建对象
     */
    public func setTableBorderWidth(tableBorderWidth: Float64): TableThemeBuilder

    /**
     * 设置表格奇数行背景色
     *
     * @param tableOddRowBackgroundColor 表格奇数行背景色
     * @return 返回 TableThemeBuilder 表格构建对象
     */
    public func setTableOddRowBackgroundColor(tableOddRowBackgroundColor: Color): TableThemeBuilder

    /**
     * 设置表格偶数行背景色
     *
     * @param tableEvenRowBackgroundColor 表格偶数行背景色
     * @return 返回 TableThemeBuilder 表格构建对象
     */
    public func setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: Color): TableThemeBuilder

    /**
     * 设置表格头背景色
     *
     * @param tableHeaderRowBackgroundColor 表格头背景色
     * @return 返回 TableThemeBuilder 表格构建对象
     */
    public func setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: Color): TableThemeBuilder

    /**
     * 构建 TableTheme 实例
     */
    public func build(): TableTheme
}
```
