/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
#include <cstdint>
#define __OS_ohos__ 1

#ifdef __OS_ohos__

#include <native_drawing/drawing_bitmap.h>

#include "ohos_log.h"
#include "utils.h"
#include <cstring>
#include <iostream>
#include <native_drawing/drawing_brush.h>
#include <native_drawing/drawing_canvas.h>
#include <native_drawing/drawing_font.h>
#include <native_drawing/drawing_font_collection.h>
#include <native_drawing/drawing_matrix.h>
#include <native_drawing/drawing_path.h>
#include <native_drawing/drawing_pen.h>
#include <native_drawing/drawing_point.h>
#include <native_drawing/drawing_rect.h>
#include <native_drawing/drawing_register_font.h>
#include <native_drawing/drawing_round_rect.h>
#include <native_drawing/drawing_text_blob.h>
#include <native_drawing/drawing_text_typography.h>
#include <native_drawing/drawing_types.h>
#include <stdint.h>
#include <string.h>


#ifdef __cplusplus
extern "C" {
#endif

void safe_memcpy(void *dest, uint32_t dest_size, const void *src, uint32_t src_size) {
    if (dest_size < src_size) {
        throw std::runtime_error("Insufficient space in the target buffer.");
    }
    std::memcpy(dest, src, src_size);
}

void safe_memset(void *dest, uint32_t destSize, int value, uint32_t count) {
    if (count > destSize) {
        throw std::runtime_error("The number of bytes to be set exceeds the buffer size.");
    }
    std::memset(dest, value, count);
}

typedef struct {
    uint8_t *data;
    int64_t len;
} UInt8Data;

static UInt8Data toBitmapRGB565(OH_Drawing_Bitmap *bitmap) {
    BitMapFileHeader bmfHdr; // 定义文件头
    BitMapInfoHeader bmiHdr; // 定义信息头
    RgbQuad bmiClr[3];       // 定义调色板

    uint32_t w = OH_Drawing_BitmapGetWidth(bitmap);
    uint32_t h = OH_Drawing_BitmapGetHeight(bitmap);
    uint8_t *bitmapAddr = (uint8_t *)OH_Drawing_BitmapGetPixels(bitmap);

    bmiHdr.biSize = sizeof(BitMapInfoHeader);
    bmiHdr.biWidth = w;                       // 指定图像的宽度，单位是像素
    bmiHdr.biHeight = h;                      // 指定图像的高度，单位是像素
    bmiHdr.biPlanes = 1;                      // 目标设备的级别，必须是1
    bmiHdr.biBitCount = 16;                   // 表示用到颜色时用到的位数 16位表示高彩色图
    bmiHdr.biCompression = BI_BITFIELDS;      // RGB565格式
    bmiHdr.biSizeImage = (w + w % 2) * h * 2; // 指定实际位图所占字节数
    bmiHdr.biXPelsPerMeter = 0;               // 水平分辨率，单位长度内的像素数
    bmiHdr.biYPelsPerMeter = 0;               // 垂直分辨率，单位长度内的像素数
    bmiHdr.biClrUsed = 0; // 位图实际使用的彩色表中的颜色索引数（设为0的话，则说明使用所有调色板项）
    bmiHdr.biClrImportant = 0; // 说明对图象显示有重要影响的颜色索引的数目，0表示所有颜色都重要

    // RGB565格式掩码
    bmiClr[0].rgbBlue = 0;
    bmiClr[0].rgbGreen = 0xF8;
    bmiClr[0].rgbRed = 0;
    bmiClr[0].rgbReserved = 0;

    bmiClr[1].rgbBlue = 0xE0;
    bmiClr[1].rgbGreen = 0x07;
    bmiClr[1].rgbRed = 0;
    bmiClr[1].rgbReserved = 0;

    bmiClr[2].rgbBlue = 0x1F;
    bmiClr[2].rgbGreen = 0;
    bmiClr[2].rgbRed = 0;
    bmiClr[2].rgbReserved = 0;

    bmfHdr.bfType = (WORD)0x4D42; // 文件类型，0x4D42也就是字符'BM'
    bmfHdr.bfSize =
        (DWORD)(sizeof(BitMapFileHeader) + sizeof(BitMapInfoHeader) + sizeof(bmiClr) + bmiHdr.biSizeImage); // 文件大小
    bmfHdr.bfReserved1 = 0; // 保留，必须为0
    bmfHdr.bfReserved2 = 0; // 保留，必须为0
    bmfHdr.bfOffBits =
        (DWORD)(sizeof(BitMapFileHeader) + sizeof(BitMapInfoHeader) + sizeof(bmiClr)); // 实际图像数据偏移量

    uint8_t *data = (uint8_t *)malloc(bmfHdr.bfSize);
    safe_memset(data, bmfHdr.bfSize, 0, bmfHdr.bfOffBits);
    uint8_t *start = data;
    int32_t destsz = bmfHdr.bfSize;
    safe_memcpy(start, destsz, &bmfHdr, sizeof(BitMapFileHeader));
    start += sizeof(BitMapFileHeader);
    destsz -= sizeof(BitMapFileHeader);
    safe_memcpy(start, destsz, &bmiHdr, sizeof(BitMapInfoHeader));
    start += sizeof(BitMapInfoHeader);
    destsz -= sizeof(BitMapInfoHeader);
    safe_memcpy(start, destsz, &bmiClr, sizeof(bmiClr));
    start += sizeof(bmiClr);
    destsz -= sizeof(bmiClr);
    for (int i = 0; i < h; i++) {
        safe_memcpy(start, destsz, bitmapAddr + (w * (h - i - 1) * 2), w * 2);
        start += (w + w % 2) * 2;
        destsz -= (w + w % 2) * 2;
    }

    UInt8Data u8data;
    u8data.data = data;
    u8data.len = bmfHdr.bfSize;
    return u8data;
}

static UInt8Data toBitmapBGRA8888(OH_Drawing_Bitmap *bitmap) {
    BitMapFileHeader bmfHdr; // 定义文件头
    BitMapInfoHeader bmiHdr; // 定义信息头

    uint32_t w = OH_Drawing_BitmapGetWidth(bitmap);
    uint32_t h = OH_Drawing_BitmapGetHeight(bitmap);
    uint8_t *bitmapAddr = (uint8_t *)OH_Drawing_BitmapGetPixels(bitmap);

    bmiHdr.biSize = sizeof(BitMapInfoHeader);
    bmiHdr.biWidth = w;             // 指定图像的宽度，单位是像素
    bmiHdr.biHeight = h;            // 指定图像的高度，单位是像素
    bmiHdr.biPlanes = 1;            // 目标设备的级别，必须是1
    bmiHdr.biBitCount = 32;         // 表示用到颜色时用到的位数 16位表示高彩色图
    bmiHdr.biCompression = BI_RGB;  // BGRA_8888格式
    bmiHdr.biSizeImage = w * h * 4; // 指定实际位图所占字节数
    bmiHdr.biXPelsPerMeter = 0;     // 水平分辨率，单位长度内的像素数
    bmiHdr.biYPelsPerMeter = 0;     // 垂直分辨率，单位长度内的像素数
    bmiHdr.biClrUsed = 0; // 位图实际使用的彩色表中的颜色索引数（设为0的话，则说明使用所有调色板项）
    bmiHdr.biClrImportant = 0; // 说明对图象显示有重要影响的颜色索引的数目，0表示所有颜色都重要

    bmfHdr.bfType = (WORD)0x4D42; // 文件类型，0x4D42也就是字符'BM'
    bmfHdr.bfSize = (DWORD)(sizeof(BitMapFileHeader) + sizeof(BitMapInfoHeader) + bmiHdr.biSizeImage); // 文件大小
    bmfHdr.bfReserved1 = 0;                                                          // 保留，必须为0
    bmfHdr.bfReserved2 = 0;                                                          // 保留，必须为0
    bmfHdr.bfOffBits = (DWORD)(sizeof(BitMapFileHeader) + sizeof(BitMapInfoHeader)); // 实际图像数据偏移量

    uint8_t *data = (uint8_t *)malloc(bmfHdr.bfSize);
    safe_memset(data, bmfHdr.bfSize, 0, bmfHdr.bfOffBits);
    uint8_t *start = data;
    int32_t destsz = bmfHdr.bfSize;
    safe_memcpy(start, destsz, &bmfHdr, sizeof(BitMapFileHeader));
    start += sizeof(BitMapFileHeader);
    destsz -= sizeof(BitMapFileHeader);
    safe_memcpy(start, destsz, &bmiHdr, sizeof(BitMapInfoHeader));
    start += sizeof(BitMapInfoHeader);
    destsz -= sizeof(BitMapInfoHeader);
    for (int i = 0; i < h; i++) {
        safe_memcpy(start, destsz, bitmapAddr + (w * (h - i - 1) * 4), w * 4);
        start += w * 4;
        destsz -= w * 4;
    }
    UInt8Data u8data;
    u8data.data = data;
    u8data.len = bmfHdr.bfSize;
    return u8data;
}

/**
 * @brief 将bitmap转换成数组数据
 * @param bitmap                bitmap
 * @param colorFormat           图片格式
 *
 * @return 图片数组数据
 */
UInt8Data TeXRenderToBitmap(OH_Drawing_Bitmap *bitmap, OH_Drawing_ColorFormat colorFormat) {
    if (colorFormat == COLOR_FORMAT_RGB_565) {
        return toBitmapRGB565(bitmap);
    } else {
        return toBitmapBGRA8888(bitmap);
    }
}

/**
 * @brief 初始化bitmap
 * @param uint32_t              图片宽度
 * @param uint32_t              图片高度
 * @param colorFormat           图片格式
 *
 * @return bitmap对象
 */
OH_Drawing_Bitmap *initGraphics2D(uint32_t w, uint32_t h, OH_Drawing_ColorFormat colorFormat) {
    OH_Drawing_Bitmap *bitmap = OH_Drawing_BitmapCreate();
    // 定义bitmap的像素格式
    OH_Drawing_BitmapFormat cFormat{colorFormat, ALPHA_FORMAT_PREMUL};
    // 构造对应格式的bitmap
    OH_Drawing_BitmapBuild(bitmap, w, h, &cFormat);
    return bitmap;
}

/**
 * @brief 通过文字生成图片（圆形）
 * @param str                   文本内容
 * @param fontSize              字体大小
 * @param fontColor             字体颜色
 * @param fontBackGroupColor    背景颜色
 * @param backGroupColor        主题背景颜色
 * @param textHeight            控件高度
 * @param colorFormat           图片格式
 *
 * @return 图片数组数据
 */
UInt8Data drawCircleImage(char *str, float fontSize, uint32_t fontColor, uint32_t fontBackGroupColor,
                          uint32_t backGroupColor, float textHeight, OH_Drawing_ColorFormat colorFormat) {
    OH_Drawing_Bitmap *bitmap = initGraphics2D(textHeight, textHeight, colorFormat); // 初始化bitmap
    OH_Drawing_Canvas *bitmapCanvas = OH_Drawing_CanvasCreate();                     // 创建一个画布对象
    OH_Drawing_CanvasBind(bitmapCanvas, bitmap); // 将Canvas与bitmap绑定，Canvas绘制的内容会输出到绑定的bitmap内存中
    OH_Drawing_CanvasClear(bitmapCanvas, backGroupColor); // 使用透明色去清空画布
    // 画圆和背景颜色
    OH_Drawing_Rect *rect = OH_Drawing_RectCreate(0.0, 0.0, textHeight, textHeight); // 创建矩形对象
    OH_Drawing_RoundRect *roundRect =
        OH_Drawing_RoundRectCreate(rect, textHeight / 2, textHeight / 2); // 创建圆角矩形对象
    OH_Drawing_Brush *brush = OH_Drawing_BrushCreate();                   // 创建画刷对象
    OH_Drawing_BrushSetColor(brush, fontBackGroupColor);                  // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                    // 画背景
    OH_Drawing_CanvasDrawRoundRect(bitmapCanvas, roundRect);              // 画圆角矩形
    // 画文本和文本颜色
    OH_Drawing_Font *font = OH_Drawing_FontCreate();                                           // 创建font字体对象
    OH_Drawing_FontSetTextSize(font, fontSize);                                                // 设置字体大小
    OH_Drawing_Rect *bounds = OH_Drawing_RectCreate(0.0, 0.0, 0.0, 0.0);                       // 创建矩形对象
    float w = 0.0;                                                                             // 文本宽度
    float *textWidth = &w;                                                                     // 文本宽度
    OH_Drawing_FontMeasureText(font, str, strlen(str), TEXT_ENCODING_UTF8, bounds, textWidth); // 获取文本宽度和边界
    OH_Drawing_Font_Metrics metrics;                                                           // 字体度量信息
    OH_Drawing_FontGetMetrics(font, &metrics);      // 获取字体度量信息
    float textH = -metrics.ascent;                  // 获取矩形对象高度 - 文本基于基线上偏移量
    float textW = w;                                // 文本宽度
    float textX = (textHeight - textW) / 2;         // 居中文本左下角X坐标
    float textY = (textHeight - textH) / 2 + textH; // 居中文本左下角Y坐标
    OH_Drawing_TextBlob *textBlob =
        OH_Drawing_TextBlobCreateFromString(str, font, TEXT_ENCODING_UTF8); // 通过字符串创建文本对象
    OH_Drawing_BrushSetColor(brush, fontColor);                             // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                      // 画背景
    OH_Drawing_CanvasDrawTextBlob(bitmapCanvas, textBlob, textX, textY);    // 画文字
    return TeXRenderToBitmap(bitmap, colorFormat);                          // pixmap数组数据
}

/**
 * @brief 通过文字生成图片（圆角矩形）
 * @param str                   文本内容
 * @param fontSize              字体大小
 * @param fontColor             字体颜色
 * @param fontBackGroupColor    背景颜色
 * @param backGroupColor        主题背景颜色
 * @param textHeight            控件高度
 * @param colorFormat           图片格式
 * @param padding               左右边距
 *
 * @return 图片数组数据
 */
UInt8Data drawRectImage(char *str, float fontSize, uint32_t fontColor, uint32_t fontBackGroupColor,
                        uint32_t backGroupColor, float textHeight, OH_Drawing_ColorFormat colorFormat, float padding) {
    // 画文本和文本颜色
    OH_Drawing_Font *font = OH_Drawing_FontCreate();                                           // 创建font字体对象
    OH_Drawing_FontSetTextSize(font, fontSize);                                                // 设置字体大小
    OH_Drawing_Rect *bounds = OH_Drawing_RectCreate(0.0, 0.0, 0.0, 0.0);                       // 创建矩形对象
    float w = 0.0;                                                                             // 文本宽度
    float *textWidth = &w;                                                                     // 文本宽度
    OH_Drawing_FontMeasureText(font, str, strlen(str), TEXT_ENCODING_UTF8, bounds, textWidth); // 获取文本宽度和边界
    // 画圆和背景颜色
    float rectWidth = w + 2 * padding;                                              // 矩形宽度
    OH_Drawing_Bitmap *bitmap = initGraphics2D(rectWidth, textHeight, colorFormat); // 初始化bitmap
    OH_Drawing_Canvas *bitmapCanvas = OH_Drawing_CanvasCreate();                    // 创建一个画布对象
    OH_Drawing_CanvasBind(bitmapCanvas, bitmap); // 将Canvas与bitmap绑定，Canvas绘制的内容会输出到绑定的bitmap内存中
    OH_Drawing_CanvasClear(bitmapCanvas, backGroupColor);                           // 使用透明色去清空画布
    OH_Drawing_Rect *rect = OH_Drawing_RectCreate(0.0, 0.0, rectWidth, textHeight); // 创建矩形对象
    OH_Drawing_RoundRect *roundRect =
        OH_Drawing_RoundRectCreate(rect, textHeight / 2, textHeight / 2); // 创建圆角矩形对象
    OH_Drawing_Brush *brush = OH_Drawing_BrushCreate();                   // 创建画刷对象
    OH_Drawing_BrushSetColor(brush, fontBackGroupColor);                  // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                    // 画背景
    OH_Drawing_CanvasDrawRoundRect(bitmapCanvas, roundRect);              // 画圆角矩形
    OH_Drawing_Font_Metrics metrics;                                      // 字体度量信息
    OH_Drawing_FontGetMetrics(font, &metrics);                            // 获取字体度量信息
    float textH = -metrics.ascent;                  // 获取矩形对象高度 - 文本基于基线上偏移量
    float textX = padding;                          // 居中文本左下角X坐标
    float textY = (textHeight - textH) / 2 + textH; // 居中文本左下角Y坐标
    OH_Drawing_TextBlob *textBlob =
        OH_Drawing_TextBlobCreateFromString(str, font, TEXT_ENCODING_UTF8); // 通过字符串创建文本对象
    OH_Drawing_BrushSetColor(brush, fontColor);                             // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                      // 画背景
    OH_Drawing_CanvasDrawTextBlob(bitmapCanvas, textBlob, textX, textY);    // 画文字
    return TeXRenderToBitmap(bitmap, colorFormat);                          // pixmap数组数据
}

/**
 * @brief 通过文字生成图片（圆角矩形带边框和分割线中间分割线）
 * @param str1                  文本内容1
 * @param str2                  文本内容2
 * @param fontSize              字体大小
 * @param fontColor             字体颜色
 * @param fontBackGroupColor    背景颜色
 * @param backGroupColor        主题背景颜色
 * @param textHeight            控件高度
 * @param borderColor           边框颜色
 * @param borderWidth           边框宽度
 * @param dividingLineColor     分割线颜色
 * @param dividingLineWidth     分割线宽度
 * @param colorFormat           图片格式
 * @param padding               左右边距
 *
 * @return 图片数组数据
 */
UInt8Data drawRectToolImage(char *str1, char *str2, float fontSize, uint32_t fontColor, uint32_t fontBackGroupColor,
                            uint32_t backGroupColor, uint32_t borderColor, float borderWidth,
                            uint32_t dividingLineColor, float dividingLineWidth, float textHeight,
                            OH_Drawing_ColorFormat colorFormat, float padding) {
    // 画文本1和文本1颜色
    OH_Drawing_Font *font1 = OH_Drawing_FontCreate();                     // 创建font字体对象
    OH_Drawing_FontSetTextSize(font1, fontSize);                          // 设置字体大小
    OH_Drawing_Rect *bounds1 = OH_Drawing_RectCreate(0.0, 0.0, 0.0, 0.0); // 创建矩形对象
    float w1 = 0.0;                                                       // 文本宽度
    float *textWidth1 = &w1;                                              // 文本宽度
    OH_Drawing_FontMeasureText(font1, str1, strlen(str1), TEXT_ENCODING_UTF8, bounds1,
                               textWidth1); // 获取文本宽度和边界
    // 画文本2和文本2颜色
    OH_Drawing_Font *font2 = OH_Drawing_FontCreate();                     // 创建font字体对象
    OH_Drawing_FontSetTextSize(font2, fontSize);                          // 设置字体大小
    OH_Drawing_Rect *bounds2 = OH_Drawing_RectCreate(0.0, 0.0, 0.0, 0.0); // 创建矩形对象
    float w2 = 0.0;                                                       // 文本宽度
    float *textWidth2 = &w2;                                              // 文本宽度
    OH_Drawing_FontMeasureText(font2, str2, strlen(str2), TEXT_ENCODING_UTF8, bounds2,
                               textWidth2); // 获取文本宽度和边界
    // 画圆和背景颜色
    float rectWidth = w1 + 2 * padding + dividingLineWidth + w2 + 2 * padding + 2 * borderWidth; // 矩形宽度
    float internalRectWidth = w1 + 2 * padding + dividingLineWidth + w2 + 2 * padding;           // 内部矩形宽度
    float internalRectHeight = textHeight - 2 * borderWidth;                                     // 内部矩形高度
    OH_Drawing_Bitmap *bitmap = initGraphics2D(rectWidth, textHeight, colorFormat);              // 初始化bitmap
    OH_Drawing_Canvas *bitmapCanvas = OH_Drawing_CanvasCreate(); // 创建一个画布对象
    OH_Drawing_CanvasBind(bitmapCanvas, bitmap); // 将Canvas与bitmap绑定，Canvas绘制的内容会输出到绑定的bitmap内存中
    OH_Drawing_CanvasClear(bitmapCanvas, backGroupColor);                           // 使用透明色去清空画布
    OH_Drawing_Rect *rect = OH_Drawing_RectCreate(0.0, 0.0, rectWidth, textHeight); // 创建矩形对象
    OH_Drawing_RoundRect *roundRect =
        OH_Drawing_RoundRectCreate(rect, textHeight / 2, textHeight / 2); // 创建圆角矩形对象
    OH_Drawing_Brush *brush = OH_Drawing_BrushCreate();                   // 创建画刷对象
    OH_Drawing_BrushSetColor(brush, borderColor);                         // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                    // 画背景
    OH_Drawing_CanvasDrawRoundRect(bitmapCanvas, roundRect);              // 画圆角矩形
    OH_Drawing_Rect *internalRect =
        OH_Drawing_RectCreate(borderWidth, borderWidth, internalRectWidth + borderWidth, internalRectHeight + borderWidth); // 创建矩形对象
    OH_Drawing_RoundRect *internalRoundRect =
        OH_Drawing_RoundRectCreate(internalRect, internalRectHeight / 2, internalRectHeight / 2); // 创建圆角矩形对象
    OH_Drawing_BrushSetColor(brush, fontBackGroupColor);                                          // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                                            // 画背景
    OH_Drawing_CanvasDrawRoundRect(bitmapCanvas, internalRoundRect);                              // 画圆角矩形
    OH_Drawing_Font_Metrics metrics1;                                                             // 字体度量信息
    OH_Drawing_FontGetMetrics(font1, &metrics1);       // 获取字体度量信息
    float textH1 = -metrics1.ascent;                   // 获取矩形对象高度 - 文本基于基线上偏移量
    float textX1 = padding + borderWidth;              // 居中文本左下角X坐标
    float textY1 = (textHeight - textH1) / 2 + textH1; // 居中文本左下角Y坐标
    OH_Drawing_TextBlob *textBlob1 =
        OH_Drawing_TextBlobCreateFromString(str1, font1, TEXT_ENCODING_UTF8); // 通过字符串创建文本对象
    OH_Drawing_BrushSetColor(brush, fontColor);                               // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                        // 画背景
    OH_Drawing_CanvasDrawTextBlob(bitmapCanvas, textBlob1, textX1, textY1);   // 画文字
    OH_Drawing_TextBlob *textBlob2 =
        OH_Drawing_TextBlobCreateFromString(str2, font2, TEXT_ENCODING_UTF8); // 通过字符串创建文本对象
    OH_Drawing_BrushSetColor(brush, fontColor);                               // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                        // 画背景
    OH_Drawing_Font_Metrics metrics2;                                         // 字体度量信息
    OH_Drawing_FontGetMetrics(font2, &metrics2);                              // 获取字体度量信息
    float textH2 = -metrics2.ascent; // 获取矩形对象高度 - 文本基于基线上偏移量
    float textX2 = padding + borderWidth + w1 + padding + dividingLineWidth + padding; // 居中文本左下角X坐标
    float textY2 = (textHeight - textH2) / 2 + textH2;                                 // 居中文本左下角Y坐标
    OH_Drawing_CanvasDrawTextBlob(bitmapCanvas, textBlob2, textX2, textY2);            // 画文字
    float lineX1 = padding + borderWidth + w1 + padding;
    float lineY1 = (textHeight - textH2) / 2;
    float lineX2 = padding + borderWidth + w1 + padding + dividingLineWidth;
    float lineY2 = (textHeight - textH2) / 2 + textH2;
    OH_Drawing_Rect *lineRect = OH_Drawing_RectCreate(lineX1, lineY1, lineX2, lineY2); // 创建矩形对象
    OH_Drawing_BrushSetColor(brush, dividingLineColor);                                // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                                 // 画背景
    OH_Drawing_CanvasDrawRect(bitmapCanvas, lineRect);                                 // 画矩形
    return TeXRenderToBitmap(bitmap, colorFormat);                                     // pixmap数组数据
}

#ifdef __cplusplus
}
#endif

#endif // __OS_ohos__