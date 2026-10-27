package markdown.components

import ohos.state_macro_manage.*

/**
 * markdown XC需求相关配置 — 段落高亮
 *
 * 管理可高亮段落的nodeHash集合和当前高亮的段落列表。
 * 外部通过setAllParagraphItems设置全部可高亮段落，
 * 通过highlightParagraph/clearParagraphHighlight控制高亮状态。
 */
@Observed
public class MarkdownHighlightParagraph {
    private var allParagraphItems: HashSet<String> = HashSet<String>() // 所有可以设置高亮的段落nodeHash集合
    private var selectedParagraphItemList: HashSet<String> = HashSet<String>() // 当前高亮显示的段落集合
    @Publish
    var selectedParagraphItem: String = "" // 当前高亮显示的段落的nodeHash
    @Publish
    var selectedParagraphItemColor: ?Color = Option<Color>.None // 当前高亮显示的段落的背景色

    @Publish
    var beforeSelectedParagraphBackgroundColor: ?Color = Option<Color>.None // 长按前段落默认背景色（用于长按后恢复）
    @Publish
    var selectedParagraphBackgroundColor: ?Color = Option<Color>.None // 长按选中段落的背景色

    public static func create(): MarkdownHighlightParagraph {
        return MarkdownHighlightParagraph()
    }

    /**
      * 设置长按前段落默认背景色
      *
      * @param color 长按前段落默认背景色
      */
     public func setBeforeSelectedParagraphBackgroundColor(color: ?Color): Unit {
         this.beforeSelectedParagraphBackgroundColor = color
     }

     /**
      * 获取长按前段落默认背景色
      *
      * @return 长按前段落默认背景色
      */
     public func getBeforeSelectedParagraphBackgroundColor(): ?Color {
         return this.beforeSelectedParagraphBackgroundColor
     }

    /**
     * 设置长按选中段落的背景色
     *
     * @param color 长按选中段落的背景色
     */
    public func setSelectedParagraphBackgroundColor(color: ?Color): Unit {
        this.selectedParagraphBackgroundColor = color
    }

    /**
     * 获取长按选中段落的背景色
     *
     * @return 长按选中段落的背景色
     */
    public func getSelectedParagraphBackgroundColor(): ?Color {
        return this.selectedParagraphBackgroundColor
    }

    /**
     * 设置所有可以设置高亮的段落nodeHash集合
     *
     * @param itemIndexList 段落nodeHash集合
     */
    protected func setAllParagraphItems(itemIndexList: ArrayList<String>): Unit {
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
    public func isSelectedParagraphItem(nodeHash: String): Bool {
        return selectedParagraphItemList.contains(nodeHash)
    }

    /**
     * 设置指定段落高亮显示
     * 同时通知MarkdownHighlightRegistry触发已注册组件的UI更新
     * 已高亮的段落重复设置返回false（幂等），不同段落可同时保持高亮
     * 对齐ArkUI原版语义：所有高亮段落渲染取色统一读最后一次设置的颜色，
     * 因此每次设置成功时将全部已高亮段落刷新为本次颜色
     *
     * @param nodeHash 段落nodeHash
     * @param color 段落高亮颜色
     *
     * @return 是否设置成功 false表示已经设置过或设置失败（未找到nodeHash）
     */
    public func setParagraphHighlight(nodeHash: String, color: Color): Bool {
        if (selectedParagraphItemList.contains(nodeHash)) {
            return false
        }
        selectedParagraphItem = nodeHash
        selectedParagraphItemColor = color
        try {
            // 多段高亮同色：先把所有已高亮段落刷新为最新颜色，再高亮新段落
            for (item in selectedParagraphItemList) {
                let _ = MarkdownHighlightRegistry.highlight(Int64.parse(item), color)
            }
            if (MarkdownHighlightRegistry.highlight(Int64.parse(nodeHash), color)) {
                selectedParagraphItemList.add(nodeHash)
                return true
            }
            return false
        } catch (e: Exception) {
            return false
        }
    }

    /**
     * 取消指定段落的高亮
     * 同时通知MarkdownHighlightRegistry取消已注册组件的UI更新
     *
     * @param nodeHash 段落nodeHash
     *
     * @return 是否取消成功 false表示该段落没有高亮或者未找到nodeHash
     */
    public func clearParagraphHighlight(nodeHash: String): Bool {
        selectedParagraphItem = ""
        let existed = selectedParagraphItemList.contains(nodeHash)
        if (existed) {
            selectedParagraphItemList.remove(nodeHash)
        }
        try {
            return MarkdownHighlightRegistry.clearHighlight(Int64.parse(nodeHash))
        } catch (e: Exception) {
            return false
        }
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
