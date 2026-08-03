package ohos_app_cangjie_entry

import std.random.Random

/**
 * 大语言模型 Mock 类（对齐 ArkTS LLM.ets）
 *
 * chat 方法在 spawn 后台线程中执行，通过随机分片大小 + sleep 模拟流式响应。
 * task 回调在后台线程执行，UI 操作需通过 launch 包裹。
 *
 * 用法：
 * 1. 创建实例：let llm = LLM()
 * 2. 调用 chat：llm.chat(text, { slice => launch { ... } }, true)
 */
public class LLM {
    private let random = Random()
    private var buffer: String = ""

    public init() {}

    public func chat(input: String, task: (String) -> Unit, stream: Bool): Unit {
        buffer = HARD_CODE_DATA
        spawn {
            sleep(Duration.millisecond * 20)
            while (buffer.size > 0) {
                let r = random.nextFloat64()
                let size = Int64(r * 10.0) + 1
                let end = if (buffer.size > size) {
                    size
                } else {
                    buffer.size
                }
                let output = buffer[0..end]
                buffer = buffer[end..buffer.size]
                task(output)
                sleep(Duration.millisecond * 20)
            }
        }
    }
}
