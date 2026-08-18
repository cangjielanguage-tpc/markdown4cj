package markdown_parser.plugin

/**
 * 广告
 */
public open class ADPlugin <: AbstractMarkdownPlugin {
    public static func create(): ADPlugin {
        return ADPlugin()
    }

    public func getClassType(): String {
        "ADPlugin"
    }
}

public class BlockAD <: CustomBlock {
    public func getNodeType(): String {
        "BlockAD"
    }
}