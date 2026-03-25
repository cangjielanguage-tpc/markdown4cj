import { BaseMDData } from "./BaseMDData"

export class TableData extends BaseMDData {
  _tableCellPadding: number = 4
  _tableBorderColor: number = 0xFF000000
  _tableBorderWidth: number = 1
  _tableOddRowBackgroundColor: number = 0xFFFFFFFF
  _tableEvenRowBackgroundColor: number = 0xFFE0E0E0
  _tableHeaderRowBackgroundColor: number = 0xFFFFFFFF
  _tableRadius: number = 5
  _tableMinTextWidth: number = 50
  _tableMaxTextWidth: number = 300
  _tableFirstColumnBold: boolean = false
  _tableTitleLineHeight: number = 22
  _tableTextLineHeight: number = 22
  _tableScrollBarShow: boolean = false
  _tableScrollBarColor: number = 0xFFFFFFFF

  public set tableCellPadding(value: number) {
    this._tableCellPadding = value
  }

  public set tableBorderColor(value: number) {
    this._tableBorderColor = value
  }

  public set tableBorderWidth(value: number) {
    this._tableBorderWidth = value
  }

  public set tableOddRowBackgroundColor(value: number) {
    this._tableOddRowBackgroundColor = value
  }

  public set tableEvenRowBackgroundColor(value: number) {
    this._tableEvenRowBackgroundColor = value
  }

  public set tableHeaderRowBackgroundColor(value: number) {
    this._tableHeaderRowBackgroundColor = value
  }

  public set tableRadius(value: number) {
    this._tableRadius = value
  }

  public set tableMinTextWidth(value: number) {
    this._tableMinTextWidth = value
  }

  public set tableMaxTextWidth(value: number) {
    this._tableMaxTextWidth = value
  }

  public set tableFirstColumnBold(value: boolean) {
    this._tableFirstColumnBold = value
  }

  public set tableTitleLineHeight(value: number) {
    this._tableTitleLineHeight = value
  }

  public set tableTextLineHeight(value: number) {
    this._tableTextLineHeight = value
  }

  public set tableScrollBarShow(value: boolean) {
    this._tableScrollBarShow = value
  }

  public set tableScrollBarColor(value: number) {
    this._tableScrollBarColor = value
  }

  constructor() {
    super()
  }
}