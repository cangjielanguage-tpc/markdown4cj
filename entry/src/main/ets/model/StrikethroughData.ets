import { MarkdownTextDecorationStyle } from "@cangjie-tpc/markdown_hybrid"
import { BaseMDData } from "./BaseMDData"

export class StrikethroughData extends BaseMDData {
  _strikethroughColor: number | undefined = undefined
  _strikethroughStyle: MarkdownTextDecorationStyle = MarkdownTextDecorationStyle.SOLID

  public set strikethroughColor(value: number | undefined) {
    this._strikethroughColor = value
  }

  public set strikethroughStyle(value: MarkdownTextDecorationStyle) {
    this._strikethroughStyle = value
  }
  constructor() {
    super()
  }
}