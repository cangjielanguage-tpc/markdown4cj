<div align="center">
<h1>Markdown4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v1.4.0-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v1.0.5-brightgreen" style="display: inline-block;" />
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
2. 支持增量解析
3. 支持markdown滚动操作开关
4. 支持标题语法
5. 支持段落语法
6. 支持分割线语法
7. 支持内联代码语法
8. 支持缩进代码块语法
9. 支持围栏代码块语法
10. 支持代码块格式化配置选项
11. 支持加粗语法
12. 支持斜体语法
13. 支持转义字符语法
14. 支持删除线语法
15. 支持链接语法
16. 支持自动网址链接语法
17. 支持部分html语法
18. 支持软硬换行语法
19. 支持表格语法
20. 支持有序列表语法
21. 支持无序列表语法
22. 支持任务列表语法
23. 支持块引用语法
24. 支持TOC目录语法
25. 支持数学公式语法
26. 支持脚注语法
27. 支持图片语法
28. 支持图片Style语法
29. 支持图片幻灯片语法
30. 支持组合代码块语法
31. 支持视频语法
32. 支持音频语法
33. 支持定义列表语法
34. 支持标题ID语法
35. 支持上标语法
36. 支持下标语法
37. 支持emoji语法
38. 支持文本高亮语法
39. 支持围栏代码块高亮功能
40. 支持列表嵌套功能
41. 支持文本样式设置
42. 支持表格样式设置
43. 支持超链接图片化设置
44. 支持单独代码块设置
45. 支持深浅主题色设置
46. 支持文本长按选中复制粘贴
47. 支持图文混排和图文不混排功能
48. 支持自定义正则实现自定义自动链接
49. 支持宽松/严格/白名单限定符设置

## 软件架构

![](https://raw.gitcode.com/Cangjie-TPC/markdown4cj/raw/markdown4cj_hybrid_cangjie-plugin-5.1.1/doc/assets/img.png)

### 源码目录

```shell
─markdown_hybrid
  └─src
      └─main
          ├─cangjie
          ├─cpp
          ├─ets
          └─resources
```

- `markdown` 工程模块 - 编译生成一个har包
- `markdown src` 模块代码目录
- `markdown src main` 模块项目目录
- `markdown src main cangjie` 仓颉代码目录
- `markdown src main cpp` cpp代码目录
- `markdown src main ets` ets代码目录
- `markdown src main resources` 资源文件目录

### 接口说明

主要类和函数接口说明详见 [API](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown4cj_hybrid_cangjie-plugin-5.1.1/doc/feature_api.md)

## 使用说明

### 编译构建

1. 下载安装
   1. 通过中心仓下载安装

      ```sh
      ohpm install @cangjie-tpc/markdown_hybrid
      ```

      在项目中使用markdown项目

      ```ets
      import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
      ```

   2. 本地编译安装 - 需要提前安装仓颉插件

      ```bash
      git clone https://gitcode.com/Cangjie-TPC/markdown4cj.git
      git checkout markdown4cj_hybrid_cangjie-plugin-5.1.1
      ```

      编译markdown
      build -> Make Module `markdown_hybrid`

      获取har包。har包路径
      markdown -> build -> outputs -> default -> markdown_hybrid.har

      在项目中使用markdown项目

      ```ets
      import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
      ```

### 使用仓颉组件功能示例

```ets
import { CJMarkdown } from '@cangjie-tpc/markdown_hybrid'

@Entry
@Component
struct DemoPage {
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  /**
   * md文本
   */
  @State message: string = '### 标题1\n' +
    '\n' +
    '# 1级标题\n' +
    '\n' +
    '### 标题2\n' +
    '\n' +
    '## 2级标题\n' +
    '\n' +
    '### 标题3\n' +
    '\n' +
    '### 3级标题\n' +
    '\n' +
    '### 标题4\n' +
    '\n' +
    '#### 4级标题\n' +
    '\n' +
    '### 标题5\n' +
    '\n' +
    '##### 5级标题\n' +
    '\n' +
    '### 标题6\n' +
    '\n' +
    '###### 6级标题\n' +
    '\n' +
    '### 标题7\n' +
    '\n' +
    '### 正常标题\n' +
    '\n' +
    '### 标题8\n' +
    '\n' +
    'Heading level 1\n' +
    '===============\n' +
    '\n' +
    '### 标题9\n' +
    '\n' +
    'Heading level 2\n' +
    '---------------\n' +
    '\n' +
    '### 标题10\n' +
    '\n' +
    'Heading level 1\n' +
    '=\n' +
    '\n' +
    '### 标题11\n' +
    '\n' +
    'Heading level 2\n' +
    '-\n';

  build() {
    Column() {
      Column() {
        CJMarkdown({
          content: this.message
        })
      }
    }
    .padding({ left: 10, right: 10, top: this.safeTop })
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
```

### 显示效果

![](https://raw.gitcode.com/Cangjie-TPC/markdown4cj/raw/markdown4cj_hybrid_cangjie-plugin-5.1.1/doc/assets/img1.png)

### 使用三方库内置的ArkTS组件功能示例

```ets
@State useCangjieComponent: boolean = false;  // 是否使用cangjie

build() {
   Column() {
      Column() {
         CJMarkdown({
            content: this.message,
            useCangjieComponent: this.useCangjieComponent
         })
      }
   }
   .padding({ left: 10, right: 10, top: this.safeTop })
   .width('100%')
   .alignItems(HorizontalAlign.Start)
}
```

### 使用用户自定义ArkTS组件功能示例

```ets
@State useCangjieComponent: boolean = false  // 是否使用cangjie

//用户自定义builder
@Builder
showTextBuilder() {
   Column(){
      Text(this.message).width('100%').height('100%').fontColor(Color.Red)
   }
}

build() {
   Column() {
      Column() {
         CJMarkdown({
            content: this.message,
            useCangjieComponent: this.useCangjieComponent,
            customContains: this.showTextBuilder.bind(this)
         })
      }
   }
   .padding({ left: 10, right: 10, top: this.safeTop })
   .width('100%')
   .alignItems(HorizontalAlign.Start)
}
```

## 约束与限制

在下述版本验证通过:

| 编号 | 依赖构建工具                           | 版本号       |
|----|----------------------------------|-----------|
| 1  | **DevEco Studio**                | 5.1.1.851 |
| 2  | **cjc**                          | v1.0.5    |

markdown依赖三方库：

| 编号 | 依赖三方库         | 版本号      |
|----|---------------|----------|
| 1  | stdx          | v1.0.1.1 |
| 2  | commonmark4cj | v1.1.1   |
| 3  | prism4cj      | v1.0.4   |
| 4  | formula       | v1.5.1   |
| 5  | codeformat    | v1.0.0   |

1、三方库静态链接和动态链接区别

- 静态链接：在编译期间，将所有依赖stdx的库函数和代码会被链接到最终的可执行文件中；生成的so中包含了所有需要的代码，不需要再依赖外部的stdx库。

  **缺点**： 由于静态链接将所有代码（包括库函数）都包含进最终的可执行文件，因此生成的可执行文件会比动态链接的文件要大。

- 动态链接：编译的har包中，会将所有使用到的stdx的二进制so添加到har的libs文件夹内；动态链接程序依赖于共享库（例如 .dll、.so），这些库在程序启动时或者运行时被加载到内存中。

  **缺点**：由于stdx版本之前存在不兼容，因此三方库和hap包依赖的stdx版本不一致情况下，存在运行crash情况。

当前三方库默认通过静态链接方式，如果有动态链接需求可以通过修改库代码中的cjpm.toml文件链接到stdx动态链接库目录，

```
[target]
  [target.aarch64-linux-ohos]
  	  ...
      path-option = [ "${AARCH64_LIBS}", "${AARCH64_MACRO_LIBS}", "${AARCH64_KIT_LIBS}", "../stdx_bin/linux_ohos_aarch64_llvm/static/stdx" ]
      [target.aarch64-linux-ohos.bin-dependencies.package-option]
  [target.x86_64-linux-ohos]
      ...
      path-option = [ "${X86_64_OHOS_LIBS}", "${X86_64_OHOS_MACRO_LIBS}", "${X86_64_OHOS_KIT_LIBS}", "../stdx_bin/linux_ohos_x86_64_llvm/static/stdx" ]
  [target.x86_64-unknown-windows-gnu]
    [target.x86_64-unknown-windows-gnu.bin-dependencies]
      path-option = [ "${X86_64_LIBS}", "${X86_64_MACRO_LIBS}", "../stdx_bin/windows_x86_64_llvm/static/stdx" ]
      [target.x86_64-unknown-windows-gnu.bin-dependencies.package-option]
```

修改如下：

```
[target]
  [target.aarch64-linux-ohos]
      ...
      path-option = [ "${AARCH64_LIBS}", "${AARCH64_MACRO_LIBS}", "${AARCH64_KIT_LIBS}", "../stdx_bin/linux_ohos_aarch64_llvm/dynamic/stdx" ]
      [target.aarch64-linux-ohos.bin-dependencies.package-option]
  [target.x86_64-linux-ohos]
      ...
      path-option = [ "${X86_64_OHOS_LIBS}", "${X86_64_OHOS_MACRO_LIBS}", "${X86_64_OHOS_KIT_LIBS}", "../stdx_bin/linux_ohos_x86_64_llvm/dynamic/stdx" ]
  [target.x86_64-unknown-windows-gnu]
    [target.x86_64-unknown-windows-gnu.bin-dependencies]
      path-option = [ "${X86_64_LIBS}", "${X86_64_MACRO_LIBS}", "../stdx_bin/windows_x86_64_llvm/dynamic/stdx" ]
      [target.x86_64-unknown-windows-gnu.bin-dependencies.package-option]
```

1. 内联代码/链接文字格式背景色。纯仓颉项目支持API19及以上版本。互操作项目支持API12及以上版本
2. 链接和删除线同时存在情况，只支持显示删除线的中划线，不显示链接的下划线
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
   1. 不支持嵌套标题
   2. 不支持嵌套块引用/有序列表/无序列表/任务列表
   3. 不支持嵌套缩进代码块/围栏代码块
5. 不支持稀疏排列/紧密排列
6. HTML支持的标签
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
      7. span标签 - 文本样式(key不支持中文)
         * font-size属性 - 文本大小
         * font-weight属性 - 文本粗细
         * color属性 - 文本颜色(只支持6位16进制颜色)
      8. u标签 - 下划线
      9. sup标签 - 上标
      10. sub标签 - 下标
   3. 行内块元素
      1. br标签 -  换行符
      2. img标签 - 图片
         * src属性 - 必选属性
         * title属性
         * width属性
         * height属性
   4. 注释
      1. `<!--  -->` - 注释标签
   5. DOCTYPE
7. 长按选中复制粘贴功能。纯仓颉项目支持API19及以上版本。互操作项目支持API12及以上版本
8. 图片显示功能。纯仓颉项目支持API15及以上版本。互操作项目支持API12及以上版本
9. 视频支持的格式 `mp4, mov, avi, mkv, wmv, flv, webm, m4v, 3gp`
10. 音频支持的格式 `mp3, wav, aac, flac, ogg, m4a, wma, amr`
11. `setLatexMathResStr` 接口默认字段是 `/data/storage/el1/bundle/entry/resources/resfile/res`。用户修改项目默认名称entry需要设置 `/data/storage/el1/bundle/xxx/resources/resfile/res` 数学公式才能正常显示
12. 增量解析会导致上下数据前后文失效(TOC/脚注/标题ID/引用链接)
13. 块引用中表格背景色跟随块引用背景色

## 开源协议

本项目基于 [Apache License 2.0](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown4cj_hybrid_cangjie-plugin-5.1.1/LICENSE) ，请自由的享受和参与开源。

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。
