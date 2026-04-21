package markdown.plugin

abstract class TrimmingAppender {
    public func append(output: Appendable, data: String): Unit

    static func create(): TrimmingAppender {
        return TrimmingAppenderImpl()
    }
}

class TrimmingAppenderImpl <: TrimmingAppender {
    public func append(_: Appendable, _: String): Unit {
    }
}
