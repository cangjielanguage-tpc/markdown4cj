// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main
@Test
public class Tester1 {

    @TestCase
    public func test3(): Unit {
        let node = md.parse(#"![hello_algo_hero.jpg](https://pic.leetcode.cn/1705312699-OKFDZL-hello_algo_hero.jpg){:width=100%}

扣友们好，我又来分享学习资源啦！
《Hello 算法》正式版终于发布了！
快来戳戳！
{:style="text-align: center;"}

⬇{:style="text-align: center;"}

---

![hello_algo_header.png](https://pic.leetcode.cn/1705313282-NKCHlR-hello_algo_header.png){:width=500}

*动画图解、一键运行的数据结构与算法教程* {:style="text-align: center;"}

[**代码仓库** >](https://github.com/krahets/hello-algo) &nbsp; &nbsp;  [**在线阅读** >](https://www.hello-algo.com) &nbsp; &nbsp; [**下载 PDF** >](https://github.com/krahets/hello-algo/releases) {:style="text-align: center;"}
"#)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        printNode(nodeView)
    }
}

/*
[08-27 11:06:17] INFO - Document{}
[08-27 11:06:17] INFO -     Paragraph{}
[08-27 11:06:17] INFO -         StyleImage{destination=https://pic.leetcode.cn/1705312699-OKFDZL-hello_algo_hero.jpg, title=None, styles=[:width=100%]}
[08-27 11:06:17] INFO -             Text{literal=hello_algo_hero.jpg}
[08-27 11:06:17] INFO -         Style{style=:width=100%}
[08-27 11:06:17] INFO -     Paragraph{}
[08-27 11:06:17] INFO -         Text{literal=扣友们好，我又来分享学习资源啦！}
[08-27 11:06:17] INFO -         SoftLineBreak{}
[08-27 11:06:17] INFO -         Text{literal=《Hello 算法》正式版终于发布了！}
[08-27 11:06:17] INFO -         SoftLineBreak{}
[08-27 11:06:17] INFO -         Text{literal=快来戳戳！}
[08-27 11:06:17] INFO -         SoftLineBreak{}
[08-27 11:06:17] INFO -         Style{style=:style="text-align: center;"}
[08-27 11:06:17] INFO -     Paragraph{}
[08-27 11:06:17] INFO -         Text{literal=⬇}
[08-27 11:06:17] INFO -         Style{style=:style="text-align: center;"}
[08-27 11:06:17] INFO -     ThematicBreak{}
[08-27 11:06:17] INFO -     Paragraph{}
[08-27 11:06:17] INFO -         StyleImage{destination=https://pic.leetcode.cn/1705313282-NKCHlR-hello_algo_header.png, title=None, styles=[:width=500]}
[08-27 11:06:17] INFO -             Text{literal=hello_algo_header.png}
[08-27 11:06:17] INFO -         Style{style=:width=500}
[08-27 11:06:17] INFO -     Paragraph{}
[08-27 11:06:17] INFO -         Emphasis{}
[08-27 11:06:17] INFO -             Text{literal=动画图解、一键运行的数据结构与算法教程}
[08-27 11:06:17] INFO -         Text{literal= }
[08-27 11:06:17] INFO -         Style{style=:style="text-align: center;"}
[08-27 11:06:17] INFO -     Paragraph{}
[08-27 11:06:17] INFO -         Link{destination=https://github.com/krahets/hello-algo, title=None}
[08-27 11:06:17] INFO -             StrongEmphasis{}
[08-27 11:06:17] INFO -                 Text{literal=代码仓库}
[08-27 11:06:17] INFO -             Text{literal= >}
[08-27 11:06:17] INFO -         Text{literal=      }
[08-27 11:06:17] INFO -         Link{destination=https://www.hello-algo.com, title=None}
[08-27 11:06:17] INFO -             StrongEmphasis{}
[08-27 11:06:17] INFO -                 Text{literal=在线阅读}
[08-27 11:06:17] INFO -             Text{literal= >}
[08-27 11:06:17] INFO -         Text{literal=     }
[08-27 11:06:17] INFO -         Link{destination=https://github.com/krahets/hello-algo/releases, title=None}
[08-27 11:06:17] INFO -             StrongEmphasis{}
[08-27 11:06:17] INFO -                 Text{literal=下载 PDF}
[08-27 11:06:17] INFO -             Text{literal= >}
[08-27 11:06:17] INFO -         Text{literal= }
[08-27 11:06:17] INFO -         Style{style=:style="text-align: center;"}
[08-27 11:06:17] INFO -
[08-27 11:06:17] INFO - Document{} view:{Document{}}
[08-27 11:06:17] INFO -     Paragraph{} view:{Paragraph{}}
[08-27 11:06:17] INFO -         StyleImage{destination=https://pic.leetcode.cn/1705312699-OKFDZL-hello_algo_hero.jpg, title=None, styles=[:width=100%]} view:{StyleImage{destination=https://pic.leetcode.cn/1705312699-OKFDZL-hello_algo_hero.jpg, title=None, styles=[:width=100%]}}
[08-27 11:06:17] INFO -             Text{literal=hello_algo_hero.jpg} view:{Text{literal=hello_algo_hero.jpg}}
[08-27 11:06:17] INFO -         Style{style=:width=100%} view:{Style{style=:width=100%}}
[08-27 11:06:17] INFO -     Paragraph{} view:{Paragraph{}}
[08-27 11:06:17] INFO -         Text{literal=扣友们好，我又来分享学习资源啦！} view:{Text{literal=扣友们好，我又来分享学习资源啦！}}
[08-27 11:06:17] INFO -         SoftLineBreak{} view:{SoftLineBreak{}}
[08-27 11:06:17] INFO -         Text{literal=《Hello 算法》正式版终于发布了！} view:{Text{literal=《Hello 算法》正式版终于发布了！}}
[08-27 11:06:17] INFO -         SoftLineBreak{} view:{SoftLineBreak{}}
[08-27 11:06:17] INFO -         Text{literal=快来戳戳！} view:{Text{literal=快来戳戳！}}
[08-27 11:06:17] INFO -         SoftLineBreak{} view:{SoftLineBreak{}}
[08-27 11:06:17] INFO -         Style{style=:style="text-align: center;"} view:{Style{style=:style="text-align: center;"}}
[08-27 11:06:17] INFO -     Paragraph{} view:{Paragraph{}}
[08-27 11:06:17] INFO -         Text{literal=⬇} view:{Text{literal=⬇}}
[08-27 11:06:17] INFO -         Style{style=:style="text-align: center;"} view:{Style{style=:style="text-align: center;"}}
[08-27 11:06:17] INFO -     ThematicBreak{} view:{ThematicBreak{}}
[08-27 11:06:17] INFO -     Paragraph{} view:{Paragraph{}}
[08-27 11:06:17] INFO -         StyleImage{destination=https://pic.leetcode.cn/1705313282-NKCHlR-hello_algo_header.png, title=None, styles=[:width=500]} view:{StyleImage{destination=https://pic.leetcode.cn/1705313282-NKCHlR-hello_algo_header.png, title=None, styles=[:width=500]}}
[08-27 11:06:17] INFO -             Text{literal=hello_algo_header.png} view:{Text{literal=hello_algo_header.png}}
[08-27 11:06:17] INFO -         Style{style=:width=500} view:{Style{style=:width=500}}
[08-27 11:06:17] INFO -     Paragraph{} view:{Paragraph{}}
[08-27 11:06:17] INFO -         Emphasis{} view:{Emphasis{}Emphasis{}}
[08-27 11:06:17] INFO -             Text{literal=动画图解、一键运行的数据结构与算法教程} view:{Text{literal=动画图解、一键运行的数据结构与算法教程}Emphasis{}}
[08-27 11:06:17] INFO -         Text{literal= } view:{Text{literal= }}
[08-27 11:06:17] INFO -         Style{style=:style="text-align: center;"} view:{Style{style=:style="text-align: center;"}}
[08-27 11:06:17] INFO -     Paragraph{} view:{Paragraph{}}
[08-27 11:06:17] INFO -         Link{destination=https://github.com/krahets/hello-algo, title=None} view:{Link{destination=https://github.com/krahets/hello-algo, title=None}Link{destination=https://github.com/krahets/hello-algo, title=None}}
[08-27 11:06:17] INFO -             StrongEmphasis{} view:{StrongEmphasis{}StrongEmphasis{}Link{destination=https://github.com/krahets/hello-algo, title=None}}
[08-27 11:06:17] INFO -                 Text{literal=代码仓库} view:{Text{literal=代码仓库}StrongEmphasis{}Link{destination=https://github.com/krahets/hello-algo, title=None}}
[08-27 11:06:17] INFO -             Text{literal= >} view:{Text{literal= >}Link{destination=https://github.com/krahets/hello-algo, title=None}}
[08-27 11:06:17] INFO -         Text{literal=      } view:{Text{literal=      }}
[08-27 11:06:17] INFO -         Link{destination=https://www.hello-algo.com, title=None} view:{Link{destination=https://www.hello-algo.com, title=None}Link{destination=https://www.hello-algo.com, title=None}}
[08-27 11:06:17] INFO -             StrongEmphasis{} view:{StrongEmphasis{}StrongEmphasis{}Link{destination=https://www.hello-algo.com, title=None}}
[08-27 11:06:17] INFO -                 Text{literal=在线阅读} view:{Text{literal=在线阅读}StrongEmphasis{}Link{destination=https://www.hello-algo.com, title=None}}
[08-27 11:06:17] INFO -             Text{literal= >} view:{Text{literal= >}Link{destination=https://www.hello-algo.com, title=None}}
[08-27 11:06:17] INFO -         Text{literal=     } view:{Text{literal=     }}
[08-27 11:06:17] INFO -         Link{destination=https://github.com/krahets/hello-algo/releases, title=None} view:{Link{destination=https://github.com/krahets/hello-algo/releases, title=None}Link{destination=https://github.com/krahets/hello-algo/releases, title=None}}
[08-27 11:06:17] INFO -             StrongEmphasis{} view:{StrongEmphasis{}StrongEmphasis{}Link{destination=https://github.com/krahets/hello-algo/releases, title=None}}
[08-27 11:06:17] INFO -                 Text{literal=下载 PDF} view:{Text{literal=下载 PDF}StrongEmphasis{}Link{destination=https://github.com/krahets/hello-algo/releases, title=None}}
[08-27 11:06:17] INFO -             Text{literal= >} view:{Text{literal= >}Link{destination=https://github.com/krahets/hello-algo/releases, title=None}}
[08-27 11:06:17] INFO -         Text{literal= } view:{Text{literal= }}
[08-27 11:06:17] INFO -         Style{style=:style="text-align: center;"} view:{Style{style=:style="text-align: center;"}}
[08-27 11:06:17] INFO -
[08-27 11:06:17] INFO - view:{Document{}}
[08-27 11:06:17] INFO -     view:{Paragraph{}}
[08-27 11:06:17] INFO -         view:{StyleImage{destination=https://pic.leetcode.cn/1705312699-OKFDZL-hello_algo_hero.jpg, title=None, styles=[:width=100%]}}
[08-27 11:06:17] INFO -             view:{Text{literal=hello_algo_hero.jpg}}
[08-27 11:06:17] INFO -         view:{Style{style=:width=100%}}
[08-27 11:06:17] INFO -     view:{Paragraph{}}
[08-27 11:06:17] INFO -         view:{Text{literal=扣友们好，我又来分享学习资源啦！}}
[08-27 11:06:17] INFO -         view:{SoftLineBreak{}}
[08-27 11:06:17] INFO -         view:{Text{literal=《Hello 算法》正式版终于发布了！}}
[08-27 11:06:17] INFO -         view:{SoftLineBreak{}}
[08-27 11:06:17] INFO -         view:{Text{literal=快来戳戳！}}
[08-27 11:06:17] INFO -         view:{SoftLineBreak{}}
[08-27 11:06:17] INFO -         view:{Style{style=:style="text-align: center;"}}
[08-27 11:06:17] INFO -     view:{Paragraph{}}
[08-27 11:06:17] INFO -         view:{Text{literal=⬇}}
[08-27 11:06:17] INFO -         view:{Style{style=:style="text-align: center;"}}
[08-27 11:06:17] INFO -     view:{ThematicBreak{}}
[08-27 11:06:17] INFO -     view:{Paragraph{}}
[08-27 11:06:17] INFO -         view:{StyleImage{destination=https://pic.leetcode.cn/1705313282-NKCHlR-hello_algo_header.png, title=None, styles=[:width=500]}}
[08-27 11:06:17] INFO -             view:{Text{literal=hello_algo_header.png}}
[08-27 11:06:17] INFO -         view:{Style{style=:width=500}}
[08-27 11:06:17] INFO -     view:{Paragraph{}}
[08-27 11:06:17] INFO -         view:{Text{literal=动画图解、一键运行的数据结构与算法教程}Emphasis{}}
[08-27 11:06:17] INFO -         view:{Text{literal= }}
[08-27 11:06:17] INFO -         view:{Style{style=:style="text-align: center;"}}
[08-27 11:06:17] INFO -     view:{Paragraph{}}
[08-27 11:06:17] INFO -         view:{Text{literal=代码仓库}StrongEmphasis{}Link{destination=https://github.com/krahets/hello-algo, title=None}}
[08-27 11:06:17] INFO -         view:{Text{literal= >}Link{destination=https://github.com/krahets/hello-algo, title=None}}
[08-27 11:06:17] INFO -         view:{Text{literal=      }}
[08-27 11:06:17] INFO -         view:{Text{literal=在线阅读}StrongEmphasis{}Link{destination=https://www.hello-algo.com, title=None}}
[08-27 11:06:17] INFO -         view:{Text{literal= >}Link{destination=https://www.hello-algo.com, title=None}}
[08-27 11:06:17] INFO -         view:{Text{literal=     }}
[08-27 11:06:17] INFO -         view:{Text{literal=下载 PDF}StrongEmphasis{}Link{destination=https://github.com/krahets/hello-algo/releases, title=None}}
[08-27 11:06:17] INFO -         view:{Text{literal= >}Link{destination=https://github.com/krahets/hello-algo/releases, title=None}}
[08-27 11:06:17] INFO -         view:{Text{literal= }}
[08-27 11:06:17] INFO -         view:{Style{style=:style="text-align: center;"}}
*/