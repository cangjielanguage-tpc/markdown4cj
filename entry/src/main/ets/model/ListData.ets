import { BaseMDData } from "./BaseMDData"

export class ListData extends BaseMDData {
  // 有序列表样式
  _orderedListBackgroundColor: number | undefined = undefined // 有序列表背景颜色
  _orderedListMarginTop: number = 8 // 有序列表上外边距
  _orderedListMarginRight: number = 0 // 有序列表右外边距
  _orderedListMarginBottom: number = 8 // 有序列表下外边距
  _orderedListMarginLeft: number = 0 // 有序列表左外边距
  _orderedListPaddingTop: number = 0 // 有序列表上内边距
  _orderedListPaddingRight: number = 0 // 有序列表右内边距
  _orderedListPaddingBottom: number = 0 // 有序列表下内边距
  _orderedListPaddingLeft: number = 0 // 有序列表左内边距
  _orderedListChildSpacing: number = 4 // 有序列表子模块上下间距
  _orderedListChildChildSpacing: number = 4 // 有序列表子模块中子模块上下间距
  _orderedListMarkerSpacing: number = 8 // 有序列表列表编号和列表内容间距
  _orderedListMarkerTextFontColor: number | undefined = undefined // 有序列表列表编号文本颜色
  _orderedListMarkerTextFontSize: number = 14 // 有序列表列表编号文本尺寸
  _orderedListMarkerTextFontStyle: FontStyle = FontStyle.Normal // 有序列表列表编号文本字体样式
  _orderedListMarkerTextFontWeight: FontWeight = FontWeight.Normal // 有序列表列表编号文本字体粗细
  _orderedListMarkerTextFontFamily: string = 'HarmonyOS Sans' // 有序列表列表编号文本字体
  _orderedListMarkerTextLineHeight: number = 22 // 有序列表列表编号文本行高

  // 无序/任务列表样式
  _bulletListBackgroundColor: number | undefined = undefined // 无序/任务背景颜色
  _bulletListMarginTop: number = 8 // 无序/任务上外边距
  _bulletListMarginRight: number = 0 // 无序/任务右外边距
  _bulletListMarginBottom: number = 8 // 无序/任务下外边距
  _bulletListMarginLeft: number = 0 // 无序/任务左外边距
  _bulletListPaddingTop: number = 0 // 无序/任务上内边距
  _bulletListPaddingRight: number = 0 // 无序/任务右内边距
  _bulletListPaddingBottom: number = 0 // 无序/任务下内边距
  _bulletListPaddingLeft: number = 0 // 无序/任务左内边距
  _bulletListChildSpacing: number = 4 // 无序/任务子模块上下间距
  _bulletListChildChildSpacing: number = 4 // 无序/任务子模块中子模块上下间距
  _bulletListBulletSpacing: number = 8 // 无序列表列表符号和列表内容间距
  _bulletListBulletIsCircle: boolean = false // 无序列表列表符号是否全部是实心圆型
  _bulletListBulletTextFontColor: number | undefined = undefined // 无序列表列表符号文本颜色
  _bulletListBulletTextFontSize: number = 14 // 无序列表列表符号文本尺寸
  _bulletListBulletTextFontStyle: FontStyle = FontStyle.Normal // 无序列表列表符号文本字体样式
  _bulletListBulletTextFontWeight: FontWeight = FontWeight.Normal // 无序列表列表符号文本字体粗细
  _bulletListBulletTextFontFamily: string = 'HarmonyOS Sans' // 无序列表列表符号文本字体
  _bulletListBulletTextLineHeight: number = 22 // 无序列表列表符号文本行高
  _bulletListCheckboxSpacing: number = 8 // 任务列表多选框和列表内容间距
  _bulletListCheckboxWidth: number = 15 // 任务列表多选框宽度
  _bulletListCheckboxHeight: number = 15 // 任务列表多选框高度
  _bulletListCheckboxSelectedColor: number | undefined = undefined // 任务列表多选框选中颜色
  _bulletListCheckboxShape: CheckBoxShape = CheckBoxShape.CIRCLE // 任务列表多选框形状

  // Setter方法 - 有序列表
  public set orderedListBackgroundColor(value: number | undefined) {
    this._orderedListBackgroundColor = value
  }

  public set orderedListMarginTop(value: number) {
    this._orderedListMarginTop = value
  }

  public set orderedListMarginRight(value: number) {
    this._orderedListMarginRight = value
  }

  public set orderedListMarginBottom(value: number) {
    this._orderedListMarginBottom = value
  }

  public set orderedListMarginLeft(value: number) {
    this._orderedListMarginLeft = value
  }

  public set orderedListPaddingTop(value: number) {
    this._orderedListPaddingTop = value
  }

  public set orderedListPaddingRight(value: number) {
    this._orderedListPaddingRight = value
  }

  public set orderedListPaddingBottom(value: number) {
    this._orderedListPaddingBottom = value
  }

  public set orderedListPaddingLeft(value: number) {
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

  public set orderedListMarkerTextFontColor(value: number | undefined) {
    this._orderedListMarkerTextFontColor = value
  }

  public set orderedListMarkerTextFontSize(value: number) {
    this._orderedListMarkerTextFontSize = value
  }

  public set orderedListMarkerTextFontStyle(value: FontStyle) {
    this._orderedListMarkerTextFontStyle = value
  }

  public set orderedListMarkerTextFontWeight(value: FontWeight) {
    this._orderedListMarkerTextFontWeight = value
  }

  public set orderedListMarkerTextFontFamily(value: string) {
    this._orderedListMarkerTextFontFamily = value
  }

  public set orderedListMarkerTextLineHeight(value: number) {
    this._orderedListMarkerTextLineHeight = value
  }

  // Setter方法 - 无序/任务列表
  public set bulletListBackgroundColor(value: number | undefined) {
    this._bulletListBackgroundColor = value
  }

  public set bulletListMarginTop(value: number) {
    this._bulletListMarginTop = value
  }

  public set bulletListMarginRight(value: number) {
    this._bulletListMarginRight = value
  }

  public set bulletListMarginBottom(value: number) {
    this._bulletListMarginBottom = value
  }

  public set bulletListMarginLeft(value: number) {
    this._bulletListMarginLeft = value
  }

  public set bulletListPaddingTop(value: number) {
    this._bulletListPaddingTop = value
  }

  public set bulletListPaddingRight(value: number) {
    this._bulletListPaddingRight = value
  }

  public set bulletListPaddingBottom(value: number) {
    this._bulletListPaddingBottom = value
  }

  public set bulletListPaddingLeft(value: number) {
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

  public set bulletListBulletTextFontColor(value: number | undefined) {
    this._bulletListBulletTextFontColor = value
  }

  public set bulletListBulletTextFontSize(value: number) {
    this._bulletListBulletTextFontSize = value
  }

  public set bulletListBulletTextFontStyle(value: FontStyle) {
    this._bulletListBulletTextFontStyle = value
  }

  public set bulletListBulletTextFontWeight(value: FontWeight) {
    this._bulletListBulletTextFontWeight = value
  }

  public set bulletListBulletTextFontFamily(value: string) {
    this._bulletListBulletTextFontFamily = value
  }

  public set bulletListBulletTextLineHeight(value: number) {
    this._bulletListBulletTextLineHeight = value
  }

  public set bulletListCheckboxSpacing(value: number) {
    this._bulletListCheckboxSpacing = value
  }

  public set bulletListCheckboxWidth(value: number) {
    this._bulletListCheckboxWidth = value
  }

  public set bulletListCheckboxHeight(value: number) {
    this._bulletListCheckboxHeight = value
  }

  public set bulletListCheckboxSelectedColor(value: number | undefined) {
    this._bulletListCheckboxSelectedColor = value
  }

  public set bulletListCheckboxShape(value: CheckBoxShape) {
    this._bulletListCheckboxShape = value
  }

  constructor() {
    super()
  }
}
