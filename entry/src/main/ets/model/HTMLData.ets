import { BaseMDData } from "./BaseMDData"

export class HTMLData extends BaseMDData {
  _underlineColor: number = 0xFF191919
  _underlineStyle: TextDecorationStyle = TextDecorationStyle.SOLID

  public set underlineColor(value: number) {
    this._underlineColor = value
  }

  public set underlineStyle(value: TextDecorationStyle) {
    this._underlineStyle = value
  }

  constructor() {
    super()
  }
}