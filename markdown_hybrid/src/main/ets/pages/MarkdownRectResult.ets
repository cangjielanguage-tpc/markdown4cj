
/**
 * 子组件的大小和相对于组件的位置
 */
export class MarkdownRectResult {
  private x: number = 0
  private y: number = 0
  private width: number = 0
  private height: number = 0

  /**
   * 构造函数
   */
  constructor(x: number, y: number, width: number, height: number) {
    this.x = x
    this.y = y
    this.width = width
    this.height = height
  }

  /**
   * 获取子组件相对坐标x
   *
   * @returns 子组件x轴位置
   */
  getItemRectX(): number {
    return this.x
  }

  /**
   * 获取子组件相对坐标y
   *
   * @returns 子组件y轴位置
   */
  getItemRectY(): number {
    return this.y
  }

  /**
   * 获取子组件宽度
   *
   * @returns 子组件宽度
   */
  getItemRectWidth(): number {
    return this.width
  }

  /**
   * 获取子组件高度
   *
   * @returns 子组件高度
   */
  getItemRectHeight(): number {
    return this.height
  }
}