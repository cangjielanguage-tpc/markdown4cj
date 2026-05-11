package markdown

import ohos.ark_interop_macro.*

@Interop[ArkTS]
public class CJNodeViewStringBuilder {
    var nodeViewStringBuilder: ?NodeViewStringBuilder =None

    public init() {}

    @Interop[ArkTS, Invisible]
    func setNodeViewStringBuilder(nodeViewStringBuilder: NodeViewStringBuilder) {
        this.nodeViewStringBuilder = nodeViewStringBuilder
    }

    /**
     * 获取全局文本字符串
     *
     * @return 文本字符串，如果未设置则返回空字符串
     */
    public func toString(): String {
        if (let Some(v) <- nodeViewStringBuilder){
            return v.toString()
        } else {
            return ""
        }
    }
}