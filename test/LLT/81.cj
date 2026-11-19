// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: main 
//--filter=*.test3
@Test
public class Tester1 {

    @TestCase
    public func test3(): Unit {
        let node = md.parse(#"""
- 第一种情况是我们使用了一个字符，即 $s[i]$ 进行解码，那么只要 $s[i] \\neq 0$，它就可以被解码成 $\\text{A} \\sim \\text{I}$ 中的某个字母。由于剩余的前 $i-1$ 个字符的解码方法数为 $f_{i-1}$，因此我们可以写出状态转移方程：

  $$
  f_i = f_{i-1}, \\quad 其中 ~ s[i] \\neq 0
  $$

$$
asd
$$
"""#)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        printNode(nodeView)
    }
}
