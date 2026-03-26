import { BaseMDData } from "./BaseMDData"

export class CodeListData extends BaseMDData {
  _codeListTitleTextSize: number = 13
  _codeListTitleSelectTextSize: number = 13
  _codeListTitleSelectTextColor: number = 0xFFFF0000
  _codeListTitleUnSelectTextColor: number = 0xFF000000
  _codeListTitleSelectBackGroupColor: number = 0xFF191919
  _codeListTitleUnSelectBackGroupColor: number = 0x00FFFFFF

  public set codeListTitleTextSize(value: number) {
    this._codeListTitleTextSize = value
  }

  public set codeListTitleSelectTextSize(value: number) {
    this._codeListTitleSelectTextSize = value
  }

  public set codeListTitleSelectTextColor(value: number) {
    this._codeListTitleSelectTextColor = value
  }

  public set codeListTitleUnSelectTextColor(value: number) {
    this._codeListTitleUnSelectTextColor = value
  }

  public set codeListTitleSelectBackGroupColor(value: number) {
    this._codeListTitleSelectBackGroupColor = value
  }

  public set codeListTitleUnSelectBackGroupColor(value: number) {
    this._codeListTitleUnSelectBackGroupColor = value
  }

  constructor() {
    super()
  }
}