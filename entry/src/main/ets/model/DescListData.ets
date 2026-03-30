import { BaseMDData } from "./BaseMDData"

export class DescListData extends BaseMDData {
  _descListTermAndDefMargins: number = 8
  _descListDefIndentation: number = 8
  _descListDefMargins: number = 8

  public set descListTermAndDefMargins(value: number) {
    this._descListTermAndDefMargins = value
  }

  public set descListDefIndentation(value: number) {
    this._descListDefIndentation = value
  }

  public set descListDefMargins(value: number) {
    this._descListDefMargins = value
  }

  constructor() {
    super();
  }
}