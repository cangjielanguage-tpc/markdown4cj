/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package markdown.codeformat

internal import std.collection.ArrayList

// 辅助函数：根据配置添加对应缩进
func addIndent(codeBuilder: StringBuilder, level: Int64, cfg: FormatConfig) {
    if (level <= 0) {
        return
    }
    if (cfg.useTab) {
        for (_ in 0..level) {
            codeBuilder.append("\t") // 制表符缩进
        }
    } else {
        for (_ in 0..cfg.indentWidth * level) {
            codeBuilder.append(" ") // 空格缩进
        }
    }
}

//去除废弃的lineBean
func removediscard(stateBean: StateBean): Unit {
    let usefulList: ArrayList<LineBean> = ArrayList<LineBean>()
    for (item in stateBean.linesList) {
        if (!item.isDiscarded) {
            usefulList.add(item)
        }
    }
    stateBean.linesList = usefulList
}

func removeOnlyChangeLine(stateBean: StateBean): Unit {
    let usefulList: ArrayList<LineBean> = ArrayList<LineBean>()
    for (item in stateBean.linesList) {
        if (item.codeLine.trimAscii().size > 0) {
            usefulList.add(item)
        }
    }
    stateBean.linesList = usefulList
}

func modifyMacroAndSpace(stateBean: StateBean): Unit {
    for (item in stateBean.linesList) {
        if (item.codeLine.trimAscii().startsWith("#")) {
            //如果这种情况#include<stdio.h>       
            if (item.codeLine.trimAscii().startsWith("#include") && !item.codeLine.contains("#include ")) {
                item.codeLine = item.codeLine.replace("#include", "#include ")
            }
            //对宏的行进行处理
            let array = item.codeLine.split(" ", 2, removeEmpty: true)
            if (array.size > 1) {
                item.codeLine = array[0] + " " + array[1]
            } else {
                item.codeLine = array[0]
            }
        }
    }
}

public func codeFormat(languageType: ?String, code: String, cfg: FormatConfig): String {
    if (let Some(i) <- languageType) {
        let result = match (i.toAsciiLower()) {
            case "c" | "cpp" | "c++" | "clike" => CandCppFormat().formatCode(code, cfg)
            case _ => code
        }
        return result
    } else {
        return code
    }
}
