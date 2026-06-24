import { hilog } from '@kit.PerformanceAnalysisKit';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import {
  printNode,
  JsNode
} from '../../../../Index';
import { parseIntoJsNode } from './md'
import { errjson } from './md1';
import { err2 } from './md2';
import { md_latex_1 } from './md3';

export default function bugTest() {
  describe('bugTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })
    it('bug1', 0, async () => {
      let doc:JsNode = await parseIntoJsNode(errjson, 2)
      let str = printNode(doc)
      console.error(str)
    })
    it('bug2', 0, async () => {
      let doc:JsNode = await parseIntoJsNode(err2, 2)
      let str = printNode(doc)
      console.error(str)
    })
    it('bugLatex1', 0, async () => {
      let md = `\\[
asd
\\]`
      let doc:JsNode = await parseIntoJsNode(md, 2)
      let str = printNode(doc)
      console.error(md)
      console.error(str)
      let latex: JsNode = doc.firstChild!
      expect(latex.nodeType).assertEqual("LatexMathBlock")
      expect(latex['latex']).assertEqual("asd")
    })
    it('bugLatex2', 0, async () => {
      let md = `$$
asd
$$`
      let doc :JsNode= await parseIntoJsNode(md, 2)
      let str = printNode(doc)
      console.error(str)
      let latex: JsNode = doc.firstChild!
      expect(latex.nodeType).assertEqual("LatexMathBlock")
      expect(latex['latex']).assertEqual("asd")
    })
    it('bugLatex3', 0, async () => {
      let md = `4. $$a$$ 应该渲染成 $b$`
      let doc:JsNode = await parseIntoJsNode(md, 2)
      let str = printNode(doc)
      console.error(str)
      let p : JsNode|undefined= doc.firstChild?.firstChild?.firstChild
      let latexa: JsNode = p?.firstChild!
      expect(latexa.nodeType).assertEqual("LatexMathNode")
      let latexb: JsNode = p?.lastChild!
      expect(latexb['latex']).assertEqual("b")
    })
    it('bugLatex_isCosed', 0, async () => {
      let md = `
- **原理**：矩阵乘法在对角矩阵上是对角线元素对应相乘
  $$ D D^{-1} = \text{diag}(d_1 \cdot \frac{1}{d_1}, d_2 \cdot \frac{1}{d_2}, \dots, d_n \cdot \frac{1}{d_n}) = \text{diag}(1, 1, \dots, 1) = I_n $$
- **结论**：逆矩阵确实存在，且为 $D^{-1} = \text{diag}(d_1^{-1}, d_2^{-1}, \dots, d_n^{-1})$


- **对角矩阵的乘法特点**：两个对角矩阵相乘，结果仍是对角矩阵，且**对角线元素就是对应位置元素的乘积**
  $$\begin{pmatrix} a_1 & 0 \\ 0 & a_2 \end{pmatrix} \begin{pmatrix} b_1 & 0 \\ 0 & b_2 \end{pmatrix} = \begin{pmatrix} a_1b_1 & 0 \\ 0 & a_2b_2 \end{pmatrix}$$`
      let doc :JsNode= await parseIntoJsNode(md, 2)
      let str = printNode(doc)
      console.error(str)
      let list = doc.firstChild!
      let latexb1: JsNode = list.firstChild?.lastChild!
      expect(latexb1.nodeType).assertEqual("LatexMathBlock")
      expect(latexb1[`isClosed`]).assertEqual(true)
      let latex2: JsNode = list.firstChild?.next?.firstChild?.lastChild!
      expect(latex2.nodeType).assertEqual("LatexMathNode")
      let latexb2: JsNode = list.lastChild?.lastChild!
      expect(latexb2.nodeType).assertEqual("LatexMathBlock")
      expect(latexb2[`isClosed`]).assertEqual(true)
    })
    it('table1', 0, async () => {
      let md = `| h1 | h2 | h3 | h4  |
|:---|---:|:---:|--|
| a | b | c | d |`
      let doc :JsNode= await parseIntoJsNode(md, 2)
      let str = printNode(doc)
      console.error(str)
      let table: JsNode = doc.firstChild!
      let head: JsNode = doc.firstChild?.firstChild?.firstChild!
      let body1: JsNode = doc.firstChild?.lastChild?.firstChild!
      expect(table.nodeType).assertEqual("TableBlock")
      expect(head.firstChild!['alignment']).assertEqual("LEFT")
      expect(head.firstChild!['width']).assertEqual(4)
      expect(head.lastChild!['alignment']).assertEqual(undefined)
      expect(head.lastChild!['width']).assertEqual(2)
      expect(head.lastChild?.previous!['alignment']).assertEqual("CENTER")
      expect(head.lastChild?.previous!['width']).assertEqual(5)
      expect(body1.firstChild!['alignment']).assertEqual("LEFT")
      expect(body1.firstChild!['width']).assertEqual(4)
      expect(body1.lastChild!['alignment']).assertEqual(undefined)
      expect(body1.lastChild!['width']).assertEqual(2)
      expect(body1.lastChild?.previous!['alignment']).assertEqual("CENTER")
      expect(body1.lastChild?.previous!['width']).assertEqual(5)
    })
    it('auto_link1', 0, async () => {
      let md = `在：https://biso6df2x4pkw.ok.kimi.link 啊在：https://biso6df2x4pkw.ok.kimi.link 啊`
      let doc:JsNode = await parseIntoJsNode(md, 2)
      let str = printNode(doc)
      console.error(str)
      let p: JsNode = doc.firstChild!
      let text0: JsNode = p.firstChild!
      let link1: JsNode = text0.next!
      let text2: JsNode = link1.next!
      let link3: JsNode = text2.next!
      let text4: JsNode = p.lastChild!
      expect(text0.nodeType).assertEqual("Text")
      expect(link1.nodeType).assertEqual("Link")
      expect(text2.nodeType).assertEqual("Text")
      expect(link3.nodeType).assertEqual("Link")
      expect(text4.nodeType).assertEqual("Text")
    })
    it('auto_link2', 0, async () => {
      let md = `已部署至https://7sncmf6ezkojw.ok.kimi.link，可直接访问查看完`
      let doc:JsNode = await parseIntoJsNode(md, 2)
      let str = printNode(doc)
      console.error(str)
      let p: JsNode = doc.firstChild!
      let text0: JsNode = p.firstChild!
      let link1: JsNode = text0.next!
      let text2: JsNode = link1.next!
      expect(text0.nodeType).assertEqual("Text")
      expect(text0.literal).assertEqual("已部署至")
      expect(link1.nodeType).assertEqual("Link")
      expect(link1.destination).assertEqual("https://7sncmf6ezkojw.ok.kimi.link")
      expect(text2.nodeType).assertEqual("Text")
      expect(text2.literal).assertEqual("，可直接访问查看完")
    })
    it('delimiter1', 0, async () => {
      let md = `**WARNING：**DON'T TOUCH THE CHILD # NOT WORKING`
      let doc: JsNode = await parseIntoJsNode(md, 2)
      let str = printNode(doc)
      console.error(str)
      let p: JsNode = doc.firstChild!
      let strong0: JsNode = p.firstChild!
      let text1: JsNode = strong0.next!
      expect(strong0.nodeType).assertEqual("StrongEmphasis")
      expect(strong0.firstChild!.literal).assertEqual("WARNING：")
      expect(text1.nodeType).assertEqual("Text")
      expect(text1.literal).assertEqual("DON'T TOUCH THE CHILD # NOT WORKING")
    })
    it('delimiter2', 0, async () => {
      let md = `**WARNING,**DON'T TOUCH THE CHILD # NOT WORKING`
      let doc: JsNode = await parseIntoJsNode(md, 2)
      let str = printNode(doc)
      console.error(str)
      let p: JsNode = doc.firstChild!
      let strong0: JsNode = p.firstChild!
      let text00: JsNode = strong0.firstChild!
      expect(strong0.nodeType).assertEqual("StrongEmphasis")
      expect(text00.nodeType).assertEqual("Text")
      expect(text00.literal).assertEqual("WARNING,")
    })
    it('delimiter3', 0, async () => {
      let md = `**[阿克西奥斯]**（/ˈæksɪɒs/）`
      let doc:JsNode = await parseIntoJsNode(md, 2)
      let str = printNode(doc)
      console.error(str)
      let p: JsNode = doc.firstChild!
      let strong0: JsNode = p.firstChild!
      let text1: JsNode = p.lastChild!
      expect(strong0.nodeType).assertEqual("StrongEmphasis")
      expect(strong0.firstChild!.nodeType).assertEqual("Text")
      expect(strong0.firstChild!.literal).assertEqual("[阿克西奥斯]")
      expect(text1.nodeType).assertEqual("Text")
      expect(text1.literal).assertEqual("（/ˈæksɪɒs/）")
    })
    it('formula1', 0, async () => {
      let md = `设 $V$ 是`
      md = md_latex_1
      md = `设 $V$ 是三维空间中的有界闭区域，其边界 $\partial V$ 是光滑（或分片光滑）的闭合曲面，$\mathbf{F}(x,y,z) = (P, Q, R)$ 是在 $V$ 上连续可微的向量场，则：

$$
\iint_{\partial V} \mathbf{F} \cdot d\mathbf{S} = \iiint_V (\nabla \cdot \mathbf{F}) \, dV
$$`
      let doc: JsNode = await parseIntoJsNode(md, 2)
      let str = printNode(doc)
      console.error(str)
      let p: JsNode = doc.firstChild!
      let text0: JsNode = p.firstChild!
      let latex1: JsNode = text0.next!
      let text2: JsNode = latex1.next!
      let latex3: JsNode = text2.next!
      let text4: JsNode = latex3.next!
      let latex5: JsNode = text4.next!
      let text6: JsNode = latex5.next!
      let latex7: JsNode = text6.next!
      let text8: JsNode = latex7.next!
      expect(text0.nodeType).assertEqual(`Text`)
      expect(latex1.nodeType).assertEqual(`LatexMathNode`)
      expect(latex1.latex).assertEqual(`V`)
      expect(text2.nodeType).assertEqual(`Text`)
      expect(latex3.nodeType).assertEqual(`LatexMathNode`)
      expect(latex3.latex).assertEqual(`\partial V`)
      expect(text4.nodeType).assertEqual(`Text`)
      expect(latex5.nodeType).assertEqual(`LatexMathNode`)
      expect(latex5.latex).assertEqual(`\mathbf{F}(x,y,z) = (P, Q, R)`)
      expect(text6.nodeType).assertEqual(`Text`)
      expect(latex7.nodeType).assertEqual(`LatexMathNode`)
      expect(latex7.latex).assertEqual(`V`)
      expect(text8.nodeType).assertEqual(`Text`)
      let latexBlock: JsNode = doc.lastChild!
      expect(latexBlock.nodeType).assertEqual(`LatexMathBlock`)
      expect(latexBlock.latex).assertEqual(`\iint_{\partial V} \mathbf{F} \cdot d\mathbf{S} = \iiint_V (\nabla \cdot \mathbf{F}) \, dV`)
    })
  })
}
