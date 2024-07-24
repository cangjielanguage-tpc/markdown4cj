/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown表格自定义控件
 */
@Component
class MarkdownTableBlockComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 表格tableNodeView
     */
    var tableNodeView: NodeView

    /**
     * 外边距 - 上面
     */
    var marginTop: Float64

    /**
     * 外边距 - 下面
     */
    var marginBottom: Float64

    var listPixelMap: ArrayList<?PixelMap> = ArrayList<?PixelMap>()

    func build() {
        Column() {
            renderTableHeaderOrBody()
        }
        // 设置元素内容的对齐方式
        .align(Alignment.Start)
        // 设置元素水平方向的布局
        .direction(Direction.Ltr)
        // 设置外边距属性
        .margin(top: marginTop, bottom: marginBottom)
        // 设置组件自身的宽度
        .width(100.percent)
    }

    /**
     * 文本
     */
    @Builder
    func tableComponentText(nodeView: NodeView, isHeader: Bool) {
        // 设置文本内容
        Span(spanText(nodeView))
            // 设置文本的字体列表
            .fontFamily(spanFontFamily(false, markdownConfiguration.markdownTheme, false))
            // 设置文本尺寸
            .fontSize(spanFontSize(false, markdownConfiguration.markdownTheme, false, 0))
            // 设置文本的字体粗细
            .fontWeight(spanFontWeight(nodeView, isHeader))
            // 设置文本的字体样式
            .fontStyle(spanFontStyle(nodeView))
            // 设置文本颜色
            .fontColor(spanFontColor(nodeView, false, markdownConfiguration.markdownTheme, false))
            // 设置文本装饰线样式及其颜色
            .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
            // 点击动作触发该方法调用
            .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
    }

    /**
     * 内联代码
     */
    @Builder
    func tableComponentCode(nodeView: NodeView, isHeader: Bool) {
        // 设置文本内容
        Span(spanText(nodeView))
            // 设置文本的字体列表
            .fontFamily(spanFontFamily(true, markdownConfiguration.markdownTheme, false))
            // 设置文本尺寸
            .fontSize(spanFontSize(true, markdownConfiguration.markdownTheme, false, 0))
            // 设置文本的字体粗细
            .fontWeight(spanFontWeight(nodeView, isHeader))
            // 设置文本的字体样式
            .fontStyle(spanFontStyle(nodeView))
            // 设置文本颜色
            .fontColor(spanFontColor(nodeView, true, markdownConfiguration.markdownTheme, false))
            // 设置文本装饰线样式及其颜色
            .decoration(decorationType: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[0], color: spanDecoration(nodeView, markdownConfiguration.markdownTheme)[1])
            // 点击动作触发该方法调用
            .onClick {evt => linkOnClick(nodeView, markdownConfiguration.linkCallback)}
    }

    /**
     * 内联HTML
     */
    @Builder
    func tableComponentHtmlInline(htmlInline: HtmlInline) {
        // 文本内容
        if (htmlInline.getLiteral().toAsciiLower().replace(" ", "") == "<br>" ||
            htmlInline.getLiteral().toAsciiLower().replace(" ", "") == "</br>" ||
            htmlInline.getLiteral().toAsciiLower().replace(" ", "") == "<br/>") {
            // 设置文本内容
            Span("\n")
        } else {
            // TODO 其他内容，暂时只支持br标签
        }
    }

    /**
     * 行内数学公式
     */
    @Builder
    func tableComponentLatexMath(allData: (?PixelMap, ?Length, ?Length, ?Array<UInt8>, String)) {
        if (allData[0].isSome() && addPixelMap(allData[0])) {
            // 设置图片的数据源
            ImageSpan(allData[0]())
                // 设置组件自身的高度
                .height(allData[1]())
                // 设置组件自身的宽度
                .width(allData[2]())
                // 设置图片的缩放类型
                .objectFit(ImageFit.Contain)
                // 设置约束尺寸
                .constraintSize(maxWidth: Length(100, unitType: LengthType.percent))
                // 点击动作触发该方法调用
                .onClick {evt => latexImageOnClick(allData[3](), allData[1](), allData[2](), markdownConfiguration.latexImageCallback)}
        } else {
            // 设置文本内容
            Span(allData[4])
                // 设置文本尺寸
                .fontSize(markdownConfiguration.markdownTheme.paragraphTextSize)
                // 设置文本的字体粗细
                .fontWeight(FontWeight.W400)
                // 设置文本的字体样式
                .fontStyle(FontStyle.Normal)
                // 设置文本颜色
                .fontColor(markdownConfiguration.markdownTheme.paragraphTextColor)
        }
    }

    /**
     * 表格内容信息
     */
    @Builder
    func renderTableCell(tableCell: NodeView, idx: Int64) {
        Text() {
            ForEach(
                tableCell.children.toArray(),
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        if ((tableCell.node as TableCell)().isHeader()) {
                            tableComponentText(item, true)
                        } else {
                            tableComponentText(item, false)
                        }
                    } else if (item.node is Code) {
                        // 内联代码
                        if ((tableCell.node as TableCell)().isHeader()) {
                            tableComponentCode(item, true)
                        } else {
                            tableComponentCode(item, false)
                        }
                    } else if (item.node is HtmlInline) {
                        // 内联HTML
                        tableComponentHtmlInline((item.node as HtmlInline)())
                    } else if (item.node is ImgVideo) {
                        // TODO 视频节点
                        Span("")
                    } else if (item.node is StyleImage) {
                        // TODO 图片Style节点
                        Span("")
                    } else if (item.node is CommonmarkImage) {
                        // TODO 图片节点
                        Span("")
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        tableComponentLatexMath(
                            latexMathStrToPixelMap((item.node as LatexMathNode)().latex,
                            markdownConfiguration.markdownTheme.resPath, markdownConfiguration))
                    } else {
                        // TODO 其他节点
                        Span("")
                    }
                }
            )
        }
        // 容器尺寸确定时，元素与兄弟节点主轴布局尺寸按照权重进行分配，忽略本身尺寸设置仅在Row/Column/Flex布局中生效
        .layoutWeight(1)
        // 设置父容器的剩余空间分配给此属性所在组件的比例
        .flexGrow(1)
        // Flex 容器压缩尺寸分配给此属性所在组件的比例
        .flexShrink(1)
        // 覆盖 Flex 布局容器中 alignItems 默认配置
        .alignSelf(ItemAlign.Stretch)
        // 设置多行文本的文本对齐方式
        .textAlign(renderTableCellAlign((tableCell.node as TableCell)()))
        // 设置内边距属性
        .padding(markdownConfiguration.tableTheme.tableCellPadding)
        // 设置组件的背景色
        .backgroundColor(renderTableCellColor((tableCell.node as TableCell)(), markdownConfiguration.tableTheme, idx))
        // 统一边框样式设置接口
        .border(width: Length(markdownConfiguration.tableTheme.tableBorderWidth / 2.0), color: markdownConfiguration.tableTheme.tableBorderColor, style: BorderStyle.Solid)
        // 组件卸载消失时触发此回调
        .onDisAppear({=> delPixelMap()})
    }

    /**
     * 表格行信息
     */
    @Builder
    func renderTableRow(tableRow: NodeView, idRow: Int64) {
        Row() {
            ForEach(
                tableRow.children,
                itemGeneratorFunc: {
                    item: NodeView, idxItem: Int64 => renderTableCell(item, idRow)
                }
            )
        }
        // 设置组件自身的宽度
        .width(100.percent)
    }

    /**
     * 表格头或表格体信息
     */
    @Builder
    func renderTableHeaderOrBody() {
        List() {
            ForEach(
                tableNodeView.children,
                itemGeneratorFunc: {
                    tableHeaderOrBody: NodeView, idx: Int64 => ForEach(
                        tableHeaderOrBody.children,
                        itemGeneratorFunc: {
                            tableRow: NodeView, idRow: Int64 => ListItem() {
                                // 行信息
                                renderTableRow(tableRow, idRow)
                            }
                        }
                    )
                }
            )
        }
        // 统一边框样式设置接口
        .border(width: Length(markdownConfiguration.tableTheme.tableBorderWidth / 2.0), color: markdownConfiguration.tableTheme.tableBorderColor, style: BorderStyle.Solid)
    }

    func addPixelMap(pixelMap: ?PixelMap): Bool{
        listPixelMap.append(pixelMap)
        return true
    }

    func delPixelMap(){
        for(item in listPixelMap){
            if(item.isSome()){
                item().Release()
            }
        }
        listPixelMap.clear()
    }
}
