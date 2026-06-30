#include <napi/native_api.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    uint8_t *data;
    int64_t len;
    int32_t width;
    int32_t height;
} UInt8Data;

extern "C" {
UInt8Data drawCircleImage(char *str, float fontSize, uint32_t fontColor, uint32_t fontBackgroundColor,
                          uint32_t backgroundColor, float textHeight, int32_t colorFormat);
UInt8Data drawRectImage(char *str, float fontSize, uint32_t fontColor, uint32_t fontBackgroundColor,
                        uint32_t backgroundColor, float textHeight, int32_t colorFormat, float padding,
                        float radius, bool isFakeBoldText);
UInt8Data drawRectToolImage(char *str1, char *str2, float fontSize, uint32_t fontColor, uint32_t fontBackgroundColor,
                            uint32_t backgroundColor, uint32_t borderColor, float borderWidth,
                            uint32_t dividingLineColor, float dividingLineWidth, float textHeight,
                            int32_t colorFormat, float padding, float lineLeftPadding, float lineRightPadding);
}

static napi_value CreateArrayBufferFromUInt8Data(napi_env env, UInt8Data data)
{
    if (data.data == NULL || data.len <= 0) {
        napi_value undefined;
        napi_get_undefined(env, &undefined);
        return undefined;
    }
    void *bufferData = NULL;
    napi_value buffer = NULL;
    napi_status status = napi_create_arraybuffer(env, (size_t)data.len, &bufferData, &buffer);
    if (status != napi_ok) {
        free(data.data);
        napi_value undefined;
        napi_get_undefined(env, &undefined);
        return undefined;
    }
    memcpy(bufferData, data.data, (size_t)data.len);
    free(data.data);
    return buffer;
}

static char* GetStringArg(napi_env env, napi_value value)
{
    size_t len = 0;
    napi_get_value_string_utf8(env, value, NULL, 0, &len);
    char *str = (char *)malloc(len + 1);
    if (str == NULL) {
        return NULL;
    }
    size_t written = 0;
    napi_get_value_string_utf8(env, value, str, len + 1, &written);
    str[written] = '\0';
    return str;
}

static napi_value JsDrawCircleImage(napi_env env, napi_callback_info info)
{
    size_t argc = 7;
    napi_value args[7];
    napi_get_cb_info(env, info, &argc, args, NULL, NULL);
    if (argc < 7) {
        napi_value undefined;
        napi_get_undefined(env, &undefined);
        return undefined;
    }
    char *str = GetStringArg(env, args[0]);
    double fontSize = 0;
    napi_get_value_double(env, args[1], &fontSize);
    uint32_t fontColor = 0;
    napi_get_value_uint32(env, args[2], &fontColor);
    uint32_t fontBgColor = 0;
    napi_get_value_uint32(env, args[3], &fontBgColor);
    uint32_t bgColor = 0;
    napi_get_value_uint32(env, args[4], &bgColor);
    double textHeight = 0;
    napi_get_value_double(env, args[5], &textHeight);
    int32_t colorFormat = 0;
    napi_get_value_int32(env, args[6], &colorFormat);

    UInt8Data result = drawCircleImage(str, (float)fontSize, fontColor, fontBgColor, bgColor,
                                       (float)textHeight, colorFormat);
    free(str);
    return CreateArrayBufferFromUInt8Data(env, result);
}

static napi_value JsDrawRectImage(napi_env env, napi_callback_info info)
{
    size_t argc = 10;
    napi_value args[10];
    napi_get_cb_info(env, info, &argc, args, NULL, NULL);
    if (argc < 10) {
        napi_value undefined;
        napi_get_undefined(env, &undefined);
        return undefined;
    }
    char *str = GetStringArg(env, args[0]);
    double fontSize = 0;
    napi_get_value_double(env, args[1], &fontSize);
    uint32_t fontColor = 0;
    napi_get_value_uint32(env, args[2], &fontColor);
    uint32_t fontBgColor = 0;
    napi_get_value_uint32(env, args[3], &fontBgColor);
    uint32_t bgColor = 0;
    napi_get_value_uint32(env, args[4], &bgColor);
    double textHeight = 0;
    napi_get_value_double(env, args[5], &textHeight);
    int32_t colorFormat = 0;
    napi_get_value_int32(env, args[6], &colorFormat);
    double padding = 0;
    napi_get_value_double(env, args[7], &padding);
    double radius = 0;
    napi_get_value_double(env, args[8], &radius);
    bool isFakeBold = false;
    napi_get_value_bool(env, args[9], &isFakeBold);

    UInt8Data result = drawRectImage(str, (float)fontSize, fontColor, fontBgColor, bgColor,
                                     (float)textHeight, colorFormat, (float)padding, (float)radius, isFakeBold);
    free(str);
    return CreateArrayBufferFromUInt8Data(env, result);
}

static napi_value JsDrawRectToolImage(napi_env env, napi_callback_info info)
{
    size_t argc = 15;
    napi_value args[15];
    napi_get_cb_info(env, info, &argc, args, NULL, NULL);
    if (argc < 15) {
        napi_value undefined;
        napi_get_undefined(env, &undefined);
        return undefined;
    }
    char *str1 = GetStringArg(env, args[0]);
    char *str2 = GetStringArg(env, args[1]);
    double fontSize = 0;
    napi_get_value_double(env, args[2], &fontSize);
    uint32_t fontColor = 0;
    napi_get_value_uint32(env, args[3], &fontColor);
    uint32_t fontBgColor = 0;
    napi_get_value_uint32(env, args[4], &fontBgColor);
    uint32_t bgColor = 0;
    napi_get_value_uint32(env, args[5], &bgColor);
    uint32_t borderColor = 0;
    napi_get_value_uint32(env, args[6], &borderColor);
    double borderWidth = 0;
    napi_get_value_double(env, args[7], &borderWidth);
    uint32_t divLineColor = 0;
    napi_get_value_uint32(env, args[8], &divLineColor);
    double divLineWidth = 0;
    napi_get_value_double(env, args[9], &divLineWidth);
    double textHeight = 0;
    napi_get_value_double(env, args[10], &textHeight);
    int32_t colorFormat = 0;
    napi_get_value_int32(env, args[11], &colorFormat);
    double padding = 0;
    napi_get_value_double(env, args[12], &padding);
    double lineLeftPadding = 0;
    napi_get_value_double(env, args[13], &lineLeftPadding);
    double lineRightPadding = 0;
    napi_get_value_double(env, args[14], &lineRightPadding);

    UInt8Data result = drawRectToolImage(str1, str2, (float)fontSize, fontColor, fontBgColor, bgColor,
                                         borderColor, (float)borderWidth, divLineColor, (float)divLineWidth,
                                         (float)textHeight, colorFormat, (float)padding,
                                         (float)lineLeftPadding, (float)lineRightPadding);
    free(str1);
    free(str2);
    return CreateArrayBufferFromUInt8Data(env, result);
}

static napi_value Init(napi_env env, napi_value exports)
{
    napi_property_descriptor desc[] = {
        {"drawCircleImage", NULL, JsDrawCircleImage, NULL, NULL, NULL, napi_default, NULL},
        {"drawRectImage", NULL, JsDrawRectImage, NULL, NULL, NULL, napi_default, NULL},
        {"drawRectToolImage", NULL, JsDrawRectToolImage, NULL, NULL, NULL, napi_default, NULL},
    };
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}

static napi_module textToImgModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = NULL,
    .nm_register_func = Init,
    .nm_modname = "text_to_img",
    .nm_priv = NULL,
    .reserved = {0},
};

extern "C" __attribute__((constructor)) void RegisterTextToImgModule(void)
{
    napi_module_register(&textToImgModule);
}
