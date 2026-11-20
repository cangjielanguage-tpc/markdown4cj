# 2.0.1

1. 性能优化：新增批量建树协议 `buildNodes` 与批量构建器 `JsNodeTreeBuilderBatch`（已从 `Index.ets` 导出）。仓颉侧把节点树序列化为扁平数字事件数组，在事件边界累积到 `buildNodesChunkSize`（默认 200）后单次跨语言调用推送，一个 `postJSTask` 对应一个包，推送次数 ≈ `ceil(总事件实参 / chunkSize)`；跨语言回调次数由每节点 4~10 次降为每分片 1 次。release 构建端到端实测（全量 202690 字符 / 6460 节点）批量较逐事件建树快约 1.5~1.7 倍
2. 新增 `Options.buildNodesChunkSize`：批量建树单次推送的事件实参上限，同时作为单个 `postJSTask` 的累积上限（task 边界跟随包边界）；非正值回退 200，超过 255 钳制为 255（仓颉调用 ArkTS 互操作方法最多 255 个实参）
3. 批量能力自动探测：builder 不含 `buildNodes` 时（自定义鸭子类型实现）自动退回逐事件回调路径，行为与旧版一致
4. 批量协议优化：节点类型与字段改为数字 ID 传输（字段 1~29，其中 `29=toStr`；未登记的节点类型回退字符串），ArkTS 侧按 ID 直接分发、不再经字段名映射；新增事件 `9` 叶子快速路径，把 `beginNode + literal + endNode` 合并为单事件（仅 `debug` 关闭且无插件自定义属性的 Text/Code/Html 等 literal 叶子生效，不满足条件时回落通用事件序列，产出节点树完全一致）；`emitEvent` 按实参个数重载，去掉每事件临时数组分配
5. 修复图片样式事件（标记 `7`）超过仓颉→ArkTS 单次调用 255 实参上限的问题：批量路径按 `max(1, min(chunkSize-2, 253))` 个样式分片，非批量路径按 255 个值分片多次调用 `putImageStyles`；新增 300 样式回归用例与 `buildNodes` 实参上限断言
6. 修复 parse 阶段异常时 Promise 永不 settle 的问题（catch 块中 throw 使 reject 不可达，ArkTS 侧 await 永久挂死）
7. **行为变更**：`toStr` 与 `SourceSpan` 统一由 `debug` 开关控制（默认 `false`）。`debug` 关闭时 `includeSourceSpans` 不生效、`toStr` 为空串，且解析期不生成 span、序列化期不传输 span；需要节点内容或位置信息（如 `printNode`、增量解析）时必须显式传 `debug: true`
8. 修复 `JsNodeImpl.putImageStyles` 在节点未持有图片样式时把 `undefined` 拼入 `ImageStyles` 数组的问题（与 `JsNodeSendableImpl` 行为对齐）
9. `JsNodeImpl.sourceSpans` 改为懒分配（默认 `undefined`，首次写入或读取时才创建数组，`reset()` 时复原），`getSourceSpans()` 仍始终返回数组；`addSourceSpans` 实参数不足一组（4 个）时直接忽略
10. 构建配置：`cjpm.toml` 版本升至 2.0.1，release 编译选项追加 `--discard-eh-frame --disable-reflection --stack-trace-format=simple --link-options=--pack-dyn-relocs=relr`；`build-profile.json5` 增加 `strictCheckDependencies: false`；`markdown_parser` 依赖由分支改为 tag `v1.0.0-markdown-parser`
11. 测试与文档：新增 6197 行综合测试文档 `001_Comprehensive_6000Lines.md`；补充批量/非批量等价、分片不变量（不同 `chunkSize` 下总实参与结构一致）、255 实参上限、下游真实配置（批量/非批量 × 插件 × span）性能用例；同步更新 README 与 `Options` 注释

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
