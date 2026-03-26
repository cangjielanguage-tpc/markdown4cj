import { BaseMDData } from "./BaseMDData"

export class EmojiData extends BaseMDData {
  _isEmojiLight: boolean = true

  public set isEmojiLight(value: boolean) {
    this._isEmojiLight = value
  }

  constructor() {
    super()
  }
}