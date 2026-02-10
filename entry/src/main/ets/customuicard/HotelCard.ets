import { AlertDialog, CustomContentDialog } from '@kit.ArkUI';

export class OrderInfo {
  public hotelName: string = "";
  public roomType: string = "";
  public checkInDate: string = "";
  public price: string = "";
  public status: string = 'pending'
  constructor(hotelName: string, roomType: string, checkInDate: string, price: string, status: string) {
    this.hotelName = hotelName;
    this.roomType = roomType;
    this.checkInDate = checkInDate;
    this.price = price;
    this.status = status;
  }
}

@Component
export struct HotelCard {
  data: string = "";
  @State orderInfo: OrderInfo = new OrderInfo("", "", "", "", '');

  aboutToAppear() {
    if (this.data && this.data !== "") {

      try {
        const data:Record<string, string> = JSON.parse(this.data);
        this.orderInfo = new OrderInfo(data.hotelName, data.roomType, data.checkInDate, data.price, data.status);
      } catch (error) {
        console.error("JSON.parse error: ", error);
      }
      
    }
  }


  dialogControllerOrderInfo: CustomDialogController= new CustomDialogController({
    builder: CustomContentDialog({
      primaryTitle: '',
      secondaryTitle: '',
      contentBuilder: () => {
        this.dialogContent();
      }
    }),
});

  build() {
    Column() {
      // 酒店基本信息行
      Row() {
        Image($r('app.media.hotel'))
          .width(40)
          .height(40)
          .margin({ right: 12 })

        Column() {
          Text(this.orderInfo.hotelName)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Text(`${this.orderInfo.roomType} | ${this.orderInfo.checkInDate}`)
            .fontSize(14)
            .fontColor('#666')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding(12)

      // 订单详情区域
      Column() {
        Divider()
        Row() {
          Text('订单金额：')
            .fontColor('#999')
          Text(`¥${this.orderInfo.price}`)
            .fontColor(Color.Red)
            .fontWeight(FontWeight.Medium)
        }
        .padding(8)

        Row() {
          Text('订单状态：')
            .fontColor('#999')
          Text(this.orderInfo.status === 'confirmed' ? '已确认' : '待确认')
            .fontColor(this.orderInfo.status === 'confirmed' ? '#07c160' : '#ff9900')

          Button("基本信息")
            .height(25)
            .width("30%")
            .type(ButtonType.Capsule)
            .margin({ top: 5, bottom: 5, left: 16 })
            .fontColor(0xFFFFFFFF)
            .backgroundColor(0xFF317AFF)
            .align(Alignment.Center)
            .fontSize(16)
            .onClick(
              () => {
                this.dialogControllerOrderInfo.open();
              }
            )
        }
        .padding(8)
      }
    }
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 12 })
    .shadow({ radius: 4, color: '#10000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  dialogContent() {
    Column() {
      Text('订单基本信息')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      Column() {
        Row() {
          Text('酒店名称：')
            .fontColor('#666')
            .fontSize(14)
          Text(this.orderInfo.hotelName)
            .fontColor(Color.Black)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .margin({ bottom: 12 })

        Row() {
          Text('房间类型：')
            .fontColor('#666')
            .fontSize(14)
          Text(this.orderInfo.roomType)
            .fontColor(Color.Black)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .margin({ bottom: 12 })

        Row() {
          Text('入住日期：')
            .fontColor('#666')
            .fontSize(14)
          Text(this.orderInfo.checkInDate)
            .fontColor(Color.Black)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .margin({ bottom: 12 })

        Row() {
          Text('订单金额：')
            .fontColor('#666')
            .fontSize(14)
          Text(`¥${this.orderInfo.price}`)
            .fontColor(Color.Red)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .margin({ bottom: 12 })

        Row() {
          Text('订单状态：')
            .fontColor('#666')
            .fontSize(14)
          Text(this.orderInfo.status === 'confirmed' ? '已确认' : '待确认')
            .fontColor(this.orderInfo.status === 'confirmed' ? '#07c160' : '#ff9900')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Button('确定')
        .width('100%')
        .height(40)
        .margin({ top: 20 })
        .type(ButtonType.Capsule)
        .backgroundColor(0xFF317AFF)
        .fontColor(Color.White)
        .onClick(() => {
          this.dialogControllerOrderInfo.close();
        })
    }
    .width(300)
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}