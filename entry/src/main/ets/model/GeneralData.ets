/**
 * 通用颜色列表
 */
export const colorListGeneralData: Array<number | undefined> = [
  undefined,
  0xFF000000, // 黑
  0xFFFFFFFF, // 白
  0xFFFF0000, // 红
  0xFF00FF00, // 绿
  0xFF0000FF, // 蓝
  // 0xFFE0E0E0, // 银灰
  0xFF808080, // 中灰
  // 0xFF2196F3, // 天蓝
  // 0xFF00F5FF, // 绿松石
  // 0xFF32CD32, // 酸橙绿
  // 0xFF191919, // 炭黑
  0xFFFA8072, // 肉粉
  0xFFFFD700, // 金
  0xFFEE82EE, // 紫罗兰
  // 0xFFFFC107, // 橙黄
  0xFF7EC0EE, // 天空蓝
  0x00000000// 透明色
]

/**
 * 通用布尔值列表
 */
export const booleanListGeneralData: Array<boolean> = [true, false]

/**
 * 通用文本大小列表
 */
export const textSizeListGeneralData: Array<number> = [10, 12, 14, 16, 20, 24, 36]
  // [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 22, 24, 26, 28, 30, 32, 34, 36]

/**
 * 通用文本行高列表
 */
export const textLineHeightListGeneralData: Array<number> = [10, 12, 14, 16, 20, 24, 36]
  // [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 22, 24, 26, 28, 30, 32, 34, 36]

/**
 * 通用文本字间距列表
 */
export const textWordSpaceListGeneralData: Array<number> = [0, 0.5, 1, 2, 5, 10]
  // [0, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

/**
 * 通用外间距列表
 */
export const marginListGeneralData: Array<number> = [0, 5, 8, 10, 15, 20, 40]

/**
 * 通用内间距列表
 */
export const paddingListGeneralData: Array<number> = [0, 5, 8, 10, 15, 20, 40]

/**
 * 通用圆角列表
 */
export const radiusListGeneraData: Array<number> = [0, 2, 5, 10, 16, 25]

/**
 * 通用字体粗细列表
 */
export const fontWeightListGeneraData: Array<FontWeight> = [FontWeight.Lighter, FontWeight.Normal, FontWeight.Regular, FontWeight.Medium, FontWeight.Bold, FontWeight.Bolder]

/**
 * 通用字体样式列表
 */
export const fontStyleListGeneraData: Array<FontStyle> = [FontStyle.Normal, FontStyle.Italic]

/**
 * 通用文本字体列表
 */
export const textTypefaceListGeneralData: Array<string> = ["HarmonyOS Sans", "Hei"]

/**
 * 加载每次间隔时间列表
 */
export const timeListGeneralData: Array<number> = [5, 10, 20, 50, 100, 200, 500]
  // [5, 10, 15, 20, 25, 30, 40, 50, 60, 70, 80, 90, 100, 200, 300, 400, 500]

/**
 * 每次增量文本数量列表
 */
export const textNumberListGeneralData: Array<number> = [1, 2, 5, 10, 20, 50, 100, 150, 200]
  // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 35, 40, 45, 50, 100, 150, 200]

/**
 * 通用边框样式列表
 */
export const borderStyleListGeneraData: Array<BorderStyle> = [BorderStyle.Solid, BorderStyle.Dashed, BorderStyle.Dotted]

/**
 * 通用线/框宽度（下划线、删除线、分割线、边框）
 */
export const lineOrBorderWidthListGeneraData: Array<number> = [0, 0.5, 1, 2, 3, 4, 5]

/**
 * 通用xx和xx文本的间距列表
 */
export const spaceListGeneralData: Array<number> = [0, 0.5, 1, 2, 5, 10]

/**
 * 通用宽高设置列表
 */
export const widthOrHeightListGeneralData: Array<number> = [0, 5, 10, 20, 50, 80, 100]

/**
 * 通用文本装饰线类型列表
 */
export const textDecorationTypeListGeneralData: Array<TextDecorationType> = [TextDecorationType.None, TextDecorationType.Underline, TextDecorationType.Overline, TextDecorationType.LineThrough]

/**
 * 通用文本装饰线样式列表
 */
export const textDecorationStyleListGeneralData: Array<TextDecorationStyle> = [TextDecorationStyle.SOLID, TextDecorationStyle.DOUBLE, TextDecorationStyle.DOTTED, TextDecorationStyle.DASHED, TextDecorationStyle.WAVY]

/**
 * 通用偏移量列表
 */
export const offsetListGeneralData: Array<number> = [-5, -2, -1, 0, 1, 2, 5]



/**
 * 图片宽高设置列表
 */
export const imageWidthOrHeightListData: Array<number | undefined> = [undefined, 10, 50, 100, 150, 300, 500]
/**
 * 图片缩放类型列表
 */
// export const imageFitTypeListData: Array<ImageFitType> = [ImageFitType.Contain, ImageFitType.Cover, ImageFitType.Fill]
/**
 * 图片缩放类型列表2
 */
export const imageFitListData: Array<ImageFit> = [ImageFit.Contain, ImageFit.Cover, ImageFit.Auto, ImageFit.Fill, ImageFit.None, ImageFit.ScaleDown]
