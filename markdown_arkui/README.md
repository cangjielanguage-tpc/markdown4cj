<div align="center">
<h1>Markdown_arkui</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v1.4.0-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v1.1.3-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-NA-red" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## 介绍

Markdown是一种轻量级标记语言，排版语法简洁，让人们更多地关注内容本身而非排版。

Markdown_arkui是一个用arkts语言编写的适用于鸿蒙系统的Markdown库。

## 优势

- 使用高效便捷
- 扩展性强，用户可自定义Markdown显示样式
- 符合 Markdown 规范

### 特性

1. 支持增量加载渲染
2. 支持增量解析
3. 支持标题语法
4. 支持段落语法
5. 支持分割线语法
6. 支持内联代码语法
7. 支持缩进代码块语法
8. 支持围栏代码块语法
9. 支持加粗语法
10. 支持斜体语法
11. 支持转义字符语法
12. 支持删除线语法
13. 支持链接语法
14. 支持自动网址链接语法
15. 支持部分html语法
16. 支持软硬换行语法
17. 支持表格语法
18. 支持有序列表语法
19. 支持无序列表语法
20. 支持任务列表语法
21. 支持块引用语法
22. 支持Toc目录语法
23. 支持脚注语法
24. 支持图片语法
25. 支持图片Style语法
26. 支持图片幻灯片语法
27. 支持组合代码块语法
28. 支持视频语法
29. 支持音频语法
30. 支持定义列表语法
31. 支持标题ID语法
32. 支持上标语法
33. 支持下标语法
34. 支持emoji语法
35. 支持围栏代码块高亮功能
36. 支持列表嵌套功能
37. 支持文本样式设置
38. 支持表格样式设置
39. 支持超链接图片化设置
40. 支持单独代码块设置
41. 支持深浅主题色设置
42. 支持文本长按选中复制粘贴
43. 支持图文混排和图文不混排功能
44. 支持自定义正则实现自定义自动链接

## 软件架构

![](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown_arkui-6.1.1/doc/assets/img.png)

### 源码目录

```shell
─markdown_arkui
  └─src
      └─main
          ├─cpp
          ├─ets
          └─resources
```

- `markdown_arkui` 工程模块 - 编译生成一个har包
- `markdown_arkui src` 模块代码目录
- `markdown_arkui src main` 模块项目目录
- `markdown_arkui src main cpp` cpp代码目录
- `markdown_arkui src main ets` ets代码目录
- `markdown_arkui src main resources` 资源文件目录

### 接口说明

主要类和函数接口说明详见 [API](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown_arkui-6.1.1/doc/feature_api.md)

## 使用说明

### 编译构建

1. 下载安装

   1.本地编译安装 - 准备好DevEco Studio 6.1.1.280环境（Windows / Linux / macOS）

      ```bash
      git clone -b markdown_arkui-6.1.1 https://gitcode.com/Cangjie-TPC/markdown4cj.git 
      ```

   2.使用命令行脚本一键编译（自动完成全部流程）

   项目根目录下提供了 4 个构建脚本，覆盖 Windows（PowerShell）与 Linux/macOS（Bash）平台：

   | 脚本 | 平台 | 说明 |
         | --- | --- | --- |
   | `build_har_15.ps1` | Windows | 将子模块 `compatibleSdkVersion` 统一改为 `5.0.3(15)` 后打包（兼容 API 15） |
   | `build_har_20.ps1` | Windows | 保持子模块默认 `compatibleSdkVersion` 为 `6.0.0(20)` 打包（API 20） |
   | `build_har_15.sh` | Linux / macOS | 同 `build_har_15.ps1` |
   | `build_har_20.sh` | Linux / macOS | 同 `build_har_20.ps1` |

   脚本执行流程（按顺序）：

   1. 依据 `.gitmodules` 从零下载 4 个子模块源码（`prism4cj` / `codeformat4cj` / `markdown4cj` / `formula4cj`，浅克隆，按 `.gitmodules` 中声明的分支）
   2. （仅 15 版脚本）将各子模块下所有 `build-profile.json5` 的 `compatibleSdkVersion` 统一改为 `5.0.3(15)`
   3. 依次打包 4 个子模块的 HAR 并复制到 `markdown_arkui/har` 目录
   4. 编译根项目 `markdown_arkui` 模块，产物为 `markdown_arkui/build/default/outputs/default/markdown_arkui.har`

   Windows 用法：

      ```powershell
      powershell -ExecutionPolicy Bypass -File .\build_har_15.ps1
      ```

   Linux / macOS 用法：

      ```bash
      bash build_har_15.sh
      ```

   可选参数（两种平台一一对应）：

   | 参数（ps1 / sh） | 说明 |
         | --- | --- |
   | `-Only` / `--only` | 第 3 步只打包指定子模块，逗号分隔，如 `-Only prism4cj,formula4cj` |
   | `-Clean` / `--clean` | 打包前删除各模块的旧 build 目录 |
   | `-SkipDownload` / `--skip-download` | 子模块已就绪时跳过清理与下载，加速打包 |
   | `-BuildMode` / `--build-mode` | 构建模式：`debug` / `release`（默认 `release`） |
   | `-DevEcoTools` / `--deveco-tools` | 显式指定 DevEco Studio 的 tools 目录（含 node/ohpm/hvigor） |
   | `-CangjieSdkRoot` / `--cangjie-sdk-root` | 显式指定兼容性 SDK 的 compatibility 根目录 |

   工具链路径不写死：未显式指定时，脚本按 `环境变量 -> 项目根各级祖先目录` 的顺序自动探测 DevEco Studio tools 目录（`DEVECO_TOOLS_HOME` / 由 `DEVECO_SDK_HOME` 推导 / `DevEco Studio*` 安装目录）与兼容性 SDK（`DEVECO_CANGJIE_PATH` / `compatibility-sdk-*` 目录），多版本共存时优先匹配与项目名相同版本号的目录。

   示例（子模块已就绪时只重打 prism4cj）：

      ```powershell
      powershell -ExecutionPolicy Bypass -File .\build_har_15.ps1 -SkipDownload -Only prism4cj
      ```

      ```bash
      bash build_har_15.sh --skip-download --only prism4cj
      ```

   在项目中使用markdown项目

      ```arkts
      import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_arkui'
      ```

### 使用仓颉组件功能示例

```ets
import { CJMarkdown, MarkdownConfiguration} from '@cangjie-tpc/markdown_arkui'

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
          content: this.message,
          config:new MarkdownConfiguration()
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

![](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown_arkui-6.1.1/doc/assets/img1.png)



## 约束与限制

当前基于 DevEco Studio for Windows 6.1.1.280 版本实现的

1. 链接和删除线同时存在情况，只支持显示删除线的的中划线，不显示链接的下划线
2. 围栏代码块高亮语言支持如下(语言类型不区分大小写，每行如有多个则表示该语言支持别名书写)：
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
3. 表格限制：
   1. 不支持嵌套标题
   2. 不支持嵌套块引用/有序列表/无序列表/任务列表
   3. 不支持嵌套缩进代码块/围栏代码块
4. 不支持稀疏排列/紧密排列
5. HTML支持的标签
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
6. 视频支持的格式 `mp4, mov, avi, mkv, wmv, flv, webm, m4v, 3gp`
7. 音频支持的格式 `mp3, wav, aac, flac, ogg, m4a, wma, amr`

## 开源协议

本项目基于 [Apache License 2.0](https://gitcode.com/Cangjie-TPC/markdown4cj/blob/markdown_arkui-6.1.1/LICENSE) ，请自由的享受和参与开源。

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。
