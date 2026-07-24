package markdown_hybrid.components

import std.collection.HashMap

/**
 * 可见矩形快照（窗口坐标系 px，不可变）
 * 对齐 ArkUI MarkdownVisibleRectHolder.ets 的 MarkdownVisibleRectSnapshot 接口
 */
public class MarkdownVisibleRectSnapshot {
    public let visTop: Float64
    public let visBottom: Float64
    public let visHeight: Float64
    public let ratio: Float64
    public let rectTop: Float64
    public let ready: Bool
    public let visReady: Bool

    public init(visTop!: Float64, visBottom!: Float64, visHeight!: Float64, ratio!: Float64,
        rectTop!: Float64, ready!: Bool, visReady!: Bool) {
        this.visTop = visTop
        this.visBottom = visBottom
        this.visHeight = visHeight
        this.ratio = ratio
        this.rectTop = rectTop
        this.ready = ready
        this.visReady = visReady
    }
}

/**
 * CJMarkdown 根节点可见矩形持有者（窗口坐标系 px）。
 *
 * 对齐 ArkUI MarkdownVisibleRectHolder.ets：
 *   - CJMarkdown 每 50ms 用 componentUtils 拿根 List 的窗口 rect [rectTop, rectBottom]
 *     （rectHeight=bottom-top），ratio 取 onVisibleAreaChange 最近一次值（lastRatio 缓存）。
 *   - 初始可见区域 = 矩形区域 × ratio（顶部对齐、静止）。
 *   - 每 50ms tick，按「矩形区域移动方向」+「ratio 变化」更新可见区域：
 *       向上滑（rectTop 减小）：ratio 不变→ratio==1用矩形区域否则不变；ratio 变小→底部收缩。
 *       向下移（rectTop 增大）：ratio 不变→ratio==1用矩形区域否则不变；ratio 变小→顶部收缩。
 *       （ratio 变大不考虑，偏漏报避免过报。）
 *   - 可见区域静止（视口本身不动），仅随 ratio 收缩；visHeight≥0 兜底。
 *
 * 消费方（MarkdownParagraphComponent 等）用 visTop/visBottom 作垂直裁剪窗口，
 * 与自身 componentUtils.getRectangleById 拿到的段落 rect 求交，判定段落可见性。
 */
public class MarkdownVisibleRectHolder {
    // 矩形区域（componentUtils 来源，窗口 px）——applyRect 每次更新
    public var rectTop: Float64 = 0.0
    public var rectBottom: Float64 = 0.0
    public var rectHeight: Float64 = 0.0
    // ratio（onVisibleAreaChange 来源，CJMarkdown 缓存后传入）
    public var ratio: Float64 = 0.0
    // 可见区域（算法输出，窗口 px，静止）——paragraph/cell 用作垂直裁剪窗口
    public var visTop: Float64 = 0.0
    public var visBottom: Float64 = 0.0
    public var visHeight: Float64 = 0.0
    public var ready: Bool = false // 已拿到过 rect（applyRect 至少调过一次）
    public var visReady: Bool = false // vis 已完成初始化（ratio 首次>0 后）
    // tick 状态
    private var inited: Bool = false
    private var prevRectTop: Float64 = -1.0 // -1.0 表示未初始化（rectTop 不会为负，用 -1.0 作哨兵）
    private var prevRatio: Float64 = -1.0
    // 监听器（对齐 StickyScrollYHolder 的 ID 模式：函数引用不能直接比较，用 Int64 key）
    private var listeners: HashMap<Int64, (MarkdownVisibleRectSnapshot) -> Unit> = HashMap<Int64, (MarkdownVisibleRectSnapshot) -> Unit>()
    private var nextId: Int64 = 0

    /**
     * 添加可见区域变化监听器
     * @param listener 监听回调
     * @return 监听器ID（用于 removeListener）
     */
    public func addListener(listener: (MarkdownVisibleRectSnapshot) -> Unit): Int64 {
        let id = nextId
        nextId += 1
        listeners[id] = listener
        return id
    }

    /**
     * 移除监听器
     * @param id 监听器ID（由 addListener 返回）
     */
    public func removeListener(id: Int64): Unit {
        listeners.remove(id)
    }

    /**
     * 清除所有监听器
     */
    public func clearListeners(): Unit {
        listeners.clear()
    }

    /**
     * 每 50ms 由 CJMarkdown 调用：传入最新矩形（窗口 px）+ ratio，运行算法更新可见区域。
     * 首次调用=初始化（visHeight=rectHeight×ratio）。后续按方向/ratio 变化收缩。
     * 变化时通知监听者。
     *
     * @param rectTop 矩形顶部（窗口 px）
     * @param rectBottom 矩形底部（窗口 px）
     * @param ratio onVisibleAreaChange 缓存的 ratio
     */
    public func applyRect(rectTop: Float64, rectBottom: Float64, ratio: Float64): Unit {
        this.rectTop = rectTop
        this.rectBottom = rectBottom
        this.rectHeight = if (rectBottom - rectTop > 0.0) { rectBottom - rectTop } else { 0.0 }
        this.ratio = ratio
        this.ready = true
        // ratio 还没回调过（首帧 lastRatio=0）→ 不初始化 vis，等 onVisibleAreaChange 给真实 ratio 再 init
        if (!inited) {
            if (ratio <= 0.0) {
                return
            }
            // 初始可见区域 = 矩形区域 × ratio（顶部对齐，静止）
            let h = rectHeight * ratio
            visHeight = h
            visTop = rectTop
            visBottom = rectTop + h
            visReady = true
            inited = true
            prevRectTop = rectTop
            prevRatio = ratio
            notify()
            return
        }
        let prevTop = prevRectTop
        let prevRatioLocal = prevRatio
        // ratio 从 ≤0 回到 >0 → 重新初始化（不走"ratio 变大不考虑"分支）
        if (prevRatioLocal <= 0.0 && ratio > 0.0) {
            let h = rectHeight * ratio
            visHeight = h
            visTop = rectTop
            visBottom = rectTop + h
            visReady = true
            prevRectTop = rectTop
            prevRatio = ratio
            notify()
            return
        }
        let movedUp = rectTop < prevTop - 0.5
        let movedDown = rectTop > prevTop + 0.5
        let ratioDiff = ratio - prevRatioLocal
        let ratioDiffAbs = if (ratioDiff < 0.0) { -ratioDiff } else { ratioDiff }
        let ratioEq = ratioDiffAbs < 1e-4
        let ratioDown = ratio < prevRatioLocal - 1e-4
        var changed = false
        if (movedUp || movedDown) {
            if (ratioEq) {
                let ratioMinus1Abs = if (ratio - 1.0 < 0.0) { -(ratio - 1.0) } else { ratio - 1.0 }
                if (ratioMinus1Abs < 1e-4) {
                    // ratio==1 → 可见区域=矩形区域
                    visHeight = rectHeight
                    visTop = rectTop
                    visBottom = rectTop + rectHeight
                    changed = true
                }
                // ratio 不变且 ≠1 → 可见区域不变（静止）
            } else if (ratioDown) {
                // ratio 变小 → 被遮挡，visHeight 减去 (prevRatio-curRatio)×rectHeight
                let shrink = (prevRatioLocal - ratio) * rectHeight
                visHeight = if (visHeight - shrink > 0.0) { visHeight - shrink } else { 0.0 }
                // 收缩端：向上滑→底部遮挡（visBottom 上移）；向下移→顶部遮挡（visTop 下移）
                if (movedUp) {
                    visBottom = visTop + visHeight
                } else {
                    visTop = visBottom - visHeight
                }
                changed = true
            }
            // ratio 变大 → 不考虑（保持不变）
        }
        // else 未移动 → 可见区域不变
        prevRectTop = rectTop
        prevRatio = ratio
        if (changed) {
            notify()
        }
    }

    /**
     * 通知所有监听器
     */
    private func notify(): Unit {
        let snapshot = MarkdownVisibleRectSnapshot(
            visTop: visTop, visBottom: visBottom, visHeight: visHeight,
            ratio: ratio, rectTop: rectTop, ready: ready, visReady: visReady
        )
        for ((_, fn) in listeners) {
            try {
                fn(snapshot)
            } catch (_: Exception) {
                // ignore 单个监听者异常
            }
        }
    }
}
