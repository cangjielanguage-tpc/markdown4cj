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

    var isInRetuen: Bool = false //是否在return中 python有用
    var isInExcept: Bool = false //是否在Except中 python有用
    var isInDef: Bool = false //是否在Def中 python有用
    var isInClass: Bool = false //是否在Def中 python有用
    var isInContinue: Bool = false //是否在Continue中 python有用
    var isInBreak: Bool = false //是否在Break中 python有用
    var isInMain: Bool = false //是否在if __name__ == "__main__":中 python有用

    var isInElif: Bool = false //是否在elif中 python有用
    var isInElse: Bool = false //是否在elif中 python有用
    var isLastLineReturn: Bool = false //上一行是否是return 如果是return else不用缩进 否则要缩进一次 python有用

    //   for word,count in sorted(freq.items(),key=lambda x:
    //             x[1],reverse=True):
    //为了处理这种情况  python有用
    var isInSmallBracket: Bool = false
    //为了处理这种情况 在小括号和大括号里面没成对走完 里面的:不能执行结束逻辑
    //return{"总数":count,"正数":positive_count,"负数":negative_count,"总和":total,"平均值":average,"最大值":
    var isInBigBracket: Bool = false // python有用
    var bigBracketDoublepy: Int64 = 0 //大括号配对 python有用
    var smallBracketDoublepy: Int64 = 0 //大括号配对 python有用
    var isInMultiString: Bool = false //是否进入多行字符串 相当于python的多行注释 python有用
    var multiStringQuote: Rune = r' ' //多行字符串的类型 python有用

}
