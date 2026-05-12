package markdown.core

internal import commonmark4cj.commonmark.*
internal import std.collection.ArrayList
internal import std.collection.HashMap
internal import std.collection.HashSet
internal import std.collection.Map
internal import std.collection.collectArrayList
internal import std.collection.forEach
internal import std.time.DateTime

/**
 * 扩展Option，getOrThrow()方法直接用()
 */
extend<T> Option<T> {
    operator func ()(): T {
        this.getOrThrow()
    }
}

/**
 * 扩展Option，实现Option类型直接使用==和!=
 */
extend<T> Option<T> where T <: Equatable<T> {
    operator func !=(other: T): Bool {
        match (this) {
            case Some(v) => v != other
            case _ => true
        }
    }

    operator func ==(other: T): Bool {
        match (this) {
            case Some(v) => v == other
            case _ => false
        }
    }
}

let NULL_CHAR: Rune = '\u{0}'
let EMPTY_STRING: String = ""
let EMPTY_MAP: Map<String, String> = HashMap()

public type Runnable = () -> Unit
