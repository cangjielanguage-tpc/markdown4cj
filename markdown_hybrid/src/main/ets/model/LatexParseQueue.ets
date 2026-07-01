/**
 * 全局LaTeX解析队列（串行化latexStringToImage调用）
 * 一次只处理一个公式，避免原生库并发调用导致卡死
 * 用于MarkdownLatexMathInline和MarkdownLatexMathBlock
 */
export class LatexParseQueue {
  private static queue: Array<() => void> = []
  private static isRunning: boolean = false

  /**
   * 将LaTeX解析任务加入队列，若当前无任务在执行则立即开始
   *
   * @param task LaTeX解析任务
   */
  static enqueue(task: () => void): void {
    LatexParseQueue.queue.push(task)
    if (!LatexParseQueue.isRunning) {
      LatexParseQueue.processNext()
    }
  }

  /**
   * 通知当前任务已完成，触发下一个任务
   */
  static notifyDone(): void {
    setTimeout(() => {
      LatexParseQueue.processNext()
    }, 0)
  }

  /**
   * 取出并执行队列中的下一个任务
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
    try {
      task()
    } catch (e) {
      LatexParseQueue.notifyDone()
    }
  }
}
