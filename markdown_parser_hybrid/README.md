<div align="center">
<h1>Markdown Parser Hybrid</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v2.0.0-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v1.1.3-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## 介绍

`@cangjie-tpc/markdown_parser_hybrid` 是一个仓颉与 ArkTS 互操作（hybrid）的 Markdown 解析库。

解析核心由仓颉语言实现（基于 commonmark4cj 引擎与插件体系），通过 ArkTS 侧的 `MarkdownParser` 接口对外暴露，解析结果以 `JsNode` 节点树返回，方便 ArkTS 侧应用（如 Markdown 渲染组件、AI 流式输出场景）直接消费。

解析器设计参考了 [Markwon v4.6.2](https://github.com/noties/Markwon)（Android Markdown 库）。

## 优势

- 仓颉侧解析性能好，ArkTS 侧接入简单
- 插件化架构，可按需开启语法扩展
- 解析结果为标准 `JsNode` 节点树，可自行遍历构建 UI
- 支持 SourceSpan 位置信息，可用于增量解析等场景
- 支持 JS 节点工厂复用，降低高频解析（流式输出）时的对象分配

### 特性

1. 支持标题语法解析
2. 支持段落语法解析
3. 支持分割线语法解析
4. 支持内联代码、缩进代码块、围栏代码块语法解析
5. 支持加粗、斜体、删除线、上下标语法解析
6. 支持链接、自动网址链接、超链接图片化语法解析
7. 支持图片语法解析（图片收集、图片样式、图文混排、图片幻灯片）
8. 支持表格语法解析
9. 支持有序/无序/任务列表语法解析
10. 支持块引用语法解析
11. 支持部分 HTML 语法解析
12. 支持软硬换行语法解析
13. 支持数学公式语法解析（LatexMathPluginV2）
14. 支持脚注语法解析
15. 支持定义列表语法解析
16. 支持标题 ID 语法解析
17. 支持 emoji 语法解析
18. 支持文本高亮（`==`定界符）语法解析
19. 支持 Toc 目录语法解析
20. 支持组合代码块语法解析
21. 支持视频/音频语法解析
22. 支持广告（AD）语法自定义解析
23. 支持自定义卡片（BlockCustomCardPlugin）自定义解析
24. 支持自定义正则实现自定义自动链接
25. 支持宽松/严格/白名单限定符设置
26. 支持同步/异步（Promise）解析接口
27. 支持 SourceSpan 信息（不包含/仅 Block 节点/全部节点）
28. 支持 UTF-8 与 UTF-16 字符索引互相转换

## 软件架构

```shell
─markdown_parser_hybrid
  └─src
      └─main
          ├─cangjie
          │  ├─loader           # ark_interop 加载器
          │  ├─types            # 仓颉 so 的 TS 类型声明
          │  ├─hybrid_parser.cj # 仓颉侧解析入口与插件装配
          │  ├─js_node_builder.cj # 仓颉节点树 -> JsNode 节点树构建
          │  └─custom_card_util.cj # 自定义卡片插件工具
          └─ets
              ├─MarkdownParser.ts   # ArkTS 侧解析器入口
              ├─Options.ts          # 解析初始化选项
              ├─JsNode.ts           # JsNode 节点树接口
              ├─JsNodeImpl.ts       # JsNode 默认实现
              ├─JsNodeSendable.ets  # 可跨线程传递的节点实现
              ├─interop.ts          # 仓颉 so 互操作封装
              └─util.ts             # printNode 与索引转换工具
```

- `markdown_parser_hybrid` 工程模块 - 编译生成一个 har 包
- `src main cangjie` 仓颉代码目录 - 解析核心，编译为 `libmarkdown_parser_hybrid.so`
- `src main ets` ArkTS 代码目录 - 对外导出的 TS/ETS 接口

### 接口说明

主要导出接口：

| 接口 | 说明 |
|----|----|
| `MarkdownParser` | 解析器入口，`new MarkdownParser(opt: Options)`，`parse(md: string): Promise<JsNode>` |
| `Options` | 解析初始化选项（节点工厂、SourceSpan、插件开关） |
| `JsNode` / `SourceSpan` | 解析结果节点树接口与位置信息 |
| `JsNodeImpl` | `JsNode` 的默认实现类 |
| `JsNodeSendableImpl` | 可跨线程（@Sendable）使用的节点实现类 |
| `printNode` | 将节点树打印为字符串，用于调试 |
| `utf8Index2utf16Index` / `utf16Index2utf8Index` | UTF-8 与 UTF-16 字符索引互相转换 |

`Options` 主要字段：

| 字段 | 说明 |
|----|----|
| `jsNodeFactory` | JsNode 复用工厂，一般传 `() => new JsNodeImpl()` |
| `includeSourceSpans` | 是否包含 SourceSpan 信息，`0`:不包含（默认） `1`:仅 Block 节点 `2`:全部节点 |
| 各类 `xxxPlugin` | 语法扩展插件开关，详见下方插件列表 |
| `LinkifyPlugin_regs` | 自定义自动链接正则数组 |
| `WhitelistLooseDelimiterPlugin_DelimiterFilterMode` | 限定符过滤模式：`"Permissive"` / `"Strict"` / 白名单数组 |
| `blockImageCard` / `blockLinkCard` | 自定义卡片回调：图片卡片 / 链接卡片是否命中 |

支持开启的插件：

| 插件 | 说明 |
|----|----|
| `ADPlugin` | 广告语法 |
| `BlockAudioPlugin` | 音频语法 |
| `BlockVideoPlugin` | 视频语法 |
| `CodeListPlugin` | 组合代码块语法 |
| `DescListPlugin` | 定义列表语法 |
| `EmojiPlugin` / `EmojiPlugin_light` | emoji 语法（light 为轻量模式） |
| `FootnotePlugin` | 脚注语法 |
| `HighlightDelimeterPlugin` | 文本高亮语法 |
| `HtmlPlugin` | HTML 语法 |
| `IdHeadingPlugin` | 标题 ID 语法 |
| `ImageCollectPlugin` | 图片收集 |
| `ImageSinglePlugin` / `ImageSlidePlugin` | 图片幻灯片 |
| `ImageStylePlugin` | 图片样式 |
| `ImageTextMixPlugin` | 图文混排 |
| `ImageVideoPlugin` | 图片视频 |
| `LatexMathPluginV2` | 数学公式 |
| `LinkifyPlugin` | 自动网址链接 |
| `LinkViewPlugin` | 超链接图片化 |
| `NodeIdPlugin` | 节点 ID（需要最后添加） |
| `StrikethroughPlugin` | 删除线语法 |
| `SubPlugin` / `SupPlugin` | 下标 / 上标语法 |
| `TablePlugin` | 表格语法 |
| `TaskListPlugin` | 任务列表语法 |
| `TocPlugin` | Toc 目录语法 |
| `BlockCustomCardPlugin` | 自定义卡片语法 |
| `WhitelistLooseDelimiterPlugin` | 宽松/严格/白名单限定符 |

## 使用说明

### 编译构建

1. 下载安装
   1. 本地编译安装

      ```git
      git clone https://gitcode.com/Cangjie-TPC/markdown4cj.git
      git checkout markdown_parser_hybrid_cangjie-plugin-6.1.1_compatibility
      ```

      编译 markdown_parser_hybrid 模块：build -> Make Module `markdown_parser_hybrid`

      获取 har 包，har 包路径：`markdown_parser_hybrid -> build -> outputs -> default -> markdown_parser_hybrid.har`

   2. 在项目中引用 har 包后使用：

      ```typescript
      import { MarkdownParser, Options, JsNode } from "@cangjie-tpc/markdown_parser_hybrid"
      ```

### 功能示例

```typescript
import { MarkdownParser, Options, JsNode, JsNodeImpl, printNode } from "@cangjie-tpc/markdown_parser_hybrid"

// 1. 初始化解析选项：按需开启插件
const opt: Options = {
  jsNodeFactory: () => new JsNodeImpl(),
  includeSourceSpans: 0,
  TablePlugin: true,
  TaskListPlugin: true,
  StrikethroughPlugin: true,
  LinkifyPlugin: true,
  HtmlPlugin: true
}

// 2. 创建解析器
const parser = new MarkdownParser(opt)

// 3. 异步解析 markdown 文本，得到节点树
const md = "# 标题\n\n**加粗** 与 *斜体*\n\n| 列1 | 列2 |\n|----|----|\n| a  | b  |"
parser.parse(md).then((doc: JsNode) => {
  // 遍历 doc 节点树，自行构建 UI
  console.info(printNode(doc))
})
```

### 约束与限制

在下述版本验证通过:

| 编号 | 依赖构建工具                                       | 版本号       |
|----|----------------------------------------------|-----------|
| 1  | **DevEco Studio**                            | 6.1.1.280 |
| 2  | **cjc**                                      | v1.1.3    |
| 3  | **DevEco Studio-Cangjie Plugin 6.1.1 Beta1** | 6.1.1.280 |
| 4  | **compatibility-sdk-6.1.1.280**              | 6.1.1.280 |

1. 互操作项目支持 API12 及以上版本
2. `NodeIdPlugin` 自定义设置时需要最后添加
3. 增量解析场景插件需要追加 `includeSourceSpans: 2` 配置，且需要最后添加
4. 增量解析会导致上下文前后文失效（Toc/脚注/标题 ID/引用链接）

## 开源协议

本项目基于 [Apache License 2.0](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown_parser_hybrid_cangjie-plugin-6.1.1_compatibility/LICENSE) ，请自由的享受和参与开源。

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。
