package markdown.components

/**
 * 表格列宽度跟踪器（非@Observed，不触发重渲染）
 * 按单元格(row,col)跟踪最新宽度，列宽=该列所有行的最大值
 * onAreaChange写入tracker → scheduleFlush延迟回调 → applyColumnWidths批量读取到@State → 一次性应用
 *
 * 三级宽度存储（优先级从高到低）：
 * 1. cellWidths：onSizeChange报告的实际宽度（每次重渲染后更新，最准确）
 * 2. imageFallback：setFallback设置的图片实际宽度（仅图片cell有值，clearWidths不清除，
 *    确保图片cell列宽不收缩到图片宽度以下）
 * 3. fallback：updateCellWidth在width>minWidth时记录的内容宽度（宽cell的contentWidth，
 *    clearWidths清除，避免text cell stale fallback阻止列收缩）
 *
 * recalcColumnMax优先级：cellWidths > imageFallback > fallback
 * - cellWidths>0：已重测，用最新值
 * - cellWidths==0且imageFallback>0：图片cell未重测，用图片实际宽度（安全）
 * - cellWidths==0且imageFallback==0且fallback>0：宽text cell未重测，用contentWidth
 * - 全为0：窄cell或未测cell，不贡献列宽
 *
 * 性能优化（O(M*N)初始测量场景）：
 * 1. scheduleFlush 防抖：一帧内多次updateCellWidth只触发一次onWidthUpdated回调，
 *    避免M*N次applyColumnWidths调用与columnWidths重赋值导致的N²布局级联
 * 2. widths数组同步更新，getWidths()返回最新快照，仅UI回调被推迟
 */
public class CellWidthTracker {
    var widths: ArrayList<Float64> = ArrayList<Float64>()
    var onWidthUpdated: ?() -> Unit = None
    private let cellWidths: HashMap<Int64, ArrayList<Float64>> = HashMap<Int64, ArrayList<Float64>>()
    private let fallbackCellWidths: HashMap<Int64, ArrayList<Float64>> = HashMap<Int64, ArrayList<Float64>>()
    private let imageFallbackCellWidths: HashMap<Int64, ArrayList<Float64>> = HashMap<Int64, ArrayList<Float64>>()
    private var flushScheduled: Bool = false // 是否已调度onWidthUpdated回调

    public init() {
    }

    /**
     * 更新指定单元格的宽度，并重算该列最大宽度
     * 如果width>minWidth，说明cell内容宽度>minWidth约束，width=contentWidth，存为fallback。
     * 如果width==minWidth，说明cell内容宽度<=minWidth，width是minWidth而非contentWidth，清除fallback（stale）。
     * 注意：imageFallback不受updateCellWidth影响，setFallback设置的值始终保留。
     *
     * @param row 行索引
     * @param col 列索引
     * @param width 单元格宽度（onSizeChange报告的实际宽度）
     * @param minWidth 当前cell的minWidth约束值（=columnWidths[col]与tableMinCellWidth的max）
     */
    public func updateCellWidth(row: Int64, col: Int64, width: Float64, minWidth: Float64): Unit {
        if (col < 0 || col >= Int64(widths.size)) {
            return
        }
        let rowWidths = getOrCreateRow(cellWidths, row)
        let oldAtCell = rowWidths[col]
        if (oldAtCell == width) {
            return
        }
        rowWidths[col] = width
        // 宽cell（width>minWidth）：width=contentWidth，存为fallback（未重测时仍可用）
        // 窄cell（width==minWidth）：清除fallback（stale值不用），imageFallback不受影响
        let fws = getOrCreateRow(fallbackCellWidths, row)
        fws[col] = if (width > minWidth) { width } else { 0.0 }
        let oldMax = widths[col]
        let newMax = recalcColumnMax(col)
        if (newMax != oldMax) {
            widths[col] = newMax
            scheduleFlush()
        }
    }

    /**
     * 重算指定列的最大宽度（取所有行该列的最大值）
     * 优先级：cellWidths > imageFallback > fallback
     *
     * @param col 列索引
     * @return 列最大宽度
     */
    private func recalcColumnMax(col: Int64): Float64 {
        var newMax: Float64 = 0.0
        for ((row, rws) in cellWidths) {
            let cw = rws[col]
            var imgFw: Float64 = 0.0
            if (let Some(imgFws) <- imageFallbackCellWidths.get(row)) {
                imgFw = imgFws[col]
            }
            var fw: Float64 = 0.0
            if (let Some(fws) <- fallbackCellWidths.get(row)) {
                fw = fws[col]
            }
            let w = if (cw > 0.0) { cw } else { if (imgFw > 0.0) { imgFw } else { fw } }
            if (w > newMax) {
                newMax = w
            }
        }
        return newMax
    }

    /**
     * 清除指定行的所有单元格宽度记录（行删除时调用）
     *
     * @param row 行索引
     */
    public func clearRow(row: Int64): Unit {
        fallbackCellWidths.remove(row)
        imageFallbackCellWidths.remove(row)
        if (cellWidths.remove(row).isNone()) {
            return
        }
        var changed = false
        for (col in 0..widths.size) {
            let oldMax = widths[col]
            let newMax = recalcColumnMax(col)
            if (newMax != oldMax) {
                widths[col] = newMax
                changed = true
            }
        }
        if (changed) {
            scheduleFlush()
        }
    }

    /**
     * 获取指定列的宽度
     *
     * @param index 列索引
     * @return 列宽度，索引越界时返回0
     */
    public func getWidth(index: Int64): Float64 {
        if (index >= 0 && index < Int64(widths.size)) {
            return widths[index]
        }
        return 0.0
    }

    /**
     * 获取所有列宽快照
     *
     * @return 列宽数组
     */
    public func getWidths(): Array<Float64> {
        let result = Array<Float64>(widths.size, repeat: 0.0)
        for (i in 0..widths.size) {
            result[i] = widths[i]
        }
        return result
    }

    /**
     * 清零cellWidths，保留fallback和imageFallback。
     * 容器宽度变化（evenWidth缩小）时调用，允许窄cell重新测量。
     * - 宽cell（fallback>0或imageFallback>0）：列宽不变→cell不变→onSizeChange不触发→fallback仍可用
     * - 窄cell（fallback=0且imageFallback=0）：cellWidths清零→widths=0→columnWidths=evenWidth
     *   → cell收缩→onSizeChange触发→tracker更新
     * 不触发onWidthUpdated，由调用方负责后续applyColumnWidths
     */
    public func saveFallbackAndClear(): Unit {
        for ((_, rws) in cellWidths) {
            for (i in 0..rws.size) {
                rws[i] = 0.0
            }
        }
        for (col in 0..widths.size) {
            widths[col] = recalcColumnMax(col)
        }
    }

    /**
     * 清除指定列所有单元格的cellWidths + 指定单元格的fallback和imageFallback（LaTeX图片加载完成时调用）
     *
     * LaTeX未加载时显示原始文本（可能很宽），加载后显示图片（可能更窄）。
     * 必须清整列所有cellWidths，让recalcColumnMax用fallback/imageFallback。
     *
     * @param row 行索引（LaTeX所在行，仅清此行fallback/imageFallback）
     * @param col 列索引（清此列所有cellWidths）
     */
    public func clearCellWidth(row: Int64, col: Int64): Unit {
        if (col < 0 || col >= Int64(widths.size)) {
            return
        }
        // 清整列所有cellWidths（移除stale minWidth值）
        for ((_, rws) in cellWidths) {
            rws[col] = 0.0
        }
        // 清此cell的fallback（移除stale原始文本宽度）
        if (let Some(fws) <- fallbackCellWidths.get(row)) {
            fws[col] = 0.0
        }
        // 清此cell的imageFallback（setFallback会重新设置）
        if (let Some(imgFws) <- imageFallbackCellWidths.get(row)) {
            imgFws[col] = 0.0
        }
        let oldMax = widths[col]
        let newMax = recalcColumnMax(col)
        if (newMax != oldMax) {
            widths[col] = newMax
            scheduleFlush()
        }
    }

    /**
     * 直接设置单元格的imageFallback宽度（图片加载完成时调用）
     * imageFallback不受updateCellWidth影响（不会被清除），确保clearWidths/clearCellWidth后
     * recalcColumnMax仍能用图片实际宽度，防止图片cell列宽收缩到图片宽度以下。
     *
     * @param row 行索引
     * @param col 列索引
     * @param width 实际内容宽度（如imageWidth）
     */
    public func setFallback(row: Int64, col: Int64, width: Float64): Unit {
        if (col < 0 || col >= Int64(widths.size)) {
            return
        }
        let imgFws = getOrCreateRow(imageFallbackCellWidths, row)
        if (imgFws[col] == width) {
            return
        }
        imgFws[col] = width
        let oldMax = widths[col]
        let newMax = recalcColumnMax(col)
        if (newMax != oldMax) {
            widths[col] = newMax
            scheduleFlush()
        }
    }

    /**
     * 清除所有列宽测量值和fallback，保留imageFallback和行/列结构。
     * 流式输出内容变化（如原始markdown→渲染后的链接，内容缩短）时调用，允许所有cell重新测量。
     * - cellWidths清零→widths=0→columnWidths=evenWidth→所有cell收缩→onSizeChange触发→重测
     * - fallback清零→移除text cell的stale contentWidth（内容已缩短但fallback仍是旧值）
     * - imageFallback保留→图片cell未重测时仍用图片实际宽度（防止图片cell列宽过度收缩）
     * 不触发onWidthUpdated，由调用方负责后续applyColumnWidths
     */
    public func clearWidths(): Unit {
        for (i in 0..widths.size) {
            widths[i] = 0.0
        }
        for ((_, rws) in cellWidths) {
            for (i in 0..rws.size) {
                rws[i] = 0.0
            }
        }
        for ((_, fws) in fallbackCellWidths) {
            for (i in 0..fws.size) {
                fws[i] = 0.0
            }
        }
    }

    /**
     * 调整列数，保留已有列的宽度数据（流式输出时列数可能增长，清零会导致已测量的宽度丢失）
     * 三级存储同步调整列数。
     *
     * @param size 新的列数
     */
    public func resize(size: Int64): Unit {
        if (size == Int64(widths.size)) {
            return
        }
        let oldWidths = widths
        let newWidths = ArrayList<Float64>()
        for (_ in 0..size) {
            newWidths.add(0.0)
        }
        let oldLen = Int64(oldWidths.size)
        let copyLen = if (oldLen < size) { oldLen } else { size }
        for (i in 0..copyLen) {
            newWidths[i] = oldWidths[i]
        }
        widths = newWidths
        resizeMap(cellWidths, size)
        resizeMap(fallbackCellWidths, size)
        resizeMap(imageFallbackCellWidths, size)
    }

    /**
     * 获取或创建指定行的宽度数组（长度=当前列数）
     */
    private func getOrCreateRow(map: HashMap<Int64, ArrayList<Float64>>, row: Int64): ArrayList<Float64> {
        match (map.get(row)) {
            case Some(rws) => return rws
            case _ =>
                let rws = ArrayList<Float64>()
                for (_ in 0..widths.size) {
                    rws.add(0.0)
                }
                map[row] = rws
                return rws
        }
    }

    /**
     * 调整指定map中所有行数组的列数，保留已有数据
     */
    private func resizeMap(map: HashMap<Int64, ArrayList<Float64>>, size: Int64): Unit {
        for ((row, rws) in map) {
            let rwsSize = Int64(rws.size)
            if (rwsSize != size) {
                let newRws = ArrayList<Float64>()
                for (_ in 0..size) {
                    newRws.add(0.0)
                }
                let rwsCopyLen = if (rwsSize < size) { rwsSize } else { size }
                for (i in 0..rwsCopyLen) {
                    newRws[i] = rws[i]
                }
                map[row] = newRws
            }
        }
    }

    /**
     * 调度延迟回调。一帧内多次调用只触发一次onWidthUpdated，
     * 把M*N次单元格测量合并为一次applyColumnWidths调用。
     * widths数组始终同步更新， getWidths()/getWidth()可立即读到最新值。
     */
    private func scheduleFlush(): Unit {
        if (flushScheduled) {
            return
        }
        if (onWidthUpdated.isNone()) {
            return
        }
        flushScheduled = true
        spawn {
            sleep(Duration.millisecond * 1)
            launch {
                flushScheduled = false
                if (let Some(cb) <- onWidthUpdated) {
                    cb()
                }
            }
        }
    }
}
