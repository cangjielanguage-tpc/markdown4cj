/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
package markdown

import ohos.ark_interop.*
import ohos.ark_interop_macro.*
import ohos.component.Scroller
import ohos.component.Edge

@Interop[ArkTS]
public class CJMarkdownScroller {
    /**
     * Scroller
     */
    @Interop[ArkTS, Invisible]
    public var scroller: Scroller = Scroller()

    /**
     * 初始化
     */
    public init() {
    }

    /**
     * 滑动指定距离
     *
     * @param xOffset 水平方向滚动距离
     * @param xOffset 竖直方向滚动距离
     */
    public func scrollBy(xOffset: Float64, yOffset: Float64): Unit {
        this.scroller.scrollBy(xOffset: xOffset, yOffset: yOffset)
    }

    /**
     * 滑动到指定Index
     *
     * @param value 要滑动到的目标元素在当前容器中的索引值
     */
    public func scrollToIndex(value: Int32): Unit {
        this.scroller.scrollToIndex(value)
    }

    /**
     * 滚动到容器边缘
     *
     * @param value 滚动到的边缘位置
     */
    public func scrollEdge(value: Int64): Unit {
        match (value) {
        	case 1 => this.scroller.scrollEdge(Edge.Top)
        	case 2 => this.scroller.scrollEdge(Edge.Bottom)
        	case _ => this.scroller.scrollEdge(Edge.Top)
        }
    }

    /**
     * 查询组件是否滚动到底部
     */
    public func isAtEnd(): Bool {
        return this.scroller.isAtEnd()
    }

    /**
     * 获取当前的滚动总偏移量
     */
    public func currentYOffset(): Float64 {
        let offsetResult = this.scroller.currentOffset()
        return offsetResult.yOffset
    }
}
