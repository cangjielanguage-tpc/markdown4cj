/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2025. All rights reserved.
 */
package markdown.plugin

import std.collection.collectArray
import std.collection.collectArrayList

const NO_END: Int = -1
/**
 * @see InlineHtmlTag
 * @see BlockHtmlTag
 */
public interface HtmlTag <: ToString {
    /**
     * @return normalized tag name (lower-case)
     */
    //    @NonNull
    func name(): String

    /**
     * @return index at which this tag starts
     */
    func start(): Int

    /**
     * @return index at which this tag ends
     */
    func end(): Int

    /**
     * @return flag indicating if this tag has no content (when start == end)
     */
    func isEmpty(): Bool

    /**
     * @return flag indicating if this tag is closed (has valid start and end)
     * @see #NO_END
     */
    func isClosed(): Bool

    //    @NonNull
    func attributes(): Map<String, String>

    /**
     * @see InlineHtmlTag
     */
    func isInline(): Bool

    /**
     * @see BlockHtmlTag
     */
    func isBlock(): Bool

    //    @NonNull
    func getAsInline(): InlineHtmlTag

    //    @NonNull
    func getAsBlock(): BlockHtmlTag
}

/**
 * Represents <em>really</em> inline HTML tags (unlile commonmark definitions)
 */
public interface InlineHtmlTag <: HtmlTag {}

/**
 * Represents HTML block tags. Please note that all tags that are not inline should be
 * considered as block tags
 */
public interface BlockHtmlTag <: HtmlTag {

    /**
     * @return parent {@link BlockHtmlTag} or None if there is no parent (this block is at root level)
     */
    //    @Nullable
    func parent(): ?BlockHtmlTag

    /**
     * @return list of children
     */
    //    @NonNull
    func children(): Collection<BlockHtmlTag>

    /**
     * @return a flag indicating if this {@link BlockHtmlTag} is at the root level (shortcut to calling:
     * {@code parent().isNone()}
     */
    func isRoot(): Bool
}

public abstract class HtmlTagImpl <: HtmlTag {
    let _name: String
    let _start: Int
    let _attributes: Map<String, String>
    var _end: Int = NO_END

    protected HtmlTagImpl(name: String, start: Int, attributes: Map<String, String>) {
        this._name = name
        this._start = start
        this._attributes = attributes
    }

    //    @NonNull
    public override func name(): String {
        return _name
    }

    public override func start(): Int {
        return _start
    }

    public override func end(): Int {
        return _end
    }

    public override func isEmpty(): Bool {
        return _start == _end
    }

    //    @NonNull
    public open override func attributes(): Map<String, String> {
        return _attributes
    }

    public override func isClosed(): Bool {
        return _end > NO_END
    }

    public func closeAt(end: Int): Unit
}

public class InlineImpl <: HtmlTagImpl & InlineHtmlTag {
    InlineImpl(name: String, start: Int, attributes: Map<String, String>) {
        super(name, start, attributes)
    }

    public override func closeAt(end: Int): Unit {
        if (!isClosed()) {
            super._end = end
        }
    }

    public override func toString(): String {
        return "InlineImpl{name='${_name}', start=${_start}, end=${_end}, attributes=${"_attributes"}"
    }

    public override func isInline(): Bool {
        return true
    }

    public override func isBlock(): Bool {
        return false
    }

    //    @NonNull
    public override func getAsInline(): InlineHtmlTag {
        return this
    }

    //    @NonNull
    public override func getAsBlock(): BlockHtmlTag {
        throw UnsupportedException("Cannot cast InlineHtmlTag instance to BlockHtmlTag")
    }
}

public class BlockImpl <: HtmlTagImpl & BlockHtmlTag {
    //    @NonNull
    static func root(): BlockImpl {
        return BlockImpl("", 0, HashMap<String, String>(), None)
    }

    //    @NonNull
    static func create(
        name: String,
        start: Int,
        attributes: Map<String, String>,
        parent: ?BlockImpl
    ): BlockImpl {
        return BlockImpl(name, start, attributes, parent)
    }

    let _parent: ?BlockImpl
    var _children: ?ArrayList<BlockImpl> = None

    BlockImpl(
        name: String,
        start: Int,
        attributes: Map<String, String>,
        parent: ?BlockImpl
    ) {
        super(name, start, attributes)
        this._parent = parent
    }

    public override func closeAt(end: Int): Unit {
        if (!isClosed()) {
            super._end = end
            if (let Some(children) <- _children) {
                for (child in children) {
                    child.closeAt(end)
                }
            }
        }
    }

    public override func isRoot(): Bool {
        return _parent.isNone()
    }

    //    @Nullable
    public override func parent(): ?BlockHtmlTag {
        return _parent ?? None
    }

    //    @NonNull
    public override func children(): ArrayList<BlockHtmlTag> {
        let list: ArrayList<BlockHtmlTag>
        if (let Some(children) <- _children) {
            list = children |> map<BlockImpl, BlockHtmlTag> {v => v} |> collectArrayList
        } else {
            list = ArrayList<BlockHtmlTag>()
        }
        return list
    }

    //    @NonNull
    public override func attributes(): Map<String, String> {
        return _attributes
    }

    public override func isInline(): Bool {
        return false
    }

    public override func isBlock(): Bool {
        return true
    }

    //    @NonNull
    public override func getAsInline(): InlineHtmlTag {
        throw UnsupportedException("Cannot cast BlockHtmlTag instance to InlineHtmlTag")
    }

    //    @NonNull
    public override func getAsBlock(): BlockHtmlTag {
        return this
    }

    public override func toString(): String {
        return "BlockImpl{name='${_name}', start=${_start}, end=${_end}, attributes=${"_attributes"}, parent=${_parent?._name ?? "None"}, children=${_children}"
    }
}
