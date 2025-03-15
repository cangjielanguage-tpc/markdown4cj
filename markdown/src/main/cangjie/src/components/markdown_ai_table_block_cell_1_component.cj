/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
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
class MarkdownAITableBlockCell1Component {
    /**
     * markdown配置
     */
    @Prop
    var markdownAIConfiguration: MarkdownAIConfiguration

    /**
     * 表格tableNodeView
     */
    @Prop
    var nodeView: NodeView

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    @Prop
    var idRow: Int64

    /**
     * 异步加载的图片数据
     */
    @State
    var arrayListPixelMap: ObservedArrayList<ImageData> = ObservedArrayList<ImageData>()

    /**
     * 缓存的图片列表
     */
    var listPixelMap: ArrayList<?PixelMap> = ArrayList<?PixelMap>()

    /**
     * 线程列表
     */
    var futs: ArrayList<?Future<Unit>> = ArrayList<?Future<Unit>>()

    protected override func aboutToDisappear(): Unit {
        threadFutureCancel(futs)
        delPixelMap(listPixelMap)
    }

    func build() {
        Text() {
            ForEach(
                nodeView.children,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => if (item.node is CommonmarkText) {
                        // 文本
                        if ((nodeView.node as TableCell)().isHeader()) {
                            tableComponentText(item, true, markdownAIConfiguration)
                        } else {
                            tableComponentText(item, false, markdownAIConfiguration)
                        }
                    } else if (item.node is Code) {
                        // 内联代码
                        if ((nodeView.node as TableCell)().isHeader()) {
                            tableComponentCode(item, true, markdownAIConfiguration)
                        } else {
                            tableComponentCode(item, false, markdownAIConfiguration)
                        }
                    } else if (item.node is LatexMathNode) {
                        // 数学公式节点
                        tableComponentLatexMath(latexMathImagePixelmap((item.node as LatexMathNode)().latex, idx))
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
            .textAlign(renderTableCellAlign((nodeView.node as TableCell)()))
            // 设置内边距属性
            .padding(markdownAIConfiguration.markdownAITheme.tableCellPadding)
            // 设置组件的背景色
            .backgroundColor(
                renderTableCellColor((nodeView.node as TableCell)(), markdownAIConfiguration.markdownAITheme, idRow))
            // 统一边框样式设置接口
            .border(width: (markdownAIConfiguration.markdownAITheme.tableBorderWidth / 2.0).vp,
                color: markdownAIConfiguration.markdownAITheme.tableBorderColor, style: BorderStyle.Solid)
    }

    /**
     * 行内数学公式
     */
    @Builder
    func tableComponentLatexMath(ret: Int64) {
        ForEach(
            arrayListPixelMap,
            itemGeneratorFunc: {
                item: ImageData, idx: Int64 => if (item.ret == ret) {
                    if (isLatexImagePixelMap(item, listPixelMap)) {
                        ImageSpan(item.pixelMap())
                            // 设置组件自身的高度
                            .height(pxToVp(item.height()))
                            // 设置组件自身的宽度
                            .width(pxToVp(item.width()))
                            // 设置图片的缩放类型
                            .objectFit(ImageFit.Contain)
                            // 设置约束尺寸
                            .constraintSize(maxWidth: 100.percent)
                            // 点击动作触发该方法调用
                            .onClick {
                                evt => latexImageOnClick(item.arrayUint8(), item.height().px, item.width().px,
                                    markdownAIConfiguration.latexImageCallback)
                            }
                    }
                }
            }
        )
    }

    /**
     * 数学公式数据处理 - 行内数学公式
     */
    func latexMathImagePixelmap(strLatexMath: String, idx: Int64): Int64 {
        let callback: (?PixelMap, ?Float64, ?Float64, ?Array<UInt8>) -> Unit = {
            pixelMap, height, width, arr => launch {
                arrayListPixelMap.append(
                    ImageData(ret: idx, pixelMap: pixelMap, height: height, width: width, arrayUint8: arr))
            }
        }
        let fut = MarkdownParseLatexUtil.latexMathStrToPixelMapRow(strLatexMath,
            markdownAIConfiguration.markdownAITheme.resPath, markdownAIConfiguration, componentWidth, callback)
        futs.append(fut)
        return idx
    }
}
