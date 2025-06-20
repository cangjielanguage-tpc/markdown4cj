/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
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
 * 全量数据全量加载
 */
@Entry
@Component
class AllCompletePage {
    let mdStr: String = ###"
> 以上信息均整理[1111](https://ssssss.com)
> 以上信息均整理[1111](https://ssssss.com)
> 以上信息均整理[1111](https://ssssss.com)
> 以上信息均整理[1111](https://ssssss.com)

1949年5月3日，杭州解放。新中国成立后，杭州迎来了新的发展机遇。改革开放以来，杭州的经济发展迅速，成为中国东部地区的重要经济中心。如今，杭州已经成为一座现代化的大都市，拥有众多高新技术产业和创新企业，在电子商务、数字经济、互联网等领域处于全国领先地位。同时，杭州作为浙江省省会和经济、文化、科教中心，长江三角洲中心城市，重要的风景旅游城市，在经济结构调整、科技创新、对外开放等方面不断取得新的成就[ 1 ](https://www.hangzhou.gov.cn/col/col805739/index.html)[ 2 ](https://www.sohu.com/a/727361103_121769699)。

测试

以下是结合中国法定节假日规律推测的**2025年放假安排**（注：实际安排需以国务院最终通知为准）：

| 节假日      | 放假时间               | 调休安排                      | 天数 |
|-------------|------------------------|-----------------------------|------
| **元旦**    | 2025年1月1日-1月3日    | 无调休（1月1日为法定假日，连带周末） | 3天  |
| **春节**    | 1月28日（除夕）-2月3日 | 2月1日（周六）、2月15日（周日）补班 | 7天  |
| **清明节**  | 4月4日-4月6日          | 无调休（4月4日法定假日，连周末）   | 3天  |
| **劳动节**  | 5月1日-5月5日          | 4月27日（周日）、5月10日（周六）补班 | 5天  |
| **端午节**  | 5月31日-6月2日         | 无调休（5月31日法定假日，连周末）   | 3天  |
| **中秋节**  | 9月6日-9月8日          | 9月13日（周六）补班              | 3天  |
| **国庆节**  | 10月1日-10月7日        | 9月28日（周日）、10月11日（周六）补班 | 7天  |

---

### 说明与补充
1. **春节调休特殊性**：推测除夕（1月28日）纳入假期，实际是否放假需以官方通知为准。
2. **劳动节小长假**：可能形成“5天长假”模式，延续近年调休惯例。
3. **中秋国庆间隔**：2025年中秋与国庆间隔约3周，调休压力相对较小。
4. **补班标注**：表格中补班日期为推测周末调换的工作日。


|公式类型|公式示例|说明|
| ---- | ---- | ---- |
|加法|`=SUM(A1:A5, B6)` 或 `=A1+A2+A3+A4+A5+B6`|计算A1至A5单元格及B6单元格数值的总和。假设A1至A5分别为1，2，3，4，5，B6为6，相加值为21[ 3 ](https://www.3d66.com/answers_relation/relation_2633185.html)。|
|减法|`=SUM(A1:A5) - B6` 或 `=A1+A2+A3+A4+A5 - B6`|计算A1至A5单元格数值总和再减去B6单元格的数值。假设A1至A5分别为1，2，3，4，5，B6为6，相减后值为9[ 3 ](https://www.3d66.com/answers_relation/relation_2633185.html)。|
|乘法|`=PRODUCT(A1:A5, B6)` 或 `=A1*A2*A3*A4*A5*B6`|计算A1至A5单元格及B6单元格数值的乘积。假设A1至A5分别为1，2，3，4，5，B6为6，相乘值为720[ 3 ](https://www.3d66.com/answers_relation/relation_2633185.html)。|
|除法|`=PRODUCT(A1:A5) / B6` 或 `=A1*A2*A3*A4*A5 / B6`|计算A1至A5单元格数值乘积再除以B6单元格的数值。假设A1至A5分别为1，2，3，4，5，B6为6，相除后值为20[ 3 ](https://www.3d66.com/answers_relation/relation_2633185.html)。|
|VLOOKUP函数|`=VLOOKUP($K$20, $A$5:$H$16, 2, 0)`|`$K$20`是要依据查找的数据；`$A$5:$H$16`表示引用区域；2是返回的数值所在列数；0表示精确查找。该公式可用于查找特定型号对应的相关数值，例如这里可获得相应的290这个数值[ 2 ](https://www.3d66.com/answers_relation/relation_3691362.html)。|
|IF函数|`=IF(逻辑值为true或false的条件, 条件为true时返回值, 条件为false时返回值)`|根据设定的条件判断返回不同的值，例如当条件为真时返回某个值，条件为假时返回另一个值[ 2 ](https://www.3d66.com/answers_relation/relation_3691362.html)。|
|SUM函数|`=SUM(D3:D8)`|用于计算指定区域（如D3至D8单元格）数值的总和，可快速统计3月销量的和等类似场景[ 2 ](https://www.3d66.com/answers_relation/relation_3691362.html)。|
|RANK函数|`=RANK(参与排名的单元格, 排名的数值区域, 排序方法)`|用于对数据进行排名，排序方法中0代表降序，1代表升序[ 4 ](https://www.51dongshi.com/dbbrzgjztfdbbrrcbd/)。|
|FV函数|在模拟运算试算定额存款最终存款总额案例中，`=FV(Rate, Nper, Pmt)`，其中 `Rate` 输入 `B2/12`（月利率），`Nper` 输入 `B3`（存款期限，月），`Pmt` 输入 `A5`（每月存款额）|用于计算存款总额，在财务计算中很常用[ 2 ](https://www.3d66.com/answers_relation/relation_3691362.html)。|
|PI函数|`=PI()`|在单元格中输入该公式可得到圆周率π的值[ 3 ](https://www.3d66.com/answers_relation/relation_2633185.html)。|

2. **组合数学中的分组编码**
   - 在组合问题中，可能表示将元素1和12分别分配到不同的组中，如：
     \[
     \text{组1: } \{1\}, \quad \text{组2: } \{12\}
     \]
   - **应用**：划分问题或装箱问题的解表示。

以下为涉及多个数学领域的复杂公式表格，使用标准LaTeX格式呈现：
---
| **公式名称**                | **数学表达式**                                                                 | **所属领域**       | **关键特性**                     |
|-----------------------------|-----------------------------------------------------------------------------|--------------------|----------------------------------|
| Navier-Stokes方程           | $\frac{\partial \mathbf{u}}{\partial t} + (\mathbf{u} \cdot \nabla)\mathbf{u} = -\nabla p + \nu \nabla^2 \mathbf{u}$ | 流体力学           | 非线性偏微分方程，描述黏性流体运动    |
| 爱因斯坦场方程              | $G_{\mu\nu} + \Lambda g_{\mu\nu} = \frac{8\pi G}{c^4} T_{\mu\nu}$          | 广义相对论         | 揭示时空几何与物质能量分布的关系      |
| Schrödinger方程             | $i\hbar \frac{\partial}{\partial t} \Psi = \left[ -\frac{\hbar^2}{2m}\nabla^2 + V \right] \Psi$ | 量子力学           | 波函数演化，量子态概率描述            |
| 高斯-博内定理               | $\int_M K \, dA + \int_{\partial M} k_g \, ds = 2\pi \chi(M)$              | 微分几何           | 连接曲率积分与拓扑欧拉示性数          |
| 黎曼ζ函数函数方程           | $\zeta(s) = 2^s \pi^{s-1} \sin\left(\frac{\pi s}{2}\right) \Gamma(1-s) \zeta(1-s)$ | 解析数论           | 揭示ζ函数在复平面上的对称性           |
| 杨-米尔斯存在性与质量间隙问题 | $\mathcal{L}_{\text{YM}} = -\frac{1}{4} F^a_{\mu\nu} F^{a\mu\nu}$          | 量子场论           | 千禧年难题，规范场理论的核心          |
| 布莱克-斯科尔斯方程         | $\frac{\partial V}{\partial t} + \frac{1}{2}\sigma^2 S^2 \frac{\partial^2 V}{\partial S^2} + rS \frac{\partial V}{\partial S} - rV = 0$ | 金融数学           | 期权定价模型，依赖随机微分方程        |
| 阿蒂亚-辛格指标定理         | $\text{ind}(D) = \int_{M} \text{ch}(E) \cdot \hat{A}(TM)$                   | 代数拓扑           | 连接椭圆算子的解析指标与拓扑不变量    |
| 考克斯特-群表示公式         | $\sum_{w \in W} (-1)^{\ell(w)} e^{w(\lambda + \rho)} = \prod_{\alpha > 0} (e^{\alpha/2} - e^{-\alpha/2})$ | 李群表示论         | 刻画Weyl群作用下的特征标结构          |
| 霍奇猜想                    | $H^{2k}(X, \mathbb{Q}) \cap H^{k,k}(X) = \text{Span}_{\mathbb{Q}}\{ [Z] \mid Z \subset X \text{代数子簇} \}$ | 代数几何           | 千禧年难题，调和形式与代数闭链的关系  |
---

| **数字类型**        | **数值示例**                  | **数学特性/应用场景**                          |
|---------------------|-----------------------------|---------------------------------------------|
| 质数               | 9973                       | 密码学RSA算法中常用的大质数因子                     |
| 完全数             | 8128                       | 所有真因数之和等于自身（1+2+4+8+16+...+2032=8128） |
| 斐波那契数         | 144                        | 向日葵螺旋排列、股票技术分析的常见周期数                 |
| 圆周率（π）        | 3.1415926535               | 阿基米德算法计算至第10位，满足航天器轨道精度需求（0.1mm/km误差） |
| 自然常数（e）      | 2.7182818284               | 连续复利计算核心，金融衍生品定价模型的基础参数              |
| 黄金分割率（φ）    | 1.6180339887               | 帕特农神庙建筑比例、iPhone界面设计的视觉优化基准           |
| 欧拉数（γ）        | 0.5772156649               | 量子场论重整化计算中的发散项修正因子                   |
| 阿伏伽德罗常数     | 6.02214076×10²³            | 1摩尔物质的基本单元数，半导体掺杂工艺的核心参数             |
| 普朗克常数         | 6.62607015×10⁻³⁴ J·s       | 量子力学不确定性原理的物理量纲载体，光量子芯片设计的理论基础      |
| 引力常数（G）      | 6.67430×10⁻¹¹ N·m²/kg²     | 爱因斯坦场方程中的时空弯曲强度系数，暗物质探测实验的基准值       |


假设我们需要创建一个与股票分析相关的复杂指标公式，可以基于以下形式：
\[ \text{ComplexIndicator} = \text{FunctionA} \times (\text{Parameter1}) + \text{FunctionB} \times (\text{Parameter2}) - \text{FunctionC} \times (\text{Parameter3}) \]
这里，`FunctionA`, `FunctionB`, 和 `FunctionC` 代表不同的数据处理方式，而 `Parameter1`, `Parameter2`, 和 `Parameter3` 则是根据具体情境设定的数值

# 食物表格
以下为你提供包含不同类别食物的表格：
|食物类别|具体食物|热量信息（参考）|
| ---- | ---- | ---- |
|主食类|米饭、面条、馒头、面包|通常每100克米饭约116大卡；每100克面条约286大卡；每100克馒头约252大卡；每100克面包约312大卡[ 3 ](https://www.zhihu.com/topic/20514017/top-answers)|
|蔬菜类|韭菜、菠菜、西兰花、胡萝卜|如100克韭菜约26大卡（可食部分90克）；菠菜每100克约28大卡；西兰花每100克约36大卡；胡萝卜每100克约41大卡[ 3 ](https://www.zhihu.com/topic/20514017/top-answers)|
|肉类|猪肉、牛肉、鸡肉|每100克猪肉（肥瘦相间）约395大卡；每100克牛肉约288大卡；每100克鸡肉约167大卡[ 3 ](https://www.zhihu.com/topic/20514017/top-answers)|
|水产类|鱼、虾、贝类|不同种类差异较大，如每100克草鱼约113大卡；每100克基围虾约101大卡；每100克花蛤约45大卡[ 1 ](http://www.wenshubang.com/huiyijilu/467610.html)[ 3 ](https://www.zhihu.com/topic/20514017/top-answers)|
|蛋类|鸡蛋、鸭蛋|每100克鸡蛋约144大卡；每100克鸭蛋约180大卡[ 3 ](https://www.zhihu.com/topic/20514017/top-answers)|
|乳制品|牛奶、酸奶|每100毫升牛奶约54大卡；每100克酸奶约72大卡[ 3 ](https://www.zhihu.com/topic/20514017/top-answers)|
|水果类|苹果、香蕉、橙子|每100克苹果约53大卡；每100克香蕉约93大卡；每100克橙子约48大卡[ 3 ](https://www.zhihu.com/topic/20514017/top-answers)|
|油类|橄榄油、大豆油|每100克橄榄油约899大卡；每100克大豆油约899大卡[ 3 ](https://www.zhihu.com/topic/20514017/top-answers)|


以下是一个标准的C语言Hello World程序：

```c
#include <stdio.h>
int main(void) {
printf("Hello World!\n");
return 0;
}
```

代码说明：
1. `#include <stdio.h>`：包含标准输入输出库，提供printf函数的使用权限[ 1 ](https://blog.csdn.net/weixin_36185028/article/details/80308816)
2. `int main(void)`：程序入口函数，返回整型值
3. `printf("Hello World!\n")`：输出指定字符串，`\n`表示换行符[ 2 ](https://blog.csdn.net/jianshuilan_0613/article/details/116160418)
4. `return 0;`：表示程序成功结束
编译运行：

```bash
gcc hello.c -o hello
./hello
```

输出结果：

```
Hello World!
```

这个程序展示了C语言程序的基本结构，包含头文件包含、主函数定义和标准输出操作。建议使用任何C语言编译器（如GCC、Clang等）进行编译运行。

[3](ZmlsZS1pZD0xNzQ1MzAzNjA3MTk1MTI3NCZmaWxlLW5hbWU9JUU3JUFFJTgwJUU3JTlGJUFEJUU0JUJCJThCJUU3JUJCJThEJUU2JTlEJUFEJUU1JUI3JTlFJUU5JTk3JUFFJUU3JUFEJTk0XzIwMjUwNDIyMTIxNDA1ODk1LnBkZg==)

这个程序展示了C语言程序的基本结构，包含头文件包含、主函数定义和标准输出操作。建议使用任何C语言编译器（如GCC、Clang等）进行编译运行。
"###

    var scroller: Scroller = Scroller()

    func build() {
        Column() {
            Scroll(scroller) {
                Column {
                    MarkdownAIComponent(output: mdStr, isFull: true, markdownAIConfiguration: setConfig())
                }
                .margin(right: 10, left: 10)
            }
            // 设置滚动方法
            .scrollable(ScrollDirection.Vertical)
        }
    }

    func setConfig(): MarkdownAIConfiguration {
        let MarkdownAIConfigurationBuilder: MarkdownAIConfigurationBuilder = MarkdownAIConfiguration.emptyBuilder()
        MarkdownAIConfigurationBuilder.setMarkdownAITheme(setMarkdownAITheme())
        MarkdownAIConfigurationBuilder.setImageCallback(imageCallback)
        MarkdownAIConfigurationBuilder.setVideoCallback(videoCallback)
        MarkdownAIConfigurationBuilder.setVideoImageCallback(videoImageCallback)
        MarkdownAIConfigurationBuilder.setLinkCallback(linkCallback)
        MarkdownAIConfigurationBuilder.setCodeCopyCallback(codeCopyCallback)
        MarkdownAIConfigurationBuilder.setCodeFullScreenCallback(codeFullScreenCallback)
        MarkdownAIConfigurationBuilder.setLatexImageCallbackCallback(latexImageCallbackCallback)
        MarkdownAIConfigurationBuilder.setFootnoteCallback(footnoteCallback)
        return MarkdownAIConfigurationBuilder.build()
    }

    func setMarkdownAITheme(): MarkdownAITheme {
        let MarkdownAITheme: MarkdownAITheme = MarkdownAITheme
            .emptyBuilder()
            // 代码复制按钮默认图
            .setCodeCopyIcon(@r(app.media.app_icon))
            // 设置一级二级标题下划线高度
            .setHeadingBreakHeight(0.0)
            .setHeadingTextSizeMultipliers([15.0, 15.0, 15.0, 15.0, 15.0, 15.0]) // fp
            // 字体颜色
            .setParagraphTextColor(Color(0xFF222222))
            // 字体大小
            .setParagraphTextSize(15.0)
            // 行高
            .setParagraphTextLineheight(25.0)
            // 内联代码颜色
            .setCodeTextColor(Color(0xFFFF5722))
            // 标题
            .setHeadingTextColor(Color(0xFF222222))
            // 链接颜色
            .setLinkColor(Color(0xFF000000))
            // 数学公式
            .setLatexMathBackGroupColor(Color(0xFFFBFBFB))
            // 表格
            .setTableHeaderRowBackgroundColor(Color(0xFFF5F7FA))
            .setTableOddRowBackgroundColor(Color(0xFFFAFAFA))
            .setTableEvenRowBackgroundColor(Color(0xFFFFFFFF))
            .setTableBorderWidth(2.0)
            .setTableBorderColor(Color.RED)
            // 设置上下文
            .setAbilityContext(getGlobalAbilityContext())
            // 链接样式 button 或 文字
            .setIsLinkStyle(true)
            // 链接相关样式
            .setLinkCircleImageRadius(16.0)
            .setLinkCircleImageTextSize(10.0)
            .setLinkCircleImageMargin(2.0)
            .setLinkCircleImageBackGroupColor(Color.WHITE)
            .setLinkCircleImageButtonBackGroupColor(Color.BLACK)
            .setLinkCircleImageTextColor(Color.WHITE)
            .setLinkRectImageRadius(16.0)
            .setLinkRectImageMargin(2.0)
            .setLinkRectImageHeight(16.0)
            .setLinkRectImageTextSize(10.0)
            .setLinkRectToolImageDividingLineWidth(1.0)
            .setLinkRectToolImageTextSize(11.0)
            .setLinkRectToolImageMargin(2.0)
            .setImagePadding(20)
            .build()
        return MarkdownAITheme
    }

    func footnoteCallback(f: ?Float64) {
        scroller.scrollBy(xOffset: 0.0, yOffset: f.getOrThrow())
        Hilog.error(1, "2", "------------------------footnoteCallback:f:${f}")
    }

    func imageCallback(url: String) {
        PromptAction.showToast(message: url)
        AppLog.error("------------------------LinkCallback:${url}")
    }

    func videoCallback(url: String) {
        PromptAction.showToast(message: url)
        AppLog.error("------------------------videoCallback:${url}")
    }

    func videoImageCallback(url: String, videoImageCallbackCallback: (String) -> Unit) {
        if (url == "562986b1-46d8-48ef-bac6-82685bcedcd8") {
            videoImageCallbackCallback("https://pic.leetcode-cn.com/1614477066-YeEeWg-file_1614477068523")
        } else {
            videoImageCallbackCallback("https://pic.leetcode-cn.com/1614477067-itHyLr-file_1614477069388")
        }
        AppLog.error("------------------------videoImageCallback:${url}")
    }

    func linkCallback(url: String) {
        PromptAction.showToast(message: url)
        AppLog.error("------------------------LinkCallback:${url}")
    }

    func codeCopyCallback(url: String) {
        PromptAction.showToast(message: url)
        AppLog.error("------------------------codeCopyCallback:${url}")
    }

    func codeFullScreenCallback(url: String, infos: ?String) {
        PromptAction.showToast(message: "${url}${infos}")
        AppLog.error("------------------------codeFullScreenCallback:${url}")
        AppLog.error("------------------------codeFullScreenCallback:${infos}")
    }

    func latexImageCallbackCallback(data: Array<UInt8>, height: Length, width: Length) {
        AppLog.error("------------------------data:${data}")
        AppLog.error("------------------------height:${height.value}")
        AppLog.error("------------------------width:${width.value}")
    }
}
