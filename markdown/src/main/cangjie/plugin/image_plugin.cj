package markdown.plugin

class Style <: CustomNode {
    Style(let style: String) {}
    public func getNodeType(): String {
        "Style"
    }
    protected func toStringAttributes(): String {
        return "style=${style}"
    }
}

class StyleDelimiterProcessor <: DelimiterProcessor {
    public func getOpeningCharacter(): Rune {
        return r'{'
    }
    public func getClosingCharacter(): Rune {
        return r'}'
    }
    public func getMinLength(): Int {
        return 1
    }
    public func getDelimiterUse(_: DelimiterRun, _: DelimiterRun): Int {
        return 1
    }
    let reg = Regex("^:(style|align|width|height|border-radius)=")
    public override func process(openingRun: DelimiterRun, closingRun: DelimiterRun): Int {
        let opener = openingRun.getOpener()
        let closer = closingRun.getCloser()
        if (process(opener, closer)) {
            return 1
        } else {
            return 0
        }
    }

    /*
     * 处理style
     * @return true 合法的style转换为Style节点
     *        false 非法的style降级为Text节点
     */
    func process(opener: Text, closer: Text): Bool {
        // 处理style
        let strBuilder = StringBuilder()
        for (n in Nodes.between(opener, closer)) {
            if (let n: Text <- n) {
                strBuilder.append(n.getLiteral())
            } else {
                return false
            }
        }
        let str = strBuilder.toString()
        if (reg.matches(str)) {
            // 处理style前的Image
            if (let Some(image: Image) <- opener.getPrevious()) {
                match (image) {
                    case v: StyleImage => v.styles.add(str)
                    case _ =>
                        let styleImage = StyleImage(str, image)
                        image.replaceWith(styleImage)
                }
                for (n in Nodes.between(opener, closer)) {
                    n.unlink()
                }
                return true
            }
        }
        return false
    }
}

public class SlideBlock <: CustomBlock {
    public func getNodeType(): String {
        "SlideBlock"
    }
}

public class StyleImage <: Image {
    static let typeInfo = "StyleImage"
    public let styles: ArrayList<String> = ArrayList<String>()
    init(style: String, img: Image) {
        super(img.getDestination(), img.getTitle())
        this.styles.add(style)
    }
    protected func toStringAttributes(): String {
        return "${super.toStringAttributes()}, styles=${styles}"
    }
    public func getNodeType(): String {
        typeInfo
    }
}

public class ImgVideo <: Image {
    public var text: String
    init(text: String, dest: String, title: ?String) {
        super(dest, title)
        this.text = text
    }
    protected func toStringAttributes(): String {
        return "text=${text},dest=${getDestination()},title=${getTitle()}"
    }
    public func getNodeType(): String {
        typeInfo
    }
    static let typeInfo = "ImgVideo"
    static let reg = Regex("[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}")
    static func isImgVideo(dest: String): Bool {
        reg.matches(dest)
    }
}
