import { BaseMDData } from "./BaseMDData"

export class StrikethroughData extends BaseMDData {
  _strikethroughColor: number = 0xFF191919
  _strikethroughStyle: TextDecorationStyle = TextDecorationStyle.SOLID

  public set strikethroughColor(value: number) {
    this._strikethroughColor = value
  }

  public set strikethroughStyle(value: TextDecorationStyle) {
    this._strikethroughStyle = value
  }
  constructor() {
    super()
  }
}