import { BaseMDData } from "./BaseMDData"

export class QuoteData extends BaseMDData {
  _blockQuoteLeftMargin: number = 8
  _blockQuoteRightMargin: number = 8
  _blockQuoteWidth: number = 1
  _blockQuoteColor: number | undefined = undefined
  _blockQuoteBackGroupColor: number | undefined = undefined
  _blockQuoteTopAndBottomMargins: number = 0

  public set blockQuoteLeftMargin(value: number) {
    this._blockQuoteLeftMargin = value
  }

  public set blockQuoteRightMargin(value: number) {
    this._blockQuoteRightMargin = value
  }

  public set blockQuoteWidth(value: number) {
    this._blockQuoteWidth = value
  }

  public set blockQuoteColor(value: number | undefined) {
    this._blockQuoteColor = value
  }

  public set blockQuoteBackGroupColor(value: number | undefined) {
    this._blockQuoteBackGroupColor = value
  }

  public set blockQuoteTopAndBottomMargins(value: number) {
    this._blockQuoteTopAndBottomMargins = value
  }

  constructor() {
    super()
  }
}