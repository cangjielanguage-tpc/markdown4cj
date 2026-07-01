import { BaseMDData } from "./BaseMDData"

export class LinkData extends BaseMDData {
  _linkIsIcon: boolean = false // 链接是否是图片显示
  _linkListIsIcon: boolean = false // 列表中的单行链接是否是图片显示
  _linkTextFontColor: ResourceColor | undefined = undefined // 链接文本颜色
  _linkTextFontSize: number | string | Resource | undefined = undefined // 链接文本尺寸
  _linkTextFontStyle: FontStyle | undefined = undefined // 链接文本字体样式
  _linkTextFontWeight: number | FontWeight | undefined = undefined // 链接文本字体粗细
  _linkTextFontFamily: string | Resource | undefined = undefined // 链接文本字体
  _linkTextLineHeight: number | string | Resource | undefined = undefined // 链接文本行高
  _linkTextLetterSpacing: number | undefined = undefined // 链接文本字符间距
  _linkTextDecorationType: TextDecorationType = TextDecorationType.Underline // 链接文本装饰线类型
  _linkTextDecorationColor: ResourceColor | undefined = undefined // 链接文本装饰线颜色
  _linkTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID // 链接文本装饰线样式
  _linkTextBackgroundColor: ResourceColor | undefined = undefined // 链接文本背景颜色
  _linkTextBackgroundRadiusTopLeft: Length = 0.0 // 链接文本背景左上圆角
  _linkTextBackgroundRadiusTopRight: Length = 0.0 // 链接文本背景右上圆角
  _linkTextBackgroundRadiusBottomLeft: Length = 0.0 // 链接文本背景左下圆角
  _linkTextBackgroundRadiusBottomRight: Length = 0.0 // 链接文本背景右下圆角
  _linkCircleIconBackgroundColor: ResourceColor | undefined = undefined // 圆形图片格式链接主题背景颜色
  _linkCircleIconButtonBackgroundColor: ResourceColor | undefined = undefined // 圆形图片格式链接控件背景颜色
  _linkCircleIconTextSize: number = 14.0 // 圆形图片格式链接文字大小
  _linkCircleIconTextColor: ResourceColor | undefined = undefined // 圆形图片格式链接文字颜色
  _linkCircleIconRadius: number = 20.0 // 圆形图片格式链接半径
  _linkCircleIconMargin: number = 6.0 // 圆形图片格式链接左右外边距
  _linkRectIconBackgroundColor: ResourceColor | undefined = undefined // 圆角矩形图片格式链接主题背景颜色
  _linkRectIconButtonBackgroundColor: ResourceColor | undefined = undefined // 圆角矩形图片格式链接控件背景颜色
  _linkRectIconTextSize: number = 14.0 // 圆角矩形图片格式链接文字大小
  _linkRectIconTextColor: ResourceColor | undefined = undefined // 圆角矩形图片格式链接文字颜色
  _linkRectIconHeight: Length = 20.0 // 圆角矩形图片格式链接控件高度
  _linkRectIconPadding: number = 6.0 // 圆角矩形图片格式链接左右内边距
  _linkRectIconRadius: number = 6.0 // 圆角矩形图片格式链接圆角半径
  _linkRectIconMargin: number = 6.0 // 圆角矩形图片格式链接左右外边距
  _linkRectToolIconBackgroundColor: ResourceColor | undefined = undefined // 空心圆角矩形图片格式链接主题背景颜色
  _linkRectToolIconButtonBackgroundColor: ResourceColor | undefined = undefined // 空心圆角矩形图片格式链接控件背景颜色
  _linkRectToolIconTextSize: number = 14.0 // 空心圆角矩形图片格式链接文字大小
  _linkRectToolIconHeight: Length = 21.0 // 空心圆角矩形图片格式链接控件高度
  _linkRectToolIconPadding: number = 6.0 // 空心圆角矩形图片格式链接左右内边距
  _linkRectToolIconBorderWidth: Length = 1.0 // 空心圆角矩形图片格式链接边框宽度
  _linkRectToolIconDividingLineWidth: Length = 1.0 // 空心圆角矩形图片格式链接分割线宽度
  _linkRectToolIconMargin: number = 6.0 // 空心圆角矩形图片格式链接左右外边距
  _linkRectToolIconLineLeftPadding: number = 3.0 // 空心圆角矩形图片格式分割线和文本左边距
  _linkRectToolIconLineRightPadding: number = 3.0 // 空心圆角矩形图片格式分割线和文本右边距

  public set linkIsIcon(value: boolean) {
    this._linkIsIcon = value
  }

  public set linkListIsIcon(value: boolean) {
    this._linkListIsIcon = value
  }

  public set linkTextFontColor(value: ResourceColor | undefined) {
    this._linkTextFontColor = value
  }

  public set linkTextFontSize(value: number | string | Resource | undefined) {
    this._linkTextFontSize = value
  }

  public set linkTextFontStyle(value: FontStyle | undefined) {
    this._linkTextFontStyle = value
  }

  public set linkTextFontWeight(value: number | FontWeight | undefined) {
    this._linkTextFontWeight = value
  }

  public set linkTextFontFamily(value: string | Resource | undefined) {
    this._linkTextFontFamily = value
  }

  public set linkTextLineHeight(value: number | string | Resource | undefined) {
    this._linkTextLineHeight = value
  }

  public set linkTextLetterSpacing(value: number | undefined) {
    this._linkTextLetterSpacing = value
  }

  public set linkTextDecorationType(value: TextDecorationType) {
    this._linkTextDecorationType = value
  }

  public set linkTextDecorationColor(value: ResourceColor | undefined) {
    this._linkTextDecorationColor = value
  }

  public set linkTextDecorationStyle(value: TextDecorationStyle) {
    this._linkTextDecorationStyle = value
  }

  public set linkTextBackgroundColor(value: ResourceColor | undefined) {
    this._linkTextBackgroundColor = value
  }

  public set linkTextBackgroundRadiusTopLeft(value: Length) {
    this._linkTextBackgroundRadiusTopLeft = value
  }

  public set linkTextBackgroundRadiusTopRight(value: Length) {
    this._linkTextBackgroundRadiusTopRight = value
  }

  public set linkTextBackgroundRadiusBottomLeft(value: Length) {
    this._linkTextBackgroundRadiusBottomLeft = value
  }

  public set linkTextBackgroundRadiusBottomRight(value: Length) {
    this._linkTextBackgroundRadiusBottomRight = value
  }

  public set linkCircleIconBackgroundColor(value: ResourceColor | undefined) {
    this._linkCircleIconBackgroundColor = value
  }

  public set linkCircleIconButtonBackgroundColor(value: ResourceColor | undefined) {
    this._linkCircleIconButtonBackgroundColor = value
  }

  public set linkCircleIconTextSize(value: number) {
    this._linkCircleIconTextSize = value
  }

  public set linkCircleIconTextColor(value: ResourceColor | undefined) {
    this._linkCircleIconTextColor = value
  }

  public set linkCircleIconRadius(value: number) {
    this._linkCircleIconRadius = value
  }

  public set linkCircleIconMargin(value: number) {
    this._linkCircleIconMargin = value
  }

  public set linkRectIconBackgroundColor(value: ResourceColor | undefined) {
    this._linkRectIconBackgroundColor = value
  }

  public set linkRectIconButtonBackgroundColor(value: ResourceColor | undefined) {
    this._linkRectIconButtonBackgroundColor = value
  }

  public set linkRectIconTextSize(value: number) {
    this._linkRectIconTextSize = value
  }

  public set linkRectIconTextColor(value: ResourceColor | undefined) {
    this._linkRectIconTextColor = value
  }

  public set linkRectIconHeight(value: Length) {
    this._linkRectIconHeight = value
  }

  public set linkRectIconPadding(value: number) {
    this._linkRectIconPadding = value
  }

  public set linkRectIconRadius(value: number) {
    this._linkRectIconRadius = value
  }

  public set linkRectIconMargin(value: number) {
    this._linkRectIconMargin = value
  }

  public set linkRectToolIconBackgroundColor(value: ResourceColor | undefined) {
    this._linkRectToolIconBackgroundColor = value
  }

  public set linkRectToolIconButtonBackgroundColor(value: ResourceColor | undefined) {
    this._linkRectToolIconButtonBackgroundColor = value
  }

  public set linkRectToolIconTextSize(value: number) {
    this._linkRectToolIconTextSize = value
  }

  public set linkRectToolIconHeight(value: Length) {
    this._linkRectToolIconHeight = value
  }

  public set linkRectToolIconPadding(value: number) {
    this._linkRectToolIconPadding = value
  }

  public set linkRectToolIconBorderWidth(value: Length) {
    this._linkRectToolIconBorderWidth = value
  }

  public set linkRectToolIconDividingLineWidth(value: Length) {
    this._linkRectToolIconDividingLineWidth = value
  }

  public set linkRectToolIconMargin(value: number) {
    this._linkRectToolIconMargin = value
  }

  public set linkRectToolIconLineLeftPadding(value: number) {
    this._linkRectToolIconLineLeftPadding = value
  }

  public set linkRectToolIconLineRightPadding(value: number) {
    this._linkRectToolIconLineRightPadding = value
  }

  constructor() {
    super()
  }
}
