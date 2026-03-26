import { BaseMDData } from "./BaseMDData"

export class AllData extends BaseMDData {
  _isDark: boolean = true

  public set isDark(value: boolean) {
    this._isDark = value
  }
  constructor() {
    super()
  }
}