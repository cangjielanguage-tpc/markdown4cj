import { BaseMDData } from "./BaseMDData"

export class CodeListData extends BaseMDData {
  _codeListTitleTextSize: number = 13
  _codeListTitleSelectTextSize: number = 13
  _codeListTitleSelectTextColor: number | undefined = undefined
  _codeListTitleUnSelectTextColor: number | undefined = undefined
  _codeListTitleSelectBackGroupColor: number | undefined = undefined
  _codeListTitleUnSelectBackGroupColor: number | undefined = undefined

  public set codeListTitleTextSize(value: number) {
    this._codeListTitleTextSize = value
  }

  public set codeListTitleSelectTextSize(value: number) {
    this._codeListTitleSelectTextSize = value
  }

  public set codeListTitleSelectTextColor(value: number | undefined) {
    this._codeListTitleSelectTextColor = value
  }

  public set codeListTitleUnSelectTextColor(value: number | undefined) {
    this._codeListTitleUnSelectTextColor = value
  }

  public set codeListTitleSelectBackGroupColor(value: number | undefined) {
    this._codeListTitleSelectBackGroupColor = value
  }

  public set codeListTitleUnSelectBackGroupColor(value: number | undefined) {
    this._codeListTitleUnSelectBackGroupColor = value
  }

  constructor() {
    super()
  }
}