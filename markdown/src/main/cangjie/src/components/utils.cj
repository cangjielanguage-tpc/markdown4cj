/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.components

import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*

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
class PicStyleObj {
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
    var align: FlexAlign = FlexAlign.Center

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

/**
 * 图片数据源
 */
@Observed
class ImageData {
    /**
     * 标识
     */
    @Publish
    var ret: Int64 = -1

    /**
     * 行标识
     */
    @Publish
    var retRow: Int64 = -1

    /**
     * 列标识
     */
    @Publish
    var retCol: Int64 = -1

    /**
     * 表格标题头标识
     */
    @Publish
    var retHead: Int64 = -1

    /**
     * 图片数据
     */
    @Publish
    var pixelMap: ?PixelMap = Option<PixelMap>.None

    /**
     * 图片高度
     */
    @Publish
    var height: ?Float64 = Option<Float64>.None

    /**
     * 图片宽度
     */
    @Publish
    var width: ?Float64 = Option<Float64>.None

    /**
     * 图片数组数据
     */
    var arrayUint8: ?Array<UInt8> = Option<Array<UInt8>>.None
}
