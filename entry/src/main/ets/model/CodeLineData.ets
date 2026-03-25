import { BaseMDData } from "./BaseMDData"

export class CodeLineData extends BaseMDData {
  _codeTextColor: number = 0xFF000000
  _codeBackgroundColor: number = 0xFFE0E0E0
  _codeTextSize: number = 13
  _codeTypeface: string = "HarmonyOS Sans"

  public set codeTextColor(value: number) {
    this._codeTextColor = value
  }

  public set codeBackgroundColor(value: number) {
    this._codeBackgroundColor = value
  }

  public set codeTextSize(value: number) {
    this._codeTextSize = value
  }

  public set codeTypeface(value: string) {
    this._codeTypeface = value
  }

  constructor() {
    super()
  }
}