import { JsNode, JsNodeSendableImpl, Options, parseIntoJsNode } from "@cangjie-tpc/commonmark_hybrid"
import { MarkdownDataSource } from "../datasorce/MarkdownDataSource"
import { MarkdownHeading } from "./MarkdownHeading"
import { MarkdownConfiguration } from '../configs/MarkdownConfiguration'
import { NodeView } from "../model/NodeView"
import { nodeToNodeView } from "../utils/MarkdownParserUtils"
import { MarkdownParagraph } from "./MarkdownParagraph"
import { MarkdownThematicBreak } from "./MarkdownThematicBreak"
import { image } from "@kit.ImageKit"

@Component
export struct CJMarkdown {
  @Prop @Watch('refreshData') content: string // 外部传入的Markdown文档
  @ObjectLink config: MarkdownConfiguration // markdown配置项
  @Provide placeholderPixelMap: PixelMap | undefined = undefined // 图片占位图
  @State componentWidth: number = 0.0 // markdown控件宽度
  scroller: Scroller = new Scroller() // list控制器
  markdownDataSource: MarkdownDataSource = new MarkdownDataSource([]) // markdown页面数据源
  private parseVersion: number = 0 // 解析版本号，每次解析递增
  private appliedVersion: number = 0 // 已应用的版本号，用于渐进式更新（避免丢弃所有中间结果）

  aboutToAppear(): void {
    this.refreshData() // 首次加载
    this.loadPlaceholderImage()
  }

  build() {
    List({
      scroller: this.scroller,
      space: this.config.markdownTheme.globalTheme.markdownBlockSpacing
    }) {
      LazyForEach(
        this.markdownDataSource,
        (item: NodeView, index: number) => {
          ListItem() {
            if (item.nodeType == "Heading" || item.nodeType == "IdHeading") {
              // 标题
              MarkdownHeading({
                node: item,
                headingTheme: this.config.markdownTheme.headingTheme,
                globalTheme: this.config.markdownTheme.globalTheme,
                subTheme: this.config.markdownTheme.subTheme,
                supTheme: this.config.markdownTheme.supTheme,
                inlineCodeTheme: this.config.markdownTheme.inlineCodeTheme,
                boldTheme: this.config.markdownTheme.boldTheme,
                italicTheme: this.config.markdownTheme.italicTheme,
                strikethroughTheme: this.config.markdownTheme.strikethroughTheme,
                highlightTheme: this.config.markdownTheme.highlightTheme,
                htmlUnderlineTheme: this.config.markdownTheme.htmlUnderlineTheme,
                linkTheme: this.config.markdownTheme.linkTheme,
                footnoteRefTheme: this.config.markdownTheme.footnoteRefTheme,
                tableTheme: this.config.markdownTheme.tableTheme,
                paragraphTheme: this.config.markdownTheme.paragraphTheme,
                blockQuoteTheme: this.config.markdownTheme.blockQuoteTheme,
                definitionListTheme: this.config.markdownTheme.definitionListTheme,
                imageTheme: this.config.markdownTheme.imageTheme,
                componentWidth: this.componentWidth
              })
            } else if (item.nodeType == "Paragraph") {
              // 段落
              MarkdownParagraph({
                node: item,
                headingTheme: this.config.markdownTheme.headingTheme,
                globalTheme: this.config.markdownTheme.globalTheme,
                subTheme: this.config.markdownTheme.subTheme,
                supTheme: this.config.markdownTheme.supTheme,
                inlineCodeTheme: this.config.markdownTheme.inlineCodeTheme,
                boldTheme: this.config.markdownTheme.boldTheme,
                italicTheme: this.config.markdownTheme.italicTheme,
                strikethroughTheme: this.config.markdownTheme.strikethroughTheme,
                highlightTheme: this.config.markdownTheme.highlightTheme,
                htmlUnderlineTheme: this.config.markdownTheme.htmlUnderlineTheme,
                linkTheme: this.config.markdownTheme.linkTheme,
                footnoteRefTheme: this.config.markdownTheme.footnoteRefTheme,
                tableTheme: this.config.markdownTheme.tableTheme,
                paragraphTheme: this.config.markdownTheme.paragraphTheme,
                blockQuoteTheme: this.config.markdownTheme.blockQuoteTheme,
                definitionListTheme: this.config.markdownTheme.definitionListTheme,
                imageTheme: this.config.markdownTheme.imageTheme,
                componentWidth: this.componentWidth
              })
            } else if (item.nodeType == "ThematicBreak") {
              MarkdownThematicBreak({
                dividerTheme: this.config.markdownTheme.dividerTheme
              })
            }
          }
        },
        (item: NodeView, index: number) => {
          // 稳定key：仅用index+nodeType，不包含内容指纹
          // 内容更新通过就地修改NodeView属性+@ObjectLink的@Watch实现，避免组件重建
          // 仅当nodeType变化（如Paragraph→Heading）时key才变化，触发组件重建
          return `${index}-${item.nodeType}`
        }
      )
    }
    .margin(
      {
        top: this.config.markdownTheme.globalTheme.blockMarginTop,
        right: this.config.markdownTheme.globalTheme.blockMarginRight,
        bottom: this.config.markdownTheme.globalTheme.blockMarginBottom,
        left: this.config.markdownTheme.globalTheme.blockMarginLeft
      }
    )
    .backgroundColor(this.config.markdownTheme.globalTheme.backgroundColor)
    .listDirection(Axis.Vertical)
    .alignListItem(ListItemAlign.Start)
    .scrollBar(BarState.Off)
    .enableScrollInteraction(this.config.markdownTheme.globalTheme.openGestureSwipe)
    .onSizeChange((oldValue, newValue) => {
      let newWidth: number = 0
      if (typeof newValue.width === 'number') {
        newWidth = newValue.width
      }
      if (this.componentWidth != newWidth) {
        this.componentWidth = newWidth
      }
    })
  }

  /**
   * 刷新数据
   */
  refreshData() {
    if (this.config.markdownTheme.globalTheme.isMarkdownParserSync) {
      this.refreshSyncData()
    } else {
      this.refreshAsyncData()
    }
  }

  /**
   * 异步触发解析数据（不等待结果）
   */
  refreshAsyncData(): void {
    this.parseVersion++ // 版本号递增
    const currentVersion = this.parseVersion
    let op: Options = {
      jsNodeFactory: () => {
        return new JsNodeSendableImpl()
      },
      includeSourceSpans: 2,
      cmInlineTags: [],
      customParsers: undefined
    }
    let promise: Promise<JsNode> = parseIntoJsNode(this.content, op)
    promise.then((node: JsNode) => {
      // 渐进式版本追踪：仅丢弃比已应用版本更旧的结果，保留比已应用版本更新的结果
      // 避免strictVersionTracking导致所有中间结果被丢弃、UI卡在旧状态
      if (currentVersion <= this.appliedVersion) {
        return
      }
      let nodeView: NodeView = new NodeView()
      nodeToNodeView(node, nodeView, nodeView)
      if (nodeView.children.length == 0) {
        this.markdownDataSource.clear()
        this.appliedVersion = currentVersion
        return
      }
      this.markdownDataSource.smartUpdateDataArray(nodeView.children)
      this.appliedVersion = currentVersion
    })
  }

  /**
   * 异步解析数据（可等待）
   */
  async refreshSyncData(): Promise<void> {
    this.parseVersion++ // 版本号递增
    const currentVersion = this.parseVersion
    let op: Options = {
      jsNodeFactory: () => {
        return new JsNodeSendableImpl()
      },
      includeSourceSpans: 2,
      cmInlineTags: [],
      customParsers: undefined
    }
    let node: JsNode = await parseIntoJsNode(this.content, op)
    // 渐进式版本追踪：仅丢弃比已应用版本更旧的结果
    if (currentVersion <= this.appliedVersion) {
      return
    }
    let nodeView: NodeView = new NodeView()
    nodeToNodeView(node, nodeView, nodeView)
    if (nodeView.children.length == 0) {
      this.markdownDataSource.clear()
      this.appliedVersion = currentVersion
      return
    }
    this.markdownDataSource.smartUpdateDataArray(nodeView.children)
    this.appliedVersion = currentVersion
  }

  /**
   * 异步处理图片占位图（可等待）
   */
  async loadPlaceholderImage(): Promise<void> {
    if(this.config.markdownTheme.imageTheme.imagePlaceholder !== undefined){
      const hostContext = this.getUIContext().getHostContext()
      if (hostContext !== undefined) {
        const resourceMgr = hostContext.resourceManager
        const fileData = await resourceMgr.getMediaContent(this.config.markdownTheme.imageTheme.imagePlaceholder)
        const imageSource = image.createImageSource(fileData.buffer)
        this.placeholderPixelMap = await imageSource.createPixelMap()
      }
    }
  }
}
