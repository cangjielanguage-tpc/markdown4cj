package markdown_parser_hybrid

import std.collection.concurrent.ArrayBlockingQueue

func createCustomCardPlugin(opt: JSObject, context: JSContext): BlockCustomCardPlugin {
    var imageFn: ?(CardBean) -> Bool = None
    var linkFn: ?(CardBean) -> Bool = None
    let blockImageCard = opt["blockImageCard"]
    if (!blockImageCard.isUndefined() && !blockImageCard.isNull()) {
        let jsImage = blockImageCard.asFunction()
        imageFn = {card: CardBean => callCardCallback(jsImage, card, context)}
    }
    let blockLinkCard = opt["blockLinkCard"]
    if (!blockLinkCard.isUndefined() && !blockLinkCard.isNull()) {
        let jsLink = blockLinkCard.asFunction()
        linkFn = {card: CardBean => callCardCallback(jsLink, card, context)}
    }
    return BlockCustomCardPlugin.create(blockImage: imageFn, blockLink: linkFn)
}

func callCardCallback(cb: JSFunction, card: CardBean, context: JSContext): Bool {
    let flag = ArrayBlockingQueue<Bool>(1)
    context.postJSTask {
        let ret = cb.call(
            [
                optStr2JSValue(context, card.getDescription()),
                optStr2JSValue(context, card.getDestination()),
                optStr2JSValue(context, card.getTitle())
            ]
        )
        let res = Bool.fromJSValue(context, ret)
        flag.add(res)
    }
    return flag.remove()
}

func optStr2JSValue(context: JSContext, s: ?String): JSValue {
    match (s) {
        case Some(v) => context.string(v).toJSValue()
        case None => context.string("").toJSValue()
    }
}
