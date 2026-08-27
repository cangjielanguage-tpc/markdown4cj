/**
 * 全局LaTeX解析队列（串行化latexStringToImage调用）
 * 一次只处理一个公式，避免原生库并发调用导致卡死
 * 用于MarkdownLatexMathInline和MarkdownLatexMathBlock
 *
 * 容错策略（三层保护，避免队列永久卡死）：
 * 1. 同步异常：processNext 的 try/catch 捕获，清看门狗并 notifyDone
 * 2. 异步 rejection：task 若返回 Promise，自动 .then/.catch，捕获后清看门狗并 notifyDone
 * 3. 看门狗兜底：task 启动时挂 WATCHDOG_TIMEOUT_MS 定时器，
 *    task 内部正常调 notifyDone 时会先 clearWatchdog；
 *    若 task 内部 promise 链丢 rejection / 异步卡死 / 忘记调 notifyDone，
 *    看门狗超时强制 notifyDone 推进队列，保证 isRunning 不被永久占住。
 *
 * 向后兼容：现有调用方传入的 task 类型为 () => void（不返回 Promise），
 * 走"依赖 task 内部 notifyDone + 看门狗兜底"分支，行为与旧版一致。
 */
export class LatexParseQueue {
  private static queue: Array<() => void | Promise<void>> = []
  private static isRunning: boolean = false
  private static isNotifyScheduled: boolean = false
  private static notifyTimerId: number = -1
  private static watchdogTimerId: number = -1
  private static readonly WATCHDOG_TIMEOUT_MS: number = 15000

  /**
   * 将LaTeX解析任务加入队列，若当前无任务在执行则立即开始
   *
   * @param task LaTeX解析任务，可同步（() => void）或异步（() => Promise<void>）
   */
  static enqueue(task: () => void | Promise<void>): void {
    LatexParseQueue.queue.push(task)
    if (!LatexParseQueue.isRunning) {
      LatexParseQueue.processNext()
    }
  }

  /**
   * 通知当前任务已完成，触发下一个任务
   * 内部会先清看门狗，避免 task 正常完成后看门狗误触发
   */
  static notifyDone(): void {
    LatexParseQueue.clearWatchdog()
    if (LatexParseQueue.isNotifyScheduled) {
      return
    }
    LatexParseQueue.isNotifyScheduled = true
    LatexParseQueue.notifyTimerId = setTimeout(() => {
      LatexParseQueue.notifyTimerId = -1
      LatexParseQueue.isNotifyScheduled = false
      LatexParseQueue.processNext()
    }, 0)
  }

  /**
   * 取消待执行的notify定时器与看门狗定时器并清空队列
   * 用于应用退出或页面销毁时清理残留任务
   */
  static dispose(): void {
    LatexParseQueue.clearWatchdog()
    if (LatexParseQueue.notifyTimerId !== -1) {
      clearTimeout(LatexParseQueue.notifyTimerId)
      LatexParseQueue.notifyTimerId = -1
    }
    LatexParseQueue.isNotifyScheduled = false
    LatexParseQueue.isRunning = false
    LatexParseQueue.queue = []
  }

  /**
   * 取出并执行队列中的下一个任务
   * 同步异常走 try/catch；异步异常走 .then/.catch；二者皆无时由看门狗兜底
   */
  private static processNext(): void {
    if (LatexParseQueue.queue.length === 0) {
      LatexParseQueue.isRunning = false
      return
    }
    LatexParseQueue.isRunning = true
    const task = LatexParseQueue.queue.shift()
    if (task === undefined) {
      LatexParseQueue.isRunning = false
      return
    }
    LatexParseQueue.startWatchdog()
    let maybePromise: void | Promise<void>
    try {
      maybePromise = task()
    } catch (e) {
      LatexParseQueue.clearWatchdog()
      console.error('LatexParseQueue task sync error: ' + (e instanceof Error ? e.stack : String(e)))
      LatexParseQueue.notifyDone()
      return
    }
    if (maybePromise instanceof Promise) {
      maybePromise.then(() => {
        LatexParseQueue.clearWatchdog()
        LatexParseQueue.notifyDone()
      }).catch((e: Error) => {
        LatexParseQueue.clearWatchdog()
        console.error('LatexParseQueue task async error: ' + (e instanceof Error ? e.stack : String(e)))
        LatexParseQueue.notifyDone()
      })
    }
    // 若 task 不返回 Promise（现有调用方）：依赖 task 内部自行调用 notifyDone，
    // 看门狗会在 WATCHDOG_TIMEOUT_MS 后兜底，防止 promise 链丢 rejection 或忘调 notifyDone
  }

  /**
   * 启动看门狗定时器（先清掉上一个，避免叠加）
   * 超时后强制 notifyDone，保证队列在 task 异常丢失 notifyDone 时仍能推进
   */
  private static startWatchdog(): void {
    LatexParseQueue.clearWatchdog()
    LatexParseQueue.watchdogTimerId = setTimeout(() => {
      LatexParseQueue.watchdogTimerId = -1
      console.error('LatexParseQueue watchdog: task did not notify done within '
        + LatexParseQueue.WATCHDOG_TIMEOUT_MS + 'ms, forcing queue advance')
      LatexParseQueue.notifyDone()
    }, LatexParseQueue.WATCHDOG_TIMEOUT_MS)
  }

  /**
   * 清除看门狗定时器
   */
  private static clearWatchdog(): void {
    if (LatexParseQueue.watchdogTimerId !== -1) {
      clearTimeout(LatexParseQueue.watchdogTimerId)
      LatexParseQueue.watchdogTimerId = -1
    }
  }
}
