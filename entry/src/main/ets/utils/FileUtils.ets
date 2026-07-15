import { baseManager } from '../entryability/EntryAbility'
import { util } from '@kit.ArkTS'

export function getFileListStr(str: string): Array<string> {
  try {
    return baseManager!.getRawFileListSync(str)
  } catch (e) {
    return []
  }
}

export function getFileContextStr(str: string): string {
  try {
    let bytes = baseManager!.getRawFileContentSync(str)
    let textDecoder = util.TextDecoder.create('utf-8', { fatal: false, ignoreBOM: true })
    return textDecoder.decodeToString(bytes)
  } catch (e) {
    return ""
  }
}
