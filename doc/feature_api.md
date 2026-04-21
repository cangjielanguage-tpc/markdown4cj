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
    8. 表格标题文本行高
    9. 表格标题文本颜色
    10. 表格内容文本颜色
    11. 表格内容文本大小
    12. 表格内容文本行高
    13. 表格圆角大小
    14. 表格一格最小宽度
    15. 表格一格最大宽度
    16. 表格第一列是否加粗
    17. 表格是否显示滚动条
    18. 表格滚动条颜色
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
     * 设置全局样式
     *
     * @param globalTheme 全局样式 - 默认GlobalTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setGlobalTheme(globalTheme: GlobalTheme): MarkdownThemeBuilder

    /**
     * 设置段落样式
     *
     * @param paragraphTheme 段落样式 - 默认ParagraphTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setParagraphTheme(paragraphTheme: ParagraphTheme): MarkdownThemeBuilder

    /**
     * 设置标题样式
     *
     * @param headingTheme 标题样式 - 默认HeadingTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTheme(headingTheme: HeadingTheme): MarkdownThemeBuilder

    /**
     * 设置表格样式
     *
     * @param tableTheme 表格样式 - 默认TableTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableTheme(tableTheme: TableTheme): MarkdownThemeBuilder

    /**
     * 设置分割线样式
     *
     * @param dividerTheme 分割线样式 - 默认DividerTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setDividerTheme(dividerTheme: DividerTheme): MarkdownThemeBuilder

    /**
     * 设置块引用样式
     *
     * @param blockQuoteTheme 块引用样式 - 默认BlockQuoteTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBlockQuoteTheme(blockQuoteTheme: BlockQuoteTheme): MarkdownThemeBuilder

    /**
     * 设置有序列表样式
     *
     * @param orderedListTheme 有序列表样式 - 默认OrderedListTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOrderedListTheme(orderedListTheme: OrderedListTheme): MarkdownThemeBuilder

    /**
     * 设置无序/任务列表样式
     *
     * @param bulletListTheme 无序/任务列表样式 - 默认BulletListTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBulletListTheme(bulletListTheme: BulletListTheme): MarkdownThemeBuilder

    /**
     * 设置定义列表样式
     *
     * @param definitionListTheme 定义列表样式 - 默认DefinitionListTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setDefinitionListTheme(definitionListTheme: DefinitionListTheme): MarkdownThemeBuilder

    /**
     * 设置代码块样式
     *
     * @param codeBlockTheme 代码块样式 - 默认CodeBlockTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setCodeBlockTheme(codeBlockTheme: CodeBlockTheme): MarkdownThemeBuilder

    /**
     * 设置音频样式
     *
     * @param audioTheme 音频样式 - 默认AudioTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setAudioTheme(audioTheme: AudioTheme): MarkdownThemeBuilder

    /**
     * 设置视频样式
     *
     * @param videoTheme 视频样式 - 默认VideoTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setVideoTheme(videoTheme: VideoTheme): MarkdownThemeBuilder

    /**
     * 设置banner样式
     *
     * @param bannerTheme banner样式 - 默认BannerTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBannerTheme(bannerTheme: BannerTheme): MarkdownThemeBuilder

    /**
     * 设置脚注定义样式
     *
     * @param footnoteDefTheme 脚注定义样式 - 默认FootnoteDefTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setFootnoteDefTheme(footnoteDefTheme: FootnoteDefTheme): MarkdownThemeBuilder

    /**
     * 设置脚注引用样式
     *
     * @param footnoteRefTheme 脚注引用样式 - 默认FootnoteRefTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setFootnoteRefTheme(footnoteRefTheme: FootnoteRefTheme): MarkdownThemeBuilder

    /**
     * 设置内联代码样式
     *
     * @param inlineCodeTheme 内联代码样式 - 默认InlineCodeTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setInlineCodeTheme(inlineCodeTheme: InlineCodeTheme): MarkdownThemeBuilder

    /**
     * 设置加粗文本样式
     *
     * @param boldTheme 加粗文本样式 - 默认BoldTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setBoldTheme(boldTheme: BoldTheme): MarkdownThemeBuilder

    /**
     * 设置数学公式样式
     *
     * @param latexMathTheme 数学公式样式 - 默认FormulaTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLatexMathTheme(latexMathTheme: LatexMathTheme): MarkdownThemeBuilder

    /**
     * 设置HTML下划线文本样式
     *
     * @param htmlUnderlineTheme HTML下划线文本样式 - 默认HtmlUnderlineTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHtmlUnderlineTheme(htmlUnderlineTheme: HtmlUnderlineTheme): MarkdownThemeBuilder

    /**
     * 设置图片样式
     *
     * @param imageTheme 图片样式 - 默认ImageTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setImageTheme(imageTheme: ImageTheme): MarkdownThemeBuilder

    /**
     * 设置斜体文本样式
     *
     * @param italicTheme 斜体文本样式 - 默认ItalicTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setItalicTheme(italicTheme: ItalicTheme): MarkdownThemeBuilder

    /**
     * 设置链接文本样式
     *
     * @param linkTheme 链接文本样式 - 默认LinkTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setLinkTheme(linkTheme: LinkTheme): MarkdownThemeBuilder

    /**
     * 设置删除线文本样式
     *
     * @param strikethroughTheme 删除线文本样式 - 默认StrikethroughTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setStrikethroughTheme(strikethroughTheme: StrikethroughTheme): MarkdownThemeBuilder

    /**
     * 设置下标文本样式
     *
     * @param subTheme 下标文本样式 - 默认SubTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSubTheme(subTheme: SubTheme): MarkdownThemeBuilder

    /**
     * 设置上标文本样式
     *
     * @param supTheme 上标文本样式 - 默认SupTheme()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSupTheme(supTheme: SupTheme): MarkdownThemeBuilder

    /**
     * 设置浅色主题整体样式
     *
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setDefaultTheme(): MarkdownThemeBuilder

    /**
     * 设置深色主题整体样式
     *
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
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
     * @param uiAbilityContext markdown上下文 - 默认None
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setUIAbilityContext(uiAbilityContext: UIAbilityContext): MarkdownThemeBuilder

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
     * 设置标题文本大小数组
     *
     * @param headingTextSizeMultipliers 标题文本大小数组 - 默认[20.0, 17.0, 16.0, 15.0, 15.0, 13.0]
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextSizeMultipliers(headingTextSizeMultipliers: Array<Float64>): MarkdownThemeBuilder

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
     * 设置标题文本颜色
     *
     * @param headingTextColor 标题文本颜色 - 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingTextColor(headingTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置H1、H2标题下分割线颜色
     *
     * @param headingBreakColor H1、H2标题下分割线颜色 - 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setHeadingBreakColor(headingBreakColor: Color): MarkdownThemeBuilder

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
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableCellPadding(tableCellPadding: Float64): MarkdownThemeBuilder

    /**
     * 设置表格边框颜色
     *
     * @param tableBorderColor 表格边框颜色 - 默认0XFF000000
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableBorderColor(tableBorderColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格边框宽度
     *
     * @param tableBorderWidth 表格边框宽度 - 默认1.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableBorderWidth(tableBorderWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置表格奇数行背景色
     *
     * @param tableOddRowBackgroundColor 表格奇数行背景色 - 默认0XFFFFFFFF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableOddRowBackgroundColor(tableOddRowBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格偶数行背景色
     *
     * @param tableEvenRowBackgroundColor 表格偶数行背景色 - 默认0XFFE0E0E0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格标题背景色
     *
     * @param tableHeaderRowBackgroundColor 表格标题背景色 - 默认0XFFFFFFFF
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格标题文本颜色
     *
     * @param tableTitleTextColor 表格标题文本颜色 - 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableTitleTextColor(tableTitleTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格标题文本大小
     *
     * @param tableTitleTextSize 表格标题文本大小 - 默认14.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableTitleTextSize(tableTitleTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置表格文本行高
     *
     * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableTextLineHeight(tableTextLineHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置表格标题文本行高
     *
     * @param tableTitleLineHeight 表格标题文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableTitleLineHeight(tableTitleLineHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置表格内容文本颜色
     *
     * @param tableContentTextColor 表格内容文本颜色 - 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableContentTextColor(tableContentTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置表格内容文本大小
     *
     * @param tableContentTextSize 表格内容文本大小 - 默认14.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableContentTextSize(tableContentTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置表格内容文本行高
     *
     * @param tableTextLineHeight 表格内容文本行高 - 默认22.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableContentTextLineHeight(tableTextLineHeight: Float64): MarkdownThemeBuilder

    /**
     * 设置表格圆角
     *
     * @param tableRadius 表格圆角 - 默认5.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableRadius(tableRadius: Float64): MarkdownThemeBuilder

    /**
     * 设置表格最小宽度
     *
     * @param tableMinTextWidth 表格最小宽度 - 默认50.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableMinTextWidth(tableMinTextWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置表格最大宽度
     *
     * @param tableMaxTextWidth 表格最大宽度- 默认300.0vp
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableMaxTextWidth(tableMaxTextWidth: Float64): MarkdownThemeBuilder

    /**
     * 设置表格第一列是否加粗
     *
     * @param tableFirstColumnBold 表格第一列是否加粗 - true：加粗；false：不加粗。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableFirstColumnBold(tableFirstColumnBold: Bool): MarkdownThemeBuilder

    /**
     * 设置表格是否显示滚动条
     *
     * @param tableScrollBarShow 表格是否显示滚动条 - true：显示；false：不显示。默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableScrollBarShow(tableScrollBarShow: Bool): MarkdownThemeBuilder

    /**
     * 设置表格滚动条颜色
     *
     * @param tableFirstColumnBold 表格滚动条颜色
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setTableScrollBarColor(tableScrollBarColor: Color): MarkdownThemeBuilder

    /**
     * 设置markdown代码高亮样式
     *
     * @param PrismTheme markdown代码高亮样式 - 默认PrismThemeDarkula.create()
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setPrismTheme(prismTheme: PrismTheme): MarkdownThemeBuilder

    /**
     * 设置删除线颜色
     *
     * @param strikethroughColor 删除线颜色 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setStrikethroughColor(strikethroughColor: Color): MarkdownThemeBuilder

    /**
     * 设置删除线样式
     *
     * @param strikethroughStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setStrikethroughStyle(strikethroughStyle: Int32): MarkdownThemeBuilder

    /**
     * 设置定义列表术语和定义行之间间距
     *
     * @param descListTermAndDefMargins 定义列表术语和定义行之间间距 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setDescListTermAndDefMargins(descListTermAndDefMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置定义列表定义行缩进
     *
     * @param descListDefIndentation 定义列表定义行缩进 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setDescListDefIndentation(descListDefIndentation: Float64): MarkdownThemeBuilder

    /**
     * 设置定义列表定义行间距
     *
     * @param descListDefMargins 定义列表定义行间距 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setDescListDefMargins(descListDefMargins: Float64): MarkdownThemeBuilder

    /**
     * 设置下标字体颜色
     *
     * @param subTextColor 下标字体颜色 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSubTextColor(subTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置下标字体大小
     *
     * @param subTextSize 下标字体大小 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSubTextSize(subTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置下标偏移距离
     *
     * @param subOffsetDist 下标偏移距离 默认0.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSubOffsetDist(subOffsetDist: Float64): MarkdownThemeBuilder

    /**
     * 设置上标字体颜色
     *
     * @param supTextColor 上标字体颜色 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSupTextColor(supTextColor: Color): MarkdownThemeBuilder

    /**
     * 设置上标字体大小
     *
     * @param supTextSize 上标字体大小 默认8.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSupTextSize(supTextSize: Float64): MarkdownThemeBuilder

    /**
     * 设置上标偏移距离
     *
     * @param supOffsetDist 上标偏移距离 默认6.0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setSupOffsetDist(supOffsetDist: Float64): MarkdownThemeBuilder

    /**
     * 设置下划线颜色
     *
     * @param underlineColor 下划线颜色 默认0XFF191919
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setUnderlineColor(underlineColor: Color): MarkdownThemeBuilder

    /**
     * 设置下划线样式
     *
     * @param underlineStyle 下划线样式 0-SOLID-单实线 1-DOUBLE-双实线 2-DOTTED-点线 3-DASHED-虚线 4-WAVY-波浪线 默认0
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setUnderlineStyle(underlineStyle: Int32): MarkdownThemeBuilder

    /**
     * 设置markdown是否支持滚动操作
     *
     * @param openGestureSwipe true-支持滚动，false-不支持滚动，默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setOpenGestureSwipe(openGestureSwipe: Bool): MarkdownThemeBuilder

    /**
     * 设置codeformat是否用制表符
     *
     * @param useTab true-使用，false-不使用，默认false
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setUseTab(useTab: Bool): MarkdownThemeBuilder

    /**
     * 设置codeformat空格缩进数量
     *
     * @param indentWidth 空格缩进数量，默认4空格
     * @return MarkdownThemeBuilder MarkdownThemeBuilder对象
     */
    public func setIndentWidth(indentWidth: Int64): MarkdownThemeBuilder

    /**
     * 返回Theme对象
     *
     * @return MarkdownTheme MarkdownTheme对象
     */
    public func build(): MarkdownTheme
}
```

#### 加粗文本样式

##### public class BoldTheme <: MarkdownBaseTheme

```cangjie
/**
 * 加粗文本样式
 */
public class BoldTheme <: MarkdownBaseTheme {
    /**
     * 设置加粗文本颜色
     *
     * @param color 加粗文本颜色
     * @return 当前BoldTheme对象
     */
    public func setBoldTextFontColor(color: Color): BoldTheme

    /**
     * 设置加粗文本尺寸
     *
     * @param size 加粗文本尺寸
     * @return 当前BoldTheme对象
     */
    public func setBoldTextFontSize(size: Float64): BoldTheme

    /**
     * 设置加粗文本字体样式
     *
     * @param style 加粗文本字体样式
     * @return 当前BoldTheme对象
     */
    public func setBoldTextFontStyle(style: FontStyle): BoldTheme

    /**
     * 设置加粗文本字体粗细
     *
     * @param weight 加粗文本字体粗细
     * @return 当前BoldTheme对象
     */
    public func setBoldTextFontWeight(weight: FontWeight): BoldTheme

    /**
     * 设置加粗文本字体
     *
     * @param family 加粗文本字体
     * @return 当前BoldTheme对象
     */
    public func setBoldTextFontFamily(family: String): BoldTheme

    /**
     * 设置加粗文本行高
     *
     * @param lineHeight 加粗文本行高
     * @return 当前BoldTheme对象
     */
    public func setBoldTextLineHeight(lineHeight: Float64): BoldTheme

    /**
     * 设置加粗文本字符间距
     *
     * @param spacing 加粗文本字符间距
     * @return 当前BoldTheme对象
     */
    public func setBoldTextLetterSpacing(spacing: Float64): BoldTheme
}
```

#### 斜体文本样式

##### public class ItalicTheme <: MarkdownBaseTheme

```cangjie
/**
 * 斜体文本样式
 */
public class ItalicTheme <: MarkdownBaseTheme {
    /**
     * 设置斜体文本颜色
     *
     * @param color 斜体文本颜色
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextFontColor(color: Color): ItalicTheme

    /**
     * 设置斜体文本尺寸
     *
     * @param size 斜体文本尺寸
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextFontSize(size: Float64): ItalicTheme

    /**
     * 设置斜体文本字体粗细
     *
     * @param weight 斜体文本字体粗细
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextFontWeight(weight: FontWeight): ItalicTheme

    /**
     * 设置斜体文本字体
     *
     * @param family 斜体文本字体
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextFontFamily(family: String): ItalicTheme

    /**
     * 设置斜体文本行高
     *
     * @param lineHeight 斜体文本行高
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextLineHeight(lineHeight: Float64): ItalicTheme

    /**
     * 设置斜体文本字符间距
     *
     * @param spacing 斜体文本字符间距
     * @return 当前ItalicTheme对象
     */
    public func setItalicTextLetterSpacing(spacing: Float64): ItalicTheme
}
```

#### 删除线文本样式

##### public class StrikethroughTheme <: MarkdownBaseTheme

```cangjie
/**
 * 删除线文本样式
 */
public class StrikethroughTheme <: MarkdownBaseTheme {
    /**
     * 设置删除线文本颜色
     *
     * @param color 删除线文本颜色
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextFontColor(color: Color): StrikethroughTheme

    /**
     * 设置删除线文本尺寸
     *
     * @param size 删除线文本尺寸
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextFontSize(size: Float64): StrikethroughTheme

    /**
     * 设置删除线文本字体样式
     *
     * @param style 删除线文本字体样式
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextFontStyle(style: FontStyle): StrikethroughTheme

    /**
     * 设置删除线文本字体粗细
     *
     * @param weight 删除线文本字体粗细
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextFontWeight(weight: FontWeight): StrikethroughTheme

    /**
     * 设置删除线文本字体
     *
     * @param family 删除线文本字体
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextFontFamily(family: String): StrikethroughTheme

    /**
     * 设置删除线文本行高
     *
     * @param lineHeight 删除线文本行高
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextLineHeight(lineHeight: Float64): StrikethroughTheme

    /**
     * 设置删除线文本字符间距
     *
     * @param spacing 删除线文本字符间距
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextLetterSpacing(spacing: Float64): StrikethroughTheme

    /**
     * 设置删除线文本装饰线颜色
     *
     * @param color 删除线文本装饰线颜色
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextDecorationColor(color: Color): StrikethroughTheme

    /**
     * 设置删除线文本装饰线样式
     *
     * @param style 删除线文本装饰线样式
     * @return 当前StrikethroughTheme对象
     */
    public func setStrikethroughTextDecorationStyle(style: MarkdownTextDecorationStyle): StrikethroughTheme
}
```

#### 下标文本样式

##### public class SubTheme <: MarkdownBaseTheme

```cangjie
/**
 * 下标文本样式
 */
public class SubTheme <: MarkdownBaseTheme {
    /**
     * 设置下标文本颜色
     *
     * @param color 下标文本颜色
     * @return 当前SubTheme对象
     */
    public func setSubTextFontColor(color: Color): SubTheme

    /**
     * 设置下标文本尺寸
     *
     * @param size 下标文本尺寸
     * @return 当前SubTheme对象
     */
    public func setSubTextFontSize(size: Float64): SubTheme

    /**
     * 设置下标文本字体样式
     *
     * @param style 下标文本字体样式
     * @return 当前SubTheme对象
     */
    public func setSubTextFontStyle(style: FontStyle): SubTheme

    /**
     * 设置下标文本字体粗细
     *
     * @param weight 下标文本字体粗细
     * @return 当前SubTheme对象
     */
    public func setSubTextFontWeight(weight: FontWeight): SubTheme

    /**
     * 设置下标文本字体
     *
     * @param family 下标文本字体
     * @return 当前SubTheme对象
     */
    public func setSubTextFontFamily(family: String): SubTheme

    /**
     * 设置下标文本字符间距
     *
     * @param spacing 下标文本字符间距
     * @return 当前SubTheme对象
     */
    public func setSubTextLetterSpacing(spacing: Float64): SubTheme

    /**
     * 设置下标文本基线的偏移量
     *
     * @param offset 下标文本基线的偏移量
     * @return 当前SubTheme对象
     */
    public func setSubTextBaselineOffset(offset: Float64): SubTheme
}
```

#### 上标文本样式

##### public class SupTheme <: MarkdownBaseTheme

```cangjie
/**
 * 上标文本样式
 */
public class SupTheme <: MarkdownBaseTheme {
    /**
     * 设置上标文本颜色
     *
     * @param color 上标文本颜色
     * @return 当前SupTheme对象
     */
    public func setSupTextFontColor(color: Color): SupTheme

    /**
     * 设置上标文本尺寸
     *
     * @param size 上标文本尺寸
     * @return 当前SupTheme对象
     */
    public func setSupTextFontSize(size: Float64): SupTheme

    /**
     * 设置上标文本字体样式
     *
     * @param style 上标文本字体样式
     * @return 当前SupTheme对象
     */
    public func setSupTextFontStyle(style: FontStyle): SupTheme

    /**
     * 设置上标文本字体粗细
     *
     * @param weight 上标文本字体粗细
     * @return 当前SupTheme对象
     */
    public func setSupTextFontWeight(weight: FontWeight): SupTheme

    /**
     * 设置上标文本字体
     *
     * @param family 上标文本字体
     * @return 当前SupTheme对象
     */
    public func setSupTextFontFamily(family: String): SupTheme

    /**
     * 设置上标文本字符间距
     *
     * @param spacing 上标文本字符间距
     * @return 当前SupTheme对象
     */
    public func setSupTextLetterSpacing(spacing: Float64): SupTheme

    /**
     * 设置上标文本基线的偏移量
     *
     * @param offset 上标文本基线的偏移量
     * @return 当前SupTheme对象
     */
    public func setSupTextBaselineOffset(offset: Float64): SupTheme
}
```

#### 内联代码样式

##### public class InlineCodeTheme <: MarkdownBaseTheme

```cangjie
/**
 * 内联代码样式
 */
public class InlineCodeTheme <: MarkdownBaseTheme {
    /**
     * 设置内联代码文本颜色
     *
     * @param color 内联代码文本颜色
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextFontColor(color: Color): InlineCodeTheme

    /**
     * 设置内联代码文本尺寸
     *
     * @param size 内联代码文本尺寸
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextFontSize(size: Float64): InlineCodeTheme

    /**
     * 设置内联代码文本字体样式
     *
     * @param style 内联代码文本字体样式
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextFontStyle(style: FontStyle): InlineCodeTheme

    /**
     * 设置内联代码文本字体粗细
     *
     * @param weight 内联代码文本字体粗细
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextFontWeight(weight: FontWeight): InlineCodeTheme

    /**
     * 设置内联代码文本字体
     *
     * @param family 内联代码文本字体
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextFontFamily(family: String): InlineCodeTheme

    /**
     * 设置内联代码文本行高
     *
     * @param lineHeight 内联代码文本行高
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextLineHeight(lineHeight: Float64): InlineCodeTheme

    /**
     * 设置内联代码文本字符间距
     *
     * @param spacing 内联代码文本字符间距
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextLetterSpacing(spacing: Float64): InlineCodeTheme

    /**
     * 设置内联代码文本背景颜色
     *
     * @param color 内联代码文本背景颜色
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextBackgroundColor(color: Color): InlineCodeTheme

    /**
     * 统一设置内联代码文本背景整体圆角
     *
     * @param radius 圆角
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextBackgroundRadius(radius: Float64): InlineCodeTheme

    /**
     * 分别设置内联代码文本背景四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前InlineCodeTheme对象
     */
    public func setInlineCodeTextBackgroundRadius(topLeft!: Float64 = 0.0, topRight!: Float64 = 0.0, bottomLeft!: Float64 = 0.0, bottomRight!: Float64 = 0.0): InlineCodeTheme
}
```

#### 段落样式

##### public class ParagraphTheme <: MarkdownBaseTheme

```cangjie
/**
 * 段落样式
 */
public class ParagraphTheme <: MarkdownBaseTheme {
    /**
     * 设置段落背景颜色
     *
     * @param color 段落背景颜色
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphBackgroundColor(color: Color): ParagraphTheme

    /**
     * 统一设置段落外边距
     *
     * @param margin 外边距
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphMargin(margin: Float64): ParagraphTheme

    /**
     * 分别设置段落四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): ParagraphTheme

    /**
     * 统一设置段落内边距
     *
     * @param padding 内边距
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphPadding(padding: Float64): ParagraphTheme

    /**
     * 分别设置段落四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): ParagraphTheme

    /**
     * 设置段落文本颜色
     *
     * @param color 段落文本颜色
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextFontColor(color: Color): ParagraphTheme

    /**
     * 设置段落文本尺寸
     *
     * @param size 段落文本尺寸
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextFontSize(size: Float64): ParagraphTheme

    /**
     * 设置段落文本字体样式
     *
     * @param style 段落文本字体样式
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextFontStyle(style: FontStyle): ParagraphTheme

    /**
     * 设置段落文本字体粗细
     *
     * @param weight 段落文本字体粗细
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextFontWeight(weight: FontWeight): ParagraphTheme

    /**
     * 设置段落文本字体
     *
     * @param family 段落文本字体
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextFontFamily(family: String): ParagraphTheme

    /**
     * 设置段落文本行高
     *
     * @param lineHeight 段落文本行高
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextLineHeight(lineHeight: Float64): ParagraphTheme

    /**
     * 设置段落文本字符间距
     *
     * @param spacing 段落文本字符间距
     * @return 当前ParagraphTheme对象
     */
    public func setParagraphTextLetterSpacing(spacing: Float64): ParagraphTheme
}
```

#### 有序列表样式

##### public class OrderedListTheme <: MarkdownBaseTheme

```cangjie
/**
 * 有序列表样式
 */
public class OrderedListTheme <: MarkdownBaseTheme {
    /**
     * 设置有序列表背景颜色
     *
     * @param color 有序列表背景颜色
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListBackgroundColor(color: Color): OrderedListTheme

    /**
     * 统一设置有序列表外边距
     *
     * @param margin 外边距
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMargin(margin: Float64): OrderedListTheme

    /**
     * 分别设置有序列表四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 8.0): OrderedListTheme

    /**
     * 统一设置有序列表内边距
     *
     * @param padding 内边距
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListPadding(padding: Float64): OrderedListTheme

    /**
     * 分别设置有序列表四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): OrderedListTheme

    /**
     * 设置有序列表子模块上下间距
     *
     * @param spacing 有序列表子模块上下间距
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListChildSpacing(spacing: Int64): OrderedListTheme

    /**
     * 设置有序列表子模块中子模块上下间距
     *
     * @param spacing 有序列表子模块中子模块上下间距
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListChildChildSpacing(spacing: Int64): OrderedListTheme

    /**
     * 设置有序列表列表编号和列表内容间距
     *
     * @param spacing 有序列表列表编号和列表内容间距
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerSpacing(spacing: Float64): OrderedListTheme

    /**
     * 设置有序列表列表编号文本颜色
     *
     * @param color 有序列表列表编号文本颜色
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextFontColor(color: Color): OrderedListTheme

    /**
     * 设置有序列表列表编号文本尺寸
     *
     * @param size 有序列表列表编号文本尺寸
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextFontSize(size: Float64): OrderedListTheme

    /**
     * 设置有序列表列表编号文本字体粗细
     *
     * @param weight 有序列表列表编号文本字体粗细
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextFontWeight(weight: FontWeight): OrderedListTheme

    /**
     * 设置有序列表列表编号文本字体
     *
     * @param family 有序列表列表编号文本字体
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextFontFamily(family: String): OrderedListTheme

    /**
     * 设置有序列表列表编号文本字体样式
     *
     * @param style 有序列表列表编号文本字体样式
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextFontStyle(style: FontStyle): OrderedListTheme

    /**
     * 设置有序列表列表编号文本行高
     *
     * @param lineHeight 有序列表列表编号文本行高
     * @return 当前OrderedListTheme对象
     */
    public func setOrderedListMarkerTextLineHeight(lineHeight: Float64): OrderedListTheme
}
```

#### 分割线样式

##### public class DividerTheme <: MarkdownBaseTheme

```cangjie
/**
 * 分割线样式
 */
public class DividerTheme <: MarkdownBaseTheme {
    /**
     * 统一设置分割线整体外边距
     *
     * @param margin 外边距
     * @return 当前DividerTheme对象
     */
    public func setDividerMargin(margin: Float64): DividerTheme

    /**
     * 分别设置分割线四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前DividerTheme对象
     */
    public func setDividerMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): DividerTheme

    /**
     * 统一设置分割线整体内边距
     *
     * @param padding 内边距
     * @return 当前DividerTheme对象
     */
    public func setDividerPadding(padding: Float64): DividerTheme

    /**
     * 设置分割线颜色
     *
     * @param color 分割线颜色
     * @return 当前DividerTheme对象
     */
    public func setDividerColor(color: Color): DividerTheme

    /**
     * 设置分割线宽度
     *
     * @param strokeWidth 分割线宽度
     * @return 当前DividerTheme对象
     */
    public func setDividerStrokeWidth(strokeWidth: Float64): DividerTheme

    /**
     * 设置分割线端点样式
     *
     * @param style 分割线端点样式
     * @return 当前DividerTheme对象
     */
    public func setDividerStyle(style: LineCapStyle): DividerTheme
}
```

#### Banner样式

##### public class BannerTheme <: MarkdownBaseTheme

```cangjie
/**
 * Banner样式
 */
public class BannerTheme <: MarkdownBaseTheme {
    /**
     * 统一设置banner整体外边距
     *
     * @param margin 外边距
     * @return 当前BannerTheme对象
     */
    public func setBannerMargin(margin: Float64): BannerTheme

    /**
     * 分别设置banner四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前BannerTheme对象
     */
    public func setBannerMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): BannerTheme

    /**
     * 统一设置banner整体内边距
     *
     * @param padding 内边距
     * @return 当前BannerTheme对象
     */
    public func setBannerPadding(padding: Float64): BannerTheme

    /**
     * 分别设置banner四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前BannerTheme对象
     */
    public func setBannerPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): BannerTheme

    /**
     * 设置banner占位图
     *
     * @param resource banner占位图
     * @return 当前BannerTheme对象
     */
    public func setBannerPlaceholder(resource: AppResource): BannerTheme
}
```

#### 定义列表样式

##### public class DefinitionListTheme <: MarkdownBaseTheme

```cangjie
/**
 * 定义列表样式
 */
public class DefinitionListTheme <: MarkdownBaseTheme {
    /**
     * 设置定义列表背景颜色
     *
     * @param color 定义列表背景颜色
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListBackgroundColor(color: Color): DefinitionListTheme

    /**
     * 统一设置定义列表外边距
     *
     * @param margin 外边距
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListMargin(margin: Float64): DefinitionListTheme

    /**
     * 分别设置定义列表四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): DefinitionListTheme

    /**
     * 统一设置定义列表内边距
     *
     * @param padding 内边距
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListPadding(padding: Float64): DefinitionListTheme

    /**
     * 设置定义列表术语和定义行之间间距
     *
     * @param spacing 定义列表术语和定义行之间间距
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListTermToDescriptionSpacing(spacing: Float64): DefinitionListTheme

    /**
     * 设置定义列表术语文本字体粗细
     *
     * @param weight 定义列表术语文本字体粗细
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListTermTextFontWeight(weight: FontWeight): DefinitionListTheme

    /**
     * 设置定义列表术语文本字体样式
     *
     * @param style 定义列表术语文本字体样式
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListTermTextFontStyle(style: FontStyle): DefinitionListTheme

    /**
     * 设置定义列表定义行之间间距
     *
     * @param spacing 定义列表定义行之间间距
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListDescriptionItemSpacing(spacing: Float64): DefinitionListTheme

    /**
     * 设置定义列表定义行左缩进距离
     *
     * @param indent 定义列表定义行左缩进距离
     * @return 当前DefinitionListTheme对象
     */
    public func setDefinitionListDescriptionIndent(indent: Float64): DefinitionListTheme
}
```

#### 脚注定义样式

##### public class FootnoteDefTheme <: MarkdownBaseTheme

```cangjie
/**
 * 脚注定义样式
 */
public class FootnoteDefTheme <: MarkdownBaseTheme {
    /**
     * 设置脚注定义背景颜色
     *
     * @param color 脚注定义背景颜色
     * @return 当前FootnoteDefTheme对象
     */
    public func setFootnoteDefBackgroundColor(color: Color): FootnoteDefTheme

    /**
     * 统一设置脚注定义外边距
     *
     * @param margin 外边距
     * @return 当前FootnoteDefTheme对象
     */
    public func setFootnoteDefMargin(margin: Float64): FootnoteDefTheme

    /**
     * 分别设置脚注定义四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前FootnoteDefTheme对象
     */
    public func setFootnoteDefMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): FootnoteDefTheme

    /**
     * 统一设置脚注定义内边距
     *
     * @param padding 内边距
     * @return 当前FootnoteDefTheme对象
     */
    public func setFootnoteDefPadding(padding: Float64): FootnoteDefTheme

    /**
     * 分别设置脚注定义四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前FootnoteDefTheme对象
     */
    public func setFootnoteDefPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): FootnoteDefTheme
}
```

#### 脚注引用样式

##### public class FootnoteRefTheme <: MarkdownBaseTheme

```cangjie
/**
 * 脚注引用样式
 */
public class FootnoteRefTheme <: MarkdownBaseTheme {
    /**
     * 设置脚注引用文本颜色
     *
     * @param color 脚注引用文本颜色
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextFontColor(color: Color): FootnoteRefTheme

    /**
     * 设置脚注引用文本尺寸
     *
     * @param size 脚注引用文本尺寸
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextFontSize(size: Float64): FootnoteRefTheme

    /**
     * 设置脚注引用文本字体样式
     *
     * @param style 脚注引用文本字体样式
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextFontStyle(style: FontStyle): FootnoteRefTheme

    /**
     * 设置脚注引用文本字体粗细
     *
     * @param weight 脚注引用文本字体粗细
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextFontWeight(weight: FontWeight): FootnoteRefTheme

    /**
     * 设置脚注引用文本字体
     *
     * @param family 脚注引用文本字体
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextFontFamily(family: String): FootnoteRefTheme

    /**
     * 设置脚注引用文本行高
     *
     * @param lineHeight 脚注引用文本行高
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextLineHeight(lineHeight: Float64): FootnoteRefTheme

    /**
     * 设置脚注引用文本字符间距
     *
     * @param spacing 脚注引用文本字符间距
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextLetterSpacing(spacing: Float64): FootnoteRefTheme

    /**
     * 设置脚注引用文本装饰线类型
     *
     * @param decorationType 脚注引用文本装饰线类型
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextDecorationType(decorationType: TextDecorationType): FootnoteRefTheme

    /**
     * 设置脚注引用文本装饰线颜色
     *
     * @param color 脚注引用文本装饰线颜色
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextDecorationColor(color: Color): FootnoteRefTheme

    /**
     * 设置脚注引用文本装饰线样式
     *
     * @param style 脚注引用文本装饰线样式
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextDecorationStyle(style: MarkdownTextDecorationStyle): FootnoteRefTheme

    /**
     * 设置脚注引用文本背景颜色
     *
     * @param color 脚注引用文本背景颜色
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextBackgroundColor(color: Color): FootnoteRefTheme

    /**
     * 统一设置脚注引用文本背景整体圆角
     *
     * @param radius 圆角
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextBackgroundRadius(radius: Float64): FootnoteRefTheme

    /**
     * 分别设置脚注引用文本背景四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前FootnoteRefTheme对象
     */
    public func setFootnoteRefTextBackgroundRadius(topLeft!: Float64 = 0.0, topRight!: Float64 = 0.0, bottomLeft!: Float64 = 0.0, bottomRight!: Float64 = 0.0): FootnoteRefTheme
}
```

#### HTML下划线文本样式

##### public class HtmlUnderlineTheme <: MarkdownBaseTheme

```cangjie
/**
 * HTML下划线文本样式
 */
public class HtmlUnderlineTheme <: MarkdownBaseTheme {
    /**
     * 设置HTML下划线文本颜色
     *
     * @param color HTML下划线文本颜色
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextFontColor(color: Color): HtmlUnderlineTheme

    /**
     * 设置HTML下划线文本尺寸
     *
     * @param size HTML下划线文本尺寸
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextFontSize(size: Float64): HtmlUnderlineTheme

    /**
     * 设置HTML下划线文本字体样式
     *
     * @param style HTML下划线文本字体样式
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextFontStyle(style: FontStyle): HtmlUnderlineTheme

    /**
     * 设置HTML下划线文本字体粗细
     *
     * @param weight HTML下划线文本字体粗细
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextFontWeight(weight: FontWeight): HtmlUnderlineTheme

    /**
     * 设置HTML下划线文本字体
     *
     * @param family HTML下划线文本字体
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextFontFamily(family: String): HtmlUnderlineTheme

    /**
     * 设置HTML下划线文本行高
     *
     * @param lineHeight HTML下划线文本行高
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextLineHeight(lineHeight: Float64): HtmlUnderlineTheme

    /**
     * 设置HTML下划线文本字符间距
     *
     * @param spacing HTML下划线文本字符间距
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextLetterSpacing(spacing: Float64): HtmlUnderlineTheme

    /**
     * 设置HTML下划线文本装饰线颜色
     *
     * @param color HTML下划线文本装饰线颜色
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextDecorationColor(color: Color): HtmlUnderlineTheme

    /**
     * 设置HTML下划线文本装饰线样式
     *
     * @param style HTML下划线文本装饰线样式
     * @return 当前HtmlUnderlineTheme对象
     */
    public func setHtmlUnderlineTextDecorationStyle(style: MarkdownTextDecorationStyle): HtmlUnderlineTheme
}
```

#### 数学公式样式

##### public class LatexMathTheme <: MarkdownBaseTheme

```cangjie
/**
 * 数学公式样式
 */
public class LatexMathTheme <: MarkdownBaseTheme {
    /**
     * 统一设置块结构数学公式外边距
     *
     * @param margin 外边距
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathMargin(margin: Float64): LatexMathTheme

    /**
     * 分别设置块结构数学公式四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): LatexMathTheme

    /**
     * 统一设置块结构数学公式内边距
     *
     * @param padding 内边距
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathPadding(padding: Float64): LatexMathTheme

    /**
     * 设置数学公式未加载状态是否显示文字
     *
     * @param showDefaultText 是否显示文字
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathDefaultText(showDefaultText: Bool): LatexMathTheme

    /**
     * 设置数学公式未加载状态文本颜色
     *
     * @param color 文本颜色
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathDefaultTextFontColor(color: Color): LatexMathTheme

    /**
     * 设置数学公式未加载状态文本尺寸
     *
     * @param size 文本尺寸
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathDefaultTextFontSize(size: Float64): LatexMathTheme

    /**
     * 设置数学公式文本大小
     *
     * @param size 文本大小
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathTextSize(size: Float64): LatexMathTheme

    /**
     * 设置数学公式背景色
     *
     * @param color 背景色
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathBackgroundColor(color: Color): LatexMathTheme

    /**
     * 设置数学公式文本颜色
     *
     * @param color 文本颜色
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathTextColor(color: Color): LatexMathTheme

    /**
     * 设置数学公式生成图片格式
     *
     * @param format 生成图片格式
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathColorFormat(format: LatexMathColorFormat): LatexMathTheme

    /**
     * 设置块结构的数学公式是否居中
     *
     * @param center 是否居中
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathBlockCenter(center: Bool): LatexMathTheme

    /**
     * 设置数学公式字体路径
     *
     * @param path 字体路径
     * @return 当前LatexMathTheme对象
     */
    public func setLatexMathResPath(path: String): LatexMathTheme
}
```

#### 全局样式

##### public class GlobalTheme <: MarkdownBaseTheme

```cangjie
/**
 * 全局样式
 */
public class GlobalTheme <: MarkdownBaseTheme {
    /**
     * 设置markdown上下文 - 互操作
     *
     * @param context 上下文对象
     * @return 当前GlobalTheme对象
     */
    public func setStageContext(context: StageContext): GlobalTheme

    /**
     * 设置markdown上下文 - 仓颉
     *
     * @param context 上下文对象
     * @return 当前GlobalTheme对象
     */
    public func setUiAbilityContext(context: UIAbilityContext): GlobalTheme

    /**
     * 设置markdown是否同步解析
     *
     * @param parserSync 是否同步解析
     * @return 当前GlobalTheme对象
     */
    public func setIsMarkdownParserSync(parserSync: Bool): GlobalTheme

    /**
     * 设置是否打开长按复制粘贴
     *
     * @param onCopy 是否开启
     * @return 当前GlobalTheme对象
     */
    public func setIsOnCopy(onCopy: Bool): GlobalTheme

    /**
     * 全局整体外边距
     *
     * @param margin 外边距
     * @return 当前GlobalTheme对象
     */
    public func setMargin(margin: Float64): GlobalTheme

    /**
     * 全局分别设置四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前GlobalTheme对象
     */
    public func setMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): GlobalTheme

    /**
     * 设置markdown子组件主轴方向的间隔
     *
     * @param space markdown子组件主轴方向的间隔
     * @return 当前GlobalTheme对象
     */
    public func setMarkdownBlockSpacing(space: Int64): GlobalTheme

    /**
     * 设置软换行是否换行
     *
     * @param lineBreak 是否换行
     * @return 当前GlobalTheme对象
     */
    public func setIsLineBreak(lineBreak: Bool): GlobalTheme

    /**
     * 设置markdown是否支持滚动手势
     *
     * @param gestureSwipe 是否支持手势滑动
     * @return 当前GlobalTheme对象
     */
    public func setOpenGestureSwipe(gestureSwipe: Bool): GlobalTheme

    /**
     * 设置背景颜色
     *
     * @param color 背景颜色
     * @return 当前GlobalTheme对象
     */
    public func setBackgroundColor(color: Color): GlobalTheme
}
```

#### 音频样式

##### public class AudioTheme <: MarkdownBaseTheme

```cangjie
/**
 * 音频样式
 */
public class AudioTheme <: MarkdownBaseTheme {
    /**
     * 设置音频背景颜色
     *
     * @param color 音频背景颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioBackgroundColor(color: Color): AudioTheme

    /**
     * 统一设置音频整体外边距
     *
     * @param margin 外边距
     * @return 当前AudioTheme对象
     */
    public func setAudioMargin(margin: Float64): AudioTheme

    /**
     * 分别设置音频四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前AudioTheme对象
     */
    public func setAudioMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): AudioTheme

    /**
     * 统一设置音频整体内边距
     *
     * @param padding 内边距
     * @return 当前AudioTheme对象
     */
    public func setAudioPadding(padding: Float64): AudioTheme

    /**
     * 分别设置音频四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前AudioTheme对象
     */
    public func setAudioPadding(top!: Float64 = 12.0, right!: Float64 = 16.0, bottom!: Float64 = 12.0, left!: Float64 = 12.0): AudioTheme

    /**
     * 设置音频边框样式
     *
     * @param borderStyle 音频边框样式
     * @return 当前AudioTheme对象
     */
    public func setAudioBorderStyle(borderStyle: BorderStyle): AudioTheme

    /**
     * 设置音频边框宽度
     *
     * @param borderWidth 音频边框宽度
     * @return 当前AudioTheme对象
     */
    public func setAudioBorderWidth(borderWidth: Float64): AudioTheme

    /**
     * 设置音频边框颜色
     *
     * @param borderColor 音频边框颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioBorderColor(borderColor: Color): AudioTheme

    /**
     * 统一设置音频整体圆角
     *
     * @param radius 圆角
     * @return 当前AudioTheme对象
     */
    public func setAudioRadius(radius: Float64): AudioTheme

    /**
     * 分别设置音频四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前AudioTheme对象
     */
    public func setAudioRadius(topLeft!: Float64 = 12.0, topRight!: Float64 = 12.0, bottomLeft!: Float64 = 12.0, bottomRight!: Float64 = 12.0): AudioTheme

    /**
     * 设置音频阴影模糊半径
     *
     * @param radius 音频阴影模糊半径
     * @return 当前AudioTheme对象
     */
    public func setAudioShadowRadius(radius: Float64): AudioTheme

    /**
     * 设置音频阴影颜色
     *
     * @param color 音频阴影颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioShadowColor(color: Color): AudioTheme

    /**
     * 设置音频阴影X轴偏移量
     *
     * @param offsetX 音频阴影X轴偏移量
     * @return 当前AudioTheme对象
     */
    public func setAudioShadowOffsetX(offsetX: Float64): AudioTheme

    /**
     * 设置音频阴影Y轴偏移量
     *
     * @param offsetY 音频阴影Y轴偏移量
     * @return 当前AudioTheme对象
     */
    public func setAudioShadowOffsetY(offsetY: Float64): AudioTheme

    /**
     * 设置音频图标
     *
     * @param icon 音频图标
     * @return 当前AudioTheme对象
     */
    public func setAudioIcon(icon: AppResource): AudioTheme

    /**
     * 设置音频图标宽度
     *
     * @param width 音频图标宽度
     * @return 当前AudioTheme对象
     */
    public func setAudioIconWidth(width: Float64): AudioTheme

    /**
     * 设置音频图标高度
     *
     * @param height 音频图标高度
     * @return 当前AudioTheme对象
     */
    public func setAudioIconHeight(height: Float64): AudioTheme

    /**
     * 统一设置音频图标整体圆角
     *
     * @param radius 圆角
     * @return 当前AudioTheme对象
     */
    public func setAudioIconRadius(radius: Float64): AudioTheme

    /**
     * 分别设置音频图标四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前AudioTheme对象
     */
    public func setAudioIconRadius(topLeft!: Float64 = 8.0, topRight!: Float64 = 8.0, bottomLeft!: Float64 = 8.0, bottomRight!: Float64 = 8.0): AudioTheme

    /**
     * 设置音频图标缩放类型
     *
     * @param fitType 音频图标缩放类型
     * @return 当前AudioTheme对象
     */
    public func setAudioIconFitType(fitType: ImageFit): AudioTheme

    /**
     * 设置音频标题文本和类型文本间距
     *
     * @param spacing 音频标题文本和类型文本间距
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleToTypeSpacing(spacing: Float64): AudioTheme

    /**
     * 设置音频标题文本颜色
     *
     * @param color 音频标题文本颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextFontColor(color: Color): AudioTheme

    /**
     * 设置音频标题文本尺寸
     *
     * @param size 音频标题文本尺寸
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextFontSize(size: Float64): AudioTheme

    /**
     * 设置音频标题文本字体样式
     *
     * @param style 音频标题文本字体样式
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextFontStyle(style: FontStyle): AudioTheme

    /**
     * 设置音频标题文本字体粗细
     *
     * @param weight 音频标题文本字体粗细
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextFontWeight(weight: FontWeight): AudioTheme

    /**
     * 设置音频标题文本字体
     *
     * @param family 音频标题文本字体
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextFontFamily(family: String): AudioTheme

    /**
     * 设置音频标题文本行高
     *
     * @param height 音频标题文本行高
     * @return 当前AudioTheme对象
     */
    public func setAudioTitleTextLineHeight(height: Float64): AudioTheme

    /**
     * 设置音频类型文本颜色
     *
     * @param color 音频类型文本颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextFontColor(color: Color): AudioTheme

    /**
     * 设置音频类型文本尺寸
     *
     * @param size 音频类型文本尺寸
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextFontSize(size: Float64): AudioTheme

    /**
     * 设置音频类型文本字体样式
     *
     * @param style 音频类型文本字体样式
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextFontStyle(style: FontStyle): AudioTheme

    /**
     * 设置音频类型文本字体粗细
     *
     * @param weight 音频类型文本字体粗细
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextFontWeight(weight: FontWeight): AudioTheme

    /**
     * 设置音频类型文本字体
     *
     * @param family 音频类型文本字体
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextFontFamily(family: String): AudioTheme

    /**
     * 设置音频类型文本行高
     *
     * @param height 音频类型文本行高
     * @return 当前AudioTheme对象
     */
    public func setAudioTypeTextLineHeight(height: Float64): AudioTheme

    /**
     * 设置音频按钮背景颜色
     *
     * @param color 音频按钮背景颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonBackgroundColor(color: Color): AudioTheme

    /**
     * 设置音频按钮宽度
     *
     * @param width 音频按钮宽度
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonWidth(width: Float64): AudioTheme

    /**
     * 设置音频按钮高度
     *
     * @param height 音频按钮高度
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonHeight(height: Float64): AudioTheme

    /**
     * 设置音频按钮边框样式
     *
     * @param borderStyle 音频按钮边框样式
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonBorderStyle(borderStyle: BorderStyle): AudioTheme

    /**
     * 设置音频按钮边框宽度
     *
     * @param borderWidth 音频按钮边框宽度
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonBorderWidth(borderWidth: Float64): AudioTheme

    /**
     * 设置音频按钮边框颜色
     *
     * @param borderColor 音频按钮边框颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonBorderColor(borderColor: Color): AudioTheme

    /**
     * 统一设置音频按钮整体圆角
     *
     * @param radius 圆角
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonRadius(radius: Float64): AudioTheme

    /**
     * 分别设置音频按钮四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonRadius(topLeft!: Float64 = 16.0, topRight!: Float64 = 16.0, bottomLeft!: Float64 = 16.0, bottomRight!: Float64 = 16.0): AudioTheme

    /**
     * 设置音频按钮默认文本内容
     *
     * @param text 音频按钮默认文本内容
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonText(text: String): AudioTheme

    /**
     * 设置音频按钮文本颜色
     *
     * @param color 音频按钮文本颜色
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextFontColor(color: Color): AudioTheme

    /**
     * 设置音频按钮文本尺寸
     *
     * @param size 音频按钮文本尺寸
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextFontSize(size: Float64): AudioTheme

    /**
     * 设置音频按钮文本字体样式
     *
     * @param style 音频按钮文本字体样式
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextFontStyle(style: FontStyle): AudioTheme

    /**
     * 设置音频按钮文本字体粗细
     *
     * @param weight 音频按钮文本字体粗细
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextFontWeight(weight: FontWeight): AudioTheme

    /**
     * 设置音频按钮文本字体
     *
     * @param family 音频按钮文本字体
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextFontFamily(family: String): AudioTheme

    /**
     * 设置音频按钮文本行高
     *
     * @param height 音频按钮文本行高
     * @return 当前AudioTheme对象
     */
    public func setAudioButtonTextLineHeight(height: Float64): AudioTheme
}
```

#### 视频样式

##### public class VideoTheme <: MarkdownBaseTheme

```cangjie
/**
 * 视频样式
 */
public class VideoTheme <: MarkdownBaseTheme {

    /**
     * 设置视频背景颜色
     * @param color 视频背景颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoBackgroundColor(color: Color): VideoTheme

    /**
     * 统一设置视频外边距
     * @param margin 外边距
     * @return 当前VideoTheme对象
     */
    public func setVideoMargin(margin: Float64): VideoTheme

    /**
     * 分别设置视频四个外边距
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前VideoTheme对象
     */
    public func setVideoMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): VideoTheme

    /**
     * 统一设置视频内边距
     * @param padding 内边距
     * @return 当前VideoTheme对象
     */
    public func setVideoPadding(padding: Float64): VideoTheme

    /**
     * 分别设置视频四个内边距
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前VideoTheme对象
     */
    public func setVideoPadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): VideoTheme

    /**
     * 统一设置视频整体圆角
     * @param radius 圆角
     * @return 当前VideoTheme对象
     */
    public func setVideoRadius(radius: Float64): VideoTheme

    /**
     * 分别设置视频四个圆角
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前VideoTheme对象
     */
    public func setVideoRadius(topLeft!: Float64 = 10.0, topRight!: Float64 = 10.0, bottomLeft!: Float64 = 10.0, bottomRight!: Float64 = 10.0): VideoTheme

    /**
     * 设置视频边框样式
     * @param borderStyle 视频边框样式
     * @return 当前VideoTheme对象
     */
    public func setVideoBorderStyle(borderStyle: BorderStyle): VideoTheme

    /**
     * 设置视频边框宽度
     * @param borderWidth 视频边框宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoBorderWidth(borderWidth: Float64): VideoTheme

    /**
     * 设置视频边框颜色
     * @param borderColor 视频边框颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoBorderColor(borderColor: Color): VideoTheme

    /**
     * 设置视频占位图
     * @param resource 视频占位图
     * @return 当前VideoTheme对象
     */
    public func setVideoPlaceholder(resource: AppResource): VideoTheme

    /**
     * 设置视频图片缩放类型
     * @param fitType 视频图片缩放类型
     * @return 当前VideoTheme对象
     */
    public func setVideoImageFitType(fitType: ImageFit): VideoTheme

    /**
     * 设置播放按钮默认图片
     * @param icon 播放按钮默认图片
     * @return 当前VideoTheme对象
     */
    public func setVideoPlayIcon(icon: AppResource): VideoTheme

    /**
     * 设置播放按钮图标宽度
     * @param width 播放按钮图标宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoPlayIconWidth(width: Float64): VideoTheme

    /**
     * 设置播放按钮图标高度
     * @param height 播放按钮图标高度
     * @return 当前VideoTheme对象
     */
    public func setVideoPlayIconHeight(height: Float64): VideoTheme

    /**
     * 设置播放按钮图标缩放类型
     * @param fitType 播放按钮图标缩放类型
     * @return 当前VideoTheme对象
     */
    public func setVideoPlayIconFitType(fitType: ImageFit): VideoTheme

    /**
     * 设置视频时间文本颜色
     * @param color 视频时间文本颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextFontColor(color: Color): VideoTheme

    /**
     * 设置视频时间文本尺寸
     * @param size 视频时间文本尺寸
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextFontSize(size: Float64): VideoTheme

    /**
     * 设置视频时间文本字体样式
     * @param style 视频时间文本字体样式
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextFontStyle(style: FontStyle): VideoTheme

    /**
     * 设置视频时间文本字体粗细
     * @param weight 视频时间文本字体粗细
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextFontWeight(weight: FontWeight): VideoTheme

    /**
     * 设置视频时间文本字体
     * @param family 视频时间文本字体
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextFontFamily(family: String): VideoTheme

    /**
     * 设置视频时间文本行高
     * @param height 视频时间文本行高
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextLineHeight(height: Float64): VideoTheme

    /**
     * 设置视频时间文本居右边距
     * @param margin 视频时间文本居右边距
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextMarginRight(margin: Float64): VideoTheme

    /**
     * 设置视频时间文本居底边距
     * @param margin 视频时间文本居底边距
     * @return 当前VideoTheme对象
     */
    public func setVideoTimeTextMarginBottom(margin: Float64): VideoTheme

    /**
     * 设置底部布局是否显示
     * @param visible 底部布局是否显示
     * @return 当前VideoTheme对象
     */
    public func setVideoBottomLayoutVisible(visible: Bool): VideoTheme

    /**
     * 设置底部布局距离视频上边距
     * @param marginTop 底部布局距离视频上边距
     * @return 当前VideoTheme对象
     */
    public func setVideoBottomLayoutMarginTop(marginTop: Float64): VideoTheme

    /**
     * 设置视频发布按钮是否显示
     * @param visible 视频发布按钮是否显示
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonVisible(visible: Bool): VideoTheme

    /**
     * 设置视频发布按钮背景颜色
     * @param color 视频发布按钮背景颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonBackgroundColor(color: Color): VideoTheme

    /**
     * 设置视频发布按钮宽度
     * @param width 视频发布按钮宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonWidth(width: Float64): VideoTheme

    /**
     * 设置视频发布按钮高度
     * @param height 视频发布按钮高度
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonHeight(height: Float64): VideoTheme

    /**
     * 统一设置视频发布按钮整体圆角
     * @param radius 圆角
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonRadius(radius: Float64): VideoTheme

    /**
     * 分别设置视频发布按钮四个圆角
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonRadius(topLeft!: Float64 = 22.0, topRight!: Float64 = 22.0, bottomLeft!: Float64 = 22.0, bottomRight!: Float64 = 22.0): VideoTheme

    /**
     * 设置视频发布按钮图标和文本间距
     * @param gap 视频发布按钮图标和文本间距
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonIconTextGap(gap: Float64): VideoTheme

    /**
     * 设置视频发布按钮图标
     * @param icon 视频发布按钮图标
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonIcon(icon: AppResource): VideoTheme

    /**
     * 设置视频发布按钮图标宽度
     * @param width 视频发布按钮图标宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonIconWidth(width: Float64): VideoTheme

    /**
     * 设置视频发布按钮图标高度
     * @param height 视频发布按钮图标高度
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonIconHeight(height: Float64): VideoTheme

    /**
     * 设置视频发布按钮默认文本内容
     * @param text 视频发布按钮默认文本内容
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonText(text: String): VideoTheme

    /**
     * 设置视频发布按钮文本颜色
     * @param color 视频发布按钮文本颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextFontColor(color: Color): VideoTheme

    /**
     * 设置视频发布按钮文本尺寸
     * @param size 视频发布按钮文本尺寸
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextFontSize(size: Float64): VideoTheme

    /**
     * 设置视频发布按钮文本字体样式
     * @param style 视频发布按钮文本字体样式
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextFontStyle(style: FontStyle): VideoTheme

    /**
     * 设置视频发布按钮文本字体粗细
     * @param weight 视频发布按钮文本字体粗细
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextFontWeight(weight: FontWeight): VideoTheme

    /**
     * 设置视频发布按钮文本字体
     * @param family 视频发布按钮文本字体
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextFontFamily(family: String): VideoTheme

    /**
     * 设置视频发布按钮文本行高
     * @param height 视频发布按钮文本行高
     * @return 当前VideoTheme对象
     */
    public func setVideoReleaseButtonTextLineHeight(height: Float64): VideoTheme

    /**
     * 设置视频下载按钮是否显示
     * @param visible 视频下载按钮是否显示
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonVisible(visible: Bool): VideoTheme

    /**
     * 设置视频下载按钮背景颜色
     * @param color 视频下载按钮背景颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonBackgroundColor(color: Color): VideoTheme

    /**
     * 设置视频下载按钮宽度
     * @param width 视频下载按钮宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonWidth(width: Float64): VideoTheme

    /**
     * 设置视频下载按钮高度
     * @param height 视频下载按钮高度
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonHeight(height: Float64): VideoTheme

    /**
     * 统一设置视频下载按钮整体圆角
     * @param radius 圆角
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonRadius(radius: Float64): VideoTheme

    /**
     * 分别设置视频下载按钮四个圆角
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonRadius(topLeft!: Float64 = 22.0, topRight!: Float64 = 22.0, bottomLeft!: Float64 = 22.0, bottomRight!: Float64 = 22.0): VideoTheme

    /**
     * 设置视频下载按钮图标和文本间距
     * @param gap 视频下载按钮图标和文本间距
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonIconTextGap(gap: Float64): VideoTheme

    /**
     * 设置视频下载按钮图标
     * @param icon 视频下载按钮图标
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonIcon(icon: AppResource): VideoTheme

    /**
     * 设置视频下载按钮图标宽度
     * @param width 视频下载按钮图标宽度
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonIconWidth(width: Float64): VideoTheme

    /**
     * 设置视频下载按钮图标高度
     * @param height 视频下载按钮图标高度
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonIconHeight(height: Float64): VideoTheme

    /**
     * 设置视频下载按钮默认文本内容
     * @param text 视频下载按钮默认文本内容
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonText(text: String): VideoTheme

    /**
     * 设置视频下载按钮文本颜色
     * @param color 视频下载按钮文本颜色
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextFontColor(color: Color): VideoTheme

    /**
     * 设置视频下载按钮文本尺寸
     * @param size 视频下载按钮文本尺寸
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextFontSize(size: Float64): VideoTheme

    /**
     * 设置视频下载按钮文本字体样式
     * @param style 视频下载按钮文本字体样式
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextFontStyle(style: FontStyle): VideoTheme

    /**
     * 设置视频下载按钮文本字体粗细
     * @param weight 视频下载按钮文本字体粗细
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextFontWeight(weight: FontWeight): VideoTheme

    /**
     * 设置视频下载按钮文本字体
     * @param family 视频下载按钮文本字体
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextFontFamily(family: String): VideoTheme

    /**
     * 设置视频下载按钮文本行高
     * @param height 视频下载按钮文本行高
     * @return 当前VideoTheme对象
     */
    public func setVideoDownloadButtonTextLineHeight(height: Float64): VideoTheme
}
```

#### 图片样式

##### public class ImageTheme <: MarkdownBaseTheme

```cangjie
/**
 * 图片样式
 */
public class ImageTheme <: MarkdownBaseTheme {
    /**
     * 设置4个外边距为统一值
     *
     * @param margin 外边距
     * @return 当前ImageTheme对象
     */
    public func setMargin(margin: Float64): ImageTheme

    /**
     * 分别设置4个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前ImageTheme对象
     */
    public func setMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): ImageTheme

    /**
     * 设置4个圆角为统一值
     *
     * @param radius 圆角
     * @return 当前ImageTheme对象
     */
    public func setRadius(radius: Float64): ImageTheme

    /**
     * 分别设置4个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前ImageTheme对象
     */
    public func setRadius(topLeft!: Float64 = 0.0, topRight!: Float64 = 0.0, bottomLeft!: Float64 = 0.0, bottomRight!: Float64 = 0.0): ImageTheme

    /**
     * 设置图片边框样式
     *
     * @param borderStyle 图片边框样式
     * @return 当前ImageTheme对象
     */
    public func setImageBorderStyle(borderStyle: BorderStyle): ImageTheme

    /**
     * 设置图片边框宽度
     *
     * @param borderWidth 图片边框宽度
     * @return 当前ImageTheme对象
     */
    public func setImageBorderWidth(borderWidth: Float64): ImageTheme

    /**
     * 设置图片边框颜色
     *
     * @param borderColor 图片边框颜色
     * @return 当前ImageTheme对象
     */
    public func setImageBorderColor(borderColor: Color): ImageTheme

    /**
     * 设置图片默认占位图
     *
     * @param placeholder 图片默认占位图
     * @return 当前ImageTheme对象
     */
    public func setImagePlaceholder(placeholder: AppResource): ImageTheme

    /**
     * 设置网络图片是否压缩
     *
     * @param imageAutoResize 网络图片是否压缩
     * @return 当前ImageTheme对象
     */
    public func setImageAutoResize(imageAutoResize: Bool): ImageTheme

    /**
     * 设置是否图文混排
     *
     * @param mixedLayout 是否图文混排
     * @return 当前ImageTheme对象
     */
    public func setIsImageMixedLayout(mixedLayout: Bool): ImageTheme

    /**
     * 设置图片基于自身宽度缩放百分比
     *
     * @param maximumWidth 图片基于自身宽度缩放百分比
     * @return 当前ImageTheme对象
     */
    public func setImageMaximumWidth(maximumWidth: Float64): ImageTheme

    /**
     * 设置图片最大高度
     *
     * @param maxHeight 图片最大高度
     * @return 当前ImageTheme对象
     */
    public func setImageMaxHeight(maxHeight: Float64): ImageTheme

    /**
     * 设置图片高度
     *
     * @param height 图片高度
     * @return 当前ImageTheme对象
     */
    public func setImageHeight(height: Float64): ImageTheme

    /**
     * 设置图片宽度
     *
     * @param width 图片宽度
     * @return 当前ImageTheme对象
     */
    public func setImageWidth(width: Float64): ImageTheme

    /**
     * 设置图片缩放类型
     *
     * @param fitType 图片缩放类型
     * @return 当前ImageTheme对象
     */
    public func setImageFitType(fitType: ImageFit): ImageTheme

    /**
     * 设置图片下载按钮是否显示
     *
     * @param visible 图片下载按钮是否显示
     * @return 当前ImageTheme对象
     */
    public func setImageDownloadButtonVisible(visible: Bool): ImageTheme
}
```

#### 表格样式

##### public class TableTheme <: MarkdownBaseTheme

```cangjie
/**
 * 表格样式
 */
public class TableTheme <: MarkdownBaseTheme {
    /**
     * 设置表格标题背景颜色
     *
     * @param color 表格标题背景颜色
     * @return 当前TableTheme对象
     */
    public func setTableTitleBackgroundColor(color: Color): TableTheme

    /**
     * 设置表格内容奇数行背景颜色
     *
     * @param color 奇数行背景颜色
     * @return 当前TableTheme对象
     */
    public func setTableContentOddRowBackgroundColor(color: Color): TableTheme

    /**
     * 设置表格内容偶数行背景颜色
     *
     * @param color 偶数行背景颜色
     * @return 当前TableTheme对象
     */
    public func setTableContentEvenRowBackgroundColor(color: Color): TableTheme

    /**
     * 统一设置表格外边距
     *
     * @param margin 外边距
     * @return 当前TableTheme对象
     */
    public func setTableMargin(margin: Float64): TableTheme

    /**
     * 分别设置表格四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前TableTheme对象
     */
    public func setTableMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): TableTheme

    /**
     * 统一设置表格内边距
     *
     * @param padding 内边距
     * @return 当前TableTheme对象
     */
    public func setTablePadding(padding: Float64): TableTheme

    /**
     * 统一设置表格内容内边距
     *
     * @param padding 内边距
     * @return 当前TableTheme对象
     */
    public func setTableCellPadding(padding: Float64): TableTheme

    /**
     * 设置表格边框样式
     *
     * @param style 表格边框样式
     * @return 当前TableTheme对象
     */
    public func setTableBorderStyle(style: BorderStyle): TableTheme

    /**
     * 设置表格边框宽度
     *
     * @param width 表格边框宽度
     * @return 当前TableTheme对象
     */
    public func setTableBorderWidth(width: Float64): TableTheme

    /**
     * 设置表格边框颜色
     *
     * @param color 表格边框颜色
     * @return 当前TableTheme对象
     */
    public func setTableBorderColor(color: Color): TableTheme

    /**
     * 统一设置表格边框四个圆角
     *
     * @param radius 圆角半径
     * @return 当前TableTheme对象
     */
    public func setTableRadius(radius: Float64): TableTheme

    /**
     * 设置表格滚动条状态
     *
     * @param state 滚动条状态
     * @return 当前TableTheme对象
     */
    public func setTableScrollBarState(state: BarState): TableTheme

    /**
     * 设置表格一格最小宽度
     *
     * @param width 最小宽度
     * @return 当前TableTheme对象
     */
    public func setTableMinCellWidth(width: Float64): TableTheme

    /**
     * 设置表格一格最大宽度
     *
     * @param width 最大宽度
     * @return 当前TableTheme对象
     */
    public func setTableMaxCellWidth(width: Float64): TableTheme

    /**
     * 设置表格第一列是否加粗
     *
     * @param isBold 是否加粗
     * @return 当前TableTheme对象
     */
    public func setTableFirstColumnIsBold(isBold: Bool): TableTheme

    /**
     * 设置表格标题文本颜色
     *
     * @param color 表格标题文本颜色
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextFontColor(color: Color): TableTheme

    /**
     * 设置表格标题文本尺寸
     *
     * @param size 表格标题文本尺寸
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextFontSize(size: Float64): TableTheme

    /**
     * 设置表格内容文本颜色
     *
     * @param color 表格内容文本颜色
     * @return 当前TableTheme对象
     */
    public func setTableContentTextFontColor(color: Color): TableTheme

    /**
     * 设置表格内容文本尺寸
     *
     * @param size 表格内容文本尺寸
     * @return 当前TableTheme对象
     */
    public func setTableContentTextFontSize(size: Float64): TableTheme

    /**
     * 分别设置表格四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前TableTheme对象
     */
    public func setTablePadding(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): TableTheme

    /**
     * 分别设置表格内容四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前TableTheme对象
     */
    public func setTableCellPadding(top!: Float64 = 4.0, right!: Float64 = 4.0, bottom!: Float64 = 4.0, left!: Float64 = 4.0): TableTheme

    /**
     * 分别设置表格边框四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前TableTheme对象
     */
    public func setTableRadius(topLeft!: Float64 = 5.0, topRight!: Float64 = 5.0, bottomLeft!: Float64 = 5.0, bottomRight!: Float64 = 5.0): TableTheme

    /**
     * 设置表格滚动条颜色
     *
     * @param color 滚动条颜色
     * @return 当前TableTheme对象
     */
    public func setTableScrollBarColor(color: Color): TableTheme

    /**
     * 设置表格标题文本字体样式
     *
     * @param style 表格标题文本字体样式
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextFontStyle(style: FontStyle): TableTheme

    /**
     * 设置表格标题文本字体粗细
     *
     * @param weight 表格标题文本字体粗细
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextFontWeight(weight: FontWeight): TableTheme

    /**
     * 设置表格标题文本字体
     *
     * @param family 表格标题文本字体
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextFontFamily(family: String): TableTheme

    /**
     * 设置表格标题文本行高
     *
     * @param lineHeight 表格标题文本行高
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextLineHeight(lineHeight: Float64): TableTheme

    /**
     * 设置表格标题文本字符间距
     *
     * @param spacing 表格标题文本字符间距
     * @return 当前TableTheme对象
     */
    public func setTableTitleTextLetterSpacing(spacing: Float64): TableTheme

    /**
     * 设置表格内容文本字体样式
     *
     * @param style 表格内容文本字体样式
     * @return 当前TableTheme对象
     */
    public func setTableContentTextFontStyle(style: FontStyle): TableTheme

    /**
     * 设置表格内容文本字体粗细
     *
     * @param weight 表格内容文本字体粗细
     * @return 当前TableTheme对象
     */
    public func setTableContentTextFontWeight(weight: FontWeight): TableTheme

    /**
     * 设置表格内容文本字体
     *
     * @param family 表格内容文本字体
     * @return 当前TableTheme对象
     */
    public func setTableContentTextFontFamily(family: String): TableTheme

    /**
     * 设置表格内容文本行高
     *
     * @param lineHeight 表格内容文本行高
     * @return 当前TableTheme对象
     */
    public func setTableContentTextLineHeight(lineHeight: Float64): TableTheme

    /**
     * 设置表格内容文本字符间距
     *
     * @param spacing 表格内容文本字符间距
     * @return 当前TableTheme对象
     */
    public func setTableContentTextLetterSpacing(spacing: Float64): TableTheme
}
```

#### 标题样式

##### public class HeadingTheme <: MarkdownBaseTheme

```cangjie
/**
 * 标题样式
 */
public class HeadingTheme <: MarkdownBaseTheme {
    /**
     * 设置标题的背景颜色:设置所有标题为统一背景颜色
     *
     * @param color 背景颜色
     * @return 当前HeadingTheme对象
     */
    public func setBackgroundColorForAllHeading(color: Color): HeadingTheme

    /**
     * 设置标题的背景颜色:通过集合的方式,分别设置每级标题的背景颜色
     *
     * @param colorList 背景颜色集合
     * @return 当前HeadingTheme对象
     */
    public func setBackgroundColorForEachHeading(colorList: Array<Color>): HeadingTheme

    /**
     * 设置标题的背景颜色:指定标题等级,设置该等级标题的背景颜色
     *
     * @param level 标题等级
     * @param color 背景颜色
     * @return 当前HeadingTheme对象
     */
    public func setBackgroundColorForDesignateHeading(level: Int64, color: Color): HeadingTheme

    /**
     * 设置标题的4个外边距:设置H1-H6级标题所有4个外边距为统一值
     *
     * @param margin 外边距
     * @return 当前HeadingTheme对象
     */
    public func setMarginForAllHeading(margin: Float64): HeadingTheme

    /**
     * 设置标题的4个外边距:指定标题等级,设置标题的4个外边距为统一值
     *
     * @param level 标题等级
     * @param margin 外边距
     * @return 当前HeadingTheme对象
     */
    public func setMarginForDesignateHeading(level: Int64, margin: Float64): HeadingTheme

    /**
     * 设置标题文本颜色:所有标题的统一文本颜色
     *
     * @param color 文本颜色
     * @return 当前HeadingTheme对象
     */
    public func setTextFontColorForAllHeading(color: Color): HeadingTheme

    /**
     * 设置标题文本颜色:设置指定等级的标题的文本颜色
     *
     * @param level 标题等级
     * @param color 文本颜色
     * @return 当前HeadingTheme对象
     */
    public func setTextFontColorForDesignateHeading(level: Int64, color: Color): HeadingTheme

    /**
     * 设置标题文本尺寸:所有标题的统一文本尺寸
     *
     * @param size 文本尺寸
     * @return 当前HeadingTheme对象
     */
    public func setTextFontSizeForAllHeading(size: Float64): HeadingTheme

    /**
     * 设置标题文本字体粗细:所有标题的统一文本字体粗细
     *
     * @param weight 文本字体粗细
     * @return 当前HeadingTheme对象
     */
    public func setTextFontWeightForAllHeading(weight: FontWeight): HeadingTheme

    /**
     * 设置标题文本字体:所有标题的统一文本字体
     *
     * @param family 文本字体
     * @return 当前HeadingTheme对象
     */
    public func setTextFontFamilyForAllHeading(family: String): HeadingTheme

    /**
     * 设置标题文本行高:所有标题的统一文本行高
     *
     * @param lineHeight 文本行高
     * @return 当前HeadingTheme对象
     */
    public func setTextLineHeightForAllHeading(lineHeight: Float64): HeadingTheme

    /**
     * 设置标题下划线高度:H1和H2标题的统一下划线高度
     *
     * @param height 下划线高度
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineHeightForAllHeading(height: Float64): HeadingTheme

    /**
     * 设置标题下划线颜色:H1和H2标题的统一下划线颜色
     *
     * @param color 下划线颜色
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineColorForAllHeading(color: Color): HeadingTheme

    /**
     * 设置标题的4个外边距：设置H1-H6级标题，每级标题自己的4个外边距为统一值
     *
     * @param marginList 外边距集合
     * @return 当前HeadingTheme对象
     */
    public func setMarginForEachHeading(marginList: Array<Float64>): HeadingTheme

    /**
     * 设置标题的4个外边距：分别设置H1-H6每级标题的每个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前HeadingTheme对象
     */
    public func setMarginForEachHeading(top!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], right!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], bottom!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], left!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]): HeadingTheme

    /**
     * 设置标题的4个外边距：指定标题等级，分别设置该标题的每个外边距
     *
     * @param level 标题等级
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前HeadingTheme对象
     */
    public func setMarginForDesignateHeading(level: Int64, top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): HeadingTheme

    /**
     * 设置标题的4个内边距：设置H1-H6级标题所有4个内边距为统一值
     *
     * @param padding 内边距
     * @return 当前HeadingTheme对象
     */
    public func setPaddingForAllHeading(padding: Float64): HeadingTheme

    /**
     * 设置标题的4个内边距：设置H1-H6级标题，每级标题自己的4个内边距为统一值
     *
     * @param paddingList 内边距集合
     * @return 当前HeadingTheme对象
     */
    public func setPaddingForEachHeading(paddingList: Array<Float64>): HeadingTheme

    /**
     * 设置标题的4个内边距：指定标题等级，设置标题的4个内边距为统一值
     *
     * @param level 标题等级
     * @param padding 内边距
     * @return 当前HeadingTheme对象
     */
    public func setPaddingForDesignateHeading(level: Int64, padding: Float64): HeadingTheme

    /**
     * 设置标题的4个内边距：分别设置H1-H6每级标题的每个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前HeadingTheme对象
     */
    public func setPaddingForEachHeading(top!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], right!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], bottom!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0], left!: Array<Float64> = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]): HeadingTheme

    /**
     * 设置标题的4个内边距：指定标题等级，分别设置该标题的每个内边距
     *
     * @param level 标题等级
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前HeadingTheme对象
     */
    public func setPaddingForDesignateHeading(level: Int64, top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): HeadingTheme

    /**
     * 设置标题文本颜色：分别设置每级标题的文本颜色
     *
     * @param colorList 文本颜色集合
     * @return 当前HeadingTheme对象
     */
    public func setTextFontColorForEachHeading(colorList: Array<Color>): HeadingTheme

    /**
     * 设置标题文本尺寸：分别设置每级标题的文本尺寸
     *
     * @param sizeList 文本尺寸集合
     * @return 当前HeadingTheme对象
     */
    public func setTextFontSizeForEachHeading(sizeList: Array<Float64>): HeadingTheme

    /**
     * 设置标题文本尺寸：设置指定等级的标题的文本尺寸
     *
     * @param level 标题等级
     * @param size 文本尺寸
     * @return 当前HeadingTheme对象
     */
    public func setTextFontSizeForDesignateHeading(level: Int64, size: Float64): HeadingTheme

    /**
     * 设置标题文本字体样式：所有标题的统一文本字体样式
     *
     * @param style 文本字体样式
     * @return 当前HeadingTheme对象
     */
    public func setTextFontStyleForAllHeading(style: FontStyle): HeadingTheme

    /**
     * 设置标题文本字体样式：分别设置每级标题的文本字体样式
     *
     * @param styleList 文本字体样式集合
     * @return 当前HeadingTheme对象
     */
    public func setTextFontStyleForEachHeading(styleList: Array<FontStyle>): HeadingTheme

    /**
     * 设置标题文本字体样式：设置指定等级的标题的文本字体样式
     *
     * @param level 标题等级
     * @param style 文本字体样式
     * @return 当前HeadingTheme对象
     */
    public func setTextFontStyleForDesignateHeading(level: Int64, style: FontStyle): HeadingTheme

    /**
     * 设置标题文本字体粗细：分别设置每级标题的文本字体粗细
     *
     * @param weightList 文本字体粗细集合
     * @return 当前HeadingTheme对象
     */
    public func setTextFontWeightForEachHeading(weightList: Array<FontWeight>): HeadingTheme

    /**
     * 设置标题文本字体粗细：设置指定等级的标题的文本字体粗细
     *
     * @param level 标题等级
     * @param weight 文本字体粗细
     * @return 当前HeadingTheme对象
     */
    public func setTextFontWeightForDesignateHeading(level: Int64, weight: FontWeight): HeadingTheme

    /**
     * 设置标题文本字体：分别设置每级标题的文本字体
     *
     * @param familyList 文本字体集合
     * @return 当前HeadingTheme对象
     */
    public func setTextFontFamilyForEachHeading(familyList: Array<String>): HeadingTheme

    /**
     * 设置标题文本字体：设置指定等级的标题的文本字体
     *
     * @param level 标题等级
     * @param family 文本字体
     * @return 当前HeadingTheme对象
     */
    public func setTextFontFamilyForDesignateHeading(level: Int64, family: String): HeadingTheme

    /**
     * 设置标题文本行高：分别设置每级标题的文本行高
     *
     * @param lineHeightList 文本行高集合
     * @return 当前HeadingTheme对象
     */
    public func setTextLineHeightForEachHeading(lineHeightList: Array<Float64>): HeadingTheme

    /**
     * 设置标题文本行高：设置指定等级的标题的文本行高
     *
     * @param level 标题等级
     * @param lineHeight 文本行高
     * @return 当前HeadingTheme对象
     */
    public func setTextLineHeightForDesignateHeading(level: Int64, lineHeight: Float64): HeadingTheme

    /**
     * 设置标题文本字符间距：所有标题的统一文本字符间距
     *
     * @param spacing 文本字符间距
     * @return 当前HeadingTheme对象
     */
    public func setTextLetterSpacingForAllHeading(spacing: Float64): HeadingTheme

    /**
     * 设置标题文本字符间距：分别设置每级标题的文本字符间距
     *
     * @param spacingList 文本字符间距集合
     * @return 当前HeadingTheme对象
     */
    public func setTextLetterSpacingForEachHeading(spacingList: Array<Float64>): HeadingTheme

    /**
     * 设置标题文本字符间距：设置指定等级的标题的文本字符间距
     *
     * @param level 标题等级
     * @param spacing 文本字符间距
     * @return 当前HeadingTheme对象
     */
    public func setTextLetterSpacingForDesignateHeading(level: Int64, spacing: Float64): HeadingTheme

    /**
     * 设置标题下划线高度：设置指定等级标题的下划线高度（仅H1和H2）
     *
     * @param level 标题等级
     * @param height 下划线高度
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineHeightForDesignateHeading(level: Int64, height: Float64): HeadingTheme

    /**
     * 设置标题下划线颜色：设置指定等级标题的下划线颜色（仅H1和H2）
     *
     * @param level 标题等级
     * @param color 下划线颜色
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineColorForDesignateHeading(level: Int64, color: Color): HeadingTheme

    /**
     * 设置标题下划线间距：H1和H2标题的统一下划线间距
     *
     * @param spacing 下划线间距
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineSpacingForAllHeading(spacing: Float64): HeadingTheme

    /**
     * 设置标题下划线间距：设置指定等级标题的下划线间距（仅H1和H2）
     *
     * @param level 标题等级
     * @param spacing 下划线间距
     * @return 当前HeadingTheme对象
     */
    public func setUnderlineSpacingForDesignateHeading(level: Int64, spacing: Float64): HeadingTheme
}
```

#### 代码块样式

##### public class CodeBlockTheme <: MarkdownBaseTheme

```cangjie
/**
 * 代码块样式
 */
public class CodeBlockTheme <: MarkdownBaseTheme {
    /**
     * 设置是否格式化围栏代码块内容
     *
     * @param isCodeFormat 是否格式化围栏代码块内容
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockIsCodeFormat(isCodeFormat: Bool): CodeBlockTheme

    /**
     * 设置codeformat是否用制表符
     *
     * @param useTab 是否用制表符
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockUseTab(useTab: Bool): CodeBlockTheme

    /**
     * 设置codeformat空格缩进数量
     *
     * @param indentWidth 空格缩进数量
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockIndentWidth(indentWidth: Int64): CodeBlockTheme

    /**
     * 设置围栏代码块代码高亮是否同步解析
     *
     * @param parserSync 是否同步解析
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockParserSync(parserSync: Bool): CodeBlockTheme

    /**
     * 设置代码块背景颜色
     *
     * @param color 代码块背景颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockBackgroundColor(color: Color): CodeBlockTheme

    /**
     * 代码块整体外边距
     *
     * @param margin 外边距
     * @return 当前CodeBlockTheme对象
     */
    public func setMargin(margin: Float64): CodeBlockTheme

    /**
     * 代码块分别设置四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前CodeBlockTheme对象
     */
    public func setMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 0.0): CodeBlockTheme

    /**
     * 代码块整体内边距
     *
     * @param padding 内边距
     * @return 当前CodeBlockTheme对象
     */
    public func setPadding(padding: Float64): CodeBlockTheme

    /**
     * 代码块分别设置四个内边距
     *
     * @param top 上内边距 命名参数
     * @param right 右内边距 命名参数
     * @param bottom 下内边距 命名参数
     * @param left 左内边距 命名参数
     * @return 当前CodeBlockTheme对象
     */
    public func setPadding(top!: Float64 = 0.0, right!: Float64 = 8.0, bottom!: Float64 = 8.0, left!: Float64 = 0.0): CodeBlockTheme

    /**
     * 设置代码块边框样式
     *
     * @param borderStyle 代码块边框样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockBorderStyle(borderStyle: BorderStyle): CodeBlockTheme

    /**
     * 设置代码块边框宽度
     *
     * @param borderWidth 代码块边框宽度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockBorderWidth(borderWidth: Float64): CodeBlockTheme

    /**
     * 设置代码块边框颜色
     *
     * @param borderColor 代码块边框颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockBorderColor(borderColor: Color): CodeBlockTheme

    /**
     * 代码块整体圆角
     *
     * @param radius 圆角
     * @return 当前CodeBlockTheme对象
     */
    public func setRadius(radius: Float64): CodeBlockTheme

    /**
     * 代码块分别设置四个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前CodeBlockTheme对象
     */
    public func setRadius(topLeft!: Float64 = 8.0, topRight!: Float64 = 8.0, bottomLeft!: Float64 = 8.0, bottomRight!: Float64 = 8.0): CodeBlockTheme

    /**
     * 设置代码块类型和代码块内容间距
     *
     * @param marginBottom 代码块类型和代码块内容间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTitleLayoutMarginBottom(marginBottom: Float64): CodeBlockTheme

    /**
     * 设置代码块类型左边距
     *
     * @param marginLeft 代码块类型左边距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextMarginLeft(marginLeft: Float64): CodeBlockTheme

    /**
     * 设置代码块没有代码类型时默认显示文本
     *
     * @param text 默认显示文本
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeText(text: String): CodeBlockTheme

    /**
     * 设置代码块类型文本颜色
     *
     * @param color 代码块类型文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextFontColor(color: Color): CodeBlockTheme

    /**
     * 设置代码块类型文本尺寸
     *
     * @param size 代码块类型文本尺寸
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextFontSize(size: Float64): CodeBlockTheme

    /**
     * 设置代码块类型文本字体样式
     *
     * @param style 代码块类型文本字体样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextFontStyle(style: FontStyle): CodeBlockTheme

    /**
     * 设置代码块类型文本字体粗细
     *
     * @param weight 代码块类型文本字体粗细
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextFontWeight(weight: FontWeight): CodeBlockTheme

    /**
     * 设置代码块类型文本字体
     *
     * @param family 代码块类型文本字体
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextFontFamily(family: String): CodeBlockTheme

    /**
     * 设置代码块类型文本行高
     *
     * @param height 代码块类型文本行高
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTypeTextLineHeight(height: Float64): CodeBlockTheme

    /**
     * 设置代码块代码复制和代码全屏间距
     *
     * @param spacing 代码块代码复制和代码全屏间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyFullScreenSpacing(spacing: Float64): CodeBlockTheme

    /**
     * 设置代码块代码复制按钮是否显示
     *
     * @param isShow 是否显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyButtonIsShow(isShow: Bool): CodeBlockTheme

    /**
     * 设置代码块代码复制文本是否显示
     *
     * @param isShow 是否显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextIsShow(isShow: Bool): CodeBlockTheme

    /**
     * 设置代码块代码复制按钮默认图标
     *
     * @param icon 默认图标
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyIcon(icon: AppResource): CodeBlockTheme

    /**
     * 设置代码块代码复制图标宽度
     *
     * @param width 图标宽度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyIconWidth(width: Float64): CodeBlockTheme

    /**
     * 设置代码块代码复制图标高度
     *
     * @param height 图标高度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyIconHeight(height: Float64): CodeBlockTheme

    /**
     * 设置代码块代码复制图标和文本间距
     *
     * @param spacing 代码块代码复制图标和文本间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyIconTextSpacing(spacing: Float64): CodeBlockTheme

    /**
     * 设置代码块代码复制默认文本内容
     *
     * @param text 默认文本内容
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyText(text: String): CodeBlockTheme

    /**
     * 设置代码块代码复制文本颜色
     *
     * @param color 代码块代码复制文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextFontColor(color: Color): CodeBlockTheme

    /**
     * 设置代码块代码复制文本尺寸
     *
     * @param size 代码块代码复制文本尺寸
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextFontSize(size: Float64): CodeBlockTheme

    /**
     * 设置代码块代码复制文本字体样式
     *
     * @param style 代码块代码复制文本字体样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextFontStyle(style: FontStyle): CodeBlockTheme

    /**
     * 设置代码块代码复制文本字体粗细
     *
     * @param weight 代码块代码复制文本字体粗细
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextFontWeight(weight: FontWeight): CodeBlockTheme

    /**
     * 设置代码块代码复制文本字体
     *
     * @param family 代码块代码复制文本字体
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextFontFamily(family: String): CodeBlockTheme

    /**
     * 设置代码块代码复制文本行高
     *
     * @param height 代码块代码复制文本行高
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockCopyTextLineHeight(height: Float64): CodeBlockTheme

    /**
     * 设置代码块代码全屏按钮是否显示
     *
     * @param isShow 是否显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenButtonIsShow(isShow: Bool): CodeBlockTheme

    /**
     * 设置代码块代码全屏文本是否显示
     *
     * @param isShow 是否显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextIsShow(isShow: Bool): CodeBlockTheme

    /**
     * 设置代码块代码全屏按钮默认图标
     *
     * @param icon 默认图标
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenIcon(icon: AppResource): CodeBlockTheme

    /**
     * 设置代码块代码全屏图标宽度
     *
     * @param width 图标宽度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenIconWidth(width: Float64): CodeBlockTheme

    /**
     * 设置代码块代码全屏图标高度
     *
     * @param height 图标高度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenIconHeight(height: Float64): CodeBlockTheme

    /**
     * 设置代码块代码全屏图标和文本间距
     *
     * @param spacing 代码块代码全屏图标和文本间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenIconTextSpacing(spacing: Float64): CodeBlockTheme

    /**
     * 设置代码块代码全屏默认文本内容
     *
     * @param text 默认文本内容
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenText(text: String): CodeBlockTheme

    /**
     * 设置代码块代码全屏文本颜色
     *
     * @param color 代码块代码全屏文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextFontColor(color: Color): CodeBlockTheme

    /**
     * 设置代码块代码全屏文本尺寸
     *
     * @param size 代码块代码全屏文本尺寸
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextFontSize(size: Float64): CodeBlockTheme

    /**
     * 设置代码块代码全屏文本字体样式
     *
     * @param style 代码块代码全屏文本字体样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextFontStyle(style: FontStyle): CodeBlockTheme

    /**
     * 设置代码块代码全屏文本字体粗细
     *
     * @param weight 代码块代码全屏文本字体粗细
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextFontWeight(weight: FontWeight): CodeBlockTheme

    /**
     * 设置代码块代码全屏文本字体
     *
     * @param family 代码块代码全屏文本字体
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextFontFamily(family: String): CodeBlockTheme

    /**
     * 设置代码块代码全屏文本行高
     *
     * @param height 代码块代码全屏文本行高
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockFullScreenTextLineHeight(height: Float64): CodeBlockTheme

    /**
     * 设置代码块代码行号是否显示
     *
     * @param isShow 是否显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberIsShow(isShow: Bool): CodeBlockTheme

    /**
     * 设置代码块代码行号左内边距
     *
     * @param left 代码块代码行号左内边距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextPaddingLeft(left: Float64): CodeBlockTheme

    /**
     * 设置代码块代码行号文本颜色
     *
     * @param color 代码块代码行号文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextFontColor(color: Color): CodeBlockTheme

    /**
     * 设置代码块代码行号文本尺寸
     *
     * @param size 代码块代码行号文本尺寸
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextFontSize(size: Float64): CodeBlockTheme

    /**
     * 设置代码块代码行号文本字体样式
     *
     * @param style 代码块代码行号文本字体样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextFontStyle(style: FontStyle): CodeBlockTheme

    /**
     * 设置代码块代码行号文本字体粗细
     *
     * @param weight 代码块代码行号文本字体粗细
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextFontWeight(weight: FontWeight): CodeBlockTheme

    /**
     * 设置代码块代码行号文本字体
     *
     * @param family 代码块代码行号文本字体
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextFontFamily(family: String): CodeBlockTheme

    /**
     * 设置代码块代码行号文本行高
     *
     * @param height 代码块代码行号文本行高
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberTextLineHeight(height: Float64): CodeBlockTheme

    /**
     * 设置代码块代码行号和代码块中间分割线颜色
     *
     * @param color 分割线颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockDividerColor(color: Color): CodeBlockTheme

    /**
     * 设置代码块代码行号和代码块中间分割线宽度
     *
     * @param strokeWidth 分割线宽度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockDividerStrokeWidth(strokeWidth: Float64): CodeBlockTheme

    /**
     * 设置代码块代码行号和分割线间距
     *
     * @param spacing 代码块代码行号和分割线间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockLineNumberDividerSpacing(spacing: Float64): CodeBlockTheme

    /**
     * 设置代码块代码文本右外边距
     *
     * @param marginRight 代码块代码文本右外边距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextMarginRight(marginRight: Float64): CodeBlockTheme

    /**
     * 设置代码块代码文本左外边距
     *
     * @param marginLeft 代码块代码文本左外边距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextMarginLeft(marginLeft: Float64): CodeBlockTheme

    /**
     * 设置代码块代码文本颜色
     *
     * @param color 代码块代码文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextFontColor(color: Color): CodeBlockTheme

    /**
     * 设置代码块代码文本尺寸
     *
     * @param size 代码块代码文本尺寸
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextFontSize(size: Float64): CodeBlockTheme

    /**
     * 设置代码块代码文本字体样式
     *
     * @param style 代码块代码文本字体样式
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextFontStyle(style: FontStyle): CodeBlockTheme

    /**
     * 设置代码块代码文本字体粗细
     *
     * @param weight 代码块代码文本字体粗细
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextFontWeight(weight: FontWeight): CodeBlockTheme

    /**
     * 设置代码块代码文本字体
     *
     * @param family 代码块代码文本字体
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextFontFamily(family: String): CodeBlockTheme

    /**
     * 设置代码块代码文本行高
     *
     * @param height 代码块代码文本行高
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextLineHeight(height: Float64): CodeBlockTheme

    /**
     * 设置代码块代码文本字符间距
     *
     * @param spacing 代码块代码文本字符间距
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockTextLetterSpacing(spacing: Float64): CodeBlockTheme

    /**
     * 设置组合代码块未选中标题字体大小
     *
     * @param size 字体大小
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleTextSize(size: Float64): CodeBlockTheme

    /**
     * 设置组合代码块选中标题字体大小
     *
     * @param size 字体大小
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleSelectTextSize(size: Float64): CodeBlockTheme

    /**
     * 设置组合代码块选中标题文本颜色
     *
     * @param color 文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleSelectTextColor(color: Color): CodeBlockTheme

    /**
     * 设置组合代码块未选中标题文本颜色
     *
     * @param color 文本颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleUnselectTextColor(color: Color): CodeBlockTheme

    /**
     * 设置组合代码块选中标题背景颜色
     *
     * @param color 背景颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleSelectBackgroundColor(color: Color): CodeBlockTheme

    /**
     * 设置组合代码块未选中标题背景颜色
     *
     * @param color 背景颜色
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockListTitleUnselectBackgroundColor(color: Color): CodeBlockTheme

    /**
     * 设置是否单独代码块显示
     *
     * @param isSeparate 是否单独显示
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockIsSeparate(isSeparate: Bool): CodeBlockTheme

    /**
     * 设置单独代码块行号宽度
     *
     * @param width 行号宽度
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockSeparateWidth(width: Float64): CodeBlockTheme

    /**
     * 设置单独代码块是否居底显示
     *
     * @param isBottom 是否居底
     * @return 当前CodeBlockTheme对象
     */
    public func setCodeBlockSeparateIsBottom(isBottom: Bool): CodeBlockTheme
}
```

#### 链接文本样式

##### public class LinkTheme <: MarkdownBaseTheme

```cangjie
/**
 * 链接文本样式
 */
public class LinkTheme <: MarkdownBaseTheme {
    /**
     * 设置链接是否是图片显示
     *
     * @param isIcon 链接是否是图片显示
     * @return 当前LinkTheme对象
     */
    public func setLinkIsIcon(isIcon: Bool): LinkTheme

    /**
     * 设置列表中的单行链接是否是图片显示
     *
     * @param isIcon 列表中的单行链接是否是图片显示
     * @return 当前LinkTheme对象
     */
    public func setLinkListIsIcon(isIcon: Bool): LinkTheme

    /**
     * 设置链接文本颜色
     *
     * @param color 链接文本颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkTextFontColor(color: Color): LinkTheme

    /**
     * 设置链接文本尺寸
     *
     * @param size 链接文本尺寸
     * @return 当前LinkTheme对象
     */
    public func setLinkTextFontSize(size: Float64): LinkTheme

    /**
     * 设置链接文本字体样式
     *
     * @param style 链接文本字体样式
     * @return 当前LinkTheme对象
     */
    public func setLinkTextFontStyle(style: FontStyle): LinkTheme

    /**
     * 设置链接文本字体粗细
     *
     * @param weight 链接文本字体粗细
     * @return 当前LinkTheme对象
     */
    public func setLinkTextFontWeight(weight: FontWeight): LinkTheme

    /**
     * 设置链接文本字体
     *
     * @param family 链接文本字体
     * @return 当前LinkTheme对象
     */
    public func setLinkTextFontFamily(family: String): LinkTheme

    /**
     * 设置链接文本行高
     *
     * @param lineHeight 链接文本行高
     * @return 当前LinkTheme对象
     */
    public func setLinkTextLineHeight(lineHeight: Float64): LinkTheme

    /**
     * 设置链接文本字符间距
     *
     * @param spacing 链接文本字符间距
     * @return 当前LinkTheme对象
     */
    public func setLinkTextLetterSpacing(spacing: Float64): LinkTheme

    /**
     * 设置链接文本装饰线类型
     *
     * @param decorationType 链接文本装饰线类型
     * @return 当前LinkTheme对象
     */
    public func setLinkTextDecorationType(decorationType: TextDecorationType): LinkTheme

    /**
     * 设置链接文本装饰线颜色
     *
     * @param color 链接文本装饰线颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkTextDecorationColor(color: Color): LinkTheme

    /**
     * 设置链接文本装饰线样式
     *
     * @param style 链接文本装饰线样式
     * @return 当前LinkTheme对象
     */
    public func setLinkTextDecorationStyle(style: MarkdownTextDecorationStyle): LinkTheme

    /**
     * 设置链接文本背景颜色
     *
     * @param color 链接文本背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkTextBackgroundColor(color: Color): LinkTheme

    /**
     * 统一设置链接文本背景四个圆角
     *
     * @param radius 统一圆角半径,同时赋值给四个角
     * @return 当前LinkTheme对象
     */
    public func setLinkTextBackgroundRadius(radius: Float64): LinkTheme

    /**
     * 分别设置4个圆角
     *
     * @param topLeft 左上圆角 命名参数
     * @param topRight 右上圆角 命名参数
     * @param bottomLeft 左下圆角 命名参数
     * @param bottomRight 右下圆角 命名参数
     * @return 当前LinkTheme对象
     */
    public func setLinkTextBackgroundRadius(topLeft!: Float64, topRight!: Float64, bottomLeft!: Float64, bottomRight!: Float64): LinkTheme

    /**
     * 设置圆形图片格式链接主题背景颜色
     *
     * @param color 圆形图片格式链接主题背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconBackgroundColor(color: Color): LinkTheme

    /**
     * 设置圆形图片格式链接控件背景颜色
     *
     * @param color 圆形图片格式链接控件背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconButtonBackgroundColor(color: Color): LinkTheme

    /**
     * 设置圆形图片格式链接文字大小
     *
     * @param size 圆形图片格式链接文字大小
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconTextSize(size: Float64): LinkTheme

    /**
     * 设置圆形图片格式链接文字颜色
     *
     * @param color 圆形图片格式链接文字颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconTextColor(color: Color): LinkTheme

    /**
     * 设置圆形图片格式链接半径
     *
     * @param radius 圆形图片格式链接半径
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconRadius(radius: Float64): LinkTheme

    /**
     * 设置圆形图片格式链接左右外边距
     *
     * @param margin 圆形图片格式链接左右外边距
     * @return 当前LinkTheme对象
     */
    public func setLinkCircleIconMargin(margin: Float64): LinkTheme

    /**
     * 设置圆角矩形图片格式链接主题背景颜色
     *
     * @param color 圆角矩形图片格式链接主题背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconBackgroundColor(color: Color): LinkTheme

    /**
     * 设置圆角矩形图片格式链接控件背景颜色
     *
     * @param color 圆角矩形图片格式链接控件背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconButtonBackgroundColor(color: Color): LinkTheme

    /**
     * 设置圆角矩形图片格式链接文字大小
     *
     * @param size 圆角矩形图片格式链接文字大小
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconTextSize(size: Float64): LinkTheme

    /**
     * 设置圆角矩形图片格式链接文字颜色
     *
     * @param color 圆角矩形图片格式链接文字颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconTextColor(color: Color): LinkTheme

    /**
     * 设置圆角矩形图片格式链接控件高度
     *
     * @param height 圆角矩形图片格式链接控件高度
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconHeight(height: Float64): LinkTheme

    /**
     * 设置圆角矩形图片格式链接左右内边距
     *
     * @param padding 圆角矩形图片格式链接左右内边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconPadding(padding: Float64): LinkTheme

    /**
     * 设置圆角矩形图片格式链接圆角半径
     *
     * @param radius 圆角矩形图片格式链接圆角半径
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconRadius(radius: Float64): LinkTheme

    /**
     * 设置圆角矩形图片格式链接左右外边距
     *
     * @param margin 圆角矩形图片格式链接左右外边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectIconMargin(margin: Float64): LinkTheme

    /**
     * 设置空心圆角矩形图片格式链接主题背景颜色
     *
     * @param color 空心圆角矩形图片格式链接主题背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconBackgroundColor(color: Color): LinkTheme

    /**
     * 设置空心圆角矩形图片格式链接控件背景颜色
     *
     * @param color 空心圆角矩形图片格式链接控件背景颜色
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconButtonBackgroundColor(color: Color): LinkTheme

    /**
     * 设置空心圆角矩形图片格式链接文字大小
     *
     * @param size 空心圆角矩形图片格式链接文字大小
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconTextSize(size: Float64): LinkTheme

    /**
     * 设置空心圆角矩形图片格式链接控件高度
     *
     * @param height 空心圆角矩形图片格式链接控件高度
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconHeight(height: Float64): LinkTheme

    /**
     * 设置空心圆角矩形图片格式链接左右内边距
     *
     * @param padding 空心圆角矩形图片格式链接左右内边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconPadding(padding: Float64): LinkTheme

    /**
     * 设置空心圆角矩形图片格式链接边框宽度
     *
     * @param width 空心圆角矩形图片格式链接边框宽度
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconBorderWidth(width: Float64): LinkTheme

    /**
     * 设置空心圆角矩形图片格式链接分割线宽度
     *
     * @param width 空心圆角矩形图片格式链接分割线宽度
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconDividingLineWidth(width: Float64): LinkTheme

    /**
     * 设置空心圆角矩形图片格式链接左右外边距
     *
     * @param margin 空心圆角矩形图片格式链接左右外边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconMargin(margin: Float64): LinkTheme

    /**
     * 设置空心圆角矩形图片格式分割线和文本左边距
     *
     * @param padding 空心圆角矩形图片格式分割线和文本左边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconLineLeftPadding(padding: Float64): LinkTheme

    /**
     * 设置空心圆角矩形图片格式分割线和文本右边距
     *
     * @param padding 空心圆角矩形图片格式分割线和文本右边距
     * @return 当前LinkTheme对象
     */
    public func setLinkRectToolIconLineRightPadding(padding: Float64): LinkTheme
}
```

#### 块引用样式

##### public class BlockQuoteTheme <: MarkdownBaseTheme

```cangjie
/**
 * 块引用样式
 */
public class BlockQuoteTheme <: MarkdownBaseTheme {
    /**
     * 设置块引用背景颜色
     *
     * @param color 块引用背景颜色
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteBackgroundColor(color: Color): BlockQuoteTheme

    /**
     * 统一设置块引用整体外边距
     *
     * @param margin 外边距
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteMargin(margin: Float64): BlockQuoteTheme

    /**
     * 分别设置块引用四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 8.0): BlockQuoteTheme

    /**
     * 统一设置块引用整体内边距
     *
     * @param padding 内边距
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuotePadding(padding: Float64): BlockQuoteTheme

    /**
     * 统一设置块引用整体圆角
     *
     * @param radius 圆角
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteRadius(radius: Float64): BlockQuoteTheme

    /**
     * 设置块引用左侧边框宽度
     *
     * @param width 块引用左侧边框宽度
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteLeftBorderWidth(width: Float64): BlockQuoteTheme

    /**
     * 设置块引用左侧边框颜色
     *
     * @param color 块引用左侧边框颜色
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteLeftBorderColor(color: Color): BlockQuoteTheme

    /**
     * 设置块引用左侧线条和内容的间距
     *
     * @param space 块引用左侧线条和内容的间距
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteBorderContentSpacing(space: Float64): BlockQuoteTheme

    /**
     * 设置块引用子模块间距
     *
     * @param space 块引用子模块间距
     * @return 当前BlockQuoteTheme对象
     */
    public func setBlockQuoteChildSpacing(space: Int64): BlockQuoteTheme
}
```

#### 无序/任务列表样式

##### public class BulletListTheme <: MarkdownBaseTheme

```cangjie
/**
 * 无序/任务列表样式
 */
public class BulletListTheme <: MarkdownBaseTheme {
    /**
     * 设置无序/任务背景颜色
     *
     * @param color 无序/任务背景颜色
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBackgroundColor(color: Color): BulletListTheme

    /**
     * 统一设置无序/任务外边距
     *
     * @param margin 外边距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListMargin(margin: Float64): BulletListTheme

    /**
     * 分别设置无序/任务四个外边距
     *
     * @param top 上外边距 命名参数
     * @param right 右外边距 命名参数
     * @param bottom 下外边距 命名参数
     * @param left 左外边距 命名参数
     * @return 当前BulletListTheme对象
     */
    public func setBulletListMargin(top!: Float64 = 0.0, right!: Float64 = 0.0, bottom!: Float64 = 0.0, left!: Float64 = 8.0): BulletListTheme

    /**
     * 统一设置无序/任务内边距
     *
     * @param padding 内边距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListPadding(padding: Float64): BulletListTheme

    /**
     * 设置无序/任务子模块上下间距
     *
     * @param spacing 无序/任务子模块上下间距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListChildSpacing(spacing: Int64): BulletListTheme

    /**
     * 设置无序/任务子模块中子模块上下间距
     *
     * @param spacing 无序/任务子模块中子模块上下间距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListChildChildSpacing(spacing: Int64): BulletListTheme

    /**
     * 设置无序列表列表符号和列表内容间距
     *
     * @param spacing 无序列表列表符号和列表内容间距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletSpacing(spacing: Float64): BulletListTheme

    /**
     * 设置无序列表列表符号是否全部是实心圆型
     *
     * @param isCircle 无序列表列表符号是否全部是实心圆型
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletIsCircle(isCircle: Bool): BulletListTheme

    /**
     * 设置无序列表列表符号文本颜色
     *
     * @param color 无序列表列表符号文本颜色
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextFontColor(color: Color): BulletListTheme

    /**
     * 设置无序列表列表符号文本尺寸
     *
     * @param size 无序列表列表符号文本尺寸
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextFontSize(size: Float64): BulletListTheme

    /**
     * 设置无序列表列表符号文本字体样式
     *
     * @param style 无序列表列表符号文本字体样式
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextFontStyle(style: FontStyle): BulletListTheme

    /**
     * 设置无序列表列表符号文本字体粗细
     *
     * @param weight 无序列表列表符号文本字体粗细
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextFontWeight(weight: FontWeight): BulletListTheme

    /**
     * 设置无序列表列表符号文本字体
     *
     * @param family 无序列表列表符号文本字体
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextFontFamily(family: String): BulletListTheme

    /**
     * 设置无序列表列表符号文本行高
     *
     * @param lineHeight 无序列表列表符号文本行高
     * @return 当前BulletListTheme对象
     */
    public func setBulletListBulletTextLineHeight(lineHeight: Float64): BulletListTheme

    /**
     * 设置任务列表多选框和列表内容间距
     *
     * @param spacing 任务列表多选框和列表内容间距
     * @return 当前BulletListTheme对象
     */
    public func setBulletListCheckboxSpacing(spacing: Float64): BulletListTheme

    /**
     * 设置任务列表多选框宽度
     *
     * @param width 任务列表多选框宽度
     * @return 当前BulletListTheme对象
     */
    public func setBulletListCheckboxWidth(width: Float64): BulletListTheme

    /**
     * 设置任务列表多选框高度
     *
     * @param height 任务列表多选框高度
     * @return 当前BulletListTheme对象
     */
    public func setBulletListCheckboxHeight(height: Float64): BulletListTheme

    /**
     * 设置任务列表多选框选中颜色
     *
     * @param color 任务列表多选框选中颜色
     * @return 当前BulletListTheme对象
     */
    public func setBulletListCheckboxSelectedColor(color: Color): BulletListTheme

    /**
     * 设置任务列表多选框形状
     *
     * @param shape 任务列表多选框形状
     * @return 当前BulletListTheme对象
     */
    public func setBulletListCheckboxShape(shape: CheckBoxShape): BulletListTheme
}
```

### public enum LatexMathColorFormat <: Equatable<LatexMathColorFormat>

数学公式生成图片格式枚举

```cangjie
/**
 * 数学公式生成图片格式枚举
 */
public enum LatexMathColorFormat <: Equatable<LatexMathColorFormat> {
    | COLOR_FORMAT_RGB_565 // 16位
    | COLOR_FORMAT_BGRA_8888 // 32位

    public operator func ==(that: LatexMathColorFormat): Bool

    public operator func !=(that: LatexMathColorFormat): Bool

    public static func fromInt64(value: Int64): ?LatexMathColorFormat

    public func toInt64(): Int64
}
```

### public enum MarkdownTextDecorationStyle <: Equatable<MarkdownTextDecorationStyle>

装饰线样式枚举

```cangjie
/**
 * 装饰线样式枚举
 */
public enum MarkdownTextDecorationStyle <: Equatable<MarkdownTextDecorationStyle> {
    | SOLID // 实线
    | DOUBLE // 双线
    | DOTTED // 虚线
    | DASHED // 破折线
    | WAVY // 波浪线

    public operator func ==(that: MarkdownTextDecorationStyle): Bool

    public operator func !=(that: MarkdownTextDecorationStyle): Boo

    public static func fromInt64(int: Int64): ?MarkdownTextDecorationStyle

    public func toInt64(): Int64

    public func toInt32(): Int32
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

