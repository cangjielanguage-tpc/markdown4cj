/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * Markdown无序列表(任务列表)、有序列表(TOC列表)自定义控件
 */
@Component
class MarkdownListItemComponent {
    /**
     * markdown配置
     */
    var markdownConfiguration: MarkdownConfiguration

    /**
     * 广告布局
     */
    @BuilderParam
    var adBuilder: (NodeView) -> Unit

    /**
     * 视频布局
     */
    @BuilderParam
    var videoBuilder: (NodeView, MarkdownConfiguration, (String) -> Unit) -> Unit

    /**
     * 音频布局
     */
    @BuilderParam
    var audioBuilder: (NodeView, MarkdownConfiguration) -> Unit

    /**
     * 列表节点
     */
    var nodeView: NodeView

    /**
     * 控件宽度 - 单位px
     */
    @Prop
    var componentWidth: Float64

    /**
     * 缓存的数据
     */
    var markdownCacheConfiguration: MarkdownCacheConfiguration

    /**
     * 脚注点击事件
     */
    var fontCallback: (String) -> Unit

    /**
     * TOC列表点击事件回调
     */
    var tocListOnClick: (Int64) -> Unit

    /**
     * 图片点击事件
     */
    var imageCallback: (String) -> Unit

    /**
     * 视频点击事件
     */
    var videoCallback: (String) -> Unit

    /**
     * 懒加载数据源
     */
    var nodeViewDataSource: NodeViewDataSource = NodeViewDataSource(ArrayList<NodeView>())

    protected override func aboutToAppear(): Unit {
        // 初始化刷新数据
        refreshData(nodeView)
        // 缓存当前控件
        markdownCacheConfiguration.listItemComponents.add(this.nodeView.nodeHash, this)
    }

    protected override func aboutToDisappear(): Unit {
        // 清除当前控件
        let value = markdownCacheConfiguration.listItemComponents.get(this.nodeView.nodeHash)
        if (let Some(v) <- value) {
            if (refEq(v, this)) {
                markdownCacheConfiguration.listItemComponents.remove(this.nodeView.nodeHash)
            }
        } else {
            markdownCacheConfiguration.listItemComponents.remove(this.nodeView.nodeHash)
        }
    }

    func build() {
        List() {
            LazyForEach(
                nodeViewDataSource,
                itemGeneratorFunc: {
                    item: NodeView, idx: Int64 => ListItem() {
                        if (item.node is Paragraph) {
                            // 段落
                            blockParagraphComponent(markdownConfiguration, item, Option<FootnoteBlock>.None, fontCallback, tocListOnClick, imageCallback, componentWidth, true, false, markdownCacheConfiguration.paragraphComponents)
                        } else if (item.node is Heading) {
                            // 标题
                            blockHeadingComponent(markdownConfiguration, item, fontCallback, imageCallback, componentWidth, true, markdownCacheConfiguration.headingComponents)
                        } else if (item.node is IndentedCodeBlock) {
                            // 缩进代码
                            blockIndentedCodeComponent(markdownConfiguration, item, markdownCacheConfiguration.indentedCodeComponents)
                        } else if (item.node is FencedCodeBlock) {
                            // 围栏代码
                            blockFencedCodeComponent(markdownConfiguration, item, markdownCacheConfiguration.fencedCodeComponents)
                        } else if (item.node is BulletList) {
                            // 无序列表
                            MarkdownListComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeView: item,
                                adBuilder: adBuilder,
                                videoBuilder: videoBuilder,
                                audioBuilder: audioBuilder,
                                isOrdered: false,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                tocListOnClick: tocListOnClick,
                                videoCallback: videoCallback,
                                componentWidth: componentWidth,
                                markdownCacheConfiguration: markdownCacheConfiguration
                            )
                        } else if (item.node is OrderedList) {
                            // 有序列表
                            MarkdownListComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeView: item,
                                adBuilder: adBuilder,
                                videoBuilder: videoBuilder,
                                audioBuilder: audioBuilder,
                                isOrdered: true,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                tocListOnClick: tocListOnClick,
                                videoCallback: videoCallback,
                                componentWidth: componentWidth,
                                markdownCacheConfiguration: markdownCacheConfiguration
                            )
                        } else if (item.node is BlockQuote) {
                            // 块引用
                            MarkdownQuoteComponent(
                                markdownConfiguration: markdownConfiguration,
                                nodeView: item,
                                adBuilder: adBuilder,
                                videoBuilder: videoBuilder,
                                audioBuilder: audioBuilder,
                                fontCallback: fontCallback,
                                imageCallback: imageCallback,
                                tocListOnClick: tocListOnClick,
                                videoCallback: videoCallback,
                                componentWidth: componentWidth,
                                markdownCacheConfiguration: markdownCacheConfiguration
                            )
                        } else if (item.node is TableBlock) {
                            // 表格
                            blockTableComponent(markdownConfiguration, item, fontCallback, imageCallback, componentWidth, markdownCacheConfiguration.tableComponents, markdownCacheConfiguration.tableRowComponents, markdownCacheConfiguration.tableCellComponents)
                        } else if (item.node is LatexMathBlock) {
                            // 数学公式 - 单行
                            blockLatextComponent(markdownConfiguration, item)
                        } else if (item.node is BlockAudio) {
                            // 音频
                            audioBuilder(item, markdownConfiguration)
                        } else if (item.node is BlockVideo) {
                            // 视频
                            videoBuilder(item, markdownConfiguration, videoCallback)
                        } else if (item.node is SlideBlock) {
                            // 图片幻灯片
                            blockImageBannerComponent(markdownConfiguration, item, imageCallback)
                        } else if (item.node is FencedCodeBlockListBlock) {
                            // 代码列表
                            blockCodeBlockListComponent(markdownConfiguration, item, toCodeList(item))
                        } else if (item.node is BlockAD) {
                            // 广告
                            adBuilder(item)
                        } else {
                            // 其他节点
                            Column() {
                                Text("")
                            }
                        }
                    }
                    // 设置外边距属性
                    .margin(top: marginNodeTopAndBottom(0, item, markdownConfiguration), bottom: marginNodeTopAndBottom(0, item, markdownConfiguration))
                },
                keyGeneratorFunc: {
                    item: NodeView, idx: Int64 => return "${idx}-${item.nodeHash}-${item.contentHash}"
                }
            )
        }
        // 设置List组件排列方向
        .listDirection(Axis.Vertical)
        // List交叉轴方向宽度大于ListItem交叉轴宽度 * lanes时，ListItem在List交叉轴方向的布局方式，默认为首部对齐
        .alignListItem(ListItemAlign.Start)
        // 对子组件进行重新布局
        .layoutWeight(1)
    }

    /**
     * 数据刷新
     */
    public func refreshData(nodeView: NodeView): Unit {
        this.nodeView = nodeView
        let refreshNodeViews = nodeView.children
        let refreshNodeViewSize: Int64 = refreshNodeViews.size // 刷新进来的数据长度
        let dataSourceSize: Int64 = nodeViewDataSource.totalCount() // 页面缓存的数据长度
        if (refreshNodeViewSize == 0) {
            return
        }
        if (refreshNodeViewSize > dataSourceSize) {
            // 新数据大于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..dataSourceSize) {
                let newBlockHash = refreshNodeViews[i].nodeHash
                let oldBlockHash = nodeViewDataSource.getData(i).nodeHash
                let newContentHash = refreshNodeViews[i].contentHash
                let oldContentHash = nodeViewDataSource.getData(i).contentHash
                // 唯一ID是否相同
                if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                    if (refreshNodeViews[i].node is BulletList || refreshNodeViews[i].node is OrderedList) {
                        // 有序列表和无序列表
                        let cache = markdownCacheConfiguration.listComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is IndentedCodeBlock) {
                        // 缩进代码
                        let cache = markdownCacheConfiguration.indentedCodeComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is FencedCodeBlock) {
                        // 围栏代码
                        let cache = markdownCacheConfiguration.fencedCodeComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is Heading) {
                        // 标题
                        let cache = markdownCacheConfiguration.headingComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is Paragraph) {
                        // 段落
                        let cache = markdownCacheConfiguration.paragraphComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is TableBlock) {
                        // 表格
                        let cache = markdownCacheConfiguration.tableComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is BlockQuote) {
                        // 块引用
                        let cache = markdownCacheConfiguration.quoteComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else {
                        nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                    }
                } else if (newBlockHash == oldBlockHash && newContentHash == oldContentHash) {
                }
            }
            // 循环添加新数据
            for (i in dataSourceSize..refreshNodeViewSize) {
                nodeViewDataSource.addData(refreshNodeViews[i])
            }
        } else if (refreshNodeViewSize == dataSourceSize) {
            // 新数据等于页面数据
            for (i in 0..dataSourceSize) {
                let newBlockHash = refreshNodeViews[i].nodeHash
                let oldBlockHash = nodeViewDataSource.getData(i).nodeHash
                let newContentHash = refreshNodeViews[i].contentHash
                let oldContentHash = nodeViewDataSource.getData(i).contentHash

                // 唯一ID是否相同
                if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                    if (refreshNodeViews[i].node is BulletList || refreshNodeViews[i].node is OrderedList) {
                        // 有序列表和无序列表
                        let cache = markdownCacheConfiguration.listComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is IndentedCodeBlock) {
                        // 缩进代码
                        let cache = markdownCacheConfiguration.indentedCodeComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is FencedCodeBlock) {
                        // 围栏代码
                        let cache = markdownCacheConfiguration.fencedCodeComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is Heading) {
                        // 标题
                        let cache = markdownCacheConfiguration.headingComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is Paragraph) {
                        // 段落
                        let cache = markdownCacheConfiguration.paragraphComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is TableBlock) {
                        // 表格
                        let cache = markdownCacheConfiguration.tableComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is BlockQuote) {
                        // 块引用
                        let cache = markdownCacheConfiguration.quoteComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else {
                        nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                    }
                } else if (newBlockHash == oldBlockHash && newContentHash == oldContentHash) {
                }
            }
        } else {
            // 新数据小于页面数据
            // 循环判断历史数据有没有做过修改
            for (i in 0..refreshNodeViewSize) {
                let newBlockHash = refreshNodeViews[i].nodeHash
                let oldBlockHash = nodeViewDataSource.getData(i).nodeHash
                let newContentHash = refreshNodeViews[i].contentHash
                let oldContentHash = nodeViewDataSource.getData(i).contentHash
                // 唯一ID是否相同
                if (newBlockHash != oldBlockHash && newContentHash != oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash != oldBlockHash && newContentHash == oldContentHash) {
                    nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                } else if (newBlockHash == oldBlockHash && newContentHash != oldContentHash) {
                    if (refreshNodeViews[i].node is BulletList || refreshNodeViews[i].node is OrderedList) {
                        // 有序列表和无序列表
                        let cache = markdownCacheConfiguration.listComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is IndentedCodeBlock) {
                        // 缩进代码
                        let cache = markdownCacheConfiguration.indentedCodeComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is FencedCodeBlock) {
                        // 围栏代码
                        let cache = markdownCacheConfiguration.fencedCodeComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is Heading) {
                        // 标题
                        let cache = markdownCacheConfiguration.headingComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is Paragraph) {
                        // 段落
                        let cache = markdownCacheConfiguration.paragraphComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is TableBlock) {
                        // 表格
                        let cache = markdownCacheConfiguration.tableComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else if (refreshNodeViews[i].node is BlockQuote) {
                        // 块引用
                        let cache = markdownCacheConfiguration.quoteComponents.get(newBlockHash)
                        if (let Some(v) <- cache) {
                            v.refreshData(refreshNodeViews[i])
                        }
                    } else {
                        nodeViewDataSource.replaceData(i, refreshNodeViews[i])
                    }
                } else if (newBlockHash == oldBlockHash && newContentHash == oldContentHash) {
                }
            }
            // 循环删除多余的旧数据
            for (i in dataSourceSize - 1..=refreshNodeViewSize : -1) {
                nodeViewDataSource.deleteData(i)
            }
        }
    }
}
