# SDUI 卡片混合渲染用例

本用例验证 **markdown** 与 **SDUI DSL** 通过自定义标签 `<sdui>` 混合渲染：卡片前后均为普通 markdown 内容，卡片本身由 SDUI 引擎原生渲染嵌入内容流。

## 用例说明

- 卡片一：View + Image + Text 组合（酒店卡片）
- 卡片二：View 嵌套 + 双子布局（机票卡片）
- 卡片前后 markdown 排版（标题 / 列表 / 加粗 / 引用）应保持正常

**卡片一：图片 + 文字组合**

<sdui data='{"type":"View","props":{"style":{"width":"320px","padding":"12px","backgroundColor":"#FFFFFFFF","borderRadius":"12px","display":"flex","flexDirection":"row","alignItems":"center"}},"children":[{"type":"Image","props":{"src":"resource://rawfile/hotel.png","style":{"width":"88px","height":"88px","borderRadius":"8px"}}},{"type":"View","props":{"style":{"display":"flex","flexDirection":"column","marginLeft":"12px"}},"children":[{"type":"Text","props":{"text":"外滩景观大酒店","style":{"fontSize":"16px","fontWeight":"700","color":"#1F2937FF"}}},{"type":"Text","props":{"text":"黄浦江景房 · 免费升房","style":{"fontSize":"12px","color":"#6B7280FF","marginTop":"4px"}}},{"type":"Text","props":{"text":"¥1288 起","style":{"fontSize":"14px","fontWeight":"700","color":"#DC2626FF","marginTop":"6px"}}}]}]}'></sdui>

卡片上方的加粗与列表应正常渲染：

- 项目一：卡片作为块级节点嵌入内容流
- 项目二：卡片布局由 SDUI DSL 声明（宽度、圆角、Flex）

**卡片二：嵌套文本布局**

<sdui data='{"type":"View","props":{"style":{"width":"320px","padding":"14px","backgroundColor":"#EFF6FFFF","borderRadius":"12px","borderWidth":"1px","borderColor":"#BFDBFEFF"}},"children":[{"type":"Text","props":{"text":"CJ6688 上海 → 三亚","style":{"fontSize":"15px","fontWeight":"700","color":"#1D4ED8FF"}}},{"type":"View","props":{"style":{"display":"flex","flexDirection":"row","justifyContent":"space-between","marginTop":"8px"}},"children":[{"type":"Text","props":{"text":"09:30 浦东T2","style":{"fontSize":"12px","color":"#3B82F6FF"}}},{"type":"Text","props":{"text":"12:45 凤凰T1","style":{"fontSize":"12px","color":"#3B82F6FF"}}}]}]}'></sdui>

> 引用块：卡片下方的 markdown 块引用应正常渲染。

结尾段落：两张卡片与 markdown 段落应在同一滚动流中依次排布。
