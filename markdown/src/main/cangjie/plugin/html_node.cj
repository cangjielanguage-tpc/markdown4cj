/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 */
package markdown.plugin

public class ImageHtmlNode <: CustomNode {
    private var destination: String
    private var width: ?String
    private var height: ?String

    public init(destination: String, width: ?String, height: ?String) {
        this.destination = destination
        this.width = width
        this.height = height
    }

    public func getDestination(): String {
        return destination
    }

    public func getWidth(): ?String {
        return width
    }

    public func getHeight(): ?String {
        return height
    }

    public override func getNodeType(): NodeType {
        return "ImageHtmlNode"
    }
}

public class FontNode <: CustomNode {
    private var color: ?String
    private var size: ?String

    public init(color: ?String, size: ?String) {
        this.color = color
        this.size = size
    }

    public func getColor(): ?String {
        return color
    }

    public func getSize(): ?String {
        return size
    }

    public override func getNodeType(): NodeType {
        return "FontNode"
    }
}

public class SpanNode <: CustomNode {
    private var attrs: ?HashMap<String, String>
    private var style: ?HashMap<String, String>

    public init(attrs: ?HashMap<String, String>, style: ?HashMap<String, String>) {
        this.attrs = attrs
        this.style = style
    }
    /**
     * 除了style之外的属性
     */
    public func getAttrs(): ?HashMap<String, String> {
        return attrs
    }
    /**
     * 分割后的style内容
     */
    public func getStyle(): ?HashMap<String, String> {
        return style
    }
    public func toStringAttributes(): String {
        var styleString = ""
        if (let Some(attrs) <- attrs) {
            styleString += "attrs:${attrs}"
        }
        if (let Some(style) <- style) {
            styleString += "style:${style}"
        }
        return styleString
    }
    public override func getNodeType(): NodeType {
        return "SpanNode"
    }
}

public interface IgnoreNode {}

public class IgnoreBlockNode <: CustomBlock & IgnoreNode {
    public override func getNodeType(): NodeType {
        return "IgnoreBlockNode"
    }
    public func getParent(): ?Node {
        this.parent
    }

    protected func setParent(parent: Node): Unit {
        this.parent = parent
    }
}

public class IgnoreInlineNode <: CustomNode & IgnoreNode {
    public override func getNodeType(): NodeType {
        return "IgnoreInlineNode"
    }
}
