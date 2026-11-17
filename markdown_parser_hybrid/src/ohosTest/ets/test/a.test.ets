import { hilog } from '@kit.PerformanceAnalysisKit';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import {
  JsNode, Options, printNode, JsNodeImpl, JsNodeSendableImpl, JsNodeTreeBuilder,
} from '../../../../Index';
import { getParser, parser } from './md'

export default function aTest() {
  describe('aTest', () => {
    beforeAll(() => {
    })
    beforeEach(() => {
    })
    afterEach(() => {
    })
    afterAll(() => {
    })
    it('footnote1', 0, async () => {
      let md = `- [^2^]: [异环NTE：免费开放世界RPG封闭测试](https://cg.163.com/static/content/69895252326700b55b0d178b)
- [^1^]: [百度百科 - 异环](https://baike.baidu.com/item/异环)`
      let parser = getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilder(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0,
        FootnotePlugin: true
      })
      let doc = await parser.parse(md)
      let str = printNode(doc)
      console.error(str)
      let p: JsNode = doc.firstChild!
      let node0: JsNode = p.firstChild!.firstChild!
      let node1: JsNode = p.lastChild!.firstChild!
      expect(node0.nodeType).assertEqual("FootnoteBlock")
      expect(node0.firstChild!.lastChild!.destination)
        .assertEqual("https://cg.163.com/static/content/69895252326700b55b0d178b")
      expect(node1.nodeType).assertEqual("FootnoteBlock")
      expect(node1.firstChild!.lastChild!.destination).assertEqual("https://baike.baidu.com/item/异环")
    })
    it('footnote2', 0, async () => {
      let md = `## 参考资料

- [^1^]: [百度百科 - 异环](https://baike.baidu.com/item/异环/64656910)
- [^2^]: [异环NTE：免费开放世界RPG封闭测试](https://cg.163.com/static/content/69895252326700b55b0d178b)
- [^3^]: [异环WIKI - 哔哩哔哩](https://wiki.biligame.com/yh/首页)
- [^4^]: [完美世界收获"二连板" 自研游戏《异环》测试表现亮眼](https://www.stcn.com/article/detail/3635940.html)
- [^5^]: [德国科隆，进入"中国时间"](http://mp.weixin.qq.com/s?__biz=MjM5MjMwMjcyMA==)`
      let parser = getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilder(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0
      })
      let doc = await parser.parse(md)
      let str = printNode(doc)
      console.error(str)
    })
    it('linkify1', 0, async () => {
      let md = `这是一个带中文的链接：
https://www.wanuxi.com/为美好的世界献上祝福第三季主视觉图公开
你好`
      let doc = await parser.parse(md)
      let str = printNode(doc)
      console.error(str)
      expect(doc.firstChild!.firstChild!.next!.next!.destination)
        .assertEqual("https://www.wanuxi.com/")
    })
    it('StyleImage1', 0, async () => {
      let md = `1111![示例图](https://markdown.com.cn/images/blue.jpg){:width=200}1111`
      let doc = await getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilder(),
        includeSourceSpans: 2,
        ImageStylePlugin: true
      }).parse(md)
      let str = printNode(doc)
      console.error(str)
      expect(doc.firstChild!.firstChild!.next!.nodeType).assertEqual("StyleImage")
    })
    it('HtmlSpan1', 0, async () => {
      let md = `<span style="color: red;"> 红色标签 </span>`
      let doc = await parser.parse(md)
      let str = printNode(doc)
      console.error(str)
      let span = doc.firstChild!.firstChild as JsNodeImpl
      expect(span.nodeType).assertEqual("SpanNode")
      expect(span.SpanNodeStyle?.get('color')).assertEqual("red")
    })
    it('buildNodesProtocol', 0, () => {
      // 批量协议一致性: 同构树分别用 buildNodes 扁平事件与旧逐节点 API 构建, 结果必须完全一致。
      // 事件覆盖全部 8 种标记, 含 addSourceSpans 的 count 定界。
      let events: Array<string | number | boolean> = [
        '@b', 'document', 'doc',
          '@n', 8, 0, 0, 0, 5, 1, 2, 10, 3,
          '@b', 'paragraph', 'para',
            '@f', 'literal', 'hello',
            '@p', 'data-x', '1',
            '@a', 'href', 'https://a.com',
            '@s', 'color', 'red',
            '@i', 2, 'width=100', 'height=50',
            '@b', 'text', 'text',
              '@f', 'literal', 'hello',
            '@e',
          '@e',
        '@e'
      ]
      let batchBuilder = new JsNodeTreeBuilder()
      // buildNodes 为 rest 参数, 与仓颉侧 callMethod 展开传参语义一致, 直接调用需展开事件数组
      batchBuilder.buildNodes(...events)
      let batchRoot = batchBuilder.getRoot()

      let legacyBuilder = new JsNodeTreeBuilder()
      legacyBuilder.beginNode('document', 'doc')
      legacyBuilder.addSourceSpans(0, 0, 0, 5, 1, 2, 10, 3)
      legacyBuilder.beginNode('paragraph', 'para')
      legacyBuilder.setField('literal', 'hello')
      legacyBuilder.putProp('data-x', '1')
      legacyBuilder.putSpanNodeAttr('href', 'https://a.com')
      legacyBuilder.putSpanNodeStyle('color', 'red')
      legacyBuilder.putImageStyles('width=100', 'height=50')
      legacyBuilder.beginNode('text', 'text')
      legacyBuilder.setField('literal', 'hello')
      legacyBuilder.endNode()
      legacyBuilder.endNode()
      legacyBuilder.endNode()
      let legacyRoot = legacyBuilder.getRoot()

      let batchPara = batchRoot.firstChild as JsNodeImpl
      let batchText = batchPara.firstChild as JsNodeImpl
      expect(printNode(batchRoot)).assertEqual(printNode(legacyRoot))
      expect(batchPara.nodeType).assertEqual('paragraph')
      expect(batchPara.literal).assertEqual('hello')
      expect(batchPara.getProps()!.get('data-x')).assertEqual('1')
      expect(batchPara.SpanNodeStyle?.get('color')).assertEqual('red')
      expect(batchPara.SpanNodeAttr?.get('href')).assertEqual('https://a.com')
      expect(batchPara.ImageStyles!.length).assertEqual(2)
      expect(batchPara.ImageStyles![0]).assertEqual('width=100')
      expect(batchText.literal).assertEqual('hello')
      let spans = batchRoot.getSourceSpans()
      expect(spans.length).assertEqual(2)
      expect(spans[0].getLineIndex()).assertEqual(0)
      expect(spans[0].getColumnIndex()).assertEqual(0)
      expect(spans[0].getInputIndex()).assertEqual(0)
      expect(spans[0].getLength()).assertEqual(5)
      expect(spans[1].getLineIndex()).assertEqual(1)
      expect(spans[1].getColumnIndex()).assertEqual(2)
      expect(spans[1].getInputIndex()).assertEqual(10)
      expect(spans[1].getLength()).assertEqual(3)
    })
    it('buildNodesLargeDoc', 0, async () => {
      // 大文档分片: 单个 buildSubtree 事件数远超单次 buildNodes 上限(500),
      // 验证 flushIfFull 在事件边界拆分后协议仍自洽。
      // 无分块时数千实参的单次 callMethod 会触发 ark_interop JSInteropNativeError(进程闪退)。
      let md = ''
      for (let i = 0; i < 2000; i++) {
        md += '**加粗** 行内文本节点。'
      }
      let parser = getParser({
        jsNodeTreeBuilder: new JsNodeTreeBuilder(() => new JsNodeSendableImpl()),
        includeSourceSpans: 0
      })
      let doc = await parser.parse(md)
      let p: JsNode = doc.firstChild!
      expect(p.nodeType).assertEqual('Paragraph')
      // 不用 printNode 断言: 它递归遍历, 深兄弟链会爆栈; 改用迭代计数, 2000 组 = 2000 Strong + 2000 Text
      let count = 0
      let child = p.firstChild
      while (child !== undefined) {
        count++
        child = child.next
      }
      expect(count).assertEqual(4000)
    })
  })
}
