package markdown_parser.plugin

public class UncheckedIOException <: Exception {
    init(cause: IOException) {
        super(cause.message)
    }

    init(message: String) {
        super(message)
    }

    public override func getClassName(): String {
        "UncheckedIOException"
    }
}
