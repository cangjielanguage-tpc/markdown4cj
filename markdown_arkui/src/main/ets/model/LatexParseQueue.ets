/**
 * 全局LaTeX解析队列（串行化latexStringToImage调用）
 * 一次只处理一个公式，避免原生库并发调用导致卡死
 * 用于MarkdownLatexMathInline和MarkdownLatexMathBlock
 *
 * 完成契约：task返回Promise<void>，Promise resolve/reject即任务完成信号，
 * 队列在promise上挂 .then/.catch 统一推进（推进发生在微任务，天然解栈，
 * 无需setTimeout宏任务调度）。task内部不得自行通知完成。
 *
 * 容错策略（三层保护，避免队列永久卡死）：
 * 1. 同步异常：task同步抛出时包装为Promise.reject，统一走异步catch路径
 * 2. 异步 rejection：.catch捕获后推进队列
 * 3. 看门狗兜底（唯一保留的定时器）：task启动时挂WATCHDOG_TIMEOUT_MS定时器，
 *    promise链丢rejection / 异步卡死时超时强制推进队列，保证不被永久占住
 *
 * 并发约定（防竞态）：ArkTS单线程事件循环下不存在抢占式并发；
 * 「检查isRunning+置位+取任务」收拢在pump的同一同步段（无await间隙）。
 * 每个任务持有唯一序号，完成回调finish闭包绑定该序号：
 * 看门狗强制推进或dispose后，迟到的promise完成因序号不匹配被丢弃，
 * 不会误触新一轮任务状态（防双任务并发执行/漏调度）。
 */
export class LatexParseQueue {
  private static queue: Array<() => Promise<void>> = []
  private static isRunning: boolean = false
  private static watchdogTimerId: number = -1
  private static readonly WATCHDOG_TIMEOUT_MS: number = 15000
  // 任务流水号：每次启动任务递增；runningTaskId标识当前执行中的任务（-1表示无）
  private static taskSeq: number = 0
  private static runningTaskId: number = -1

  /**
   * 将LaTeX解析任务加入队列，若当前无任务在执行则立即开始
   *
   * @param task LaTeX解析任务，返回Promise<void>，resolve/reject即完成信号
   */
  static enqueue(task: () => Promise<void>): void {
    LatexParseQueue.queue.push(task)
    // 「检查isRunning+置位+取任务」在同一同步段内完成（pump无await间隙，
    // ArkTS单线程事件循环内不可分割），消除判定与置位交错的竞争窗口
    LatexParseQueue.pump()
  }

  /**
   * 取消看门狗定时器并清空队列
   * 用于应用退出或页面销毁时清理残留任务；
   * dispose后迟到的promise完成因runningTaskId=-1被finish丢弃
   */
  static dispose(): void {
    LatexParseQueue.clearWatchdog()
    LatexParseQueue.isRunning = false
    LatexParseQueue.runningTaskId = -1
    LatexParseQueue.queue = []
  }

  /**
   * 队列泵：从队列头取任务并执行
   * 检查isRunning+置位+shift取任务收拢在同一同步段（无await间隙）；
   * 同步异常包装为Promise.reject统一走异步catch，推进只发生在微任务，无栈内嵌套
   */
  private static pump(): void {
    // 有任务在执行则等其完成回调推进，避免双任务并发执行
    if (LatexParseQueue.isRunning || LatexParseQueue.queue.length === 0) {
      return
    }
    const task = LatexParseQueue.queue.shift()
    if (task === undefined) {
      return
    }
    LatexParseQueue.isRunning = true
    LatexParseQueue.taskSeq++
    LatexParseQueue.runningTaskId = LatexParseQueue.taskSeq
    const taskId = LatexParseQueue.taskSeq
    // 完成回调绑定本任务序号：看门狗强制推进或dispose后，
    // 迟到的promise完成因序号不匹配被丢弃，不触碰新一轮任务状态
    const finish = (): void => {
      if (taskId !== LatexParseQueue.runningTaskId) {
        return
      }
      LatexParseQueue.clearWatchdog()
      LatexParseQueue.isRunning = false
      LatexParseQueue.runningTaskId = -1
      LatexParseQueue.pump()
    }
    LatexParseQueue.startWatchdog()
    let promise: Promise<void>
    try {
      promise = task()
    } catch (e) {
      console.error('LatexParseQueue task sync error: ' + (e instanceof Error ? e.stack : String(e)))
      promise = Promise.reject(e as Error)
    }
    promise.then(() => {
      finish()
    }).catch((e: Error) => {
      console.error('LatexParseQueue task async error: ' + (e instanceof Error ? e.stack : String(e)))
      finish()
    })
  }

  /**
   * 启动看门狗定时器（先清掉上一个，避免叠加）
   * 超时说明promise链丢rejection或异步卡死，强制推进队列防止永久卡死；
   * 原任务的迟到完成由finish的序号校验拦截
   */
  private static startWatchdog(): void {
    LatexParseQueue.clearWatchdog()
    LatexParseQueue.watchdogTimerId = setTimeout(() => {
      LatexParseQueue.watchdogTimerId = -1
      if (LatexParseQueue.runningTaskId === -1) {
        // 任务已正常完成或已dispose：看门狗无需介入
        return
      }
      console.error('LatexParseQueue watchdog: task did not finish within '
        + LatexParseQueue.WATCHDOG_TIMEOUT_MS + 'ms, forcing queue advance')
      LatexParseQueue.isRunning = false
      LatexParseQueue.runningTaskId = -1
      LatexParseQueue.pump()
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
