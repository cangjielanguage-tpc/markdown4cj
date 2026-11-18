/**
 * 文本选区状态值（选区更新收敛，见内存优化方案 4.1）
 *
 * 起止坐标收敛成一次写入：宿主命中、手柄拖动、清除和延时关菜单全部走
 * updateSelection(start, end) 统一更新，渲染（.selection()）与复制（自定义菜单）
 * 读取同一对坐标，消除两个 @State 分两次写入引发的重复刷新与中间状态。
 *
 * 保持 -1/-1 清除语义与原 selectStart/selectEnd 行为一致；
 * 每次变化整体替换实例（@State 据此触发一次刷新），不引入 @Observed 包装。
 */
export class SelectionRange {
  start: number // 选区开始位置（-1/-1 表示清除选区）
  end: number // 选区结束位置

  constructor(start: number, end: number) {
    this.start = start
    this.end = end
  }
}
