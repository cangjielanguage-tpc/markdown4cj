package ohos_app_cangjie_entry

// 标准库
internal import std.collection.ArrayList

// 内部其他包
internal import markdown.components.*
internal import markdown.components.theme.*
internal import markdown.core.Markdown
internal import markdown.plugin.BlockAudioPlugin
internal import markdown.plugin.BlockVideoPlugin
internal import markdown.plugin.CodeListPlugin
internal import markdown.plugin.DescListPlugin
internal import markdown.plugin.emoji.EmojiPlugin
internal import markdown.plugin.FootnotePlugin
internal import markdown.plugin.HighlightDelimeterPlugin
internal import markdown.plugin.HtmlPlugin
internal import markdown.plugin.IdHeadingPlugin
internal import markdown.plugin.ImageCollectPlugin
internal import markdown.plugin.ImageSlidePlugin
internal import markdown.plugin.ImageStylePlugin
internal import markdown.plugin.LatexMathPluginV2
internal import markdown.plugin.LinkifyPlugin
internal import markdown.plugin.NodeIdPlugin
internal import markdown.plugin.NodeViewStringBuilder
internal import markdown.plugin.StrikethroughPlugin
internal import markdown.plugin.SubPlugin
internal import markdown.plugin.SupPlugin
internal import markdown.plugin.TablePlugin
internal import markdown.plugin.TaskListPlugin
internal import markdown.plugin.TocPlugin
internal import markdown.plugin.ImageTextMixPlugin

// 系统UI
internal import ohos.base.*
internal import ohos.component.*
internal import ohos.concurrency.launch
internal import ohos.hilog.*
internal import ohos.state_manage.*
internal import ohos.state_manage.ObservedArrayList

// 互操作
internal import ohos.ark_interop.*
internal import ohos.ark_interop_helper.*

// kit
internal import kit.LocalizationKit.AppResource
