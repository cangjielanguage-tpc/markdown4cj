package markdown.plugin

public class TaskListItem <: ListItem {
    public static let TASK_DEPTH: String = "TaskDepth"
    static let typeInfo: String = "TaskListItem"
    private let done: Bool

    public init(isDone: Bool) {
        this.done = isDone
    }

    public func isDone(): Bool {
        return done
    }

    public func toString(): String {
        return "TaskListItem{isDone=${done}}"
    }

    public func getNodeType(): String {
        typeInfo
    }
}

public class TaskListPlugin <: AbstractMarkdownPlugin {
    public static func create(): TaskListPlugin {
        return TaskListPlugin()
    }

    private init() {}

    public func configureParser(builder: ParserBuilder): Unit {
        builder.postProcessor(TaskListPostProcessor())
    }

    public func configureVisitor(builder: MarkdownVisitorBuilder): Unit {
        builder.on(
            TaskListItem.typeInfo,
            {
                visitor, taskListItem => visitor.visitChildren(taskListItem)
            }
        )
    }

    public func getClassType(): String {
        "TaskListPlugin"
    }
}

class TaskListVisitor <: AbstractVisitor {
    public func visit(listItem: ListItem): Unit {
        // Takes first child and checks if it is Text (we are looking for exact `[xX\s]` without any formatting)
        // check if it is paragraph (can contain text)
        if (let Some(child: Paragraph) <- listItem.getFirstChild()) {
            if (let Some(textNode: Text) <- child.getFirstChild()) {
                let text: String = textNode.getLiteral()
                if (text.size >= 3 && text[0] == b'[' && (text[1] == b'x' || text[1] == b'X' || text[1] == b' ') &&
                    text[2] == b']') {
                    // append the rest of matched text (can be empty)
                    let restMatchedText: String = match (text.get(3)) {
                        case None => ""
                        case Some(" ") =>
                            if (text.size == 4) {
                                ""
                            } else {
                                text[4..]
                            }
                        case _ => return
                    }
                    let checked: Byte = text[1]
                    let isChecked: Bool = (checked == b'x') || (checked == b'X')

                    let taskListItem: TaskListItem = TaskListItem(isChecked)

                    let paragraph: Paragraph = Paragraph()

                    // insert before list item (directly before inside parent)
                    listItem.insertBefore(taskListItem)

                    if (restMatchedText.size != 0) {
                        paragraph.appendChild(Text(restMatchedText))
                    }

                    // move all the rest children (from the first paragraph)
                    ParserUtils.moveChildren(paragraph, textNode)

                    // append our created paragraph
                    taskListItem.appendChild(paragraph)

                    // move all the rest children from the listItem (further nested lists, etc)
                    ParserUtils.moveChildren(taskListItem, child)

                    // remove list item from node
                    listItem.unlink()

                    // visit taskListItem children
                    visitChildren(taskListItem)
                    return
                }
            }
        }
        visitChildren(listItem)
    }
}

// Hint taken from commonmark-ext-task-list-items artifact
class TaskListPostProcessor <: PostProcessor {
    public func process(node: Node): Node {
        let visitor: TaskListVisitor = TaskListVisitor()
        node.accept(visitor)
        return node
    }
}

public abstract class TaskListProps {
    public static let DONE: Prop<Bool> = Prop<Bool>("task-list-done")
    private init() {}
}
