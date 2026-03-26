import { BaseMDData } from "./BaseMDData"

export class CodeSeparateData extends BaseMDData {
  _isSeparateCodeBlock: boolean = false
  _separateCodeBlockWidth: number = 50
  _separateCodeIsBottom: boolean = false

  public set isSeparateCodeBlock(value: boolean) {
    this._isSeparateCodeBlock = value
  }

  public set separateCodeBlockWidth(value: number) {
    this._separateCodeBlockWidth = value
  }

  public set separateCodeIsBottom(value: boolean) {
    this._separateCodeIsBottom = value
  }

  constructor() {
    super()
  }
}