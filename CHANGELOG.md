# 2.0.0

1. 适配 DevEco Studio 6.1.1（compatibility-sdk-6.1.1.280），cjc 版本 v1.1.3
2. 新增仓颉侧 Markdown 解析核心通过 ark_interop 互操作暴露给 ArkTS 侧的架构
3. 新增 `MarkdownParser` 解析器入口接口，支持 `parse(md: string): Promise<JsNode>` 异步解析
4. 新增 `Options` 解析初始化选项，包括 `jsNodeFactory` 节点复用工厂和 `includeSourceSpans`（0:不包含 1:仅 Block 节点 2:全部节点）
5. 新增 `JsNode` 节点树接口（nodeType/parent/firstChild/lastChild/previous/next/appendChild/unlink/literal/destination/title 等）和 `SourceSpan` 位置信息接口
6. 新增 `JsNodeImpl` 默认节点实现类
7. 新增 `JsNodeSendableImpl` 可跨线程（@Sendable）使用的节点实现类
8. 新增 `printNode` 节点树调试打印工具
9. 新增 `utf8Index2utf16Index` / `utf16Index2utf8Index` UTF-8 与 UTF-16 字符索引互相转换接口
10. 新增广告语法插件（ADPlugin）
11. 新增音频语法插件（BlockAudioPlugin）
12. 新增视频语法插件（BlockVideoPlugin）
13. 新增组合代码块语法插件（CodeListPlugin）
14. 新增定义列表语法插件（DescListPlugin）
15. 新增 emoji 语法插件（EmojiPlugin），支持轻量模式（EmojiPlugin_light）
16. 新增脚注语法插件（FootnotePlugin）
17. 新增文本高亮语法插件（HighlightDelimeterPlugin）
18. 新增 HTML 语法插件（HtmlPlugin）
19. 新增标题 ID 语法插件（IdHeadingPlugin）
20. 新增图片收集插件（ImageCollectPlugin）
21. 新增图片幻灯片插件（ImageSinglePlugin / ImageSlidePlugin）
22. 新增图片样式插件（ImageStylePlugin）
23. 新增图文混排插件（ImageTextMixPlugin）
24. 新增图片视频插件（ImageVideoPlugin）
25. 新增数学公式语法插件（LatexMathPluginV2）
26. 新增自动网址链接插件（LinkifyPlugin），支持自定义正则（LinkifyPlugin_regs）
27. 新增超链接图片化插件（LinkViewPlugin）
28. 新增节点 ID 插件（NodeIdPlugin），需要最后添加
29. 新增删除线语法插件（StrikethroughPlugin）
30. 新增下标/上标语法插件（SubPlugin / SupPlugin）
31. 新增表格语法插件（TablePlugin）
32. 新增任务列表语法插件（TaskListPlugin）
33. 新增 Toc 目录语法插件（TocPlugin）
34. 新增自定义卡片插件（BlockCustomCardPlugin），支持 blockImageCard / blockLinkCard 自定义回调
35. 新增宽松/严格/白名单限定符插件（WhitelistLooseDelimiterPlugin），支持 Permissive / Strict / 白名单数组过滤模式
