// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main 
@Test
public class HtmlNodeTester {
    @TestCase
    public func test5(): Unit {
        let str = #"
## Problemset
[problemset](https://dev.lingkou.xyz/problemset/)
https://dev.lingkou.xyz/problemset/


<br>


[problemset](https://dev.lingkou.xyz/problemset/all/)
https://dev.lingkou.xyz/problemset/all/
<br>
[problemset](https://dev.lingkou.xyz/problemset/all/)
https://dev.lingkou.xyz/problemset/all/

[foo]: /url
This is a paragraph with a [foo] link.
"#
        // let str = "$$\n\\mathbb{ABCD abcd}\n$$"
        let node = md.parse(str)
        printNode(node)
        // println(str)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        // let list = nodeView.children
        // println(refEq(list[0],list[1]))
        printNode(nodeView)
    }
}
/*
Document{}
    Heading{}
        Text{literal=Problemset}
    Paragraph{}
        Link{destination=https://dev.lingkou.xyz/problemset/, title=None}
            Text{literal=problemset}
        SoftLineBreak{}
        Text{literal=https://dev.lingkou.xyz/problemset/}
    HtmlBlock{}
    Paragraph{}
        Link{destination=https://dev.lingkou.xyz/problemset/all/, title=None}
            Text{literal=problemset}
        SoftLineBreak{}
        Text{literal=https://dev.lingkou.xyz/problemset/all/}
        SoftLineBreak{}
        HtmlInline{}
        SoftLineBreak{}
        Link{destination=https://dev.lingkou.xyz/problemset/all/, title=None}
            Text{literal=problemset}
        SoftLineBreak{}
        Text{literal=https://dev.lingkou.xyz/problemset/all/}
    LinkReferenceDefinition{}
    Paragraph{}
        Text{literal=This is a paragraph with a }
        Link{destination=/url, title=None}
            Text{literal=foo}
        Text{literal= link.}

view:{Document{}}
    view:{Heading{}}
        view:{Text{literal=Problemset}}
    view:{Paragraph{}}
        view:{Text{literal=problemset}Link{destination=https://dev.lingkou.xyz/problemset/, title=None}}
        view:{SoftLineBreak{}}
        view:{Text{literal=https://dev.lingkou.xyz/problemset/}}
    view:{HtmlBlock{}}
    view:{Paragraph{}}
        view:{Text{literal=problemset}Link{destination=https://dev.lingkou.xyz/problemset/all/, title=None}}
        view:{SoftLineBreak{}}
        view:{Text{literal=https://dev.lingkou.xyz/problemset/all/}}
        view:{SoftLineBreak{}}
        view:{HtmlInline{}}
        view:{SoftLineBreak{}}
        view:{Text{literal=problemset}Link{destination=https://dev.lingkou.xyz/problemset/all/, title=None}}
        view:{SoftLineBreak{}}
        view:{Text{literal=https://dev.lingkou.xyz/problemset/all/}}
    view:{LinkReferenceDefinition{}}
    view:{Paragraph{}}
        view:{Text{literal=This is a paragraph with a }}
        view:{Text{literal=foo}Link{destination=/url, title=None}}
        view:{Text{literal= link.}}
*/