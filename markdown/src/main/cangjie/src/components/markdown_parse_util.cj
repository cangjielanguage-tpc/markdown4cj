/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 通过异步的方式将markdown数据解析成Node树节点列表
 *
 * @param mdStr markdown数据
 * @param markdownConfiguration MarkdownConfiguration
 * @param callback Node树节点列表回调接口
 */
func stringToNodesUtils(mdStr: String, markdownConfiguration: MarkdownConfiguration, callback: (ArrayList<NodeView>) -> Unit): Future<Unit>{
    let fut: Future<Unit> = spawn {
        try {
            let markdown: Markdown = if (let Some(v) <- markdownConfiguration.markdownParser) {
                v
            } else {
                Markdown.builder()
                    // 任务列表插件
                    .usePlugin(TaskListPlugin.create())
                    // 删除线插件
                    .usePlugin(StrikethroughPlugin.create())
                    // 表格插件
                    .usePlugin(TablePlugin.create())
                    // 幻灯片、视频、ImageStyle插件
                    .usePlugin(ImagePlugin.create())
                    // 代码标签
                    .usePlugin(CodeListPlugin.create())
                    // 数学公式
                    .usePlugin(LatexMathPlugin.create())
                    // 链接
                    .usePlugin(LinkifyPlugin.create())
                    // TOC列表插件
                    .usePlugin(TocPlugin.create())
                    .build()
            }
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let node: CommonmarkNode = markdown.parse(mdStr)
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let nodeView: NodeView = markdown.render(node)
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            callback(nodeView.children)
        } catch (e: Exception) {
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let arrayListNodeView: ArrayList<NodeView> = ArrayList<NodeView>()
            let paragraph: Paragraph = Paragraph()
            let commonmarkText: CommonmarkText = CommonmarkText(mdStr)
            paragraph.appendChild(commonmarkText)
            let paragraphNodeView: NodeView = buildView(paragraph, true)
            let textNodeView: NodeView = buildView(commonmarkText, true)
            arrayListNodeView.append(paragraphNodeView)
            callback(arrayListNodeView)
        }
    }
    return fut
}

/**
 * 通过异步的方式将代码转换成带有颜色的列表 - 围栏代码、缩进代码
 *
 * @param code 传入代码内容
 * @param info 传入代码类型
 * @param prismTheme 传入的高亮样式
 * @param callback PrismNodesParseRes列表回调接口
 */
func stringToResList(code: String, info: ?String, prismTheme: PrismTheme, callback: (ArrayList<PrismNodesParseRes>) -> Unit): Future<Unit>{
    let fut: Future<Unit> = spawn {
        try {
            var prism: Prism = Prism(GrammarLocatorGrammarUtils())
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            var psh: PrismSyntaxHighlight = PrismSyntaxHighlight.create(prism, prismTheme)
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let prismNodesParseResList: ArrayList<PrismNodesParseRes> = psh.highlight(info, code.trimRight("\n"))
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            callback(prismNodesParseResList)
        } catch (e: Exception) {
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let prismNodesParseResList: ArrayList<PrismNodesParseRes> = ArrayList<PrismNodesParseRes>()
            let prismNodesParseRes: PrismNodesParseRes = PrismNodesParseRes("", code, Option<String>.None, Option<Color>.None)
            prismNodesParseResList.append(prismNodesParseRes)
            callback(prismNodesParseResList)
        }
    }
    return fut
}

/**
 * 通过异步的方式将代码转换成带有颜色的列表 - 组合代码
 *
 * @param codeBlockListNodeView 传入围栏代码列表的NodeView
 * @param markdownConfiguration 传入MarkdownConfiguration
 * @param callback PrismNodesParseResState列表的列表回调接口
 * @param strText 代码列表数据
 * @return 返回PrismNodesParseResState列表的列表，返回代码类型的类型，返回代码内容列表，返回第一条数据内容
 */
func stringToResLists(codeBlockListNodeView: NodeView, markdownConfiguration: MarkdownConfiguration, strText: ArrayList<String>, callback: (ArrayList<ArrayList<PrismNodesParseRes>>) -> Unit): Future<Unit> {
    let fut: Future<Unit> = spawn {
       try {
            var prismNodesParseResLists: ArrayList<ArrayList<PrismNodesParseRes>> = ArrayList<ArrayList<PrismNodesParseRes>>()
            for (nodeView in codeBlockListNodeView.children) {
                if (nodeView.node is FencedCodeBlock) {
                    var prism: Prism = Prism(GrammarLocatorGrammarUtils())
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    var psh: PrismSyntaxHighlight = PrismSyntaxHighlight.create(prism, markdownConfiguration.prismTheme)
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    let res: ArrayList<PrismNodesParseRes> = psh.highlight((nodeView.node as FencedCodeBlock)().getInfo(),
                        (nodeView.node as FencedCodeBlock)().getLiteral().trimRight("\n"))
                    if (Thread.currentThread.hasPendingCancellation) {
                        return
                    }
                    prismNodesParseResLists.append(res)
                }
            }
            callback(prismNodesParseResLists)
       } catch (e: Exception) {
            if (Thread.currentThread.hasPendingCancellation) {
                return
            }
            let prismNodesParseResLists: ArrayList<ArrayList<PrismNodesParseRes>> =  ArrayList<ArrayList<PrismNodesParseRes>>()
            for(str in  strText){
                let prismNodesParseResList:ArrayList<PrismNodesParseRes> = ArrayList<PrismNodesParseRes>()
                let prismNodesParseRes:PrismNodesParseRes = PrismNodesParseRes("", str, Option<String>.None, Option<Color>.None)
                prismNodesParseResList.append(prismNodesParseRes)
                prismNodesParseResLists.append(prismNodesParseResList)
            }
            callback(prismNodesParseResLists)
       }
    }
    return fut
}

