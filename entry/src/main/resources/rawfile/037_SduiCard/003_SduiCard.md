# SDUI 卡片点击事件验证用例

本用例验证 markdown 中嵌入的 **SDUI 卡片支持点击交互**：卡片按钮通过 DSL `actions` 声明 `onClick` 回调，点击后事件经 SDUI 引擎分发到宿主注册的 action handler。

## 用例说明

- 卡片复用 001 用例的酒店卡片（图片 + 文字 + 价格），价格下方新增两个按钮
- 「查看详情」→ `type=callback` 自定义回调，点击弹出弹框显示酒店详细信息
- 「立即预订」→ `type=link` SDUI 标准跳转事件，点击跳转预订空白页（`target` 直接声明目标页）
- 页面顶部「点击验证」状态栏记录最近一次点击来源与累计次数

**点击验证卡片**

<sdui data='{"type":"View","props":{"style":{"width":"320px","padding":"12px","backgroundColor":"#FFFFFFFF","borderRadius":"12px","display":"flex","flexDirection":"row","alignItems":"center"}},"children":[{"type":"Image","props":{"src":"resource://rawfile/hotel.png","style":{"width":"88px","height":"88px","borderRadius":"8px"}}},{"type":"View","props":{"style":{"display":"flex","flexDirection":"column","marginLeft":"12px"}},"children":[{"type":"Text","props":{"text":"外滩景观大酒店","style":{"fontSize":"16px","fontWeight":"700","color":"#1F2937FF"}}},{"type":"Text","props":{"text":"黄浦江景房 · 免费升房","style":{"fontSize":"12px","color":"#6B7280FF","marginTop":"4px"}}},{"type":"Text","props":{"text":"¥1288 起","style":{"fontSize":"14px","fontWeight":"700","color":"#DC2626FF","marginTop":"6px"}}},{"type":"View","props":{"style":{"display":"flex","flexDirection":"row","marginTop":"8px"}},"children":[{"type":"Text","props":{"text":"查看详情","style":{"width":"94px","height":"30px","lineHeight":"30px","fontSize":"12px","fontColor":"#FFFFFFFF","backgroundColor":"#3B82F6FF","borderRadius":"6px","textAlign":"center","marginRight":"8px"}},"actions":[{"trigger":"onClick","type":"callback","target":"onSduiCardClick","data":{"label":"查看详情"}}]},{"type":"Text","props":{"text":"立即预订","style":{"width":"94px","height":"30px","lineHeight":"30px","fontSize":"12px","fontColor":"#FFFFFFFF","backgroundColor":"#16A34AFF","borderRadius":"6px","textAlign":"center"}},"actions":[{"trigger":"onClick","type":"link","target":"pages/BlankPage"}]}]}]}]}'></sdui>

## 操作步骤

1. 点击卡片中的「查看详情」：应弹出弹框，显示酒店详细信息（名称 / 房型 / 价格）
2. 点击卡片中的「立即预订」：应跳转到预订空白页
3. 观察页面顶部「点击验证」状态栏：计数随每次点击递增，label 与所点按钮一致

> 图片与文字节点未声明 actions，不可点击；仅两个按钮注册了 onClick。

结尾段落：点击事件与 markdown 混排渲染互不影响。
