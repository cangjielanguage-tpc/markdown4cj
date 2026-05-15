标题

# 一级标题

## 二级标题

### 三级标题

#### 四级标题

##### 五级标题

###### 六级标题

段落

一小段段落

很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落很长的一段段落

抱歉，我暂时无法回答你的问题，我学习的知识中没有相关的内容。

加粗

普通文本 **加粗的文本** 普通文本

普通文本 __加粗的文本__ 普通文本

斜体

普通文本 *斜体的文本* 普通文本

普通文本 _斜体的文本_ 普通文本

删除线

普通文本 ~~删除线的文本~~ 普通文本

内联代码

普通文本 `内联代码文本` 普通文本

链接

普通文本 [Markdown语法](https://markdown.com.cn)。 普通文本

https://markdown.com.cn

没有代码类型的代码块

```
> hvigor Finished :markdown:default@BuildNativeWithNinja... after 1 s 438 ms 
> hvigor Finished :markdown:default@BeforeProcessLibs... after 5 ms 
> hvigor Finished :markdown:default@ProcessLibs... after 106 ms 
> hvigor Finished :entry:default@CompileArkTS... after 5 s 567 ms 
```

仓颉代码类型的代码块

```cangjie
/**
 * 扩展Option，getOrThrow()方法直接用()
 */
extend<T> Option<T> {
    operator func ()(): T {
        this.getOrThrow()
    }
}
```

java代码类型的代码块

```java
public class Fibonacci {
    public static void main(String[] args) {
        int n = 10; // 计算前10个斐波那契数
        System.out.println("前 " + n + " 个斐波那契数是：");
        
        for (int i = 0; i < n; i++) {
            System.out.print(fibonacci(i) + " ");
        }
    }
    
    // 递归方法计算斐波那契数
    public static int fibonacci(int num) {
        if (num <= 1) {
            return num;
        }
        return fibonacci(num - 1) + fibonacci(num - 2);
    }
}
```

缩进代码块

    setPlugin(): MarkdownPlugin {
        let a = new MarkdownPlugin()
        a.setIsTablePlugin(true)
        a.setIsLatexMathPlugin(true)
        return a
    }

无序列表

* 无序列表1
* 无序列表2
* 无序列表3
* 无序列表4
* 无序列表5
* 无序列表6
* 无序列表7
* 无序列表8无序列表8无序列表8无序列表8无序列表8无序列表8无序列表8无序列表8无序列表8

有序列表

1. 有序列表1
2. 有序列表2
3. 有序列表3
4. 有序列表4
5. 有序列表5
6. 有序列表6
7. 有序列表7
8. 有序列表8有序列表8有序列表8有序列表8有序列表8有序列表8有序列表8有序列表8有序列表8

块引用

> 块引用1
> 
> 块引用2
> 
> 块引用3
>
> 块引用4
>
> 块引用5

任务列表

- [x] 任务列表1
- [ ] 任务列表2
- [x] 任务列表3
- [ ] 任务列表4
- [x] 任务列表5
- [ ] 任务列表6

分割线

***

软换行

软换行第一行
软换行第二行

硬换行

硬换行第一行  
硬换行第二行

表格

| 题号 | 标题 | 难易度 |
| :--- | ---:| :---: |
| 1 | $aaaaaaaaaaaaaaaaaaaaa + bbbbbbbbbbbbbbbbbbbbbbb = c$ | 简单 |
| 15 | 三数之和 | [链接链接链接链接链接链接链接链接链接链接链接链接链接链接链接链接链接11](https://baidu.com) |
| 262 | 行程和用户 | 困难 |

数学公式

行内数学公式$a+b=c$行内数学公式

行内数学公式\[a+b=c\]行内数学公式

$$
\text{组1: } \{1\}, \quad \text{组2: } \{12\}
$$

\[
\text{组1: } \{1\}, \quad \text{组2: } \{12\}
\]

定义列表

term
: definition

术语
: 定义

脚注

Markdown 是一种轻量级标记语言[^1]，由约翰·格鲁伯（John Gruber）于 2004 年创建。

它的设计目标是让文本易读易写，同时支持转换为 HTML 等格式[^2]。

[^1]: 轻量级标记语言是一类用简单标记代替复杂 HTML 标签的语言。
[^2]: 常见的转换工具包括 Pandoc、Markdown-it 等。

标题ID

[第一章 概述](#chapter-1)

[1.1 研究背景](#section-1-1)

# 第一章 概述 {#chapter-1}

## 1.1 研究背景 {#section-1-1}

图片

![](https://qcdn2.zhaomi.cn/d/ptyGRnnvhwP_vlyRrwOPHhp_mark.png)

音频

![](https://qncdn.n.cn/so/upfile/8bb2e56621119eff26b21cdf90ad849f.mp3)

视频

![](https://psd.n.cn/aiso-vod/prod/image_video/202506/GwvyRjShNMe.mp4)
