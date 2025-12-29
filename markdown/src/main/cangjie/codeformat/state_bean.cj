/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package markdown.codeformat

class StateBean {
    var codeChars: ?Array<Rune> = None
    var isLineStart: Bool = true
    var indentLevel: Int64 = 0 //缩进层级
    var isInString: Bool = false //是否在字符串中
    var stringQuote: Rune = r' ' //字符串的类型
    var isInMacro: Bool = false //是否在宏中
    var isInAccessFlag: Bool = false //是否在访问修饰符
    var isInFor: Bool = false //是否在for循环中
    var isInSinglelineComment: Bool = false //是否在单行注释里
    var isInMultilineComment: Bool = false //是否在多行注释里
    var smallBracketDouble: Int64 = 0 //小括号配对 
    var middleBracketDouble: Int64 = 0 //中括号配对
    var sharpBracketDouble: Int64 = 0 //尖括号配对
    var currentIndex: Int64 = 0 //当前索引
    var lastChar: Rune = r' ' //上一个char
    var currentChar: Rune = r' ' //当前char
    var output: StringBuilder = StringBuilder() //最后输出的stringbuilder
    var linesList: ArrayList<LineBean> = ArrayList<LineBean>() //多少行
    var perLineStartIndex: Int64 = 0 //上一行到哪里结束
    var perLineOutput: StringBuilder = StringBuilder() //缓存单行数据，如果单行没解析完，就把缓存中的输出到output中
}
