import { BaseMDData } from "./BaseMDData"

/**
 * 链接曝光测试用例配置数据
 * 精简：只保留曝光相关少量字段，样式用默认主题
 */
export class LinkExposureData extends BaseMDData {
  _exposureThreshold: number = 0.5 // 曝光可见阈值（0~1，链接与可见区交集面积/链接面积 ≥ 此值才算可见）
  _tableStickyHeader: boolean = false // 表格标题行是否吸顶（002/003表格场景验证用）
  _isLinkifyPlugin: boolean = false // 是否加载链接自动解析插件（纯文本URL自动转链接）
}
