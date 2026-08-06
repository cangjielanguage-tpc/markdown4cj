package markdown.components

/**
 * 链接曝光注册表（静态）
 * 消费方（MarkdownParagraphComponent / MarkdownHeadingComponent）在aboutToAppear时
 * 调用register注册本组件包含的http链接URL列表，aboutToDisappear时调用unregister注销。
 *
 * 由于根列表使用LazyForEach，组件的创建/销毁与可见性高度相关：
 * - 组件创建（滚入视口+预加载区）→ 链接visible=true
 * - 组件销毁（滚出视口+预加载区）→ 链接visible=false
 *
 * 同一URL可能出现在多个段落中，使用引用计数：count从0→1时报visible=true，
 * count从1→0时报visible=false。
 */
public class MarkdownLinkExposureRegistry {
    static var exposureCallback: ?(MarkdownExposureEvent) -> Unit = None
    static var exposureThreshold: Float64 = 0.5
    static var linkCounts: HashMap<String, Int64> = HashMap<String, Int64>()
    static var componentUrls: HashMap<Int64, ArrayList<String>> = HashMap<Int64, ArrayList<String>>()
    // 根 List 的唯一 id（.id() 用），由 MarkdownComponent 在 aboutToAppear 时注册
    // 子组件 onVisibleAreaChange 已考虑所有祖先裁剪，不再需要查询 List rect
    static var listRootId: String = ""
    static var listIdCounter: Int64 = 0

    /**
     * 设置曝光回调
     * 由MarkdownComponent在aboutToAppear时调用
     *
     * @param cb 回调函数 (MarkdownExposureEvent: { eventType, visible, data })
     */
    public static func setExposureCallback(cb: (MarkdownExposureEvent) -> Unit): Unit {
        exposureCallback = cb
    }

    /**
     * 设置曝光阈值
     * 由MarkdownComponent在aboutToAppear时调用
     * 阈值范围 [0, 1]：>1 按 1 处理（完全可见才报），<0 按 0 处理（漏出即报）
     *
     * @param threshold 0~1，链接与可见区交集面积/链接面积 ≥ 此值才算可见
     */
    public static func setExposureThreshold(threshold: Float64): Unit {
        var t = threshold
        if (t > 1.0) {
            t = 1.0
        } else if (t < 0.0) {
            t = 0.0
        }
        exposureThreshold = t
    }

    /**
     * 生成根 List 的唯一 id（MarkdownComponent aboutToAppear 时调用一次）
     * @return 形如 "md-list-0" 的唯一 id
     */
    public static func generateListId(): String {
        let id = "md-list-${listIdCounter}"
        listIdCounter = listIdCounter + 1
        return id
    }

    /**
     * 设置根 List 的 id
     * @param id 由 generateListId 生成
     */
    public static func setListRootId(id: String): Unit {
        listRootId = id
    }

    /**
     * 获取根 List 的 id
     * @return 根 List 的 id
     */
    public static func getListRootId(): String {
        return listRootId
    }

    /**
     * 是否已设置曝光回调
     * 子组件用此方法判断是否启用曝光，不依赖 @Prop 的 MarkdownConfiguration.elementExposureCallback
     *（@Prop 对 @Observed 类的深拷贝可能丢失 Option<Function> 字段）
     */
    public static func isExposureEnabled(): Bool {
        return exposureCallback.isSome()
    }

    /**
     * 获取曝光阈值
     * 子组件用此方法获取阈值，不依赖 @Prop 的 MarkdownConfiguration.exposureThreshold
     */
    public static func getExposureThreshold(): Float64 {
        return exposureThreshold
    }

    /**
     * 注册组件包含的http链接
     * count从0→1的URL报visible=true
     * 幂等：同一nodeHash重复register直接返回（用于onVisibleAreaChange多次触发场景）
     *
     * @param nodeHash 组件节点hash
     * @param urls 组件包含的http链接URL列表
     */
    public static func register(nodeHash: Int64, urls: ArrayList<String>): Unit {
        if (urls.size == 0) {
            return
        }
        // 幂等：已注册过则跳过（避免ratio回调多次触发导致重复计数）
        if (componentUrls.contains(nodeHash)) {
            return
        }
        componentUrls[nodeHash] = urls
        for (url in urls) {
            let count = linkCounts.get(url) ?? Int64(0)
            if (count == 0) {
                if (let Some(cb) <- exposureCallback) {
                    cb(MarkdownExposureEvent(eventType: "link", visible: true, data: url))
                }
            }
            linkCounts[url] = count + 1
        }
    }

    /**
     * 注销组件包含的http链接
     * count从1→0的URL报visible=false
     *
     * @param nodeHash 组件节点hash
     */
    public static func unregister(nodeHash: Int64): Unit {
        if (let Some(urls) <- componentUrls.get(nodeHash)) {
            for (url in urls) {
                let count = linkCounts.get(url) ?? Int64(0)
                if (count > 0) {
                    let newCount = count - 1
                    if (newCount == 0) {
                        linkCounts.remove(url)
                        if (let Some(cb) <- exposureCallback) {
                            cb(MarkdownExposureEvent(eventType: "link", visible: false, data: url))
                        }
                    } else {
                        linkCounts[url] = newCount
                    }
                }
            }
            componentUrls.remove(nodeHash)
        }
    }

    /**
     * 清空组件数据（linkCounts + componentUrls），但保留回调
     * 由MarkdownComponent在aboutToDisappear时调用
     * 不清 exposureCallback：避免 MarkdownComponent 重建后 @Prop 深拷贝丢失回调导致 registry 为空
     */
    public static func clearData(): Unit {
        linkCounts.clear()
        componentUrls.clear()
    }

    /**
     * 清空所有数据（含回调+阈值+根 List id）
     * 由页面在aboutToDisappear时调用（非 MarkdownComponent 的 aboutToDisappear）
     */
    public static func clear(): Unit {
        exposureCallback = None
        exposureThreshold = 0.5
        listRootId = ""
        linkCounts.clear()
        componentUrls.clear()
    }

    /**
     * 递归提取NodeView子树中所有http链接URL（去重）
     * 优化：用HashSet做去重，避免ArrayList.contains的O(K)线性查找（原O(K²)→现O(K)）
     *
     * @param node 节点
     * @return 去重后的http链接URL列表
     */
    public static func extractHttpLinks(node: NodeView): ArrayList<String> {
        let seen = HashSet<String>()
        let urls = ArrayList<String>()
        collectHttpLinks(node, seen, urls)
        return urls
    }

    /**
     * 递归收集http链接URL到urls（用seen去重）
     */
    private static func collectHttpLinks(node: NodeView, seen: HashSet<String>, urls: ArrayList<String>): Unit {
        if (let Some(url) <- node.linkUrl) {
            if (url.startsWith("http://") || url.startsWith("https://")) {
                if (!seen.contains(url)) {
                    seen.add(url)
                    urls.add(url)
                }
            }
        }
        for (child in node.children) {
            collectHttpLinks(child, seen, urls)
        }
    }
}
