/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package markdown.texttoimg4cj

foreign {
    func drawCircleImage(str: CString, fontSize: Float32, fontColor: UInt32, fontBackGroupColor: UInt32,
        backGroupColor: UInt32, textHeight: Float32, colorFormat: Int32): UInt8Data

    func drawRectImage(str: CString, fontSize: Float32, fontColor: UInt32, fontBackGroupColor: UInt32,
        backGroupColor: UInt32, textHeight: Float32, colorFormat: Int32, padding: Float32, radius: Float32): UInt8Data

    func drawRectToolImage(str1: CString, str2: CString, fontSize: Float32, fontColor: UInt32,
        fontBackGroupColor: UInt32, backGroupColor: UInt32, borderColor: UInt32, borderWidth: Float32,
        dividingLineColor: UInt32, dividingLineWidth: Float32, textHeight: Float32, colorFormat: Int32,
        padding: Float32, lineLeftPadding: Float32, lineRightPadding: Float32): UInt8Data
}

@C
struct UInt8Data {
    var data: CPointer<UInt8> = CPointer<UInt8>()
    var len: Int64 = 0
}

public enum ColorFormatEnum {
    | COLOR_FORMAT_RGB_565
    | COLOR_FORMAT_BGRA_8888
}

let RGB_565: Int32 = 2
let BGRA_8888: Int32 = 5

/**
 * 画圆形图标
 *
 * @param str 文本内容
 * @param fontSize 文本大小 - 单位px
 * @param fontColor 文本颜色
 * @param fontBackGroupColor 控件背景颜色
 * @param backGroupColor 背景颜色
 * @param textHeight 控件高度 - 单位px
 * @param colorFormat 图片格式
 * @return 图片数组数据
 */
public func drawCircleImageButton(str: String, fontSize: Float64, fontColor: UInt32, fontBackGroupColor: UInt32,
    backGroupColor: UInt32, textHeight: Float64, colorFormat: ColorFormatEnum): Array<UInt8> {
    unsafe {
        // 文本
        var cstr = LibC.mallocCString(str)
        // 文本大小
        var fontSizeFloat32: Float32 = Float32(fontSize)
        // 控件高度
        var textHeightFloat32: Float32 = Float32(textHeight)
        // 图片格式
        let format = match (colorFormat) {
            case COLOR_FORMAT_RGB_565 => RGB_565
            case COLOR_FORMAT_BGRA_8888 => BGRA_8888
        }
        var data: UInt8Data = drawCircleImage(cstr, fontSizeFloat32, fontColor, fontBackGroupColor, backGroupColor,
            textHeightFloat32, format)
        var arr = Array<UInt8>(data.len, item: 0)
        for (i in 0..data.len) {
            arr[i] = data.data.read(i)
        }
        LibC.free(data.data)
        LibC.free(cstr)
        return arr
    }
}

/**
 * 画圆角矩形图标
 *
 * @param str 文本内容
 * @param fontSize 文本大小 - 单位px
 * @param fontColor 文本颜色
 * @param fontBackGroupColor 控件背景颜色
 * @param backGroupColor 背景颜色
 * @param textHeight 控件高度 - 单位px
 * @param colorFormat 图片格式
 * @param padding 左右边距 - 单位px
 * @return 图片数组数据
 */
public func drawRectImageButton(str: String, fontSize: Float64, fontColor: UInt32, fontBackGroupColor: UInt32,
    backGroupColor: UInt32, textHeight: Float64, colorFormat: ColorFormatEnum, padding: Float64, radius: Float64): Array<UInt8> {
    unsafe {
        // 文本
        var cstr = LibC.mallocCString(str)
        // 文本大小
        var fontSizeFloat32: Float32 = Float32(fontSize)
        // 控件高度
        var textHeightFloat32: Float32 = Float32(textHeight)
        // 左右边距
        var paddingFloat32: Float32 = Float32(padding)
        // 圆角半径
        var radiusFloat32: Float32 = Float32(radius)
        // 图片格式
        let format = match (colorFormat) {
            case COLOR_FORMAT_RGB_565 => RGB_565
            case COLOR_FORMAT_BGRA_8888 => BGRA_8888
        }
        var data: UInt8Data = drawRectImage(cstr, fontSizeFloat32, fontColor, fontBackGroupColor, backGroupColor,
            textHeightFloat32, format, paddingFloat32, radiusFloat32)
        var arr = Array<UInt8>(data.len, item: 0)
        for (i in 0..data.len) {
            arr[i] = data.data.read(i)
        }
        LibC.free(data.data)
        LibC.free(cstr)
        return arr
    }
}

/**
 * 画空心圆角矩形图标
 *
 * @param str 文本内容
 * @param fontSize 文本大小 - 单位px
 * @param fontColor 文本颜色
 * @param fontBackGroupColor 控件背景颜色
 * @param backGroupColor 背景颜色
 * @param borderColor 边框颜色
 * @param borderWidth 边框宽度 - 单位px
 * @param dividingLineColor 分割线颜色
 * @param dividingLineWidth 分割线宽度 - 单位px
 * @param textHeight 控件高度 - 单位px
 * @param colorFormat 图片格式
 * @param padding 左右边距 - 单位px
 * @return 图片数组数据
 */
public func drawRectToolImageButton(str1: String, str2: String, fontSize: Float64, fontColor: UInt32,
    fontBackGroupColor: UInt32, backGroupColor: UInt32, borderColor: UInt32, borderWidth: Float64,
    dividingLineColor: UInt32, dividingLineWidth: Float64, textHeight: Float64, colorFormat: ColorFormatEnum,
    padding: Float64, lineLeftPadding: Float64, lineRightPadding: Float64): Array<UInt8> {
    unsafe {
        // 文本
        var cstr1 = LibC.mallocCString(str1)
        // 文本
        var cstr2 = LibC.mallocCString(str2)
        // 文本大小
        var fontSizeFloat32: Float32 = Float32(fontSize)
        // 文本大小
        var borderWidthFloat32: Float32 = Float32(borderWidth)
        // 文本大小
        var dividingLineWidthFloat32: Float32 = Float32(dividingLineWidth)
        // 控件高度
        var textHeightFloat32: Float32 = Float32(textHeight)
        // 左右边距
        var paddingFloat32: Float32 = Float32(padding)
        // 左右边距
        var lineLeftPaddingFloat32: Float32 = Float32(lineLeftPadding)
        // 左右边距
        var lineRightPaddingFloat32: Float32 = Float32(lineRightPadding)
        // 图片格式
        let format = match (colorFormat) {
            case COLOR_FORMAT_RGB_565 => RGB_565
            case COLOR_FORMAT_BGRA_8888 => BGRA_8888
        }
        var data: UInt8Data = drawRectToolImage(cstr1, cstr2, fontSizeFloat32, fontColor, fontBackGroupColor,
            backGroupColor, borderColor, borderWidthFloat32, dividingLineColor, dividingLineWidthFloat32,
            textHeightFloat32, format, paddingFloat32, lineLeftPaddingFloat32, lineRightPaddingFloat32)
        var arr = Array<UInt8>(data.len, item: 0)
        for (i in 0..data.len) {
            arr[i] = data.data.read(i)
        }
        LibC.free(data.data)
        LibC.free(cstr1)
        LibC.free(cstr2)
        return arr
    }
}
