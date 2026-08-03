package ohos_app_cangjie_entry

/**
 * 消息发送对象枚举（对齐 ArkTS Message.ets Who）
 */
public enum Who <: Equatable<Who> {
    | You
    | Me

    public operator func ==(other: Who): Bool {
        match (this) {
            case You =>
                match (other) {
                    case You => true
                    case _ => false
                }
            case Me =>
                match (other) {
                    case Me => true
                    case _ => false
                }
        }
    }

    public operator func !=(other: Who): Bool {
        !(this == other)
    }
}

/**
 * 消息对象（对齐 ArkTS Message.ets Message）
 *
 * 与 ArkTS 版本区别：content 直接为 String（不再包装 MessageContent），
 * 以便与 AIChatBlock 组件的 @Prop output: String 直接对接。
 */
public class Message {
    public var content: String
    public var who: Who
    public var time: String

    public init(content: String, who: Who, time: String) {
        this.content = content
        this.who = who
        this.time = time
    }
}
