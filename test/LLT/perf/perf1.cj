// RESOURCES: spec.md
// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
internal import markdown_parser.core.*
internal import markdown_parser.plugin.*
internal import commonmark4cj.commonmark.*
internal import commonmark4cj.table.*
internal import commonmark4cj.strikethrough.*
internal import std.collection.*

// @Test
public func perf_spec(): Unit {
    let mdstr = String.fromUtf8(File.readFrom("spec.md"))
    for (_ in 0..1000) {
        md.parse(mdstr)
    }
}