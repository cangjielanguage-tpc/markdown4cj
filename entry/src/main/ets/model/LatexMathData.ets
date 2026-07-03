// import { LatexMathColorFormat } from "@cangjie-tpc/markdown_hybrid"
import { BaseMDData } from "./BaseMDData"

export class LatexMathData extends BaseMDData {
  _latexMathMarginTop: number = 8 // LaTeX数学公式上外边距
  _latexMathMarginRight: number = 8 // LaTeX数学公式右外边距
  _latexMathMarginBottom: number = 8 // LaTeX数学公式下外边距
  _latexMathMarginLeft: number = 8 // LaTeX数学公式左外边距
  _latexMathPaddingTop: number = 0 // LaTeX数学公式上内边距
  _latexMathPaddingRight: number = 0 // LaTeX数学公式右内边距
  _latexMathPaddingBottom: number = 0 // LaTeX数学公式下内边距
  _latexMathPaddingLeft: number = 0 // LaTeX数学公式左内边距
  _latexMathDefaultText: boolean = true // 数学公式未加载状态是否显示文字
  _latexMathDefaultTextFontColor: ResourceColor | undefined = undefined // 数学公式未加载状态文本颜色
  _latexMathDefaultTextFontSize: number = 14 // 数学公式未加载状态文本尺寸
  _latexMathDefaultTextFontStyle: FontStyle = FontStyle.Normal // 数学公式未加载状态文本字体样式
  _latexMathDefaultTextFontWeight: FontWeight = FontWeight.Normal // 数学公式未加载状态文本字体粗细
  _latexMathDefaultTextFontFamily: string = 'HarmonyOS Sans' // 数学公式未加载状态文本字体
  _latexMathTextSize: number = 16 // 数学公式文本大小
  _latexMathBackgroundColor: ResourceColor | undefined = undefined // 数学公式背景色
  _latexMathTextColor: ResourceColor | undefined = undefined // 数学公式文本颜色
  // _latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888 // 数学公式生成图片格式
  _latexMathBlockCenter: boolean = false // 块结构的数学公式是否居中
  _latexMathResPath: string = '/data/storage/el1/bundle/entry/resources/resfile/res' // 数学公式字体路径

  constructor() {
    super()
  }
}