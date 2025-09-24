/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.concurrency.*
import markdown.components.*
import std.sync.*
import std.time.*
import ohos.hilog.*

/**
 *
 */
@Entry
@Component
class TestError1Page {
    var mdStr: String = ###"$$\begin{align*}
\tan \theta &= \frac{1}{2 - \sqrt{3}} \cdot \frac{2 + \sqrt{3}}{2 + \sqrt{3}} \
&= \frac{2 + \sqrt{3}}{(2 - \sqrt{3})(2 + \sqrt{3})} \
\end{align*}$$"###

    /**
     * markdown文本
     */
    var mdStr0: String = ###"
**[程序员翻身](#jump_8)**

> 以上信息均整理[1111](https://ssssss.com)
> 以上信息均整理[1111](https://ssssss.com)
> 以上信息均整理[1111](https://ssssss.com)
> 以上信息均整理[1111](https://ssssss.com)
"###
    var mdStr1: String = ###"
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
"###
    var mdStr2: String = ###"
场景（Where、When）： 使用空白行将一行或多行文本进行分隔

是否商用：是

目标：用空白行对一行或多行文本进行分割

验收标准：能正确解析空白行对段落进行分割展示

依赖的需求：commonmark

资料：涉及

操作系统类型：OHOS

约束：N/A

### 段落2

Markdown是一种轻量级标记语言，排版语法简洁，让人们更多地关注内容本身而非排版。

本库是一个用仓颉 + 仓颉UI编写的适用于鸿蒙系统的 Markdown 库。
"###
    var mdStr3: String = ###"
### 分割线1

内容1

***

内容2

### 分割线2

内容3

---

内容4

### 分割线3

内容5
___

内容6

### 分割线4

内容7

_________________

内容8

### 分割线5

内容9

*****************

内容10

### 分割线6

内容9

------------------

内容10

"###
    var mdStr4: String = ###"
# 最美数学公式 Top 100

| 题号 | 标题 | 难易度 |
| :--- | ---:| :---: |
| 1 | $aaaaaaaaaaaaaaaaaaaaa + bbbbbbbbbbbbbbbbbbbbbbb = c$ | 简单 |
| 15 | 三数之和 | [链接链接链接链接链接链接链接链接链接链接链接链接链接链接链接链接链接11](https://baidu.com) |
| 262 | 行程和用户 | 困难 |

# 最美数学公式 Top 100

| 序号 | 公式名称              | 数学公式                          | 描述                                                                 |
|------|-----------------------|-----------------------------------|----------------------------------------------------------------------|
| 101  | 同伦群长正合列            | $\cdots \to \pi_n(F) \to \pi_n(E) \to \pi_n(B) \to \pi_{n-1}(F) \to \cdots$ | 纤维丛拓扑结构的代数刻画                                             |

---
"###
    var mdStr5: String = ###"
# 数学公式$a+b=c$

数学公式$a+b=c$

数学公式$a+b=c$ 数学公式 数学公式$a+b=c$ 数学公式 数学公式$a+b=c$ 数学公式 数学公式$a+b=c$ 数学公式 数学公式$a+b=c$ 数学公式

# 数学公式\(a+b=c\)

数学公式\[a+b=c\]

数学公式\[a+b=c\] 数学公式 数学公式\[a+b=c\] 数学公式 数学公式\[a+b=c\] 数学公式 数学公式\[a+b=c\] 数学公式 数学公式\[a+b=c\] 数学公式

\[ \text{ComplexIndicator} = \text{FunctionA} \times (\text{Parameter1}) + \text{FunctionB} \times (\text{Parameter2}) - \text{FunctionC} \times (\text{Parameter3}) \]

\[
\text{组1: } \{1\}, \quad \text{组2: } \{12\}
\]
"###
    var mdStr6: String = ###"
接下来将执行任务4：生成配音。![](https://qncdn.n.cn/so/upfile/8bb2e56621119eff26b21cdf90ad849f.mp3)![](https://qncdn.n.cn/so/upfile/f67caaa61ea42aa85cbb7cb2322a615f.mp3)![](https://qncdn.n.cn/so/upfile/7206945e43d54e0774da90d94c97966a.mp3)![](https://qncdn.n.cn/so/upfile/373c218585fde186dbeb422d73003afa.mp3)![](https://qncdn.n.cn/so/upfile/3a11fd6cffad1eb5e1e65f3814bf3c77.mp3)![](https://qncdn.n.cn/so/upfile/6ba0e1f72a4795ee1c48721c04d5d9db.mp3)![](https://qncdn.n.cn/so/upfile/2a6431052eefa2fa84969283b5047b9d.mp3)![](https://qncdn.n.cn/so/upfile/fcb5dbcbfd0e154b475646c88c77e161.mp3)![](https://qncdn.n.cn/so/upfile/94807bd77003d01b087ea2cead4acb98.mp3)

## 4. 故事配音![](https://qncdn.n.cn/so/upfile/0cee9f7a345d7a9092d8dfe4c43f383c.mp3)![](https://qncdn.n.cn/so/upfile/0f3f3af2b317999634ca0b7eca36f47b.mp3)![](https://qncdn.n.cn/so/upfile/19056f62348100c5d958aa6c371242f1.mp3)![](https://qncdn.n.cn/so/upfile/a2a378d4985de56b8fed8ff3b74fb5ae.mp3)![](https://qncdn.n.cn/so/upfile/2043232c54314a730de7de0e10a0ebbf.mp3)![](https://qncdn.n.cn/so/upfile/3e070a8c7277dec150c8aec4478d7ee7.mp3)![](https://qncdn.n.cn/so/upfile/b800be6d685ecd9c8a81b53587411bc9.mp3)![](https://qncdn.n.cn/so/upfile/6eec4f79e243bc9910118da32d399257.mp3)![](https://qncdn.n.cn/so/upfile/115f343270a562f634e24de1e7c6eb08.mp3)![](https://qncdn.n.cn/so/upfile/6aaeb0a3578cd1e18ad4c7d7796ed28a.mp3)![](https://qncdn.n.cn/so/upfile/ba580e43fd30a3b05f58eed397e2bcbc.mp3)
"###
    var mdStr7: String = ###"
接下来将执行任务5：图生视频。![](https://psd.n.cn/aiso-vod/prod/image_video/202506/GwvyRjShNMe.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202506/Fyk6wvwviSJ.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202506/wDySOHkCdwv.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202506/RwDyxmsErPv.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202506/kyv3yHv9GDw.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202506/wzvTPDVoxyv.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202506/gCy4X3whrv6.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202506/5f3mNZv0wyI.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202506/3wvnwdO0jZy.mp4)

## 5. 图生视频![](https://psd.n.cn/aiso-vod/prod/image_video/202507/PhEwvO5BBLe.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202507/Bzr9bPw5PRB.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202507/BXYj6l7Blzw.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202507/IBnXwl6jBWB.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202507/0RlnBV1UBwH.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202507/S1lbxtBjBgw.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202507/CswLuBSwBLl.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202507/BrZucTXwBYU.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202507/BuwUenMB9a9.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202507/UDmiBJwAzBu.mp4)![](https://psd.n.cn/aiso-vod/prod/image_video/202507/BwOmabPBPXu.mp4)
"###
    var mdStr8: String = ###"
### 任务1：扩写故事

**故事标题**：三只小猪的智慧房子

**儿童故事内容**：
从前，有三只小猪，他们决定各自建造自己的房子。大猪选择用稻草建房，因为它又快又轻松。二猪挑选木头，认为它坚固耐用。小猪则费力地用砖头盖房，觉得最安全。

一天，大灰狼来了，对着稻草房吹气，“呼——”，房子倒了，大猪慌忙躲进木头房。大灰狼又用力一吹，“咔嚓——”，木头房也塌了。两只小猪赶紧逃到砖头房里。

大灰狼来到砖头房前，深吸一口气猛吹，“呼——”，但砖头房纹丝不动。他不甘心，试图撞门，可怎么也撞不开。最后，累得筋疲力尽的大灰狼灰溜溜地走了。从此，三只小猪安心住在结实的砖头房子里。
"###
    var mdStr9: String = ###"
我将为您制作《石壕吏》的儿童动画故事。我会按照任务步骤一步步完成这个项目。

## 1. 扩写故事

# 勇敢的小石头

从前，在一个叫石壕村的小村庄里，住着一家人：善良的老爷爷、慈祥的老奶奶和他们的小孙子石头。石头是个聪明勇敢的孩子，他最喜欢听爷爷讲古代英雄的故事。

那是一个动荡的年代，战争使得许多村庄都陷入了困境。一天晚上，当星星刚刚爬上天空，一阵急促的敲门声打破了宁静。"开门！征兵令！"门外传来粗暴的声音。

石头躲在角落里，看见几个穿着官服的差吏闯进家门。他们大声宣布要带走爷爷去服役。奶奶哭着求情："老头子都这把年纪了，哪能上战场啊？"

爷爷悄悄对石头使了个眼色，趁差吏不注意时，翻过后院的矮墙逃走了。差吏们发现后勃然大怒，竟然要带走奶奶去做军营的杂役。

石头鼓起勇气站了出来："你们不能带走我奶奶！这是不对的！"差吏们只是冷笑。

就在这时，村里的其他人家听到动静，纷纷赶来。他们团结起来，对差吏说："我们村可以出粮食支援军队，但不能让老人去服役！"

面对村民们的团结，差吏们最终只好作罢，悻悻离去。爷爷也安全回到了家中。

从那以后，石头和村民们一起想办法，种更多的粮食，织更多的布，支援前线，同时保护村里的老人和孩子。石头也明白了，团结和勇气可以战胜困难，而和平才是最珍贵的。

每当夜幕降临，石壕村的人们就会聚在一起，讲述着他们共同经历的故事，期盼着和平早日到来。
"###
    var mdStr10: String = ###"
我将为您创建一个以丝绸之路为主题的教育动画故事。让我按照任务步骤依次完成。

## 1. 扩写故事

# 驼铃声声丝路情

很久以前，在中国古代的长安城，生活着一个名叫小安的男孩。小安的父亲是一位著名的商人，常年在丝绸之路上往返贸易。小安从小就对父亲口中描述的西域风光和奇特商品充满了好奇。

在小安十二岁那年的春天，父亲决定带他一同前往西域。"儿子，是时候让你亲眼见识丝绸之路的壮观了。"父亲微笑着说。小安激动得一晚上都没睡好，他终于可以踏上这条传说中的商路了！

出发那天，小安看到一支庞大的商队在城门外集结。骆驼背上驮着丝绸、茶叶和精美的瓷器，驼铃声声回荡在空气中。父亲告诉小安："这条路连接着东西方文明，不仅运送商品，也传递着友谊和知识。"

商队穿越了荒凉的戈壁滩，小安第一次体验到了沙漠的酷热和寒冷。在一个绿洲小镇上，他们遇到了来自波斯的商人阿里。阿里向他们展示了精美的地毯和香料，这些都是小安从未见过的宝贝。

继续西行，他们来到了敦煌。小安被莫高窟中绚丽的壁画深深吸引，那里记录着佛教如何通过丝绸之路传入中国的故事。一位老僧人告诉小安："丝绸之路不仅运送物品，更传播着信仰和艺术。"
"###
    var mdStr11: String = ###"
哈哈哈哈<!--标准本长度-->
史铁生是中国当代著名作家，他的作品以深邃的思想、细腻的情感和独特的文学风格著称。
"###
    var mdStr12: String = ###"
# 人脸识别民事公益诉讼案与个人敏感信息保护研究
## 案件背景与法律意义

# 全国首例人脸识别民事公益诉讼案的判决要点及法律意义

2023年底，我国审理了全国首例涉"人脸识别"民事公益诉讼案，该案不仅在刑事处罚的基础上，还通过检察机关提起民事公益诉讼，为个人信息保护领域树立了重要司法先例。

## 判决要点分析

1. **双重责任追究机制**：该案将刑事责任与民事责任相结合，被告除受到刑事处罚外，还被追究民事公益责任，体现了对个人信息侵权行为的全方位惩处[[11](https://new.qq.com/rain/a/20231215A07S7Y00)]。

2. **多元化赔偿方式**：判决要求四名被告支付公益损害赔偿金共计10万余元，同时创新性地引入"行为补偿"机制，允许通过个人信息保护相关的警示教育、公益宣传、志愿服务等方式进行补偿，并可视修复效果对赔偿金进行折抵[[11](https://new.qq.com/rain/a/20231215A07S7Y00)]。

3. **行为禁止令**：判决要求被告注销用于侵权的互联网账号、解散或退出用于传授犯罪方法的通讯群组，并公开赔礼道歉，从源头上切断侵权行为[[11](https://new.qq.com/rain/a/20231215A07S7Y00)]。

4. **保护公共利益**：法院认定被告对不特定社会公众的人脸信息进行非法收集、买卖、使用的行为，侵害了不特定群体的信息自决权及人格权益，构成对公共利益的侵害[[11](https://new.qq.com/rain/a/20231215A07S7Y00)]。

![image](https://qncdn.n.cn/so/upfile/7577958ea6decc4491d2a14ef253b67d.jpg)
"###
    var mdStr13: String = ###"
# 任务规划与流程

我将根据您的请求，创建一个关于西汉王朝二百一十年历史的视频内容。以下是我的任务规划：

1. 首先，我将搜索西汉王朝的历史信息，整理成文字内容
2. 然后，将整理好的内容编写成适合视频配音的文案，并生成视频标题
3. 接着，将视频文案拆分成分镜脚本，包括视频台词和生图提示词
4. 根据生图提示词生成相应的图片
5. 为视频台词生成配音
6. 将图片转化为视频
7. 为视频添加配音和字幕
8. 将多段视频拼接成一个完整视频
9. 获取适合的背景音乐
10. 最终为视频添加背景音乐

现在，我将开始执行这些任务。
"###

    /**
     * 文件名
     */
    var list: Array<String> = [mdStr0, mdStr1, mdStr2, mdStr3, mdStr4, mdStr5, mdStr6, mdStr7, mdStr8, mdStr9, mdStr10,
        mdStr11, mdStr12, mdStr13]

    /**
     * 流式markdown文本
     */
    @State
    var output: String = ""

    /**
     * 一次加载文本个数
     */
    @State
    var number: Int64 = 0

    /**
     * 延时时间
     */
    @State
    var sleepTime: Int64 = 50

    /**
     * 滑动控制器
     */
    var scroller: Scroller = Scroller()

    func build() {
        Column() {
            titleComponent(
                "11、连续输入数学公式闪退",
                true
            )
            Button("点击加载markdown")
                // 高度
                .height(40)
                // 宽度
                .width(100.percent)
                // 圆角
                .shape(ShapeType.Capsule)
                // 文本颜色
                .fontColor(0xFFFFFF)
                // 背景颜色
                .backgroundColor(0xFF0000)
                // 外边距
                .margin(top: 5, bottom: 5, right: 40, left: 40)
                // 内容对齐方式
                .align(Alignment.Center)
                // 字体大小
                .fontSize(16)
                // 点击动作触发该方法调用
                .onClick {
                    =>
                    if(list.size - 1 == number){
                        number = 0
                        output = list[number]
                    } else {
                        number ++
                        output = list[number]
                    }
                }
            Scroll(scroller) {
                Column {
                    MarkdownComponent(
                        output: output
                    )
                }
            }
            // 左右外边距
            .margin(right: 10, left: 10)
            // 内边距
            .padding(bottom: 150)
            // 设置滚动方法
            .scrollable(ScrollDirection.Vertical)
        }
    }
}