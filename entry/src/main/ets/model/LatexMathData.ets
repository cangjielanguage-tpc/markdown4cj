import { BaseMDData } from "./BaseMDData"

export class LatexMathData extends BaseMDData {
  _latexMathTextSize: number = 14
  _latexMathTextColor: number | undefined = 0xFF000000
  _latexMathBackgroundColor: number | undefined = 0x00000000
  _latexMathColorFormat: number = 1
  _latexMathBlockCenter: boolean = true
  _latexMathDefaultText: boolean = true

  public set latexMathTextSize(value: number) {
    this._latexMathTextSize = value
  }

  public set latexMathTextColor(value: number | undefined) {
    this._latexMathTextColor = value
  }

  public set latexMathBackgroundColor(value: number | undefined) {
    this._latexMathBackgroundColor = value
  }

  public set latexMathColorFormat(value: number) {
    this._latexMathColorFormat = value
  }

  public set latexMathBlockCenter(value: boolean) {
    this._latexMathBlockCenter = value
  }

  public set latexMathDefaultText(value: boolean) {
    this._latexMathDefaultText = value
  }

  constructor() {
    super()
  }
}
