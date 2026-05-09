import { BaseMDData } from "./BaseMDData"

export class LinkData extends BaseMDData {
  _linkIsIcon: boolean = false // 链接是否是图片显示
  _linkListIsIcon: boolean = false // 列表中的单行链接是否是图片显示
  _linkTextFontColor: number | undefined = undefined // 链接文本颜色
  _linkTextFontSize: number = 14 // 链接文本尺寸
  _linkTextFontStyle: FontStyle = FontStyle.Normal // 链接文本字体样式
  _linkTextFontWeight: FontWeight = FontWeight.Normal // 链接文本字体粗细
  _linkTextFontFamily: string = 'HarmonyOS Sans' // 链接文本字体
  _linkTextLineHeight: number = 22 // 链接文本行高
  _linkTextLetterSpacing: number = 0 // 链接文本字符间距
  _linkTextDecorationType: TextDecorationType = TextDecorationType.None // 链接文本装饰线类型
  _linkTextDecorationColor: number | undefined = undefined // 链接文本装饰线颜色
  _linkTextDecorationStyle: TextDecorationStyle = TextDecorationStyle.SOLID // 链接文本装饰线样式
  _linkTextBackgroundColor: number | undefined = undefined // 链接文本背景颜色
  _linkTextBackgroundRadiusTopLeft: number = 0 // 链接文本背景左上圆角
  _linkTextBackgroundRadiusTopRight: number = 0 // 链接文本背景右上圆角
  _linkTextBackgroundRadiusBottomLeft: number = 0 // 链接文本背景左下圆角
  _linkTextBackgroundRadiusBottomRight: number = 0 // 链接文本背景右下圆角
  _linkCircleIconBackgroundColor: number | undefined = undefined // 圆形图片格式链接主题背景颜色
  _linkCircleIconButtonBackgroundColor: number | undefined = undefined // 圆形图片格式链接控件背景颜色
  _linkCircleIconTextSize: number = 14 // 圆形图片格式链接文字大小
  _linkCircleIconTextColor: number | undefined = undefined // 圆形图片格式链接文字颜色
  _linkCircleIconRadius: number = 20 // 圆形图片格式链接半径
  _linkCircleIconMargin: number = 6 // 圆形图片格式链接左右外边距
  _linkRectIconBackgroundColor: number | undefined = undefined // 圆角矩形图片格式链接主题背景颜色
  _linkRectIconButtonBackgroundColor: number | undefined = undefined // 圆角矩形图片格式链接控件背景颜色
  _linkRectIconTextSize: number = 14 // 圆角矩形图片格式链接文字大小
  _linkRectIconTextColor: number | undefined = undefined // 圆角矩形图片格式链接文字颜色
  _linkRectIconHeight: number = 20 // 圆角矩形图片格式链接控件高度
  _linkRectIconPadding: number = 6 // 圆角矩形图片格式链接左右内边距
  _linkRectIconRadius: number = 6 // 圆角矩形图片格式链接圆角半径
  _linkRectIconMargin: number = 6 // 圆角矩形图片格式链接左右外边距
  _linkRectToolIconBackgroundColor: number | undefined = undefined // 空心圆角矩形图片格式链接主题背景颜色
  _linkRectToolIconButtonBackgroundColor: number | undefined = undefined // 空心圆角矩形图片格式链接控件背景颜色
  _linkRectToolIconTextSize: number = 14 // 空心圆角矩形图片格式链接文字大小
  _linkRectToolIconHeight: number = 21 // 空心圆角矩形图片格式链接控件高度
  _linkRectToolIconPadding: number = 6 // 空心圆角矩形图片格式链接左右内边距
  _linkRectToolIconBorderWidth: number = 1 // 空心圆角矩形图片格式链接边框宽度
  _linkRectToolIconDividingLineWidth: number = 1 // 空心圆角矩形图片格式链接分割线宽度
  _linkRectToolIconMargin: number = 6 // 空心圆角矩形图片格式链接左右外边距
  _linkRectToolIconLineLeftPadding: number = 3 // 空心圆角矩形图片格式分割线和文本左边距
  _linkRectToolIconLineRightPadding: number = 3 // 空心圆角矩形图片格式分割线和文本右边距

  public set linkIsIcon(value: boolean) {
    this._linkIsIcon = value
  }

  public set linkListIsIcon(value: boolean) {
    this._linkListIsIcon = value
  }

  public set linkTextFontColor(value: number | undefined) {
    this._linkTextFontColor = value
  }

  public set linkTextFontSize(value: number) {
    this._linkTextFontSize = value
  }

  public set linkTextFontStyle(value: FontStyle) {
    this._linkTextFontStyle = value
  }

  public set linkTextFontWeight(value: FontWeight) {
    this._linkTextFontWeight = value
  }

  public set linkTextFontFamily(value: string) {
    this._linkTextFontFamily = value
  }

  public set linkTextLineHeight(value: number) {
    this._linkTextLineHeight = value
  }

  public set linkTextLetterSpacing(value: number) {
    this._linkTextLetterSpacing = value
  }

  public set linkTextDecorationType(value: TextDecorationType) {
    this._linkTextDecorationType = value
  }

  public set linkTextDecorationColor(value: number | undefined) {
    this._linkTextDecorationColor = value
  }

  public set linkTextDecorationStyle(value: TextDecorationStyle) {
    this._linkTextDecorationStyle = value
  }

  public set linkTextBackgroundColor(value: number | undefined) {
    this._linkTextBackgroundColor = value
  }

  public set linkTextBackgroundRadiusTopLeft(value: number) {
    this._linkTextBackgroundRadiusTopLeft = value
  }

  public set linkTextBackgroundRadiusTopRight(value: number) {
    this._linkTextBackgroundRadiusTopRight = value
  }

  public set linkTextBackgroundRadiusBottomLeft(value: number) {
    this._linkTextBackgroundRadiusBottomLeft = value
  }

  public set linkTextBackgroundRadiusBottomRight(value: number) {
    this._linkTextBackgroundRadiusBottomRight = value
  }

  public set linkCircleIconBackgroundColor(value: number | undefined) {
    this._linkCircleIconBackgroundColor = value
  }

  public set linkCircleIconButtonBackgroundColor(value: number | undefined) {
    this._linkCircleIconButtonBackgroundColor = value
  }

  public set linkCircleIconTextSize(value: number) {
    this._linkCircleIconTextSize = value
  }

  public set linkCircleIconTextColor(value: number | undefined) {
    this._linkCircleIconTextColor = value
  }

  public set linkCircleIconRadius(value: number) {
    this._linkCircleIconRadius = value
  }

  public set linkCircleIconMargin(value: number) {
    this._linkCircleIconMargin = value
  }

  public set linkRectIconBackgroundColor(value: number | undefined) {
    this._linkRectIconBackgroundColor = value
  }

  public set linkRectIconButtonBackgroundColor(value: number | undefined) {
    this._linkRectIconButtonBackgroundColor = value
  }

  public set linkRectIconTextSize(value: number) {
    this._linkRectIconTextSize = value
  }

  public set linkRectIconTextColor(value: number | undefined) {
    this._linkRectIconTextColor = value
  }

  public set linkRectIconHeight(value: number) {
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

  public set linkRectToolIconBackgroundColor(value: number | undefined) {
    this._linkRectToolIconBackgroundColor = value
  }

  public set linkRectToolIconButtonBackgroundColor(value: number | undefined) {
    this._linkRectToolIconButtonBackgroundColor = value
  }

  public set linkRectToolIconTextSize(value: number) {
    this._linkRectToolIconTextSize = value
  }

  public set linkRectToolIconHeight(value: number) {
    this._linkRectToolIconHeight = value
  }

  public set linkRectToolIconPadding(value: number) {
    this._linkRectToolIconPadding = value
  }

  public set linkRectToolIconBorderWidth(value: number) {
    this._linkRectToolIconBorderWidth = value
  }

  public set linkRectToolIconDividingLineWidth(value: number) {
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
