## 混合表格
| 序号 | 基础文本元素 | 链接与媒体 | 列表与结构 | 代码与格式 | 特殊符号 | HTML 混合 | 数学与标注 |
| ---- | ------------ | ----------- | ----------- | ---------- | -------- | --------- | ---------- |
| 1    | 普通文本     | [百度](https://www.baidu.com)<br>![测试图](https://img0.baidu.com/it/u=3788542909,4147717639&fm=253&fmt=auto&app=138&f=JPEG?w=323&h=485) | - 无序列表1<br>- 无序列表2<br>1. 有序列表1<br>2. 有序列表2 | `print(123)`<br>```python<br>a = 1<br>print(a)<br>``` | 😀🔥🚗📱 | <div style="color:blue">蓝色文本</div><br><hr> | X^2^ + Y^3^<br>H~2~O |
| 2    | ~~删除线文本~~<br>**加粗**<br>*斜体* | [GitHub](https://github.com)<br>![图标](https://img0.baidu.com/it/u=3788542909,4147717639&fm=253&fmt=auto&app=138&f=JPEG?w=323&h=485) | - 水果<br>  - 苹果<br>  - 香蕉<br>1. 步骤<br>  1.1 准备<br>  1.2 执行 | `const a = 10`<br>```javascript<br>function test() {<br>  return "test";<br>}<br>``` | 🎉🎈⚡️⭐️ | <button>测试按钮</button><br><br><i>HTML斜体</i> | E=mc^2^<br>log~10~(100) |
| 3    | 脚注测试[^fn1] | [豆包](https://www.doubao.com)<br>![示例图](https://img0.baidu.com/it/u=3788542909,4147717639&fm=253&fmt=auto&app=138&f=JPEG?w=323&h=485) | - 编程语言<br>  - Python<br>  - Java<br>1. 任务<br>  1. 完成<br>  2. 复盘 | `SELECT * FROM table`<br>```sql<br>INSERT INTO t VALUES (1);<br>``` | 📝✏️🔍🔧 | <span style="font-size:16px">自定义字号</span><br><u>下划线</u> | a_n = a_1 + (n-1)d<br>π≈3.14159 |
| 4    | 混合文本😜**测试**~~内容~~ | [知乎](https://www.zhihu.com)<br>![测试图2](https://img0.baidu.com/it/u=3788542909,4147717639&fm=253&fmt=auto&app=138&f=JPEG?w=323&h=485) | - 操作系统<br>  - Windows<br>  - Linux<br>1. 版本<br>  1. v1.0<br>  2. v2.0 | `echo "hello"`<br>```bash<br>ls -l<br>cd /home<br>``` | 🖥️⌨️🖱️💻 | <table border="1"><tr><td>嵌套表格</td></tr></table> | ∑^n^~i=1~ i = n(n+1)/2<br>√2≈1.414 |





















[^fn1]: 这是表格内脚注的示例内容，用于测试脚注渲染效果