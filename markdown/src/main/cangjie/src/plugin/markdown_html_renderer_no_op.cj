/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.plugin

class MarkdownHtmlRendererNoOp <: MarkdownHtmlRenderer {
    init() {
        super()
    }

    public override func render(visitor: MarkdownVisitor, parser: MarkdownHtmlParser, rootTag: HtmlTag): Node {
        parser.reset()
        throw Exception("TODO")
    }

    public override func tagHandler(tagName: String): ?TagHandler {
        return None
    }
}
