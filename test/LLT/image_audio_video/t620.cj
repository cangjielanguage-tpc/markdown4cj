// DEPENDENCE: ../z_test.cj
// EXEC: cjc %import-path %L %l %f z_test.cj --test --debug-macro
// EXEC: ./main
// --filter=t11
import std.collection.*
/*
Document{}
    Paragraph{}
        Text{literal=audio}
    BlockAudio{}
        Image{destination=1.mp3, title=None}
    BlockAudio{}
        Image{destination=1.wav, title=None}
    BlockAudio{}
        Image{destination=1.aac, title=None}
    BlockAudio{}
        Image{destination=1.flac, title=None}
    Paragraph{}
        Text{literal= asdasd }
    BlockAudio{}
        Image{destination=1.ogg, title=None}
    BlockAudio{}
        Image{destination=1.m4a, title=None}
    BlockAudio{}
        Image{destination=1.wma, title=None}
    BlockAudio{}
        Image{destination=1.amr, title=None}
    Paragraph{}
        Image{destination=1.png, title=None}

view:{Document{}}
    view:{Paragraph{}}
        view:{Text{literal=audio}}
    view:{BlockAudio{}}
        view:{Image{destination=1.mp3, title=None}}   
    view:{BlockAudio{}}
        view:{Image{destination=1.wav, title=None}}   
    view:{BlockAudio{}}
        view:{Image{destination=1.aac, title=None}}   
    view:{BlockAudio{}}
        view:{Image{destination=1.flac, title=None}}  
    view:{Paragraph{}}
        view:{Text{literal= asdasd }}
    view:{BlockAudio{}}
        view:{Image{destination=1.ogg, title=None}}   
    view:{BlockAudio{}}
        view:{Image{destination=1.m4a, title=None}}   
    view:{BlockAudio{}}
        view:{Image{destination=1.wma, title=None}}   
    view:{BlockAudio{}}
        view:{Image{destination=1.amr, title=None}}   
    view:{Paragraph{}}
        view:{Image{destination=1.png, title=None}}   
*/
@Test
func audio(): Unit {
    let md: Markdown = Markdown.builder().usePlugin(BlockAudioPlugin()).build()
    var str = #"audio![](1.mp3)![](1.wav)![](1.aac)![](1.flac) asdasd ![](1.ogg)![](1.m4a)![](1.wma)![](1.amr)![](1.png)"#
    // str = #"接下来将执行任务3：文生图。![](1.mp3)![](1.wav)![](1.aac)![](1.flac) asdasd "#
    let node = md.parse(str)
    printNode(node)
    let view = md.render(node)
    printNode(view)
    @Assert(view[0] is Paragraph)
    @Assert(view[1] is BlockAudio)
    @Assert(view[2] is BlockAudio)
    @Assert(view[3] is BlockAudio)
    @Assert(view[4] is BlockAudio)
    @Assert(view[5] is Paragraph)
    @Assert(view[6] is BlockAudio)
    @Assert(view[7] is BlockAudio)
    @Assert(view[8] is BlockAudio)
    @Assert(view[9] is BlockAudio)
    @Assert(view.children[10] is Paragraph)
}

/*
Document{}
    Paragraph{}
        Text{literal=video}
    BlockVideo{}
        Image{destination=1.mp4, title=None}
    BlockVideo{}
        Image{destination=1.mov, title=None}
    BlockVideo{}
        Image{destination=1.avi, title=None}
    BlockVideo{}
        Image{destination=1.mkv, title=None}
    Paragraph{}
        Text{literal= asdasd }
    BlockVideo{}
        Image{destination=1.wmv, title=None}
    BlockVideo{}
        Image{destination=1.m4v, title=None}
    BlockVideo{}
        Image{destination=1.flv, title=None}
    BlockVideo{}
        Image{destination=1.webm, title=None}
    BlockVideo{}
        Image{destination=1.3gp, title=None}
    Paragraph{}
        Image{destination=1.png, title=None}

view:{Document{}}
    view:{Paragraph{}}
        view:{Text{literal=video}}
    view:{BlockVideo{}}
        view:{Image{destination=1.mp4, title=None}}   
    view:{BlockVideo{}}
        view:{Image{destination=1.mov, title=None}}   
    view:{BlockVideo{}}
        view:{Image{destination=1.avi, title=None}}   
    view:{BlockVideo{}}
        view:{Image{destination=1.mkv, title=None}}   
    view:{Paragraph{}}
        view:{Text{literal= asdasd }}
    view:{BlockVideo{}}
        view:{Image{destination=1.wmv, title=None}}   
    view:{BlockVideo{}}
        view:{Image{destination=1.m4v, title=None}}   
    view:{BlockVideo{}}
        view:{Image{destination=1.flv, title=None}}   
    view:{BlockVideo{}}
        view:{Image{destination=1.webm, title=None}}  
    view:{BlockVideo{}}
        view:{Image{destination=1.3gp, title=None}}   
    view:{Paragraph{}}
        view:{Image{destination=1.png, title=None}}   
*/
@Test
func video(): Unit {
    let md: Markdown = Markdown.builder().usePlugin(BlockVideoPlugin()).build()
    var str = #"video![](1.mp4)![](1.mov)![](1.avi)![](1.mkv) asdasd ![](1.wmv)![](1.m4v)![](1.flv)![](1.webm)![](1.3gp)![](1.png)"#
    let node = md.parse(str)
    printNode(node)
    let view = md.render(node)
    printNode(view)
    @Assert(view[0] is Paragraph)
    @Assert(view[1] is BlockVideo)
    @Assert(view[2] is BlockVideo)
    @Assert(view[3] is BlockVideo)
    @Assert(view[4] is BlockVideo)
    @Assert(view[5] is Paragraph)
    @Assert(view[6] is BlockVideo)
    @Assert(view[7] is BlockVideo)
    @Assert(view[8] is BlockVideo)
    @Assert(view[9] is BlockVideo)
    @Assert(view.children[10] is BlockVideo)
    @Assert(view.children[11] is Paragraph)
}

/*
Document{}
    Paragraph{}
        Text{literal=video&audio}
    BlockVideo{}
        Image{destination=1.mp4, title=None}
    BlockAudio{}
        Image{destination=1.mp3, title=None}
    Paragraph{}
        Text{literal=asdasd }
    BlockVideo{}
        Image{destination=1.wmv, title=None}
    BlockAudio{}
        Image{destination=1.wma, title=None}
    Paragraph{}
        Image{destination=1.png, title=None}

view:{Document{}}
    view:{Paragraph{}}
        view:{Text{literal=video&audio}}
    view:{BlockVideo{}}
        view:{Image{destination=1.mp4, title=None}}  
    view:{BlockAudio{}}
        view:{Image{destination=1.mp3, title=None}}  
    view:{Paragraph{}}
        view:{Text{literal=asdasd }}
    view:{BlockVideo{}}
        view:{Image{destination=1.wmv, title=None}}  
    view:{BlockAudio{}}
        view:{Image{destination=1.wma, title=None}}  
    view:{Paragraph{}}
        view:{Image{destination=1.png, title=None}}  
*/
@Test
func va(): Unit {
    let md: Markdown = Markdown.builder().usePlugin(BlockAudioPlugin()).usePlugin(BlockVideoPlugin()).build()
    var str = #"video&audio![](1.mp4)![](1.mp3)asdasd ![](1.wmv)![](1.wma)![](1.png)"#
    let node = md.parse(str)
    printNode(node)
    let view = md.render(node)
    printNode(view)
    @Assert(view[0] is Paragraph)
    @Assert(view[1] is BlockVideo)
    @Assert(view[2] is BlockAudio)
    @Assert(view[3] is Paragraph)
    @Assert(view[4] is BlockVideo)
    @Assert(view[5] is BlockAudio)
    @Assert(view[6] is Paragraph)
}

/*
Document{}
    Paragraph{}
        Text{literal=video&audio}
    BlockVideo{}
        Image{destination=1.mp4, title=None}
    BlockAudio{}
        Image{destination=1.mp3, title=None}
    Paragraph{}
        Text{literal=asdasd }
    BlockVideo{}
        Image{destination=1.wmv, title=None}
    BlockAudio{}
        Image{destination=1.wma, title=None}
    Paragraph{}
        Image{destination=1.png, title=None}

view:{Document{}{links:Some([1.mp4, 1.wmv, 1.png])}} 
    view:{Paragraph{}}
        view:{Text{literal=video&audio}}
    view:{BlockVideo{}}
        view:{Image{destination=1.mp4, title=None}}  
    view:{BlockAudio{}}
        view:{Image{destination=1.mp3, title=None}}  
    view:{Paragraph{}}
        view:{Text{literal=asdasd }}
    view:{BlockVideo{}}
        view:{Image{destination=1.wmv, title=None}}  
    view:{BlockAudio{}}
        view:{Image{destination=1.wma, title=None}}  
    view:{Paragraph{}}
        view:{Image{destination=1.png, title=None}}  
*/
@Test
func collect(): Unit {
    let md: Markdown = Markdown.builder().usePlugin(BlockAudioPlugin()).usePlugin(BlockVideoPlugin()).usePlugin(ImageCollectPlugin()).build()
    var str = #"video&audio![](1.mp4)![](1.mp3)asdasd ![](1.wmv)![](1.wma)![](1.png)"#
    let node = md.parse(str)
    printNode(node)
    let view = md.render(node)
    printNode(view)
    let links = view.getProp<HashSet<String>>("links").getOrThrow()
    @Assert(links.size, 3)
    @Assert(links.contains("1.mp4"))
    @Assert(links.contains("1.wmv"))
    @Assert(links.contains("1.png"))
}


@Test
func audio78(): Unit {
    let md: Markdown = Markdown.builder().usePlugin(BlockAudioPlugin()).usePlugin(BlockVideoPlugin()).build()
    var str = #"# audio![](1.mp3) asdasd ![](1.mp4) aaaaa"#
    let node = md.parse(str)
    printNode(node)
    let view = md.render(node)
    printNode(view)
    @Assert(view[0] is Heading)
    @Assert(view[1] is BlockAudio)
    @Assert(view[2] is Heading)
    @Assert(view[3] is BlockVideo)
    @Assert(view[4] is Heading)
}