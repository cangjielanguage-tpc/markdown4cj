# 标题链接曝光测试

本用例验证各级标题（H1~H6）内含 http 链接的曝光统计。标题在长文中作为锚点，滚动进出屏时链接应与段落场景一样「显示/消失」成对回调。

# H1 标题含链接 [百度](https://baidu.com)

H1 标题内的链接，验证最高级标题曝光。下面用撑高段落制造滚动距离。

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

## H2 标题含链接 [GitHub](https://github.com)

H2 标题内的链接，验证二级标题曝光。标题下方常接段落，链接独立统计不串扰。

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

### H3 标题含链接 [Stack Overflow](https://stackoverflow.com)

H3 标题内的链接，验证三级标题曝光。

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

#### H4 标题含链接 [淘宝](https://taobao.com)

H4 标题内的链接，验证四级标题曝光。小字号标题链接矩形更小，验证阈值裁剪仍准确。

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

##### H5 标题含链接 [京东](https://jd.com)

H5 标题内的链接，验证五级标题曝光。

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

###### H6 标题含链接 [知乎](https://zhihu.com)

H6 标题内的链接，验证最低级标题曝光。

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.

## 撑高段落（间隔）

At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident. Similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus.

## 多链接标题

### 同一标题含多个链接 [网易](https://163.com) 与 [哔哩哔哩](https://bilibili.com)

同一 H3 标题内并列两条 http 链接，验证偏移表聚合不串扰（两条链接 rangeStart/rangeEnd 各自独立，分别判定可见性）。

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

## 标题与正文链接相邻

### [腾讯](https://qq.com) 标题链接紧邻正文链接

紧邻标题的正文段落也含 [新浪](https://sina.com.cn) 链接，验证标题链接与段落链接曝光互不串扰（各自 NodeView 独立统计）。

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.

## 结尾 H2 标题含链接 [Google](https://google.com)

文末最后一条标题链接，验证长文末尾标题曝光正常，且滚动出屏后能补发消失回调。
