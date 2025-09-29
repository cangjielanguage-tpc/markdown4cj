/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.ark_interop.*
import ohos.ark_interop_helper.*
import ohos.ark_interop_macro.*
import std.collection.*

@Interop[ArkTS]
public class CJMarkdownConfig {
    /**
     * 链接的点击事件
     */
    var linkCallback: ?(String) -> Unit = None

    /**
     * 图片的点击事件
     */
    var imageCallback: ?(String, ArrayList<String>) -> Unit = None

    /**
     * 图片替换事件
     */
    var imageCallbackCallback: ?(String) -> ?Array<UInt8> = None

    /**
     * 音频的点击事件
     */
    var audioCallback: ?(String) -> Unit = None

    /**
     * 视频的点击事件
     */
    var videoCallback: ?(String, ArrayList<String>) -> Unit = None

    /**
     * 视频的图片替换回调
     */
    var videoImageCallback: ?(String, (String, Float64, Int64) -> Unit) -> Unit = None

    /**
     * 代码复制按钮的点击事件
     */
    var codeCopyCallback: ?(String) -> Unit = None

    /**
     * 代码全屏按钮的点击事件
     */
    var codeFullScreenCallback: ?(String, Option<String>) -> Unit = None

    /**
     * 数学公式图片点击事件
     */
    var latexImageCallback: ?(Array<UInt8>, Length, Length) -> Unit = None

    /**
     * 数学公式数据处理事件
     */
    var latexStrCallback: ?(String) -> String = None

    /**
     * TOC跳转指定位置
     */
    var tocIndexCallback: ?(Option<Float64>) -> Unit = None

    /**
     * 脚注跳转指定位置
     */
    var footnoteCallback: ?(Option<Float64>) -> Unit = None

    /**
     * markdown默认样式
     */
    var cjMarkdownTheme: CJMarkdownTheme = CJMarkdownTheme()

    public init() {}

    /**
     * 设置链接的点击事件
     *
     * @param cb 链接点击回调接口 (链接url)
     */
    public func setLinkCallback(cb: (String) -> Unit): Unit {
        this.linkCallback = cb
    }

    /**
     * 设置图片的点击事件
     *
     * @param cb 图片点击回调接口 (图片url，图片和视频url列表)
     */
    public func setImageCallback(cb: (String, JSArrayEx<String>) -> Unit): Unit {
        this.imageCallback = {
            url, list => cb(url, JSArrayEx<String>(list.toArray()))
        }
    }

    /**
     * 设置图片预处理事件
     *
     * @param cb 图片预处理回调接口 (图片url -> 处理后的图片数据)
     */
    public func setImageCallbackCallback(cb: (String) -> Option<JSArrayEx<UInt8>>): Unit {
        this.imageCallbackCallback = {
            url =>
                let a = cb(url)
                if(a.isSome()){
                    a.getOrThrow().toArray()
                }else{
                    Option<Array<UInt8>>.None
                }
        }
    }

    /**
     * 设置音频的点击事件
     *
     * @param cb 音频点击回调接口 (音频url)
     */
    public func setAudioCallback(cb: (String) -> Unit): Unit {
        this.audioCallback = cb
    }

    /**
     * 设置视频的点击事件
     *
     * @param cb 视频点击回调接口 (视频url，图片和视频url列表)
     */
    public func setVideoCallback(cb: (String, JSArrayEx<String>) -> Unit): Unit {
        this.videoCallback = {
            url, list => cb(url, JSArrayEx<String>(list.toArray()))
        }
    }

    /**
     * 设置视频的图片替换回调
     *
     * @param cb 视频的图片替换回调接口 - (视频url，(视频首帧图片url，图片宽高比，视频时长))
     */
    public func setVideoImageCallback(cb: (String, (String, Float64, Int64) -> Unit) -> Unit): Unit {
        this.videoImageCallback = cb
    }

    /**
     * 设置代码复制按钮的点击事件
     *
     * @param cb 代码复制点击回调接口 (代码内容)
     */
    public func setCodeCopyCallback(cb: (String) -> Unit): Unit {
        this.codeCopyCallback = cb
    }

    /**
     * 设置代码全屏按钮的点击事件
     *
     * @param cb 代码全屏点击回调接口 (代码内容，代码类型)
     */
    public func setCodeFullScreenCallback(cb: (String, Option<String>) -> Unit): Unit {
        this.codeFullScreenCallback = cb
    }

    /**
     * 设置数学公式图片点击事件
     *
     * @param cb 数学公式图片点击回调接口 (数学公式图片数组数据，高度，宽度)
     */
    public func setLatexImageCallback(cb: (Array<Byte>, Float64, Float64) -> Unit): Unit {
        this.latexImageCallback = {
            data, height, width => cb(data, height.value, width.value)
        }
    }

    /**
     * 设置数学公式数据处理事件
     *
     * @param cb 数学公式数据处理回调接口 (数学公式文本内容)：数学公式处理之后的文本内容
     */
    public func setLatexStrCallback(cb: (String) -> String): Unit {
        this.latexStrCallback = cb
    }

    /**
     * 设置TOC跳转指定位置
     *
     * @param cb TOC跳转指定位置接口 (位置距离)
     */
    public func setTocIndexCallback(cb: (Option<Float64>) -> Unit): Unit {
        this.tocIndexCallback = cb
    }

    /**
     * 设置脚注跳转指定位置
     *
     * @param cb 脚注跳转指定位置接口 (位置距离)
     */
    public func setFootnoteCallback(cb: (Option<Float64>) -> Unit): Unit {
        this.footnoteCallback = cb
    }

    /**
     * 设置markdown默认样式
     *
     * @param cjMarkdownTheme Markdown基础样式
     */
    public func setCJMarkdownTheme(cjMarkdownTheme: CJMarkdownTheme): Unit {
        this.cjMarkdownTheme = cjMarkdownTheme
    }
}
