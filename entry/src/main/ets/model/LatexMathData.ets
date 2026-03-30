import { LatexMathColorFormat } from "@cangjie-tpc/markdown_hybrid"
import { BaseMDData } from "./BaseMDData"

export class LatexMathData extends BaseMDData {
  _latexMathTextSize: number = 16
  _latexMathBackGroupColor: number | undefined = undefined
  _latexMathTextColor: number | undefined = undefined
  _latexMathColorFormat: LatexMathColorFormat = LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
  _latexMathBlockCenter: boolean = false
  _latexMathResStr: string = "/data/storage/el1/bundle/entry/resources/resfile/res"
  _latexDefaultText: boolean = true

  public set latexMathTextSize(value: number) {
    this._latexMathTextSize = value
  }

  public set latexMathBackGroupColor(value: number | undefined) {
    this._latexMathBackGroupColor = value
  }

  public set latexMathTextColor(value: number | undefined) {
    this._latexMathTextColor = value
  }

  public set latexMathColorFormat(value: LatexMathColorFormat) {
    this._latexMathColorFormat = value
  }

  public set latexMathBlockCenter(value: boolean) {
    this._latexMathBlockCenter = value
  }

  public set latexMathResStr(value: string) {
    this._latexMathResStr = value
  }

  public set latexDefaultText(value: boolean) {
    this._latexDefaultText = value
  }

  constructor() {
    super()
  }
}