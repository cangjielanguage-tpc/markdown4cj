// DEPENDENCE: attribute.cj  attributes.cj  character_reader.cj  common_mark_entities.cj  document_type.cj  normalizer.cj  parse_error.cj  token.cj  tokeniser.cj  tokeniser_state.cj  validate.cj unchecked_io_exception.cj
// EXEC: cjc %import-path %L %l %f attribute.cj  attributes.cj  character_reader.cj  common_mark_entities.cj  document_type.cj  normalizer.cj  parse_error.cj  token.cj  tokeniser.cj  tokeniser_state.cj  validate.cj unchecked_io_exception.cj --test
// EXEC: ./main

package markdown_parser.plugin
// internal import markdown_parser.core.*
// internal import markdown_parser.plugin.*
internal import commonmark4cj.commonmark.*
internal import std.collection.*
internal import std.convert.*
internal import std.unicode.*
internal import std.math.*
internal import std.io.*

/**
 * 扩展Option，getOrThrow()方法直接用()
 */
extend<T> Option<T> {
    operator func ()(): T {
        this.getOrThrow()
    }
}

extend String {
    func equalsIgnoreCase(other: String) {
        this.toAsciiLower() == other.toAsciiLower()
    }
    func strip(): String {
        var (left, right) = (0, this.size - 1)
        while (left <= right && this[left] <= b' ') {
            left++
        }
        while (left <= right && this[right] <= b' ') {
            right--
        }
        return this[left..=right]
    }
    func equals(s: String): Bool {
        this == s
    }
}

func binarySearch<T>(arr: Array<T>, key: T): Int64 where T <: Comparable<T> {
    var low = 0
    var high = arr.size - 1
    while (low <= high) {
        var mid = (low + high) / 2
        let midVal = arr[mid]
        match (midVal.compare(key)) {
            case LT => low = mid + 1
            case GT => high = mid - 1
            case EQ => return mid // key found
        }
    }

    // key not found.
    return -(low + 1)
}

@Test
public func token1(): Unit {
    let htmlFragment = "<a><b/><c></c><code>asd</code><br><br/></br>"
    let tokeniser = Tokeniser(CharacterReader(htmlFragment), ParseErrorList.noTracking())
    while (true) {
        let token = tokeniser.read()
        let tokenType = token.typ
        if (TokenType.EOFType == tokenType) {
            break
        }
        match (tokenType) {
            case StartTagType =>
                let startTag = (token as StartTagToken).getOrThrow()
                println("StartTagType: ${startTag.normalName()} ${startTag.isSelfClosing()}")
            case EndTagType =>
                let endTag = (token as EndTagToken).getOrThrow()
                println("EndTagType: ${endTag.normalName()} ${endTag.isSelfClosing()}")
            case CharacterType =>
                let character = (token as CharacterToken).getOrThrow()
                println("CharacterType: ${character.getData()}")
            case v => println(v)
        }
        token.reset()
    }
}
