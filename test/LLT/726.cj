// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: main --show-all-output
//--filter=*.test3
@Test
public class Tester1 {

    @TestCase
    public func test3(): Unit {
        let node = md.parse(#"""
* Task lists:
- [ ] Not _done_
  - [X] **Done** with `X`
  - [x] ~~and~~ **or** small `x`
"""#)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        println(node.childrenSize)
        printNode(nodeView)
    }
}
@Test
func t1(): Unit {
    let reg = Regex(#"^\[[xX\s]\]\s+(.*)"#)
    var data = reg.matcher("[X] **Done** with `X`").find().getOrThrow()
    println("1.1 ${data.groupCount()}")
    println("1.2 ${data.matchPosition(0).start} ${data.matchPosition(0).end}")
    println("1.3 ${data.matchPosition(1).start} ${data.matchPosition(1).end}")
    
    data = reg.find("[X] **Done** with `X`",group:true).getOrThrow()
    println("2.1 ${data.groupCount()}")
    println("2.2 ${data.matchPosition(0).start} ${data.matchPosition(0).end}")
    println("2.3 ${data.matchPosition(1).start} ${data.matchPosition(1).end}")
}