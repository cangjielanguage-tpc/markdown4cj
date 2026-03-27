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
    * @param isInputEnded 流式输入是否输入结束(true:结束输入,false:持续输入)
    * @param incrementalAnalysis markdown是否增量解析(true:增量解析,false:全量解析)
    * @param markdownConfiguration 传入markdown配置选项
    * @param markdownPlugin 传入markdown插件
    * @param adBuilder 传入广告布局
    * @param videoBuilder 传入视频布局
    * @param audioBuilder 传入音频布局
    * @param customBlockBuilder 传入自定义块结构布局
    * @param customHeadingLineBuilder 传入自定义标题行内布局
    * @param customParagraphLineBuilder 传入自定义段落行内布局
    * @param customTableLineBuilder 传入自定义表格行内布局
    * @param scroller list控制器
    */
    MarkdownComponent(
        output: String,
        isInputEnded: Bool,
        incrementalAnalysis: Bool,
        markdownConfiguration!: MarkdownConfiguration,
        markdownPlugin!: Markdown,
        @BuilderParam adBuilder!: (NodeView) -> Unit,
        @BuilderParam videoBuilder!: (NodeView, MarkdownTheme, (String) -> Unit, (String, (String, Float64, Int64) -> Unit) -> Unit, ?(String) -> Unit, ?(String) -> Unit) -> Unit,
        @BuilderParam audioBuilder!: (NodeView, MarkdownTheme, ?(String) -> Unit) -> Unit,
        @BuilderParam customBlockBuilder!: (NodeView, Int64) -> Unit,
        @BuilderParam customHeadingLineBuilder!: (NodeView, Int64) -> Unit,
        @BuilderParam customParagraphLineBuilder!: (NodeView, Int64) -> Unit,
        @BuilderParam customTableLineBuilder!: (NodeView, Int64) -> Unit,
        scroller: Scroller
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
     * 设置图片下载的点击事件
     *
     * @param imageDownloadCallback 图片下载的点击事件
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setImageDownloadCallback(imageDownloadCallback: (String) -> Unit): MarkdownConfigurationBuilder

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
     * 设置视频发布的点击事件
     *
     * @param videoReleaseCallback 视频发布的点击事件 (String:视频链接)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setVideoReleaseCallback(videoReleaseCallback: (String) -> Unit): MarkdownConfigurationBuilder

    /**
     * 设置视频下载的点击事件
     *
     * @param videoDownloadCallback 视频下载的点击事件 (String:视频链接)
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setVideoDownloadCallback(videoDownloadCallback: (String) -> Unit): MarkdownConfigurationBuilder

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

可设置接口总览

1. 上下文 - 本地图片rawfile需要上下文
    1. stageContext - 混合项目
    2. uiAbilityContext - 仓颉项目
2. 综合接口
   1. markdown是否同步解析
   2. 是否打开长按复制粘贴功能
   3. markdown第一个模块上边距
   4. markdown最后一个模块下边距
   5. 每个模块之间上下间距
3. 链接
   1. 链接是否图片显示 - 链接图标化
   2. 列表中的单行链接是否是图片显示
   3. 文本格式链接
      1. 文本格式链接文本颜色
      2. 是否按照链接文字字体大小显示文本
      3. 文本格式链接文字大小
      4. 文本格式链接文字行高
      5. 文本格式链接背景颜色
      6. 文本格式是否显示链接下划线
   4. 圆形图片格式链接
      1. 圆形图片格式链接主题背景颜色
      2. 圆形图片格式链接控件背景颜色
      3. 圆形图片格式链接文字大小
      4. 圆形图片格式链接文字颜色
      5. 圆形图片格式链接半径
      6. 圆形图片格式链接左右外边距
   5. 圆角矩形图片格式链接
      1. 圆角矩形图片格式链接主题背景颜色
      2. 圆角矩形图片格式链接控件背景颜色
      3. 圆角矩形图片格式链接文字大小
      4. 圆角矩形图片格式链接文字颜色
      5. 圆角矩形图片格式链接控件高度
      6. 圆角矩形图片格式链接左右内边距
      7. 圆角矩形图片格式链接圆角半径
      8. 圆角矩形图片格式链接左右外边距
   6. 空心圆角矩形图片格式链接
      1. 空心圆角矩形图片格式链接主题背景颜色
      2. 空心圆角矩形图片格式链接控件背景颜色
      3. 空心圆角矩形图片格式链接文字大小
      4. 空心圆角矩形图片格式链接控件高度
      5. 空心圆角矩形图片格式链接左右内边距
      6. 空心圆角矩形图片格式链接边框宽度
      7. 空心圆角矩形图片格式链接分割线宽度
      8. 空心圆角矩形图片格式链接左右外边距
      9. 空心圆角矩形图片格式分割线和文本左边距
      10. 空心圆角矩形图片格式分割线和文本右边距
4. 块引用
   1. 块引用左边距
   2. 块引用右边距
   3. 块引用左边线条宽度
   4. 块引用左边线条颜色
   5. 块引用背景颜色
   6. 块引用子模块上下间距
5. 有序/无序/任务列表
   1. 有序/无序/任务列表子模块上下间距
   2. 有序/无序/任务列表左边距
   3. 有序/无序/任务列表右边距
   4. 有序列表
      1. 有序列表前缀文本是否加粗
      2. 有序列表前缀文本颜色
      3. 有序列表前缀文本大小
      4. 有序列表前缀文本行高
   5. 无序列表
      1. 无序列表前缀是否全部是实心圆型
      2. 无序列表前缀文本颜色
      3. 无序列表前缀文本大小
      4. 无序列表前缀文本行高
   6. 任务列表
      1. 任务列表选择框宽高
6. 代码
   1. 内联代码
      1. 内联代码文本颜色
      2. 内联代码背景颜色
      3. 内联代码文本大小
      4. 内联代码文本字体
   2. 缩进/围栏/组合/单独代码块
      1. 是否格式化代码块内容
      2. 代码高亮是否同步解析
      3. 缩进/围栏/组合/单独代码块代码文本颜色
      4. 缩进/围栏/组合/单独代码块代码类型文本颜色
      5. 缩进/围栏/组合/单独代码块代码类型文本
      6. 缩进/围栏/组合/单独代码块代码类型和代码块距离
      7. 缩进/围栏/组合/单独代码块代码复制/全屏文字是否显示
      8. 缩进/围栏/组合/单独代码块代码行号是否显示
      9. 缩进/围栏/组合/单独代码块背景颜色
      10. 缩进/围栏/组合/单独代码块左边距
      11. 缩进/围栏/组合/单独代码块右边距
      12. 缩进/围栏/组合/单独代码块字体
      13. 缩进/围栏/组合/单独代码块代码文本大小
      14. 缩进/围栏/组合/单独代码块代码文本行高
      15. 缩进/围栏/组合/单独代码块控件圆角大小
      16. 缩进/围栏/组合/单独代码块代码全屏按钮是否显示
      17. 缩进/围栏/组合/单独代码块代码全屏/复制按钮宽高
      18. 缩进/围栏/组合/单独代码块代码全屏按钮默认图标
      19. 缩进/围栏/组合/单独代码块代码复制按钮默认图标
      20. 组合代码块
          1. 组合代码块未选中标题字体大小
          2. 组合代码块选中标题字体大小
          3. 组合代码块选中标题文本颜色
          4. 组合代码块未选中标题文本颜色
          5. 组合代码块选中标题背景颜色
          6. 组合代码块未选中标题背景颜色
      21. 单独代码块
          1. 是否单独代码块显示
          2. 单独代码块行号宽度
          3. 单独代码块是否居底显示
7. 标题
   1. H1和H2标题下分割线高度
   2. H1标题下分割线颜色
   3. H2标题下分割线颜色
   4. 标题文本字体
   5. 标题文本字间距
   6. 标题模块上间距
   7. 标题模块下间距
   8. H1标题文本大小
   9. H2标题文本大小
   10. H3标题文本大小
   11. H4标题文本大小
   12. H5标题文本大小
   13. H6标题文本大小
   14. H1标题文本颜色
   15. H2标题文本颜色
   16. H3标题文本颜色
   17. H4标题文本颜色
   18. H5标题文本颜色
   19. H6标题文本颜色
   20. H1标题文本行高
   21. H2标题文本行高
   22. H3标题文本行高
   23. H4标题文本行高
   24. H5标题文本行高
   25. H6标题文本行高
8. 段落
   1. 段落模块上间距
   2. 段落模块下间距
   3. 段落文本大小
   4. 段落文本颜色
   5. 段落文本字间距
   6. 段落文本行高
   7. 段落文本字体
9. 分割线
   1. 分割线颜色
   2. 分割线高度
   3. 分割线额外上部外边距
   4. 分割线额外下部外边距
10. 软换行
    1. 软换行是否换行
11. 数学公式
    1. 数学公式未加载状态是否显示文字
    2. 数学公式文本大小
    3. 数学公式背景色
    4. 数学公式文本颜色
    5. 数学公式生成图片格式
    6. 块结构的数学公式是否居中
    7. 数学公式字体路径
12. 音频
    1. 音频图标
    2. 音频阴影颜色值
    3. 音频边框颜色
    4. 音频边框粗细
    5. 音频边框圆角
    6. 音频按钮背景颜色
    7. 音频按钮文字颜色
    8. 音频按钮文字大小
    9. 音频按钮文字内容
    10. 音频按钮圆角大小
    11. 音频标题文字大小
    12. 音频标题文字颜色
    13. 音频标题文字行高
    14. 音频类型文字大小
    15. 音频类型文字颜色
    16. 音频类型文字行高
    17. 音频上边距
    18. 音频下边距
13. 视频
    1. 视频默认占位图
    2. 视频播放按钮默认图标
    3. 视频发布默认图标
    4. 视频下载默认图标
    5. 视频圆角大小
    6. 视频时间文本颜色
    7. 视频时间文本大小
    8. 视频时间文本居右边距
    9. 视频时间文本居底边距
    10. 视频上边距
    11. 视频下边距
    12. 视频发布/下载按钮布局是否显示
    13. 视频发布按钮图片宽度和高度
    14. 视频发布按钮宽度
    15. 视频发布按钮高度
    16. 视频发布按钮圆角
    17. 视频发布按钮文本内容
    18. 视频发布按钮文本大小
    19. 视频发布按钮文本颜色
    20. 视频发布按钮背景颜色
    21. 视频下载按钮图片宽度和高度
    22. 视频下载按钮宽度
    23. 视频下载按钮高度
    24. 视频下载按钮圆角
    25. 视频下载按钮文本内容
    26. 视频下载按钮文本大小
    27. 视频下载按钮文本颜色
    28. 视频下载按钮背景颜色
14. 图片banner
    1. 图片banner默认占位图
15. 图片
    1. 是否图文混排
    2. 图片基于自身宽度缩放百分比
    3. 图片基于父布局宽度缩放百分比
    4. 图片最大高度
    5. 图片最大宽度
    6. 图片圆角大小
    7. 图片边框宽度
    8. 图片边框颜色
    9. 图片缩放类型
    10. 图片默认占位图
    11. 网络图片是否压缩
    12. 图片上边距
    13. 图片下边距
    14. 图片是否有下载按钮
    15. 图片下载默认图标
    16. 图片下载按钮图片宽度和高度
    17. 图片下载按钮宽度
    18. 图片下载按钮高度
    19. 图片下载按钮圆角
    20. 图片下载按钮文本内容
    21. 图片下载按钮文本大小
    22. 图片下载按钮文本颜色
    23. 图片下载按钮背景颜色
16. 表格
    1. 表格内容内边距
    2. 表格边框颜色
    3. 表格边框宽度
    4. 表格奇数行背景色
    5. 表格偶数行背景色
    6. 表格标题背景色
    7. 表格标题文本大小
    8. 表格标题行高
    9. 表格内容文本颜色
    10. 表格内容文本大小
    11. 表格内容文本行高
    12. 表格圆角大小
    13. 表格一格最小宽度
    14. 表格一格最大宽度
    15. 表格第一列是否加粗
    16. 表格是否显示滚动条
    17. 表格滚动条颜色
17. 代码块高亮
    1. markdown代码高亮样式
18. 删除线
    1. 删除线颜色
    2. 删除线样式
19. 定义列表
    1. 定义列表术语和定义行之间间距
    2. 定义列表定义行缩进
    3. 定义列表定义行间距
20. 下标
    1. 下标字体颜色
    2. 下标字体大小
    3. 下标偏移距离
21. 上标
    1. 上标字体颜色
    2. 上标字体大小
    3. 上标偏移距离
22. 下划线
    1. 下划线颜色
    2. 下划线样式

```cangjie
/**
 * Markdown用户可设置的样式
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
     * 设置markdown是否同步解析
     *
     * @param isMarkdownParserSync markdown是否同步解析 - 默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsMarkdownParserSync(isMarkdownParserSync: Bool): MarkdownThemeBuilder

    /**
     * 设置是否打开长按复制粘贴
     *
     * @param isOnCopy 是否打开长按复制粘贴 - 默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsOnCopy(isOnCopy: Bool): MarkdownThemeBuilder

    /**
     * 设置markdown第一个模块上边距
     *
     * @param blockFirstTopMargin markdown第一个模块上边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockFirstTopMargin(blockFirstTopMargin: Float64): MarkdownThemeBuilder

    /**
     * 设置markdown最后一个模块下边距
     *
     * @param blockLastBottomMargin markdown最后一个模块下边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockLastBottomMargin(blockLastBottomMargin: Float64): MarkdownThemeBuilder

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
     * 设置文本格式链接文字行高
     *
     * @param linkLineHeight 文本格式链接文字行高
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkLineHeight(linkLineHeight: Float64): MarkdownThemeBuilder

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
     * 设置是否格式化代码块内容
     *
     * @param isCodeFormat 是否格式化代码块内容 - true：格式化代码块；false：不格式化代码块。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsCodeFormat(isCodeFormat: Bool): MarkdownThemeBuilder

    /**
     * 设置内联代码文本颜色
     *
     * @param codeTextColor 内联代码文本颜色 - 默认OXFF000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTextColor(codeTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置内联代码背景颜色
     *
     * @param codeBackgroundColor 内联代码背景颜色 - 默认OXFFEAEAEA
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBackgroundColor(codeBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置内联代码文本大小
     *
     * @param codeTextSize 内联代码文本大小 - 默认13.0fp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTextSize(codeTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置内联代码文本字体
     *
     * @param codeTypeface内联代码文本字体 - 默认"HarmonyOS Sans"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeTypeface(codeTypeface: String): MarkdownThemeBuilder

    /**
     * 设置围栏代码块代码高亮是否同步解析
     *
     * @param isCodeBlockParserSync 围栏代码块代码高亮是否同步解析 - 默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsCodeBlockParserSync(isCodeBlockParserSync: Bool): MarkdownThemeBuilder

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
     * 设置代码块右边距
     *
     * @param codeMultilineRightMargin 代码块右边距 - 默认8.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeMultilineRightMargin(codeMultilineRightMargin: Float64): MarkdownThemeBuilder

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
     * 设置一级标题文本大小
     *
     * @param headingTextSize1 一级标题文本大小 - 默认20.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextSize1(headingTextSize1: Float64): MarkdownThemeBuilder

    /**
     * 设置二级标题文本大小
     *
     * @param headingTextSize2 二级标题文本大小 - 默认17.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextSize2(headingTextSize2: Float64): MarkdownThemeBuilder

    /**
     * 设置三级标题文本大小
     *
     * @param headingTextSize3 三级标题文本大小 - 默认16.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextSize3(headingTextSize3: Float64): MarkdownThemeBuilder

    /**
     * 设置四级标题文本大小
     *
     * @param headingTextSize4 四级标题文本大小 - 默认15.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextSize4(headingTextSize4: Float64): MarkdownThemeBuilder

    /**
     * 设置五级标题文本大小
     *
     * @param headingTextSize5 五级标题文本大小 - 默认15.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextSize5(headingTextSize5: Float64): MarkdownThemeBuilder

    /**
     * 设置六级标题文本大小
     *
     * @param headingTextSize6 六级标题文本大小 - 默认13.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextSize6(headingTextSize6: Float64): MarkdownThemeBuilder

    /**
     * 设置一级标题文本颜色
     *
     * @param headingTextColor1 一级标题文本颜色
     */
    public func setHeadingTextColor1(headingTextColor1: Color): MarkdownThemeBuilder

    /**
     * 设置H1标题下分割线颜色
     *
     * @param headingBreakColor H1标题下分割线颜色 - 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBreakColor1(headingBreakColor1: Color): MarkdownThemeBuilder

    /**
     * 设置二级标题文本颜色
     *
     * @param headingTextColor2 二级标题文本颜色
     */
    public func setHeadingTextColor2(headingTextColor2: Color): MarkdownThemeBuilder

    /**
     * 设置H2标题下分割线颜色
     *
     * @param headingBreakColor2 H1、H2标题下分割线颜色 - 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBreakColor2(headingBreakColor2: Color): MarkdownThemeBuilder

    /**
     * 设置三级标题文本颜色
     *
     * @param headingTextColor3 三级标题文本颜色
     */
    public func setHeadingTextColor3(headingTextColor3: Color): MarkdownThemeBuilder

    /**
     * 设置四级标题文本颜色
     *
     * @param headingTextColor4 四级标题文本颜色
     */
    public func setHeadingTextColor4(headingTextColor4: Color): MarkdownThemeBuilder

    /**
     * 设置五级标题文本颜色
     *
     * @param headingTextColor5 五级标题文本颜色
     */
    public func setHeadingTextColor5(headingTextColor5: Color): MarkdownThemeBuilder

    /**
     * 设置六级标题文本颜色
     *
     * @param headingTextColor6 六级标题文本颜色
     */
    public func setHeadingTextColor6(headingTextColor6: Color): MarkdownThemeBuilder

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
     * 设置视频发布默认图标
     *
     * @param videoReleaseImage 视频发布默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoReleaseImage(videoReleaseImage: AppResource): MarkdownThemeBuilder

    /**
     * 设置视频下载默认图标
     *
     * @param videoDownloadImage 视频下载默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoDownloadImage(videoDownloadImage: AppResource): MarkdownThemeBuilder

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
     * 设置视频发布/下载按钮布局是否显示
     *
     * @param isVideoBottomLayout 视频发布/下载按钮布局是否显示 - 默false不显示
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsVideoBottomLayout(isVideoBottomLayout: Bool): MarkdownThemeBuilder

    /**
     * 设置视频发布按钮图片宽度和高度
     *
     * @param videoReleaseImageWidthHeight 视频发布按钮图片宽度和高度 - 默认18.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoReleaseImageWidthHeight(videoReleaseImageWidthHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置视频发布按钮宽度
     *
     * @param videoReleaseWidth 视频发布按钮宽度 - 默认144.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoReleaseWidth(videoReleaseWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置视频发布按钮高度
     *
     * @param videoReleaseHeight 视频发布按钮高度 - 默认44.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoReleaseHeight(videoReleaseHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置视频发布按钮圆角
     *
     * @param videoReleaseRadius 视频发布按钮圆角 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoReleaseRadius(videoReleaseRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置视频发布按钮文本内容
     *
     * @param videoReleaseText 视频发布按钮文本内容 - 默认"发布视频"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoReleaseText(videoReleaseText: String): MarkdownThemeBuilder

    /**
     * 设置视频发布按钮文本大小
     *
     * @param videoReleaseTexSize 视频发布按钮文本大小 - 默认16.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoReleaseTexSize(videoReleaseTexSize: Float64): MarkdownThemeBuilder

    /**
     * 设置视频发布按钮文本颜色
     *
     * @param videoReleaseTexColor 视频发布按钮文本颜色 - 默认0xE6000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoReleaseTexColor(videoReleaseTexColor: Color): MarkdownThemeBuilder

    /**
     * 设置视频发布按钮背景颜色
     *
     * @param videoReleaseBackgroundColor 视频发布按钮背景颜色 - 默认0xFFF5F5F5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoReleaseBackgroundColor(videoReleaseBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置视频下载按钮图片宽度和高度
     *
     * @param videoDownloadImageWidthHeight 视频下载按钮图片宽度和高度 - 默认18.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoDownloadImageWidthHeight(videoDownloadImageWidthHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置视频下载按钮宽度
     *
     * @param videoDownloadWidth 视频下载按钮宽度 - 默认144.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoDownloadWidth(videoDownloadWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置视频下载按钮高度
     *
     * @param videoDownloadHeight 视频下载按钮高度 - 默认44.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoDownloadHeight(videoDownloadHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置视频下载按钮圆角
     *
     * @param videoDownloadRadius 视频下载按钮圆角 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoDownloadRadius(videoDownloadRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置视频下载按钮文本内容
     *
     * @param videoDownloadText 视频下载按钮文本内容 - 默认"下载视频"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoDownloadText(videoDownloadText: String): MarkdownThemeBuilder

    /**
     * 设置视频下载按钮文本大小
     *
     * @param videoDownloadTexSize 视频下载按钮文本大小 - 默认16.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoDownloadTexSize(videoDownloadTexSize: Float64): MarkdownThemeBuilder

    /**
     * 设置视频下载按钮文本颜色
     *
     * @param videoDownloadTexColor 视频下载按钮文本颜色 - 默认0xE6000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoDownloadTexColor(videoDownloadTexColor: Color): MarkdownThemeBuilder

    /**
     * 设置视频下载按钮背景颜色
     *
     * @param videoDownloadBackgroundColor 视频下载按钮背景颜色 - 默认0xFFF5F5F5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoDownloadBackgroundColor(videoDownloadBackgroundColor: Color): MarkdownThemeBuilder

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
     * 设置图片最大高度
     *
     * @param imageMaxHeight 图片最大高度 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageMaxHeight(imageMaxHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置图片最大宽度
     *
     * @param imageMaxWidth 图片最大宽度 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageMaxWidth(imageMaxWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置图片圆角
     *
     * @param imageBorderRadius 图片圆角 - 默认0.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageBorderRadius(imageBorderRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置图片边框宽度
     *
     * @param imageBorderWidth 图片边框宽度 - 默认0.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageBorderWidth(imageBorderWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置图片边框颜色
     *
     * @param imageBorderColor 图片边框颜色 - 默认Color.BLACK
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageBorderColor(imageBorderColor: Color): MarkdownThemeBuilder

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
     * 设置图片是否有下载按钮
     *
     * @param isImageDownload 图片是否有下载按钮 - 默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsImageDownload(isImageDownload: Bool): MarkdownThemeBuilder

    /**
     * 设置是否图文混排
     *
     * @param isImageMixedLayout 是否图文混排 - 默认true
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIsImageMixedLayout(isImageMixedLayout: Bool): MarkdownThemeBuilder

    /**
     * 设置图片下载默认图标
     *
     * @param imageDownloadImage 图片下载默认图标 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageDownloadImage(imageDownloadImage: AppResource): MarkdownThemeBuilder

    /**
     * 设置图片下载按钮图片宽度和高度
     *
     * @param imageDownloadImageWidthHeight 图片下载按钮图片宽度和高度 - 默认18.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageDownloadImageWidthHeight(imageDownloadImageWidthHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置图片下载按钮宽度
     *
     * @param imageDownloadWidth 图片下载按钮宽度 - 默认296.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageDownloadWidth(imageDownloadWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置图片下载按钮高度
     *
     * @param imageDownloadHeight 图片下载按钮高度 - 默认44.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageDownloadHeight(imageDownloadHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置图片下载按钮圆角
     *
     * @param imageDownloadRadius 图片下载按钮圆角 - 默认22.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageDownloadRadius(imageDownloadRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置图片下载按钮文本内容
     *
     * @param imageDownloadText 图片下载按钮文本内容 - 默认"下载图片"
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageDownloadText(imageDownloadText: String): MarkdownThemeBuilder

    /**
     * 设置图片下载按钮文本大小
     *
     * @param imageDownloadTexSize 图片下载按钮文本大小 - 默认16.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageDownloadTexSize(imageDownloadTexSize: Float64): MarkdownThemeBuilder

    /**
     * 设置图片下载按钮文本颜色
     *
     * @param imageDownloadTexColor 图片下载按钮文本颜色 - 默认0XE6000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageDownloadTexColor(imageDownloadTexColor: Color): MarkdownThemeBuilder

    /**
     * 设置图片下载按钮背景颜色
     *
     * @param imageDownloadBackgroundColor 图片下载按钮背景颜色 - 默认0XFFF5F5F5
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageDownloadBackgroundColor(imageDownloadBackgroundColor: Color): MarkdownThemeBuilder

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
     * 设置表格标题背景色
     *
     * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认0XFFFFFFFF
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格标题文本颜色
     *
     * @param tableTitleTextColor 表格标题文本颜色 - 默认0XFF191919
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableTitleTextColor(tableTitleTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格标题文本大小
     *
     * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableTitleTextSize(tableTitleTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置表格标题文本行高
     *
     * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableTitleLineHeight(tableTitleLineHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置表格内容文本颜色
     *
     * @param tableContentTextColor 表格内容文本颜色 - 默认0XFF191919
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableContentTextColor(tableContentTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格内容文本大小
     *
     * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableContentTextSize(tableContentTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置表格内容文本行高
     *
     * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
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
     * 设置表格是否显示滚动条
     *
     * @param tableScrollBarShow 表格是否显示滚动条 - true：显示；false：不显示。默认false
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableScrollBarShow(tableScrollBarShow: Bool): MarkdownThemeBuilder

    /**
     * 设置表格滚动条颜色
     *
     * @param tableFirstColumnBold 表格滚动条颜色
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setTableScrollBarColor(tableScrollBarColor: Color): MarkdownThemeBuilder

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
     * 设置删除线样式
     *
     * @param strikethroughStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setStrikethroughStyle(strikethroughStyle: Int32): MarkdownThemeBuilder

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
     * 设置下标字体颜色
     *
     * @param subTextColor 下标字体颜色 默认0XFF191919
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setSubTextColor(subTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置下标字体大小
     *
     * @param subTextSize 下标字体大小 默认8.0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setSubTextSize(subTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置下标偏移距离
     *
     * @param subOffsetDist 下标偏移距离 默认0.0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setSubOffsetDist(subOffsetDist: Float64): MarkdownThemeBuilder

    /**
     * 设置上标字体颜色
     *
     * @param supTextColor 上标字体颜色 默认0XFF191919
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setSupTextColor(supTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置上标字体大小
     *
     * @param supTextSize 上标字体大小 默认8.0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setSupTextSize(supTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置上标偏移距离
     *
     * @param supOffsetDist 上标偏移距离 默认6.0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setSupOffsetDist(supOffsetDist: Float64): MarkdownThemeBuilder

    /**
     * 设置下划线颜色
     *
     * @param underlineColor 下划线颜色 默认0XFF191919
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setUnderlineColor(underlineColor: Color): MarkdownThemeBuilder

    /**
     * 设置下划线样式
     *
     * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
     * @return MarkdownConfigurationBuilder MarkdownConfigurationBuilder对象
     */
    public func setUnderlineStyle(underlineStyle: Int32): MarkdownThemeBuilder

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
    /**
     * 创建自动网址链接插件
     *
     * @param regs 自定义正则
     * @return LinkifyPlugin
     */
    public static func create(regs: Array<String>): LinkifyPlugin
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

### Markdown 上标插件

```cangjie
public class SupPlugin <: AbstractMarkdownPlugin {
    /**
     * 创建上标插件
     *
     * @return SupPlugin
     */
    public static func create(): SupPlugin
}
```

### Markdown 下标插件

```cangjie
public class SubPlugin <: AbstractMarkdownPlugin {
    /**
     * 创建下标插件
     *
     * @return SubPlugin
     */
    public static func create(): SubPlugin
}
```

### Markdown Emoji插件

```cangjie
public class EmojiPlugin <: AbstractMarkdownPlugin {
    /**
     * 创建Emoji插件
     *
     * @return EmojiPlugin
     */
    public static func create(): EmojiPlugin
    
    /**
     * 创建Emoji插件
     *
     * @param light 是否轻量emoji，默认true
     * @return EmojiPlugin
     */
    public static func create(light: Bool): EmojiPlugin
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

