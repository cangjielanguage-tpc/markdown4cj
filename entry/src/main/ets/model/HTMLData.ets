import { BaseMDData } from "./BaseMDData"

export class HTMLData extends BaseMDData {
  _underlineColor: number | undefined = undefined
  _underlineStyle: TextDecorationStyle = TextDecorationStyle.SOLID

  public set underlineColor(value: number | undefined) {
    this._underlineColor = value
  }

  public set underlineStyle(value: TextDecorationStyle) {
    this._underlineStyle = value
  }

  constructor() {
    super()
  }
}