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
import std.sync.sleep
import std.time.*
import ohos.hilog.Hilog

/**
 * markdown外层是list
 */
@Entry
@Component
class ListMarkdownPage1 {
    let mdStr0: String = ###"
内容1
## 以下是白日依山尽的图片:
"###
    let mdStr1: String = ###"
内容2
## 夕阳西下山水画的艺术表现与创作灵感

“夕阳西下”是中国传统山水画中极具诗意的主题之一，常与归舟、晚霞、湖光山色等元素结合，营造出宁静悠远、意境深远的画面氛围。这一主题不仅在古典绘画中广受青睐，也在当代数字艺术和创意设计中持续焕发活力。

### 1. **传统山水画中的“夕阳西下”意境**

在传统文人画中，“夕阳西下”往往象征着归隐、思乡与自然和谐之美。例如，“远浦归帆”作为“潇湘八景”之一，描绘了夕阳西下时江面归航的渔舟、岸边酒旗以及宁静的水村小镇，画面疏朗闲淡，富有动静相宜的美感。这类作品通过淡描勾画而非浓墨重彩，展现出自然朴实的艺术风格，令观者仿佛置身其中，感受江边恬静的世界[[2]]()。

此外，水墨山水画中也常见“夕阳西下，江山妖娆，羁鸟思归”的构图，通过绚丽的晚霞与倦鸟归巢的细节，强化了画面的情感张力与视觉冲击力，呈现出一幅壮丽而富有哲思的自然图景[[8]]()。

### 2. **现代艺术与数字创作中的再现**

随着数字技术的发展，“夕阳西下”的山水画主题也被广泛应用于AI数字艺术、插画设计与摄影合成中。例如：

- 视觉中国提供了多幅以“AI数字艺术”形式呈现的夕阳山水画，画面中橙红色的天空、云霞缭绕的山峰与碧绿湖水交相辉映，极具视觉冲击力，适用于广告设计、壁纸与创意配图[[1]]()。
- 天河公园湖心亭在夕阳下的实景被形容“仿佛置身于山水画中”，晚霞洒满天际，映照碧水，展现出自然景观与传统美学的高度契合[[7]]()。
- 手绘风格的插画素材也大量出现，如绿色手绘风格的小溪流水山水画，结合夕阳西下的光影效果，常用于海报背景、免抠元素等设计场景[[6]]()。

### 3. **绘画教学与创作实践**

对于艺术爱好者而言，“夕阳西下”的小景致也是常见的绘画练习题材。抖音平台上已有简易教程指导如何用橘红、橘黄、中黄、柠檬黄和白色进行渐变涂抹，表现天空与水面的光影变化，并添加小树、芦苇、小鸟等元素增强画面生动性[[5]]()。此类教学强调色彩过渡与倒影处理，帮助初学者掌握山水画的基本技法。

### 4. **摄影与视频中的“山水画意境”**

除了绘画，摄影与视频创作也致力于捕捉“山水画般”的夕阳景象。例如，有创作者在日出前进入颐和园，使用电影机拍摄西堤的夕阳西下场景，力求还原传统山水画的意境，被称为“不可复制的美景”[[4]]()。这类影像作品将自然光影与古典美学结合，拓展了“山水画”的表现边界。

---

## 总结

“夕阳西下山水画”不仅是一种视觉艺术形式，更承载着深厚的文化意蕴。从传统水墨到现代AI生成，从绘画教程到摄影创作，这一主题持续激发着创作者的灵感，展现出自然之美与人文情怀的交融。无论是欣赏还是创作，它都为人们提供了一种回归宁静、感悟自然的审美路径。

"###
    let mdStr2: String = ###"
内容3
## AI数字艺术在山水画领域的多维实践探索
近年来，AI技术与传统山水画的融合成为文化创新的重要方向，其应用不仅体现在艺术创作辅助与风格模拟，更延伸至展览呈现、学术研究及文化传播等多个层面，形成科技赋能传统艺术的全新范式。

### 展览中的科技与艺术深度融合实践
- **多维度艺术体验空间构建**
  2025年“笔迹溯源——空天视角下的关山月写生之路”展览开创性地将遥感卫星数据、数字AI技术与传统山水画结合，通过20件经典画作、17件遥感卫星图片、2件高程模型及5件数字艺术作品，构建了“山、水、海”三大主题板块，系统梳理艺术家写生历程与风格生成逻辑[ 1 ](https://news.qq.com/rain/a/20250605A094CV00)。
- **动态化数字装置创新**
  展览中的《丹岩流影·九曲霓裳》以关山月作品《漂游伴水声》为灵感，将武夷山山水转化为多媒体光影装置；《碧涛帆影千重幕》则通过动画模拟浪花飞溅、潮起潮落，动态呈现《云龙卧海疆》中的南海意境，实现传统笔墨的时空延伸[ 1 ](https://news.qq.com/rain/a/20250605A094CV00)。

### AI在山水画创作中的技术应用与挑战
- **风格模拟与元素生成**
  AI通过学习大量山水画数据（如30幅以上画家作品），可精准提取笔墨技法、构图特征，模拟沈周、黄公望等名家风格，生成兼具传统韵味与现代感的作品。例如“气韵再生”AI绘画模型已训练出100多位艺术大家的“AI化身”，用户可一键生成特定风格的山河湖海意象[ 2 ](https://max.book118.com/html/2024/1114/8142051115006143.shtm)[ 3 ](https://www.njdaily.cn/news/2025/0220/7437769620253722987.html)。
- **创作辅助与效率提升**
  AI能自动化处理素材整合、细节优化等基础任务，为画家提供山水元素（如山峰、水流、云雾）参考，并通过智能分析评估作品，提出改进建议，支持二次创作[ 2 ](https://max.book118.com/html/2024/1114/8142051115006143.shtm)。
- **技术局限性与人文思考**
  尽管AI可模拟笔墨技法，但难以完全复现画家的情感表达与哲学思考。其生成作品缺乏“气韵生动”的艺术生命力，且对历史文化语境的理解不足，易呈现“科技感有余而人文性不足”的局限[ 2 ](https://max.book118.com/html/2024/1114/8142051115006143.shtm)。

### 跨学科研究与文化传承新路径
- **空天视角下的学术创新**
  武汉大学与关山月美术馆合作，利用自研卫星数据与写生数据结合，通过高程模型与遥感影像还原写生场景，揭示山水画在地质真实性框架下的空间表达特征，为美术史研究提供地理信息维度的全新证据[ 1 ](https://news.qq.com/rain/a/20250605A094CV00)。
- **美育与公众传播拓展**
  AI技术通过“定制化创作”降低艺术门槛，如南京大学训练营中，学生可训练AI模型再现传统大师笔触；景区AIGC拍照机让游客生成后印象派风格画像，实现传统美学的年轻化传播[ 3 ](https://www.njdaily.cn/news/2025/0220/7437769620253722987.html)。

### 未来发展：平衡技术赋能与人文内核
AI数字艺术对山水画的革新需以“笔墨当随时代”为精神内核，在技术应用中保留传统艺术的哲学底蕴与情感深度。未来可通过构建更丰富的文化数据集、优化算法对“意境”的理解能力，推动科技与艺术从“形式融合”向“精神协同”演进，让传统山水画在数字时代焕发新生。
"###
//    let mdStr2: String = getFileContextStr("latex.md")
//    let mdStr3: String = getFileContextStr("table.md")
//    let mdStr5: String = getFileContextStr("title.md")

//    let arr = [mdStr0, mdStr1, mdStr2]
    
    var stringDataSource: StringDataSource = StringDataSource(ArrayList<String>())


    protected override func aboutToAppear(): Unit {
        stringDataSource.addDatas([mdStr0,"", mdStr1,"",mdStr1,"",mdStr1,"", mdStr2])
    }

    func build() {
        Column() {
//            titleComponent(
//                "列表嵌套markdown",
//                true
//            )
            List() {
                LazyForEach(
                    stringDataSource,
                    itemGeneratorFunc: {
                        str: String, index: Int64 => ListItem() {
                            Row(){
                               Image(@r(app.media.app_icon))
                                .height(40)
                                .width(40)
                                if(str==""){
                                  Image("https://markdown.com.cn/assets/img/shiprock.c3b9a023.jpg")
                                    .width(100.percent)
                                    .height(200)
                                }else{
//                                    Column(){
                                        MarkdownAIComponent(output: str, markdownAIConfiguration: setConfig())
//                                    }
                                }
                            }
                            .height(100.percent)
                            .alignItems(VerticalAlign.Top)
                        }
                    }
                )
            }
            .cachedCount(0)
            .layoutWeight(1)
            .scrollBar(BarState.Off)
            .edgeEffect(EdgeEffect.None)
        }
        .height(100.percent)
    }

    /**
     * 设置MarkdownAIConfiguration
     *
     * @return MarkdownAIConfiguration
     */
    func setConfig(): MarkdownAIConfiguration {
        let MarkdownAIConfigurationBuilder: MarkdownAIConfigurationBuilder = MarkdownAIConfiguration.emptyBuilder()
        // 设置markdown默认样式
        MarkdownAIConfigurationBuilder.setMarkdownAITheme(setMarkdownAITheme())
        // 设置链接的点击事件
        MarkdownAIConfigurationBuilder.setLinkCallback(linkCallback)
        // 设置图片的点击事件
        MarkdownAIConfigurationBuilder.setImageCallback(imageCallback)
        // 设置音频的点击事件
        MarkdownAIConfigurationBuilder.setAudioCallback(audioCallback)
        // 设置视频的点击事件
        MarkdownAIConfigurationBuilder.setVideoCallback(videoCallback)
        // 设置视频的图片替换回调
        MarkdownAIConfigurationBuilder.setVideoImageCallback(videoImageCallback)
        // 设置代码复制按钮的点击事件
        MarkdownAIConfigurationBuilder.setCodeCopyCallback(codeCopyCallback)
        // 设置代码全屏按钮的点击事件
        MarkdownAIConfigurationBuilder.setCodeFullScreenCallback(codeFullScreenCallback)
        // 设置数学公式图片点击事件
        MarkdownAIConfigurationBuilder.setLatexImageCallbackCallback(latexImageCallbackCallback)
        return MarkdownAIConfigurationBuilder.build()
    }

    /**
     * 设置MarkdownAITheme
     *
     * @return MarkdownAITheme
     */
    func setMarkdownAITheme(): MarkdownAITheme {
        let markdownAIThemeBuilder: MarkdownAIThemeBuilder = MarkdownAITheme.emptyBuilder()

        // 1、上下文
        markdownAIThemeBuilder.setAbilityContext(getGlobalAbilityContext()) // 设置上下文

        // 2、模块间距
        markdownAIThemeBuilder.setBlockTopAndBottomMargins(10.0) // 设置每个模块之间上下间距

        // 3、链接
        markdownAIThemeBuilder.setIsLinkStyle(true) // 设置链接是否是图片显示
        // 文本格式
        markdownAIThemeBuilder.setLinkColor(Color.RED) // 设置文本格式链接的文本颜色
        markdownAIThemeBuilder.setLinkSize(15.0) // 设置文本格式链接文字大小
        markdownAIThemeBuilder.setIsLinkUnderlined(false) // 设置是否显示文本格式链接下划线
        // 圆形图片
        markdownAIThemeBuilder.setLinkCircleImageRadius(16.0) // 设置圆形链接半径
        markdownAIThemeBuilder.setLinkCircleImageTextSize(10.0) // 设置圆形链接文字大小
        markdownAIThemeBuilder.setLinkCircleImageMargin(2.0) // 设置圆形链接左右边距
        markdownAIThemeBuilder.setLinkCircleImageBackGroupColor(Color.WHITE) // 设置圆形链接主题背景颜色
        markdownAIThemeBuilder.setLinkCircleImageButtonBackGroupColor(Color.BLACK) // 设置圆形链接控件背景颜色
        markdownAIThemeBuilder.setLinkCircleImageTextColor(Color.WHITE) // 设置圆形链接文字颜色
        // 圆角图片
        markdownAIThemeBuilder.setLinkRectImageRadius(16.0) // 设置圆角矩形链接圆角半径
        markdownAIThemeBuilder.setLinkRectImageMargin(2.0) // 设置圆角矩形链接左右边距
        markdownAIThemeBuilder.setLinkRectImageHeight(16.0) // 设置圆角矩形链接控件高度
        markdownAIThemeBuilder.setLinkRectImageTextSize(10.0) // 设置圆角矩形链接文字大小
        // 空心圆角图片
        markdownAIThemeBuilder.setLinkRectToolImageDividingLineWidth(1.0) // 设置空心圆角矩形链接分割线宽度
        markdownAIThemeBuilder.setLinkRectToolImageTextSize(11.0) // 设置空心圆角矩形链接文字大小
        markdownAIThemeBuilder.setLinkRectToolImageMargin(2.0) // 设置空心圆角矩形链接左右边距

        // 4、列表
        markdownAIThemeBuilder.setBlockOrderedAndBulletTopAndBottomMargins(0.0) // 设置列表子模块间距
        markdownAIThemeBuilder.setBlockQuoteTopAndBottomMargins(0.0) // // 设置块引用子模块间距
        // 块引用
        markdownAIThemeBuilder.setBlockQuoteColor(Color.RED) // 设置块引用左边线条颜色
        markdownAIThemeBuilder.setBlockQuoteBackGroupColor(Color.GRAY) // 设置块引用背景颜色
        // 有序列表
        markdownAIThemeBuilder.setOrderedListItemSize(15.0) // 设置有序列表项的字体大小
        markdownAIThemeBuilder.setOrderedListItemLineHeight(25.0) // 设置有序列表项文本行高
        // 无序列表
        markdownAIThemeBuilder.setBulletListItemColor(Color.GREEN) // 设置无序列表项的颜色
        markdownAIThemeBuilder.setBulletListItemLineHeight(22.0) // 设置无序列表项文本行高
        // 任务列表

        // 5、代码
        // 内联代码
        markdownAIThemeBuilder.setCodeTextColor(Color(0xFFFF5722)) // 设置内联代码文本颜色
        // 代码块
        markdownAIThemeBuilder.setCodeCopyIcon(@r(app.media.app_icon)) // 设置代码复制按钮默认图标
        markdownAIThemeBuilder.setCodeBlockRadius(0.0) //  设置代码块圆角
        // 组合代码
        // 单独代码块
        markdownAIThemeBuilder.setIsSeparateCodeBlock(false) // 设置是否单独代码块

        // 6、标题
        markdownAIThemeBuilder.setHeadingBreakHeight(0.0) // 设置H1、H2标题下分割线高度
        markdownAIThemeBuilder.setHeadingTextSizeMultipliers([15.0, 15.0, 15.0, 15.0, 15.0, 15.0]) // 设置标题文本大小数组
        markdownAIThemeBuilder.setHeadingTextColor(Color(0xFF222222)) // 设置标题字体颜色
        markdownAIThemeBuilder.setHeadingTextLineHeight1(25.0) // 设置一级标题文本行高
        markdownAIThemeBuilder.setHeadingTextLineHeight2(25.0) // 设置二级标题文本行高
        markdownAIThemeBuilder.setHeadingTextLineHeight3(25.0) // 设置三级标题文本行高
        markdownAIThemeBuilder.setHeadingTextLineHeight4(25.0) // 设置四级标题文本行高
        markdownAIThemeBuilder.setHeadingTextLineHeight5(25.0) // 设置五级标题文本行高
        markdownAIThemeBuilder.setHeadingTextLineHeight6(25.0) // 设置六级标题文本行高

        // 7、段落
        markdownAIThemeBuilder.setParagraphTextColor(Color(0xFF222222)) // 设置段落字体颜色
        markdownAIThemeBuilder.setParagraphTextSize(15.0) // 设置段落字体大小
        markdownAIThemeBuilder.setParagraphTextLineHeight(25.0) // 设置段落文本行高

        // 8、分割线
        markdownAIThemeBuilder.setThematicBreakColor(Color.BLUE) // 设置分割线颜色

        // 9、软换行
        markdownAIThemeBuilder.setIsLineBreak(true) // 设置软换行是否换行

        // 10、数学公式
        markdownAIThemeBuilder.setLatexMathBackGroupColor(Color(0xFFFBFBFB)) // 设置数学公式背景色
        markdownAIThemeBuilder.setLatexMathTextColor(Color.GREEN) // 设置数学公式字体颜色

        // 11、音频
        markdownAIThemeBuilder.setAudioIcon(@r(app.media.app_icon)) // 设置音频icon

        // 12、视频
        markdownAIThemeBuilder.setVideoImage(@r(app.media.place_holder)) // 设置视频默认占位图
        markdownAIThemeBuilder.setPlayCircleFillIcon(@r(app.media.play_circle_fill)) // 设置视频播放按钮默认图标

        // 13、图片Banner

        // 14、图片
//        markdownAIThemeBuilder.setImagePadding(20) //  设置图片宽度边距

        // 15、表格
        markdownAIThemeBuilder.setTableHeaderRowBackgroundColor(Color(0xFFF5F7FA)) // 设置表格头背景色
        markdownAIThemeBuilder.setTableOddRowBackgroundColor(Color(0xFFFAFAFA)) // 设置表格奇数行背景色
        markdownAIThemeBuilder.setTableEvenRowBackgroundColor(Color(0xFFFFFFFF)) // 设置表格偶数行背景色
        markdownAIThemeBuilder.setTableBorderWidth(2.0) // 设置表格边框宽度
        markdownAIThemeBuilder.setTableBorderColor(Color.RED) // 设置表格边框颜色

        // 16、代码高亮
        markdownAIThemeBuilder.setPrismTheme(PrismThemeDarkula.create()) // 设置markdown代码高亮样式

        return markdownAIThemeBuilder.build()
    }

    /**
     * 链接的点击事件
     *
     * @param url 链接url
     */
    func linkCallback(url: String): Unit {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------LinkCallback:${url}")
    }

    /**
     * 图片的点击事件
     *
     * @param url 图片url
     * @param arr 图片和视频的url集合
     */
    func imageCallback(url: String, arr: ArrayList<String>): Unit {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------LinkCallback:${url},arr:${arr}")
    }

    /**
     * 音频的点击事件
     *
     * @param url 音频url
     */
    func audioCallback(url: String): Unit {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------LinkCallback:${url}")
    }

    /**
     * 视频的点击事件
     *
     * @param url 视频url
     * @param arr 图片和视频的url集合
     */
    func videoCallback(url: String, arr: ArrayList<String>): Unit {
        PromptAction.showToast(message: url)
        Hilog.error(1, "1", "------------------------videoCallback:${url},arr:${arr}")
    }

    /**
     * 视频的图片替换回调
     *
     * @param url 视频url
     * @param videoImageCallbackCallback 视频首帧图回调
     */
    func videoImageCallback(url: String, videoImageCallbackCallback: (String, Float64, Int64) -> Unit) {
        Hilog.error(1, "1", "------------------------videoImageCallback:${url}")
    }

    /**
     * 代码复制按钮的点击事件
     *
     * @param code 代码内容
     */
    func codeCopyCallback(code: String): Unit {
        PromptAction.showToast(message: code)
        Hilog.error(1, "1", "------------------------codeCopyCallback:${code}")
    }

    /**
     * 代码全屏按钮的点击事件
     *
     * @param code 代码内容
     * @param infos 代码类型
     */
    func codeFullScreenCallback(code: String, infos: ?String): Unit {
        PromptAction.showToast(message: "${code}${infos}")
        Hilog.error(1, "1", "------------------------codeFullScreenCallback:${code}")
        Hilog.error(1, "1", "------------------------codeFullScreenCallback:${infos}")
    }

    /**
     * 数学公式图片点击事件
     *
     * @param data 数学公式图片数组内容
     * @param height 图片高度
     * @param width 图片宽度
     */
    func latexImageCallbackCallback(data: Array<UInt8>, height: Length, width: Length): Unit {
        Hilog.error(1, "1", "------------------------data:${data}")
        Hilog.error(1, "1", "------------------------height:${height.value}")
        Hilog.error(1, "1", "------------------------width:${width.value}")
    }
}
