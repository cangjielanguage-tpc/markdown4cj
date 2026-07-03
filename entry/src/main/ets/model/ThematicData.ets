import { BaseMDData } from "./BaseMDData"

export class ThematicData extends BaseMDData {
  _dividerMarginTop: Length = 0.0 // 分割线上外边距
  _dividerMarginRight: Length = 0.0 // 分割线右外边距
  _dividerMarginBottom: Length = 0.0 // 分割线下外边距
  _dividerMarginLeft: Length = 0.0 // 分割线左外边距
  _dividerPaddingTop: Length = 0.0 // 分割线上内边距
  _dividerPaddingRight: Length = 0.0 // 分割线右内边距
  _dividerPaddingBottom: Length = 0.0 // 分割线下内边距
  _dividerPaddingLeft: Length = 0.0 // 分割线左内边距
  _dividerColor: ResourceColor | undefined = undefined // 分割线颜色
  _dividerStrokeWidth: number = 0.5 // 分割线宽度
  _dividerStyle: LineCapStyle = LineCapStyle.Butt // 分割线端点样式

  constructor() {
    super()
  }
}