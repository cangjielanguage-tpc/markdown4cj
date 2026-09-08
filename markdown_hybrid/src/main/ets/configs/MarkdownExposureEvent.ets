/**
 * 元素曝光事件
 *
 * 当链接等元素进入或离开屏幕可见区域时触发
 */
export class MarkdownExposureEvent {
  /**
   * 事件类型（如 "link"）
   */
  eventType: string = ''

  /**
   * 是否可见（true=进入可见区域，false=离开可见区域）
   */
  visible: boolean = false

  /**
   * 事件数据（如链接URL）
   */
  data: string = ''
}
