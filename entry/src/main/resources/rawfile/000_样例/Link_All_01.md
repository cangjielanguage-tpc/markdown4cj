# Markdown 链接 完整测试数据（全覆盖）
包含：**所有标准链接语法 + 嵌套在列表/表格/引用/代码/加粗中 + 合法/非法/特殊场景**，直接复制即可测试渲染。

---

## 一、基础合法链接（全部可渲染）
### 1. 行内链接（最常用）
[鸿蒙官网](https://www.harmonyos.com)
[带标题提示](https://www.harmonyos.com "悬停查看标题")

### 2. 引用式链接（分离写法）
[鸿蒙开发者官网][dev]
[华为主页][huawei]

[dev]: https://developer.huawei.com/consumer/cn/ "开发者中心"
[huawei]: https://www.huawei.com "华为官方"

### 3. 页内锚点链接（跳转到标题）
[跳转到：非法链接测试](#-四-非法链接-无法正常渲染)
[回到顶部](#markdown-链接-完整测试数据全覆盖)

### 4. 图片链接（图片可点击跳转）
[![鸿蒙图标](https://developer.huawei.com/favicon.ico)](https://www.harmonyos.com)

### 5. 邮箱链接--http或者https可以图片化，其他不行
邮箱：<test@example.com>
[发送邮件](mailto:test@example.com?subject=测试邮件)

### 6. 电话链接--http或者https可以图片化，其他不行
[拨打客服](tel:400-000-0000)

### 7. 角标/脚注链接
这里是测试文本[^1]

### 8. 圆形链接 
[1](https://www.harmonyos.com)

### 9. 空心圆角
[3](ZmlsZS1pZD0xNzQ1MzAzNjA3MTk1MTI3NCZmaWxlLW5hbWU9JUU3JUFFJTgwJUU3JTlGJUFEJUU0JUJCJThCJUU3JUJCJThEJUU2JTlEJUFEJUU1JUI3JTlFJUU5JTk3JUFFJUU3JUFEJTk0XzIwMjUwNDIyMTIxNDA1ODk1LnBkZg==)


---

## 二、链接嵌套在其他结构中（混合渲染）
### 1. 无序列表 + 链接
- 基础链接：[百度](https://www.baidu.com)
- 带标题：[Google](https://www.google.com "搜索")
- 图片链接：![小图标](https://via.placeholder.com/16) [测试](https://test.com)
- [测试-单行链接](https://test.com)
### 2. 有序列表 + 链接
1. 第一步：打开 [Github](https://github.com)
2. 第二步：访问 [Gitee](https://gitee.com)

### 3. 加粗/斜体/删除线 内嵌套链接
**加粗嵌套 [鸿蒙链接](https://harmonyos.com)**
*斜体嵌套 [测试链接](https://test.com)*
~~删除线嵌套 [失效链接](https://invalid.com)~~

### 4. 引用块内嵌套链接
> 官方文档：[HarmonyOS 字体](https://developer.harmonyos.com/docs)
> 嵌套多行链接：[主页](/) [帮助](/#)

### 5. 表格内嵌套链接（高频测试）
| 类型 | 可点击链接 | 带样式链接 |
|------|------------|------------|
| 官网 | [鸿蒙](https://harmonyos.com) | **[华为](https://huawei.com)** |
| 开发 | [DevEco](https://devecos.huawei.com) | *[文档](https://dev.huawei.com)* |

### 6. 表格滚动条

| 序号 | 数据1       | 数据2       | 数据3       | 数据4       | 数据5       | 数据6       | 数据7       | 数据8       | 数据9       | 数据10      |
|------|-------------|-------------|-------------|-------------|-------------|-------------|-------------|-------------|-------------|-------------|
| 1    | 百度[^1]   | 单元格1-2   | 单元格1-3   | 单元格1-4   | 单元格1-5   | 单元格1-6   | 单元格1-7   | 单元格1-8   | 单元格1-9   | 单元格1-10  |
| 2    | 单元格2-1   | AI[^2]     | [百度AI平台](https://) | 单元格2-4   | 单元格2-5   | 单元格2-6   | 单元格2-7   | 单元格2-8   | 单元格2-9   | 单元格2-10  |


### 7. 代码块内/行内代码 嵌套链接
行内代码包裹链接：`查看文档：https://dev.huawei.com`
代码块内链接（仅文本，不可点）：
```
https://www.test.com
[链接文本](https://test.com)
```

### 8. 任务列表 + 链接
- [x] 已完成：[查看文档](https://doc.com)
- [ ] 待办：[配置环境](https://env.com)

---

## 三、高级/特殊合法链接
### 1. 相对路径链接-
[上级目录](../)
[当前文件](./readme.md)

### 2. 带特殊字符的链接
[带参数链接](https://test.com?name=测试&id=123#title)
[带空格链接](<https://test.com/file name.md>)

### 3. 空链接（合法，不跳转）
[空链接](#)
[空文本链接]()

---

## 四、非法链接（无法正常渲染）
### 1. 语法残缺（括号/方括号不匹配）
[残缺链接(https://test.com)
残缺链接]https://test.com)
[](缺少地址

### 2. 纯文本链接（无语法包裹）
https://test.com
www.test.com
test@example.com

### 3. 无效协议链接（非 http/https/mailto/tel 等）
[无效协议](test://invalid.com)
[未知协议](abc://123.456)

### 4. 错误格式链接
[错误嵌套](https://[test].com)
[空格未转义](https://test.com file name)

### 5. 代码块内链接（强制不渲染）
```
https://www.huawei.com
[链接](https://harmonyos.com)
```

---

## 五、终极混合测试（全结构嵌套）
- 顶级列表项：**[加粗链接](https://a.com)**
    - 二级列表：*[斜体链接](https://b.com)*
        - 三级列表：![图标](https://via.placeholder.com/16) [图片+文字](https://c.com)
> 引用内链接：[锚点](#)
| 表格 | [链接1](/) | [链接2](#) |

---

### 总结
这份数据覆盖 **100% 链接渲染场景**：
✅ 所有合法链接语法（行内/引用/锚点/图片/邮箱/电话）
✅ 链接嵌套在：列表、表格、引用、加粗、斜体、任务列表
✅ 纯文本、残缺语法、无效协议 = **非法链接**
直接复制到编辑器即可完整测试！

[^1]: 这是脚注链接对应的内容