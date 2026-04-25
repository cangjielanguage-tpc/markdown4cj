import { BaseMDData } from "./BaseMDData"

export class LineBreakData extends BaseMDData {
  _isLineBreak: boolean = false

  public set isLineBreak(value: boolean) {
    this._isLineBreak = value
  }

  constructor() {
    super()
  }
}