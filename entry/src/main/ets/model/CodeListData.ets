import { CodeBlockData } from "./CodeBlockData"

export class CodeListData extends CodeBlockData {
  _codeBlockListTitleTextSize: number = 13.0 // 组合代码块未选中标题字体大小
  _codeBlockListTitleSelectTextSize: number = 13.0 // 组合代码块选中标题字体大小
  _codeBlockListTitleSelectTextColor: ResourceColor | undefined = undefined // 组合代码块选中标题文本颜色
  _codeBlockListTitleUnselectTextColor: ResourceColor | undefined = undefined // 组合代码块未选中标题文本颜色
  _codeBlockListTitleSelectBackgroundColor: ResourceColor | undefined = undefined // 组合代码块选中标题背景颜色
  _codeBlockListTitleUnselectBackgroundColor: ResourceColor | undefined = undefined // 组合代码块未选中标题背景颜色

  constructor() {
    super()
  }
}