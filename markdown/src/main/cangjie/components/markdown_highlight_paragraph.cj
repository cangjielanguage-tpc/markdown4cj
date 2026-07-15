package markdown.components

import std.collection.ArrayList
import std.collection.HashSet

/**
 * markdown XC需求相关配置 — 段落高亮
 *
 * 管理可高亮段落的nodeHash集合和当前高亮的段落列表。
 * 外部通过setAllParagraphItems设置全部可高亮段落，
 * 通过highlightParagraph/clearParagraphHighlight控制高亮状态。
 */
public class MarkdownHighlightParagraph {
    private var allParagraphItems: HashSet<String> = HashSet<String>() // 所有可以设置高亮的段落nodeHash集合
    private var selectedParagraphItemList: HashSet<String> = HashSet<String>() // 当前高亮显示的段落集合

    public var selectedParagraphItem: String = "" // 当前高亮显示的段落的nodeHash
    public var selectedParagraphItemColor: ?Color = None // 当前高亮显示的段落的背景色

    public init() {
    }

    /**
     * 设置所有可以设置高亮的段落nodeHash集合
     *
     * @param itemIndexList 段落nodeHash集合
     */
    public func setAllParagraphItems(itemIndexList: ArrayList<String>): Unit {
        for (item in itemIndexList) {
            allParagraphItems.add(item)
        }
    }

    /**
     * 获取所有可以设置高亮的段落的nodeHash集合
     *
     * @return 段落nodeHash集合
     */
    public func getAllParagraphItems(): ArrayList<String> {
        let result = ArrayList<String>()
        for (item in allParagraphItems) {
            result.add(item)
        }
        return result
    }

    /**
     * 获取当前高亮显示的段落nodeHash集合
     *
     * @return 段落nodeHash集合
     */
    public func getSelectedParagraphItemList(): ArrayList<String> {
        let result = ArrayList<String>()
        for (item in selectedParagraphItemList) {
            result.add(item)
        }
        return result
    }

    /**
     * 检查指定段落是否在高亮列表中
     *
     * @param index 段落nodeHash
     * @return 是否在高亮列表中
     */
    public func isSelectedParagraphItem(index: String): Bool {
        return selectedParagraphItemList.contains(index)
    }

    /**
     * 设置指定段落高亮显示
     * 同时通知MarkdownHighlightRegistry触发已注册组件的UI更新
     *
     * @param index 段落nodeHash
     * @param color 段落高亮颜色
     *
     * @return 是否设置成功 false表示已经设置过
     */
    public func highlightParagraph(index: String, color: Color): Bool {
        selectedParagraphItem = index
        selectedParagraphItemColor = color
        if (selectedParagraphItemList.contains(index)) {
            return false
        }
        selectedParagraphItemList.add(index)
        MarkdownHighlightRegistry.highlight(Int64.parse(index), color)
        return true
    }

    /**
     * 取消指定段落的高亮
     * 同时通知MarkdownHighlightRegistry取消已注册组件的UI更新
     *
     * @param index 段落nodeHash
     *
     * @return 是否取消成功 false表示该段落没有高亮
     */
    public func clearParagraphHighlight(index: String): Bool {
        selectedParagraphItem = ""
        let existed = selectedParagraphItemList.contains(index)
        if (existed) {
            selectedParagraphItemList.remove(index)
        }
        MarkdownHighlightRegistry.clearHighlight(Int64.parse(index))
        return existed
    }

    /**
     * 取消所有段落高亮
     * 同时通知MarkdownHighlightRegistry取消所有已注册组件的UI更新
     */
    public func clearAllParagraphHighlights(): Unit {
        selectedParagraphItem = ""
        selectedParagraphItemColor = None
        selectedParagraphItemList.clear()
        MarkdownHighlightRegistry.clearAll()
    }
}
