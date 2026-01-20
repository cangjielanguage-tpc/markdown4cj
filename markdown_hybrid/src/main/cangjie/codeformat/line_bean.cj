/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package markdown.codeformat

class LineBean {
    var codeLine: String = ""
    var indentLevel: Int64 = 0
    var smallBracketDouble: Int64 = 0 //小括号配对 
    var middleBracketDouble: Int64 = 0 //中括号配对
    var sharpBracketDouble: Int64 = 0 //尖括号配对
    var isInString: Bool = false //是否在字符串中
    var isInMacro: Bool = false //是否在宏中
    var isInAccessFlag: Bool = false //是否在访问修饰符
    var isInFor: Bool = false //是否在for循环中
    var isInSinglelineComment: Bool = false //是否是单行注释
    var isInMultilineComment: Bool = false //是否是多行注释
    var singleLineWhiteSpace: Int64 = 0 //单行注释前面有几个空格
    var singlelineCommentisAfterChangline: Bool = false //单行前面是不是换行
    var isDiscarded: Bool = false //过滤后是否废弃
    var isFirstMultiCommentLine: Bool = false //是否是多行里面的第一行 第一行跟其他不同
    var mutlilineCommentisAfterChangline: Bool = false //多行前面是不是换行

    var isInMultiString: Bool = false //是不是在多行注释里面 python有用

}
