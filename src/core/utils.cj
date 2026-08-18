package markdown_parser.core

public abstract class ParserUtils {
    public static func moveChildren(to: Node, froms: Node): Unit {
        var next: ?Node = froms.getNext()
        var temp: ?Node
        while (let Some(n) <- next) {
            // appendChild would unlink passed node (thus making next info un-available)
            temp = n.getNext()
            to.appendChild(n)
            next = temp
        }
    }
}
