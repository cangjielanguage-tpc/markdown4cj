package markdown_hybrid.components

import std.collection.HashMap
import std.collection.ArrayList

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

    /**
     * 设置曝光回调
     * 由MarkdownComponent在aboutToAppear时调用
     *
     * @param cb 回调函数 (MarkdownExposureEvent: { type, visible, data })
     */
    public static func setExposureCallback(cb: (MarkdownExposureEvent) -> Unit): Unit {
        exposureCallback = cb
    }

    /**
     * 设置曝光阈值
     * 由MarkdownComponent在aboutToAppear时调用
     *
     * @param threshold 0~1，链接与可见区交集面积/链接面积 ≥ 此值才算可见
     */
    public static func setExposureThreshold(threshold: Float64): Unit {
        exposureThreshold = threshold
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
                    cb(MarkdownExposureEvent(`type`: "link", visible: true, data: url))
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
                            cb(MarkdownExposureEvent(`type`: "link", visible: false, data: url))
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
     * 清空所有数据（含回调+阈值）
     * 由页面在aboutToDisappear时调用（非 MarkdownComponent 的 aboutToDisappear）
     */
    public static func clear(): Unit {
        exposureCallback = None
        exposureThreshold = 0.5
        linkCounts.clear()
        componentUrls.clear()
    }

    /**
     * 递归提取NodeView子树中所有http链接URL（去重）
     *
     * @param node 节点
     * @return 去重后的http链接URL列表
     */
    public static func extractHttpLinks(node: NodeView): ArrayList<String> {
        let urls = ArrayList<String>()
        if (let Some(url) <- node.linkUrl) {
            if (url.startsWith("http://") || url.startsWith("https://")) {
                if (!urls.contains(url)) {
                    urls.add(url)
                }
            }
        }
        for (child in node.children) {
            let childUrls = extractHttpLinks(child)
            for (u in childUrls) {
                if (!urls.contains(u)) {
                    urls.add(u)
                }
            }
        }
        return urls
    }
}
