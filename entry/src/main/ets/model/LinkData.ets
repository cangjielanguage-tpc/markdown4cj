import { BaseMDData } from "./BaseMDData"

export class LinkData extends BaseMDData {
  _isLinkStyle: boolean = false
  _isListLinkStyle: boolean = false
  _linkColor: number = 0xFF0000FF
  _isLinkSize: boolean = true
  _linkSize: number = 14
  _linkBackGroupColor: number = 0x00000000
  _isLinkUnderlined: boolean = true
  _linkCircleImageBackGroupColor: number = 0x00000000
  _linkCircleImageButtonBackGroupColor: number = 0xFF000000
  _linkCircleImageTextColor: number = 0xFFFFFFFF
  _linkCircleImageTextSize: number = 14
  _linkCircleImageRadius: number = 20
  _linkCircleImageMargin: number = 6
  _linkRectImageBackGroupColor: number = 0x00000000
  _linkRectImageButtonBackGroupColor: number = 0xFF000000
  _linkRectImageTextSize: number = 14
  _linkRectImageTextColor: number = 0xFFFFFFFF
  _linkRectImageHeight: number = 20
  _linkRectImagePadding: number = 6
  _linkRectImageRadius: number = 6
  _linkRectImageMargin: number = 6
  _linkRectToolImageBackGroupColor: number = 0x00000000
  _linkRectToolImageButtonBackGroupColor: number = 0xFFFFFFFF
  _linkRectToolImageTextSize: number = 14
  _linkRectToolImageHeight: number = 21
  _linkRectToolImagePadding: number = 6
  _linkRectToolImageBorderWidth: number = 1
  _linkRectToolImageDividingLineWidth: number = 1
  _linkRectToolImageMargin: number = 6
  _linkRectToolImageLineLeftPadding: number = 3
  _linkRectToolImageLineRightPadding: number = 3
  _linkLineHeight: number = 22

  public set isLinkStyle(value: boolean) {
    this._isLinkStyle = value
  }

  public set isListLinkStyle(value: boolean) {
    this._isListLinkStyle = value
  }

  public set linkColor(value: number) {
    this._linkColor = value
  }

  public set isLinkSize(value: boolean) {
    this._isLinkSize = value
  }

  public set linkSize(value: number) {
    this._linkSize = value
  }

  public set linkBackGroupColor(value: number) {
    this._linkBackGroupColor = value
  }

  public set isLinkUnderlined(value: boolean) {
    this._isLinkUnderlined = value
  }

  public set linkCircleImageBackGroupColor(value: number) {
    this._linkCircleImageBackGroupColor = value
  }

  public set linkCircleImageButtonBackGroupColor(value: number) {
    this._linkCircleImageButtonBackGroupColor = value
  }

  public set linkCircleImageTextSize(value: number) {
    this._linkCircleImageTextSize = value
  }

  public set linkCircleImageTextColor(value: number) {
    this._linkCircleImageTextColor = value
  }

  public set linkCircleImageRadius(value: number) {
    this._linkCircleImageRadius = value
  }

  public set linkCircleImageMargin(value: number) {
    this._linkCircleImageMargin = value
  }

  public set linkRectImageBackGroupColor(value: number) {
    this._linkRectImageBackGroupColor = value
  }

  public set linkRectImageButtonBackGroupColor(value: number) {
    this._linkRectImageButtonBackGroupColor = value
  }

  public set linkRectImageTextSize(value: number) {
    this._linkRectImageTextSize = value
  }

  public set linkRectImageTextColor(value: number) {
    this._linkRectImageTextColor = value
  }

  public set linkRectImageHeight(value: number) {
    this._linkRectImageHeight = value
  }

  public set linkRectImagePadding(value: number) {
    this._linkRectImagePadding = value
  }

  public set linkRectImageRadius(value: number) {
    this._linkRectImageRadius = value
  }

  public set linkRectImageMargin(value: number) {
    this._linkRectImageMargin = value
  }

  public set linkRectToolImageBackGroupColor(value: number) {
    this._linkRectToolImageBackGroupColor = value
  }

  public set linkRectToolImageButtonBackGroupColor(value: number) {
    this._linkRectToolImageButtonBackGroupColor = value
  }

  public set linkRectToolImageTextSize(value: number) {
    this._linkRectToolImageTextSize = value
  }

  public set linkRectToolImageHeight(value: number) {
    this._linkRectToolImageHeight = value
  }

  public set linkRectToolImagePadding(value: number) {
    this._linkRectToolImagePadding = value
  }

  public set linkRectToolImageBorderWidth(value: number) {
    this._linkRectToolImageBorderWidth = value
  }

  public set linkRectToolImageDividingLineWidth(value: number) {
    this._linkRectToolImageDividingLineWidth = value
  }

  public set linkRectToolImageMargin(value: number) {
    this._linkRectToolImageMargin = value
  }

  public set linkRectToolImageLineLeftPadding(value: number) {
    this._linkRectToolImageLineLeftPadding = value
  }

  public set linkRectToolImageLineRightPadding(value: number) {
    this._linkRectToolImageLineRightPadding = value
  }

  public set linkLineHeight(value: number) {
    this._linkLineHeight = value
  }

  constructor() {
    super()
  }
}