import { MarkdownBaseTheme } from './MarkdownBaseTheme';
import { COLOR_TRANSPARENT, isMargin } from "../base/Constants";

/**
 * 全局样式配置
 */
@Observed
export class GlobalTheme implements MarkdownBaseTheme {
  stageContext: Context | undefined = undefined // Stage上下文
  uiAbilityContext: Context | undefined = undefined // UIAbility上下文
  isMarkdownParserSync: boolean = false // 是否使用同步Markdown解析器
  parseThrottleMs: number = 200 // 解析节流间隔（ms），流式输出时控制解析频率
  isOnCopy: boolean = true // 是否启用复制功能
  blockMarginTop: Length = 0.0 // 区块上外边距
  blockMarginRight: Length = 0.0 // 区块右外边距
  blockMarginBottom: Length = 0.0 // 区块下外边距
  blockMarginLeft: Length = 0.0 // 区块左外边距
  markdownBlockSpacing: number = 8 // Markdown区块间距
  isLineBreak: boolean = false // 是否启用换行渲染
  openGestureSwipe: boolean = false // 是否启用手势滑动打开
  backgroundColor: ResourceColor = COLOR_TRANSPARENT // Markdown容器背景颜色

  /**
   * 设置Stage上下文
   *
   * @param context Stage上下文
   * @return GlobalTheme
   */
  setStageContext(context: Context): GlobalTheme {
    this.stageContext = context;
    return this;
  }

  /**
   * 设置UIAbility上下文
   *
   * @param context UIAbility上下文
   * @return GlobalTheme
   */
  setUiAbilityContext(context: Context): GlobalTheme {
    this.uiAbilityContext = context;
    return this;
  }

  /**
   * 设置Markdown解析器是否同步
   *
   * @param parserSync 同步状态
   * @return GlobalTheme
   */
  setIsMarkdownParserSync(parserSync: boolean): GlobalTheme {
    this.isMarkdownParserSync = parserSync;
    return this;
  }

  /**
   * 设置解析节流间隔
   *
   * @param throttleMs 节流间隔（ms），0表示不节流 - 默认200
   * @return GlobalTheme
   */
  setParseThrottleMs(throttleMs: number): GlobalTheme {
    this.parseThrottleMs = throttleMs;
    return this;
  }

  /**
   * 设置是否启用复制功能
   *
   * @param onCopy 复制启用状态
   * @return GlobalTheme
   */
  setIsOnCopy(onCopy: boolean): GlobalTheme {
    this.isOnCopy = onCopy;
    return this;
  }

  /**
   * 设置四周外边距
   *
   * @param options 外边距选项或统一数值
   * @return GlobalTheme
   */
  setMargin(options: Margin | Length): GlobalTheme {
    // 1. 如果是 number 或 string，直接四边统一赋值
    if (typeof options === "number" || typeof options === "string") {
      this.blockMarginTop = options;
      this.blockMarginRight = options;
      this.blockMarginBottom = options;
      this.blockMarginLeft = options;
    }
    // 2. 如果是 object，它要么是 Margin，要么是 Resource
    else if (typeof options === "object" && options !== null) {
      // 在 ArkTS 中，直接通过判断对象是否拥有 Margin 的专属属性来区分
      // 如果包含 top/right/bottom/left 任意一个，就当作 Margin 处理
      if (isMargin(options)) {
        const margin = options as Margin;
        if (margin.top !== undefined) {
          this.blockMarginTop = margin.top;
        }
        if (margin.right !== undefined) {
          this.blockMarginRight = margin.right;
        }
        if (margin.bottom !== undefined) {
          this.blockMarginBottom = margin.bottom;
        }
        if (margin.left !== undefined) {
          this.blockMarginLeft = margin.left;
        }
      } else {
        // 否则，它就是 Resource，作为单值统一赋值
        this.blockMarginTop = options as Length;
        this.blockMarginRight = options as Length;
        this.blockMarginBottom = options as Length;
        this.blockMarginLeft = options as Length;
      }
    }
    return this;
  }

  /**
   * 设置Markdown块间距
   *
   * @param space 间距
   * @return GlobalTheme
   */
  setMarkdownBlockSpacing(space: number): GlobalTheme {
    this.markdownBlockSpacing = space;
    return this;
  }

  /**
   * 设置是否启用换行渲染
   *
   * @param lineBreak 换行渲染启用状态
   * @return GlobalTheme
   */
  setIsLineBreak(lineBreak: boolean): GlobalTheme {
    this.isLineBreak = lineBreak;
    return this;
  }

  /**
   * 设置是否启用手势滑动打开
   *
   * @param gestureSwipe 手势滑动启用状态
   * @return GlobalTheme
   */
  setOpenGestureSwipe(gestureSwipe: boolean): GlobalTheme {
    this.openGestureSwipe = gestureSwipe;
    return this;
  }

  /**
   * 设置Markdown容器背景颜色
   *
   * @param color 背景颜色
   * @return GlobalTheme
   */
  setBackgroundColor(color: ResourceColor): GlobalTheme {
    this.backgroundColor = color;
    return this;
  }
}