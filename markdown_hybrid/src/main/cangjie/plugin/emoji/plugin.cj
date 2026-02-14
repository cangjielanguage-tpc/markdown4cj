/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package markdown.plugin.emoji

/**
 * emoji plugin
 */
public class EmojiPlugin <: AbstractMarkdownPlugin {
    let opts: Options
    init(defaults: Options) {
        opts = normalize_opts(defaults)
    }
    /*
     * create emoji plugin 精简
     * @return emoji plugin
     */
    public static func create(): EmojiPlugin {
        create(false)
    }
    /*
     * create emoji plugin
     * @param light 是否使用精简的emoji数据
     * @return emoji plugin
     */
    public static func create(light: Bool): EmojiPlugin {
        let opt = Options(light: light, shortCutSrc: EMOJI_DATA_SHORTCUTS)
        EmojiPlugin(opt)
    }
    /*
     * create emoji plugin
     * @param customOptions 自定义选项
     * @return emoji plugin
     */
    public static func create(opt: Options): EmojiPlugin {
        EmojiPlugin(opt)
    }

    public func configureParser(parser: ParserBuilder): Unit {
        parser.postProcessor(EmojiPostProcessor(opts))
    }

    public func getClassType(): String {
        "EmojiPlugin"
    }
}

class EmojiPostProcessor <: PostProcessor {
    EmojiPostProcessor(let options: Options) {}
    public func process(node: Node): Node {
        node.accept(EmojiVisitor(options))
        node
    }
}

let ucm_Z = "[ \\xA0\u{1680}\u{2000}-\u{200A}\u{2028}\u{2029}\u{202F}\u{205F}\u{3000}]"
let ucm_P = "[!-#%-\\*,-\\/:;\\?@\\[-\\]_\\{\\}\\xA1\\xA7\\xAB\\xB6\\xB7\\xBB\\xBF\u{037E}\u{0387}\u{055A}-\u{055F}\u{0589}\u{058A}\u{05BE}\u{05C0}\u{05C3}\u{05C6}\u{05F3}\u{05F4}\u{0609}\u{060A}\u{060C}\u{060D}\u{061B}\u{061E}\u{061F}\u{066A}-\u{066D}\u{06D4}\u{0700}-\u{070D}\u{07F7}-\u{07F9}\u{0830}-\u{083E}\u{085E}\u{0964}\u{0965}\u{0970}\u{09FD}\u{0A76}\u{0AF0}\u{0C84}\u{0DF4}\u{0E4F}\u{0E5A}\u{0E5B}\u{0F04}-\u{0F12}\u{0F14}\u{0F3A}-\u{0F3D}\u{0F85}\u{0FD0}-\u{0FD4}\u{0FD9}\u{0FDA}\u{104A}-\u{104F}\u{10FB}\u{1360}-\u{1368}\u{1400}\u{166D}\u{166E}\u{169B}\u{169C}\u{16EB}-\u{16ED}\u{1735}\u{1736}\u{17D4}-\u{17D6}\u{17D8}-\u{17DA}\u{1800}-\u{180A}\u{1944}\u{1945}\u{1A1E}\u{1A1F}\u{1AA0}-\u{1AA6}\u{1AA8}-\u{1AAD}\u{1B5A}-\u{1B60}\u{1BFC}-\u{1BFF}\u{1C3B}-\u{1C3F}\u{1C7E}\u{1C7F}\u{1CC0}-\u{1CC7}\u{1CD3}\u{2010}-\u{2027}\u{2030}-\u{2043}\u{2045}-\u{2051}\u{2053}-\u{205E}\u{207D}\u{207E}\u{208D}\u{208E}\u{2308}-\u{230B}\u{2329}\u{232A}\u{2768}-\u{2775}\u{27C5}\u{27C6}\u{27E6}-\u{27EF}\u{2983}-\u{2998}\u{29D8}-\u{29DB}\u{29FC}\u{29FD}\u{2CF9}-\u{2CFC}\u{2CFE}\u{2CFF}\u{2D70}\u{2E00}-\u{2E2E}\u{2E30}-\u{2E4E}\u{3001}-\u{3003}\u{3008}-\u{3011}\u{3014}-\u{301F}\u{3030}\u{303D}\u{30A0}\u{30FB}\u{A4FE}\u{A4FF}\u{A60D}-\u{A60F}\u{A673}\u{A67E}\u{A6F2}-\u{A6F7}\u{A874}-\u{A877}\u{A8CE}\u{A8CF}\u{A8F8}-\u{A8FA}\u{A8FC}\u{A92E}\u{A92F}\u{A95F}\u{A9C1}-\u{A9CD}\u{A9DE}\u{A9DF}\u{AA5C}-\u{AA5F}\u{AADE}\u{AADF}\u{AAF0}\u{AAF1}\u{ABEB}\u{FD3E}\u{FD3F}\u{FE10}-\u{FE19}\u{FE30}-\u{FE52}\u{FE54}-\u{FE61}\u{FE63}\u{FE68}\u{FE6A}\u{FE6B}\u{FF01}-\u{FF03}\u{FF05}-\u{FF0A}\u{FF0C}-\u{FF0F}\u{FF1A}\u{FF1B}\u{FF1F}\u{FF20}\u{FF3B}-\u{FF3D}\u{FF3F}\u{FF5B}\u{FF5D}\u{FF5F}-\u{FF65}]" +
    "|[\u{10100}-\u{10102}\u{1039F}\u{103D0}]" + "|\u{1056F}" +
    "|[\u{10857}\u{1091F}\u{1093F}\u{10A50}-\u{10A58}\u{10A7F}\u{10AF0}-\u{10AF6}\u{10B39}-\u{10B3F}\u{10B99}-\u{10B9C}]" +
    "|[\u{10F55}-\u{10F59}]" +
    "|[\u{11047}-\u{1104D}\u{110BB}\u{110BC}\u{110BE}-\u{110C1}\u{11140}-\u{11143}\u{11174}\u{11175}\u{111C5}-\u{111C8}\u{111CD}\u{111DB}\u{111DD}-\u{111DF}\u{11238}-\u{1123D}\u{112A9}]" +
    "|[\u{1144B}-\u{1144F}\u{1145B}\u{1145D}\u{114C6}\u{115C1}-\u{115D7}\u{11641}-\u{11643}\u{11660}-\u{1166C}\u{1173C}-\u{1173E}]" +
    "|[\u{1183B}\u{11A3F}-\u{11A46}\u{11A9A}-\u{11A9C}\u{11A9E}-\u{11AA2}]" +
    "|[\u{11C41}-\u{11C45}\u{11C70}\u{11C71}\u{11EF7}\u{11EF8}]" + "|[\u{12470}-\u{12474}]" +
    "|[\u{16A6E}\u{16A6F}\u{16AF5}\u{16B37}-\u{16B3B}\u{16B44}]" + "|[\u{16E97}-\u{16E9A}]" + "|\u{1BC9F}" +
    "|[\u{1DA87}-\u{1DA8B}]" + "|[\u{1E95E}\u{1E95F}]"
let ucm_Cc = "[\\0-\\x1F\\x7F-\\x9F]"
let ZPCc = Regex("${ucm_Z}|${ucm_P}|${ucm_Cc}", RegexFlag.Unicode)

class EmojiVisitor <: AbstractVisitor {
    EmojiVisitor(let options: Options) {}
    /* 
     * Emojies & shortcuts replacement logic.
     * Note: In theory, it could be faster to parse :smile: in inline chain and
     * leave only shortcuts here. But, who care...
     */
    public func visit(node: Text): Unit {
        let src = node.getLiteral()

        let datas = options.regex.getOrThrow().findAll(src)
        if (datas.size == 0) {
            return
        }

        let emojies = options.defs.getOrThrow()
        let shortcuts = options.shortcuts.getOrThrow()
        var newNodeLiteral = StringBuilder()
        var last_pos = 0
        for (data in datas) {
            let matchStr = data.matchString()
            let pos = data.matchPosition()
            let offset = pos.start

            let emoji_name: String
            // Validate emoji name
            if (shortcuts.contains(matchStr)) {
                // replace shortcut with full name
                emoji_name = shortcuts[matchStr]

                // Don't allow letters before any shortcut (as in no ":/" in http://)
                // find codepoint at offset - 1 in utf8 string : src
                if (offset > 0 && !ZPCc.matches(src.codePointAt(offset - 1))) {
                    continue
                }

                // Don't allow letters after any shortcut
                if (pos.end < src.size && !ZPCc.matches(src.codePointAt(pos.end))) {
                    continue
                }
            } else {
                emoji_name = matchStr[1..matchStr.size - 1]
            }

            // Add tokens to pending list
            if (offset > last_pos) {
                newNodeLiteral.append(src[last_pos..offset])
            }

            newNodeLiteral.append(emojies[emoji_name])

            last_pos = pos.end
        }

        if (last_pos < src.size) {
            newNodeLiteral.append(src[last_pos..])
        }

        node.setLiteral(newNodeLiteral.toString())
    }
}

extend String {
    func codePointAt(i: Int): String {
        var start = i
        var end = i
        while (this[start] >> 6 == 0b10) {
            start--
        }
        while (this[end] >> 6 == 0b10) {
            end++
        }
        return this[start..=end]
    }
}
