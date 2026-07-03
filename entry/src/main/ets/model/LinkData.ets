import { BaseMDData } from "./BaseMDData"

export class LinkData extends BaseMDData {
  _isLinkifyPlugin: boolean = false // 是否加载链接自动解析插件
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

  constructor() {
    super()
  }
}
