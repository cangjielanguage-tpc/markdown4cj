import { image } from "@kit.ImageKit"
import { resourceColorToNumber, LINK_ICON_TYPE_CIRCLE, LINK_ICON_TYPE_RECT, COLOR_FFE0E0E0,
  COLOR_FF4A90E2,
  COLOR_TRANSPARENT,
  COLOR_FF808080,
  COLOR_FF191919,
  COLOR_FFF5F2F0,
  COLOR_WHITE} from "../base/Constants"
import { latexStringToImage, LatexMathColorFormat } from "@cangjie-tpc/formula_hybrid"
import {
  headingBackgroundColor,
  headingMarginBottom,
  headingMarginLeft,
  headingMarginRight,
  headingMarginTop,
  headingPaddingBottom,
  headingPaddingLeft,
  headingPaddingRight,
  headingPaddingTop,
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
} from '../utils/MarkdownThemeUtils'
import { NodeView } from '../model/NodeView'
import { LatexParseQueue } from '../model/LatexParseQueue'
import { HeadingTheme } from '../theme/HeadingTheme'
import { GlobalTheme } from '../theme/GlobalTheme'
import { BlockQuoteTheme } from '../theme/BlockQuoteTheme'
import {
  imageUrlHandle,
  imageWidthAndHeight,
  spanSoftLineBreak
} from '../utils/MarkdownUtils'
import {
  generateLinkIconPixelMap,
  computeLinkIconInfo,
  LinkIconResult
} from '../utils/MarkdownLinkIconGenerator'
import { SubTheme } from '../theme/SubTheme'
import { SupTheme } from '../theme/SupTheme'
import { InlineCodeTheme } from '../theme/InlineCodeTheme'
import { ItalicTheme } from '../theme/ItalicTheme'
import { LatexMathTheme } from '../theme/LatexMathTheme'
import { StrikethroughTheme } from '../theme/StrikethroughTheme'
import { HighlightTheme } from '../theme/HighlightTheme'
import { HtmlUnderlineTheme } from '../theme/HtmlUnderlineTheme'
import { BoldTheme } from '../theme/BoldTheme'
import { LinkTheme } from '../theme/LinkTheme'
import { FootnoteRefTheme } from '../theme/FootnoteRefTheme'
import { TableTheme } from '../theme/TableTheme'
import { ParagraphTheme } from '../theme/ParagraphTheme'
import { DefinitionListTheme } from '../theme/DefinitionListTheme'
import { ImageTheme } from '../theme/ImageTheme'
import { MarkdownImageBlock } from './MarkdownImageBlock'
import display from '@ohos.display'
import { MarkdownHighlightParagraph } from '../configs/MarkdownHighlightParagraph'
import { componentUtils, PromptAction } from '@kit.ArkUI'
import { MarkdownExposureEvent } from '../model/MarkdownExposureEvent'
import {
  computeLinkRanges,
  evaluateLinkExposure,
  ParagraphViewport
} from '../utils/MarkdownExposureUtils'
import { MarkdownVisibleRectHolder, MarkdownVisibleRectSnapshot } from '../model/MarkdownVisibleRectHolder'
import { pasteboard } from "@kit.BasicServicesKit"

/**
 * 标题控件
 */
@Component
export struct MarkdownHeading {
  @Consume placeholderPixelMap: PixelMap | undefined // 图片占位图
  @Consume isLatexMathEnabled: boolean // 数学公式插件是否启用
  // CJMarkdown 根节点可见矩形（窗口坐标系 px）。链接曝光裁剪窗口=标题全局rect与该矩形求交，
  // 替代整屏高度——避免标题被标题栏/面板/系统栏遮挡时仍判可见（过报）。
  @Consume('mdVisibleRectHolder') visibleRectHolder: MarkdownVisibleRectHolder
  @ObjectLink @Watch('refreshData') node: NodeView // 标题自身节点数据
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
  imageDownloadCallback?: (url: string) => void // 图片下载点击事件
  imageReplaceCallback?: (url: string) => Promise<ArrayBuffer | undefined> // 图片替换回调
  latexImageCallback?: (data: ArrayBuffer, height: number, width: number) => void // 数学公式图片点击事件
  latexStrCallback: (str: string) => string = (str: string) => str // 数学公式数据处理事件
  customLongPressCallback?: (str: string) => void = undefined // 自定义长按事件
  @State @Watch('onListChanged') list: NodeView[] = [] // 标题子节点数据源
  private isAlive: boolean = true // 组件是否存活
  // —— 曝光统计（与 MarkdownParagraph 同构） ——
  elementExposureCallback?: (event: MarkdownExposureEvent) => void // 元素曝光回调（透传）
  exposureThreshold: number = 0.5 // 曝光阈值（透传）
  private textController: TextController = new TextController() // 标题Text控制器，用于getRectsForRange拿链接矩形
  private httpLinks: NodeView[] = [] // 标题内参与曝光的http链接（含rangeStart/rangeEnd）
  private httpLinksDirty: boolean = true // httpLinks 是否需重算（首次/config同步后/refreshData后置脏）
  private exposureTimerId: number = -1 // 曝光评估防抖定时器
  // 标题在屏可见视口相关：标题全局rect ∩ CJMarkdown根可见矩形（窗口坐标系px）→ 平移到Text原点
  private headingId: string = '' // 标题Text的唯一id（用于componentUtils.getRectangleById，aboutToAppear赋值）
  private headingWidthPx: number = 0 // Text自身宽度（px，onAreaChange的vp转px，水平方向链接截断用）
  private screenHeightPx: number = 0 // 屏幕高度（px，兜底用：visibleRectHolder未就绪时退化裁剪窗口）
  private viewportReady: boolean = false // onAreaChange是否触发过（尺寸已就绪）
  // CJMarkdown根可见矩形变化监听器（滚动/根尺寸变化时重算曝光）。aboutToAppear注册/aboutToDisappear注销。
  private visibleRectListener: (r: MarkdownVisibleRectSnapshot) => void = () => {}

  @State textBackgroundColor: ResourceColor = COLOR_TRANSPARENT // 被长按段落实时背景颜色
  @State selectBackgroundColor: ResourceColor = COLOR_FF4A90E2 // 选中文本的背景颜色
  @State selectStart: number = 0 // 选中文本的开始位置
  @State selectEnd: number = 0 // 选中文本的结束位置
  private textContent: string = "" // 文本内容
  private promptAction: PromptAction = this.getUIContext().getPromptAction()
  private delayTime: number = 300 // 自定义菜单关闭延时时间（毫秒）
  private timerId: number = -1 // 自定义菜单关闭延时定时器 ID
  @State @Watch('onParamChange') needHideMenu: boolean = false // 需要监听的条件参数
  paragraphHeadingAnimationStart?: () => void // 段落动画开始回调
  paragraphHeadingAnimationEnd?: () => void // 段落动画结束回调

  // 是否启用元素曝光统计：仅当 elementExposureCallback 已设置时为 true。
  // 未设回调时短路掉 computeLinkRanges/getRectsForRange/监听器/onVisibleAreaChange 等，省 CPU。
  // 用方法而非 getter：@Component struct 内 `private get exposureEnabled` 在运行时返回 undefined
  //（实测 cbSet=true enabled=undefined），导致运行时门控永久判 false、整条链路死。
  private isExposureEnabled(): boolean {
    return this.elementExposureCallback !== undefined
  }

  aboutToAppear(): void {
    // 标题Text的唯一id：用nodeHash保证流式复用同一节点时id稳定（componentUtils.getRectangleById用它拿全局rect）
    this.headingId = 'md-exp-h-' + this.node.nodeHash
    for (const child of this.node.children) {
      if (child.nodeType === "LatexMathNode" && child.latexPixelMap === undefined && child.latexIsLoading) {
        child.latexIsLoading = false
      }
    }
    this.refreshData() // 首次加载
    // 监听器无条件注册：aboutToAppear 时刻 config 可能尚未与父组件同步（详情页在自身 aboutToAppear
    // 才给 markdownConfiguration 赋带回调的新对象），此刻 elementExposureCallback 可能是 undefined。
    // 若在此一次性门控会永久判 false。改为无条件注册，由 scheduleExposure/回调内部按运行时
    // exposureEnabled 短路。与 MarkdownParagraph/MarkdownTableCell 对称。
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

  build() {
    Row() {
      this.headingColumn()
    }
    .backgroundColor(headingBackgroundColor(
      this.node.headingLevel,
      this.globalTheme,
      this.blockQuoteTheme,
      this.headingTheme,
      this.markdownHighlightParagraph,
      this.node.isQuote,
      this.node.nodeHash
    ))
    .padding({
      top: headingPaddingTop(
        this.node.headingLevel,
        this.headingTheme
      ),
      right: headingPaddingRight(
        this.node.headingLevel,
        this.headingTheme
      ),
      bottom: headingPaddingBottom(
        this.node.headingLevel,
        this.headingTheme
      ),
      left: headingPaddingLeft(
        this.node.headingLevel,
        this.headingTheme
      )
    })
    .margin({
      top: headingMarginTop(
        this.node.headingLevel,
        this.headingTheme
      ),
      right: headingMarginRight(
        this.node.headingLevel,
        this.headingTheme
      ),
      bottom: headingMarginBottom(
        this.node.headingLevel,
        this.headingTheme
      ),
      left: headingMarginLeft(
        this.node.headingLevel,
        this.headingTheme
      )
    }).transition(
      TransitionEffect.asymmetric(
        this.globalTheme.paragraphHeadingAnimationEnabled
          ? TransitionEffect.opacity(0).animation({ duration: this.globalTheme.paragraphHeadingAnimationDuration })
          : TransitionEffect.IDENTITY,
        TransitionEffect.IDENTITY
      )
    )
    .onAppear(() => {
      if (this.globalTheme.paragraphHeadingAnimationEnabled) {
        this.paragraphHeadingAnimationStart?.()
        setTimeout(() => {
          this.paragraphHeadingAnimationEnd?.()
        }, this.globalTheme.paragraphHeadingAnimationDuration)
      }
    })
  }

  /**
   * 标题Column
   * 注意：顶层ForEach直接引用this.list(@State)，不通过@Builder参数传递
   * 因为@Builder参数会创建本地副本，导致@State变化无法同步到ForEach
   */
  @Builder
  headingColumn() {
    Column() {
      if (!this.imageTheme.isImageMixedLayout
        && this.list.length === 1
        && (this.list[0].nodeType === "Image" || this.list[0].nodeType === "StyleImage" || this.list[0].nodeType === "ImageHtmlNode")) {
        MarkdownImageBlock({
          item: this.list[0],
          imageTheme: this.imageTheme,
          componentWidth: this.componentWidth,
          imageCallback: this.imageCallback,
          imageDownloadCallback: this.imageDownloadCallback,
          imageReplaceCallback: this.imageReplaceCallback
        })
      } else {
        Text(undefined, { controller: this.textController }) {
          ForEach(
            this.list,
            (item: NodeView, index: number) => {
              this.headingInlineItem(item, index)
            },
            (item: NodeView, index: number) => {
              this.updateTextContent(item) // 整理出当前所有的文本
              return `${index}-${item.nodeHash}-${item.contentHash}-${item.isEmphasis}-${item.isStrongEmphasis}-${item.isInLineCode}-${item.isStrikethrough}-${item.isHighlight}-${item.isUnderlineNode}-${item.isSubNode}-${item.isSupNode}-${item.imageWidth}-${item.imageHeight}-${item.latexImageWidth}-${item.latexImageHeight}-${item.latexPixelMap !== undefined}-${item.imageReplacePixelMap !== undefined}-${item.linkIconPixelMap !== undefined}-${item.linkIconType}-${item.linkIconWidth}-${item.linkIconHeight}-${this.linkTheme.linkCircleIconMargin}-${this.linkTheme.linkRectIconMargin}-${this.linkTheme.linkRectToolIconMargin}`
            }
          )
        }
        .textAlign(TextAlign.Start)
        .copyOption(
          this.globalTheme.isOnCopy ? CopyOptions.LocalDevice : CopyOptions.None
        )
        .onCopy((str) => {
          this.textCopyCallback?.(str)
        })
        .id(this.headingId)
        .onVisibleAreaChange([0.0, 0.01, 0.1, 0.25, 0.5, 0.75, 1.0], (_isVisible: boolean, _currentRatio: number) => {
          // 仅作触发用：ratio 阈值变化时重算曝光。不使用 isVisible 布尔门控可见性
          // （实测滑动中 isVisible 会翻转竞态，门控会导致漏报）。真正的可见性由
          // evaluateLinkExposure 的「链接rect ∩ 标题在屏可见视口」判定。
          // 未设曝光回调时直接返回，滚动期不再走 scheduleExposure（连 setTimeout 都不开）。
          if (!this.isExposureEnabled()) {
            return
          }
          this.scheduleExposure()
        })
        .onAreaChange((_old: Area, newArea: Area) => {
          // 标题Text自身宽度（vp→px）。全局位置由 componentUtils.getRectangleById 实时拿，
          // 故此处只更新宽度（水平方向链接截断用）并触发评估。未启用曝光时跳过。
          if (!this.isExposureEnabled()) {
            return
          }
          const w: number = (newArea.width as number) ?? 0
          this.headingWidthPx = vp2px(w)
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
                this.customLongPressCallback?.(this.textContent) // 调用用户自定义长按回调方法
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

      this.headingUnderline()
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .layoutWeight(1)
  }

  /**
   * 渲染单个内联节点（文本/代码/链接/加粗等）
   *
   * @param item 节点视图
   * @param index 索引
   */
  @Builder
  headingInlineItem(item: NodeView, index: number) {
    if ((item.nodeType === "Text" || item.nodeType === "Code" || item.nodeType === "Footnote") && (item.isSupNode || item.isSubNode)) {
      // 上下标：使用baselineOffset，不使用lineHeight（两者不能混用）
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
          false,
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
        .onClick(() => {
          if (item.footnoteID !== undefined) {
            this.footnoteCallback?.(item.footnoteID) // 脚注点击
            return
          }
          if (item.headLinkIndex !== undefined) {
            this.tocCallback?.(item.headLinkIndex) // TOC/标题ID点击
            return
          }
          if (item.linkUrl !== undefined) {
            this.linkCallback?.(item.linkUrl) // 链接点击
            return
          }
        })
    } else if (item.nodeType === "Text" || item.nodeType === "Code" || item.nodeType === "Footnote") {
      // 普通文本/内联代码/内联脚注：使用lineHeight，不使用baselineOffset
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
          false,
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
            this.footnoteCallback?.(item.footnoteID) // 脚注点击
            return
          }
          if (item.headLinkIndex !== undefined) {
            this.tocCallback?.(item.headLinkIndex) // TOC/标题ID点击
            return
          }
          if (item.linkUrl !== undefined) {
            this.linkCallback?.(item.linkUrl) // 链接点击
            return
          }
        })
    } else if (item.nodeType === "SoftLineBreak") {
      // 软换行
      Span(spanSoftLineBreak(this.globalTheme.isLineBreak))
    } else if (item.nodeType === "HardLineBreak") {
      // 硬换行
      Span("\n")
    } else if (item.nodeType === "Link" || item.nodeType === "HeadLink") {
      if ((item.isBulletList || item.isOrderedList || item.isQuote || item.isDescList) && this.isSingleLinkNode() && !this.linkTheme.linkListIsIcon) {
        Span(item.nodeText)
          .fontColor(this.linkTheme.linkTextFontColor)
          .fontSize(this.paragraphTheme.paragraphTextFontSize)
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
        .width(item.imageWidth ?? 0)
        .height(item.imageHeight ?? 0)
        .objectFit(this.imageTheme.imageFitType)
        .verticalAlign(ImageSpanAlignment.CENTER)
        .constraintSize({ maxWidth: this.imageTheme.imageMaxWidth ?? '100%', maxHeight: this.imageTheme.imageMaxHeight})
        .onClick(()=>{
          if(item.isLink){
            this.linkCallback?.(item.linkUrl ?? "")
          }else{
            this.imageCallback?.(item.imageUrl ?? "")
          }
        })
        .onComplete((imageLoadResult) => {
          if (imageLoadResult === undefined || imageLoadResult === null) {
            return
          }
          item.imageNaturalWidth = imageLoadResult.width
          item.imageNaturalHeight = imageLoadResult.height
          const effectiveWidth: number = this.componentWidth > 0
            ? this.componentWidth
            : px2vp(imageLoadResult.width)
          const l = imageWidthAndHeight(
            effectiveWidth,
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
          if (l[0] > 0 && l[1] > 0) {
            item.imageWidth = px2vp(l[0])
            item.imageHeight = px2vp(l[1])
            if (this.list.indexOf(item) >= 0) {
              this.list = [...this.list]
            }
          }
        })
      }
    } else if (item.nodeType === "LatexMathNode") {
      // 数学公式行内 - 和图片一样直接用ImageSpan
      if (this.isLatexMathEnabled && item.latexPixelMap !== undefined && item.latexImageWidth > 0 && item.latexImageHeight > 0) {
        ImageSpan(item.latexPixelMap)
          .height(this.latexMathTheme.latexMathTextSize)
          .width((item.latexImageWidth / item.latexImageHeight) * this.latexMathTheme.latexMathTextSize)
          .verticalAlign(ImageSpanAlignment.CENTER)
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
   * 一级二级标题是否显示下划线
   */
  @Builder
  headingUnderline() {
    if (this.node.headingLevel === 1) {
      Divider()
        .color(this.headingTheme.heading1UnderlineColor)
        .strokeWidth(this.headingTheme.heading1UnderlineHeight)
        .margin({ top: this.headingTheme.heading1UnderlineSpacing })
    } else if (this.node.headingLevel === 2) {
      Divider()
        .color(this.headingTheme.heading2UnderlineColor)
        .strokeWidth(this.headingTheme.heading2UnderlineHeight)
        .margin({ top: this.headingTheme.heading2UnderlineSpacing })
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
   * 防抖触发曝光评估。合并连续的 onAreaChange/onVisibleAreaChange/refreshData 触发。
   * 评估后对「本次显示」的链接回调 visible=true，「本次消失」的回调 visible=false。
   *
   * 视口来源：componentUtils.getRectangleById(headingId) 拿标题相对窗口的全局 rect（px），
   * 与屏幕高度求交得标题在屏可见区，再平移到 Text 内容区原点坐标系（与 getRectsForRange 同源）。
   * 首屏在屏内的标题也能被覆盖：onAreaChange 首帧触发 → scheduleExposure → getRectangleById 拿到位置。
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
    // config 同步后 holder 通知/事件触发本方法，此处 httpLinks 仍为脏（dirty=true）。检测到 dirty 则补算一次（标题无脚注前缀），
    // 算完置 clean，避免无链接标题每次 scheduleExposure 都重算。
    if (this.httpLinksDirty && this.list.length > 0) {
      this.httpLinks = computeLinkRanges(this.list, this.globalTheme.isLineBreak, 0)
      this.httpLinksDirty = false
    }
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
      // 标题相对窗口的全局矩形（px）：componentUtils 同步调用，setTimeout(0) 时已 layout 完成
      let globalTop: number = 0
      let globalBottom: number = 0
      try {
        const info = componentUtils.getRectangleById(this.headingId)
        // windowOffset 相对应用窗口原点；size 是组件尺寸。均为 px。
        globalTop = info.windowOffset.y
        globalBottom = info.windowOffset.y + info.size.height
      } catch (e) {
        // 组件未挂载/id 未就绪，本次跳过
        return
      }
      // 标题在屏可见视口（相对Text内容区原点，px）：
      // 垂直裁剪窗口 = holder 推算的可见区域 [visTop, visBottom]（窗口 px，见 MarkdownVisibleRectHolder 算法）：
      //   onAreaChange 拿矩形区域，onVisibleAreaChange 拿 ratio，每 50ms 按「移动方向 + ratio 变化」收缩可见区域。
      // 标题Text不横滚，水平方向整宽可见：clipLeftPx=0, clipRightPx=widthPx
      // holder.visReady=false（ratio 首次>0 前）退化用整屏 [0, screenH]，避免漏报。
      const useVis: boolean = this.visibleRectHolder.visReady
      const vpTop: number = useVis ? this.visibleRectHolder.visTop : 0
      const vpBottom: number = useVis ? this.visibleRectHolder.visBottom : this.screenHeightPx
      const clipTopPx: number = Math.max(vpTop, Math.min(vpBottom, globalTop))
      const clipBottomPx: number = Math.min(vpBottom, Math.max(vpTop, globalBottom))
      const viewport: ParagraphViewport = {
        ready: clipBottomPx > clipTopPx && this.headingWidthPx > 0,
        clipTopPx: clipTopPx - globalTop,
        clipBottomPx: clipBottomPx - globalTop,
        clipLeftPx: 0,
        clipRightPx: this.headingWidthPx,
        widthPx: this.headingWidthPx
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
    const oldImageNaturalSizes: Map<string, number[]> = new Map()
    const oldImageStyles: Map<string, string> = new Map()
    for (const oldChild of this.list) {
      if (oldChild.imageUrl !== undefined) {
        if (oldChild.imageWidth !== undefined && oldChild.imageWidth > 0 && oldChild.imageHeight !== undefined) {
          oldImageSizes.set(oldChild.imageUrl, [oldChild.imageWidth, oldChild.imageHeight])
        }
        if (oldChild.imageNaturalWidth !== undefined && oldChild.imageNaturalHeight !== undefined) {
          oldImageNaturalSizes.set(oldChild.imageUrl, [oldChild.imageNaturalWidth, oldChild.imageNaturalHeight])
        }
        oldImageStyles.set(oldChild.imageUrl,
          `${oldChild.imageStyleWidth ?? ''}|${oldChild.imageStyleHeight ?? ''}|${oldChild.imageRadius ?? ''}`)
      }
    }
    for (const newChild of children) {
      if (newChild.imageUrl !== undefined) {
        const oldNaturalSize = oldImageNaturalSizes.get(newChild.imageUrl)
        if (oldNaturalSize) {
          newChild.imageNaturalWidth = oldNaturalSize[0]
          newChild.imageNaturalHeight = oldNaturalSize[1]
        }
        const oldStyleKey = oldImageStyles.get(newChild.imageUrl)
        const newStyleKey = `${newChild.imageStyleWidth ?? ''}|${newChild.imageStyleHeight ?? ''}|${newChild.imageRadius ?? ''}`
        if (oldStyleKey === newStyleKey) {
          const oldSize = oldImageSizes.get(newChild.imageUrl)
          if (oldSize) {
            newChild.imageWidth = oldSize[0]
            newChild.imageHeight = oldSize[1]
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
      // 标题无脚注前缀，footnotePrefixLen=0；computeLinkRanges 与 headingInlineItem 渲染顺序一致
      this.httpLinks = computeLinkRanges(this.list, this.globalTheme.isLineBreak, 0)
      this.httpLinksDirty = false
      this.scheduleExposure()
    }
  }

  /**
   * 数学公式异步加载入队（从onListChanged提取，refreshData直接调用，不依赖@Watch链）
   * task 返回 Promise<void>：LatexParseQueue.processNext 会自动挂 .then/.catch，
   * 即便 task 内部 promise 链丢 rejection 也能兜底推进队列，避免永久卡死。
   */
  private tryEnqueueLatexLoading(): void {
    if (!this.isLatexMathEnabled) {
      return
    }
    for (const child of this.list) {
      if (child.nodeType === "LatexMathNode" && !child.latexIsLoading && child.latexPixelMap === undefined) {
        child.latexIsLoading = true
        LatexParseQueue.enqueue((): Promise<void> => {
          if (this.isAlive) {
            return this.loadLatexImage(child)
          } else {
            child.latexIsLoading = false
            return Promise.resolve()
          }
        })
      }
    }
  }

  /**
   * list变化时触发数学公式异步加载（从refreshData移出，避免每次流式输出都跑for循环）
   */
  onListChanged() {
    this.tryReplaceImages()
    this.tryGenerateLinkIcons()
    this.tryEnqueueLatexLoading()
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
    for (const child of this.list) {
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
            if (this.list.indexOf(child) < 0) {
              result.pixelMap.release()
              return
            }
            // 流式输出中文本可能已变化，检查是否仍是生成时的文本
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
            console.error('Heading linkIcon generation failed')
          })
      }
    }
  }

  /**
   * 异步替换图片：调用imageReplaceCallback获取原始字节→转为PixelMap→更新ImageSpan渲染
   */
  private tryReplaceImages(): void {
    if (this.imageReplaceCallback === undefined) {
      return
    }
    for (const child of this.list) {
      if (child.imageUrl !== undefined && !child.imageReplaceTried) {
        child.imageReplaceTried = true
        this.imageReplaceCallback(child.imageUrl).then((buffer: ArrayBuffer | undefined) => {
          if (!this.isAlive || buffer === undefined) {
            return
          }
          if (this.list.indexOf(child) < 0) {
            return
          }
          const imageSource: image.ImageSource = image.createImageSource(buffer)
          imageSource.createPixelMap().then((pm: PixelMap) => {
            imageSource.release()
            if (!this.isAlive || this.list.indexOf(child) < 0) {
              pm.release()
              return
            }
            child.imageReplacePixelMap = pm
            this.list = [...this.list]
          }).catch(() => {
            imageSource.release()
          })
        }).catch(() => {
          console.error('Heading imageReplace failed')
        })
      }
    }
  }

  /**
   * 异步加载数学公式图片
   * 流式输出时latex文本可能增长，需捕获调用时的文本，回调中校验是否已过期，
   * 避免旧文本的图片覆盖新状态（旧图片闪烁/内存泄漏）。
   * 返回 Promise<void>：让 processNext 自动接管 .then/.catch，确保任何异步 rejection 都能推进队列。
   *
   * @param item 节点视图
   */
  private loadLatexImage(item: NodeView): Promise<void> {
    const capturedNodeText: string = item.nodeText
    const strLatexMath: string = this.latexStrCallback(capturedNodeText)
    const textSize: number = vp2px(this.latexMathTheme.latexMathTextSize)
    const textColor: number = resourceColorToNumber(this.latexMathTheme.latexMathTextColor)
    const bgColor: number = resourceColorToNumber(this.latexMathTheme.latexMathBackgroundColor)
    const colorFormat: LatexMathColorFormat = this.latexMathTheme.latexMathColorFormat === 0
      ? LatexMathColorFormat.COLOR_FORMAT_RGB_565
      : LatexMathColorFormat.COLOR_FORMAT_BGRA_8888
    const resPath: string | undefined = this.latexMathTheme.latexMathResPath

    return latexStringToImage(strLatexMath, textSize, textColor, bgColor, colorFormat, resPath)
      .then((buffer: ArrayBuffer) => {
        if (!this.isAlive) {
          item.latexIsLoading = false
          LatexParseQueue.notifyDone()
          return
        }
        const imageSource: image.ImageSource = image.createImageSource(buffer)
        return imageSource.createPixelMap().then((pm: PixelMap) => {
          try {
            imageSource.release()
          } catch (e) {
            console.error('Heading ImageSource release failed: ' + (e instanceof Error ? e.stack : String(e)))
          }
          if (!this.isAlive) {
            try {
              pm.release()
            } catch (e) {
              console.error('Heading PixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
            }
            item.latexIsLoading = false
            LatexParseQueue.notifyDone()
            return
          }
          return pm.getImageInfo().then((info: image.ImageInfo) => {
            if (!this.isAlive) {
              try {
                pm.release()
              } catch (e) {
                console.error('Heading PixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
              }
              item.latexIsLoading = false
              LatexParseQueue.notifyDone()
              return
            }
            // 流式输出中文本可能已变化，丢弃过期结果
            // 重新触发onListChanged检查是否需要为新文本重新入队加载
            if (item.nodeText !== capturedNodeText) {
              try {
                pm.release()
              } catch (e) {
                console.error('Heading PixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
              }
              LatexParseQueue.notifyDone()
              this.list = [...this.list]
              return
            }
            // 释放旧PixelMap（防御性：理论上此处应为undefined）
            if (item.latexPixelMap !== undefined) {
              try {
                item.latexPixelMap.release()
              } catch (e) {
                console.error('Heading latexPixelMap release failed: ' + (e instanceof Error ? e.stack : String(e)))
              }
            }
            item.latexPixelMap = pm
            item.latexImageData = buffer
            item.latexImageWidth = info.size.width
            item.latexImageHeight = info.size.height
            item.latexIsLoading = false
            this.list = [...this.list]
            LatexParseQueue.notifyDone()
          }).catch((e: Error) => {
            console.error('Heading loadLatexImage getImageInfo failed: '
              + (e instanceof Error ? e.stack : String(e)))
            try {
              pm.release()
            } catch (err) {
              console.error('Heading PixelMap release failed: ' + (err instanceof Error ? err.stack : String(err)))
            }
            // 仅当文本未变化时才重置loading，避免覆盖新一轮加载的loading状态
            if (item.nodeText === capturedNodeText) {
              item.latexIsLoading = false
            }
            LatexParseQueue.notifyDone()
          })
        }).catch((e: Error) => {
          console.error('Heading loadLatexImage createPixelMap failed: '
            + (e instanceof Error ? e.stack : String(e)))
          try {
            imageSource.release()
          } catch (err) {
            console.error('Heading ImageSource release failed: ' + (err instanceof Error ? err.stack : String(err)))
          }
          if (item.nodeText === capturedNodeText) {
            item.latexIsLoading = false
          }
          LatexParseQueue.notifyDone()
        })
      })
      .catch((e: Error) => {
        console.error('Heading loadLatexImage latexStringToImage failed: '
          + (e instanceof Error ? e.stack : String(e)))
        if (item.nodeText === capturedNodeText) {
          item.latexIsLoading = false
        }
        LatexParseQueue.notifyDone()
      })
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
