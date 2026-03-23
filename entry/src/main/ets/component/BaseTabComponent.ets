import { TypeEnum } from "../model/TypeEnum"
import { colorSwitch, colorSwitch1, numberToColorString } from "../utils/BaseUtils"

/**
 * 自定义选项卡
 */
@Component
export struct BaseTabComponent {
  titleStr: string = ""
  typeEnum: TypeEnum = TypeEnum.IS_STRING
  allListData: Array<string | number | boolean> = Array<string | number | boolean>()
  @Link
  allData: string | number | boolean

  build() {
    Column() {
      Row() {
        Text(this.titleStr)
          .fontSize(16)
          .textAlign(TextAlign.Start)
        if (this.typeEnum == TypeEnum.IS_STRING) {
          Text(this.allData as string)
            .fontSize(16)
            .textAlign(TextAlign.Start)
        } else if (this.typeEnum == TypeEnum.IS_NUMBER) {
          Text(`${this.allData as number}`)
            .fontSize(16)
            .textAlign(TextAlign.Start)
        } else if (this.typeEnum == TypeEnum.IS_BOOLEAN) {
          Text(`${this.allData as boolean}`)
            .fontSize(16)
            .textAlign(TextAlign.Start)
        } else if (this.typeEnum == TypeEnum.IS_COLOR) {
          Text(numberToColorString(this.allData as number))
            .backgroundColor(this.allData as number)
            .fontColor(colorSwitch(this.allData as number))
            .fontSize(16)
            .padding(2)
            .textAlign(TextAlign.Start)
            .border({ width: 1, color: Color.Black })
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
          ForEach(this.allListData, (item: string | number | boolean, _: number) => {
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
          })
        } else if (this.typeEnum == TypeEnum.IS_NUMBER) {
          ForEach(this.allListData, (item: string | number | boolean, _: number) => {
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
          })
        } else if (this.typeEnum == TypeEnum.IS_BOOLEAN) {
          ForEach(this.allListData, (item: string | number | boolean, _: number) => {
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
          })
        } else if (this.typeEnum == TypeEnum.IS_COLOR) {
          ForEach(this.allListData, (item: string | number | boolean, _: number) => {
            Button(numberToColorString(item as number))
              .type(ButtonType.Capsule)
              .fontColor(colorSwitch1(item as number))
              .stateEffect(true)
              .height(25)
              .margin(2)
              .backgroundColor(item as number)
              .fontSize(14)
              .onClick(() => {
                this.allData = item
              })
          })
        }
      }
    }
  }
}