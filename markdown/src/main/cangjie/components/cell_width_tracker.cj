package markdown.components

/**
 * 表格列宽度跟踪器（非@Observed，不触发重渲染）
 * 按单元格(row,col)跟踪最新宽度，列宽=该列所有行的最大值
 * onAreaChange写入tracker → onWidthUpdated回调 → applyColumnWidths批量读取到@State → 一次性应用
 */
public class CellWidthTracker {
    var widths: ArrayList<Float64> = ArrayList<Float64>()
    var onWidthUpdated: ?() -> Unit = None
    private let cellWidths: HashMap<Int64, ArrayList<Float64>> = HashMap<Int64, ArrayList<Float64>>()

    public init() {
    }

    /**
     * 更新指定单元格的宽度，并重算该列最大宽度
     *
     * @param row 行索引
     * @param col 列索引
     * @param width 单元格宽度
     */
    public func updateCellWidth(row: Int64, col: Int64, width: Float64): Unit {
        if (col < 0 || col >= Int64(widths.size)) {
            return
        }
        let rowWidthsOpt = cellWidths.get(row)
        let rowWidths = match (rowWidthsOpt) {
            case Some(rws) => rws
            case _ =>
                let rws = ArrayList<Float64>()
                for (_ in 0..widths.size) {
                    rws.add(0.0)
                }
                cellWidths[row] = rws
                rws
        }
        if (rowWidths[col] == width) {
            return
        }
        rowWidths[col] = width
        let oldMax = widths[col]
        var newMax: Float64 = 0.0
        for ((_, rws) in cellWidths) {
            if (rws[col] > newMax) {
                newMax = rws[col]
            }
        }
        if (newMax != oldMax) {
            widths[col] = newMax
            if (let Some(cb) <- onWidthUpdated) {
                cb()
            }
        }
    }

    /**
     * 清除指定行的所有单元格宽度记录（行删除时调用）
     *
     * @param row 行索引
     */
    public func clearRow(row: Int64): Unit {
        let removed = cellWidths.remove(row)
        match (removed) {
            case Some(_) => ()
            case _ => return
        }
        var changed = false
        for (col in 0..widths.size) {
            let oldMax = widths[col]
            var newMax: Float64 = 0.0
            for ((_, rws) in cellWidths) {
                if (rws[col] > newMax) {
                    newMax = rws[col]
                }
            }
            if (newMax != oldMax) {
                widths[col] = newMax
                changed = true
            }
        }
        if (changed) {
            if (let Some(cb) <- onWidthUpdated) {
                cb()
            }
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
     * 清除所有列宽测量值（保留行/列结构）
     * 用于refreshData时重置宽度，允许单元格重新测量（内容缩短时可以收缩）
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
    }

    /**
     * 调整列数，保留已有列的宽度数据（流式输出时列数可能增长，清零会导致已测量的宽度丢失）
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
        for ((row, rws) in cellWidths) {
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
                cellWidths[row] = newRws
            }
        }
    }
}
