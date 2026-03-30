import { BaseMDData } from "./BaseMDData"

export class ListData extends BaseMDData {
  _blockOrderedAndBulletTopAndBottomMargins: number = 0
  _blockLeftMargin: number = 8
  _blockRightMargin: number = 8
  _orderedListItemPrefixBold: boolean = false
  _orderedListItemColor: number | undefined = undefined
  _orderedListItemSize: number = 14
  _orderedListItemLineHeight: number = 22
  _bulletListItemCircle: boolean = false
  _bulletListItemColor: number | undefined = undefined
  _bulletListItemSize: number = 4
  _bulletListItemLineHeight: number = 18
  _taskListItemLength: number = 15

  public set blockOrderedAndBulletTopAndBottomMargins(value: number) {
    this._blockOrderedAndBulletTopAndBottomMargins = value
  }

  public set blockLeftMargin(value: number) {
    this._blockLeftMargin = value
  }

  public set blockRightMargin(value: number) {
    this._blockRightMargin = value
  }

  public set orderedListItemPrefixBold(value: boolean) {
    this._orderedListItemPrefixBold = value
  }

  public set orderedListItemColor(value: number | undefined) {
    this._orderedListItemColor = value
  }

  public set orderedListItemSize(value: number) {
    this._orderedListItemSize = value
  }

  public set orderedListItemLineHeight(value: number) {
    this._orderedListItemLineHeight = value
  }

  public set bulletListItemCircle(value: boolean) {
    this._bulletListItemCircle = value
  }

  public set bulletListItemColor(value: number | undefined) {
    this._bulletListItemColor = value
  }

  public set bulletListItemSize(value: number) {
    this._bulletListItemSize = value
  }

  public set bulletListItemLineHeight(value: number) {
    this._bulletListItemLineHeight = value
  }

  public set taskListItemLength(value: number) {
    this._taskListItemLength = value
  }

  constructor() {
    super()
  }
}