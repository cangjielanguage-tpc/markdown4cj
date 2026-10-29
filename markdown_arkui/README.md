<div align="center">
<h1>Markdown_arkui</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v2.0.0-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v1.1.3-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-NA-red" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## 介绍

Markdown是一种轻量级标记语言，排版语法简洁，让人们更多地关注内容本身而非排版。

Markdown_arkui是一个用arkts语言编写的适用于鸿蒙系统的Markdown库。

## 优势

- 使用高效便捷：一个组件 + 一个配置即可渲染
- 扩展性强，用户可自定义Markdown显示样式
- 渲染与业务解耦：点击、复制、曝光等行为全部通过回调还给宿主
- 符合 Markdown 规范

### 特性

1. 支持增量加载渲染
2. 支持增量解析
3. 支持标题语法
4. 支持段落语法
5. 支持分割线语法
6. 支持内联代码语法
7. 支持缩进代码块语法
8. 支持围栏代码块语法
9. 支持加粗语法
10. 支持斜体语法
11. 支持转义字符语法
12. 支持删除线语法
13. 支持链接语法
14. 支持自动网址链接语法
15. 支持部分html语法
16. 支持软硬换行语法
17. 支持表格语法
18. 支持有序列表语法
19. 支持无序列表语法
20. 支持任务列表语法
21. 支持块引用语法
22. 支持Toc目录语法
23. 支持脚注语法
24. 支持图片语法
25. 支持图片Style语法
26. 支持图片幻灯片语法
27. 支持组合代码块语法
28. 支持视频语法
29. 支持音频语法
30. 支持定义列表语法
31. 支持标题ID语法
32. 支持上标语法
33. 支持下标语法
34. 支持emoji语法
35. 支持围栏代码块高亮功能
36. 支持列表嵌套功能
37. 支持文本样式设置
38. 支持表格样式设置
39. 支持超链接图片化设置
40. 支持单独代码块设置
41. 支持深浅主题色设置
42. 支持文本长按选中复制粘贴
43. 支持图文混排和图文不混排功能
44. 支持自定义正则实现自定义自动链接
45. 支持段落高亮功能
46. 支持划选文字复制功能
47. 支持长按段落背景效果功能
48. 支持表格复制能力
49. 支持全文复制能力
50. 支持表格的表头功能
51. 支持表格首行吸顶功能
52. 支持段落出现效果功能
53. 支持超链接样式以及曝光功能
54. 支持自定义卡片（块级图片/链接）与自定义标签（如 SDUI）渲染

## 软件架构

![](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown_arkui-6.1.1/doc/assets/img.png)

### 源码目录

```shell
─markdown_arkui
  └─src
      └─main
          ├─cpp
          ├─ets
          └─resources
```

- `markdown_arkui` 工程模块 - 编译生成一个har包
- `markdown_arkui src` 模块代码目录
- `markdown_arkui src main` 模块项目目录
- `markdown_arkui src main cpp` cpp代码目录
- `markdown_arkui src main ets` ets代码目录
- `markdown_arkui src main resources` 资源文件目录

### 模块职责

| 层 | 模块 | 职责 |
| --- | --- | --- |
| 使用方（entry） | 页面/组件 | 引入依赖、构造三件套、注入 `CJMarkdown`、实现回调与主题定制 |
| 库（markdown_arkui） | `CJMarkdown` | 解析调度 + 渲染分发 |
| 接口 | `MarkdownParserUtils` | AST → NodeView 树（含增量复用） |
| 接口 | `MarkdownConfiguration` | 交互回调、样式注入、全局文本、段落高亮 |
| 接口 | `MarkdownPlugin` | 特性开关（表格/公式/音视频/HTML…） |
| 接口 | `MarkdownTheme` 系列 | 全量可定制样式 |

### 设计要点

1. **零成本接入**：一个组件 + 一个配置即可渲染，标配即可用。
2. **能力按需开启**：插件默认全关，只有显式 `setIsXxx(true)` 才参与解析，未开启特性零回归。
3. **渲染与业务解耦**：库只负责把 Markdown 渲染成 UI，点击/复制/曝光等行为全部通过回调还给宿主。
4. **响应式 content**：`content` 变化即增量解析渲染，天然适配流式/AI 对话场景。
5. **样式全量可配**：段落、标题、代码块、表格、链接、图片等每个块级/行内元素都有独立 Theme，且 setter 支持链式调用。

## 快速开始

在页面上渲染一段 Markdown，最简单只需要一个组件 + 一个 `MarkdownConfiguration` 对象：

```typescript
import { CJMarkdown, MarkdownConfiguration } from '@cangjie-tpc/markdown_arkui'

build() {
  Column() {
    CJMarkdown({
      content: this.content,                 // 传入 Markdown 文本  //必填
      config: new MarkdownConfiguration()    // 配置/回调       //必填
    })
  }
  .width('100%')
  .padding(10)
}
```

### CJMarkdown 参数

| 参数 | 类型 | 必填 | 说明 |
| --- | --- | :-: | --- |
| `content` | `string` | ✅ | Markdown 文档内容（响应式，变化自动增量解析渲染） |
| `config` | `MarkdownConfiguration` | ✅ | 配置与交互回调 |
| `plugin` | `MarkdownPlugin` | ❌ | 特性开关（默认全关；有默认值 `new MarkdownPlugin()`，可省略） |
| `scroller` | `Scroller` | ❌ | 列表控制器（TOC/脚注跳转滚动用；有默认值 `new Scroller()`，可省略） |
| `scrollController` | `MarkdownScrollController` | ❌ | 外层滚动控制器（不固定高度模式/吸顶联动用） |
| `blockImageCardComponent` | `@Builder (desc, imageSrc, title)` | ❌ | 块级图片自定义卡片，见「自定义卡片」 |
| `blockLinkCardComponent` | `@Builder (desc, link, title)` | ❌ | 块级链接自定义卡片，见「自定义卡片」 |
| `customTagViewComponent` | `@Builder (tag, attrs, content)` | ❌ | 自定义标签（如 `<sdui>`）渲染，见「SDUI 卡片」 |

```typescript
CJMarkdown({
  content: this.content,
  config: this.mdConfig,
  plugin: this.mdPlugin,
  scroller: this.markdownScroller,
  scrollController: this.scrollController,
  blockImageCardComponent: this.ImageCard,          // 块级图片卡片 Builder
  blockLinkCardComponent: this.LinkCard,            // 块级链接卡片 Builder
  customTagViewComponent: this.SduiTagViewBuilder   // 自定义标签（如 sdui）Builder
})
```

## 接入流程

```
工程 → ①引入依赖 → ②构造三件套 → ③注入组件
```

### ① 引入依赖

`entry/oh-package.json5` 声明 `@cangjie-tpc/markdown_arkui`：

```json5
{
  "dependencies": {
    "@cangjie-tpc/markdown_arkui": "file:har/markdown_arkui.har"
  }
}
```

| 引入方式 | 写法 | 适用场景 |
| --- | --- | --- |
| har 包 | `file:har/markdown_arkui.har` | 发布分发（har 已内置 prism/codeformat/parser/formula 四个运行时依赖） |
| 源码模块 | `file:../markdown_arkui` | 开发联调（本仓库 entry 即采用） |

### ② 构造三件套（配置 / 插件 / 主题）

```typescript
@State mdConfig: MarkdownConfiguration = new MarkdownConfiguration()
@State mdTheme: MarkdownTheme = new MarkdownTheme()
@State mdPlugin: MarkdownPlugin = new MarkdownPlugin()

aboutToAppear(): void {
  this.mdTheme = this.setMarkdownTheme()    // setMarkdownTheme 为伪代码
  this.mdPlugin = this.setPlugin()
  this.mdConfig = this.setMarkdownConfig()  // setMarkdownConfig 为伪代码
  this.mdConfig.setMarkdownTheme(this.mdTheme)   // 配置挂样式
}

setPlugin(): MarkdownPlugin {
  let plugin: MarkdownPlugin = new MarkdownPlugin()
  plugin.setIsTablePlugin(true) // 表格插件
  plugin.setIsLatexMathPlugin(true) // 数学公式插件
  plugin.setIsStrikethroughPlugin(true) // 删除线插件
  plugin.setIsTaskListPlugin(true) // 任务列表插件
  plugin.setIsLinkifyPlugin(true) // 自动链接插件
  plugin.setIsBlockAudioPlugin(true) // 音频插件
  plugin.setIsBlockVideoPlugin(true) // 视频插件
  plugin.setIsImageCollectPlugin(true) // 图片视频列表url集合列表解析插件
  plugin.setIsImageTextMixPlugin(true) // 图文不混排插件
  plugin.setIsImageSlidePlugin(true) // 图片banner
  plugin.setIsCodeListPlugin(true) // 代码块列表
  plugin.setIsImageStylePlugin(true) // 图片样式
  plugin.setIsTocPlugin(true) // TOC插件
  plugin.setIsFootnotePlugin(true) // 脚注
  plugin.setIsHtmlPlugin(true) // Html插件
  plugin.setIsLinkViewPlugin(true) // 链接单独块解析插件
  plugin.setIsDescListPlugin(true) // 定义列表解析插件
  plugin.setIsHeadIDPlugin(true) // 标题ID解析插件
  return plugin
}

setMarkdownConfig(): MarkdownConfiguration {
  let config = new MarkdownConfiguration()
  config.setLinkCallback(this.linkCallBack.bind(this))
  config.setImageCallback(this.imageCallback.bind(this))
  config.setAudioCallback(this.audioCallback.bind(this))
  config.setVideoCallback(this.videoCallback.bind(this))
  config.setVideoImageCallback(this.videoImageCallback.bind(this))
  config.setCodeCopyCallback(this.codeCopyCallback.bind(this))
  config.setCodeFullScreenCallback(this.codeFullScreenCallback.bind(this))
  config.setLatexImageCallback(this.latexCallBack.bind(this))
  config.setTocIndexCallback(this.tocIndexCallback.bind(this))
  config.setFootnoteCallback(this.footnoteCallback.bind(this))
  if (this.beforeSelectedParagraphBackgroundColor !== undefined) {
    config.getMarkdownHighlightParagraph().setBeforeSelectedParagraphBackgroundColor(this.beforeSelectedParagraphBackgroundColor)
  }
  if (this.selectedParagraphBackgroundColor !== undefined) {
    config.getMarkdownHighlightParagraph().setSelectedParagraphBackgroundColor(this.selectedParagraphBackgroundColor)
  }
  config.setCustomLongPressCallback(this.longPressCallback.bind(this))
  return config
}

setMarkdownTheme(): MarkdownTheme {
  let theme = new MarkdownTheme()
  if (this.currentColorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
    theme.setDefaultTheme()
  } else {
    theme.setDarculaTheme()
  }
  // ---------- 通用 - Global
  let globalTheme: GlobalTheme = new GlobalTheme()
  if (this.globalBackgroundColor !== undefined) {
    globalTheme.setBackgroundColor(this.globalBackgroundColor)
  }
  globalTheme.setGlobalMargin({top: this.blockMarginTop, right: this.blockMarginRight, bottom: this.blockMarginBottom, left: this.blockMarginLeft})
  globalTheme.setBlockSpacing(this.markdownBlockSpacing)
  globalTheme.setIsLineBreak(this.isLineBreak)
  globalTheme.setIsMarkdownParserSync(this.isMarkdownParserSync)
  globalTheme.setIsOnCopy(this.isOnCopy)
  globalTheme.setOpenGestureSwipe(this.openGestureSwipe)
  globalTheme.setEnableParseThrottle(this.enableParseThrottle)
  globalTheme.setParseThrottleMs(this.parseThrottleMs)
  theme.setGlobalTheme(globalTheme)
  // ---------- 专有
  theme.setCodeFullScreenIcon($r('app.media.startIcon'))
  theme.setCodeCopyIcon($r('app.media.startIcon'))
  theme.setAudioIcon($r('app.media.startIcon'))
  theme.setVideoImage($r('app.media.place_holder'))
  theme.setPlayCircleFillIcon($r('app.media.play_circle_fill'))
  theme.setBannerImage($r('app.media.place_holder'))
  theme.setImageResource($r('app.media.place_holder'))
  return theme
}
```

### ③ 注入组件

```typescript
CJMarkdown({
  content: this.content,                   // Markdown 文本
  config: this.mdConfig,                   // 配置/回调
  plugin: this.mdPlugin,                   // 插件开关
  scroller: this.markdownScroller,         // 【可选】列表控制器，用于程序化滚动（见下）
  // scrollController: this.scrollController, // 【可选】外层滚动控制器（不固定高度/吸顶场景）
  // blockImageCardComponent / blockLinkCardComponent / customTagViewComponent 见后文
})
```

`scroller` 参数说明：传入一个 ArkUI 内置 `Scroller`，即可在外部程序化控制 Markdown 列表滚动。典型用法是与 TOC/脚注回调联动（见 `DemoDetailsPage.ets`）：

```typescript
@State markdownScroller: Scroller = new Scroller()   // Markdown 的滚动控制器

tocIndexCallback(index: number | undefined): void {
  if (index !== undefined) {
    this.markdownScroller.scrollToIndex(index, true)  // 平滑滚动到指定索引
  }
}
```

## 核心接口

### MarkdownConfiguration（配置/回调）

| 能力 | 接口 | 说明 |
| --- | --- | --- |
| 样式注入 | `setMarkdownTheme(theme)` | 设置markdown样式 |
| 链接 | `setLinkCallback(cb)` | 设置链接点击回调 |
| 图片 | `setImageCallback(cb)/setImageDownloadCallback(cb)` | 设置图片点击回调/设置图片下载的点击事件 |
| 表格 | `setTableCopyCallback(cb)` | 设置表格复制的点击事件 |
| 段落 | `setParagraphHeadingAnimationStart(cb)/setParagraphHeadingAnimationEnd(cb)` | 设置段落动画开始/结束回调 |
| 图片替换 | `setImageReplaceCallback(cb)` | 设置图片替换事件 |
| 音频/视频 | `setAudioCallback(cb) / setVideoCallback(cb)` | 设置音/视频点击回调 |
| 视频首帧 | `setVideoImageCallback(cb)` | 设置视频占位图和宽高比和视频时长的回调 |
| 视频发布 | `setVideoReleaseCallback(cb)/setVideoDownloadCallback(cb)` | 设置视频发布/下载的点击事件 |
| 代码 | `setCodeCopyCallback(cb) / setCodeFullScreenCallback(cb)` | 设置代码复制点击回调/设置代码全屏点击回调 |
| 数学公式 | `setLatexImageCallback(cb) / setLatexStrCallback(cb)` | 设置数学公式图片点击回调/设置数学公式数据处理事件 |
| TOC/脚注 | `setTocIndexCallback(cb) / setFootnoteCallback(cb)` | 设置TOC点击回调/设置脚注点击回调 |
| 长按复制 | `setTextCopyCallback(cb)` | 设置文本复制的点击事件 |
| 自定义长按 | `setCustomLongPressCallback(cb)` | 自定义长按事件 |
| 曝光统计 | `setElementExposureCallback(cb) + setExposureThreshold(number)` | 设置元素曝光回调/设置曝光可见阈值 |
| 全局文本 | `setNodeString(MarkdownNodeViewString)` | 设置全局文本对象 |
| 段落高亮 | `getMarkdownHighlightParagraph()` | 获取高亮设置对象 |

### MarkdownPlugin（特性开关）

默认全关，按需开启（`plugin.setXxx(true)`）：

```typescript
plugin.setIsTablePlugin(true)          // 表格
plugin.setIsLatexMathPlugin(true)      // 数学公式
plugin.setIsStrikethroughPlugin(true)  // 删除线
plugin.setIsTaskListPlugin(true)       // 任务列表
plugin.setIsLinkifyPlugin(true, regs?) // 自动链接（可传自定义正则数组）
plugin.setIsBlockAudioPlugin(true)     // 音频
plugin.setIsBlockVideoPlugin(true)     // 视频
plugin.setIsTocPlugin(true)            // TOC 目录
plugin.setIsFootnotePlugin(true)       // 脚注
plugin.setIsHtmlPlugin(true)           // HTML
plugin.setIsImageStylePlugin(true)     // 图片 style
plugin.setIsImageSlidePlugin(true)     // 图片 Banner
plugin.setIsImageCollectPlugin(true)   // 图片/视频 url 集合
plugin.setIsImageTextMixPlugin(true)   // 图文不混排
plugin.setIsCodeListPlugin(true)       // 组合代码块列表
plugin.setIsDescListPlugin(true)       // 定义列表
plugin.setIsHeadIDPlugin(true)         // 标题 ID
plugin.setIsSubPlugin(true)            // 下标
plugin.setIsSupPlugin(true)            // 上标
plugin.setIsEmojiPlugin(enable, light) // Emoji
plugin.setIsWhitelistPlugin(mode)      // 白名单过滤
plugin.setIsLinkViewPlugin(true)       // 链接单独块解析插件
plugin.setIsHighlightPlugin(true)      // 加载高亮解析插件
plugin.setIsBlockCustomCardPlugin(true,
  (desc: string, imageSrc: string, title: string) => boolean,   // 块级图片卡片条件
  (desc: string, link: string, title: string) => boolean)       // 块级链接卡片条件
```

### MarkdownTheme（主题定制）

所有子主题类均通过 `Index.ets` 导出，可独立 `new` 后注入到 `MarkdownTheme`（所有 `setXxxTheme` 均返回 `MarkdownTheme`，支持链式调用）：

```typescript
let theme = new MarkdownTheme()
theme.setDefaultTheme()                                    // 内置浅色主题
// theme.setDarculaTheme()                                 // 内置深色主题

// 全局
theme.setGlobalTheme(new GlobalTheme())                    // 全局：外边距/块间距/换行/解析同步/长按复制/曝光
// 文本样式
theme.setBoldTheme(new BoldTheme())                        // 加粗
theme.setItalicTheme(new ItalicTheme())                    // 斜体
theme.setStrikethroughTheme(new StrikethroughTheme())      // 删除线
theme.setHighlightTheme(new HighlightTheme())              // 高亮
theme.setSubTheme(new SubTheme())                          // 下标
theme.setSupTheme(new SupTheme())                          // 上标
theme.setInlineCodeTheme(new InlineCodeTheme())            // 行内代码
theme.setHtmlUnderlineTheme(new HtmlUnderlineTheme())      // HTML 下划线
// 段落 / 标题 / 分割线 / 引用
theme.setParagraphTheme(new ParagraphTheme())              // 段落
theme.setHeadingTheme(new HeadingTheme())                  // 标题（含 H1-H6）
theme.setDividerTheme(new DividerTheme())                  // 分割线
theme.setBlockQuoteTheme(new BlockQuoteTheme())            // 块引用
// 列表
theme.setBulletListTheme(new BulletListTheme())            // 无序 / 任务列表
theme.setOrderedListTheme(new OrderedListTheme())          // 有序列表
theme.setDefinitionListTheme(new DefinitionListTheme())    // 定义列表
// 表格
theme.setTableTheme(new TableTheme())                      // 表格（边框/单元格/标题头/粘性表头）
// 代码
theme.setCodeBlockTheme(new CodeBlockTheme())              // 代码块（类型文本/复制/全屏/行号/高亮）
// 链接
theme.setLinkTheme(new LinkTheme())                        // 链接
// 图片 / 音频 / 视频 / Banner
theme.setImageTheme(new ImageTheme())                      // 图片
theme.setAudioTheme(new AudioTheme())                      // 音频
theme.setVideoTheme(new VideoTheme())                      // 视频
theme.setBannerTheme(new BannerTheme())                    // 图片 Banner 幻灯片
// 脚注
theme.setFootnoteDefTheme(new FootnoteDefTheme())          // 脚注定义
theme.setFootnoteRefTheme(new FootnoteRefTheme())          // 脚注引用
// 数学公式
theme.setLatexMathTheme(new LatexMathTheme())              // 数学公式（LaTeX）
```

> 上文为 `MarkdownTheme` 对外暴露的全部 28 个 `setXxxTheme`/`setDefaultTheme`/`setDarculaTheme` 接口，与 `Index.ets` 导出的主题类一一对应；各主题类的字段与方法详见 [feature_api.md](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown_arkui-6.1.1/doc/feature_api.md)。

### 自定义卡片（块级图片 / 块级链接）

库支持把满足条件的块级图片 / 链接按宿主自定义组件渲染，分两步：

**① 开启插件，并声明“什么算卡片”（可选条件函数）：**

```typescript
plugin.setIsBlockCustomCardPlugin(
  true,                                            // 开关
  (desc: string, imageSrc: string, title: string) => desc.includes('Custom'),   // 图片卡片条件
  (desc: string, link: string, title: string) => desc.includes('Custom')        // 链接卡片条件
)
```

> 只有开启插件**且传入条件函数**才会转卡片：条件函数返回 `boolean`，返回 `true` 才按卡片处理；
> 若条件函数不传（`undefined`），则不触发自定义卡片逻辑，图片/链接按原始渲染方式显示。

**② 为 CJMarkdown 注入卡片 Builder：**

```typescript
@Builder
ImageCard(desc: string, imageSrc: string, title: string) {
  Column() {
    Image(imageSrc).width(200).height(120).objectFit(ImageFit.Contain)
    Text(desc).fontSize(14)
  }
  .padding(8).borderRadius(8).borderWidth(1).borderColor('#999999')
}

@Builder
LinkCard(desc: string, link: string, title: string) {
  Column() {
    Text(desc).fontSize(14)
    Text(link).fontSize(12).fontColor('#333333')
  }
  .padding(8)
}

CJMarkdown({
  content: this.content,
  config: this.mdConfig,
  plugin: this.mdPlugin,
  blockImageCardComponent: this.ImageCard,  // 块级图片卡片 Builder
  blockLinkCardComponent: this.LinkCard     // 块级链接卡片 Builder
})
```

> 默认 Builder 为空白占位；不注入则卡片区域显示空白，注入后完全由宿主决定展示样式。

### SDUI 卡片（自定义标签）

库支持把文档中的自定义 HTML 标签（如 `<sdui ...>`）交由宿主导出为原生组件（SDUI 等任意引擎）：库只产出 `customTag/customAttrs/customContent` 三元组，渲染交给宿主 Builder。

#### 使用的标签

```markdown
<sdui data='{"type":"View","props":{"style":{...}},"children":[...]}'></sdui>
```

| 组成 | 说明 |
| --- | --- |
| 标签名 | `sdui`（自定义，宿主启动时注册，可扩展其他标签） |
| `data` 属性 | SDUI DSL 的 JSON 字符串（单引号包裹，避免与 JSON 内部双引号冲突） |
| 书写位置 | 独占一行、块级使用；支持完整开闭标签 `<sdui ...></sdui>` 与自闭合 `<sdui .../>` |

#### 宿主接入（4 步）

**0. 引入 sdui 依赖（可选，按宿主所用引擎）：**

```json5
// entry/oh-package.json5
{
  "dependencies": {
    "@cangjie-tpc/markdown_arkui": "file:har/markdown_arkui.har",
    "sdui": "file:./har/sdui.har"          // 本示例用 SDUI 引擎渲染自定义标签
  }
}
```

**① 注册标签 + 开启 HTML 插件（`entry/.../SduiCardDetailsPage.ets`，需在首次渲染前）：**

```typescript
import { CJMarkdown, CustomViewRegistry } from '@cangjie-tpc/markdown_arkui'
import { SDUIView, installSduiHostRegistry } from 'sdui'

aboutToAppear(): void {
  CustomViewRegistry.register('sdui')       // 登记标签名（全局静态注册表、幂等，注册一次全局生效）
  this.markdownPlugin.setIsHtmlPlugin(true) // 方案约定开启 HTML 插件（行内提升/兜底拦截场景需要）
}
```

标签只有注册后才会被拦截；未注册标签走原有丢弃逻辑，**零回归**。

**② 提供 Builder，把 `data` 属性交给 SDUI 引擎渲染：**

```typescript
@Builder
SduiTagViewBuilder(tag: string, attrs: Record<string, string>, content: string) {
  if (tag === 'sdui') {
    Column() {
      SDUIView({ json: attrs['data'] ?? '' })  // attrs['data'] = SDUI DSL JSON
    }
  }
}
```

**③ 注入 `customTagViewComponent` 并渲染：**

```typescript
CJMarkdown({
  content: this.content,
  config: this.markdownConfiguration,
  plugin: this.markdownPlugin,
  customTagViewComponent: this.SduiTagViewBuilder
})
```

**④ 卡片交互（可选）：**

```typescript
installSduiHostRegistry().setAction('phase1Callback', (payload: string, _meta: string): string => {
  // payload 含 DSL actions 声明的 target/data，宿主自行解析路由
  return `OK count=...`
})
```

#### Markdown 处理流水线（6 步）

```
原文 → ①注册 → ②预处理 → ③解析 → ④还原 → ⑤提升 → ⑥渲染
```

**① 宿主注册标签**：见上文接入第 ① 步。

**② 解析前文本预处理**（`markdown_arkui/.../plugin/CustomViewRegistry.ets` 的 `preprocessCustomTags`）

这是本方案的核心，用于绕过 Cangjie 解析器的限制。

> 背景：Cangjie 解析器对非 CommonMark 已知标签（`sdui` 不在 `<p>`/`<div>` 等白名单内）做**静默剥离**——不产出 HtmlBlock/HtmlInline 原文节点，标签和属性数据在 AST 层完全丢失，无法在解析后拦截。

做法：把已注册标签的原文**包进无语言围栏代码块**（围栏块的 literal 会被解析器 100% 完整保留，作为可靠载体）：

```
<sdui data='...'></sdui>
        ↓ 预处理
\n```\n<sdui data='...'></sdui>\n```\n
```

防误伤两道保护：

- 先把用户已有的围栏块和行内代码（如 `` `<sdui>` ``）替换为占位符，处理完还原；
- 开闭标签间内容限定单行，孤立的 `<sdui>`（无紧邻闭标签）不会被匹配。

**③ Markdown 解析**（`markdown_arkui/.../components/MarkdownComponent.ets`）

`CJMarkdown` 解析前自动调用预处理，宿主**无需手动调用**：

```typescript
markdownParser.parse(CustomViewRegistry.preprocessCustomTags(this.content))
```

预处理后的文本进入解析器，`<sdui>` 原文以 FencedCodeBlock 节点形态存活于 AST。

**④ AST 还原为自定义节点**（`markdown_arkui/.../utils/MarkdownParserUtils.ets`）

`nodeToNodeView` 遍历 AST，在 `FencedCodeBlock` 分支用 `parseTagLiteral` 解析 literal（手写解析器：支持单/双/无引号属性、自闭合、HTML 实体解码）：

```typescript
case 'FencedCodeBlock': {
  const parsedFenceTag = CustomViewRegistry.parseTagLiteral(fenceLiteral)
  if (parsedFenceTag !== undefined && CustomViewRegistry.isRegistered(parsedFenceTag.tag)) {
    currentView.nodeType = 'CustomTagView'               // 专属类型，防止被代码块渲染截走
    currentView.customTag = parsedFenceTag.tag           // 'sdui'
    currentView.customAttrs = parsedFenceTag.attrs       // { data: 'SDUI JSON...' }
    currentView.customContent = parsedFenceTag.content
    targetParentView.children.push(currentView)
    break
  }
  // 未注册 → 走正常代码块渲染
}
```

同时保留 HtmlBlock / HtmlInline 两路兜底拦截（未来解析器行为变化时依然可用）。

**⑤ 行内提升**（`MarkdownParserUtils.ets` 的 `liftCustomTagBlocks`）

若标签落在段落行内流（HtmlInline 产物），后处理把段落**拆段提升**：

```
段落 → [前段切片, 卡片, 后段切片]
```

保证卡片以块级形态出现在正确位置（表格单元格内不提升）。

**⑥ 渲染分发**（`MarkdownComponent.ets`）

```typescript
} else if (item.customTag !== undefined) {
  this.customTagViewComponent(item.customTag, item.customAttrs ?? {}, item.customContent ?? "")
}
```

`customTagViewComponent` 是 `@BuilderParam`，由宿主注入——**库不依赖 SDUI，宿主决定标签怎么渲染**。

#### 职责分层

| 层 | 模块 | 职责 |
| --- | --- | --- |
| 库（markdown_arkui） | `CustomViewRegistry` | 标签注册表 + 预处理 + 标签原文解析 |
| 库 | `MarkdownParserUtils` | AST 拦截还原（CustomTagView 节点）+ 行内提升 |
| 库 | `MarkdownComponent` | 渲染分发（BuilderParam 回调宿主） |
| 宿主（entry） | `SduiCardDetailsPage` | 注册 `sdui` 标签 + 提供 Builder → `SDUIView` |

#### 设计要点

1. **围栏载体是方案基石**：不改造 Cangjie 解析器，用解析器保证完整保留的 fenced literal 承载标签原文，规避静默剥离。
2. **注册制拦截**：只拦已注册标签，未注册标签行为不变，对存量 markdown 零影响。
3. **渲染与解析解耦**：库只产出 `customTag/customAttrs/customContent` 三元组，渲染交给宿主 Builder，任意标签可接入任意组件（不止 SDUI）。

## 使用示例

```ets
import { CJMarkdown, MarkdownConfiguration} from '@cangjie-tpc/markdown_arkui'

@Entry
@Component
struct DemoPage {
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  /**
   * md文本
   */
  @State message: string = '### 标题1\n' +
    '\n' +
    '# 1级标题\n' +
    '\n' +
    '### 标题2\n' +
    '\n' +
    '## 2级标题\n' +
    '\n' +
    '### 标题3\n' +
    '\n' +
    '### 3级标题\n' +
    '\n' +
    '### 标题4\n' +
    '\n' +
    '#### 4级标题\n' +
    '\n' +
    '### 标题5\n' +
    '\n' +
    '##### 5级标题\n' +
    '\n' +
    '### 标题6\n' +
    '\n' +
    '###### 6级标题\n' +
    '\n' +
    '### 标题7\n' +
    '\n' +
    '### 正常标题\n' +
    '\n' +
    '### 标题8\n' +
    '\n' +
    'Heading level 1\n' +
    '===============\n' +
    '\n' +
    '### 标题9\n' +
    '\n' +
    'Heading level 2\n' +
    '---------------\n' +
    '\n' +
    '### 标题10\n' +
    '\n' +
    'Heading level 1\n' +
    '=\n' +
    '\n' +
    '### 标题11\n' +
    '\n' +
    'Heading level 2\n' +
    '-\n';

  build() {
    Column() {
      Column() {
        CJMarkdown({
          content: this.message,
          config:new MarkdownConfiguration()
        })
      }
    }
    .padding({ left: 10, right: 10, top: this.safeTop })
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
```

### 显示效果

![](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown_arkui-6.1.1/doc/assets/img1.png)

## 编译构建

1. 准备环境并获取源码：准备好 DevEco Studio 6.1.1.280 环境（Windows / Linux / macOS）

   ```bash
   git clone -b markdown_arkui-6.1.1 https://gitcode.com/Cangjie-TPC/markdown4cj.git
   ```

2. 下载依赖 HAR：`ohpm install` 时由 `oh-package.json5` 的 `hooks.preInstall` 自动执行 `scripts/pre_har_install.mjs`，从 OBS 下载 4 个预编译依赖 HAR（`prism_hybrid` / `codeformat_hybrid` / `markdown_parser_hybrid` / `formula_hybrid`，版本 v2.0.0）到 `markdown_arkui/har` 目录，并按 SHA256 校验；已存在且校验通过的文件自动跳过。也可以手动执行：

   ```bash
   node ./scripts/pre_har_install.mjs
   ```

3. 编译工程：用 DevEco Studio 打开工程，编译 `markdown_arkui` 模块，产物为 `markdown_arkui/build/default/outputs/default/markdown_arkui.har`

4. 在项目中使用markdown项目

   ```arkts
   import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_arkui'
   ```

## 验证方式

本仓库 `entry` 内置完整测试用例：

- 首页功能列表 → 逐项进入 `*DetailsPage`，可切换文件、全量/增量加载、深浅色
- `DemoDetailsPage.ets`：最完整的“配置 + 插件 + 主题 + 回调 + 段落高亮”使用范式
- `rawfile/036_CustomCard/`：自定义卡片用例
- 首页「39、SDUI卡片接入」→ `rawfile/037_SduiCard/`：
  - `001_SduiCard.md`：酒店卡（View+Image+Text）+ 机票卡（嵌套 Flex）混排在标题/列表/加粗/引用中
  - `002_SduiCard.md`：非法 JSON 容错 + 异常后恢复
  - `003_SduiCard.md`：卡片按钮点击交互（callback 弹框 / link 跳转）与状态栏计数验证

## 约束与限制

当前基于 DevEco Studio for Windows 6.1.1.280 版本实现的

1. 链接和删除线同时存在情况，只支持显示删除线的的中划线，不显示链接的下划线
2. 增量解析会导致 TOC/脚注/标题ID/引用链接上下文失效
3. 围栏代码块高亮语言支持如下(语言类型不区分大小写，每行如有多个则表示该语言支持别名书写)：
   1. brainfuck
   2. c
   3. clike
   4. clojure
   5. cpp、c++
   6. csharp、dotnet、c#
   7. css_extras
   8. css
   9. dart
   10. git
   11. go、golang
   12. groovy
   13. java
   14. javascript、js、typescript、ts
   15. json、jsonp
   16. kotlin
   17. latex
   18. makefile
   19. markdown、md
   20. markup、svg
   21. python、python3、py、py3、Python ML、pythonml、pandas、pythondata
   22. scala
   23. sql、mysql、oracle、oraclesql、sqlserver、MS SQL Server、mssql、postgresql、pgsql
   24. swift
   25. yaml
   26. cangjie、cj
   27. rust
4. 表格限制：
   1. 不支持嵌套标题
   2. 不支持嵌套块引用/有序列表/无序列表/任务列表
   3. 不支持嵌套缩进代码块/围栏代码块
5. 不支持稀疏排列/紧密排列
6. HTML支持的标签
   1. 块元素
      1. hr标签 - 分割线
      2. h1~h6标签 - 标题
      3. blockquote标签 - 块引用
      4. ul、ol、li标签 - 有序列表和无序列表
      5. table、thead、tbody、tfoot、tr、th、td标签 - 表格
      6. pre标签 - 缩进代码块
      7. p标签 - 段落标签
   2. 行内元素
      1. font标签 - 文本样式
         * color属性
         * size属性
      2. a标签 - 链接
         * href属性 - 必选属性
         * title属性
      3. b、strong标签 - 加粗
      4. i、em、cite、dfn标签 - 斜体
      5. s、del标签 - 删除
      6. code、samp、var、kbd标签 - 内联代码
      7. span标签 - 文本样式(key不支持中文)
         * font-size属性 - 文本大小
         * font-weight属性 - 文本粗细
         * color属性 - 文本颜色(只支持6位16进制颜色)
      8. u标签 - 下划线
      9. sup标签 - 上标
      10. sub标签 - 下标
   3. 行内块元素
      1. br标签 -  换行符
      2. img标签 - 图片
         * src属性 - 必选属性
         * title属性
         * width属性
         * height属性
   4. 注释
      1. `<!--  -->` - 注释标签
   5. DOCTYPE
7. 视频支持的格式 `mp4, mov, avi, mkv, wmv, flv, webm, m4v, 3gp`
8. 音频支持的格式 `mp3, wav, aac, flac, ogg, m4a, wma, amr`

## 接口说明

主要类和函数接口说明详见 [feature_api.md](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown_arkui-6.1.1/doc/feature_api.md)。

## 开源协议

本项目基于 [Apache License 2.0](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown_arkui-6.1.1/LICENSE) ，请自由的享受和参与开源。

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。
