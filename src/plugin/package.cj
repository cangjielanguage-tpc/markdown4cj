package markdown.plugin

internal import markdown.core.*
// internal import commonmark4cj.commonmark.*
public import commonmark4cj.strikethrough.*
public import commonmark4cj.table.*
internal import std.collection.ArrayList
internal import std.collection.LinkedList
internal import std.collection.LinkedListNode
internal import std.collection.HashMap
internal import std.collection.HashSet
internal import std.collection.Map
internal import std.collection.collectArray
internal import std.collection.collectArrayList
internal import std.collection.collectString
internal import std.collection.map
internal import std.collection.forEach
internal import std.collection.Set
internal import std.time.DateTime
internal import std.regex.Matcher
internal import std.regex.Regex
internal import std.regex.RegexFlag
internal import std.collection.contains
internal import std.io.IOException
internal import std.unicode.UnicodeStringExtension
internal import std.math.abs
internal import std.math.MaxMinValue
internal import std.convert.Parsable
internal import std.convert.*

let NULL_CHAR: Rune = '\u{0}'
let EMPTY_STRING: String = ""
let EMPTY_MAP: Map<String, String> = HashMap()
let EMPTY_STRING_ARRAY: Array<String> = []

public type Runnable = () -> Unit

extend StringBuilder {
    func appends(str: ToString): StringBuilder {
        this.append(str)
        return this
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

/*
BlockParser
tryStart
addline
tryContinue ? addline : {closeBlock;parseInlines}
 */
