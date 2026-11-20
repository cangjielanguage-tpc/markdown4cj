#include <cstdint>
#define OS_OHOS

#ifdef OS_OHOS

#include <native_drawing/drawing_bitmap.h>

#include "utils.h"
#include <cmath>
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

// safe_*系列返回错误码（0成功/负数失败），禁止在extern "C"/napi边界内抛C++异常，
// 异常穿越FFI边界行为未定义（典型结局std::terminate进程崩溃）
int safe_memcpy(void *dest, size_t dest_size, const void *src, size_t src_size)
{
    if (dest == NULL || src == NULL) {
        return -1;
    }
    if (dest_size < src_size) {
        return -1;
    }
    std::memcpy(dest, src, src_size);
    return 0;
}

int safe_memset(void *dest, size_t destSize, int value, size_t count)
{
    if (dest == NULL) {
        return -1;
    }
    if (count > destSize) {
        return -1;
    }
    std::memset(dest, value, count);
    return 0;
}

const int PLANES = 1;
const int BIT_COUNT_16 = 16;
const int BIT_COUNT_32 = 32;
const int ZERO = 0;
const int ONE = 1;
const int TWO = 2;
const int FOUR = 4;
const int COLOR_0XF8 = 0xF8;
const int COLOR_0XE0 = 0xE0;
const int COLOR_0X07 = 0x07;
const int COLOR_0X1F = 0x1F;
const int COLOR_0X4D42 = 0x4D42;
const int COLOR_0X00FF0000 = 0x00FF0000;
const int COLOR_0X0000FF00 = 0x0000FF00;
const int COLOR_0X000000FF = 0x000000FF;
const int COLOR_0XFF000000 = 0xFF000000;
const int COLOR_0X73524742 = 0x73524742;

// 单张位图像素量硬上限：异常尺寸输入下限制内存分配放大（DoS/整数回绕防护）
const uint64_t MAX_BITMAP_PIXELS = 100000000ULL;
// 绘制尺寸硬上限（px）：位图宽高钳制，防止异常数值放大到位图分配失控
const float MAX_DRAW_DIMENSION = 8192.0f;
const float MIN_DRAW_DIMENSION = 1.0f;

typedef struct {
    uint8_t *data;
    int64_t len;
    int32_t width;
    int32_t height;
} UInt8Data;

// 绘制尺寸钳制：NaN/负值回落最小值，超大值钳到上限
static float clampDrawSize(float v)
{
    if (std::isnan(v) || v < MIN_DRAW_DIMENSION) {
        return MIN_DRAW_DIMENSION;
    }
    if (v > MAX_DRAW_DIMENSION) {
        return MAX_DRAW_DIMENSION;
    }
    return v;
}

// 位图像素量合法性校验：uint64计算防回绕，超上限返回false
static bool isPixelCountValid(uint64_t w, uint64_t h)
{
    return w * h <= MAX_BITMAP_PIXELS;
}

static UInt8Data toRawPixelData(OH_Drawing_Bitmap *bitmap)
{
    uint32_t w = OH_Drawing_BitmapGetWidth(bitmap);
    uint32_t h = OH_Drawing_BitmapGetHeight(bitmap);
    uint8_t *bitmapAddr = (uint8_t *)OH_Drawing_BitmapGetPixels(bitmap);
    // 位图构建失败/无效时GetPixels返回NULL，判空防对NULL源memcpy段错误
    if (bitmapAddr == NULL) {
        UInt8Data empty = {NULL, 0, 0, 0};
        return empty;
    }
    int64_t dataLen = (int64_t)w * (int64_t)h * 4;

    uint8_t *data = (uint8_t *)malloc(dataLen);
    if (!data) {
        UInt8Data empty = {NULL, 0, 0, 0};
        return empty;
    }
    memcpy(data, bitmapAddr, dataLen);

    UInt8Data result;
    result.data = data;
    result.len = dataLen;
    result.width = (int32_t)w;
    result.height = (int32_t)h;
    return result;
}


static UInt8Data toBitmapRGB565(OH_Drawing_Bitmap *bitmap)
{
    BitMapFileHeader bmfHdr; // 定义文件头
    BitMapInfoHeader bmiHdr; // 定义信息头
    RgbQuad bmiClr[3];       // 定义调色板

    uint32_t w = OH_Drawing_BitmapGetWidth(bitmap);
    uint32_t h = OH_Drawing_BitmapGetHeight(bitmap);
    uint8_t *bitmapAddr = (uint8_t *)OH_Drawing_BitmapGetPixels(bitmap);
    // 位图构建失败/无效时GetPixels返回NULL，判空防对NULL源memcpy段错误
    if (bitmapAddr == NULL) {
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }

    // 像素量与字节数用uint64计算并校验上限，防止uint32回绕导致后续空间校验符号反转失效
    uint64_t rowBytes = ((uint64_t)w + (uint64_t)(w % TWO)) * TWO; // 含行尾padding的每行字节数
    uint64_t pixelDataBytes = rowBytes * (uint64_t)h;
    uint64_t headerBytes = (uint64_t)sizeof(BitMapFileHeader) + (uint64_t)sizeof(BitMapInfoHeader) +
                           (uint64_t)sizeof(bmiClr);
    uint64_t totalBytes = headerBytes + pixelDataBytes;
    if (!isPixelCountValid((uint64_t)w, (uint64_t)h) || totalBytes > 0xFFFFFFFFULL) {
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }

    bmiHdr.biSize = sizeof(BitMapInfoHeader);
    bmiHdr.biWidth = w;                       // 指定图像的宽度，单位是像素
    bmiHdr.biHeight = h;                      // 指定图像的高度，单位是像素
    bmiHdr.biPlanes = PLANES;                      // 目标设备的级别，必须是1
    bmiHdr.biBitCount = BIT_COUNT_16;                   // 表示用到颜色时用到的位数 16位表示高彩色图
    bmiHdr.biCompression = BI_BITFIELDS;      // RGB565格式
    bmiHdr.biSizeImage = (DWORD)pixelDataBytes; // 指定实际位图所占字节数
    bmiHdr.biXPelsPerMeter = ZERO;               // 水平分辨率，单位长度内的像素数
    bmiHdr.biYPelsPerMeter = ZERO;               // 垂直分辨率，单位长度内的像素数
    bmiHdr.biClrUsed = ZERO; // 位图实际使用的彩色表中的颜色索引数（设为0的话，则说明使用所有调色板项）
    bmiHdr.biClrImportant = ZERO; // 说明对图象显示有重要影响的颜色索引的数目，0表示所有颜色都重要

    // RGB565格式掩码
    bmiClr[ZERO].rgbBlue = ZERO;
    bmiClr[ZERO].rgbGreen = COLOR_0XF8;
    bmiClr[ZERO].rgbRed = ZERO;
    bmiClr[ZERO].rgbReserved = ZERO;

    bmiClr[ONE].rgbBlue = COLOR_0XE0;
    bmiClr[ONE].rgbGreen = COLOR_0X07;
    bmiClr[ONE].rgbRed = ZERO;
    bmiClr[ONE].rgbReserved = ZERO;

    bmiClr[TWO].rgbBlue = COLOR_0X1F;
    bmiClr[TWO].rgbGreen = ZERO;
    bmiClr[TWO].rgbRed = ZERO;
    bmiClr[TWO].rgbReserved = ZERO;

    bmfHdr.bfType = (WORD)COLOR_0X4D42; // 文件类型，0x4D42也就是字符'BM'
    bmfHdr.bfSize = (DWORD)totalBytes; // 文件大小
    bmfHdr.bfReserved1 = ZERO; // 保留，必须为0
    bmfHdr.bfReserved2 = ZERO; // 保留，必须为0
    bmfHdr.bfOffBits = (DWORD)headerBytes; // 实际图像数据偏移量

    uint8_t *data = (uint8_t *)malloc((size_t)totalBytes);
    // malloc失败返回空结果（与toRawPixelData防护一致），禁止对NULL写入
    if (data == NULL) {
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }
    // 整块清零：奇数宽度行尾padding不再携带未初始化堆内存（信息泄漏防护）
    if (safe_memset(data, (size_t)totalBytes, ZERO, (size_t)totalBytes) != 0) {
        free(data);
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }
    size_t offset = 0;
    if (safe_memcpy(data + offset, totalBytes - offset, &bmfHdr, sizeof(BitMapFileHeader)) != 0) {
        free(data);
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }
    offset += sizeof(BitMapFileHeader);
    if (safe_memcpy(data + offset, totalBytes - offset, &bmiHdr, sizeof(BitMapInfoHeader)) != 0) {
        free(data);
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }
    offset += sizeof(BitMapInfoHeader);
    if (safe_memcpy(data + offset, totalBytes - offset, &bmiClr, sizeof(bmiClr)) != 0) {
        free(data);
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }
    offset += sizeof(bmiClr);
    for (uint32_t i = 0; i < h; i++) {
        if (safe_memcpy(data + offset, totalBytes - offset,
                        bitmapAddr + ((uint64_t)w * (h - i - ONE) * TWO), (size_t)(w * TWO)) != 0) {
            free(data);
            UInt8Data empty = {NULL, ZERO, 0, 0};
            return empty;
        }
        offset += (size_t)rowBytes;
    }

    UInt8Data u8data;
    u8data.data = data;
    u8data.len = (int64_t)totalBytes;
    return u8data;
}

// 手动定义必要的结构体
typedef struct {
    LONG fx;
    LONG fy;
    LONG fz;
} CIEXYZ;

typedef struct {
    CIEXYZ ciexyzRed;
    CIEXYZ ciexyzGreen;
    CIEXYZ ciexyzBlue;
} CIEXYZTRIPLE;

typedef struct {
    DWORD bV4Size;
    LONG  bV4Width;
    LONG  bV4Height;
    WORD  bV4Planes;
    WORD  bV4BitCount;
    DWORD bV4Compression;
    DWORD bV4SizeImage;
    LONG  bV4XPelsPerMeter;
    LONG  bV4YPelsPerMeter;
    DWORD bV4ClrUsed;
    DWORD bV4ClrImportant;
    DWORD bV4RedMask;
    DWORD bV4GreenMask;
    DWORD bV4BlueMask;
    DWORD bV4AlphaMask;
    DWORD bV4CSType;
    CIEXYZTRIPLE bV4Endpoints;
    DWORD bV4GammaRed;
    DWORD bV4GammaGreen;
    DWORD bV4GammaBlue;
} BitMapV4Header;

static UInt8Data toBitmapBGRA8888(OH_Drawing_Bitmap *bitmap)
{
    BitMapFileHeader bmfHdr;
    BitMapV4Header bmiHdr;

    uint32_t w = OH_Drawing_BitmapGetWidth(bitmap);
    uint32_t h = OH_Drawing_BitmapGetHeight(bitmap);
    uint8_t *bitmapAddr = (uint8_t *)OH_Drawing_BitmapGetPixels(bitmap);
    // 位图构建失败/无效时GetPixels返回NULL，判空防对NULL源memcpy段错误
    if (bitmapAddr == NULL) {
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }

    // 像素量与字节数用uint64计算并校验上限，防止uint32回绕
    uint64_t pixelDataBytes = (uint64_t)w * (uint64_t)h * FOUR;
    uint64_t totalBytes = (uint64_t)sizeof(BitMapFileHeader) + (uint64_t)sizeof(BitMapV4Header) + pixelDataBytes;
    if (!isPixelCountValid((uint64_t)w, (uint64_t)h) || totalBytes > 0xFFFFFFFFULL) {
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }

    // 初始化BITMAPV4HEADER
    memset(&bmiHdr, ZERO, sizeof(BitMapV4Header));
    bmiHdr.bV4Size = sizeof(BitMapV4Header);
    bmiHdr.bV4Width = w;
    bmiHdr.bV4Height = h;
    bmiHdr.bV4Planes = PLANES;
    bmiHdr.bV4BitCount = BIT_COUNT_32;
    bmiHdr.bV4Compression = BI_BITFIELDS;
    bmiHdr.bV4SizeImage = (DWORD)pixelDataBytes;
    bmiHdr.bV4XPelsPerMeter = ZERO;
    bmiHdr.bV4YPelsPerMeter = ZERO;
    bmiHdr.bV4ClrUsed = ZERO;
    bmiHdr.bV4ClrImportant = ZERO;

    // 设置颜色掩码 - BGRA顺序
    bmiHdr.bV4RedMask = COLOR_0X00FF0000;
    bmiHdr.bV4GreenMask = COLOR_0X0000FF00;
    bmiHdr.bV4BlueMask = COLOR_0X000000FF;
    bmiHdr.bV4AlphaMask = COLOR_0XFF000000;

    // 设置颜色空间为sRGB
    bmiHdr.bV4CSType = COLOR_0X73524742;

    // 设置文件头
    bmfHdr.bfType = (WORD)COLOR_0X4D42;
    bmfHdr.bfSize = (DWORD)totalBytes;
    bmfHdr.bfReserved1 = ZERO;
    bmfHdr.bfReserved2 = ZERO;
    bmfHdr.bfOffBits = (DWORD)(sizeof(BitMapFileHeader) + sizeof(BitMapV4Header));

    // 分配内存
    uint8_t *data = (uint8_t *)malloc((size_t)totalBytes);
    if (!data) {
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }

    size_t offset = 0;
    // 复制文件头（safe_*失败时释放缓冲返回空结果，杜绝泄漏）
    if (safe_memcpy(data + offset, totalBytes - offset, &bmfHdr, sizeof(BitMapFileHeader)) != 0) {
        free(data);
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }
    offset += sizeof(BitMapFileHeader);

    // 复制信息头
    if (safe_memcpy(data + offset, totalBytes - offset, &bmiHdr, sizeof(BitMapV4Header)) != 0) {
        free(data);
        UInt8Data empty = {NULL, ZERO, 0, 0};
        return empty;
    }
    offset += sizeof(BitMapV4Header);

    // 复制像素数据（BMP是从下到上存储的）
    for (uint32_t i = 0; i < h; i++) {
        uint8_t *srcLine = bitmapAddr + ((uint64_t)w * (h - i - ONE) * FOUR);
        if (safe_memcpy(data + offset, totalBytes - offset, srcLine, (size_t)((uint64_t)w * FOUR)) != 0) {
            free(data);
            UInt8Data empty = {NULL, ZERO, 0, 0};
            return empty;
        }
        offset += (size_t)((uint64_t)w * FOUR);
    }

    UInt8Data u8data;
    u8data.data = data;
    u8data.len = (int64_t)totalBytes;
    return u8data;
}

/**
 * @brief 将bitmap转换成数组数据
 * @param bitmap                bitmap
 * @param colorFormat           图片格式
 *
 * @return 图片数组数据
 */
UInt8Data TeXRenderToBitmap(OH_Drawing_Bitmap *bitmap, OH_Drawing_ColorFormat colorFormat)
{
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
OH_Drawing_Bitmap *initGraphics2D(uint32_t w, uint32_t h, OH_Drawing_ColorFormat colorFormat)
{
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
 * @param fontBackgroundColor    背景颜色
 * @param backgroundColor        主题背景颜色
 * @param textHeight            控件高度
 * @param colorFormat           图片格式
 *
 * @return 图片数组数据
 */
UInt8Data drawCircleImage(char *str, float fontSize, uint32_t fontColor, uint32_t fontBackgroundColor,
                          uint32_t backgroundColor, float textHeight, OH_Drawing_ColorFormat colorFormat)
{
    float drawHeight = clampDrawSize(textHeight); // 位图边长钳制，防异常尺寸放大内存分配
    OH_Drawing_Bitmap *bitmap = initGraphics2D(drawHeight, drawHeight, colorFormat); // 初始化bitmap
    OH_Drawing_Canvas *bitmapCanvas = OH_Drawing_CanvasCreate();                     // 创建一个画布对象
    OH_Drawing_CanvasBind(bitmapCanvas, bitmap); // 将Canvas与bitmap绑定，Canvas绘制的内容会输出到绑定的bitmap内存中
    OH_Drawing_CanvasClear(bitmapCanvas, backgroundColor); // 使用透明色去清空画布
    // 画圆和背景颜色
    OH_Drawing_Rect *rect = OH_Drawing_RectCreate(0.0, 0.0, drawHeight, drawHeight); // 创建矩形对象
    OH_Drawing_RoundRect *roundRect =
        OH_Drawing_RoundRectCreate(rect, drawHeight / 2, drawHeight / 2); // 创建圆角矩形对象
    OH_Drawing_Brush *brush = OH_Drawing_BrushCreate();                   // 创建画刷对象
    OH_Drawing_BrushSetAntiAlias(brush, true);                            // 设置画刷抗锯齿
    OH_Drawing_BrushSetColor(brush, fontBackgroundColor);                  // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                    // 画背景
    OH_Drawing_CanvasDrawRoundRect(bitmapCanvas, roundRect);              // 画圆角矩形
    // 画文本和文本颜色
    OH_Drawing_Font *font = OH_Drawing_FontCreate();                                           // 创建font字体对象
    OH_Drawing_FontSetTextSize(font, fontSize);                                                // 设置字体大小
    OH_Drawing_Rect *bounds = OH_Drawing_RectCreate(0.0, 0.0, 0.0, 0.0);                       // 创建矩形对象
    float w = 0.0;                                                                             // 文本宽度
    float *textWidth = &w;                                                                     // 文本宽度
    OH_Drawing_FontMeasureText(font, str, strlen(str), TEXT_ENCODING_UTF8, bounds, textWidth); // 获取文本宽度和边界
    float h = OH_Drawing_RectGetHeight(bounds);                                                // 文本真实高度
    float top = OH_Drawing_RectGetTop(bounds);   // 文本真实高度基于基线上边界高度
    float imageTopHeight = (drawHeight - h) / 2; // 居中文本距离图片上边界高度
    float textY = imageTopHeight - top;          // 居中文本左下角Y坐标
    float textX = (drawHeight - w) / 2;          // 居中文本左下角X坐标
    OH_Drawing_TextBlob *textBlob =
        OH_Drawing_TextBlobCreateFromString(str, font, TEXT_ENCODING_UTF8); // 通过字符串创建文本对象
    OH_Drawing_BrushSetColor(brush, fontColor);                             // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                      // 画背景
    OH_Drawing_CanvasDrawTextBlob(bitmapCanvas, textBlob, textX, textY);    // 画文字
    UInt8Data a = TeXRenderToBitmap(bitmap, colorFormat); // BMP数组数据
    
    OH_Drawing_BitmapDestroy(bitmap); // 用于销毁位图对象并回收该对象占有内存。
    OH_Drawing_CanvasDestroy(bitmapCanvas); // 用于销毁画布对象并回收该对象占有的内存。
    OH_Drawing_RectDestroy(rect); // 用于销毁矩形对象并回收该对象占有的内存。
    OH_Drawing_RoundRectDestroy(roundRect); // 用于销毁圆角矩形对象并回收该对象占有的内存。
    OH_Drawing_BrushDestroy(brush); // 用于销毁画刷对象并回收该对象占有的内存。
    OH_Drawing_FontDestroy(font); // 用于销毁字型对象并回收该对象占有的内存。
    OH_Drawing_RectDestroy(bounds); // 用于销毁矩形对象并回收该对象占有的内存。
    OH_Drawing_TextBlobDestroy(textBlob); // 用于销毁文本对象并回收该对象占有的内存。
    
    return a;
}

/**
 * @brief 通过文字生成图片（圆角矩形）
 * @param str                   文本内容
 * @param fontSize              字体大小
 * @param fontColor             字体颜色
 * @param fontBackgroundColor    背景颜色
 * @param backgroundColor        主题背景颜色
 * @param textHeight            控件高度
 * @param colorFormat           图片格式
 * @param padding               左右边距
 * @param radius                圆角半径
 *
 * @return 图片数组数据
 */
UInt8Data drawRectImage(char *str, float fontSize, uint32_t fontColor, uint32_t fontBackgroundColor,
                        uint32_t backgroundColor, float textHeight, OH_Drawing_ColorFormat colorFormat, float padding,
                        float radius, bool isFakeBoldText)
{
    // 画文本和文本颜色
    OH_Drawing_Font *font = OH_Drawing_FontCreate();                                           // 创建font字体对象
    OH_Drawing_FontSetFakeBoldText(font, isFakeBoldText);                                      // 用于设置增加描边宽度以近似粗体字体效果。
    OH_Drawing_FontSetTextSize(font, fontSize);                                                // 设置字体大小
    OH_Drawing_Rect *bounds = OH_Drawing_RectCreate(0.0, 0.0, 0.0, 0.0);                       // 创建矩形对象
    float w = 0.0;                                                                             // 文本宽度
    float *textWidth = &w;                                                                     // 文本宽度
    OH_Drawing_FontMeasureText(font, str, strlen(str), TEXT_ENCODING_UTF8, bounds, textWidth); // 获取文本宽度和边界
    // 画圆和背景颜色
    float drawHeight = clampDrawSize(textHeight);           // 位图高度钳制，防异常尺寸放大内存分配
    float rectWidth = clampDrawSize(w + 2 * padding);       // 矩形宽度钳制（文本宽度可能因超长文本放大）
    OH_Drawing_Bitmap *bitmap = initGraphics2D(rectWidth, drawHeight, colorFormat); // 初始化bitmap
    OH_Drawing_Canvas *bitmapCanvas = OH_Drawing_CanvasCreate();                    // 创建一个画布对象
    OH_Drawing_CanvasBind(bitmapCanvas, bitmap); // 将Canvas与bitmap绑定，Canvas绘制的内容会输出到绑定的bitmap内存中
    OH_Drawing_CanvasClear(bitmapCanvas, backgroundColor);                           // 使用透明色去清空画布
    OH_Drawing_Rect *rect = OH_Drawing_RectCreate(0.0, 0.0, rectWidth, drawHeight); // 创建矩形对象
    OH_Drawing_RoundRect *roundRect = OH_Drawing_RoundRectCreate(rect, radius, radius); // 创建圆角矩形对象
    OH_Drawing_Brush *brush = OH_Drawing_BrushCreate();                                 // 创建画刷对象
    OH_Drawing_BrushSetAntiAlias(brush, true);                                          // 设置画刷抗锯齿
    OH_Drawing_BrushSetColor(brush, fontBackgroundColor);                                // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                                  // 画背景
    OH_Drawing_CanvasDrawRoundRect(bitmapCanvas, roundRect);                            // 画圆角矩形
    float h = OH_Drawing_RectGetHeight(bounds);                                         // 文本真实高度
    float top = OH_Drawing_RectGetTop(bounds);   // 文本真实高度基于基线上边界高度
    float imageTopHeight = (drawHeight - h) / 2; // 居中文本距离图片上边界高度
    float textY = imageTopHeight - top;          // 居中文本左下角Y坐标
    float textX = padding;                       // 居中文本左下角X坐标
    OH_Drawing_TextBlob *textBlob =
        OH_Drawing_TextBlobCreateFromString(str, font, TEXT_ENCODING_UTF8); // 通过字符串创建文本对象
    OH_Drawing_BrushSetColor(brush, fontColor);                             // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                      // 画背景
    OH_Drawing_CanvasDrawTextBlob(bitmapCanvas, textBlob, textX, textY);    // 画文字
    UInt8Data a = TeXRenderToBitmap(bitmap, colorFormat); // BMP数组数据
    
    OH_Drawing_FontDestroy(font); // 用于销毁字型对象并回收该对象占有的内存。
    OH_Drawing_RectDestroy(bounds); // 用于销毁矩形对象并回收该对象占有的内存。
    OH_Drawing_BitmapDestroy(bitmap); // 用于销毁位图对象并回收该对象占有内存。
    OH_Drawing_CanvasDestroy(bitmapCanvas); // 用于销毁画布对象并回收该对象占有的内存。
    OH_Drawing_RectDestroy(rect); // 用于销毁矩形对象并回收该对象占有的内存。
    OH_Drawing_RoundRectDestroy(roundRect); // 用于销毁圆角矩形对象并回收该对象占有的内存。
    OH_Drawing_BrushDestroy(brush); // 用于销毁画刷对象并回收该对象占有的内存。
    OH_Drawing_TextBlobDestroy(textBlob); // 用于销毁文本对象并回收该对象占有的内存。
    
    return a;
}

/**
 * @brief 通过文字生成图片（圆角矩形带边框和分割线中间分割线）
 * @param str1                  文本内容1
 * @param str2                  文本内容2
 * @param fontSize              字体大小
 * @param fontColor             字体颜色
 * @param fontBackgroundColor    背景颜色
 * @param backgroundColor        主题背景颜色
 * @param textHeight            控件高度
 * @param borderColor           边框颜色
 * @param borderWidth           边框宽度
 * @param dividingLineColor     分割线颜色
 * @param dividingLineWidth     分割线宽度
 * @param colorFormat           图片格式
 * @param padding               左右边距
 * @param lineLeftPadding       分割线和文本左边距
 * @param lineRightPadding      分割线和文本右边距
 *
 * @return 图片数组数据
 */
UInt8Data drawRectToolImage(char *str1, char *str2, float fontSize, uint32_t fontColor, uint32_t fontBackgroundColor,
                            uint32_t backgroundColor, uint32_t borderColor, float borderWidth,
                            uint32_t dividingLineColor, float dividingLineWidth, float textHeight,
                            OH_Drawing_ColorFormat colorFormat, float padding, float lineLeftPadding,
                            float lineRightPadding)
{
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
    float drawHeight = clampDrawSize(textHeight); // 位图高度钳制，防异常尺寸放大内存分配
    float rectWidth = clampDrawSize(borderWidth + padding + w1 + lineLeftPadding + dividingLineWidth +
                                    lineRightPadding + w2 + padding + borderWidth); // 矩形宽度钳制
    float internalRectWidth =
        padding + w1 + lineLeftPadding + dividingLineWidth + lineRightPadding + w2 + padding; // 内部矩形宽度
    float internalRectHeight = drawHeight - 2 * borderWidth;                                  // 内部矩形高度
    OH_Drawing_Bitmap *bitmap = initGraphics2D(rectWidth, drawHeight, colorFormat);           // 初始化bitmap
    OH_Drawing_Canvas *bitmapCanvas = OH_Drawing_CanvasCreate(); // 创建一个画布对象
    OH_Drawing_CanvasBind(bitmapCanvas, bitmap); // 将Canvas与bitmap绑定，Canvas绘制的内容会输出到绑定的bitmap内存中
    OH_Drawing_CanvasClear(bitmapCanvas, backgroundColor);                           // 使用透明色去清空画布
    OH_Drawing_Rect *rect = OH_Drawing_RectCreate(0.0, 0.0, rectWidth, drawHeight); // 创建矩形对象
    OH_Drawing_RoundRect *roundRect =
        OH_Drawing_RoundRectCreate(rect, drawHeight / 2, drawHeight / 2); // 创建圆角矩形对象
    OH_Drawing_Brush *brush = OH_Drawing_BrushCreate();                   // 创建画刷对象
    OH_Drawing_BrushSetAntiAlias(brush, true);                            // 设置画刷抗锯齿
    OH_Drawing_BrushSetColor(brush, borderColor);                         // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                    // 画背景
    OH_Drawing_CanvasDrawRoundRect(bitmapCanvas, roundRect);              // 画圆角矩形
    OH_Drawing_Rect *internalRect = OH_Drawing_RectCreate(borderWidth, borderWidth, internalRectWidth + borderWidth,
                                                          internalRectHeight + borderWidth); // 创建矩形对象
    OH_Drawing_RoundRect *internalRoundRect =
        OH_Drawing_RoundRectCreate(internalRect, internalRectHeight / 2, internalRectHeight / 2); // 创建圆角矩形对象
    OH_Drawing_BrushSetColor(brush, fontBackgroundColor);                                          // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                                            // 画背景
    OH_Drawing_CanvasDrawRoundRect(bitmapCanvas, internalRoundRect);                              // 画圆角矩形
    float h1 = OH_Drawing_RectGetHeight(bounds1);                                                 // 文本真实高度
    float top1 = OH_Drawing_RectGetTop(bounds1);   // 文本真实高度基于基线上边界高度
    float imageTopHeight1 = (drawHeight - h1) / 2; // 居中文本距离图片上边界高度
    float textY1 = imageTopHeight1 - top1;         // 居中文本左下角Y坐标
    float textX1 = padding + borderWidth;          // 居中文本左下角X坐标
    OH_Drawing_TextBlob *textBlob1 =
        OH_Drawing_TextBlobCreateFromString(str1, font1, TEXT_ENCODING_UTF8); // 通过字符串创建文本对象
    OH_Drawing_BrushSetColor(brush, fontColor);                               // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                        // 画背景
    OH_Drawing_CanvasDrawTextBlob(bitmapCanvas, textBlob1, textX1, textY1);   // 画文字
    OH_Drawing_TextBlob *textBlob2 =
        OH_Drawing_TextBlobCreateFromString(str2, font2, TEXT_ENCODING_UTF8); // 通过字符串创建文本对象
    OH_Drawing_BrushSetColor(brush, fontColor);                               // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                        // 画背景
    float h2 = OH_Drawing_RectGetHeight(bounds2);                             // 文本真实高度
    float top2 = OH_Drawing_RectGetTop(bounds2);   // 文本真实高度基于基线上边界高度
    float imageTopHeight2 = (drawHeight - h2) / 2; // 居中文本距离图片上边界高度
    float textY2 = imageTopHeight2 - top2;         // 居中文本左下角Y坐标
    float textX2 =
        borderWidth + padding + w1 + lineLeftPadding + dividingLineWidth + lineRightPadding; // 居中文本左下角X坐标
    OH_Drawing_CanvasDrawTextBlob(bitmapCanvas, textBlob2, textX2, textY2);                  // 画文字
    float lineX1 = borderWidth + padding + w1 + lineLeftPadding;
    float lineX2 = borderWidth + padding + w1 + lineLeftPadding + dividingLineWidth;
    float lineY1 = borderWidth + padding;
    float lineY2 = drawHeight - padding - borderWidth;
    OH_Drawing_Rect *lineRect = OH_Drawing_RectCreate(lineX1, lineY1, lineX2, lineY2); // 创建矩形对象
    OH_Drawing_BrushSetColor(brush, dividingLineColor);                                // 设置画刷颜色
    OH_Drawing_CanvasAttachBrush(bitmapCanvas, brush);                                 // 画背景
    OH_Drawing_CanvasDrawRect(bitmapCanvas, lineRect);                                 // 画矩形
    UInt8Data a = TeXRenderToBitmap(bitmap, colorFormat); // BMP数组数据
    
    OH_Drawing_FontDestroy(font1); // 用于销毁字型对象并回收该对象占有的内存。
    OH_Drawing_RectDestroy(bounds1); // 用于销毁矩形对象并回收该对象占有的内存。
    OH_Drawing_FontDestroy(font2); // 用于销毁字型对象并回收该对象占有的内存。
    OH_Drawing_RectDestroy(bounds2); // 用于销毁矩形对象并回收该对象占有的内存。
    OH_Drawing_BitmapDestroy(bitmap); // 用于销毁位图对象并回收该对象占有内存。
    OH_Drawing_CanvasDestroy(bitmapCanvas); // 用于销毁画布对象并回收该对象占有的内存。
    OH_Drawing_RectDestroy(rect); // 用于销毁矩形对象并回收该对象占有的内存。
    OH_Drawing_RoundRectDestroy(roundRect); // 用于销毁圆角矩形对象并回收该对象占有的内存。
    OH_Drawing_BrushDestroy(brush); // 用于销毁画刷对象并回收该对象占有的内存。
    OH_Drawing_RectDestroy(internalRect); // 用于销毁矩形对象并回收该对象占有的内存。
    OH_Drawing_RoundRectDestroy(internalRoundRect); // 用于销毁圆角矩形对象并回收该对象占有的内存。
    OH_Drawing_TextBlobDestroy(textBlob1); // 用于销毁文本对象并回收该对象占有的内存。
    OH_Drawing_TextBlobDestroy(textBlob2); // 用于销毁文本对象并回收该对象占有的内存。
    OH_Drawing_RectDestroy(lineRect); // 用于销毁矩形对象并回收该对象占有的内存。
    
    return a;
}

#ifdef __cplusplus
}
#endif

#endif // OS_OHOS