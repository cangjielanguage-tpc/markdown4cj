# Markdown 接入 SDUI 方案说明

## 一、使用的标签

```markdown
<sdui data='{"type":"View","props":{"style":{...}},"children":[...]}'></sdui>
```

| 组成 | 说明 |
| --- | --- |
| 标签名 | `sdui`（自定义，宿主启动时注册，可扩展其他标签） |
| `data` 属性 | SDUI DSL 的 JSON 字符串（单引号包裹，避免与 JSON 内部双引号冲突） |
| 书写位置 | 独占一行、块级使用；支持完整开闭标签 `<sdui ...></sdui>` 与自闭合 `<sdui .../>` |

## 二、Markdown 处理流水线（6 步）

```
原文 → ①注册 → ②预处理 → ③解析 → ④还原 → ⑤提升 → ⑥渲染
```

### ① 宿主注册标签（entry/src/main/ets/pages/SduiCardDetailsPage.ets）

```typescript
aboutToAppear(): void {
  CustomViewRegistry.register('sdui')        // 登记标签名（全局注册表）
  this.markdownPlugin.setIsHtmlPlugin(true)  // 开启 HTML 插件
}
```

标签只有注册后才会被拦截；未注册标签走原有丢弃逻辑，**零回归**。

### ② 解析前文本预处理（markdown_arkui/.../plugin/CustomViewRegistry.ets `preprocessCustomTags`）

**这是本方案的核心，用于绕过 Cangjie 解析器的限制。**

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

### ③ Markdown 解析（markdown_arkui/.../components/MarkdownComponent.ets）

```typescript
markdownParser.parse(CustomViewRegistry.preprocessCustomTags(this.content))
```

预处理后的文本进入解析器，`<sdui>` 原文以 FencedCodeBlock 节点形态存活于 AST。

### ④ AST 还原为自定义节点（markdown_arkui/.../utils/MarkdownParserUtils.ets）

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

### ⑤ 行内提升（MarkdownParserUtils.ets `liftCustomTagBlocks`）

若标签落在段落行内流（HtmlInline 产物），后处理把段落**拆段提升**：

```
段落 → [前段切片, 卡片, 后段切片]
```

保证卡片以块级形态出现在正确位置（表格单元格内不提升）。

### ⑥ 渲染分发（MarkdownComponent.ets）

```typescript
} else if (item.customTag !== undefined) {
  this.customTagViewComponent(item.customTag, item.customAttrs ?? {}, item.customContent ?? "")
}
```

`customTagViewComponent` 是 `@BuilderParam`，由宿主注入——**库不依赖 SDUI，宿主决定标签怎么渲染**：

```typescript
// SduiCardDetailsPage.ets（宿主侧）
@Builder
SduiTagViewBuilder(tag: string, attrs: Record<string, string>, content: string) {
  if (tag === 'sdui') {
    SDUIView({ json: attrs['data'] ?? '' })  // 取 data 属性 → SDUI 引擎原生渲染
  }
}

CJMarkdown({
  content: this.content,
  plugin: this.markdownPlugin,
  customTagViewComponent: this.SduiTagViewBuilder  // 注入
})
```

## 三、职责分层

| 层 | 模块 | 职责 |
| --- | --- | --- |
| 库（markdown_arkui） | CustomViewRegistry | 标签注册表 + 预处理 + 标签原文解析 |
| 库 | MarkdownParserUtils | AST 拦截还原（CustomTagView 节点）+ 行内提升 |
| 库 | MarkdownComponent | 渲染分发（BuilderParam 回调宿主） |
| 宿主（entry） | SduiCardDetailsPage | 注册 `sdui` 标签 + 提供 Builder → `SDUIView` |

## 四、设计要点

1. **围栏载体是方案基石**：不改造 Cangjie 解析器，用解析器保证完整保留的 fenced literal 承载标签原文，规避静默剥离。
2. **注册制拦截**：只拦已注册标签，未注册标签行为不变，对存量 markdown 零影响。
3. **渲染与解析解耦**：库只产出 `customTag/customAttrs/customContent` 三元组，渲染交给宿主 Builder，任意标签可接入任意组件（不止 SDUI）。

## 五、验证方式

测试用例位于 `entry/src/main/resources/rawfile/037_SduiCard/`：

- `001_SduiCard.md`：酒店卡（View+Image+Text）+ 机票卡（嵌套 Flex）混排在标题/列表/加粗/引用中；
- `002_SduiCard.md`：非法 JSON 容错 + 异常后恢复。

路径：首页 →「39、SDUI卡片接入」→ 001/002。设备实测 UI 树已确认卡片内容（外滩景观大酒店/¥1288 起、CJ6688/09:30 等）正确渲染，markdown 混排正常，无代码块误渲染。
