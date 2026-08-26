# Markdown 接入指南

## 一、快速开始

在页面上渲染一段 Markdown，只需要一个组件 + 一个配置对象：

```typescript
import { CJMarkdown, MarkdownConfiguration } from '@cangjie-tpc/markdown_arkui'

build() {
  Column() {
    CJMarkdown({
      content: this.content,                      // 传入 Markdown 文本
      config: new MarkdownConfiguration()         // 配置/回调
    })
  }
  .width('100%')
  .padding(10)
}
```

| 组成 | 说明 |
| --- | --- |
| 组件 | `CJMarkdown`（渲染入口，`content` 为响应式属性，内容变化自动增量渲染） |
| 配置 | `MarkdownConfiguration`（交互回调、样式注入、全局文本提取） |
| 插件 | `MarkdownPlugin`（特性开关，默认全关） |
| 样式 | `MarkdownTheme`（主题定制，默认内置浅色/深色两套） |

## 二、接入流水线（4 步）

```
工程 → ①引入依赖 → ②构造三件套 → ③注入组件 → ④主题适配
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
  this.mdTheme = this.buildTheme()   //buildTheme为伪代码
  this.mdPlugin = this.buildPlugin()  //buildPlugin为伪代码
  this.mdConfig = this.buildConfig()  //buildConfig为伪代码
  this.mdConfig.setMarkdownTheme(this.mdTheme)   // 配置挂样式
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
  // blockImageCardComponent / blockLinkCardComponent / customTagViewComponent 见 §3.4 / §3.5
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

| CJMarkdown 参数 | 类型 | 必填 | 说明 |
| --- | --- | :-: | --- |
| `content` | `string` | ✅ | Markdown 文档内容（响应式，变化自动增量解析渲染） |
| `config` | `MarkdownConfiguration` | ✅ | 配置与交互回调 |
| `plugin` | `MarkdownPlugin` | ❌ | 特性开关（默认全关；有默认值 `new MarkdownPlugin()`，可省略） |
| `scroller` | `Scroller` | ❌ | 列表控制器（TOC/脚注跳转滚动用；有默认值 `new Scroller()`，可省略） |
| `scrollController` | `MarkdownScrollController` | ❌ | 外层滚动控制器（不固定高度模式/吸顶联动用） |
| `blockImageCardComponent` | `@Builder (desc, imageSrc, title)` | ❌ | 块级图片自定义卡片，见 §3.4 |
| `blockLinkCardComponent` | `@Builder (desc, link, title)` | ❌ | 块级链接自定义卡片，见 §3.4 |
| `customTagViewComponent` | `@Builder (tag, attrs, content)` | ❌ | 自定义标签（如 `<sdui>`）渲染，见 §3.5 |

### ④ 主题适配

深浅色跟随系统，或用内置主题一键切换：

```typescript
buildTheme(): MarkdownTheme {
  let theme = new MarkdownTheme()
  if (isDark) {
    theme.setDarculaTheme()   // 深色
  } else {
    theme.setDefaultTheme()   // 浅色
  }
  return theme
}
```

## 三、核心接口

### 3.1 MarkdownConfiguration（配置/回调）

| 能力 | 接口 | 说明 |
| --- | --- | --- |
| 样式注入 | `setMarkdownTheme(theme)` | 挂载体 |
| 链接 | `setLinkCallback(cb)` | `(url: string) => void` |
| 图片 | `setImageCallback(cb)` | `(url, urlList: Array<string>) => void` |
| 图片替换 | `setImageReplaceCallback(cb)` | `(url) => Promise<ArrayBuffer \| undefined>` |
| 音频/视频 | `setAudioCallback / setVideoCallback` | 点击回调 |
| 视频首帧 | `setVideoImageCallback(cb)` | `(url, cb) => void` 回调占位图/宽高比/时长 |
| 代码 | `setCodeCopyCallback / setCodeFullScreenCallback` | 复制 / 全屏 |
| 数学公式 | `setLatexImageCallback / setLatexStrCallback` | 公式图片点击 / 预处理 |
| TOC/脚注 | `setTocIndexCallback / setFootnoteCallback` | 偏移量回调 |
| 长按复制 | `setTextCopyCallback(cb)` | 文本复制 |
| 自定义长按 | `setCustomLongPressCallback(cb)` | `(str: string) => void` |
| 曝光统计 | `setElementExposureCallback + setExposureThreshold` | 元素曝光 |
| 全局文本 | `setNodeString(nodeString)` | 提取整篇纯文本（`nodeString.toString()`） |
| 段落高亮 | `getMarkdownHighlightParagraph()` | 见 §3.4 |

### 3.2 MarkdownPlugin（特性开关）

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
plugin.setIsSubPlugin / setIsSupPlugin // 下标 / 上标
plugin.setIsEmojiPlugin(enable, light) // Emoji
plugin.setIsWhitelistPlugin(mode)      // 白名单过滤
plugin.setIsBlockCustomCardPlugin(true) // 自定义卡片（块级图片/链接转卡片）
```

### 3.3 MarkdownTheme（主题定制）

所有子主题均通过 `Index.ets` 导出，可独立 `new` 后注入：

```typescript
theme.setGlobalTheme(new GlobalTheme())          // 全局、块间距、是否换行
theme.setParagraphTheme(new ParagraphTheme())    // 段落
theme.setHeadingTheme(new HeadingTheme())        // 标题（含 H1-H6）
theme.setCodeBlockTheme(new CodeBlockTheme())    // 代码块（含复制/全屏按钮）
theme.setTableTheme(new TableTheme())            // 表格（边框/单元格/标题/粘性表头）
theme.setLinkTheme(new LinkTheme())              // 链接
theme.setImageTheme(new ImageTheme())            // 图片
// 音频 / 视频 / Banner / 列表 / 引用 / 脚注 / 数学公式等一应俱全，方法见 doc/feature_api.md
```

### 3.4 自定义卡片（块级图片 / 块级链接）

库支持把满足条件的块级图片 / 链接按宿主自定义组件渲染，分两步：

**① 开启插件，并声明"什么算卡片"（可选条件函数）：**

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

### 3.5 SDUI 卡片（自定义标签 `customTagViewComponent`）

库支持把文档中的自定义 HTML 标签（如 `<sdui ...>`）交由宿主导出为原生组件（SDUI 等任意引擎），详见仓库根目录《Markdown 接入 SDUI 方案》。

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

**工作原理：**
1. **预处理（库内部自动）**：`CJMarkdown` 解析前自动调用 `CustomViewRegistry.preprocessCustomTags(content)`，把已注册标签原文包进无语言围栏代码块（`\n```\n<sdui ...></sdui>\n```\n`），宿主**无需手动调用**——围栏 literal 是可靠载体，规避解析器对未知标签的静默剥离；
2. **还原节点**：`nodeToNodeView` 在围栏块/HtmlBlock/HtmlInline 分支用 `parseTagLiteral` 还原为 `CustomTagView` 节点（含 `customTag/customAttrs/customContent` 三元组）；
3. **渲染分发**：`CJMarkdown` 通过 `customTagViewComponent` 回调宿主 Builder。

未注册标签行为不变（预处理不包、解析层丢弃），存量 markdown 零影响。

测试用例：`entry/src/main/resources/rawfile/037_SduiCard/`（001 酒店/机票卡片混排、002 非法 JSON 容错）。


## 四、职责分层

| 层 | 模块 | 职责 |
| --- | --- | --- |
| 使用方（entry） | 页面/组件 | 引入依赖、构造三件套、注入 `CJMarkdown`、实现回调与主题定制 |
| 库（markdown_arkui） | `CJMarkdown` | 解析调度 + 渲染分发 |
| 库 | `MarkdownParserUtils` | AST → NodeView 树（含增量复用） |
| 库 | `MarkdownConfiguration` | 交互回调、样式注入、全局文本、段落高亮 |
| 库 | `MarkdownPlugin` | 特性开关（表格/公式/音视频/HTML…） |
| 库 | `MarkdownTheme` 系列 | 全量可定制样式 |

## 五、设计要点

1. **零成本接入**：一个组件 + 一个配置即可渲染，标配即可用。
2. **能力按需开启**：插件默认全关，只有显式 `setIsXxx(true)` 才参与解析，未开启特性零回归。
3. **渲染与业务解耦**：库只负责把 Markdown 渲染成 UI，点击/复制/曝光等行为全部通过回调还给宿主。
4. **响应式 content**：`content` 变化即相机增量解析渲染，天然适配流式/AI 对话场景。
5. **样式全量可配**：段落、标题、代码块、表格、链接、图片等每个块级/行内元素都有独立 Theme，且 setter 支持链式调用。

## 六、约束与限制

- DevEco Studio for Windows 6.1.1.280；
- 表格不支持嵌套标题/块引用/列表/代码块；不支持稀疏/紧密排列
- 链接与删除线并存时只显示删除线中划线
- HTML 标签支持范围见 `markdown_arkui/README.md`
- 视频：mp4、mov、avi、mkv、wmv、flv、webm、m4v、3gp；音频：mp3、wav、aac、flac、ogg、m4a、wma、amr
- 增量解析会导致 TOC/脚注/标题ID/引用链接上下文失效

## 七、验证方式

本仓库 `entry` 内置完整测试用例：

- 首页功能列表 → 逐项进入 `*DetailsPage`，可切换文件、全量/增量加载、深浅色
- `DemoDetailsPage.ets`：最完整的"配置 + 插件 + 主题 + 回调 + 段落高亮"使用范式
- `rawfile/036_CustomCard/`、`037_SduiCard/`：自定义卡片与 SDUI 卡片接入用例

完整 API 清单见 `doc/feature_api.md`。