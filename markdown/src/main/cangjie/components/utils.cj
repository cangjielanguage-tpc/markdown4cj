package markdown.components

import ohos.state_macro_manage.*

/**
 * 扩展Option，getOrThrow()方法直接用()
 */
extend<T> Option<T> {
    operator func ()(): T {
        this.getOrThrow()
    }
}

/**
 * 扩展Option，实现Option类型直接使用==和!=
 */
extend<T> Option<T> where T <: Equatable<T> {
    operator func ==(other: T): Bool {
        match (this) {
            case Some(v) => v == other
            case _ => false
        }
    }

    operator func !=(other: T): Bool {
        match (this) {
            case Some(v) => v != other
            case _ => true
        }
    }
}

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

/**
 * 表格宽度
 */
@Observed
public class CellWidthArrayIndexedClass {
    @Publish
    var minWidth: Float64 = 0.0 // 表格最小宽度最大值
    @Publish
    var index: Int64 = -1 // 第几列
}
