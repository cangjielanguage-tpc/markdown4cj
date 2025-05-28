/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 扩展Option，getOrThrow()方法直接用()
 */
extend<T> Option<T> {
    operator func ()(): T {
        this.getOrThrow()
    }
}

/**
 * 扩展Option，实现Option类型直接使用==和!=
 */
extend<T> Option<T> where T <: Equatable<T> {
    operator func ==(other: T): Bool {
        match (this) {
            case Some(v) => v == other
            case _ => false
        }
    }

    operator func !=(other: T): Bool {
        match (this) {
            case Some(v) => v != other
            case _ => true
        }
    }
}

/**
 * 图片Style使用的实体类
 */
public class PicStyleObj {
    /**
     * 图片高度
     */
    var width: ?Length = None

    /**
     * 图片宽度
     */
    var height: ?Length = None

    /**
     * 对齐方式
     */
    var align: FlexAlign = FlexAlign.Start

    /**
     * 图片圆角
     */
    var borderRadius: ?Length = None
}

/**
 * 数学公式生成图片格式枚举
 */
public enum LatexMathColorFormat <: Equatable<LatexMathColorFormat> {
    /**
     * 16位
     */
    | COLOR_FORMAT_RGB_565

    /**
     * 32位
     */
    | COLOR_FORMAT_BGRA_8888

    public operator func ==(that: LatexMathColorFormat): Bool {
        match ((this, that)) {
            case (COLOR_FORMAT_RGB_565, COLOR_FORMAT_RGB_565) => true
            case (COLOR_FORMAT_BGRA_8888, COLOR_FORMAT_BGRA_8888) => true
            case _ => false
        }
    }

    public operator func !=(that: LatexMathColorFormat): Bool {
        return !(this == that)
    }
}
