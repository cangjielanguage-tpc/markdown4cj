package markdown_parser.plugin

public class CardBean  {
    private var description: ?String
    private var destination: ?String
    private var title: ?String

    init(description: ?String, destination: ?String, title: ?String) {
        this.description = description
        this.destination = destination
        this.title = title
    }

    public func getDescription(): ?String {
        return description
    }

    public func getDestination(): ?String {
        return destination
    }

    public func getTitle(): ?String {
        return title
    }
}
