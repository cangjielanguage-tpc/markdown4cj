package markdown_parser.plugin.emoji

internal import std.collection.*
internal import std.regex.*
internal import std.sort.*
internal import commonmark4cj.commonmark.*
internal import markdown_parser.core.*

// Convert input options to more useable format
// and compile search regexp

func quoteRE(str: String): String {
    let arr = ArrayList<Byte>(str.size)
    for (b in str) {
        match (b) {
            case b'.' | b'?' | b'*' | b'+' | b'^' | b'$' | b'[' | b']' | b'\\' | b'(' | b')' | b'{' | b'}' | b'|' | b'-' => arr
                .add(b'\\')
            case _ => ()
        }
        arr.add(b)
    }
    unsafe { String.fromUtf8Unchecked(arr.getRawArray()[..arr.size]) }
}

func normalize_opts(options: Options): Options {

    // Filter emojies by whitelist, if needed
    let emojies = if (let Some(enabled) <- options.enabled && enabled.size > 0) {
        let emojies_new = HashMap<String, String>()
        for (k in enabled) {
            if (let Some(Some(v)) <- options.defs?.get(k)) {
                emojies_new.add(k, v)
            }
        }
        emojies_new
    } else {
        options.defs ?? HashMap<String, String>()
    }

    // Flatten shortcuts to simple object: { alias: emoji_name }
    let shortcuts = if (let Some(shortCutSrc) <- options.shortCutSrc && shortCutSrc.size > 0) {
        let shortcuts_new = HashMap<String, String>()
        for ((key, aliases) in shortCutSrc where emojies.contains(key)) {
            for (alias in aliases) {
                shortcuts_new.add(alias, key)
            }
        }
        shortcuts_new
    } else {
        HashMap<String, String>()
    }

    // If no definitions are given, return empty regex to avoid replacements with 'undefined'.
    let names = if (emojies.size == 0) {
        '^$'
    } else {
        // Compile regexp
        let scs = shortcuts |> map {kv => kv[0]}
        let arr = emojies |> map {kv => ":${kv[0]}:"} |> concat(scs) |> collectArray
        sort(arr, descending: true)
        arr |> map(quoteRE) |> collectString(delimiter: '|')
    }
    let regex = Regex(names)

    return Options(
        defs: emojies,
        shortcuts: shortcuts,
        regex: regex
    )
}
