// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public func test3(): Unit {
    let node = md.parse(#"*code, `not* emph`"#)
    printNode(node)
    let nodeView = md.render(node)
    printNode(node)
    printNode(nodeView)
}
