import { image } from "@kit.ImageKit"
import { resourceColorToNumber, LINK_ICON_TYPE_CIRCLE, LINK_ICON_TYPE_RECT, COLOR_TRANSPARENT,
  COLOR_FF4A90E2,
  COLOR_FF191919,
  COLOR_FF808080,
  COLOR_WHITE,
  COLOR_FFF5F2F0} from "../base/Constants"
import { latexStringToImage, LatexMathColorFormat } from "@cangjie-tpc/formula_hybrid"
import { CellWidthTracker } from "../model/CellWidthTracker"
import { LatexParseQueue } from "../model/LatexParseQueue"
import { NodeView } from "../model/NodeView"
import { MarkdownExposureEvent } from "../model/MarkdownExposureEvent"
import {
  computeLinkRanges,
  evaluateLinkExposure,
  ParagraphViewport
} from "../utils/MarkdownExposureUtils"
import display from "@ohos.display"
import { componentUtils, PromptAction } from "@kit.ArkUI"
import { MarkdownVisibleRectHolder, MarkdownVisibleRectSnapshot } from "../model/MarkdownVisibleRectHolder"
import { BlockQuoteTheme } from "../theme/BlockQuoteTheme"
import { BoldTheme } from "../theme/BoldTheme"
import { DefinitionListTheme } from "../theme/DefinitionListTheme"
import { FootnoteRefTheme } from "../theme/FootnoteRefTheme"
import { GlobalTheme } from "../theme/GlobalTheme"
import { HeadingTheme } from "../theme/HeadingTheme"
import { HighlightTheme } from "../theme/HighlightTheme"
import { HtmlUnderlineTheme } from "../theme/HtmlUnderlineTheme"
import { ImageTheme } from "../theme/ImageTheme"
import { InlineCodeTheme } from "../theme/InlineCodeTheme"
import { ItalicTheme } from "../theme/ItalicTheme"
import { LatexMathTheme } from "../theme/LatexMathTheme"
import { LinkTheme } from "../theme/LinkTheme"
import { ParagraphTheme } from "../theme/ParagraphTheme"
import { StrikethroughTheme } from "../theme/StrikethroughTheme"
import { SubTheme } from "../theme/SubTheme"
import { SupTheme } from "../theme/SupTheme"
import { TableTheme } from "../theme/TableTheme"
import {
  imageUrlHandle, imageWidthAndHeight, lengthToVpNumber,
  safeString,
  spanSoftLineBreak
} from "../utils/MarkdownUtils"
import {
  generateLinkIconPixelMap, computeLinkIconInfo, LinkIconResult
} from "../utils/MarkdownLinkIconGenerator"
import {
  spanBackgroundColor,
  spanBaselineOffset,
  spanDecoration,
  spanFontColor,
  spanFontFamily,
  spanFontSize,
  spanFontStyle,
  spanFontWeight,
  spanLetterSpacing,
  spanLineHeight,
  tableCellBackgroundColor
} from "../utils/MarkdownThemeUtils"
import { MarkdownHighlightParagraph } from "../configs/MarkdownHighlightParagraph"
import { pasteboard } from "@kit.BasicServicesKit"

/**
 * 表格格子控件
 */
@Component
export struct MarkdownTableCell {
  @Consume placeholderPixelMap: PixelMap | undefined // 图片占位图
  @ObjectLink @Watch('refreshData') node: NodeView // 表格格子自身节点数据
  @ObjectLink headingTheme: HeadingTheme // 标题样式
  @ObjectLink globalTheme: GlobalTheme // 整体样式
  @ObjectLink blockQuoteTheme: BlockQuoteTheme // 块引用样式
  @ObjectLink subTheme: SubTheme // 下标样式
  @ObjectLink supTheme: SupTheme // 上标样式
  @ObjectLink inlineCodeTheme: InlineCodeTheme // 内联代码样式
  @ObjectLink boldTheme: BoldTheme // 加粗样式
  @ObjectLink italicTheme: ItalicTheme // 斜体样式
  @ObjectLink strikethroughTheme: StrikethroughTheme // 删除线样式
  @ObjectLink highlightTheme: HighlightTheme // 高亮样式
  @ObjectLink htmlUnderlineTheme: HtmlUnderlineTheme // 下划线样式
  @ObjectLink linkTheme: LinkTheme // 链接样式
  @ObjectLink footnoteRefTheme: FootnoteRefTheme // 内联脚注样式
  @ObjectLink tableTheme: TableTheme // 表格样式
  @ObjectLink paragraphTheme: ParagraphTheme // 段落样式
  @ObjectLink definitionListTheme: DefinitionListTheme // 定义列表样式
  @ObjectLink imageTheme: ImageTheme // 图片样式
  @ObjectLink latexMathTheme: LatexMathTheme // 数学公式样式
  @ObjectLink markdownHighlightParagraph: MarkdownHighlightParagraph // 段落高亮配置
  @Prop componentWidth: number = 0.0 // 父布局控件宽度
  textCopyCallback?: (text: string) => void // 文本复制的点击事件
  footnoteCallback?: (index: string) => void // 脚注点击事件
  tocCallback?: (index: number) => void // TOC/标题ID点击事件
  linkCallback?: (url: string) => void // 链接点击事件
  imageCallback?: (url: string) => void // 图片点击事件
  imageDownloadCallback?: (url: string) => void // 图片下载事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> // 图片替换回调
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  customLongPressCallback?: () => void = undefined // 自定义长按事件
  @Prop tableBlockCellRow: number // 表格的第几行
  @Prop tableBlockCellCell: number // 表格的第几条
  @Prop tableBlockCellCellSize: number // 表格总共有几列
  @Prop tableBlockCellRowSize: number // 表格总共有几行
  @Consume('tableColumnWidths') columnWidths: number[] // 各列宽度快照（@Consume从MarkdownTable同步）
  @Consume cellWidthTracker: CellWidthTracker // 列宽跟踪器（非@Observed，onSizeChange只写不触发重渲染）
  @Consume isLatexMathEnabled: boolean // 数学公式插件是否启用
  @Consume tableContainerId: string // 表格横向body Scroll容器id（曝光水平可见性判定用）
  // CJMarkdown 根节点可见矩形（窗口坐标系 px）。垂直裁剪窗口=cell全局rect与该矩形求交，
  // 替代整屏高度——避免 cell 被标题栏/面板/系统栏遮挡时仍判可见（过报）。与 MarkdownParagraph 对称。
  @Consume('mdVisibleRectHolder') visibleRectHolder: MarkdownVisibleRectHolder
  @State @Watch('onListChanged') list: NodeView[] = [] // 表格格子子节点数据源
  private isAlive: boolean = true // 组件是否存活
  // —— 曝光统计（照搬 MarkdownParagraph） ——
  elementExposureCallback?: (event: MarkdownExposureEvent) => void // 元素曝光回调（透传）
  exposureThreshold: number = 0.5 // 曝光阈值（透传）
  private textController: TextController = new TextController() // 用于getRectsForRange取链接渲染矩形
  private httpLinks: NodeView[] = [] // 本段落内的http链接节点
  private httpLinksDirty: boolean = true // httpLinks 是否需重算（首次/config同步后/refreshData后置脏）
  private exposureTimerId: number = -1 // 曝光评估节流定时器
  private cellId: string = '' // Text组件id，供componentUtils.getRectangleById使用
  private cellWidthPx: number = 0 // Text当前宽度(px)
  private screenHeightPx: number = 0 // 屏幕高度(px，兜底用：visibleRectHolder未就绪时退化裁剪窗口)
  private screenWidthPx: number = 0 // 屏幕宽度(px，水平方向链接截断用)
  private viewportReady: boolean = false // 视口宽度/屏幕高度是否已就绪
  // CJMarkdown根可见矩形变化监听器（滚动/根尺寸变化时重算曝光）。aboutToAppear注册/aboutToDisappear注销。
  private visibleRectListener: (r: MarkdownVisibleRectSnapshot) => void = () => {}

  @State textBackgroundColor: ResourceColor = COLOR_TRANSPARENT // 被长按段落实时背景颜色
  @State selectBackgroundColor: ResourceColor = COLOR_FF4A90E2 // 选中文本的背景颜色
  @State selectStart: number = 0 // 选中文本的开始位置
  @State selectEnd: number = 0 // 选中文本的结束位置
  private textContent: string = "" // 文本内容
  private promptAction: PromptAction = this.getUIContext().getPromptAction()
  private delayTime: number = 500 // 自定义菜单关闭延时时间（毫秒）
  private timerId: number = -1 // 自定义菜单关闭延时定时器 ID
  @State @Watch('onParamChange') needHideMenu: boolean = false // 需要监听的条件参数
  @BuilderParam blockImageCardComponent: (desc:string, imageSrc:string, title:string) => void
  @BuilderParam blockLinkCardComponent: (desc:string, link:string, title:string) => void


  // 是否启用元素曝光统计：仅当 elementExposureCallback 已设置时为 true。
  // 未设回调时短路掉 computeLinkRanges/getRectsForRange/监听器/onVisibleAreaChange 等，省 CPU。
  // 用普通方法而非 getter：规避 @Component struct 内 private get 在模板字符串/条件判断中的 quirks。
  private isExposureEnabled(): boolean {
    return this.elementExposureCallback !== undefined
  }

  aboutToAppear(): void {
    this.cellId = 'md-tcell-' + this.node.nodeHash + '-' + this.tableBlockCellRow + '-' + this.tableBlockCellCell
    for (const child of this.node.children) {
      if (child.nodeType === "LatexMathNode" && child.latexPixelMap === undefined && child.latexIsLoading) {
        child.latexIsLoading = false
      }
    }
    this.refreshData() // 首次加载（refreshData设置list，onListChanged内调用tryReplaceImages/tryGenerateLinkIcons）
    // 监听器无条件注册：aboutToAppear 时刻 config 可能尚未与父组件同步（详情页在自身 aboutToAppear
    // 才给 markdownConfiguration 赋带回调的新对象），此刻 elementExposureCallback 可能是 undefined。
    // 若在此一次性门控会永久判 false。改为无条件注册，由 scheduleExposure/回调内部按运行时
    // exposureEnabled 短路。与 MarkdownParagraph 对称。
    this.visibleRectListener = (_r) => {
      this.scheduleExposure()
    }
    this.visibleRectHolder.addListener(this.visibleRectListener)
  }

  aboutToDisappear(): void {
    this.isAlive = false
    // 监听器在 aboutToAppear 无条件注册，故此处无条件移除（removeListener 对未注册者是 no-op，安全）
    this.visibleRectHolder.removeListener(this.visibleRectListener)
    if (this.exposureTimerId !== -1) {
      clearTimeout(this.exposureTimerId)
      this.exposureTimerId = -1
    }
    // 组件回收时，对当前可见的链接补发一次 visible=false（保证显示/消失成对），再重置标志。
    // 按运行时 exposureEnabled 门控：没回调则 httpLinks 恒空、无可见链接，跳过。
    if (this.isExposureEnabled()) {
      for (const link of this.httpLinks) {
        if (link.isLinkVisible()) {
          link.markLinkHidden()
          this.elementExposureCallback?.({ eventType: 'link', visible: false, data: link.linkUrl ?? '' })
        }
      }
    }
  }

  /**
   * 拿屏幕高度（px）。display.getDefaultDisplaySync 在 aboutToAppear 之前可能拿不到，
   * 故每次评估前兜底取一次。拿到后缓存。componentUtils.windowOffset 也是 px，单位一致。
   */
  private ensureScreenHeight(): void {
    if (this.screenHeightPx > 0) {
      return
    }
    try {
      const d = display.getDefaultDisplaySync()
      this.screenHeightPx = d.height
    } catch (e) {
      // ignore，下次再取
    }
  }

  /**
   * 拿屏幕宽度（px）。表格横向滚动时，cell 滚出屏幕右边界用此判定不可见。
   */
  private ensureScreenWidth(): void {
    if (this.screenWidthPx > 0) {
      return
    }
    try {
      const d = display.getDefaultDisplaySync()
      this.screenWidthPx = d.width
    } catch (e) {
      // ignore，下次再取
    }
  }

  /**
   * 防抖触发曝光评估。合并连续的 onAreaChange/onVisibleAreaChange/refreshData 触发。
   * 评估后对「本次显示」的链接回调 visible=true，「本次消失」的回调 visible=false。
   *
   * 视口来源：componentUtils.getRectangleById(cellId) 拿格内Text相对窗口的全局 rect（px），
   * 与屏幕高度求交得在屏可见区，再平移到 Text 内容区原点坐标系（与 getRectsForRange 同源）。
   * 表格吸顶/横向滚动/外层滚动导致的位移都反映在 windowOffset 里，无需单独建模。
   */
  private scheduleExposure(): void {
    if (!this.isAlive) {
      return
    }
    // 未设曝光回调时直接短路（兜底：onAreaChange/onVisibleAreaChange 仍会触发本方法）
    if (!this.isExposureEnabled()) {
      return
    }
    // 懒补算：aboutToAppear→refreshData 首跑时 config 可能尚未同步（exposureEnabled=false 跳过了 computeLinkRanges），
    // config 同步后 holder 通知/事件触发本方法，此处 httpLinks 仍为脏（dirty=true）。检测到 dirty 则补算一次（cell 无脚注前缀），
    // 算完置 clean，避免无链接 cell 每次 scheduleExposure 都重算。
    if (this.httpLinksDirty && this.list.length > 0) {
      this.httpLinks = computeLinkRanges(this.list, this.globalTheme.isLineBreak, 0)
      this.httpLinksDirty = false
    }
    // 仍无http链接的cell不参与曝光评估（省性能）
    if (this.httpLinks.length === 0) {
      return
    }
    if (this.exposureTimerId !== -1) {
      clearTimeout(this.exposureTimerId)
    }
    this.exposureTimerId = setTimeout(() => {
      this.exposureTimerId = -1
      if (!this.isAlive) {
        return
      }
      if (!this.viewportReady) {
        return
      }
      this.ensureScreenHeight()
      if (this.screenHeightPx <= 0) {
        return
      }
      this.ensureScreenWidth() // 兜底用：容器id取不到时用屏幕宽做水平右边界
      // 格内Text相对窗口的全局矩形（px）：componentUtils 同步调用，setTimeout(0) 时已 layout 完成
      let cellLeft: number = 0
      let cellTop: number = 0
      let cellRight: number = 0
      let cellBottom: number = 0
      try {
        const info = componentUtils.getRectangleById(this.cellId)
        cellLeft = info.windowOffset.x
        cellTop = info.windowOffset.y
        cellRight = info.windowOffset.x + info.size.width
        cellBottom = info.windowOffset.y + info.size.height
      } catch (e) {
        // 组件未挂载/id 未就绪，本次跳过
        return
      }
      // 表格横向body Scroll容器全局水平范围（px）：cell 滚出容器右边界 = 被表格横向clip = 不可见
      // 取不到容器id（header分支无id等）时退化为用屏幕宽兜底
      let contLeft: number = 0
      let contRight: number = this.screenWidthPx
      if (this.tableContainerId.length > 0) {
        try {
          const cInfo = componentUtils.getRectangleById(this.tableContainerId)
          contLeft = cInfo.windowOffset.x
          contRight = cInfo.windowOffset.x + cInfo.size.width
        } catch (e) {
          // 容器未就绪，用屏幕宽兜底
        }
      }
      // 水平可见：cell 全局水平区间与容器水平区间求交（cell 横滚出容器可见区被裁剪）
      const hIntersectLeft: number = Math.max(cellLeft, contLeft)
      const hIntersectRight: number = Math.min(cellRight, contRight)
      const hVisible: boolean = hIntersectRight > hIntersectLeft
      // 垂直裁剪窗口 = holder 推算的可见区域 [visTop, visBottom]（窗口 px，见 MarkdownVisibleRectHolder 算法）：
      //   onAreaChange 拿矩形区域，onVisibleAreaChange 拿 ratio，每 50ms 按「移动方向 + ratio 变化」收缩可见区域。
      // holder.visReady=false（ratio 首次>0 前）退化用整屏 [0, screenH]，避免漏报。
      const useVis: boolean = this.visibleRectHolder.visReady
      const vpTop: number = useVis ? this.visibleRectHolder.visTop : 0
      const vpBottom: number = useVis ? this.visibleRectHolder.visBottom : this.screenHeightPx
      // 格在屏可见视口（相对Text内容区原点，px）：
      // 垂直=全局区间与根可见矩形求交后平移；水平=cell与容器水平交集平移到Text原点
      const clipTopPx: number = Math.max(vpTop, Math.min(vpBottom, cellTop))
      const clipBottomPx: number = Math.min(vpBottom, Math.max(vpTop, cellBottom))
      const clipLeftPx: number = Math.max(0, hIntersectLeft - cellLeft)
      const clipRightPx: number = Math.max(0, hIntersectRight - cellLeft)
      const viewport: ParagraphViewport = {
        ready: hVisible && clipBottomPx > clipTopPx && clipRightPx > clipLeftPx && this.cellWidthPx > 0,
        clipTopPx: clipTopPx - cellTop,
        clipBottomPx: clipBottomPx - cellTop,
        clipLeftPx: clipLeftPx,
        clipRightPx: clipRightPx,
        widthPx: this.cellWidthPx
      }
      const result = evaluateLinkExposure(this.textController, viewport, this.exposureThreshold, this.httpLinks)
      for (const link of result.becameVisible) {
        this.elementExposureCallback?.({ eventType: 'link', visible: true, data: link.linkUrl ?? '' })
      }
      for (const link of result.becameHidden) {
        this.elementExposureCallback?.({ eventType: 'link', visible: false, data: link.linkUrl ?? '' })
      }
    }, 0)
  }



  //判断节点里有没有TableCellPart或者CustomCardImage或者CustomCardLink 如果没有走原来逻辑
  isBlockLogic(nodeViewList: NodeView[]):boolean{
      for (let i = 0; i < nodeViewList.length; i++) {
        let nodeView = nodeViewList[i]
        if(nodeView.nodeType == "TableCellPart" || nodeView.nodeType == "CustomCardImage" || nodeView.nodeType == "CustomCardLink"){
            return true
        }
      }
      return false
    }

  isGrandchildInList(item: NodeView): boolean {
    for (const parent of this.list) {
      if (parent.children && parent.children.indexOf(item) >= 0) {
        return true
      }
    }
    return false
  }

  collectAllDescendants(): NodeView[] {
    const result: NodeView[] = []
    for (const child of this.list) {
      result.push(child)
      if (child.children) {
        for (const grandChild of child.children) {
          result.push(grandChild)
        }
      }
    }
    return result
  }




  build() {
    Column() {
      if(this.isBlockLogic(this.list)){
        this.tableBlockCellCustomComponent()
      }else{
        this.tableCellColumn()
      }

    }
    .alignItems(this.node.tableAlignment)
    .justifyContent(FlexAlign.Center)
    .alignSelf(ItemAlign.Stretch)
    .padding({
      top: this.tableTheme.tableCellPaddingTop,
      right: this.tableTheme.tableCellPaddingRight,
      bottom: this.tableTheme.tableCellPaddingBottom,
      left: this.tableTheme.tableCellPaddingLeft
    })
    .backgroundColor(tableCellBackgroundColor(this.node, this.blockQuoteTheme, this.tableTheme, this.node.isQuote, this.tableBlockCellRow))
    .borderWidth({
      left: this.leftWidths(),
      right: this.rightWidths(),
      top: this.topWidths(),
      bottom: this.bottomWidths()
    })
    .borderStyle(this.tableTheme.tableBorderStyle)
    .borderColor(this.tableTheme.tableBorderColor)
    .constraintSize({
      minWidth: this.columnWidths[this.tableBlockCellCell] ?? 0,
      maxWidth: this.tableTheme.tableMaxCellWidth
    })
    .onSizeChange((oldValue, newValue) => {
      let newWidth: number = 0
      if (typeof newValue.width === 'number') {
        newWidth = newValue.width
      }
      if (newWidth > 0) {
        this.cellWidthTracker.updateCellWidth(this.tableBlockCellRow, this.tableBlockCellCell, newWidth)
      }
    })
  }

  /**
   * 段落文本数据循环
   * 注意：顶层ForEach直接引用this.list(@State)，不通过@Builder参数传递
   * 因为@Builder参数会创建本地副本，导致@State变化无法同步到ForEach
   */
  @Builder
  tableCellColumn() {
    Text(undefined, { controller: this.textController }) {
      ForEach(
        this.list,
        (item: NodeView, index: number) => {
          this.tableCellInlineItem(item, index)
        },
        (item: NodeView, index: number) => {
          this.updateTextContent(item) // 整理出当前所有的文本
          return `${index}-${item.nodeHash}-${item.contentHash}-${item.isEmphasis}-${item.isStrongEmphasis}-${item.isInLineCode}-${item.isStrikethrough}-${item.isHighlight}-${item.isUnderlineNode}-${item.isSubNode}-${item.isSupNode}-${item.imageWidth}-${item.imageHeight}-${item.latexImageWidth}-${item.latexImageHeight}-${item.latexPixelMap !== undefined}-${item.imageReplacePixelMap !== undefined}-${item.linkIconPixelMap !== undefined}-${item.linkIconType}-${item.linkIconWidth}-${item.linkIconHeight}-${this.linkTheme.linkCircleIconMargin}-${this.linkTheme.linkRectIconMargin}-${this.linkTheme.linkRectToolIconMargin}`
        }
      )
    }
    .textAlign(TextAlign.Start)
    .halfLeading(true)
    .copyOption(
      this.globalTheme.isOnCopy ? CopyOptions.LocalDevice : CopyOptions.None
    )
    .onCopy((str) => {
      this.textCopyCallback?.(str)
    })
    .id(this.cellId)
    .onVisibleAreaChange([0.0, 0.01, 0.1, 0.25, 0.5, 0.75, 1.0], (_isVisible: boolean, _currentRatio: number) => {
      // 仅作触发用，不用 isVisible 布尔门控可见性（实测滑动中会翻转竞态导致漏报）。
      // 真正的可见性由 evaluateLinkExposure 的「链接rect ∩ 格在屏可见视口」判定。
      // 未设曝光回调时直接返回，滚动期不再走 scheduleExposure（连 setTimeout 都不开）。
      if (!this.isExposureEnabled()) {
        return
      }
      this.scheduleExposure()
    })
    .onAreaChange((_old: Area, newArea: Area) => {
      // 格内Text自身宽度（vp→px）。全局位置由 componentUtils.getRectangleById 实时拿，
      // 故此处只更新宽度并触发评估。未启用曝光时跳过。
      if (!this.isExposureEnabled()) {
        return
      }
      const w: number = (newArea.width as number) ?? 0
      this.cellWidthPx = vp2px(w)
      this.viewportReady = true
      this.scheduleExposure()
    })
    .backgroundColor(this.textBackgroundColor)
    .selectedBackgroundColor(this.selectBackgroundColor)
    .selection(this.selectStart, this.selectEnd)
    .onTextSelectionChange((selectionStart: number, selectionEnd: number): void => {
      this.selectStart = selectionStart
      this.selectEnd = selectionEnd
      this.textBackgroundColor = COLOR_TRANSPARENT
      this.selectBackgroundColor = this.markdownHighlightParagraph.selectedParagraphBackgroundColor
    })
    .parallelGesture(
      LongPressGesture({ repeat: false, duration: 400})
        .onAction((event: GestureEvent) => {
          this.textBackgroundColor = this.markdownHighlightParagraph.beforeSelectedParagraphBackgroundColor
        })
        .onActionEnd((event: GestureEvent) => {
          if (!this.globalTheme.isOnCopy) { // 不启用长按复制时使用自定义方法
            this.textBackgroundColor = COLOR_TRANSPARENT
            this.customLongPressCallback?.() // 调用用户自定义长按回调方法
          }
        })
    )
    .bindSelectionMenu(TextSpanType.TEXT, this.CustomMenu, TextResponseType.LONG_PRESS, {
      onMenuShow: () => {
        this.needHideMenu = false
      },
      onMenuHide: () => {
        this.needHideMenu = true
      }
    })
    .bindSelectionMenu(TextSpanType.IMAGE, this.NullMenu(), TextResponseType.LONG_PRESS, {
      onMenuShow: () => {
        this.needHideMenu = false
      },
      onMenuHide: () => {
        this.needHideMenu = true
      }
    })
    .bindSelectionMenu(TextSpanType.MIXED, this.CustomMenu, TextResponseType.LONG_PRESS, {
      onMenuShow: () => {
        this.needHideMenu = false
      },
      onMenuHide: () => {
        this.needHideMenu = true
      }
    })
  }


  @Builder
  tableBlockCellCustomComponent() {
    Column() {
      ForEach(
        this.list,
        (item: NodeView, idx: number) => {
          if (item.nodeType == "CustomCardImage") {
            // 自定义卡片图片
            this.blockImageCardComponent(
              safeString(item.imageAltText),
              safeString(item.imageUrl),
              safeString(item.imageTitle),
            )
          } else if (item.nodeType == "CustomCardLink") {
            this.blockLinkCardComponent(
              safeString(item.nodeText),
              safeString(item.linkUrl),
              safeString(item.linkTitle),
            )
          } else if (item.nodeType == "TableCellPart") {
            Text(undefined, { controller: this.textController }) {
              ForEach(
                item.children,
                (itemNodeView: NodeView, index: number) => {
                  this.tableCellInlineItem(itemNodeView, index)
                },
                (itemNodeView: NodeView, index: number) => {
                  this.updateTextContent(itemNodeView) // 整理出当前所有的文本
                  return `${index}-${itemNodeView.nodeHash}-${itemNodeView.contentHash}-${itemNodeView.imageWidth}-${itemNodeView.imageHeight}-${itemNodeView.latexImageWidth}-${itemNodeView.latexImageHeight}-${itemNodeView.latexPixelMap !== undefined}-${itemNodeView.imageReplacePixelMap !== undefined}-${itemNodeView.linkIconPixelMap !== undefined}-${itemNodeView.linkIconType}-${itemNodeView.linkIconWidth}-${itemNodeView.linkIconHeight}-${this.linkTheme.linkCircleIconMargin}-${this.linkTheme.linkRectIconMargin}-${this.linkTheme.linkRectToolIconMargin}`
                }
              )
            }
            .textAlign(TextAlign.Start)
            .halfLeading(true)
            .copyOption(
              this.globalTheme.isOnCopy ? CopyOptions.LocalDevice : CopyOptions.None
            )
          }
        },
        (item: NodeView, idx: number) => {
          let childKey = ''
          if (item.children) {
            for (const child of item.children) {
              childKey += `-${child.nodeHash}-${child.imageWidth}-${child.imageHeight}-${child.imageReplacePixelMap !== undefined}-${child.latexPixelMap !== undefined}`
            }
          }
          return `${idx}-${item.nodeHash}-${item.nodeType}${childKey}`
        }
      )
    }
}






  /**
   * 渲染单个内联节点（文本/代码/链接/加粗等）
   *
   * @param item 节点视图
   * @param index 索引
   */
  @Builder
  tableCellInlineItem(item: NodeView, index: number) {
    if (item.nodeType === "Text" || item.nodeType === "Code" || item.nodeType === "Footnote") {
      // 普通文本/内联代码/内联脚注
      Span(item.nodeText)
        .fontColor(spanFontColor(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .fontSize(spanFontSize(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .fontStyle(spanFontStyle(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme,
          this.definitionListTheme
        ))
        .fontWeight(spanFontWeight(
          item,
          this.tableBlockCellCell === 0 && this.tableTheme.tableFirstColumnIsBold,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme,
          this.definitionListTheme
        ))
        .fontFamily(spanFontFamily(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .letterSpacing(spanLetterSpacing(
          item,
          this.subTheme,
          this.supTheme,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .decoration(spanDecoration(
          item,
          this.strikethroughTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme
        ))
        .textBackgroundStyle(spanBackgroundColor(
          item,
          this.inlineCodeTheme,
          this.highlightTheme,
          this.linkTheme,
          this.footnoteRefTheme
        ))
        .baselineOffset(spanBaselineOffset(
          item,
          this.subTheme,
          this.supTheme
        ))
        .lineHeight(spanLineHeight(
          item,
          this.inlineCodeTheme,
          this.boldTheme,
          this.italicTheme,
          this.strikethroughTheme,
          this.highlightTheme,
          this.htmlUnderlineTheme,
          this.linkTheme,
          this.footnoteRefTheme,
          this.headingTheme,
          this.tableTheme,
          this.paragraphTheme
        ))
        .onClick(() => {
          if (item.footnoteID !== undefined) {
            this.footnoteCallback?.(item.footnoteID)
            return
          }
          if (item.headLinkIndex !== undefined) {
            this.tocCallback?.(item.headLinkIndex)
            return
          }
          if (item.linkUrl !== undefined) {
            this.linkCallback?.(item.linkUrl)
            return
          }
        })
    } else if (item.nodeType === "SoftLineBreak") {
      // 软换行
      Span(spanSoftLineBreak(this.globalTheme.isLineBreak))
    } else if (item.nodeType === "HardLineBreak") {
      // 硬换行
      Span("\n")
    } else if (item.nodeType === "Image" || item.nodeType === "StyleImage" || item.nodeType === "ImageHtmlNode") {
      // 图片/图片Style/HTML图片
      if (item.imageReplacePixelMap !== undefined || item.imageUrl !== undefined) {
        ImageSpan(item.imageReplacePixelMap ?? imageUrlHandle(item.imageUrl))
          .alt(this.placeholderPixelMap)
          .margin({
            top: this.imageTheme.imageMarginTop,
            right: this.imageTheme.imageMarginRight,
            bottom: this.imageTheme.imageMarginBottom,
            left: this.imageTheme.imageMarginLeft
          })
          .borderRadius({
            topLeft: item.imageRadius ?? this.imageTheme.imageRadiusTopLeft,
            topRight: item.imageRadius ?? this.imageTheme.imageRadiusTopRight,
            bottomLeft: item.imageRadius ?? this.imageTheme.imageRadiusBottomLeft,
            bottomRight: item.imageRadius ?? this.imageTheme.imageRadiusBottomRight
          })
          .borderWidth(this.imageTheme.imageBorderWidth)
          .borderColor(this.imageTheme.imageBorderColor)
          .borderStyle(this.imageTheme.imageBorderStyle)
          .width(item.imageWidth ?? undefined)
          .height(item.imageHeight)
          .objectFit(this.imageTheme.imageFitType)
          .verticalAlign(ImageSpanAlignment.CENTER)
          .constraintSize({
            maxWidth: this.tableTheme.tableMaxCellWidth,
            maxHeight: this.imageTheme.imageMaxHeight
          })
          .onClick(() => {
            if (item.isLink) {
              this.linkCallback?.(item.linkUrl ?? "")
            } else {
              this.imageCallback?.(item.imageUrl ?? "")
            }
          })
          .onComplete((imageLoadResult) => {
            const cellMaxWidth: number = lengthToVpNumber(this.tableTheme.tableMaxCellWidth) ?? this.componentWidth
            const l = imageWidthAndHeight(
              cellMaxWidth,
              imageLoadResult.width,
              imageLoadResult.height,
              (item.imageStyleWidth !== undefined ? vp2px(item.imageStyleWidth) : undefined) ??
              (this.imageTheme.imageWidth !== undefined ? vp2px(this.imageTheme.imageWidth) : undefined),
              (item.imageStyleHeight !== undefined ? vp2px(item.imageStyleHeight) : undefined) ??
              (this.imageTheme.imageHeight !== undefined ? vp2px(this.imageTheme.imageHeight) : undefined),
              this.imageTheme.imageMaxWidth,
              this.imageTheme.imageMaxHeight,
              this.imageTheme.imageFixedRatioWidth,
              this.imageTheme.imageMaximumWidth
            )
            item.imageWidth = px2vp(l[0])
            item.imageHeight = px2vp(l[1])
            if (this.list.indexOf(item) >= 0 || this.isGrandchildInList(item)) {
              this.list = [...this.list]
            }
          })
      }
    } else if (item.nodeType === "Link" || item.nodeType === "HeadLink") {
      if ((item.isBulletList || item.isOrderedList || item.isQuote || item.isDescList) && this.isSingleLinkNode() && !this.linkTheme.linkListIsIcon) {
        Span(item.nodeText)
          .fontColor(this.linkTheme.linkTextFontColor)
          .fontSize(this.paragraphTheme.paragraphTextFontSize)
          .decoration(spanDecoration(
            item,
            this.strikethroughTheme,
            this.htmlUnderlineTheme,
            this.linkTheme,
            this.footnoteRefTheme
          ))
          .onClick(() => {
            if (item.linkUrl !== undefined) {
              this.linkCallback?.(item.linkUrl)
            }
          })
      } else {
        if (item.linkIconPixelMap !== undefined && item.linkIconWidth > 0 && item.linkIconHeight > 0) {
          ImageSpan(item.linkIconPixelMap)
            .width(px2vp(item.linkIconWidth))
            .height(px2vp(item.linkIconHeight))
            .verticalAlign(ImageSpanAlignment.CENTER)
            .margin({
              left: this.getLinkIconMargin(item),
              right: this.getLinkIconMargin(item)
            })
            .onClick(() => {
              if (item.linkUrl !== undefined) {
                this.linkCallback?.(item.linkUrl)
              }
            })
        } else {
          Span(item.nodeText)
            .fontColor(this.linkTheme.linkTextFontColor)
            .fontSize(this.paragraphTheme.paragraphTextFontSize)
            .decoration(spanDecoration(
              item,
              this.strikethroughTheme,
              this.htmlUnderlineTheme,
              this.linkTheme,
              this.footnoteRefTheme
            ))
            .onClick(() => {
              if (item.linkUrl !== undefined) {
                this.linkCallback?.(item.linkUrl)
              }
            })
        }
      }
    } else if (item.nodeType === "LatexMathNode") {
      // 数学公式行内 - 和图片一样直接用ImageSpan
      if (this.isLatexMathEnabled && item.latexPixelMap !== undefined && item.latexImageWidth > 0 && item.latexImageHeight > 0) {
        ImageSpan(item.latexPixelMap)
          .height(this.latexMathTheme.latexMathTextSize)
          .width((item.latexImageWidth / item.latexImageHeight) * this.latexMathTheme.latexMathTextSize)
          .verticalAlign(ImageSpanAlignment.CENTER)
          .constraintSize({ maxWidth: this.tableTheme.tableMaxCellWidth })
          .onClick(() => {
            if (this.latexImageCallback !== undefined && item.latexImageData !== undefined) {
              this.latexImageCallback(item.latexImageData, item.latexImageHeight, item.latexImageWidth)
            }
          })
      } else {
        Span(item.nodeText)
      }
    } else {
      // 其它
    }
  }

  /**
   * 自定义菜单
   */
  @Builder
  CustomMenu() {
    Row() {
      // 菜单项：复制
      Column() {
        Text('复制')
          .fontSize(14)
          .fontColor(COLOR_FF191919)
      }
      .padding({ left: 10, right: 10, top: 8, bottom: 8 })
      .onClick(() => {
        // 获取选中文本并复制到剪贴板
        let selectedText = this.textContent.substring(this.selectStart, this.selectEnd)
        let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, selectedText)
        pasteboard.getSystemPasteboard().setData(pasteData)
        this.textCopyCallback?.(selectedText)
        this.textController.closeSelectionMenu()
      })
    }
    .backgroundColor(COLOR_WHITE)
    .borderWidth(1)
    .borderColor(COLOR_FFF5F2F0)
    .borderRadius(5)
    .shadow(ShadowStyle.OUTER_DEFAULT_LG) // 阴影
  }

  /**
   * 自定义空白菜单
   */
  @Builder
  NullMenu() {}

  /**
   * 表格左部边框宽度
   */
  leftWidths(): Length {
    return 0
  }

  /**
   * 表格右部边框宽度
   */
  rightWidths(): Length {
    return this.tableBlockCellCell === this.tableBlockCellCellSize - 1 ? 0 : this.tableTheme.tableBorderWidth
  }

  /**
   * 表格顶部边框宽度
   */
  topWidths(): Length {
    return 0
  }

  /**
   * 表格底部边框宽度
   */
  bottomWidths(): Length {
    return this.tableBlockCellRow === this.tableBlockCellRowSize - 1 ? 0 : this.tableTheme.tableBorderWidth
  }

  /**
   * 刷新数据
   */
  refreshData() {
    const children = this.node.children
    if (children.length === 0) {
      for (const old of this.list) {
        old.releaseOwnPixelMaps()
      }
      this.list = []
      this.httpLinks = []
      this.httpLinksDirty = true
      return
    }
    const oldImageSizes: Map<string, number[]> = new Map()
    for (const oldChild of this.list) {
      if (oldChild.imageUrl !== undefined && oldChild.imageWidth !== undefined && oldChild.imageWidth > 0 && oldChild.imageHeight !== undefined) {
        oldImageSizes.set(oldChild.imageUrl, [oldChild.imageWidth, oldChild.imageHeight])
      }
      if (oldChild.children) {
        for (const grandChild of oldChild.children) {
          if (grandChild.imageUrl !== undefined && grandChild.imageWidth !== undefined && grandChild.imageWidth > 0 && grandChild.imageHeight !== undefined) {
            oldImageSizes.set(grandChild.imageUrl, [grandChild.imageWidth, grandChild.imageHeight])
          }
        }
      }
    }
    for (const newChild of children) {
      if (newChild.imageUrl !== undefined) {
        const oldSize = oldImageSizes.get(newChild.imageUrl)
        if (oldSize) {
          newChild.imageWidth = oldSize[0]
          newChild.imageHeight = oldSize[1]
        }
      }
      if (newChild.children) {
        for (const grandChild of newChild.children) {
          if (grandChild.imageUrl !== undefined) {
            const oldSize = oldImageSizes.get(grandChild.imageUrl)
            if (oldSize) {
              grandChild.imageWidth = oldSize[0]
              grandChild.imageHeight = oldSize[1]
            }
          }
        }
      }
    }
    const oldList = this.list
    this.list = [...children]
    const newSet: Set<NodeView> = new Set<NodeView>(children)
    for (const old of oldList) {
      if (!newSet.has(old)) {
        old.releaseOwnPixelMaps()
      }
    }
    this.tryEnqueueLatexLoading()
    // 标记 httpLinks 脏：list 变了偏移必变。dirty=true 后：已启用→下面立即重算；未启用（config
    // 尚未同步）→跳过，dirty 留 true，待 config 同步后 scheduleExposure 懒补算。
    this.httpLinksDirty = true
    // 仅在启用曝光时重算http链接字符偏移并触发评估；未设回调时跳过（省遍历开销）
    if (this.isExposureEnabled()) {
      this.httpLinks = computeLinkRanges(this.list, this.globalTheme.isLineBreak, 0)
      this.httpLinksDirty = false
      this.scheduleExposure()
    }
  }

  /**
   * 数学公式异步加载入队（从onListChanged提取，refreshData直接调用，不依赖@Watch链）
   */
  private tryEnqueueLatexLoading(): void {
    if (!this.isLatexMathEnabled) {
      return
    }
    const allItems: NodeView[] = this.collectAllDescendants()
    for (const child of allItems) {
      if (child.nodeType === "LatexMathNode" && !child.latexIsLoading && child.latexPixelMap === undefined) {
        child.latexIsLoading = true
        LatexParseQueue.enqueue(() => {
          if (this.isAlive) {
            this.loadLatexImage(child)
          } else {
            child.latexIsLoading = false
            LatexParseQueue.notifyDone()
          }
        })
      }
    }
  }

  /**
   * list变化时触发异步加载（从refreshData移出tryReplaceImages/tryGenerateLinkIcons，避免每次this.list=[...this.list]都重跑；
   * 各方法内置tried守卫，重复触发仅遍历检查不会重跑）
   */
  onListChanged() {
    this.tryReplaceImages()
    this.tryGenerateLinkIcons()
    this.tryEnqueueLatexLoading()
  }

  /**
   * 异步替换图片：调用imageReplaceCallback获取原始字节→转为PixelMap→更新ImageSpan渲染
   */
  private tryReplaceImages(): void {
    if (this.imageReplaceCallback === undefined) {
      return
    }
    const allItems: NodeView[] = this.collectAllDescendants()
    for (const child of allItems) {
      if (child.imageUrl !== undefined && !child.imageReplaceTried) {
        child.imageReplaceTried = true
        this.imageReplaceCallback(child.imageUrl).then((buffer: ArrayBuffer | undefined) => {
          if (!this.isAlive || buffer === undefined) {
            return
          }
          if (this.list.indexOf(child) < 0 && !this.isGrandchildInList(child)) {
            return
          }
          const imageSource: image.ImageSource = image.createImageSource(buffer)
          imageSource.createPixelMap().then((pm: PixelMap) => {
            imageSource.release()
            if (!this.isAlive || (this.list.indexOf(child) < 0 && !this.isGrandchildInList(child))) {
              pm.release()
              return
            }
            child.imageReplacePixelMap = pm
            this.list = [...this.list]
          }).catch(() => {
            imageSource.release()
          })
        }).catch(() => {
          console.error('TableCell imageReplace failed')
        })
      }
    }
  }

  /**
   * 判断当前list是否仅含一个Link节点（用于列表上下文是否图片化判断）
   */
  private isSingleLinkNode(): boolean {
    if (this.list.length !== 1) {
      return false
    }
    const node = this.list[0]
    return node.nodeType === "Link" || node.nodeType === "HeadLink"
  }

  /**
   * 根据链接URL和文本计算图标外边距
   */
  private getLinkIconMargin(item: NodeView): number {
    const iconType = item.linkIconType
    if (iconType === LINK_ICON_TYPE_CIRCLE) {
      return this.linkTheme.linkCircleIconMargin
    } else if (iconType === LINK_ICON_TYPE_RECT) {
      return this.linkTheme.linkRectIconMargin
    } else {
      return this.linkTheme.linkRectToolIconMargin
    }
  }

  /**
   * 异步生成链接图标PixelMap（通过C++原生绘图）
   */
  private tryGenerateLinkIcons(): void {
    const allItems: NodeView[] = this.collectAllDescendants()
    for (const child of allItems) {
      if ((child.nodeType === "Link" || child.nodeType === "HeadLink") && child.isLinkStyle && !child.linkIconTried) {
        child.linkIconTried = true
        child.linkIconText = child.nodeText
        child.linkIconType = computeLinkIconInfo(child.linkUrl ?? "", child.nodeText).iconType
        generateLinkIconPixelMap(child.nodeText, child.linkUrl ?? "", this.linkTheme)
          .then((result: LinkIconResult | undefined) => {
            if (!this.isAlive || result === undefined) {
              if (result !== undefined) {
                result.pixelMap.release()
              }
              return
            }
            if (this.list.indexOf(child) < 0 && !this.isGrandchildInList(child)) {
              result.pixelMap.release()
              return
            }
            if (child.linkIconText !== child.nodeText) {
              result.pixelMap.release()
              return
            }
            if (child.linkIconPixelMap !== undefined) {
              try {
                child.linkIconPixelMap.release()
              } catch (e) {
                console.error('linkIconPixelMap release failed: ' + JSON.stringify(e))
              }
            }
            child.linkIconPixelMap = result.pixelMap
            child.linkIconWidth = result.width
            child.linkIconHeight = result.height
            this.list = [...this.list]
          })
          .catch(() => {
            console.error('TableCell linkIcon generation failed')
          })
      }
    }
  }

  /**
   * 异步加载数学公式图片（通过全局队列串行调用latexStringToImage）
   * 流式输出时latex文本可能增长，需捕获调用时的文本，回调中校验是否已过期，
   * 避免旧文本的图片覆盖新状态（旧图片闪烁/内存泄漏）。
   *
   * @param item 节点视图
   */
  private loadLatexImage(item: NodeView): void {
    try {
      const capturedNodeText: string = item.nodeText
      const strLatexMath: string = this.latexStrCallback(capturedNodeText)
      const textSize: number = vp2px(this.latexMathTheme.latexMathTextSize)
      const textColor: number = resourceColorToNumber(this.latexMathTheme.latexMathTextColor)
      const bgColor: number = resourceColorToNumber(this.latexMathTheme.latexMathBackgroundColor)
      const colorFormat: LatexMathColorFormat = this.latexMathTheme.latexMathColorFormat === 0
        ? LatexMathColorFormat.COLOR_FORMAT_RGB_565
        : LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
      const resPath: string | undefined = this.latexMathTheme.latexMathResPath

      latexStringToImage(strLatexMath, textSize, textColor, bgColor, colorFormat, resPath)
        .then((buffer: ArrayBuffer) => {
          if (!this.isAlive) {
            item.latexIsLoading = false
            LatexParseQueue.notifyDone()
            return
          }
          const imageSource: image.ImageSource = image.createImageSource(buffer)
          imageSource.createPixelMap().then((pm: PixelMap) => {
            imageSource.release()
            if (!this.isAlive) {
              pm.release()
              item.latexIsLoading = false
              LatexParseQueue.notifyDone()
              return
            }
            pm.getImageInfo().then((info: image.ImageInfo) => {
              if (!this.isAlive) {
                pm.release()
                item.latexIsLoading = false
                LatexParseQueue.notifyDone()
                return
              }
              // 流式输出中文本可能已变化，丢弃过期结果
              // 重新触发onListChanged检查是否需要为新文本重新入队加载
              if (item.nodeText !== capturedNodeText) {
                pm.release()
                LatexParseQueue.notifyDone()
                this.list = [...this.list]
                return
              }
              // 释放旧PixelMap（防御性：理论上此处应为undefined）
              if (item.latexPixelMap !== undefined) {
                try {
                  item.latexPixelMap.release()
                } catch (e) {
                  console.error('TableCell latexPixelMap release failed: ' + JSON.stringify(e))
                }
              }
              item.latexPixelMap = pm
              item.latexImageData = buffer
              item.latexImageWidth = info.size.width
              item.latexImageHeight = info.size.height
              item.latexIsLoading = false
              this.list = [...this.list] // 触发重渲染
              LatexParseQueue.notifyDone()
            }).catch(() => {
              pm.release()
              // 仅当文本未变化时才重置loading，避免覆盖新一轮加载的loading状态
              if (item.nodeText === capturedNodeText) {
                item.latexIsLoading = false
              }
              LatexParseQueue.notifyDone()
            })
          }).catch(() => {
            imageSource.release()
            if (item.nodeText === capturedNodeText) {
              item.latexIsLoading = false
            }
            LatexParseQueue.notifyDone()
          })
        })
        .catch(() => {
          if (item.nodeText === capturedNodeText) {
            item.latexIsLoading = false
          }
          LatexParseQueue.notifyDone()
        })
    } catch (e) {
      item.latexIsLoading = false
      LatexParseQueue.notifyDone()
    }
  }

  // 更新文本内容
  private updateTextContent(item: NodeView): void {
    if (item.nodeType === "Text" || item.nodeType === "Code" || item.nodeType === "Footnote") {
      this.textContent =  this.textContent + item.nodeText
    } else if (item.nodeType === "SoftLineBreak") {
      // 软换行
      this.textContent =  this.textContent + spanSoftLineBreak(this.globalTheme.isLineBreak)
    } else if (item.nodeType === "HardLineBreak") {
      // 硬换行
      this.textContent =  this.textContent + "\n"
    } else if (item.nodeType === "Link" || item.nodeType === "HeadLink" || item.nodeType === "LatexMathNode" ||
      item.nodeType === "Image" || item.nodeType === "StyleImage" || item.nodeType === "ImageHtmlNode") {
      // 非文本节点，不处理
    } else {
      this.textContent =  this.textContent + item.nodeText
    }
  }

  // 参数变化时的回调
  onParamChange(): void {
    if (this.needHideMenu) {
      this.startDelay() // 参数变为 true：启动延时
    } else {
      this.cancelDelay() // 参数变为 false：取消延时
    }
  }

  // 启动弹窗关闭判断延时
  private startDelay(): void {
    this.cancelDelay() // 先清除之前的定时器，防止重复
    this.timerId = setTimeout(() => {
      // 延时到期，再次检查参数状态，参数仍为 true，关闭长按菜单
      if (this.needHideMenu) {
        this.selectStart = -1
        this.selectEnd = -1
        this.textController.closeSelectionMenu()
      }
      this.timerId = -1
    }, this.delayTime)
  }

  // 取消弹窗关闭判断延时
  private cancelDelay(): void {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId)
      this.timerId = -1
    }
  }
}
