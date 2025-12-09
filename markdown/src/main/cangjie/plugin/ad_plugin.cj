/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.plugin

/**
 * 广告
 */
public open class ADPlugin <: AbstractMarkdownPlugin {
    public static func create(): ADPlugin {
        return ADPlugin()
    }

    public open override func afterRender(doc: Node, _: MarkdownVisitor): Unit {
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