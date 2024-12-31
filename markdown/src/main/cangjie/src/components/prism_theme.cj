/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*


/**
    prism 主题接口
*/
public interface PrismTheme {

    /**
     * 获取背景色
     * @return UInt32 返回背景色
     */
    func background(): Color

    /**
     * 设置背景色
     * @param bg 背景色值
     */
    func setBackground(bg: Color): Unit

    /**
     * 获取文本颜色
     * @return UInt32 返回文本颜色
     */
    func textColor(): Color

    /**
     * 设置文本颜色
     * @param text 文本颜色
     */
    func setTextColor(text: Color): Unit

    /**
     * 获取字段颜色存储集合
     * @return HashMap<String, Color> 返回颜色存储集合
     */
    func getColorMap(): HashMap<String, Color>

    /**
     * 自定义设置字段颜色存储集合
     * @param HashMap<String, Color> 颜色存储集合
     */
    func setColorMap(colorMap: HashMap<String, Color>): Unit
}

/**
    prism 主题抽象基类
*/
public abstract open class PrismThemeBase <: PrismTheme {

    static func applyAlpha(alpha: UInt32, color: UInt32): UInt32 {
        // 清除原有的 alpha 通道值，保留原有的 RGB 通道值
        let colorWithoutAlpha: UInt32 = color & 0x00FFFFFF
        // 将指定的 alpha 值左移 24 位
        let alphaShifted: UInt32 = alpha << 24
        // 将新的 alpha 通道值与原有的 RGB 通道值进行合并
        let finalColor: UInt32 = colorWithoutAlpha | alphaShifted
        // 返回新的颜色值
        return finalColor
    }

    static func applyAlpha(alpha: Float64, color: UInt32): UInt32 {
        // 将浮点数类型的 alpha 值转换为整数类型，并调用之前的 applyAlpha 方法
        let alphaInt: UInt32 = UInt32(255.0 * alpha + 0.5)
        return applyAlpha(alphaInt, color)
    }

    static func isOfType(expected: String, types: String, alias: ?String): Bool {
        return expected == types || expected == match(alias) {case Some(v) => v case None=> ""}
    }
}

/**
    prism 默认主题类
*/
public class PrismThemeDefault <: PrismThemeBase {

    // 背景颜色
    var bg: Color
    var colorMap: HashMap<String, Color>
    // 文本颜色
    var text: Color

    init(background: Color, colorMap: HashMap<String, Color>, text: Color) {
        this.bg = background
        this.colorMap = colorMap
        this.text = text
    }

    /**
     * 创建 PrismThemeDefault 对象的静态方法
     *
     * @return 返回一个默认背景色的主题
     */
    public static func create(): PrismThemeDefault {
        return PrismThemeDefault(Color(0xFFf5f2f0), ColorHashMap().initDefaultColor(), Color(0xdd000000))
    }

    /**
     * 创建 PrismThemeDarkula 对象的静态方法
     * @param 传入背景色
     *
     * @return 返回自定义背景色的主题
     */
    static func create(background: Color, text: Color): PrismThemeDefault {
        return PrismThemeDefault(background, ColorHashMap().initDefaultColor(), text)
    }

    /**
     * 获取背景色
     *
     * @return 返回背景色
     */
    public func background(): Color {
        return this.bg
    }

    /**
     * 设置背景色
     * @param bg 背景色值
     */
    public func setBackground(bg: Color): Unit {
        this.bg = bg
    }

    /**
     * 获取默认文本颜色
     *
     * @return 返回文本颜色
     */
    public func textColor(): Color {
        return this.text
    }

    /**
     * 设置文本颜色
     * @param text 文本颜色
     */
    public func setTextColor(text: Color): Unit {
        this.text = text
    }

    /**
     * 获取颜色存储集合
     * @return HashMap<String, Color> 返回颜色存储集合
     */
    public override open func getColorMap(): HashMap<String, Color> {
        return this.colorMap
    }

    /**
     * 自定义设置颜色存储集合
     * @param HashMap<String, Color> 颜色存储集合
     */
    public override open func setColorMap(colorMap: HashMap<String, Color>): Unit {
        this.colorMap = colorMap
    }
}

/**
    prism 暗黑主题类
*/
public class PrismThemeDarkula <: PrismThemeBase {
    // 背景颜色
    var bg: Color
    var colorMap: HashMap<String, Color>
    // 文本颜色
    var text: Color

    /**
     * PrismThemeDarkula 构造函数
     *
     * @param background 背景
     * @param colorMap  颜色存储集合
     * @param text 文本颜色
     */
    init(background: Color, colorMap: HashMap<String, Color>, text: Color) {
        this.bg = background
        this.colorMap = colorMap
        this.text = text
    }

    /**
     * 创建 PrismThemeDarkula 对象的静态方法
     *
     * @return 返回一个默认背景色的暗黑主题
     */
    public static func create(): PrismThemeDarkula {
        return PrismThemeDarkula(Color(0xFF2d2d2d), ColorHashMap().initDarkulaColor(), Color(0xFFa9b7c6))
    }

    /**
     * 创建 PrismThemeDarkula 对象的静态方法
     * @param 传入背景色
     *
     * @return 返回自定义背景色的暗黑主题
     */
    static func create(background: Color, text: Color): PrismThemeDarkula {
        return PrismThemeDarkula(background, ColorHashMap().initDarkulaColor(), text)
    }

    /**
     * 获取背景色
     *
     * @return 返回背景色
     */
    public func background(): Color {
        return this.bg
    }

    /**
     * 设置背景色
     * @param bg 背景色值
     */
    public func setBackground(bg: Color): Unit {
        this.bg = bg
    }

    /**
     * 获取默认文本颜色
     *
     * @return 返回文本颜色
     */
    public func textColor(): Color {
        return this.text
    }

    /**
     * 设置文本颜色
     * @param text 文本颜色
     */
    public func setTextColor(text: Color): Unit {
        this.text = text
    }

    /**
     * 获取颜色存储集合
     * @return HashMap<String, Color> 返回颜色存储集合
     */
    public override open func getColorMap(): HashMap<String, Color> {
        return this.colorMap
    }

    /**
     * 自定义设置颜色存储集合
     * @param HashMap<String, Color> 颜色存储集合
     */
    public override open func setColorMap(colorMap: HashMap<String, Color>): Unit {
        this.colorMap = colorMap
    }
}

/**
 * 代码颜色值存储集合
 */
public class ColorHashMap {
    var colorMap: HashMap<String, Color>

    func initDefaultColor(): HashMap<String, Color> {
        this.colorMap = HashMap<String, Color>()
        this.colorMap.put("comment", Color(0xFF708090))
        this.colorMap.put("prolog", Color(0xFF708090))
        this.colorMap.put("doctype", Color(0xFF708090))
        this.colorMap.put("cdata", Color(0xFF708090))
        this.colorMap.put("punctuation", Color(0xFF999999))
        this.colorMap.put("property", Color(0xFF990055))
        this.colorMap.put("tag", Color(0xFF990055))
        this.colorMap.put("boolean", Color(0xFF990055))
        this.colorMap.put("number", Color(0xFF990055))
        this.colorMap.put("constant", Color(0xFF990055))
        this.colorMap.put("symbol", Color(0xFF990055))
        this.colorMap.put("deleted", Color(0xFF990055))
        this.colorMap.put("selector", Color(0xFF669900))
        this.colorMap.put("attr-name", Color(0xFF669900))
        this.colorMap.put("string", Color(0xFF669900))
        this.colorMap.put("char", Color(0xFF669900))
        this.colorMap.put("builtin", Color(0xFF669900))
        this.colorMap.put("inserted", Color(0xFF669900))
        this.colorMap.put("operator", Color(0xFF9a6e3a))
        this.colorMap.put("url", Color(0xFF9a6e3a))
        this.colorMap.put("entity", Color(0xFF9a6e3a))
        this.colorMap.put("atrule", Color(0xFF0077aa))
        this.colorMap.put("attr-value", Color(0xFF0077aa))
        this.colorMap.put("keyword", Color(0xFF0077aa))
        this.colorMap.put("function", Color(0xFFDD4A68))
        this.colorMap.put("class-name", Color(0xFFDD4A68))
        this.colorMap.put("regex", Color(0xFFee9900))
        this.colorMap.put("important", Color(0xFFee9900))
        this.colorMap.put("variable", Color(0xFFee9900))
        return this.colorMap
    }

    func initDarkulaColor(): HashMap<String, Color> {
        this.colorMap = HashMap<String, Color>()
        this.colorMap.put("comment", Color(0xFF808080))
        this.colorMap.put("prolog", Color(0xFF808080))
        this.colorMap.put("cdata", Color(0xFF808080))
        this.colorMap.put("delimiter", Color(0xFFcc7832))
        this.colorMap.put("boolean", Color(0xFFcc7832))
        this.colorMap.put("keyword", Color(0xFFcc7832))
        this.colorMap.put("selector", Color(0xFFcc7832))
        this.colorMap.put("important", Color(0xFFcc7832))
        this.colorMap.put("atrule", Color(0xFFcc7832))
        this.colorMap.put("operator", Color(0xFFa9b7c6))
        this.colorMap.put("punctuation", Color(0xFFa9b7c6))
        this.colorMap.put("attr-name", Color(0xFFa9b7c6))
        this.colorMap.put("tag", Color(0xFFe8bf6a))
        this.colorMap.put("doctype", Color(0xFFe8bf6a))
        this.colorMap.put("builtin", Color(0xFFe8bf6a))
        this.colorMap.put("entity", Color(0xFF6897bb))
        this.colorMap.put("number", Color(0xFF6897bb))
        this.colorMap.put("symbol", Color(0xFF6897bb))
        this.colorMap.put("property", Color(0xFF9876aa))
        this.colorMap.put("constant", Color(0xFF9876aa))
        this.colorMap.put("variable", Color(0xFF9876aa))
        this.colorMap.put("string", Color(0xFF6a8759))
        this.colorMap.put("char", Color(0xFF6a8759))
        this.colorMap.put("annotation", Color(0xFFbbb438))
        this.colorMap.put("attr-value", Color(0xFFa5c261))
        this.colorMap.put("url", Color(0xFF287bde))
        this.colorMap.put("function", Color(0xFFffc66d))
        this.colorMap.put("regex", Color(0xFF364135))
        this.colorMap.put("inserted", Color(0xFF294436))
        this.colorMap.put("deleted", Color(0xFF484a4a))
        return this.colorMap
    }

    init() {
        this.colorMap = HashMap<String, Color>()
    }

    /**
     * ColorHashmap 构造函数
     *
     * @param map 默认或是自定义的 colorMap
     */
    public init(map: HashMap<String, Color>) {
        this.colorMap = map
    }

    /**
     * 获取 colormap 属性
     *
     */
    public func getColorMap(): HashMap<String, Color> {
        return this.colorMap
    }
}