import { BaseMDData } from "./BaseMDData"

export class LinkData extends BaseMDData {
  _isLinkStyle: boolean = false
  _isListLinkStyle: boolean = false
  _linkColor: number | undefined = undefined
  _isLinkSize: boolean = true
  _linkSize: number = 14
  _linkBackGroupColor: number | undefined = undefined
  _isLinkUnderlined: boolean = true
  _linkCircleImageBackGroupColor: number | undefined = undefined
  _linkCircleImageButtonBackGroupColor: number | undefined = undefined
  _linkCircleImageTextColor: number | undefined = undefined
  _linkCircleImageTextSize: number = 14
  _linkCircleImageRadius: number = 20
  _linkCircleImageMargin: number = 6
  _linkRectImageBackGroupColor: number | undefined = undefined
  _linkRectImageButtonBackGroupColor: number | undefined = undefined
  _linkRectImageTextSize: number = 14
  _linkRectImageTextColor: number | undefined = undefined
  _linkRectImageHeight: number = 20
  _linkRectImagePadding: number = 6
  _linkRectImageRadius: number = 6
  _linkRectImageMargin: number = 6
  _linkRectToolImageBackGroupColor: number | undefined = undefined
  _linkRectToolImageButtonBackGroupColor: number | undefined = undefined
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

  public set linkColor(value: number | undefined) {
    this._linkColor = value
  }

  public set isLinkSize(value: boolean) {
    this._isLinkSize = value
  }

  public set linkSize(value: number) {
    this._linkSize = value
  }

  public set linkBackGroupColor(value: number | undefined) {
    this._linkBackGroupColor = value
  }

  public set isLinkUnderlined(value: boolean) {
    this._isLinkUnderlined = value
  }

  public set linkCircleImageBackGroupColor(value: number | undefined) {
    this._linkCircleImageBackGroupColor = value
  }

  public set linkCircleImageButtonBackGroupColor(value: number | undefined) {
    this._linkCircleImageButtonBackGroupColor = value
  }

  public set linkCircleImageTextSize(value: number) {
    this._linkCircleImageTextSize = value
  }

  public set linkCircleImageTextColor(value: number | undefined) {
    this._linkCircleImageTextColor = value
  }

  public set linkCircleImageRadius(value: number) {
    this._linkCircleImageRadius = value
  }

  public set linkCircleImageMargin(value: number) {
    this._linkCircleImageMargin = value
  }

  public set linkRectImageBackGroupColor(value: number | undefined) {
    this._linkRectImageBackGroupColor = value
  }

  public set linkRectImageButtonBackGroupColor(value: number | undefined) {
    this._linkRectImageButtonBackGroupColor = value
  }

  public set linkRectImageTextSize(value: number) {
    this._linkRectImageTextSize = value
  }

  public set linkRectImageTextColor(value: number | undefined) {
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

  public set linkRectToolImageBackGroupColor(value: number | undefined) {
    this._linkRectToolImageBackGroupColor = value
  }

  public set linkRectToolImageButtonBackGroupColor(value: number | undefined) {
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