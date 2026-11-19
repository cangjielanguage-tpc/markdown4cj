// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester {
    @TestCase
    public func test1(): Unit {
        let md = Markdown.builder().usePlugin(CodeListPlugin.create()).build()

        let node = md.parse("""
```java [g-t]
public class Main {
public static void main(String[] args) {
System.out.print("你好力扣");
}
}
```
asd
asd
```python [-t]
print "你好力扣"
```
""")
        printNode(node)
        println((node.getFirstChild()() as FencedCodeBlock)?.getInfo())
        println((node.getLastChild()() as FencedCodeBlock)?.getInfo())

        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
    
    @TestCase
    public func test2(): Unit {
        let md = Markdown.builder().usePlugin(CodeListPlugin.create()).build()
        let node = md.parse("""
```java [solution1-Java 答案]
public class Main {
    public static void main(String[] args) {
        System.out.print(\"你好力扣\");
    }
}
```
```python [solution1-Python 答案]
print \"你好力扣\"
```
""")
        printNode(node)

        let nodeView = md.render(node)
        printNode(node)
        printNode(nodeView)
        /*
Document{} view:{Document{}}
    FencedCodeBlockListBlock{name:solution1, tabs=[Java 答案, Python 答案]} view:{FencedCodeBlockListBlock{name:solution1, tabs=[Java 答案, Python 答案]}}
        FencedCodeBlock{} view:{FencedCodeBlock{}}
        FencedCodeBlock{} view:{FencedCodeBlock{}}
        */
    }
    
    @TestCase
    public func test3(): Unit {
        let md = Markdown.builder().usePlugin(CodeListPlugin.create()).build()
        printNode(md.parse("```java [solution1-Java 答案]\n```"))
        printNode(md.parse("```java [solution1-Java 答案-asdadas]\n```"))
        printNode(md.parse("```java [-Java 答案]\n```"))
        printNode(md.parse("```java [-]\n```"))
        printNode(md.parse("```java []\n```"))
        printNode(md.parse("```java [solution1-]\n```"))
        printNode(md.parse("```java []\n```"))
        printNode(md.parse("``` [solution1-Java 答案]\n```"))
        printNode(md.parse("``` []\n```"))
        printNode(md.parse("``` [-Java 答案]\n```"))
        printNode(md.parse("``` [-]\n```"))
    }
    
    @TestCase
    public func test4(): Unit {
        let md = Markdown.builder().usePlugin(CodeListPlugin.create()).build()
        var (islist,name,tab,lang) = matches("")
        // println("${islist},${name},${tab},${lang}")
        (islist,name,tab,lang) = matches("java [solution1-Java 答案]")
        println("${islist},${name},${tab},${lang}")

        (islist,name,tab,lang) = matches("java []")
        println("${islist},${name},${tab},${lang}")
        
        (islist,name,tab,lang) = matches(" [solution1-Java 答案]")
        println("${islist},${name},${tab},${lang}")

        (islist,name,tab,lang) = matches(" []")
        println("${islist},${name},${tab},${lang}")

        (islist,name,tab,lang) = matches(" [-Java 答案]")
        println("${islist},${name},${tab},${lang}")

        (islist,name,tab,lang) = matches(" [-]")
        println("${islist},${name},${tab},${lang}")
    }
    
    private static let reg = Regex(#"(.*) \[([^\[\]]*?)\]"#)
    /*
     * @return (isCodeList, ListName, TabName, Lang)
     */
    private static func matches(info: String): (Bool, String, String, String) {
        return match (reg.matcher(info).find()) {
            case Some(data) =>
                let (lang, str) = match (data.groupNumber()) {
                    case 1 => (data.matchString(1).trimAscii(), "")
                    case 2 => (data.matchString(1).trimAscii(), data.matchString(2))
                    case _ => ("", "")
                }
                let arr = str.split("-")
                match (arr.size) {
                    case 0 => (true, "", lang, lang)
                    case 1 => (true, arr[0], lang, lang)
                    case _ =>
                        var tabname = arr[1].trimAscii()
                        if (tabname.size == 0) {
                            tabname = lang
                        }
                        (true, arr[0], tabname, lang)
                }
            case _ => (false, "", "", "")
        }
    }

    @TestCase
    public func test5(): Unit {
        let md = Markdown.builder().usePlugin(CodeListPlugin.create()).build()
        let node = md.parse("""
2.  Find the following code block on line 21:

    ```java [solution1-Java 答案]
    public class Main {
        public static void main(String[] args) {
            System.out.print(\"你好力扣\");
        }
    }
    ```
    ```python [solution1-Python 答案]
    print \"你好力扣\"
    ```
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func test6(): Unit {
        let md = Markdown.builder().usePlugin(CodeListPlugin.create()).build()
        let node = md.parse("""
> # 这是一个链接 [百~~度大法~~好](https://markdown.com.cn)。
>>`cangjie`
>>>#### 这是一个标题
>>>>**这几个字加粗了**
>>>>>*这几个字变斜了*
>>>>>> ```go [-go语言]
           package main
            import "fmt"
            func main() {
            fmt.Println("Hello, World!")
            }
        ```
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }

    @TestCase
    public func test7(): Unit {
        let md = Markdown.builder().usePlugin(CodeListPlugin.create()).build()
        let node = md.parse("""
```go [-go语言]
    package main
    import "fmt"
    func main() {
    fmt.Println("Hello, World!")
    }
```
```java [-]
    package main
    import "fmt"
    func main() {
    fmt.Println("Hello, World!")
    }
```
```js []
    package main
    import "fmt"
    func main() {
    fmt.Println("Hello, World!")
    }
```
""")
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(nodeView.childrenSize)
        printNode(nodeView)
    }
}
