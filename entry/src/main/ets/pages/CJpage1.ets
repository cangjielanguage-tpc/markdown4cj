import { CJMarkdown, MarkdownConfiguration, MarkdownPlugin, MarkdownTheme } from '@cangjie-tpc/markdown_hybrid'
import { util } from '@kit.ArkTS';
import { titleComponent } from './BaseComponent';

class MyDataSource implements IDataSource {
  registerDataChangeListener(listener: DataChangeListener): void {
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
  }

  public dataArray: TextData[] = []

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): TextData {
    return this.dataArray[index];
  }

  public pushData(str: string): void {
    const data = new TextData();
    data.text = str
    this.dataArray.push(data);
  }
}

class TextData{
  text:string = ""
}
@Entry
@Component
struct CJpage {
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  private data: MyDataSource = new MyDataSource();
  prefix:string ="哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈。\n"
  aboutToAppear(): void {
      let fileData = getContext().resourceManager.getRawFileContentSync('big-markdown.txt')
      let decoder = new util.TextDecoder('utf-8');
      let output = decoder.decode(fileData);
      this.data.pushData(output + "1")
      this.data.pushData(this.prefix+"test1")
      this.data.pushData(this.prefix+"test2")
    //   this.data.pushData(this.prefix+"test3")
    //   this.data.pushData(this.prefix+"test4")
    //   this.data.pushData(this.prefix+"test5")
    // this.data.pushData("哈哈")
    // this.data.pushData(this.prefix+"test6")
    //   this.data.pushData(this.prefix+"test7")
    //   this.data.pushData(this.prefix+"test8")
    //   this.data.pushData(this.prefix+"test9")
    //   this.data.pushData(this.prefix+"test10")
    //   this.data.pushData(this.prefix+"test11")
    //   this.data.pushData(this.prefix+"test12")
    //   this.data.pushData(this.prefix+"test13")
    //   this.data.pushData(this.prefix+"test14")
    //   this.data.pushData(this.prefix+"test15")
    //   this.data.pushData(this.prefix+"test16")
    //   this.data.pushData(this.prefix+"test17")
    //   this.data.pushData(this.prefix+"test18")
    //   this.data.pushData(this.prefix+"test19")
    //   this.data.pushData(this.prefix+"test20")
    //   this.data.pushData(this.prefix+"test21")
    //   this.data.pushData(this.prefix+"test22")
    // this.data.pushData(this.prefix+"test23")
    // this.data.pushData(this.prefix+"test24")
    // this.data.pushData(this.prefix+"test25")
    // this.data.pushData(this.prefix+"test26")
    // this.data.pushData(this.prefix+"test27")
    // this.data.pushData(this.prefix+"test28")
    // this.data.pushData(this.prefix+"test29")


    // fileData = getContext().resourceManager.getRawFileContentSync('001_图片.md')
    // decoder = new util.TextDecoder('utf-8');
    // output = decoder.decode(fileData);
    // this.data.pushData(output + "2")
    // this.data.pushData("test3")
    // this.data.pushData("test4")
    // fileData = getContext().resourceManager.getRawFileContentSync('001_单独代码块.md')
    // decoder = new util.TextDecoder('utf-8');
    // output = decoder.decode(fileData);
    // this.data.pushData(output + "3")
    // this.data.pushData("test5")
    // this.data.pushData("test6")
    // fileData = getContext().resourceManager.getRawFileContentSync('001_综合.md')
    // decoder = new util.TextDecoder('utf-8');
    // output = decoder.decode(fileData);
    // this.data.pushData(output + "4")
    // this.data.pushData("test7")
    // this.data.pushData("test8")
    // fileData = getContext().resourceManager.getRawFileContentSync('002_单独代码块.md')
    // decoder = new util.TextDecoder('utf-8');
    // output = decoder.decode(fileData);
    // this.data.pushData(output + "5")
    // this.data.pushData("test9")
    // this.data.pushData("test11")
    // fileData = getContext().resourceManager.getRawFileContentSync('003_单独代码块.md')
    // decoder = new util.TextDecoder('utf-8');
    // output = decoder.decode(fileData);
    // this.data.pushData(output + "6")
    // this.data.pushData("test22")
    // this.data.pushData("test33")
    // fileData = getContext().resourceManager.getRawFileContentSync('004_单独代码块.md')
    // decoder = new util.TextDecoder('utf-8');
    // output = decoder.decode(fileData);
    // this.data.pushData(output + "7")
    // this.data.pushData("test44")
    // this.data.pushData("test55")
    // fileData = getContext().resourceManager.getRawFileContentSync('markdown_text.txt')
    // decoder = new util.TextDecoder('utf-8');
    // output = decoder.decode(fileData);
    // this.data.pushData(output + "8")
    // this.data.pushData("test66")
    // this.data.pushData("test77")
  }

  @State textData: TextData = new TextData();
   index: number = 0

  build() {
    Column(){
      titleComponent(
        "测试页面",
        0xFF317AFF,
        true,
        this.safeTop
      )
      // List() {
      //   LazyForEach(this.data, (item: TextData) => {
      //     ListItem() {
      //       MyComponent({data: item})
      //     }
      //   })
      // }
      // .width("100%")
      // .cachedCount(2)
      // .divider({strokeWidth: 10})
      Text("点击切换文本")
        .alignSelf(ItemAlign.Center)
        .fontSize(40)
        .onClick(()=>{
          // this.textData.text = ""
          // setTimeout(()=>{
          //   this.textData.text = this.data.getData(this.index)
          // },50)
          this.textData = this.data.getData(this.index)
          this.index++
          if (this.index >= this.data.totalCount()) {
            this.index = 0
          }
        })
      Column() {
        // CJMarkdown({mdStr: this.textData.text,
        //   theme: {copyIcon: $r('app.media.startIcon'),
        //     isFull:false}})

        CJMarkdown({mdStr: this.textData.text,
          cfg: setMarkdownConfig(),
          plugin: setPlugin()})
      }.width("50%")
    }.width("100%")
    .alignItems(HorizontalAlign.Center)

  }

  // @Builder
  // itemView(text: string) {
  //   Column() {
  //     CJMarkdown({mdStr: text,
  //       theme: {copyIcon: $r('app.media.startIcon'),
  //         isFull:false}})
  //   }.width("50%")
  // }
}

function setMarkdownConfig(): MarkdownConfiguration {
  let config = new MarkdownConfiguration()
  let theme = new MarkdownTheme()
  theme.setCodeCopyIcon($r('app.media.startIcon'))
  config.setMarkdownTheme(theme)
  return config
}

function setPlugin(): MarkdownPlugin {
  let plugin: MarkdownPlugin = new MarkdownPlugin()
  plugin.setIsHtmlPlugin(true) // HTML插件
  plugin.setIsTaskListPlugin(true) // 任务列表插件
  plugin.setIsStrikethroughPlugin(true) // 删除线插件
  plugin.setIsTablePlugin(true) // 表格插件
  plugin.setIsLatexMathPlugin(true) // 数学公式插件
  plugin.setIsFootnotePlugin(true) // 脚注插件
  plugin.setIsImageCollectPlugin(true) // 图片视频列表URL集合插件
  plugin.setIsLinkifyPlugin(true) // 自动连接插件
  return plugin
}

// @Reusable
// @Component
// struct MyComponent {
//   @Prop data: TextData
//   aboutToAppear(): void {
//     console.log("aboutToCJAppear HM " + this.data.text)
//   }
//   aboutToReuse(): void {
//     console.log("aboutToCJReuse HM " + this.data.text)
//   }
//   build() {
//     Column() { CJMarkdown({mdStr: this.data.text,
//       isFull:false,
//       cfg: setMarkdownConfig(),
//       plugin: setPlugin()})
//       // CJMarkdown({mdStr: this.data.text,
//       //   theme: {copyIcon: $r('app.media.startIcon'),
//       //     isFull:false}})
//     }.width("50%")
//   }
// }