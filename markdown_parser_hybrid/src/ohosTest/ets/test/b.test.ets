import { hilog } from '@kit.PerformanceAnalysisKit';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { testCJ } from 'libmarkdown_parser_hybrid.so';
import {
  utf16Index2utf8Index,
  utf8Index2utf16Index,
  printNode,
  JsNode
} from '../../../../Index';
import { parseIntoJsNode } from './md'

export default function bTest() {
  describe('bTest', () => {
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
    it('test_parse0_001', 0, async () => {
      let md = '我0123a56a89'
      let testNode:JsNode = await parseIntoJsNode(md, 0)
      expect(testNode.nodeType).assertEqual("Document")
      expect(testNode.previous).assertEqual(undefined)
      expect(testNode.firstChild?.nodeType).assertEqual("Paragraph")
      expect(testNode.lastChild?.nodeType).assertEqual("Paragraph")
      expect(testNode.parent?.nodeType).assertEqual(undefined)
      expect(testNode.next?.nodeType).assertEqual(undefined)
      expect(testNode.literal).assertEqual(undefined)
      expect(testNode.destination).assertEqual(undefined)
      expect(testNode.title).assertEqual(undefined)
      expect(testNode.label).assertEqual(undefined)
      expect(testNode.openingDelimiter).assertEqual(undefined)
      expect(testNode.closingDelimiter).assertEqual(undefined)
      expect(testNode.fenceChar).assertEqual(undefined)
      expect(testNode.fenceLength).assertEqual(undefined)
      expect(testNode.fenceIndent).assertEqual(undefined)
      expect(testNode.info).assertEqual(undefined)
      expect(testNode.isTight).assertEqual(undefined)
      expect(testNode.bulletMarker).assertEqual(undefined)
      expect(testNode.startNumber).assertEqual(undefined)
      expect(testNode.delimiter).assertEqual(undefined)
    })
    it('test_parse0_002', 0, async () => {
      let md = '我0123a56a89'
      let node :JsNode= await parseIntoJsNode(md, 0)
      let testNode = node.firstChild
      if (testNode == undefined) {
        expect().assertFail()
      } else {
        expect(testNode.nodeType).assertEqual("Paragraph")
        expect(testNode.previous).assertEqual(undefined)
        expect(testNode.firstChild?.nodeType).assertEqual("Text")
        expect(testNode.lastChild?.nodeType).assertEqual("Text")
        expect(testNode.parent?.nodeType).assertEqual("Document")
        expect(testNode.next?.nodeType).assertEqual(undefined)
        expect(testNode.literal).assertEqual(undefined)
        expect(testNode.destination).assertEqual(undefined)
        expect(testNode.title).assertEqual(undefined)
        expect(testNode.label).assertEqual(undefined)
        expect(testNode.openingDelimiter).assertEqual(undefined)
        expect(testNode.closingDelimiter).assertEqual(undefined)
        expect(testNode.fenceChar).assertEqual(undefined)
        expect(testNode.fenceLength).assertEqual(undefined)
        expect(testNode.fenceIndent).assertEqual(undefined)
        expect(testNode.info).assertEqual(undefined)
        expect(testNode.isTight).assertEqual(undefined)
        expect(testNode.bulletMarker).assertEqual(undefined)
        expect(testNode.startNumber).assertEqual(undefined)
        expect(testNode.delimiter).assertEqual(undefined)
      }
    })
    it('test_parse0_003', 0, async () => {
      let md = '我0123a56a89'
      let node01 :JsNode= await parseIntoJsNode(md, 0)
      let node02 :JsNode|undefined= node01.firstChild
      if (node02 == undefined || node02.firstChild == undefined) {
        expect().assertFail()
      } else {
        let testNode = node02.firstChild
        if (testNode == undefined) {
          expect().assertFail()
        } else {
          expect(testNode.nodeType).assertEqual("Text")
          expect(testNode.previous).assertEqual(undefined)
          expect(testNode.firstChild?.nodeType).assertEqual(undefined)
          expect(testNode.lastChild?.nodeType).assertEqual(undefined)
          expect(testNode.parent?.nodeType).assertEqual("Paragraph")
          expect(testNode.next?.nodeType).assertEqual(undefined)
          expect(testNode.literal).assertEqual("我0123a56a89")
          expect(testNode.destination).assertEqual(undefined)
          expect(testNode.title).assertEqual(undefined)
          expect(testNode.label).assertEqual(undefined)
          expect(testNode.openingDelimiter).assertEqual(undefined)
          expect(testNode.closingDelimiter).assertEqual(undefined)
          expect(testNode.fenceChar).assertEqual(undefined)
          expect(testNode.fenceLength).assertEqual(undefined)
          expect(testNode.fenceIndent).assertEqual(undefined)
          expect(testNode.info).assertEqual(undefined)
          expect(testNode.isTight).assertEqual(undefined)
          expect(testNode.bulletMarker).assertEqual(undefined)
          expect(testNode.startNumber).assertEqual(undefined)
          expect(testNode.delimiter).assertEqual(undefined)
        }
      }
    })
    it('test_parse1_notEmptyParser_001', 0, async () => {
      let md = '<a>fsfsfsddfdsfabd</a>'
      let testNode:JsNode= await parseIntoJsNode(md, 0)
      expect(testNode.nodeType).assertEqual("Document")
      expect(testNode.previous).assertEqual(undefined)
      expect(testNode.firstChild?.nodeType).assertEqual("Paragraph")
      expect(testNode.lastChild?.nodeType).assertEqual("Paragraph")
      expect(testNode.parent?.nodeType).assertEqual(undefined)
      expect(testNode.next?.nodeType).assertEqual(undefined)
      expect(testNode.literal).assertEqual(undefined)
      expect(testNode.destination).assertEqual(undefined)
      expect(testNode.title).assertEqual(undefined)
      expect(testNode.label).assertEqual(undefined)
      expect(testNode.openingDelimiter).assertEqual(undefined)
      expect(testNode.closingDelimiter).assertEqual(undefined)
      expect(testNode.fenceChar).assertEqual(undefined)
      expect(testNode.fenceLength).assertEqual(undefined)
      expect(testNode.fenceIndent).assertEqual(undefined)
      expect(testNode.info).assertEqual(undefined)
      expect(testNode.isTight).assertEqual(undefined)
      expect(testNode.bulletMarker).assertEqual(undefined)
      expect(testNode.startNumber).assertEqual(undefined)
      expect(testNode.delimiter).assertEqual(undefined)
    })
    it('test_parse1_notEmptyParser_002', 0, async () => {
      let md = '<a>fsfsfsddfdsfbd</a>'
      let node:JsNode= await parseIntoJsNode(md, 0)
      console.error(printNode(node))
      let testNode = node.firstChild
      if (testNode == undefined) {
        expect().assertFail()
      } else {
        expect(testNode.nodeType).assertEqual("Paragraph")
        expect(testNode.previous).assertEqual(undefined)
        // expect(testNode.firstChild?.nodeType).assertEqual("HtmlInline")
        // expect(testNode.lastChild?.nodeType).assertEqual("HtmlInline")
        expect(testNode.parent?.nodeType).assertEqual("Document")
        expect(testNode.next?.nodeType).assertEqual(undefined)
        expect(testNode.literal).assertEqual(undefined)
        expect(testNode.destination).assertEqual(undefined)
        expect(testNode.title).assertEqual(undefined)
        expect(testNode.label).assertEqual(undefined)
        expect(testNode.openingDelimiter).assertEqual(undefined)
        expect(testNode.closingDelimiter).assertEqual(undefined)
        expect(testNode.fenceChar).assertEqual(undefined)
        expect(testNode.fenceLength).assertEqual(undefined)
        expect(testNode.fenceIndent).assertEqual(undefined)
        expect(testNode.info).assertEqual(undefined)
        expect(testNode.isTight).assertEqual(undefined)
        expect(testNode.bulletMarker).assertEqual(undefined)
        expect(testNode.startNumber).assertEqual(undefined)
        expect(testNode.delimiter).assertEqual(undefined)
      }
    })
  })
}
