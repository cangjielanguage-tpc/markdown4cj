import { BaseMDData } from "./BaseMDData"

export class TableData extends BaseMDData {
  _tableCellPadding: number = 4
  _tableBorderColor: number | undefined = undefined
  _tableBorderWidth: number = 1
  _tableOddRowBackgroundColor: number | undefined = undefined
  _tableEvenRowBackgroundColor: number | undefined = undefined
  _tableHeaderRowBackgroundColor: number | undefined = undefined
  _tableRadius: number = 5
  _tableMinTextWidth: number = 50
  _tableMaxTextWidth: number = 300
  _tableFirstColumnBold: boolean = false
  _tableTitleLineHeight: number = 22
  _tableTextLineHeight: number = 22
  _tableTitleTextSize: number = 14
  _tableTitleTextColor: number | undefined = undefined
  _tableContentTextLineHeight: number = 22
  _tableContentTextSize: number = 14
  _tableContentTextColor: number | undefined = undefined
  _tableScrollBarShow: boolean = false
  _tableScrollBarColor: number | undefined = undefined

  public set tableCellPadding(value: number) {
    this._tableCellPadding = value
  }

  public set tableBorderColor(value: number | undefined) {
    this._tableBorderColor = value
  }

  public set tableBorderWidth(value: number) {
    this._tableBorderWidth = value
  }

  public set tableOddRowBackgroundColor(value: number | undefined) {
    this._tableOddRowBackgroundColor = value
  }

  public set tableEvenRowBackgroundColor(value: number | undefined) {
    this._tableEvenRowBackgroundColor = value
  }

  public set tableHeaderRowBackgroundColor(value: number | undefined) {
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

  public set tableTitleTextSize(value: number) {
    this._tableTitleTextSize = value
  }

  public set tableTitleTextColor(value: number | undefined) {
    this._tableTitleTextColor = value
  }

  public set tableContentTextLineHeight(value: number) {
    this._tableContentTextLineHeight = value
  }

  public set tableContentTextSize(value: number) {
    this._tableContentTextSize = value
  }

  public set tableContentTextColor(value: number | undefined) {
    this._tableContentTextColor = value
  }

  public set tableScrollBarShow(value: boolean) {
    this._tableScrollBarShow = value
  }

  public set tableScrollBarColor(value: number | undefined) {
    this._tableScrollBarColor = value
  }

  constructor() {
    super()
  }
}