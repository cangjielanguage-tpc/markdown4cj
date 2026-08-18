package markdown_parser.plugin

/**
 * 分隔符过滤模式
 */
public enum DelimiterFilterMode {
    | Permissive // 宽松模式（全部允许）
    | Strict // 严格模式（全部禁止）
    | Selective(Array<String>) // 白名单模式

    public static func fromInt64(int: Int64, allowedDelimiters: Array<String>): DelimiterFilterMode {
        return match (int) {
            case 0 => Permissive
            case 1 => Strict
            case 2 => Selective(allowedDelimiters)
            case _ => Selective(allowedDelimiters)
        }
    }

    public func toInt64(): Int64 {
        return match (this) {
            case Permissive => 0
            case Strict => 1
            case Selective(a) => 2
        }
    }
}

/**
 * 白名单宽松分隔符插件
 */
public class WhitelistLooseDelimiterPlugin <: AbstractMarkdownPlugin {
    private var filterMode: DelimiterFilterMode = DelimiterFilterMode.Strict
    private var whiteList: ?HashSet<Rune> = None

    /**
     * 统一工厂方法
     * 使用命名参数调用，例如 create(mode: DelimiterFilterMode.Selective)
     */
    public static func create(mode: DelimiterFilterMode): WhitelistLooseDelimiterPlugin {
        let plugin = WhitelistLooseDelimiterPlugin()
        plugin.filterMode = mode
        if (let Selective(arr) <- mode) {
            let set = HashSet<Rune>()
            plugin.whiteList = set
            for (str in arr) {
                set.add(all: str.toRuneArray())
            }
        }
        return plugin
    }

    public override func configureParser(parser: ParserBuilder): Unit {
        parser.delimiterOpenCloseProcessor({
            ctx: DelimiterOpenCloseContext => match (this.filterMode) {
                case DelimiterFilterMode.Permissive => DelimiterOpenCloseResult.of(true, true)
                case DelimiterFilterMode.Strict => ctx.defaultResult()
                case DelimiterFilterMode.Selective(a) =>
                    if (whiteList?.contains(ctx.delimiterChar()) ?? false) {
                        DelimiterOpenCloseResult.of(true, true)
                    } else {
                        ctx.defaultResult()
                    }
            }
        })
    }

    public func getClassType(): String {
        "WhitelistLooseDelimiterPlugin"
    }
}
