<div align="center">
<h1>Markdown4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v1.1.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.53.18-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-NA-red" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## 介绍

Markdown是一种轻量级标记语言，排版语法简洁，让人们更多地关注内容本身而非排版。

Markdown4cj是一个用仓颉语言编写的适用于鸿蒙系统的Markdown库。

## 优势

- 使用高效便捷
- 扩展性强，用户可自定义Markdown显示样式
- 符合 Markdown 规范

### 特性

1. 支持增量加载渲染
2. 支持标题语法
3. 支持段落语法
4. 支持分割线语法
5. 支持内联代码语法
6. 支持缩进代码块语法
7. 支持围栏代码块语法
8. 支持加粗语法
9. 支持斜体语法
10. 支持转义字符语法
11. 支持删除线语法
12. 支持链接语法
13. 支持自动网址链接语法
14. 支持部分html语法
15. 支持软硬换行语法
16. 支持表格语法
17. 支持有序列表语法
18. 支持无序列表语法
19. 支持任务列表语法
20. 支持块引用语法
21. 支持Toc目录语法
22. 支持数学公式语法
23. 支持脚注语法
24. 支持图片语法
25. 支持图片Style语法
26. 支持图片幻灯片语法
27. 支持组合代码块语法
28. ~~支持视频语法~~
29. 支持围栏代码块高亮功能
30. 支持列表嵌套功能
31. 支持文本样式设置
32. 支持表格样式设置
33. 支持超链接图片化设置
34. 支持深浅主题色设置

## 软件架构

![](https://raw.gitcode.com/Cangjie-TPC/markdown4cj/blobs/5a5352e79bdc3af5dc6907686876b5cf7f4ca53e/img.png)

### 源码目录

```shell
─markdown
  └─src
      └─main
          ├─cangjie
          │  └─src
          │      ├─components
          │      ├─core
          │      ├─texttoimg4cj
          │      └─plugin
          ├─cpp
          └─resources

```

- `markdown` 工程模块 - 编译生成一个har包
- `markdown src` 模块代码目录
- `markdown src main` 模块项目目录
- `markdown src main cangjie` 仓颉代码目录
- `markdown src main cpp` cpp代码目录
- `markdown src main resources` 资源文件目录
- `markdown src main cangjie src components` markdown UI页面目录
- `markdown src main cangjie src core` markdown 数据解析处理目录
- `markdown src main cangjie src texttoimg4cj` markdown 文本转图片模块
- `markdown src main cangjie src plugin` markdown 插件化目录

### 接口说明

主要类和函数接口说明详见 [API](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/develop/doc/API.md)

## 使用说明

### 编译构建

1. 下载安装
   通过中心仓下载安装

      ```sh
      ohpm install @cangjie-tpc/markdown
      ```

2. 在项目中使用markdown项目
   ```cangjie
   import markdown.components.*
   ```

### 功能示例

```cangjie
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import markdown.components.*

@Entry
@Component
class ARHeading1Page {
    func build() {
        Scroll() {
            Column {
                MarkdownComponent(output: mdStr, isFull: true)
            }
        }
        // 设置滚动方法
        .scrollable(ScrollDirection.Vertical)
    }

    let mdStr: String = """
### 标题1

# 1级标题

### 标题2

## 2级标题

### 标题3

### 3级标题

### 标题4

#### 4级标题

### 标题5

##### 5级标题

### 标题6

###### 6级标题

### 标题7

### 正常标题

### 标题8

Heading level 1
===============

### 标题9

Heading level 2
---------------

### 标题10

Heading level 1
=

### 标题11

Heading level 2
-

"""
}
```

### 显示效果

![](https://raw.gitcode.com/Cangjie-TPC/markdown4cj/blobs/c2964f6d5916d7cbeac768b7967062e76ab67a5a/img1.png)

## 约束与限制

当前基于 DevEco Studio for Windows 5.0.13.200 和 DevEco Studio Cangjie Plugin Canary for Windows 5.0.13.200 版本实现的

1. 内联代码暂未支持背景色设置
2. 链接和删除线同时存在情况，只支持显示删除线的的中划线，不显示链接的下划线
3. 围栏代码块高亮语言支持如下(语言类型不区分大小写，每行如有多个则表示该语言支持别名书写)：
   1. brainfuck
   2. c
   3. clike
   4. clojure
   5. cpp、c++
   6. csharp、dotnet、c#
   7. css_extras
   8. css
   9. dart
   10. git
   11. go、golang
   12. groovy
   13. java
   14. javascript、js、typescript、ts
   15. json、jsonp
   16. kotlin
   17. latex
   18. makefile
   19. markdown、md
   20. markup、svg
   21. python、python3、py、py3、Python ML、pythonml、pandas、pythondata
   22. scala
   23. sql、mysql、oracle、oraclesql、sqlserver、MS SQL Server、mssql、postgresql、pgsql
   24. swift
   25. yaml
   26. cangjie、cj
   27. rust
4. 表格限制：
   1. 不支持行内添加标题
   2. 不支持行内添加块引用
   3. 不支持行内添加有序、无序、任务列表
   4. 不支持行内添加图片
   5. 不支持行内添加视频
   6. 不支持行内添加图片banner
   7. 不支持行内添加缩进代码块、围栏代码块、围栏代码组合列表块
5. ImageStyle只支持宽高样式设置，暂不支持圆角和对齐方式设置
6. TOC插件应在最后加载, 避免受其他插件影响
7. 暂未支持稀疏排列和紧密排列
8. 数学公式背景色暂不支持设置透明色
9. HTML支持的标签
   1. 块元素
      1. hr标签 - 分割线
      2. h1~h6标签 - 标题
      3. blockquote标签 - 块引用
      4. ul、ol、li标签 - 有序列表和无序列表
      5. table、thead、tbody、tfoot、tr、th、td标签 - 表格
      6. pre标签 - 缩进代码块
      7. p标签 - 段落标签
   2. 行内元素
      1. font标签 - 文本样式
         * color属性
         * size属性
      2. a标签 - 链接
         * href属性 - 必选属性
         * title属性
      3. b、strong标签 - 加粗
      4. i、em、cite、dfn标签 - 斜体
      5. s、del标签 - 删除
      6. code、samp、var、kbd标签 - 内联代码
   3. 行内块元素
      1. br标签 -  换行符
      2. img标签 - 图片
         * src属性 - 必选属性
         * title属性
         * width属性
         * height属性

## 开源协议

本项目基于 [Apache License 2.0](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/develop/markdown/LICENSE) ，请自由的享受和参与开源。

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。
