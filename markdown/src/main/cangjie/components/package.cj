package markdown.components

// 标准库
internal import std.collection.ArrayList
internal import std.collection.HashMap
internal import std.collection.HashSet
internal import std.convert.Formattable
internal import std.convert.Parsable
internal import std.regex.MatchData
internal import std.regex.Regex
internal import std.sync.AtomicBool
internal import std.sync.Mutex
internal import std.sync.Semaphore
internal import std.sync.SyncCounter
internal import std.sync.Timer
internal import std.math.ceil
internal import std.math.floor

// stdx
internal import stdx.encoding.base64.fromBase64String
internal import stdx.encoding.url.URL

// 内部其他包
internal import markdown.texttoimg4cj.*
internal import markdown.components.theme.*

// markdown_parser
// 不用通配导入：markdown_parser.core/plugin 通过 public import 重导出了 commonmark，
// 其中 Text/Image/Alignment/ListItem 会与 ohos.component 同名类型产生歧义，故逐项显式导入
internal import markdown_parser.core.*
internal import markdown_parser.plugin.*

// codeformat
internal import codeformat.codeFormat
internal import codeformat.FormatConfig

// commonmark
internal import commonmark4cj.commonmark.Document
internal import commonmark4cj.commonmark.IndentedCodeBlock
internal import commonmark4cj.commonmark.FencedCodeBlock
internal import commonmark4cj.commonmark.Heading
internal import commonmark4cj.commonmark.Paragraph
internal import commonmark4cj.commonmark.BlockQuote
internal import commonmark4cj.commonmark.BulletList
internal import commonmark4cj.commonmark.OrderedList
internal import commonmark4cj.commonmark.ListItem as CommonmarkListItem
internal import commonmark4cj.commonmark.ThematicBreak
internal import commonmark4cj.commonmark.SoftLineBreak
internal import commonmark4cj.commonmark.HardLineBreak
internal import commonmark4cj.commonmark.Code
internal import commonmark4cj.commonmark.Text as CommonmarkText
internal import commonmark4cj.commonmark.HtmlBlock
internal import commonmark4cj.commonmark.Image as CommonmarkImage
internal import commonmark4cj.commonmark.Link as CommonmarkLink
internal import commonmark4cj.commonmark.Node as CommonmarkNode
internal import commonmark4cj.commonmark.StrongEmphasis
internal import commonmark4cj.commonmark.Emphasis
internal import commonmark4cj.strikethrough.Strikethrough
internal import commonmark4cj.table.TableBlock
internal import commonmark4cj.table.TableRow
internal import commonmark4cj.table.TableHead
internal import commonmark4cj.table.TableCell
internal import commonmark4cj.table.TableBody
internal import commonmark4cj.table.Alignment as TableAlignment

// prism
internal import prism4cj.GrammarLocatorGrammarUtils
internal import prism4cj.prism.Prism
internal import prism4cj.prism.Syntax
internal import prism4cj.prism.Text as PrismText
internal import prism4cj.prism.Node as PrismNode
internal import prism4cj.prism.Grammar as PrismGrammar

// formula
internal import formula.LaTeX
internal import formula.Render
internal import formula.Graphic2D
internal import formula.ColorFormat

// 系统UI
internal import ohos.ability.UIAbilityContext
internal import ohos.ability.getStageContext
internal import ohos.base.*
internal import ohos.component.CustomView
internal import ohos.component.IDataSource
internal import ohos.component.SwiperController
internal import ohos.component.ViewBuilder
internal import ohos.component.ReuseParams
internal import ohos.component.DataChangeListener
internal import ohos.component.Scroller
internal import ohos.component.TouchEvent
internal import ohos.component.ClickEvent
internal import ohos.component.HorizontalAlign
internal import ohos.component.Text
internal import ohos.component.Span
internal import ohos.component.ImageSpan
internal import ohos.component.Column
internal import ohos.component.TextDecorationType
internal import ohos.component.ImageFit
internal import ohos.component.ListItem
internal import ohos.component.List
internal import ohos.component.StickyStyle
internal import ohos.component.ListItemGroup
internal import ohos.component.ListItemGroupParams
internal import ohos.component.ScrollState
internal import ohos.component.Alignment
internal import ohos.component.FontWeight
internal import ohos.component.TextAlign
internal import ohos.component.Visibility
internal import ohos.component.FontStyle
internal import ohos.component.LegalCallCheck
internal import ohos.component.FakeComponent
internal import ohos.component.Row
internal import ohos.component.Blank
internal import ohos.component.Swiper
internal import ohos.component.Image
internal import ohos.component.If
internal import ohos.component.ForEach
internal import ohos.component.TextOverflow
internal import ohos.component.FlexAlign
internal import ohos.component.__Recycle__
internal import ohos.component.ImageSpanAlignment
internal import ohos.component.Checkbox
internal import ohos.component.Scroll
internal import ohos.component.VerticalAlign
internal import ohos.component.EdgeWidths
internal import ohos.component.LazyForEach
internal import ohos.component.CheckBoxShape
internal import ohos.component.ScrollDirection
internal import ohos.component.BorderStyle
internal import ohos.component.BarState
internal import ohos.component.Edge
internal import ohos.component.TouchType
internal import ohos.component.ListItemAlign
internal import ohos.component.EdgeEffect
internal import ohos.component.vp2px
internal import ohos.component.px2vp
internal import ohos.component.fp2px
internal import ohos.component.Axis
internal import ohos.component.NestedScrollOptions
internal import ohos.component.NestedScrollMode
internal import ohos.component_utils.ComponentUtils
internal import ohos.component.ItemAlign
internal import ohos.component.Stack
internal import ohos.component.Divider
internal import ohos.component.CopyOptions
internal import ohos.component.TextBackgroundStyle
internal import ohos.component.BorderRadiuses
internal import ohos.component.TransitionEffect
internal import ohos.component.AnimateParam
internal import ohos.component.Curve
internal import ohos.component.bind
internal import ohos.component.TextSpanType
internal import ohos.component.TextResponseType
internal import ohos.component.GestureEvent
internal import kit.UIKit.LongPressGesture
internal import kit.UIKit.Measure
internal import kit.UIKit.MeasureOptions
internal import ohos.concurrency.launch
internal import ohos.prompt_action.PromptAction
internal import ohos.pasteboard.createData
internal import ohos.pasteboard.getSystemPasteboard
internal import ohos.pasteboard.MIMETYPE_TEXT_PLAIN
internal import ohos.device_info.DeviceInfo
internal import ohos.display.getDefaultDisplaySync
internal import ohos.image.ImageSource
internal import ohos.image.PixelMap
internal import ohos.image.Size
internal import ohos.image.createImageSource
internal import ohos.resource_manager.ResourceManager
internal import ohos.resource_manager.AppResource
internal import ohos.resource_manager.__GenerateResource__
internal import ohos.state_manage.ObservedObject
internal import ohos.state_manage.ObservedProperty
internal import ohos.state_manage.LocalStorage
internal import ohos.state_manage.ObservedArrayList
internal import ohos.state_manage.ObservedComplexAbstract
internal import ohos.state_manage.ViewStackProcessor
internal import ohos.state_manage.SubscriberManager

// 互操作
internal import ohos.ark_interop_helper.*
internal import ohos.ark_interop.*

// kit
internal import kit.LocalizationKit.AppResource
