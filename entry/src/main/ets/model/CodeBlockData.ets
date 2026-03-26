import { BaseMDData } from "./BaseMDData"

export class CodeBlockData extends BaseMDData {
  _isCodeFormat: boolean = false
  _codeBlockTextColor: number | undefined = undefined
  _codeBlockTypeTextColor: number | undefined = undefined
  _codeBlockTypeTextStr: string = ""
  _codeBlockTypeTextPadding: number = 0
  _codeBlockIconTextHide: boolean = true
  _codeBlockLineNumberHide: boolean = true
  _codeBlockBackgroundColor: number | undefined = undefined
  _codeMultilineMargin: number = 8
  _codeBlockTypeface: string = "HarmonyOS Sans"
  _codeBlockTextSize: number = 13
  _codeBlockLineHeight: number = 22
  _codeBlockRadius: number = 8
  _isCodeFullScreen: boolean = true
  _iconWidthAndHeight: number = 24
  _isDark: boolean = true
  _useTab: boolean = false
  _indentWidth: number = 4

  public set isCodeFormat(value: boolean) {
    this._isCodeFormat = value
  }

  public set codeBlockTextColor(value: number | undefined) {
    this._codeBlockTextColor = value
  }

  public set codeBlockTypeTextColor(value: number | undefined) {
    this._codeBlockTypeTextColor = value
  }

  public set codeBlockTypeTextStr(value: string) {
    this._codeBlockTypeTextStr = value
  }

  public set codeBlockTypeTextPadding(value: number) {
    this._codeBlockTypeTextPadding = value
  }

  public set codeBlockIconTextHide(value: boolean) {
    this._codeBlockIconTextHide = value
  }

  public set codeBlockLineNumberHide(value: boolean) {
    this._codeBlockLineNumberHide = value
  }

  public set codeBlockBackgroundColor(value: number | undefined) {
    this._codeBlockBackgroundColor = value
  }

  public set codeMultilineMargin(value: number) {
    this._codeMultilineMargin = value
  }

  public set codeBlockTypeface(value: string) {
    this._codeBlockTypeface = value
  }

  public set codeBlockTextSize(value: number) {
    this._codeBlockTextSize = value
  }

  public set codeBlockLineHeight(value: number) {
    this._codeBlockLineHeight = value
  }

  public set codeBlockRadius(value: number) {
    this._codeBlockRadius = value
  }

  public set isCodeFullScreen(value: boolean) {
    this._isCodeFullScreen = value
  }

  public set iconWidthAndHeight(value: number) {
    this._iconWidthAndHeight = value
  }

  public set isDark(value: boolean) {
    this._isDark = value
  }

  public set useTab(value: boolean) {
    this._useTab = value
  }

  public set indentWidth(value: number) {
    this._indentWidth = value
  }

  constructor() {
    super()
  }
}