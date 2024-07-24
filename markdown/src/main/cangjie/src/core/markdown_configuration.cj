/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.core

public class MarkdownConfiguration {
    public static func builder(): MarkdownConfigurationBuilder {
        return MarkdownConfigurationBuilder()
    }

    private let _theme: ?MarkdownTheme

    init(builder: MarkdownConfigurationBuilder) {
        this._theme = builder._theme
    }

    public func theme(): ?MarkdownTheme {
        return _theme
    }
}

public class MarkdownConfigurationBuilder {
    var _theme: ?MarkdownTheme = None

    init() {
    }

    public func build(theme: MarkdownTheme): MarkdownConfiguration {
        this._theme = theme
        return MarkdownConfiguration(this)
    }
}
