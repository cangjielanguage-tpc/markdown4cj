import { BaseMDData } from "./BaseMDData"

export class StrikethroughData extends BaseMDData {
  _strikethroughColor: number | undefined = undefined
  _strikethroughStyle: TextDecorationStyle = TextDecorationStyle.SOLID

  public set strikethroughColor(value: number | undefined) {
    this._strikethroughColor = value
  }

  public set strikethroughStyle(value: TextDecorationStyle) {
    this._strikethroughStyle = value
  }
  constructor() {
    super()
  }
}