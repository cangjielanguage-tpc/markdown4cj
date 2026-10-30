/**
 * 曝光回调条件注册 Modifier（AttributeModifier 机制）。
 *
 * 设计依据（曝光优化改动说明文档方案D的注册要求）：不直接在 build 属性链里挂
 * onVisibleAreaChange/onSizeChange——那样注册无条件生效，未启用曝光的接入方也要承担
 * 引擎逐帧可见性遍历税（实测 HandleVisibleAreaChangeEvent ≈0.88ms/572节点/帧）。
 * 改为按曝光开关条件注册：enabled=false 时不注册任何回调，引擎零遍历、真零税。
 *
 * 使用方式：
 *   - 组件持有 @State modifier 引用，Text 上挂 .attributeModifier(this.exposureModifier)；
 *   - 曝光开关翻转时组件重建 modifier 实例（@State 引用变化触发 build 重跑，
 *     applyNormalAttribute 按新状态挂/卸回调）；
 *   - onVisibleAreaChange 无传 undefined 注销的重载（API 20），true→false 已注册的回调
 *     无法撤销，由组件回调内部的 isExposureEnabled 门控兜底（关曝光后只是一次布尔判断）。
 */
const EXPOSURE_RATIOS: Array<number> = [0.0, 0.01, 0.1, 0.25, 0.5, 0.75, 1.0] // 跨阈值才分发，滚一屏每节点最多7次

export class MarkdownExposureAttributeModifier implements AttributeModifier<TextAttribute> {
  private enabled: boolean = false
  private sizeDirtyCallback: (() => void) | undefined = undefined
  private visibleRatioCallback: ((ratio: number) => void) | undefined = undefined

  setEnabled(enabled: boolean): void {
    this.enabled = enabled
  }

  setSizeCallback(cb: (() => void) | undefined): void {
    this.sizeDirtyCallback = cb
  }

  setVisibleRatioCallback(cb: ((ratio: number) => void) | undefined): void {
    this.visibleRatioCallback = cb
  }

  applyNormalAttribute(instance: TextAttribute): void {
    if (this.enabled) {
      if (this.sizeDirtyCallback !== undefined) {
        instance.onSizeChange((_o: SizeOptions, _n: SizeOptions) => this.sizeDirtyCallback!())
      }
      if (this.visibleRatioCallback !== undefined) {
        instance.onVisibleAreaChange(EXPOSURE_RATIOS,
          (_v: boolean, ratio: number) => this.visibleRatioCallback!(ratio))
      }
    } else {
      // onSizeChange 的 SDK 类型参数非可选（common.d.ts: onSizeChange(event: SizeChangeCallback)），
      // 无法经 modifier 传 undefined 注销（onVisibleAreaChange 同样无 undefined 重载）。
      // 启用→禁用翻转后已注册回调由组件回调内的 isExposureEnabled 门控短路（回调首行布尔判断）。
    }
  }
}
