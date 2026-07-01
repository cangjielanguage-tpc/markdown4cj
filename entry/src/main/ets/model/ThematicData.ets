import { BaseMDData } from "./BaseMDData"

export class ThematicData extends BaseMDData {
  _dividerMarginTop: number = 8 // 分割线上外边距
  _dividerMarginRight: number = 0 // 分割线右外边距
  _dividerMarginBottom: number = 8 // 分割线下外边距
  _dividerMarginLeft: number = 0 // 分割线左外边距
  _dividerPaddingTop: number = 0 // 分割线上内边距
  _dividerPaddingRight: number = 0 // 分割线右内边距
  _dividerPaddingBottom: number = 0 // 分割线下内边距
  _dividerPaddingLeft: number = 0 // 分割线左内边距
  _dividerColor: number | undefined = undefined // 分割线颜色
  _dividerStrokeWidth: number = 1 // 分割线宽度
  _dividerStyle: LineCapStyle = LineCapStyle.Round // 分割线端点样式

  public set dividerMarginTop(value: number) {
    this._dividerMarginTop = value
  }

  public set dividerMarginRight(value: number) {
    this._dividerMarginRight = value
  }

  public set dividerMarginBottom(value: number) {
    this._dividerMarginBottom = value
  }

  public set dividerMarginLeft(value: number) {
    this._dividerMarginLeft = value
  }

  public set dividerPaddingTop(value: number) {
    this._dividerPaddingTop = value
  }

  public set dividerPaddingRight(value: number) {
    this._dividerPaddingRight = value
  }

  public set dividerPaddingBottom(value: number) {
    this._dividerPaddingBottom = value
  }

  public set dividerPaddingLeft(value: number) {
    this._dividerPaddingLeft = value
  }

  public set dividerColor(value: number | undefined) {
    this._dividerColor = value
  }

  public set dividerStrokeWidth(value: number) {
    this._dividerStrokeWidth = value
  }

  public set dividerStyle(value: LineCapStyle) {
    this._dividerStyle = value
  }

  constructor() {
    super()
  }
}