package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.hybrid_base.*
import markdown.components.*

struct TestItem {
    let name: String
    let page: String
    init(name!: String, page!: String) {
        this.name = name
        this.page = page
    }
}

@HybridComponentEntry
@Component
class IndexPage {
    let items: Array<TestItem> = [
        TestItem(name: "0、演示样例", page: "DemoDetailsPage"),
        TestItem(name: "1、标题", page: "TitleDetailsPage"),
        TestItem(name: "2、段落", page: "ParagraphDetailsPage"),
        TestItem(name: "3、分割线", page: "ThematicDetailsPage"),
        TestItem(name: "4、软换行", page: "LineBreakDetailsPage"),
        TestItem(name: "5、数学公式", page: "LatexMathDetailsPage"),
        TestItem(name: "6、表格", page: "TableDetailsPage"),
        TestItem(name: "7、链接", page: "LinkDetailsPage"),
        TestItem(name: "8、块引用", page: "QuoteDetailsPage"),
        TestItem(name: "9、列表", page: "ListDetailsPage"),
        TestItem(name: "10、内联代码", page: "CodeLineDetailsPage"),
        TestItem(name: "11、代码块", page: "CodeBlockDetailsPage"),
        TestItem(name: "12、组合代码块", page: "CodeListDetailsPage"),
        TestItem(name: "13、单独代码块", page: "CodeSeparateDetailsPage"),
        TestItem(name: "14、音频", page: "AudioDetailsPage"),
        TestItem(name: "15、视频", page: "VideoDetailsPage"),
        TestItem(name: "16、图片", page: "ImageDetailsPage"),
        TestItem(name: "17、加粗", page: "BoldDetailsPage"),
        TestItem(name: "18、斜体", page: "ItalicDetailsPage"),
        TestItem(name: "19、删除线", page: "StrikethroughDetailsPage"),
        TestItem(name: "20、图片style", page: "ImageStyleDetailsPage"),
        TestItem(name: "21、Toc目录", page: "TocDetailsPage"),
        TestItem(name: "22、脚注", page: "FootnoteDetailsPage"),
        TestItem(name: "23、定义列表", page: "DescListDetailsPage"),
        TestItem(name: "24、标题ID", page: "HeadIDDetailsPage"),
        TestItem(name: "25、HTML", page: "HTMLDetailsPage"),
        TestItem(name: "26、下标", page: "SubDetailsPage"),
        TestItem(name: "27、上标", page: "SupDetailsPage"),
        TestItem(name: "28、Emoji", page: "EmojiDetailsPage"),
        TestItem(name: "29、综合", page: "AllDetailsPage"),
        TestItem(name: "30、Banner", page: "BannerDetailsPage"),
        TestItem(name: "31、AB方案", page: "ABCustomDetailsPage"),
        TestItem(name: "33、文本全量切换", page: "SwitchDataPage"),
        TestItem(name: "34、超大数据", page: "BigDataDetailsPage"),
        TestItem(name: "35、高亮文本", page: "HighlightDetailsPage"),
        TestItem(name: "38、链接曝光功能", page: "LinkExposureDetailsPage"),
        TestItem(name: "【已废弃】0", page: "Deprecated0DetailsPage"),
        TestItem(name: "【已废弃】1", page: "Deprecated1DetailsPage"),
        TestItem(name: "【已废弃】2", page: "Deprecated2DetailsPage"),
        TestItem(name: "【已废弃】3", page: "Deprecated3DetailsPage"),
        TestItem(name: "【已废弃】4", page: "Deprecated4DetailsPage"),
        TestItem(name: "【已废弃】5", page: "Deprecated5DetailsPage"),
        TestItem(name: "【已废弃】6", page: "Deprecated6DetailsPage")
    ]

    public func build() {
        Column {
            Text("Markdown测试用例")
                .height(40.0)
                .width(100.percent)
                .fontColor(0xFFFFFFFF)
                .textAlign(TextAlign.Center)
                .fontSize(18.0)
                .backgroundColor(0xFFFF0000)
            Scroll {
                Column {
                    ForEach(
                        items,
                        itemGeneratorFunc: {
                            item: TestItem, _: Int64 =>
                                Button(item.name)
                                    .height(40.0)
                                    .width(80.percent)
                                    .shape(ShapeType.Capsule)
                                    .fontColor(0xFFFFFFFF)
                                    .backgroundColor(0xFFFF0000)
                                    .margin(top: 5.0, bottom: 5.0)
                                    .fontSize(16.0)
                                    .onClick {
                                        evt => callGlobalFunc("navigate", item.page)
                                    }
                        }
                    )
                }
            }
            .scrollable(ScrollDirection.Vertical)
            .layoutWeight(1)
        }
    }
}
