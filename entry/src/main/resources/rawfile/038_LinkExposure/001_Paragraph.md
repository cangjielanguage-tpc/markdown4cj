# 段落链接曝光测试

本用例验证段落内 http 链接的曝光统计：链接进入屏幕可见区（≥50%面积）触发 `visible:true`，滚出触发 `visible:false`，成对上报。

## 第一组：短链接（单 TextBox）

这是第一条测试链接：[百度首页](https://baidu.com)，用于验证基础曝光。

下方为撑高文本，确保链接需滚动才能进入视口。Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

这是第二条测试链接：[新浪首页](https://sina.com.cn)，与第一条间隔一段撑高文本，验证不同段落的独立曝光。

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.

## 第二组：长链接文本（多 TextBox 聚合）

这是一个长链接文本的测试，链接文字很长会换行产生多个 TextBox：[这是一个非常非常非常长的链接显示文本用于测试多行链接的曝光面积聚合计算逻辑](https://example.com/very/long/link/test/case/multi/line)

Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.

## 第三组：一段含多个链接

同一段内含三条链接，验证段内多链接的独立曝光：[网易](https://163.com)、[腾讯](https://qq.com)、[知乎](https://zhihu.com)，三者各自独立统计。

At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident. Similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio.

## 第四组：非 http 链接（不参与曝光）

这条例子是相对链接 [相对链接](./local/path)，不应触发曝光回调，因为只有 http/https 链接参与统计。

Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet.

## 第五组：间隔大段撑高

[GitHub](https://github.com) 是全球最大的代码托管平台，验证链接在长文末尾的曝光。

Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur. At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident.

[Stack Overflow](https://stackoverflow.com) 是程序员问答社区，与上一条间隔撑高文本。

Totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

[Google](https://google.com) 搜索引擎，用于验证最后一条链接滚入滚出。

Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam.

## 第六组：连续短段多链接

[哔哩哔哩](https://bilibili.com) 视频社区。

[淘宝](https://taobao.com) 电商平台。

[京东](https://jd.com) 电商平台。

 nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.
