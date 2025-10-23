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
import markdown.core.NodeView
import markdown.plugin.*
import markdown.core.*
import commonmark4cj.commonmark.Heading
import commonmark4cj.commonmark.Paragraph
import commonmark4cj.commonmark.Image as CommonmarkImage
import commonmark4cj.commonmark.Node as CommonmarkNode
import commonmark4cj.commonmark.PostProcessor
import commonmark4cj.commonmark.AbstractVisitor
import commonmark4cj.commonmark.ParserBuilder

/**
 *
 */
@Entry
@Component
class UIADDetailsPage {
    /**
     * markdown文本
     */
    @State
    var mdStr = ""

    /**
     * 文件名
     */
    @State
    var params = ""

    /**
     * 流式markdown文本
     */
    @State
    var output: String = ""

    /**
     * 一次加载文本个数
     */
    @State
    var number: Int64 = 10

    /**
     * 延时时间
     */
    @State
    var sleepTime: Int64 = 100

    /**
     * 滑动控制器
     */
    var scroller: Scroller = Scroller()

    /**
     * rawfile文件夹列表
     */
    @State
    var folderList: ObservedArrayList<String> = ObservedArrayList<String>()

    protected override func aboutToAppear(): Unit {
        params = (Router.getParams().getOrThrow() as String).getOrThrow()
        mdStr = getFileContextStr(params)
    }

    func build() {
        Column() {
            titleComponent(
                params,
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
                    => output = mdStr
                }
            Scroll(scroller) {
                Column {
                    MarkdownComponent(
                        output: output,
                        markdownPlugin: setPlugin(),
                        adBuilder: ADBuilder
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

    @Builder
    func ADBuilder(item: NodeView){
        Text("这是广告")
    }

    func setPlugin(): Markdown {
        var markdownPlugin: Markdown = Markdown
            .builder()
            // 广告插件
            .usePlugin(BlockADPlugin.create())
            .build()
        return markdownPlugin
    }
}

public class BlockADPlugin <: ADPlugin {
    public static func create(): BlockADPlugin {
        return BlockADPlugin()
    }

    public override func configureParser(builder: ParserBuilder): Unit {
        builder.postProcessor(BlockADProcessor())
    }
}

class BlockADProcessor <: PostProcessor {
    public func process(node: CommonmarkNode): CommonmarkNode {
        node.accept(BlockADVisitor())
        node
    }
}

func isAudio(destination: String): Bool {
    var k = destination.lastIndexOf(b'?') ?? destination.size
    let dest = destination[..k]
    let i = dest.lastIndexOf(b'.') ?? return false
    return match (dest[i..]) {
        case '.mp3' | '.wav' | '.aac' | '.flac' | '.ogg' | '.m4a' | '.wma' | '.amr' => return true
        case _ => false
    }
}

class BlockADVisitor <: AbstractVisitor {
    public func visit(p: Heading): Unit {
        visit(
            p,
            {
                =>
                let h = Heading()
                h.setLevel(p.getLevel())
                return h
            }
        )
    }
    public func visit(p: Paragraph): Unit {
        visit(p, {=> Paragraph()})
    }
    public func visit(blockNode: CommonmarkNode, newBlock: () -> CommonmarkNode): Unit {
        var p = blockNode
        var current: ?CommonmarkNode = p.getFirstChild()
        while (let Some(n) <- current) {
            current = n.getNext()
            match (n) {
                case n: CommonmarkImage where isAudio(n.getDestination()) =>
                    let oldp = p
                    // 提取Audio
                    n.unlink()
                    let block = BlockAD()
                    block.appendChild(n)
                    p.insertAfter(block)
                    // 分割后续paragraph.children
                    if (let Some(c) <- current) {
                        let newp = newBlock()
                        var n1: ?CommonmarkNode = current
                        while (let Some(n11) <- n1) {
                            n1 = n11.getNext()
                            n11.unlink()
                            newp.appendChild(n11)
                        }
                        block.insertAfter(newp)
                        p = newp
                    }
                    // 清理空p
                    if (oldp.getFirstChild().isNone()) {
                        oldp.unlink()
                    }
                case _ => ()
            }
        }
    }
}
