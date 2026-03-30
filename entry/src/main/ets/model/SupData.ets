import { BaseMDData } from "./BaseMDData"

export class SupData extends BaseMDData {
  _supTextColor: number | undefined = undefined
  _supTextSize: number = 8
  _supOffsetDist: number = 6

  public set supTextColor(value: number | undefined) {
    this._supTextColor = value
  }

  public set supTextSize(value: number) {
    this._supTextSize = value
  }

  public set supOffsetDist(value: number) {
    this._supOffsetDist = value
  }

  constructor() {
    super()
  }
}