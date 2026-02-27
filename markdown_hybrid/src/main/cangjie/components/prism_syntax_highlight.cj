/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * prism 句法高亮类
 */
public class PrismSyntaxHighlight {
    let prism: Prism
    let theme: PrismTheme

    /**
     * 根据 prism 对象和主题生成句法高亮类
     *
     * @param prism 预定义的 prism 类对象
     * @param theme 预定义主题
     * @return PrismSyntaxHighlight 返回句法高亮类对象
     */
    public static func create(prism: Prism, theme: PrismTheme): PrismSyntaxHighlight {
        return PrismSyntaxHighlight(prism, theme)
    }

    init(prism: Prism, theme: PrismTheme) {
        this.prism = prism
        this.theme = theme
    }

    /**
     * 代码高亮方法
     *
     * @param info 代码语言
     * @param code 代码
     * @return ArrayList<PrismNodesParseResUI> 返回通过 prism 库解析后的结果集
     */
    public func highlight(info: ?String, code: String): ArrayList<PrismNodesParseResUI> {
        if (code.isEmpty() || info.isNone()) {
            return highlightNoLanguageInfo(code)
        }
        if (info.getOrThrow().isEmpty()) {
            return highlightNoLanguageInfo(code)
        }
        return highlightWithLanguageInfo(this.prism, this.theme, info.getOrThrow(), code)
    }

    func highlightNoLanguageInfo(code: String): ArrayList<PrismNodesParseResUI> {
        return ArrayList<PrismNodesParseResUI>([PrismNodesParseResUI(types: "", text: code, alias: Option<String>.None, color: Option<Color>.None)])
    }

    func highlightWithLanguageInfo(prism: Prism, theme: PrismTheme, info: String, code: String): ArrayList<PrismNodesParseResUI> {
        return PrismNodeParse.textToArrayList(prism, theme.getColorMap(), info, code)
    }

    func getPrism(): Prism {
        return prism
    }

    func getTheme(): PrismTheme {
        return theme
    }
}

public class PrismNodesParseResUI {
    var types: String = ""
    var text: String = ""
    var alias: Option<String> = Option<String>.None
    var color: Option<Color> = Option<Color>.None

    public init(types!: String, text!: String, alias!: Option<String>, color!: Option<Color>) {
        this.types = types
        this.text = text
        this.alias = alias
        this.color = color
    }

    /**
     * 获取结果对象类型
     *
     * @return 返回结果对象的类型
     */
    func getType(): String {
        return types
    }

    /**
     * 设置结果对象类型
     *
     * @return 返回结果对象的类型
     */
    func setType(types: String): Unit {
        this.types = types
    }

    /**
     * 获取结果对象文本
     *
     * @return 返回结果对象的文本信息
     */
    func getText(): String {
        return text
    }

    /**
     * 设置结果对象类型
     *
     * @return 返回结果对象的类型
     */
    func setText(text: String): Unit {
        this.text = text
    }

    /**
     * 获取结果对象别名
     *
     * @return 返回结果对象的别名
     */
    func getAlias(): Option<String> {
        return alias
    }

    /**
     * 设置结果对象类型
     *
     * @return 返回结果对象的类型
     */
    func setAlias(alias: Option<String>): Unit {
        this.alias = alias
    }

    /**
     * 获取结果对象文本对应的颜色
     *
     * @return 返回结果对象文本对应的颜色
     */
    func getColor(): Option<Color> {
        return color
    }

    /**
     * 设置结果对象类型
     *
     * @return 返回结果对象的类型
     */
    func setColor(color: Option<Color>): Unit {
        this.color = color
    }
}

class PrismNodeParse {
    static let glg: GrammarLocatorGrammarUtils = GrammarLocatorGrammarUtils()

    static func textToArrayList(prism: Prism, colorMap: HashMap<PrismColor, Color>, info: ?String, literal: String): ArrayList<PrismNodesParseResUI> {
        if (let None <- info) {
            return ArrayList<PrismNodesParseResUI>([PrismNodesParseResUI(types: "", text: literal, alias: Option<String>.None, color: Option<Color>.None)])
        }
        let realInfo: String = info.getOrThrow().toAsciiLower()
        var grammar: ?PrismGrammar = None
        grammar = glg.grammar(prism, realInfo)
        var list: ArrayList<PrismNode> = try {
            prism.tokenize(literal, grammar.getOrThrow())
        } catch (e: NoneValueException) {
            return ArrayList<PrismNodesParseResUI>([PrismNodesParseResUI(types: "", text: literal, alias: Option<String>.None, color: Option<Color>.None)])
        }
        let listPrismNodesParseRes: ArrayList<PrismNodesParseResUI> = ArrayList<PrismNodesParseResUI>()
        for (i in 0..list.size) {
            PrismNodeParse.iterCurrent(list[i], Option.None, listPrismNodesParseRes, colorMap)
        }
        return listPrismNodesParseRes
    }

    static func iterCurrent(node: PrismNode, parent: ?Syntax, objList: ArrayList<PrismNodesParseResUI>, map: HashMap<PrismColor, Color>): Unit {
        if (node.isSyntax()) {
            let opt: Syntax = (node as Syntax).getOrThrow()
            for (child in opt.children()) {
                iterCurrent(child, opt, objList, map)
            }
        } else {
            let types = parent?.syntaxType() ?? ""
            let alias = parent?.alias() ?? None
            let text = (node as PrismText).getOrThrow().literal()
            var color: ?Color = map.get(PrismColor.fromString(types.toAsciiLower()))
            if (color.isNone() && alias.isSome()) {
                color = map.get(PrismColor.fromString(alias.getOrThrow().toAsciiLower()))
            }
            let obj = PrismNodesParseResUI(types: types, text: text, alias: alias, color: color)
            objList.add(obj)
        }
    }
}
