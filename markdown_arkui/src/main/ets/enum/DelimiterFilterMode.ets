/**
 * 分隔符过滤模式
 */
export enum DelimiterFilterMode {
  /** 宽松模式（全部允许） */
  Permissive,
  /** 严格模式（全部禁止） */
  Strict,
  /** 白名单模式（仅允许白名单中的分隔符） */
  Whitelist
}
