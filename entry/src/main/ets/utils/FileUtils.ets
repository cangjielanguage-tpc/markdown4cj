/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { baseManager } from '../entryability/EntryAbility'
import { uint8ArrayToString } from './BaseUtils'

/**
 * 读取路径下文件夹
 */
export function getFileListStr(str: string): Array<string> {
  try {
    return baseManager!.getRawFileListSync(str)
  } catch (e) {
    return []
  }
}

/**
 * 读取路径下文件内容
 */
export function getFileContextStr(str: string): string {
  try {
    return uint8ArrayToString(baseManager!.getRawFileContentSync(str))
  } catch (e) {
    return ""
  }
}

/**
 * 读取路径下文件内容
 */
export function getFileContextArr(str: string): ArrayBuffer | undefined {
  try {
    return baseManager!.getRawFileContentSync(str).buffer as ArrayBuffer
  } catch (e) {
    return undefined
  }
}