package markdown_parser.plugin

public abstract class CommonMarkEntities {
    public static func isNamedEntity(name: String): Bool {
        return COMMONMARK_NAMED_ENTITIES.contains(name)
    }

    public static func codepointsForName(name: String, codepoints: Array<Rune>): Int64 {
        var val: ?String = COMMONMARK_NAMED_ENTITIES.get(name)
        if (let Some(v) <- val?.toRuneArray()) {
            codepoints[0] = v[0]
            if (v.size == 2) {
                codepoints[1] = v[1]
            }
            return v.size
        }
        return 0
    }

    private static let COMMONMARK_NAMED_ENTITIES: Map<String, String> = Html5Entities.readEntities()
}
