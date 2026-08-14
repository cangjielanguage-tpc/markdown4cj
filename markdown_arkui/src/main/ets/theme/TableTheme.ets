import { MarkdownBaseTheme } from './MarkdownBaseTheme'
import {
  COLOR_WHITE,
  COLOR_BLACK,
  COLOR_FF191919,
  COLOR_FFE0E0E0,
  COLOR_FF191919_SCB,
  isMargin,
  isPadding,
  isBorderRadiuses
} from "../base/Constants"

/**
 * 表格样式配置
 */
@Observed
export class TableTheme implements MarkdownBaseTheme {
  tableTitleBackgroundColor: ResourceColor = COLOR_WHITE // 表格标题背景颜色
  tableContentOddRowBackgroundColor: ResourceColor = COLOR_FFE0E0E0 // 表格内容奇数行背景颜色
  tableContentEvenRowBackgroundColor: ResourceColor = COLOR_WHITE // 表格内容偶数行背景颜色
  tableMarginTop: Length = 0.0 // 上边距
  tableMarginRight: Length = 0.0 // 右边距
  tableMarginBottom: Length = 0.0 // 下边距
  tableMarginLeft: Length = 0.0 // 左边距
  tablePaddingTop: Length = 0.0 // 上内边距
  tablePaddingRight: Length = 0.0 // 右内边距
  tablePaddingBottom: Length = 0.0 // 下内边距
  tablePaddingLeft: Length = 0.0 // 左内边距
  tableCellPaddingTop: Length = 4.0 // 单元格上内边距
  tableCellPaddingRight: Length = 4.0 // 单元格右内边距
  tableCellPaddingBottom: Length = 4.0 // 单元格下内边距
  tableCellPaddingLeft: Length = 4.0 // 单元格左内边距
  tableBorderStyle: BorderStyle = BorderStyle.Solid // 边框样式
  tableBorderWidth: Length = 1.0 // 边框宽度
  tableBorderColor: ResourceColor = COLOR_BLACK // 边框颜色
  tableRadiusTopLeft: Length = 5.0 // 左上圆角
  tableRadiusTopRight: Length = 5.0 // 右上圆角
  tableRadiusBottomLeft: Length = 5.0 // 左下圆角
  tableRadiusBottomRight: Length = 5.0 // 右下圆角
  tableScrollBarState: BarState = BarState.Off // 滚动条状态
  tableScrollBarColor: Color | number | string = COLOR_FF191919_SCB // 滚动条颜色
  tableMinCellWidth: Length = 50.0 // 最小单元格宽度
  tableMaxCellWidth: Length = 300.0 // 最大单元格宽度
  tableFirstColumnIsBold: boolean = false // 第一列加粗
  tableTitleTextFontColor: ResourceColor = COLOR_FF191919 // 标题文字字体颜色
  tableTitleTextFontSize: number | string | Resource = 14.0 // 标题文字字体大小
  tableTitleTextFontStyle: FontStyle = FontStyle.Normal // 标题文字字体样式
  tableTitleTextFontWeight: number | FontWeight = FontWeight.Bold // 标题文字字体粗细
  tableTitleTextFontFamily: string | Resource = 'HarmonyOS Sans' // 标题文字字体族
  tableTitleTextLineHeight: number | string | Resource = 22.0 // 标题文字行高
  tableTitleTextLetterSpacing: number = 0.0 // 标题文字字间距
  tableContentTextFontColor: ResourceColor = COLOR_FF191919 // 内容文字字体颜色
  tableContentTextFontSize: number | string | Resource = 14.0 // 内容文字字体大小
  tableContentTextFontStyle: FontStyle = FontStyle.Normal // 内容文字字体样式
  tableContentTextFontWeight: number | FontWeight = FontWeight.Normal // 内容文字字体粗细
  tableContentTextFontFamily: string | Resource = 'HarmonyOS Sans' // 内容文字字体族
  tableContentTextLineHeight: number | string | Resource = 22.0 // 内容文字行高
  tableContentTextLetterSpacing: number = 0.0 // 内容文字字间距
  tableStickyHeader: boolean = false // 表格标题行是否吸顶（仅当外层 List 可滚动时生效）

  //下面是表格的
  tableHeadIsShow: boolean = true // 表格头复制按钮是否显示
  tableHeadTitleText: string = '比较' // 表格头标题
  tableHeadTitleTextFontFamily: string | Resource | undefined = undefined // 表格头标题类型文本字体族
  tableHeadTitleTextFontSize: number | string | Resource | undefined = undefined // 表格头标题类型文本字体大小
  tableHeadTitleTextFontWeight: number | FontWeight | undefined = undefined // 表格头标题类型文本字体粗细
  tableHeadTitleTextFontStyle: FontStyle | undefined = undefined // 表格头标题类型文本字体样式
  tableHeadTitleTextFontColor: ResourceColor | undefined = undefined // 表格头标题类型文本字体颜色
  tableHeadTitleTextLineHeight: number | string | Resource | undefined = undefined // 表格头标题类型文本行高
  tableHeadTitleTextMarginLeft: Length = 0.0 // 表格头标题类型文本左边距

  tableHeadCopyIcon: Resource | undefined = undefined // 表格头复制图标
  tableHeadCopyIconWidth: Length = 24.0 // 表格头复制图标宽度
  tableHeadCopyIconHeight: Length = 24.0 // 表格头复制图标高度
  tableHeadCopyIconMarginRight: Length = 0.0 // 表格头复制图标右边距



  /**
   * 设置表格标题背景颜色
   *
   * @param color 颜色
   * @return TableTheme
   */
  setTableTitleBackgroundColor(color: ResourceColor): TableTheme {
    this.tableTitleBackgroundColor = color
    return this
  }

  /**
   * 设置表格内容奇数行背景颜色
   *
   * @param color 颜色
   * @return TableTheme
   */
  setTableContentOddRowBackgroundColor(color: ResourceColor): TableTheme {
    this.tableContentOddRowBackgroundColor = color
    return this
  }

  /**
   * 设置表格内容偶数行背景颜色
   *
   * @param color 颜色
   * @return TableTheme
   */
  setTableContentEvenRowBackgroundColor(color: ResourceColor): TableTheme {
    this.tableContentEvenRowBackgroundColor = color
    return this
  }

  /**
   * 设置表格边距
   *
   * @param options 边距选项
   * @return TableTheme
   */
  setTableMargin(options: Margin | Length): TableTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.tableMarginTop = options
      this.tableMarginRight = options
      this.tableMarginBottom = options
      this.tableMarginLeft = options
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin
        if (margin.top !== undefined) {
          this.tableMarginTop = margin.top
        }
        if (margin.right !== undefined) {
          this.tableMarginRight = margin.right
        }
        if (margin.bottom !== undefined) {
          this.tableMarginBottom = margin.bottom
        }
        if (margin.left !== undefined) {
          this.tableMarginLeft = margin.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.tableMarginTop = options as Length
        this.tableMarginRight = options as Length
        this.tableMarginBottom = options as Length
        this.tableMarginLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置表格内边距
   *
   * @param options 内边距选项
   * @return TableTheme
   */
  setTablePadding(options: Padding | Length): TableTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.tablePaddingTop = options
      this.tablePaddingRight = options
      this.tablePaddingBottom = options
      this.tablePaddingLeft = options
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        const padding = options as Padding
        if (padding.top !== undefined) {
          this.tablePaddingTop = padding.top
        }
        if (padding.right !== undefined) {
          this.tablePaddingRight = padding.right
        }
        if (padding.bottom !== undefined) {
          this.tablePaddingBottom = padding.bottom
        }
        if (padding.left !== undefined) {
          this.tablePaddingLeft = padding.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.tablePaddingTop = options as Length
        this.tablePaddingRight = options as Length
        this.tablePaddingBottom = options as Length
        this.tablePaddingLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置单元格内边距
   *
   * @param options 内边距选项
   * @return TableTheme
   */
  setTableCellPadding(options: Padding | Length): TableTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.tableCellPaddingTop = options
      this.tableCellPaddingRight = options
      this.tableCellPaddingBottom = options
      this.tableCellPaddingLeft = options
    }
    // 2. 如果是 object，它要么是 Padding，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Padding 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Padding 处理
      if (isPadding(options)) {
        const padding = options as Padding
        if (padding.top !== undefined) {
          this.tableCellPaddingTop = padding.top
        }
        if (padding.right !== undefined) {
          this.tableCellPaddingRight = padding.right
        }
        if (padding.bottom !== undefined) {
          this.tableCellPaddingBottom = padding.bottom
        }
        if (padding.left !== undefined) {
          this.tableCellPaddingLeft = padding.left
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.tableCellPaddingTop = options as Length
        this.tableCellPaddingRight = options as Length
        this.tableCellPaddingBottom = options as Length
        this.tableCellPaddingLeft = options as Length
      }
    }
    return this
  }

  /**
   * 设置表格边框样式
   *
   * @param style 边框样式
   * @return TableTheme
   */
  setTableBorderStyle(style: BorderStyle): TableTheme {
    this.tableBorderStyle = style
    return this
  }

  /**
   * 设置表格边框宽度
   *
   * @param width 边框宽度
   * @return TableTheme
   */
  setTableBorderWidth(width: Length): TableTheme {
    this.tableBorderWidth = width
    return this
  }

  /**
   * 设置表格边框颜色
   *
   * @param color 颜色
   * @return TableTheme
   */
  setTableBorderColor(color: ResourceColor): TableTheme {
    this.tableBorderColor = color
    return this
  }

  /**
   * 设置表格圆角
   *
   * @param options 圆角选项
   * @return TableTheme
   */
  setTableRadius(options: BorderRadiuses | Length): TableTheme {
    // 1. 如果是 number 或 string，直接四角统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.tableRadiusTopLeft = options
      this.tableRadiusTopRight = options
      this.tableRadiusBottomLeft = options
      this.tableRadiusBottomRight = options
    }
    // 2. 如果是 object，它要么是 BorderRadiuses，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 BorderRadiuses 的专属属性来区分
      // 如果包含 topLeft/topRight/bottomLeft/bottomRight 任意一个，就当作 BorderRadiuses 处理
      if (isBorderRadiuses(options)) {
        const radius = options as BorderRadiuses
        if (radius.topLeft !== undefined) {
          this.tableRadiusTopLeft = radius.topLeft
        }
        if (radius.topRight !== undefined) {
          this.tableRadiusTopRight = radius.topRight
        }
        if (radius.bottomLeft !== undefined) {
          this.tableRadiusBottomLeft = radius.bottomLeft
        }
        if (radius.bottomRight !== undefined) {
          this.tableRadiusBottomRight = radius.bottomRight
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.tableRadiusTopLeft = options as Length
        this.tableRadiusTopRight = options as Length
        this.tableRadiusBottomLeft = options as Length
        this.tableRadiusBottomRight = options as Length
      }
    }
    return this
  }

  /**
   * 设置表格滚动条状态
   *
   * @param state 滚动条状态
   * @return TableTheme
   */
  setTableScrollBarState(state: BarState): TableTheme {
    this.tableScrollBarState = state
    return this
  }

  /**
   * 设置表格滚动条颜色
   *
   * @param color 颜色
   * @return TableTheme
   */
  setTableScrollBarColor(color: Color | number | string): TableTheme {
    this.tableScrollBarColor = color
    return this
  }

  /**
   * 设置表格最小单元格宽度
   *
   * @param width 最小单元格宽度
   * @return TableTheme
   */
  setTableMinCellWidth(width: Length): TableTheme {
    this.tableMinCellWidth = width
    return this
  }

  /**
   * 设置表格最大单元格宽度
   *
   * @param width 最大单元格宽度
   * @return TableTheme
   */
  setTableMaxCellWidth(width: Length): TableTheme {
    this.tableMaxCellWidth = width
    return this
  }

  /**
   * 设置表格第一列是否加粗
   *
   * @param isBold 是否加粗
   * @return TableTheme
   */
  setTableFirstColumnIsBold(isBold: boolean): TableTheme {
    this.tableFirstColumnIsBold = isBold
    return this
  }

  /**
   * 设置表格标题文字字体颜色
   *
   * @param color 颜色
   * @return TableTheme
   */
  setTableTitleTextFontColor(color: ResourceColor): TableTheme {
    this.tableTitleTextFontColor = color
    return this
  }

  /**
   * 设置表格标题文字字体大小
   *
   * @param size 字体大小
   * @return TableTheme
   */
  setTableTitleTextFontSize(size: number | string | Resource): TableTheme {
    this.tableTitleTextFontSize = size
    return this
  }

  /**
   * 设置表格标题文字字体样式
   *
   * @param style 字体样式
   * @return TableTheme
   */
  setTableTitleTextFontStyle(style: FontStyle): TableTheme {
    this.tableTitleTextFontStyle = style
    return this
  }

  /**
   * 设置表格标题文字字体粗细
   *
   * @param weight 字体粗细
   * @return TableTheme
   */
  setTableTitleTextFontWeight(weight: number | FontWeight): TableTheme {
    this.tableTitleTextFontWeight = weight
    return this
  }

  /**
   * 设置表格标题文字字体族
   *
   * @param family 字体族
   * @return TableTheme
   */
  setTableTitleTextFontFamily(family: string | Resource): TableTheme {
    this.tableTitleTextFontFamily = family
    return this
  }

  /**
   * 设置表格标题文字行高
   *
   * @param lineHeight 行高
   * @return TableTheme
   */
  setTableTitleTextLineHeight(lineHeight: number | string | Resource): TableTheme {
    this.tableTitleTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置表格标题文字字间距
   *
   * @param spacing 字间距
   * @return TableTheme
   */
  setTableTitleTextLetterSpacing(spacing: number): TableTheme {
    this.tableTitleTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置表格内容文字字体颜色
   *
   * @param color 颜色
   * @return TableTheme
   */
  setTableContentTextFontColor(color: ResourceColor): TableTheme {
    this.tableContentTextFontColor = color
    return this
  }

  /**
   * 设置表格内容文字字体大小
   *
   * @param size 字体大小
   * @return TableTheme
   */
  setTableContentTextFontSize(size: number | string | Resource): TableTheme {
    this.tableContentTextFontSize = size
    return this
  }

  /**
   * 设置表格内容文字字体样式
   *
   * @param style 字体样式
   * @return TableTheme
   */
  setTableContentTextFontStyle(style: FontStyle): TableTheme {
    this.tableContentTextFontStyle = style
    return this
  }

  /**
   * 设置表格内容文字字体粗细
   *
   * @param weight 字体粗细
   * @return TableTheme
   */
  setTableContentTextFontWeight(weight: number | FontWeight): TableTheme {
    this.tableContentTextFontWeight = weight
    return this
  }

  /**
   * 设置表格内容文字字体族
   *
   * @param family 字体族
   * @return TableTheme
   */
  setTableContentTextFontFamily(family: string | Resource): TableTheme {
    this.tableContentTextFontFamily = family
    return this
  }

  /**
   * 设置表格内容文字行高
   *
   * @param lineHeight 行高
   * @return TableTheme
   */
  setTableContentTextLineHeight(lineHeight: number | string | Resource): TableTheme {
    this.tableContentTextLineHeight = lineHeight
    return this
  }

  /**
   * 设置表格内容文字字间距
   *
   * @param spacing 字间距
   * @return TableTheme
   */
  setTableContentTextLetterSpacing(spacing: number): TableTheme {
    this.tableContentTextLetterSpacing = spacing
    return this
  }

  /**
   * 设置表格标题行是否吸顶
   * 开启后表格将以 ListItemGroup 形式直接渲染在外层 List 中，
   * 标题行作为 group header 在外层 List 滚动时天然吸顶；
   * 关闭后回退为 Scroll>List>rows 的传统结构（标题不吸顶）。
   * 注意：仅当外层 List 有固定高度可滚动时吸顶才可见；不固定高度时无滚动，吸顶不触发。
   *
   * @param enable 是否吸顶
   * @return TableTheme
   */
  setTableStickyHeader(enable: boolean): TableTheme {
    this.tableStickyHeader = enable
    return this
  }


  /**
   * 设置表格头是否显示
   *
   * @param enable 是否显示表头 true显示 false不显示
   * @return TableTheme
   */
  setTableHeadIsShow(enable: boolean): TableTheme {
    this.tableHeadIsShow = enable;
    return this;
  }


  /**
   * 设置表格头标题文本
   *
   * @param text 标题文本
   * @return TableTheme
   */
  setTableHeadTitleText(text: string): TableTheme {
    this.tableHeadTitleText = text;
    return this;
  }

  /**
   * 设置表格头标题文本字体族
   *
   * @param family 字体族
   * @return TableTheme
   */
  setTableHeadTitleTextFontFamily(family: string | Resource | undefined): TableTheme {
    this.tableHeadTitleTextFontFamily = family;
    return this;
  }

  /**
   * 设置表格头标题文本字体大小
   *
   * @param size 字体大小
   * @return TableTheme
   */
  setTableHeadTitleTextFontSize(size: number | string | Resource | undefined): TableTheme {
    this.tableHeadTitleTextFontSize = size;
    return this;
  }

  /**
   * 设置表格头标题文本字体粗细
   *
   * @param weight 字体粗细
   * @return TableTheme
   */
  setTableHeadTitleTextFontWeight(weight: number | FontWeight | undefined): TableTheme {
    this.tableHeadTitleTextFontWeight = weight;
    return this;
  }

  /**
   * 设置表格头标题文本字体样式
   *
   * @param style 字体样式
   * @return TableTheme
   */
  setTableHeadTitleTextFontStyle(style: FontStyle | undefined): TableTheme {
    this.tableHeadTitleTextFontStyle = style;
    return this;
  }

  /**
   * 设置表格头标题文本字体颜色
   *
   * @param color 颜色
   * @return TableTheme
   */
  setTableHeadTitleTextFontColor(color: ResourceColor | undefined): TableTheme {
    this.tableHeadTitleTextFontColor = color;
    return this;
  }

  /**
   * 设置表格头标题文本行高
   *
   * @param lineHeight 行高
   * @return TableTheme
   */
  setTableHeadTitleTextLineHeight(lineHeight: number | string | Resource | undefined): TableTheme {
    this.tableHeadTitleTextLineHeight = lineHeight;
    return this;
  }

  /**
   * 设置表格头标题文本左边距
   *
   * @param marginLeft 左边距
   * @return TableTheme
   */
  setTableHeadTitleTextMarginLeft(marginLeft: Length): TableTheme {
    this.tableHeadTitleTextMarginLeft = marginLeft;
    return this;
  }

  /**
   * 设置表格头复制图标
   *
   * @param icon 图标资源
   * @return TableTheme
   */
  setTableHeadCopyIcon(icon: Resource | undefined): TableTheme {
    this.tableHeadCopyIcon = icon;
    return this;
  }

  /**
   * 设置表格头复制图标宽度
   *
   * @param width 宽度
   * @return TableTheme
   */
  setTableHeadCopyIconWidth(width: Length): TableTheme {
    this.tableHeadCopyIconWidth = width;
    return this;
  }

  /**
   * 设置表格头复制图标高度
   *
   * @param height 高度
   * @return TableTheme
   */
  setTableHeadCopyIconHeight(height: Length): TableTheme {
    this.tableHeadCopyIconHeight = height;
    return this;
  }

  /**
   * 设置表格头复制图标右边距
   *
   * @param marginRight 右边距
   * @return TableTheme
   */
  setTableHeadCopyIconMarginRight(marginRight: Length): TableTheme {
    this.tableHeadCopyIconMarginRight = marginRight;
    return this;
  }


}
