package markdown.components

public class CardWrapper <: CustomView {
    private var cardName: String = ""
    private var CompObj: ?JSObject = Option.None
    private var jsonStr: String = ""

    public CardWrapper(parent: Option<CustomView>, cardName: ObservedProperty<String>, jsonStr!: ObservedProperty<String>, localStorage!: Option<LocalStorage> = None) {
        super(parent, localStorage)
        this.cardName = cardName.get()
        this.jsonStr = jsonStr.get()
        registerSelf() // 必须注册，防止对象被释放
    }

    public func build(): Unit {
        this.observeComponentCreation(
            {
                elmtId, isInitialRender =>
                    let globalCtx = getCtx()
                    if (isInitialRender) {
                        let jsClazz = globalCtx.global[cardName].asClass(globalCtx)
                        let jsClsObj = globalCtx.global[cardName].asObject(globalCtx)
                        let callFunc = {
                            globalCtx: JSContext, callinfo: JSCallInfo => globalCtx.undefined().toJSValue()
                        }
                        let param: JSObject = globalCtx.object()
                        // 将 jsonStr 传递到 param 中
                        if (jsonStr != "") {
                            param["data"] = globalCtx.string(jsonStr).toJSValue()
                        }
                        let jsComponent = jsClazz.new(
                            [
                                globalCtx.undefined().toJSValue(), // parent
                                param.toJSValue(), // param
                                globalCtx.undefined().toJSValue(), // localStorage
                                globalCtx.undefined().toJSValue(), // elmtId
                                globalCtx.function(callFunc).toJSValue(), // lambda
                                globalCtx.object().toJSValue() // debugLine info
                            ]
                        )
                        CompObj = jsComponent.asObject(globalCtx)
                        jsClsObj.callMethod("create", jsComponent)
                    } else {
                        CompObj.getOrThrow().callMethod("forceCompleteRerender", globalCtx.boolean(true).toJSValue())
                    }
                    FakeComponent()
            }
        )
    }

    public func aboutToBeDeleted(): Unit {
    }
}
