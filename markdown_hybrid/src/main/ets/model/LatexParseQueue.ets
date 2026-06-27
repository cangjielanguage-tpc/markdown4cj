/**
 * 全局LaTeX解析队列（串行化latexStringToImage调用）
 * 一次只处理一个公式，避免原生库并发调用导致卡死
 * 用于MarkdownLatexMathInline和MarkdownLatexMathBlock
 */
export class LatexParseQueue {
  private static queue: Array<() => void> = []
  private static isRunning: boolean = false

  static enqueue(task: () => void): void {
    LatexParseQueue.queue.push(task)
    if (!LatexParseQueue.isRunning) {
      LatexParseQueue.processNext()
    }
  }

  static notifyDone(): void {
    LatexParseQueue.isRunning = false
    setTimeout(() => {
      LatexParseQueue.processNext()
    }, 0)
  }

  private static processNext(): void {
    if (LatexParseQueue.queue.length === 0) {
      LatexParseQueue.isRunning = false
      return
    }
    LatexParseQueue.isRunning = true
    const task = LatexParseQueue.queue.shift()!
    task()
  }
}
