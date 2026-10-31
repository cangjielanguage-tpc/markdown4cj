/**
 * FrameNode 句柄缓存的窗口矩形直读器（窗口坐标系 px）。
 *
 * 背景（曝光优化改动说明 §2/§3）：getRectangleById / getFrameNodeById 底层都是
 * Inspector::GetInspectorByKey——按 id 全窗口组件树线性查找并序列化 Inspector JSON
 * （长会话单次≈423µs），不能放进逐帧曝光链路。本读取器首次按 id 取 FrameNode 句柄
 * 并缓存，之后每轮只调句柄上的 getPositionToWindow() + getMeasuredSize() O(1) 直读，
 * 彻底消灭 Inspector 全树查找。
 *
 * 单位口径：getPositionToWindow() 返回 vp（内部做 vp2px 转 px），
 * getMeasuredSize() 返回 px（原样使用）。
 *
 * 句柄失效（组件销毁 / LazyForEach 回收重建 / 条件渲染移除导致 FrameNode dispose）：
 * 每次直读前先 getUniqueId()>0 前置检查（官方推荐，防 dispose 后查询 API JS crash），
 * 再叠加 try/catch + 读不出丢句柄双保险，下一轮 read 重新按 id 取句柄（组件重建后 id 不变，可重新命中）。
 */
import { FrameNode } from "@kit.ArkUI"

/**
 * 直读结果：组件当前窗口矩形（px）。
 */
export interface MarkdownNodeWindowRect {
  /** 窗口左边界（px） */
  left: number
  /** 窗口上边界（px） */
  top: number
  /** 宽度（px） */
  width: number
  /** 高度（px） */
  height: number
}

export class MarkdownNodeRectReader {
  private nodeId: string = ''
  private handle: FrameNode | null = null

  /** 绑定组件 id；句柄在首次 read 时才取（aboutToAppear 时刻组件尚未挂载，取不到） */
  attach(nodeId: string): void {
    this.nodeId = nodeId
    this.handle = null
  }

  /**
   * 直读当前窗口矩形（px）。组件未挂载 / 读不出 / 异常时丢弃缓存句柄并返回 null，
   * 调用方跳过本次评估，等下一轮再试（评估触发源：holder 广播/横滚广播/兜底轮询）。
   */
  read(uiContext: UIContext): MarkdownNodeWindowRect | null {
    if (this.nodeId === '') {
      return null
    }
    if (this.handle === null) {
      try {
        this.handle = uiContext.getFrameNodeById(this.nodeId)
      } catch (e) {
        this.handle = null
        return null
      }
      if (this.handle === null) {
        return null // 组件尚未挂载完成，下一轮再取
      }
    }
    try {
      // 前置有效性检查（SDK 官方推荐，FrameNode.d.ts dispose NOTE）：句柄失效（dispose）后调用
      // getPositionToWindow/getMeasuredSize 等查询 API 会 JS crash（catch 不一定拦得住），
      // getUniqueId()<=0 表示已无实体节点 → 丢句柄，下一轮重新取。
      if (this.handle.getUniqueId() <= 0) {
        this.handle = null
        return null
      }
      const pos: Position = this.handle.getPositionToWindow()
      const size: Size = this.handle.getMeasuredSize()
      if (typeof pos?.x !== 'number' || typeof pos?.y !== 'number'
        || typeof size?.width !== 'number' || typeof size?.height !== 'number') {
        // 读不出（组件尚未完成布局等）→ 丢弃句柄，下一轮重新取
        this.handle = null
        return null
      }
      // vp→px 用 uiContext 的密度（与 getFrameNodeById 同源），多窗口/多 density 场景不出错
      return {
        left: uiContext.vp2px(pos.x),
        top: uiContext.vp2px(pos.y),
        width: size.width,
        height: size.height
      }
    } catch (e) {
      // 句柄失效（组件销毁/重建）→ 丢弃句柄，下一轮重新取
      this.handle = null
      return null
    }
  }
}
