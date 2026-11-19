// RESOURCES: spec.md
// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: pwsh -command "cp ../../../target/release/markdown_parser/*.dll ."
// EXEC: pwsh -command "cp ../../../target/release/commonmark4cj/*.dll ."
// EXEC: ./main 
//--filter=test3
import std.runtime.*

let markdown: Markdown = Markdown
    .builder()
    // HTML插件
    .usePlugin(HtmlPlugin.create())
    // 任务列表插件
    .usePlugin(TaskListPlugin.create())
    // 删除线插件
    .usePlugin(StrikethroughPlugin.create())
    // 表格插件
    .usePlugin(TablePlugin.create())
    // 数学公式
    .usePlugin(LatexMathPluginV2.create())
    // 音频
    .usePlugin(BlockAudioPlugin.create())
    // 视频
    .usePlugin(BlockVideoPlugin.create())
    // 链接
    // .usePlugin(LinkViewPlugin.create())
    // 脚注
    .usePlugin(FootnotePlugin.create())
    // 图片列表
    .usePlugin(ImageCollectPlugin.create())
    .usePlugin(NodeIdPlugin.create())
    .usePlugin(LinkifyPlugin.create())
    .usePlugin(ImageTextMixPlugin.create())
    .usePlugin(TocPlugin.create())
    .usePlugin(IdHeadingPlugin.create())
    .usePlugin(DescListPlugin.create())
    .build()

@Test
public func test0(): Unit {
    var str = #"
a
sd
"#
    var nv1 = markdown.render(markdown.parse(str))
    printNode(nv1)
    str = #"
a
sd1
"#
    var nv2 = markdown.render(markdown.parse(str))
    printNode(nv2)

    @Assert(nv1[0].getProp<Int64>("nodeHash").getOrThrow(),nv2[0].getProp<Int64>("nodeHash").getOrThrow())
}
@Test
public func test1(): Unit {
    var str = #"
| c1 | c2 |
| - | - |
| r1c1 | r1c2 |
"#
    var nv1 = markdown.render(markdown.parse(str))
    printNode(nv1)
    str = #"
| c1 | c2 |
| - | - |
| r1c1 | r1c2 |
|
"#
    var nv2 = markdown.render(markdown.parse(str))
    printNode(nv2)

    @Assert(nv1[0].getProp<Int64>("nodeHash").getOrThrow(),nv2[0].getProp<Int64>("nodeHash").getOrThrow())
}
@Test
public func test2(): Unit {
    var str = #"
*  Open the file.
*  Find the following code block on line 21
"#
    var nv1 = markdown.render(markdown.parse(str))
    printNode(nv1)
    str = #"
*  Open the file.
*  Find the following code block on line 21:

   | a
"#
    var nv2 = markdown.render(markdown.parse(str))
    printNode(nv2)

    @Assert(nv1[0].getProp<Int64>("nodeHash").getOrThrow(),nv2[0].getProp<Int64>("nodeHash").getOrThrow())
}
@Test
public func test3(): Unit {
    var str = #"
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
"#
    var nv1 = markdown.render(markdown.parse(str))
    printNode(nv1)
    str = #"
1. 然后，将整理好的内容编写成适合视频配音的文案，并生成视频标题
2. 最终为视频添加背景音乐
3. 根据生图提示词生成相应的图片
4. 接着，将视频文案拆分成分镜脚本，包括视频台词和生图提示词
5. 将图片转化为视频
6. 为视频台词生成配音
7. 获取适合的背景音乐
8. 为视频添加配音和字幕
9. 将多段视频拼接成一个完整视频
10. 首先，我将搜索西汉王朝的历史信息，整理成文字内容
"#
    var nv2 = markdown.render(markdown.parse(str))
    printNode(nv2)

    @Assert(nv1[0].getProp<Int64>("nodeHash").getOrThrow(),nv2[0].getProp<Int64>("nodeHash").getOrThrow())
}




public class NodeIdPlugin1 <: AbstractMarkdownPlugin {
    public static func create(): NodeIdPlugin1 {
        return NodeIdPlugin1()
    }

    public override func afterRender(doc: Node, _: MarkdownVisitor): Unit {
        calcNodeIdWithLoop(doc)
    }

    public func getClassType(): String {
        "NodeIdPlugin"
    }

    let stack = ArrayList<NodeHashCalculator>()

    func calcNodeIdWithLoop(rootNode: Node): Unit {
        stack.add(NodeHashCalculator(rootNode, None, 0))

        while (stack.size > 0) {
            let parent = stack[stack.size - 1]
            let childIndex = parent.childIndex
            if (childIndex < parent.node.childrenSize) {
                let child = parent.node[childIndex]
                let childHasher = NodeHashCalculator(child, parent, childIndex)
                if (child.childrenSize > 0) {
                    // 保存当前状态，然后处理子节点
                    stack.add(childHasher)
                } else {
                    // 没有子节点
                    childHasher.finish()
                }
            } else {
                // 所有子节点处理完毕，处理父节点
                parent.finish()
                stack.remove(at: stack.size - 1)
            }
        }
    }
}

/**
 * 用于计算node的nodeHash/contentHash
 * init时
 *     - 计算nodeHash
 * finish时
 *     - 写入nodeHash/contentHash
 *     - 更新parent.contentHash
 *     - 更新parent的childIndex
 */
class NodeHashCalculator {
    var childIndex = 0 // 当前遍历到node的第几个子节点
    var nodeHasher = DefaultHasher() // 用于计算node的nodeHash
    var posionHasher = DefaultHasher() // 用于计算node的posistion的nodeHash
    var contentHasher = DefaultHasher() // 用于计算node的contentHash
    NodeHashCalculator(
        let node: Node, /* 当前节点 */
        let parent: ?NodeHashCalculator, /* 父节点 */
        let index: Int /* node属于parent的第几个子节点 */
    ) {
        // 根据parent.position/index 计算position
        posionHasher.write(parent?.posionHasher.finish() ?? 0)
        posionHasher.write(index)

        // 根据node.porpString 计算基础contentHash
        contentHasher.write(match (node) {
            case v: NodeHash => v.propString()
            case _ => node.toString()
        })

        // 根据position/NodeType 计算nodeHash
        nodeHasher.write(posionHasher.finish())
        nodeHasher.write(node.getNodeType())
    }

    /**
     * 累加contentHash
     */
    @OverflowWrapping
    func accumulate(hash: Int): Unit {
        this.contentHasher.write(hash)
    }

    /**
     * 写入nodeHash/contentHash
     * 将node.contentHash累加到parent.contentHash
     * 更新parent.childIndex
     */
    func finish(): Unit {
        node.addProp("nodeHash", nodeHasher.finish())
        node.addProp("contentHash", contentHasher.finish())
        if (let Some(p) <- parent) {
            p.accumulate(contentHasher.finish())
            p.childIndex += 1
        }
    }
}
