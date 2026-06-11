package markdown.core

internal import commonmark4cj.commonmark.*
internal import std.collection.ArrayList
internal import std.collection.HashMap
internal import std.collection.HashSet
internal import std.collection.Map
internal import std.collection.collectArrayList
internal import std.collection.forEach
internal import std.time.DateTime

public interface OptionExt<T> {
    operator func ()(): T
}

/**
 * 扩展Option，getOrThrow()方法直接用()
 */
extend<T> Option<T> <: OptionExt<T> {
    public operator func ()(): T {
        this.getOrThrow()
    }
}

let NULL_CHAR: Rune = '\u{0}'
let EMPTY_STRING: String = ""
let EMPTY_MAP: Map<String, String> = HashMap()

public type Runnable = () -> Unit
