import { MarkdownTextDecorationStyle } from "@cangjie-tpc/markdown_hybrid"
import { BaseMDData } from "./BaseMDData"

export class HTMLData extends BaseMDData {
  _underlineColor: number | undefined = undefined
  _underlineStyle: MarkdownTextDecorationStyle = MarkdownTextDecorationStyle.SOLID

  public set underlineColor(value: number | undefined) {
    this._underlineColor = value
  }

  public set underlineStyle(value: MarkdownTextDecorationStyle) {
    this._underlineStyle = value
  }

  constructor() {
    super()
  }
}