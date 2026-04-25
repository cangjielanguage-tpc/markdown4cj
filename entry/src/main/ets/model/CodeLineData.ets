import { BaseMDData } from "./BaseMDData"

export class CodeLineData extends BaseMDData {
  _codeTextColor: number | undefined = undefined
  _codeBackgroundColor: number | undefined = undefined
  _codeTextSize: number = 13
  _codeTypeface: string = "HarmonyOS Sans"

  public set codeTextColor(value: number | undefined) {
    this._codeTextColor = value
  }

  public set codeBackgroundColor(value: number | undefined) {
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