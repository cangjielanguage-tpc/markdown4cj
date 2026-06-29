import { hilog } from '@kit.PerformanceAnalysisKit';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import {
  JsNode, Options, printNode, JsNodeImpl, JsNodeSendableImpl,
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
        jsNodeFactory: () => new JsNodeSendableImpl(),
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
        jsNodeFactory: () => new JsNodeSendableImpl(),
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
        jsNodeFactory: () => new JsNodeImpl(),
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
  })
}
