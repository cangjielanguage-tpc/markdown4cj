/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown';
import hilog from '@ohos.hilog';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  /**
   * md文本
   */
  @State message: string = '标题\n' +
    '\n' +
    '# 一级标题\n' +
    '\n' +
    '## 二级标题\n' +
    '\n' +
    '### 三级标题\n' +
    '\n' +
    '#### 四级标题\n' +
    '\n' +
    '##### 五级标题\n' +
    '\n' +
    '###### 六级标题\n' +
    '\n' +
    '段落\n' +
    '\n' +
    '一小段段落\n' +
    '\n' +
    '很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落\n' +
    '\n' +
    '抱歉，我暂时无法回答你的问题，我学习的知识中没有相关的内容。\n' +
    '\n' +
    '加粗\n' +
    '\n' +
    '普通文本 **加粗的文本** 普通文本\n' +
    '\n' +
    '普通文本 __加粗的文本__ 普通文本\n' +
    '\n' +
    '斜体\n' +
    '\n' +
    '普通文本 *斜体的文本* 普通文本\n' +
    '\n' +
    '普通文本 _斜体的文本_ 普通文本\n' +
    '\n' +
    '删除线\n' +
    '\n' +
    '普通文本 ~~删除线的文本~~ 普通文本\n' +
    '\n' +
    '内联代码\n' +
    '\n' +
    '普通文本 `内联代码文本` 普通文本\n' +
    '\n' +
    '链接\n' +
    '\n' +
    '普通文本 [Markdown语法](https://markdown.com.cn)。 普通文本\n' +
    '\n' +
    'https://markdown.com.cn\n' +
    '\n' +
    '没有代码类型的代码块\n' +
    '\n' +
    '```\n' +
    '> hvigor Finished :markdown:default@BuildNativeWithNinja... after 1 s 438 ms \n' +
    '> hvigor Finished :markdown:default@BeforeProcessLibs... after 5 ms \n' +
    '> hvigor Finished :markdown:default@ProcessLibs... after 106 ms \n' +
    '> hvigor Finished :entry:default@CompileArkTS... after 5 s 567 ms \n' +
    '```\n' +
    '\n' +
    '仓颉代码类型的代码块\n' +
    '\n' +
    '```cangjie\n' +
    '/**\n' +
    ' * 扩展Option，getOrThrow()方法直接用()\n' +
    ' */\n' +
    'extend<T> Option<T> {\n' +
    '    operator func ()(): T {\n' +
    '        this.getOrThrow()\n' +
    '    }\n' +
    '}\n' +
    '```\n' +
    '\n' +
    'java代码类型的代码块\n' +
    '\n' +
    '```java\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    'public class Fibonacci {\n' +
    '    public static void main(String[] args) {\n' +
    '        int n = 10; // 计算前10个斐波那契数\n' +
    '        System.out.println("前 " + n + " 个斐波那契数是：");\n' +
    '        \n' +
    '        for (int i = 0; i < n; i++) {\n' +
    '            System.out.print(fibonacci(i) + " ");\n' +
    '        }\n' +
    '    }\n' +
    '    \n' +
    '    // 递归方法计算斐波那契数\n' +
    '    public static int fibonacci(int num) {\n' +
    '        if (num <= 1) {\n' +
    '            return num;\n' +
    '        }\n' +
    '        return fibonacci(num - 1) + fibonacci(num - 2);\n' +
    '    }\n' +
    '}\n' +
    '```\n' +
    '\n' +
    '缩进代码块\n' +
    '\n' +
    '    setPlugin(): MarkdownPlugin {\n' +
    '        let a = new MarkdownPlugin()\n' +
    '        a.setIsTablePlugin(true)\n' +
    '        a.setIsLatexMathPlugin(true)\n' +
    '        return a\n' +
    '    }\n' +
    '\n' +
    '无序列表\n' +
    '\n' +
    '* 无序列表1\n' +
    '* 无序列表2\n' +
    '* 无序列表3\n' +
    '* 无序列表4\n' +
    '* 无序列表5\n' +
    '* 无序列表6\n' +
    '* 无序列表7\n' +
    '* 无序列表8无序列表8无序列表8无序列表8无序列表8无序列表8无序列表8无序列表8无序列表8\n' +
    '\n' +
    '有序列表\n' +
    '\n' +
    '1. 有序列表1\n' +
    '2. 有序列表2\n' +
    '3. 有序列表3\n' +
    '4. 有序列表4\n' +
    '5. 有序列表5\n' +
    '6. 有序列表6\n' +
    '7. 有序列表7\n' +
    '8. 有序列表8有序列表8有序列表8有序列表8有序列表8有序列表8有序列表8有序列表8有序列表8\n' +
    '\n' +
    '块引用\n' +
    '\n' +
    '> 块引用1\n' +
    '> \n' +
    '> 块引用2\n' +
    '> \n' +
    '> 块引用3\n' +
    '>\n' +
    '> 块引用4\n' +
    '>\n' +
    '> 块引用5\n' +
    '\n' +
    '任务列表\n' +
    '\n' +
    '- [x] 任务列表1\n' +
    '- [ ] 任务列表2\n' +
    '- [x] 任务列表3\n' +
    '- [ ] 任务列表4\n' +
    '- [x] 任务列表5\n' +
    '- [ ] 任务列表6\n' +
    '\n' +
    '分割线\n' +
    '\n' +
    '***\n' +
    '\n' +
    '软换行\n' +
    '\n' +
    '软换行第一行\n' +
    '软换行第二行\n' +
    '\n' +
    '硬换行\n' +
    '\n' +
    '硬换行第一行  \n' +
    '硬换行第二行\n' +
    '\n' +
    '表格\n' +
    '\n' +
    '| 题号 | 标题 | 难易度 |\n' +
    '| :--- | ---:| :---: |\n' +
    '| 1 | $aaaaaaaaaaaaaaaaaaaaa + bbbbbbbbbbbbbbbbbbbbbbb = c$ | 简单 |\n' +
    '| 15 | 三数之和 | [链接链接链接链接链接链接链接链接链接链接链接链接链接链接链接链接链接11](https://baidu.com) |\n' +
    '| 262 | 行程和用户 | 困难 |\n' +
    '\n' +
    '数学公式\n' +
    '\n' +
    '$a+b=c$\n' +
    '\n' +
    '图片\n' +
    '\n' +
    '![](https://qcdn2.zhaomi.cn/d/ptyGRnnvhwP_vlyRrwOPHhp_mark.png)\n' +
    '\n' +
    '音频\n' +
    '\n' +
    '![](https://qncdn.n.cn/so/upfile/8bb2e56621119eff26b21cdf90ad849f.mp3)\n' +
    '\n' +
    '视频\n' +
    '\n' +
    '![](https://psd.n.cn/aiso-vod/prod/image_video/202506/GwvyRjShNMe.mp4)\n' +
    '\n';

  build() {
    Column() {
      Column() {
        CJMarkdown({
          mdStr: this.message,
          isFull: true,
          cfg: this.setCJMarkdownConfig(),
          plugin: this.setPlugin()
        })
      }
    }
    .padding({ left: 10, right: 10, top: this.safeTop })
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  setCJMarkdownConfig(): MarkdownConfiguration {
    let a = new MarkdownConfiguration()

    a.setCodeCopyCallback(this.setCodeCopyCallback)
    a.setLinkCallback(this.setLinkCallback)

    let b = new MarkdownTheme()

    b.setCodeTextColor(0xFFFF0000)
    b.setCodeCopyIcon($r('app.media.app_icon'))

    b.setHeadingTextColor(0xFF0000FF)
    b.setHeadingBreakColor(0xFF0000FF)
    b.setHeadingBreakHeight(3.0)

    b.setLatexMathTextColor(0xFF0000FF)

    b.setBlockQuoteBackGroupColor(0xFFEAEAEA)

    b.setTaskListItemLength(22)

    b.setAudioIcon($r('app.media.app_icon'))

    b.setVideoImage($r('app.media.place_holder'))
    b.setPlayCircleFillIcon($r('app.media.play_circle_fill'))

    a.setMarkdownTheme(b)

    return a
  }

  setPlugin(): MarkdownPlugin {
    let a = new MarkdownPlugin()
    a.setIsTablePlugin(true) // 表格插件
    a.setIsLatexMathPlugin(true) // 数学公式插件
    a.setIsStrikethroughPlugin(true) // 删除线插件
    a.setIsTaskListPlugin(true) // 任务列表插件
    a.setIsLinkifyPlugin(true) // 自动链接插件
    a.setIsBlockAudioPlugin(true) // 音频插件
    a.setIsBlockVideoPlugin(true) // 视频插件

    return a
  }

  setCodeCopyCallback(str: string): void {
    hilog.error(1, "1", `---------------setCodeCopyCallback.str:${str}`)
    promptAction.showToast({
      message: str
    })
  }

  setLinkCallback(str: string): void {
    hilog.error(1, "1", `---------------setLinkCallback.str:${str}`)
    promptAction.showToast({
      message: str
    })
  }
}