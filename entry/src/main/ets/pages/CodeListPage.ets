/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { titleComponent } from '../component/BaseComponent'
import { getFileListStr } from '../utils/FileUtils'
import { router } from '@kit.ArkUI'
import { BaseTabComponent } from '../component/BaseTabComponent'
import { TypeEnum } from '../model/TypeEnum'
import {
  booleanListGeneralData,
  colorListGeneralData,
  marginListGeneralData,
  textNumberListGeneralData,
  textSizeListGeneralData,
  timeListGeneralData
} from '../model/GeneralData'
import { CodeListData } from '../model/CodeListData'

@Entry
@Component
struct CodeListPage {
  // ---------------- 通用
  /**
   * 滑动控制器
   */
  scroller: Scroller = new Scroller()
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop')
  safeTop: number = 0
  /**
   * rawfile路径
   */
  rawFilePath: string = "012_组合代码块"
  /**
   * rawfile文件夹列表
   */
  @State
  folderList: Array<string> = new Array<string>()
  /**
   * 是否全量加载Markdown文本列表
   */
  isFullList: Array<boolean> = booleanListGeneralData
  /**
   * 是否全量加载Markdown文本
   */
  @State
  isFull: boolean = true
  /**
   * 是否增量解析Markdown文本列表
   */
  incrementalAnalysisList: Array<boolean> = booleanListGeneralData
  /**
   * 是否增量解析Markdown文本
   */
  @State
  incrementalAnalysis: boolean = false
  /**
   * 增量加载每次间隔时间列表
   */
  timeList: Array<number> = timeListGeneralData
  /**
   * 增量加载每次间隔时间
   */
  @State
  time: number = 50
  /**
   * 增量每次增量文本数量列表
   */
  textNumberList: Array<number> = textNumberListGeneralData
  /**
   * 增量每次增量文本数量
   */
  @State
  textNumber: number = 10
  /**
   * 是否同步解析Markdown文本列表
   */
  isMarkdownParserSyncList: Array<boolean> = booleanListGeneralData
  /**
   * 是否同步解析Markdown文本
   */
  @State
  isMarkdownParserSync: boolean = false
  /**
   * 是否打开长按复制粘贴效果列表
   */
  isOnCopyList: Array<boolean> = booleanListGeneralData
  /**
   * 是否打开长按复制粘贴效果
   */
  @State
  isOnCopy: boolean = false
  /**
   * Markdown文本第一个模块上边距列表
   */
  blockFirstTopMarginList: Array<number> = marginListGeneralData
  /**
   * Markdown文本第一个模块上边距
   */
  @State
  blockFirstTopMargin: number = 8
  /**
   * Markdown文本最后一个模块下边距列表
   */
  blockLastBottomMarginList: Array<number> = marginListGeneralData
  /**
   * Markdown文本最后一个模块下边距
   */
  @State
  blockLastBottomMargin: number = 8
  /**
   * Markdown文本模块间上下间距列表
   */
  blockTopAndBottomMarginsList: Array<number> = marginListGeneralData
  /**
   * Markdown文本模块间上下间距
   */
  @State
  blockTopAndBottomMargins: number = 8
  /**
   * 是否允许markdown控件自身响应滑动列表
   */
  openGestureSwipeList: Array<boolean> = booleanListGeneralData
  /**
   * 是否允许markdown控件自身响应滑动
   */
  @State
  openGestureSwipe: boolean = false
  /**
   * 是否开启响应滑动测试列表
   */
  openGestureSwipeTestList: Array<boolean> = booleanListGeneralData
  /**
   * 是否开启响应滑动测试
   */
  @State
  openGestureSwipeTest: boolean = false

  // ---------------- 专有
  /**
   * 组合代码未选中标题字体大小列表
   */
  codeListTitleTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 组合代码未选中标题字体大小
   */
  @State
  codeListTitleTextSize: number = 13
  /**
   * 组合代码选中标题字体大小列表
   */
  codeListTitleSelectTextSizeList: Array<number> = textSizeListGeneralData
  /**
   * 组合代码选中标题字体大小
   */
  @State
  codeListTitleSelectTextSize: number = 13
  /**
   * 组合代码选中标题文本颜色列表
   */
  codeListTitleSelectTextColorList: Array<number> = colorListGeneralData
  /**
   * 组合代码选中标题文本颜色
   */
  @State
  codeListTitleSelectTextColor: number = 0xFFFF0000
  /**
   * 组合代码未选中标题文本颜色列表
   */
  codeListTitleUnSelectTextColorList: Array<number> = colorListGeneralData
  /**
   * 组合代码未选中标题文本颜色
   */
  @State
  codeListTitleUnSelectTextColor: number = 0xFF000000
  /**
   * 组合代码选中标题背景颜色列表
   */
  codeListTitleSelectBackGroupColorList: Array<number> = colorListGeneralData
  /**
   * 组合代码选中标题背景颜色
   */
  @State
  codeListTitleSelectBackGroupColor: number = 0xFF191919
  /**
   * 组合代码未选中标题背景颜色列表
   */
  codeListTitleUnSelectBackGroupColorList: Array<number> = colorListGeneralData
  /**
   * 组合代码未选中标题背景颜色
   */
  @State
  codeListTitleUnSelectBackGroupColor: number = 0x00FFFFFF
  /**
   * 配置数据内容
   */
  @State
  codeListData: CodeListData = new CodeListData()

  aboutToAppear(): void {
    this.folderList = getFileListStr(`${this.rawFilePath}/`)
  }

  build() {
    Column() {
      titleComponent(
        "组合代码块配置页面",
        0xFF317AFF,
        true,
        this.safeTop
      )
      Scroll() {
        Column() {
          // ------------ 通用
          BaseTabComponent({
            titleStr: "是否全量加载Markdown文本 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isFullList,
            allData: this.isFull
          })
          BaseTabComponent({
            titleStr: "是否增量解析Markdown文本 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.incrementalAnalysisList,
            allData: this.incrementalAnalysis
          })
          BaseTabComponent({
            titleStr: "增量加载每次间隔时间 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.timeList,
            allData: this.time
          })
          BaseTabComponent({
            titleStr: "增量每次增量文本数量 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.textNumberList,
            allData: this.textNumber
          })
          BaseTabComponent({
            titleStr: "是否同步解析Markdown文本 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isMarkdownParserSyncList,
            allData: this.isMarkdownParserSync
          })
          BaseTabComponent({
            titleStr: "是否打开长按复制粘贴效果 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.isOnCopyList,
            allData: this.isOnCopy
          })
          BaseTabComponent({
            titleStr: "Markdown文本第一个模块上边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockFirstTopMarginList,
            allData: this.blockFirstTopMargin
          })
          BaseTabComponent({
            titleStr: "Markdown文本最后一个模块下边距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockLastBottomMarginList,
            allData: this.blockLastBottomMargin
          })
          BaseTabComponent({
            titleStr: "Markdown文本模块间上下间距 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.blockTopAndBottomMarginsList,
            allData: this.blockTopAndBottomMargins
          })
          BaseTabComponent({
            titleStr: "是否开启响应滑动测试 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.openGestureSwipeTestList,
            allData: this.openGestureSwipeTest
          })
          BaseTabComponent({
            titleStr: "是否允许markdown控件自身响应滑动 - ",
            typeEnum: TypeEnum.IS_BOOLEAN,
            allListData: this.openGestureSwipeList,
            allData: this.openGestureSwipe
          })

          // ---------------- 专有
          BaseTabComponent({
            titleStr: "组合代码未选中标题字体大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeListTitleTextSizeList,
            allData: this.codeListTitleTextSize
          })
          BaseTabComponent({
            titleStr: "组合代码选中标题字体大小 - ",
            typeEnum: TypeEnum.IS_NUMBER,
            allListData: this.codeListTitleSelectTextSizeList,
            allData: this.codeListTitleSelectTextSize
          })
          BaseTabComponent({
            titleStr: "组合代码选中标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeListTitleSelectTextColorList,
            allData: this.codeListTitleSelectTextColor
          })
          BaseTabComponent({
            titleStr: "组合代码未选中标题文本颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeListTitleUnSelectTextColorList,
            allData: this.codeListTitleUnSelectTextColor
          })
          BaseTabComponent({
            titleStr: "组合代码选中标题背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeListTitleSelectBackGroupColorList,
            allData: this.codeListTitleSelectBackGroupColor
          })
          BaseTabComponent({
            titleStr: "组合代码未选中标题背景颜色 - ",
            typeEnum: TypeEnum.IS_COLOR,
            allListData: this.codeListTitleUnSelectBackGroupColorList,
            allData: this.codeListTitleUnSelectBackGroupColor
          })

          // 列表显示
          List() {
            ForEach(this.folderList, (item: string, index: number) => {
              ListItem() {
                Button(`${index + 1}、${item}`)
                  .height(40)
                  .width('80%')
                  .type(ButtonType.Capsule)
                  .fontColor(0xFFFFFFFF)
                  .backgroundColor(0xFF317AFF)
                  .margin({ top: 5, bottom: 5 })
                  .align(Alignment.Center)
                  .fontSize(16)
                  .onClick(() => {
                    // ---------- 通用
                    this.codeListData.isFull = this.isFull
                    this.codeListData.incrementalAnalysis = this.incrementalAnalysis
                    this.codeListData.time = this.time
                    this.codeListData.textNumber = this.textNumber
                    this.codeListData.isMarkdownParserSync = this.isMarkdownParserSync
                    this.codeListData.isOnCopy = this.isOnCopy
                    this.codeListData.blockFirstTopMargin = this.blockFirstTopMargin
                    this.codeListData.blockLastBottomMargin = this.blockLastBottomMargin
                    this.codeListData.blockTopAndBottomMargins = this.blockTopAndBottomMargins
                    this.codeListData.openGestureSwipe = this.openGestureSwipe
                    this.codeListData.openGestureSwipeTest = this.openGestureSwipeTest
                    this.codeListData.pagePath = `${this.rawFilePath}/${item}`
                    // ---------- 专有
                    this.codeListData.codeListTitleTextSize = this.codeListTitleTextSize
                    this.codeListData.codeListTitleSelectTextSize = this.codeListTitleSelectTextSize
                    this.codeListData.codeListTitleSelectTextColor = this.codeListTitleSelectTextColor
                    this.codeListData.codeListTitleUnSelectTextColor = this.codeListTitleUnSelectTextColor
                    this.codeListData.codeListTitleSelectBackGroupColor = this.codeListTitleSelectBackGroupColor
                    this.codeListData.codeListTitleUnSelectBackGroupColor = this.codeListTitleUnSelectBackGroupColor
                    // ---------- 跳转到详情
                    router.pushUrl({ url: "pages/CodeListDetailsPage", params: this.codeListData })
                  })
              }
            })
          }
          .alignListItem(ListItemAlign.Center)
        }
        .padding({ bottom: 100 })
      }
    }
    .backgroundColor(0xFFEAEAEA)
    .height("100%")
  }
}


