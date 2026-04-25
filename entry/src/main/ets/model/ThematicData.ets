import { BaseMDData } from "./BaseMDData"

export class ThematicData extends BaseMDData {
  _thematicBreakHeight: number = 0.5
  _thematicBreakColor: number | undefined = undefined
  _thematicBreakTopMargin: number = 0
  _thematicBreakBottomMargin: number = 0

  public set thematicBreakHeight(value: number) {
    this._thematicBreakHeight = value
  }

  public set thematicBreakColor(value: number | undefined) {
    this._thematicBreakColor = value
  }

  public set thematicBreakTopMargin(value: number) {
    this._thematicBreakTopMargin = value
  }

  public set thematicBreakBottomMargin(value: number) {
    this._thematicBreakBottomMargin = value
  }

  constructor() {
    super()
  }
}