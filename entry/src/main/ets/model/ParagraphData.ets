import { BaseMDData } from "./BaseMDData"

export class ParagraphData extends BaseMDData {
  _paragraphTextSize: number = 14
  _paragraphTextColor: number | undefined = undefined
  _paragraphTextWordSpace: number = 0
  _paragraphTextLineHeight: number = 22
  _paragraphTypeface: string = "HarmonyOS Sans"
  _paragraphTopMargins: number = 8
  _paragraphBottomMargins: number = 8

  public set paragraphTextSize(value: number) {
    this._paragraphTextSize = value
  }

  public set paragraphTextColor(value: number | undefined) {
    this._paragraphTextColor = value
  }

  public set paragraphTextWordSpace(value: number) {
    this._paragraphTextWordSpace = value
  }

  public set paragraphTextLineHeight(value: number) {
    this._paragraphTextLineHeight = value
  }

  public set paragraphTypeface(value: string) {
    this._paragraphTypeface = value
  }

  public set paragraphTopMargins(value: number) {
    this._paragraphTopMargins = value
  }

  public set paragraphBottomMargins(value: number) {
    this._paragraphBottomMargins = value
  }

  constructor() {
    super()
  }
}