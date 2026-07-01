import { BaseMDData } from "./BaseMDData"

export class ListData extends BaseMDData {
  // 有序列表样式
  _orderedListBackgroundColor: ResourceColor | undefined = undefined // 有序列表背景颜色
  _orderedListMarginTop: Length = 0.0 // 有序列表外边距上
  _orderedListMarginRight: Length = 0.0 // 有序列表外边距右
  _orderedListMarginBottom: Length = 0.0 // 有序列表外边距下
  _orderedListMarginLeft: Length = 8.0 // 有序列表外边距左
  _orderedListPaddingTop: Length = 0.0 // 有序列表内边距上
  _orderedListPaddingRight: Length = 0.0 // 有序列表内边距右
  _orderedListPaddingBottom: Length = 0.0 // 有序列表内边距下
  _orderedListPaddingLeft: Length = 0.0 // 有序列表内边距左
  _orderedListChildSpacing: number = 8 // 有序列表子项间距
  _orderedListChildChildSpacing: number = 8 // 有序列表子子项间距
  _orderedListMarkerSpacing: number = 8.0 // 有序列表标记间距
  _orderedListMarkerTextFontColor: ResourceColor | undefined = undefined // 有序列表标记文本字体颜色
  _orderedListMarkerTextFontSize: number | string | Resource = 14.0 // 有序列表标记文本字体大小
  _orderedListMarkerTextFontStyle: FontStyle = FontStyle.Normal // 有序列表标记文本字体样式
  _orderedListMarkerTextFontWeight: number | FontWeight = FontWeight.Normal // 有序列表标记文本字体粗细
  _orderedListMarkerTextFontFamily: string | Resource = 'HarmonyOS Sans' // 有序列表标记文本字体族
  _orderedListMarkerTextLineHeight: number | string | Resource = 22.0 // 有序列表标记文本行高

  // 无序/任务列表样式
  _bulletListBackgroundColor: ResourceColor | undefined = undefined // 无序/任务列表背景颜色
  _bulletListMarginTop: Length = 0.0 // 无序/任务列表外边距上
  _bulletListMarginRight: Length = 0.0 // 无序/任务列表外边距右
  _bulletListMarginBottom: Length = 0.0 // 无序/任务列表外边距下
  _bulletListMarginLeft: Length = 8.0 // 无序/任务列表外边距左
  _bulletListPaddingTop: Length = 0.0 // 无序/任务列表内边距上
  _bulletListPaddingRight: Length = 0.0 // 无序/任务列表内边距右
  _bulletListPaddingBottom: Length = 0.0 // 无序/任务列表内边距下
  _bulletListPaddingLeft: Length = 0.0 // 无序/任务列表内边距左
  _bulletListChildSpacing: number = 8 // 无序/任务列表子项间距
  _bulletListChildChildSpacing: number = 8 // 无序/任务列表子子项间距
  _bulletListBulletSpacing: number = 8.0 // 无序/任务列表标记间距
  _bulletListBulletIsCircle: boolean = false // 无序/任务列表标记是否圆形
  _bulletListBulletTextFontColor: ResourceColor | undefined = undefined // 无序/任务列表标记文本字体颜色
  _bulletListBulletTextFontSize: number | string | Resource = 4.0 // 无序/任务列表标记文本字体大小
  _bulletListBulletTextFontStyle: FontStyle = FontStyle.Normal // 无序/任务列表标记文本字体样式
  _bulletListBulletTextFontWeight: number | FontWeight = FontWeight.Normal // 无序/任务列表标记文本字体粗细
  _bulletListBulletTextFontFamily: string | Resource = 'HarmonyOS Sans' // 无序/任务列表标记文本字体族
  _bulletListBulletTextLineHeight: number | string | Resource = 18.0 // 无序/任务列表标记文本行高
  _bulletListCheckboxSpacing: number = 8.0 // 无序/任务列表复选框间距
  _bulletListCheckboxWidth: Length = 15.0 // 无序/任务列表复选框宽度
  _bulletListCheckboxHeight: Length = 15.0 // 无序/任务列表复选框高度
  _bulletListCheckboxSelectedColor: ResourceColor | undefined = undefined // 无序/任务列表复选框选中颜色
  _bulletListCheckboxShape: CheckBoxShape = CheckBoxShape.ROUNDED_SQUARE // 无序/任务列表复选框形状

  // Setter方法 - 有序列表
  public set orderedListBackgroundColor(value: ResourceColor | undefined) {
    this._orderedListBackgroundColor = value
  }

  public set orderedListMarginTop(value: Length) {
    this._orderedListMarginTop = value
  }

  public set orderedListMarginRight(value: Length) {
    this._orderedListMarginRight = value
  }

  public set orderedListMarginBottom(value: Length) {
    this._orderedListMarginBottom = value
  }

  public set orderedListMarginLeft(value: Length) {
    this._orderedListMarginLeft = value
  }

  public set orderedListPaddingTop(value: Length) {
    this._orderedListPaddingTop = value
  }

  public set orderedListPaddingRight(value: Length) {
    this._orderedListPaddingRight = value
  }

  public set orderedListPaddingBottom(value: Length) {
    this._orderedListPaddingBottom = value
  }

  public set orderedListPaddingLeft(value: Length) {
    this._orderedListPaddingLeft = value
  }

  public set orderedListChildSpacing(value: number) {
    this._orderedListChildSpacing = value
  }

  public set orderedListChildChildSpacing(value: number) {
    this._orderedListChildChildSpacing = value
  }

  public set orderedListMarkerSpacing(value: number) {
    this._orderedListMarkerSpacing = value
  }

  public set orderedListMarkerTextFontColor(value: ResourceColor | undefined) {
    this._orderedListMarkerTextFontColor = value
  }

  public set orderedListMarkerTextFontSize(value: number | string | Resource) {
    this._orderedListMarkerTextFontSize = value
  }

  public set orderedListMarkerTextFontStyle(value: FontStyle) {
    this._orderedListMarkerTextFontStyle = value
  }

  public set orderedListMarkerTextFontWeight(value: number | FontWeight) {
    this._orderedListMarkerTextFontWeight = value
  }

  public set orderedListMarkerTextFontFamily(value: string | Resource) {
    this._orderedListMarkerTextFontFamily = value
  }

  public set orderedListMarkerTextLineHeight(value: number | string | Resource) {
    this._orderedListMarkerTextLineHeight = value
  }

  // Setter方法 - 无序/任务列表
  public set bulletListBackgroundColor(value: ResourceColor | undefined) {
    this._bulletListBackgroundColor = value
  }

  public set bulletListMarginTop(value: Length) {
    this._bulletListMarginTop = value
  }

  public set bulletListMarginRight(value: Length) {
    this._bulletListMarginRight = value
  }

  public set bulletListMarginBottom(value: Length) {
    this._bulletListMarginBottom = value
  }

  public set bulletListMarginLeft(value: Length) {
    this._bulletListMarginLeft = value
  }

  public set bulletListPaddingTop(value: Length) {
    this._bulletListPaddingTop = value
  }

  public set bulletListPaddingRight(value: Length) {
    this._bulletListPaddingRight = value
  }

  public set bulletListPaddingBottom(value: Length) {
    this._bulletListPaddingBottom = value
  }

  public set bulletListPaddingLeft(value: Length) {
    this._bulletListPaddingLeft = value
  }

  public set bulletListChildSpacing(value: number) {
    this._bulletListChildSpacing = value
  }

  public set bulletListChildChildSpacing(value: number) {
    this._bulletListChildChildSpacing = value
  }

  public set bulletListBulletSpacing(value: number) {
    this._bulletListBulletSpacing = value
  }

  public set bulletListBulletIsCircle(value: boolean) {
    this._bulletListBulletIsCircle = value
  }

  public set bulletListBulletTextFontColor(value: ResourceColor | undefined) {
    this._bulletListBulletTextFontColor = value
  }

  public set bulletListBulletTextFontSize(value: number | string | Resource) {
    this._bulletListBulletTextFontSize = value
  }

  public set bulletListBulletTextFontStyle(value: FontStyle) {
    this._bulletListBulletTextFontStyle = value
  }

  public set bulletListBulletTextFontWeight(value: number | FontWeight) {
    this._bulletListBulletTextFontWeight = value
  }

  public set bulletListBulletTextFontFamily(value: string | Resource) {
    this._bulletListBulletTextFontFamily = value
  }

  public set bulletListBulletTextLineHeight(value: number | string | Resource) {
    this._bulletListBulletTextLineHeight = value
  }

  public set bulletListCheckboxSpacing(value: number) {
    this._bulletListCheckboxSpacing = value
  }

  public set bulletListCheckboxWidth(value: Length) {
    this._bulletListCheckboxWidth = value
  }

  public set bulletListCheckboxHeight(value: Length) {
    this._bulletListCheckboxHeight = value
  }

  public set bulletListCheckboxSelectedColor(value: ResourceColor | undefined) {
    this._bulletListCheckboxSelectedColor = value
  }

  public set bulletListCheckboxShape(value: CheckBoxShape) {
    this._bulletListCheckboxShape = value
  }

  constructor() {
    super()
  }
}
