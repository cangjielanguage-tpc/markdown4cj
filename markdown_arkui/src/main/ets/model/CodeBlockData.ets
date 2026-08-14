import { PrismBlock } from "@cangjie-tpc/prism_hybrid"

/**
 * 单个代码块的高亮解析结果（可观察）
 * @ObjectLink 检测属性变化，触发子组件原地刷新，避免ForEach key变化导致组件重建
 */
@Observed
export class CodeBlockData {
  blocks: Array<PrismBlock> = [] // 高亮解析结果（每行一个PrismBlock）
  defaultFontColor: number = 0 // 默认文本颜色
}