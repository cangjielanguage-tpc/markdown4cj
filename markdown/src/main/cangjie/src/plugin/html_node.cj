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
    private var attrs: Map<String,String>

    public init(attrs: Map<String,String>) {
        this.attrs = attrs
    }

    public func getAttrs(): Map<String,String> {
        return attrs
    }

    public override func getNodeType(): NodeType {
        return "SpanNode"
    }
}

public class IgnoreNode <: CustomBlock {
    public init() {
    }

    public override func getNodeType(): NodeType {
        return "IgnoreNode"
    }
    
    public override func getParent(): ?Node {
        parent
    }
}
