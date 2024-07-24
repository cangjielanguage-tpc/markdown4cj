/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package markdown.core

/**
 * Markdown所有用户可设置样式
 */
public interface MarkdownTheme {
    static func builderWithDefaults(): MarkdownThemeBuilder {
        return EmptyMarkdownThemeBuilder()
    }
}

class EmptyMarkdownTheme <: MarkdownTheme {}

public interface MarkdownThemeBuilder {
    func build(): MarkdownTheme
}

class EmptyMarkdownThemeBuilder <: MarkdownThemeBuilder {
    public func build(): MarkdownTheme {
        return EmptyMarkdownTheme()
    }
}
