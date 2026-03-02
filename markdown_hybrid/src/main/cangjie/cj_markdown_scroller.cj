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
    @Interop[ArkTS, Invisible]
    public var scroller: Scroller = Scroller()

    public init() {
    }

    public func scrollBy(xOffset: Float64, yOffset: Float64): Unit {
        this.scroller.scrollBy(xOffset: xOffset, yOffset: yOffset)
    }

    public func scrollEdge(value: Int64): Unit {
        match (value) {
        	case 1 => this.scroller.scrollEdge(Edge.Top)
        	case 2 => this.scroller.scrollEdge(Edge.Bottom)
        	case _ => this.scroller.scrollEdge(Edge.Top)
        }
    }

    public func isAtEnd(): Bool {
        return this.scroller.isAtEnd()
    }

    public func currentYOffset(): Float64 {
        let offsetResult = this.scroller.currentOffset()
        return offsetResult.yOffset
    }
}
