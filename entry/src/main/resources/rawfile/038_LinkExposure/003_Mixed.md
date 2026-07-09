# 混合长文链接曝光测试

本用例验证各类 Markdown 块（段落、表格、列表、引用、定义列表）混合场景下的 http 链接曝光统计。整文较长，需垂直多屏滚动。

## 段落

这是混合场景的段落，含 [百度](https://baidu.com) 链接，验证段落曝光与其它块叠加时的独立性。

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.

## 引用

> 引用块内的链接：[GitHub](https://github.com)，验证引用场景曝光。
>
> 引用块多行内容，第二行也含链接：[Stack Overflow](https://stackoverflow.com)，与上一条同属引用块。

## 有序列表

1. 列表项一，含 [淘宝](https://taobao.com) 链接
2. 列表项二，含 [京东](https://jd.com) 链接
3. 列表项三，不含链接，用于打断聚合
4. 列表项四，含 [知乎](https://zhihu.com) 链接

## 无序列表

- 无序项一，含 [哔哩哔哩](https://bilibili.com) 链接
- 无序项二，含 [网易](https://163.com) 链接
- 无序项三，无链接

## 表格

| 序号 | 名称 | 链接 |
|---|---|---|
| 1 | 新浪 | [新浪首页](https://sina.com.cn) |
| 2 | 腾讯 | [腾讯首页](https://qq.com) |
| 3 | Google | [Google](https://google.com) |

## 定义列表

Markdown
:   轻量标记语言，详见 [Markdown 官方](https://daringfireball.net/projects/markdown/)

CommonMark
:   Markdown 规范实现，详见 [CommonMark](https://commonmark.org)

## 撑高段落（间隔）

At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident. Similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus.

## 第二轮段落

间隔一段后再次出现的链接：[MDN](https://developer.mozilla.org)，验证滚入滚出成对。

Totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.

## 第二轮表格（宽表，测横滚）

| 编号 | 名称 | 类别 | 状态 | 负责人 | 备注 | 链接 |
|---|---|---|---|---|---|---|
| 201 | 任务X | 开发 | 进行中 | 张三 | 核心模块 | [文档](https://example.com/mixed/201) |
| 202 | 任务Y | 测试 | 待开始 | 李四 | 边界测试 | [文档](https://example.com/mixed/202) |
| 203 | 任务Z | 设计 | 已完成 | 王五 | UI 改版 | [文档](https://example.com/mixed/203) |

## 结尾段落

文末最后一条链接：[GitHub](https://github.com)，验证长文末尾曝光正常。

Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur. Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur.
