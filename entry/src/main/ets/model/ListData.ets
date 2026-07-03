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

  constructor() {
    super()
  }
}
