/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.plugin.emoji

public class Options {
    var defs: ?HashMap<String, String> = None
    var shortCutSrc: ?HashMap<String, Array<String>> = None
    var shortcuts: ?HashMap<String, String> = None
    var enabled: ?Array<String> = None
    var regex: ?Regex = None
    /*
     * 初始化选项
     *
     * @param defs        emoji 定义 (emoji 名称 -> emoji 字符)
     * @param shortCutSrc 快捷方式定义 (emoji 名称 -> 快捷方式名称数组)
     * @param shortcuts   已启用的快捷方式 (快捷方式名称 -> emoji 字符)
     * @param enabled     已启用的 emoji
     * @param regex       emoji 正则表达式
     * @param light       是否为轻量模式
     */
    public init(
        defs!: ?HashMap<String, String> = None,
        shortCutSrc!: ?HashMap<String, Array<String>> = None,
        shortcuts!: ?HashMap<String, String> = None,
        enabled!: ?Array<String> = None,
        regex!: ?Regex = None,
        light!: ?Bool = None
    ) {
        if (let Some(defs) <- defs) {
            this.defs = defs
        } else if (let Some(light) <- light) {
            this.setLight(light)
        }
        if (let Some(shortCutSrc) <- shortCutSrc) {
            this.shortCutSrc = shortCutSrc
        } else if (light.isSome()) {
            this.shortCutSrc = EMOJI_DATA_SHORTCUTS
        }
        this.shortcuts = shortcuts
        this.enabled = enabled
        this.regex = regex
    }
    public func setLight(light: Bool): Unit {
        if (light) {
            defs = EMOJI_DATA_LIGHT
        } else {
            defs = EMOJI_DATA_FULL
        }
    }
}
