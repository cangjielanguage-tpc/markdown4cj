# SDUI 卡片异常容错用例

## 用例说明

- 卡片一：data 属性为非法 JSON，应在卡片位置显示 SDUI 错误提示，前后 markdown 不受影响
- 卡片二：合法卡片紧随异常卡片，应正常渲染（互不影响）

**异常卡片：非法 JSON**

<sdui data='{"type":"View" '></sdui>

异常卡片之后的段落应正常渲染。

**合法卡片：应正常显示**

<sdui data='{"type":"View","props":{"style":{"width":"280px","padding":"12px","backgroundColor":"#F0FDF4FF","borderRadius":"10px"}},"children":[{"type":"Text","props":{"text":"异常后恢复渲染","style":{"fontSize":"14px","color":"#15803DFF"}}}]}'></sdui>

> 结束：容错与恢复均符合预期。
