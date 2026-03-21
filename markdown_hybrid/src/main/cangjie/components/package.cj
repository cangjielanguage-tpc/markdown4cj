/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

// 标准库
internal import std.collection.ArrayList
internal import std.collection.HashMap
internal import std.collection.HashSet
internal import std.convert.Formattable
internal import std.convert.Parsable
internal import std.regex.Regex
internal import std.regex.MatchData
internal import std.sync.Mutex
internal import std.sync.Semaphore
internal import std.sync.SyncCounter
internal import std.sync.AtomicBool

// stdx
internal import stdx.encoding.base64.fromBase64String
internal import stdx.encoding.url.URL

// 内部其他包
internal import markdown.core.*
internal import markdown.plugin.*
internal import markdown.texttoimg4cj.*

// codeformat
internal import codeformat.codeFormat
internal import codeformat.FormatConfig

// commonmark
internal import commonmark4cj.commonmark.IndentedCodeBlock
internal import commonmark4cj.commonmark.FencedCodeBlock
internal import commonmark4cj.commonmark.Heading
internal import commonmark4cj.commonmark.Code
internal import commonmark4cj.commonmark.Text as CommonmarkText
internal import commonmark4cj.commonmark.Image as CommonmarkImage
internal import commonmark4cj.commonmark.Link as CommonmarkLink
internal import commonmark4cj.commonmark.Node as CommonmarkNode
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
internal import ohos.base.*
internal import ohos.component.*
internal import ohos.state_manage.*
internal import ohos.device_info.DeviceInfo
internal import ohos.ability.*
internal import ohos.image.PixelMap
internal import ohos.image.Size
internal import ohos.image.createImageSource
internal import ohos.image.ImageSource
internal import ohos.display.*
internal import ohos.concurrency.*
internal import ohos.resource_manager.ResourceManager

// 互操作
internal import ohos.ark_interop_helper.*
internal import ohos.ark_interop.*

// kit
internal import kit.LocalizationKit.*
