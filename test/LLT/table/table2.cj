// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main 
//--filter=t36

import commonmark4cj.commonmark.*
import commonmark4cj.table.*

let EXTENSIONS: Array<Extension> = [TablesExtension.create()]
let mdParser: Parser = Parser.builder().extensions(EXTENSIONS).build()

@Test
func t35(): Unit {
    let str = #"Abc|Def
-|-
|b11|b12|
"#
    let node = mdParser.parse(str)
    printNode(node)
    @Assert(node.getLastChild()() is TableBlock)
}

@Test
func t36(): Unit {
    let str = #"Abc|
---|
1|"#
    let node = mdParser.parse(str)
    printNode(node)
    @Assert(node.getLastChild()() is TableBlock)
}
