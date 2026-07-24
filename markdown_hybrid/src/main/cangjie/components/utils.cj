package markdown_hybrid.components

import ohos.state_macro_manage.*

/**
 * 获取prop数据
 *
 * @param commonmarkNode Node
 * @param key key
 * @param default 默认值
 * @return T
 */
func getProp<T>(commonmarkNode: CommonmarkNode, key: String, default: T): T {
    match (commonmarkNode.getProp<T>(key)) {
        case Some(v) => v
        case _ => default
    }
}

/**
 * 图片Style使用的实体类
 */
public class PicStyleObj {
    var width: ?Length = None // 图片宽度
    var height: ?Length = None // 图片高度
    var align: HorizontalAlign = HorizontalAlign.Center // 图片对齐方式
    var borderRadius: ?Length = None // 图片圆角
}

/**
 * 文本对象
 */
public class StringClass {
    var str: String = "" // 文本内容

    func addString(s: String): Unit {
        str = str + s
    }
}
