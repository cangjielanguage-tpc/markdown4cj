package markdown.components

/**
 * 元素曝光事件模型。
 *
 * 链接（后续可扩展 image/regex）在屏幕上「显示」或「消失」时回调上报。
 * 对齐 ArkTS MarkdownExposureEvent：type/visible/data，未来扩字段不破坏签名。
 */
public class MarkdownExposureEvent {
    /**
     * 曝光元素的类型。暂时只有 'link'，预留 'image'/'regex'。
     */
    public var `type`: String

    /**
     * 是否可见。true=链接进入可见态（显示），false=链接离开可见态（消失）。
     */
    public var visible: Bool

    /**
     * 元素数据。type='link' 时为链接 url 字符串。
     */
    public var data: String

    public init(`type`!: String, visible!: Bool, data!: String) {
        this.`type` = `type`
        this.visible = visible
        this.data = data
    }
}
