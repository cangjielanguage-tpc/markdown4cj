/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 链接的点击事件
 *
 * @param nodeView NodeView
 * @param linkCallback 链接点击事件的回调事件
 */
func linkOnClick(nodeView: NodeView, linkCallback: ?(String) -> Unit): Unit {
    if (linkCallback.isSome() && nodeView.link.isSome()) {
        linkCallback()(nodeView.link().getDestination())
    }
}

/**
 * 图片的点击事件
 *
 * @param commonmarkImageStr 图片链接
 * @param imageCallback 图片点击事件的回调事件
 */
func imageOnClick(commonmarkImageStr: String, imageCallback: ?(String) -> Unit): Unit {
    if (imageCallback.isSome()) {
        imageCallback()(commonmarkImageStr)
    }
}

/**
 * 视频的点击事件
 *
 * @param imgVideoStr 视频链接
 * @param videoCallback 视频点击事件的回调事件
 */
func videoOnClick(imgVideoStr: String, videoCallback: ?(String) -> Unit): Unit {
    if (videoCallback.isSome()) {
        videoCallback()(imgVideoStr)
    }
}

/**
 * 代码复制的点击事件
 *
 * @param codeText 需要复制的代码内容
 * @param codeCopyCallback 代码复制点击事件的回调事件
 */
func codeCopyOnClick(codeText: String, codeCopyCallback: ?(String) -> Unit): Unit {
    if (codeCopyCallback.isSome()) {
        codeCopyCallback()(codeText.trimRight("\n"))
    }
}

/**
 * 代码全屏的点击事件
 *
 * @param codeText 需要全屏的代码内容
 * @param info 代码类型
 * @param codeCopyCallback 代码全屏点击事件的回调事件
 */
func codeFullScreenOnClick(codeText: String, info: ?String, codeFullScreenCallback: ?(String, ?String) -> Unit): Unit {
    if (codeFullScreenCallback.isSome()) {
        codeFullScreenCallback()(codeText.trimRight("\n"), info)
    }
}

/**
 * 数学公式图片点击事件
 *
 * @param lists 数学公式数据
 * @param height 高度
 * @param width 宽度
 * @param latexImageCallback 数学公式图片点击事件
 */
func latexImageOnClick(lists: Array<UInt8>, height: Length, width: Length,
    latexImageCallback: ?(Array<UInt8>, Length, Length) -> Unit): Unit {
    if (latexImageCallback.isSome()) {
        latexImageCallback()(lists, height, width)
    }
}

/**
 * 超大数据跳转页面显示全部数据点击事件
 *
 * @param nodeView 数学公式数据
 * @param marginTop 间距
 * @param marginBottom 间距
 * @param componentWidth 宽度
 * @param listBigDataCallback 超大数据跳转页面显示全部数据点击事件
 */
func listBigDataOnClick(nodeView: NodeView, marginTop: Float64, marginBottom: Float64, componentWidth: Float64,
    listBigDataCallback: ?(NodeView, Float64, Float64, Float64) -> Unit): Unit {
    if (listBigDataCallback.isSome()) {
        listBigDataCallback()(nodeView, marginTop, marginBottom, componentWidth)
    }
}
