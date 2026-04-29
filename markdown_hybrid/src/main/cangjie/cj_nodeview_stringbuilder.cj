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
     * 设置视频背景颜色
     *
     * @param color 背景颜色
     */
    public func toString(): String {
        if (let Some(v) <- nodeViewStringBuilder){
            return v.toString()
        } else {
            return ""
        }
    }
}