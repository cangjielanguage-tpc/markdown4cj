// DEPENDENCE: z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test
// EXEC: ./main 
@Test
public class LinkifyTest {
    @TestCase
    public func test3(): Unit {
        let str = #"""
# http://1.com asdasda https://11.com
* https://2.com
  - [X] **http://3.com** https://4.com


http://50.comasd


http://5.com
https://6.com  
http://7.com https://8.com  
[http://10.com](url) [http://11.com](url) 
"""#
        // let str = "http://7.com https://8.com https://9.com"
        // let str = "[http://1.com](url)\n\n\n\nhttp://2.com"
        let node = md.parse(str)
        printNode(node)
        let nodeView = md.render(node)
        printNode(node)
        printNode(nodeView)
    }
}

/*
[07-30 18:47:27] INFO - Document{}
[07-30 18:47:27] INFO -     Paragraph{}
[07-30 18:47:27] INFO -         Text{literal=""}
[07-30 18:47:27] INFO -     Heading{}
[07-30 18:47:27] INFO -         Text{literal=http://1.com asdasda https://11.com}
[07-30 18:47:27] INFO -     BulletList{}
[07-30 18:47:27] INFO -         ListItem{}
[07-30 18:47:27] INFO -             Paragraph{}
[07-30 18:47:27] INFO -                 Text{literal=https://2.com}
[07-30 18:47:27] INFO -             BulletList{}
[07-30 18:47:27] INFO -                 TaskListItem{isDone=true}
[07-30 18:47:27] INFO -                     Paragraph{}
[07-30 18:47:27] INFO -                         StrongEmphasis{}
[07-30 18:47:27] INFO -                             Text{literal=http://3.com}
[07-30 18:47:27] INFO -                         Text{literal= https://4.com}
[07-30 18:47:27] INFO -     Paragraph{}
[07-30 18:47:27] INFO -         Text{literal=http://50.comasd}
[07-30 18:47:27] INFO -     Paragraph{}
[07-30 18:47:27] INFO -         Text{literal=http://5.com}
[07-30 18:47:27] INFO -         SoftLineBreak{}
[07-30 18:47:27] INFO -         Text{literal=https://6.com}
[07-30 18:47:27] INFO -         HardLineBreak{}
[07-30 18:47:27] INFO -         Text{literal=http://7.com https://8.com}
[07-30 18:47:27] INFO -         HardLineBreak{}
[07-30 18:47:27] INFO -         Link{destination=url, title=None}
[07-30 18:47:27] INFO -             Text{literal=http://10.com}
[07-30 18:47:27] INFO -         Text{literal= }
[07-30 18:47:27] INFO -         Link{destination=url, title=None}
[07-30 18:47:27] INFO -             Text{literal=http://11.com}
[07-30 18:47:27] INFO -         Text{literal=}
[07-30 18:47:27] INFO -         SoftLineBreak{}
[07-30 18:47:27] INFO -         Text{literal=""}
[07-30 18:47:27] INFO -
[07-30 18:47:27] INFO - Document{} view:{Document{}}
[07-30 18:47:27] INFO -     Paragraph{} view:{Paragraph{}}
[07-30 18:47:27] INFO -         Text{literal=""} view:{Text{literal=""}}
[07-30 18:47:27] INFO -     Heading{} view:{Heading{}}
[07-30 18:47:27] INFO -         Link{destination=http://1.com, title=Some(http://1.com)} view:{Link{destination=http://1.com, title=Some(http://1.com)}Link{destination=http://1.com, title=Some(http://1.com)}}
[07-30 18:47:27] INFO -             Text{literal=http://1.com} view:{Text{literal=http://1.com}Link{destination=http://1.com, title=Some(http://1.com)}}
[07-30 18:47:27] INFO -         Text{literal= asdasda } view:{Text{literal= asdasda }}
[07-30 18:47:27] INFO -         Link{destination=https://11.com, title=Some(https://11.com)} view:{Link{destination=https://11.com, title=Some(https://11.com)}Link{destination=https://11.com, title=Some(https://11.com)}}
[07-30 18:47:27] INFO -             Text{literal=https://11.com} view:{Text{literal=https://11.com}Link{destination=https://11.com, title=Some(https://11.com)}}
[07-30 18:47:27] INFO -     BulletList{} view:{BulletList{}{BulletList{},bulletListDepth:0}}
[07-30 18:47:27] INFO -         ListItem{} view:{ListItem{}{BulletList{},bulletListDepth:0}}
[07-30 18:47:27] INFO -             Paragraph{} view:{Paragraph{}{BulletList{},bulletListDepth:0}}
[07-30 18:47:27] INFO -                 Link{destination=https://2.com, title=Some(https://2.com)} view:{Link{destination=https://2.com, title=Some(https://2.com)}Link{destination=https://2.com, title=Some(https://2.com)}{BulletList{},bulletListDepth:0}}
[07-30 18:47:27] INFO -                     Text{literal=https://2.com} view:{Text{literal=https://2.com}Link{destination=https://2.com, title=Some(https://2.com)}{BulletList{},bulletListDepth:0}}
[07-30 18:47:27] INFO -             BulletList{} view:{BulletList{}{BulletList{},bulletListDepth:1}}
[07-30 18:47:27] INFO -                 TaskListItem{isDone=true} view:{TaskListItem{isDone=true}{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -                     Paragraph{} view:{Paragraph{}{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -                         StrongEmphasis{} view:{StrongEmphasis{}StrongEmphasis{}{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -                             Link{destination=http://3.com, title=Some(http://3.com)} view:{Link{destination=http://3.com, title=Some(http://3.com)}StrongEmphasis{}Link{destination=http://3.com, title=Some(http://3.com)}{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -                                 Text{literal=http://3.com} view:{Text{literal=http://3.com}StrongEmphasis{}Link{destination=http://3.com, title=Some(http://3.com)}{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -                         Text{literal= } view:{Text{literal= }{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -                         Link{destination=https://4.com, title=Some(https://4.com)} view:{Link{destination=https://4.com, title=Some(https://4.com)}Link{destination=https://4.com, title=Some(https://4.com)}{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -                             Text{literal=https://4.com} view:{Text{literal=https://4.com}Link{destination=https://4.com, title=Some(https://4.com)}{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -     Paragraph{} view:{Paragraph{}}
[07-30 18:47:27] INFO -         Link{destination=http://50.comasd, title=Some(http://50.comasd)} view:{Link{destination=http://50.comasd, title=Some(http://50.comasd)}Link{destination=http://50.comasd, title=Some(http://50.comasd)}}
[07-30 18:47:27] INFO -             Text{literal=http://50.comasd} view:{Text{literal=http://50.comasd}Link{destination=http://50.comasd, title=Some(http://50.comasd)}}
[07-30 18:47:27] INFO -     Paragraph{} view:{Paragraph{}}
[07-30 18:47:27] INFO -         Link{destination=http://5.com, title=Some(http://5.com)} view:{Link{destination=http://5.com, title=Some(http://5.com)}Link{destination=http://5.com, title=Some(http://5.com)}}
[07-30 18:47:27] INFO -             Text{literal=http://5.com} view:{Text{literal=http://5.com}Link{destination=http://5.com, title=Some(http://5.com)}}
[07-30 18:47:27] INFO -         SoftLineBreak{} view:{SoftLineBreak{}}
[07-30 18:47:27] INFO -         Link{destination=https://6.com, title=Some(https://6.com)} view:{Link{destination=https://6.com, title=Some(https://6.com)}Link{destination=https://6.com, title=Some(https://6.com)}}
[07-30 18:47:27] INFO -             Text{literal=https://6.com} view:{Text{literal=https://6.com}Link{destination=https://6.com, title=Some(https://6.com)}}
[07-30 18:47:27] INFO -         HardLineBreak{} view:{HardLineBreak{}}
[07-30 18:47:27] INFO -         Link{destination=http://7.com, title=Some(http://7.com)} view:{Link{destination=http://7.com, title=Some(http://7.com)}Link{destination=http://7.com, title=Some(http://7.com)}}
[07-30 18:47:27] INFO -             Text{literal=http://7.com} view:{Text{literal=http://7.com}Link{destination=http://7.com, title=Some(http://7.com)}}
[07-30 18:47:27] INFO -         Text{literal= } view:{Text{literal= }}
[07-30 18:47:27] INFO -         Link{destination=https://8.com, title=Some(https://8.com)} view:{Link{destination=https://8.com, title=Some(https://8.com)}Link{destination=https://8.com, title=Some(https://8.com)}}
[07-30 18:47:27] INFO -             Text{literal=https://8.com} view:{Text{literal=https://8.com}Link{destination=https://8.com, title=Some(https://8.com)}}
[07-30 18:47:27] INFO -         HardLineBreak{} view:{HardLineBreak{}}
[07-30 18:47:27] INFO -         Link{destination=url, title=None} view:{Link{destination=url, title=None}Link{destination=url, title=None}}
[07-30 18:47:27] INFO -             Text{literal=http://10.com} view:{Text{literal=http://10.com}Link{destination=url, title=None}}
[07-30 18:47:27] INFO -         Text{literal= } view:{Text{literal= }}
[07-30 18:47:27] INFO -         Link{destination=url, title=None} view:{Link{destination=url, title=None}Link{destination=url, title=None}}
[07-30 18:47:27] INFO -             Text{literal=http://11.com} view:{Text{literal=http://11.com}Link{destination=url, title=None}}
[07-30 18:47:27] INFO -         Text{literal=} view:{Text{literal=}}
[07-30 18:47:27] INFO -         SoftLineBreak{} view:{SoftLineBreak{}}
[07-30 18:47:27] INFO -         Text{literal=""} view:{Text{literal=""}}
[07-30 18:47:27] INFO -
[07-30 18:47:27] INFO - view:{Document{}}
[07-30 18:47:27] INFO -     view:{Paragraph{}}
[07-30 18:47:27] INFO -         view:{Text{literal=""}}
[07-30 18:47:27] INFO -     view:{Heading{}}
[07-30 18:47:27] INFO -         view:{Text{literal=http://1.com}Link{destination=http://1.com, title=Some(http://1.com)}}
[07-30 18:47:27] INFO -         view:{Text{literal= asdasda }}
[07-30 18:47:27] INFO -         view:{Text{literal=https://11.com}Link{destination=https://11.com, title=Some(https://11.com)}}
[07-30 18:47:27] INFO -     view:{BulletList{}{BulletList{},bulletListDepth:0}}
[07-30 18:47:27] INFO -         view:{ListItem{}{BulletList{},bulletListDepth:0}}
[07-30 18:47:27] INFO -             view:{Paragraph{}{BulletList{},bulletListDepth:0}}
[07-30 18:47:27] INFO -                 view:{Text{literal=https://2.com}Link{destination=https://2.com, title=Some(https://2.com)}{BulletList{},bulletListDepth:0}}
[07-30 18:47:27] INFO -             view:{BulletList{}{BulletList{},bulletListDepth:1}}
[07-30 18:47:27] INFO -                 view:{TaskListItem{isDone=true}{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -                     view:{Paragraph{}{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -                         view:{Text{literal=http://3.com}StrongEmphasis{}Link{destination=http://3.com, title=Some(http://3.com)}{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -                         view:{Text{literal= }{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -                         view:{Text{literal=https://4.com}Link{destination=https://4.com, title=Some(https://4.com)}{BulletList{},bulletListDepth:1}{TaskDepth:Some(0)}}
[07-30 18:47:27] INFO -     view:{Paragraph{}}
[07-30 18:47:27] INFO -         view:{Text{literal=http://50.comasd}Link{destination=http://50.comasd, title=Some(http://50.comasd)}}
[07-30 18:47:27] INFO -     view:{Paragraph{}}
[07-30 18:47:27] INFO -         view:{Text{literal=http://5.com}Link{destination=http://5.com, title=Some(http://5.com)}}
[07-30 18:47:27] INFO -         view:{SoftLineBreak{}}
[07-30 18:47:27] INFO -         view:{Text{literal=https://6.com}Link{destination=https://6.com, title=Some(https://6.com)}}
[07-30 18:47:27] INFO -         view:{HardLineBreak{}}
[07-30 18:47:27] INFO -         view:{Text{literal=http://7.com}Link{destination=http://7.com, title=Some(http://7.com)}}
[07-30 18:47:27] INFO -         view:{Text{literal= }}
[07-30 18:47:27] INFO -         view:{Text{literal=https://8.com}Link{destination=https://8.com, title=Some(https://8.com)}}
[07-30 18:47:27] INFO -         view:{HardLineBreak{}}
[07-30 18:47:27] INFO -         view:{Text{literal=http://10.com}Link{destination=url, title=None}}
[07-30 18:47:27] INFO -         view:{Text{literal= }}
[07-30 18:47:27] INFO -         view:{Text{literal=http://11.com}Link{destination=url, title=None}}
[07-30 18:47:27] INFO -         view:{Text{literal=}}
[07-30 18:47:27] INFO -         view:{SoftLineBreak{}}
[07-30 18:47:27] INFO -         view:{Text{literal=""}}
*/