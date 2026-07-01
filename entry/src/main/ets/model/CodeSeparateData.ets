import { CodeBlockData } from "./CodeBlockData"

export class CodeSeparateData extends CodeBlockData {
  _codeBlockIsSeparate: boolean = false // 是否单独代码块显示
  _codeBlockSeparateWidth: Length = 50.0 // 单独代码块行号宽度
  _codeBlockSeparateIsBottom: boolean = false // 单独代码块是否居底显示

  public set codeBlockIsSeparate(value: boolean) {
    this._codeBlockIsSeparate = value
  }

  public set codeBlockSeparateWidth(value: Length) {
    this._codeBlockSeparateWidth = value
  }

  public set codeBlockSeparateIsBottom(value: boolean) {
    this._codeBlockSeparateIsBottom = value
  }

  constructor() {
    super()
  }
}