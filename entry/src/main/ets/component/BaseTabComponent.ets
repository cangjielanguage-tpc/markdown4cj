import { TypeEnum } from "../model/TypeEnum"
import { colorSwitch, colorSwitch1, numberToColorString, styleToString } from "../utils/BaseUtils"

/**
 * 自定义选项卡
 */
@Component
export struct BaseTabComponent {
  titleStr: string = ""
  typeEnum: TypeEnum = TypeEnum.IS_STRING
  allListData: Array<string | number | boolean | Resource | undefined> = Array<string | number | boolean | Resource | undefined>()
  @Link
  allData: string | number | boolean | Resource | undefined

  build() {
    Column() {
      Row() {
        Text(this.titleStr)
          .fontSize(16)
          .textAlign(TextAlign.Start)
        if (this.typeEnum == TypeEnum.IS_STRING) {
          if (this.allData !== undefined) {
            Text(this.allData as string)
              .fontSize(16)
              .textAlign(TextAlign.Start)
          } else {
            Text("undefined")
              .fontSize(16)
              .textAlign(TextAlign.Start)
          }
        } else if (this.typeEnum == TypeEnum.IS_NUMBER) {
          if (this.allData !== undefined) {
            Text(`${(this.allData as number)}`)
              .fontSize(16)
              .textAlign(TextAlign.Start)
          } else {
            Text("undefined")
              .fontSize(16)
              .textAlign(TextAlign.Start)
          }
        } else if (this.typeEnum == TypeEnum.IS_BOOLEAN) {
          if (this.allData !== undefined) {
            Text(`${this.allData as boolean}`)
              .fontSize(16)
              .textAlign(TextAlign.Start)
          } else {
            Text("undefined")
              .fontSize(16)
              .textAlign(TextAlign.Start)
          }
        } else if (this.typeEnum == TypeEnum.IS_COLOR) {
          if (this.allData !== undefined) {
            Text(numberToColorString(this.allData as number))
              .backgroundColor(this.allData as number)
              .fontColor(colorSwitch(this.allData as number))
              .fontSize(16)
              .padding(2)
              .textAlign(TextAlign.Start)
              .border({ width: 1, color: Color.Black })
          } else {
            Text("undefined")
              .fontSize(16)
              .textAlign(TextAlign.Start)
          }
        } else if (this.typeEnum == TypeEnum.IS_RESOURCE) {
          if (this.allData !== undefined) {
            Text(`${(this.allData as Resource).id}`)
              .fontSize(16)
              .textAlign(TextAlign.Start)
          } else {
            Text("undefined")
              .fontSize(16)
              .textAlign(TextAlign.Start)
          }
        } else if (this.typeEnum == TypeEnum.IS_DECORATION_STYLE) {
          if (this.allData !== undefined) {
            Text(styleToString(this.allData as number))
              .fontSize(16)
              .textAlign(TextAlign.Start)
          } else {
            Text("undefined")
              .fontSize(16)
              .textAlign(TextAlign.Start)
          }
        }
      }
      .width("100%")
      .backgroundColor(0XFFE0E0E0)
      .padding({
        top: 5,
        bottom: 5,
        left: 2,
        right: 2
      })
      .margin(2)

      Flex({ alignItems: ItemAlign.Center, wrap: FlexWrap.Wrap }) {
        if (this.typeEnum == TypeEnum.IS_STRING) {
          ForEach(this.allListData, (item: string | number | boolean | Resource | undefined, _: number) => {
            if (item !== undefined) {
              Button(`${item}`)
                .type(ButtonType.Capsule)
                .stateEffect(true)
                .height(25)
                .margin(2)
                .backgroundColor(0xFF317AFF)
                .fontSize(14)
                .onClick(() => {
                  this.allData = item as string
                })
            } else {
              Button("undefined")
                .type(ButtonType.Capsule)
                .stateEffect(true)
                .height(25)
                .margin(2)
                .backgroundColor(0xFF317AFF)
                .fontSize(14)
                .onClick(() => {
                  this.allData = undefined
                })
            }
          })
        } else if (this.typeEnum == TypeEnum.IS_NUMBER) {
          ForEach(this.allListData, (item: string | number | boolean | Resource | undefined, _: number) => {
            if (item !== undefined) {
              Button(`${item}`)
                .type(ButtonType.Capsule)
                .stateEffect(true)
                .height(25)
                .margin(2)
                .backgroundColor(0xFF317AFF)
                .fontSize(14)
                .onClick(() => {
                  this.allData = item as number
                })
            } else {
              Button("undefined")
                .type(ButtonType.Capsule)
                .stateEffect(true)
                .height(25)
                .margin(2)
                .backgroundColor(0xFF317AFF)
                .fontSize(14)
                .onClick(() => {
                  this.allData = undefined
                })
            }
          })
        } else if (this.typeEnum == TypeEnum.IS_BOOLEAN) {
          ForEach(this.allListData, (item: string | number | boolean | Resource | undefined, _: number) => {
            if (item !== undefined) {
              Button(`${item}`)
                .type(ButtonType.Capsule)
                .stateEffect(true)
                .height(25)
                .margin(2)
                .backgroundColor(0xFF317AFF)
                .fontSize(14)
                .onClick(() => {
                  this.allData = item as boolean
                })
            } else {
              Button("undefined")
                .type(ButtonType.Capsule)
                .stateEffect(true)
                .height(25)
                .margin(2)
                .backgroundColor(0xFF317AFF)
                .fontSize(14)
                .onClick(() => {
                  this.allData = undefined
                })
            }
          })
        } else if (this.typeEnum == TypeEnum.IS_COLOR) {
          ForEach(this.allListData, (item: string | number | boolean | Resource | undefined, _: number) => {
            if (item !== undefined) {
              Button(numberToColorString(item as number))
                .type(ButtonType.Capsule)
                .fontColor(colorSwitch1(item as number))
                .stateEffect(true)
                .height(25)
                .margin(2)
                .backgroundColor(item as number)
                .fontSize(14)
                .onClick(() => {
                  this.allData = item as number
                })
            } else {
              Button("undefined")
                .type(ButtonType.Capsule)
                .stateEffect(true)
                .height(25)
                .margin(2)
                .backgroundColor(0xFF317AFF)
                .fontSize(14)
                .onClick(() => {
                  this.allData = undefined
                })
            }
          })
        } else if (this.typeEnum == TypeEnum.IS_RESOURCE) {
          ForEach(this.allListData, (item: string | number | boolean | Resource | undefined, _: number) => {
            if (item !== undefined) {
              Button(`${(item as Resource).id}`)
                .type(ButtonType.Capsule)
                .stateEffect(true)
                .height(25)
                .margin(2)
                .backgroundColor(0xFF317AFF)
                .fontSize(14)
                .onClick(() => {
                  this.allData = item as Resource
                })
            } else {
              Button("undefined")
                .type(ButtonType.Capsule)
                .stateEffect(true)
                .height(25)
                .margin(2)
                .backgroundColor(0xFF317AFF)
                .fontSize(14)
                .onClick(() => {
                  this.allData = undefined
                })
            }

          })
        } else if (this.typeEnum == TypeEnum.IS_DECORATION_STYLE) {
          ForEach(this.allListData, (item: string | number | boolean, _: number) => {
            Button(`${styleToString(item as number)}`)
              .type(ButtonType.Capsule)
              .stateEffect(true)
              .height(25)
              .margin(2)
              .backgroundColor(0xFF317AFF)
              .fontSize(14)
              .onClick(() => {
                this.allData = item as string
              })
          })
        }
      }
    }
  }
}