import { BaseMDData } from "./BaseMDData"

export class SubData extends BaseMDData {
  _subTextColor: number | undefined = undefined
  _subTextSize: number = 8
  _subOffsetDist: number = 0

  public set subTextColor(value: number | undefined) {
    this._subTextColor = value
  }

  public set subTextSize(value: number) {
    this._subTextSize = value
  }

  public set subOffsetDist(value: number) {
    this._subOffsetDist = value
  }

  constructor() {
    super()
  }
}