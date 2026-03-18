/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { LatexMathColorFormat } from "@cangjie-tpc/markdown_hybrid";
import { util } from "@kit.ArkTS";

/**
 * uint8Array转换成string
 */
export function uint8ArrayToString(array: Uint8Array) {
  let textDecoderOptions: util.TextDecoderOptions = {
    fatal: false,
    ignoreBOM: true
  }
  let decodeToStringOptions: util.DecodeToStringOptions = {
    stream: false
  }
  let textDecoder = util.TextDecoder.create('utf-8', textDecoderOptions);
  let retStr = textDecoder.decodeToString(array, decodeToStringOptions);
  return retStr;
}

/**
 * 下划线样式转文本
 */
export function styleToString(style: TextDecorationStyle): string {
  switch (style) {
    case TextDecorationStyle.SOLID:
      return "单实线"
    case TextDecorationStyle.DOUBLE:
      return "双实线"
    case TextDecorationStyle.DOTTED:
      return "点线"
    case TextDecorationStyle.DASHED:
      return "虚线"
    case TextDecorationStyle.WAVY:
      return "波浪线"
  }
}

/**
 * 颜色列表转换文本
 */
export function numberArrayToColorString(color: Array<number>): string {
  let returnString = ""
  for (let index = 0; index < color.length; index++) {
    returnString = returnString + numberToColorString(color[index]) + " ";
  }
  return returnString
}

/**
 * 颜色转换文本
 */
export function numberToColorString(color: number|undefined): string {
  switch (color) {
    case 0xFF000000:
      return "黑"
    case 0xFFFFFFFF:
      return "白"
    case 0xFFFF0000:
      return "红"
    case 0xFF00FF00:
      return "绿"
    case 0xFF0000FF:
      return "蓝"
    case 0xFFE0E0E0:
      return "灰"
    case 0xE6000000:
      return "0xE6000000"
    case 0xFFF5F5F5:
      return "0xFFF5F5F5"
    case 0x1A000000:
      return "0x1A000000"
    case 0x33000000:
      return "0x33000000"
    case 0x80000000:
      return "0x80000000"
    case 0xFF191919:
      return "0xFF191919"
    case 0x00FFFFFF:
      return "0x00FFFFFF"
    case 0xFF00F5FF:
      return "绿松石"
    case 0xFF6A5ACD:
      return "板岩蓝"
    case 0xFF32CD32:
      return "酸橙绿"
    case 0xFFFFD700:
      return "金"
    case 0xFFFA8072:
      return "肉粉"
    case 0xFFEE82EE:
      return "紫罗兰"
    case 0xFF7EC0EE:
      return "天空蓝"
    case 0xFF8B0000:
      return "深红"
    case 0x00000000:
      return "透明色"
    case undefined:
      return "undefined"
  }
  return ""
}

/**
 * 文本转换布尔值
 */
export function stringToBoolean(isFull: string): boolean {
  switch (isFull) {
    case "全量加载":
      return true
    case "增量加载":
      return false
  }
  return true
}

/**
 * 布尔值转换文本
 */
export function booleanToString(isFull: boolean): string {
  switch (isFull) {
    case true:
      return "全量加载"
    case false:
      return "增量加载"
  }
}

/**
 * 对象转换成json
 */
export function objectToJson(obj: object): string {
  try {
    let json = JSON.stringify(obj)
    return json
  } catch (e) {
    return ""
  }
}

/**
 * 对象转换成json
 */
export function enumToString(e: LatexMathColorFormat): string {
  switch (e) {
    case LatexMathColorFormat.COLOR_FORMAT_RGB_565:
      return "COLOR_FORMAT_RGB_565"
    case LatexMathColorFormat.COLOR_FORMAT_BGRA_8888:
      return "COLOR_FORMAT_BGRA_8888"
  }
}