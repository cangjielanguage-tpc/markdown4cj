/**
 * 自定义标签解析结果
 */
export class ParsedCustomTag {
  tag: string = '' // 标签名（统一小写）
  attrs: Record<string, string> = {} // 标签属性表
  content: string = '' // 开闭标签之间的内容
}

/**
 * 自定义标签视图注册表（全局生效）
 *
 * markdown 文档中的 HTML 块级标签（如 <sdui data='...'></sdui>），
 * 若标签名已通过 register 注册，则解析层将其转为块级自定义视图节点（NodeView.customTag等字段），
 * 渲染层通过 CJMarkdown 的 customTagViewComponent BuilderParam 回调宿主渲染；
 * 未注册的 HTML 标签保持原有行为（解析层丢弃），对存量用法零影响。
 */
export class CustomViewRegistry {
  private static tags: Set<string> = new Set<string>()

  /**
   * 注册自定义标签（仅标签名，渲染由 customTagViewComponent 回调完成）
   *
   * @param tag 标签名（大小写不敏感，内部统一小写存储）
   */
  static register(tag: string): void {
    CustomViewRegistry.tags.add(tag.toLowerCase())
  }

  /**
   * 注销自定义标签
   *
   * @param tag 标签名
   */
  static unregister(tag: string): void {
    CustomViewRegistry.tags.delete(tag.toLowerCase())
  }

  /**
   * 标签是否已注册
   *
   * @param tag 标签名
   * @return true：已注册；false：未注册
   */
  static isRegistered(tag: string): boolean {
    return CustomViewRegistry.tags.has(tag.toLowerCase())
  }

  /**
   * 解析前预处理：把已注册标签的原文包进无语言围栏代码块
   *
   * 背景：Cangjie 解析器（HtmlPlugin）对非已知 HTML 标签（如 <sdui>）做静默剥离
   * （不产 HtmlBlock/HtmlInline 原文节点，仅残留空段落），标签与属性数据在 AST 层不可恢复。
   * 围栏代码块的 literal 会被解析器完整保留，故将其作为自定义标签的可靠载体：
   * 预处理 `<tag ...>...</tag>` → "\n```\n<tag ...>...</tag>\n```\n"，
   * 解析后在 FencedCodeBlock 分支用 parseTagLiteral 还原为自定义视图节点。
   *
   * 防误伤措施：
   * 1) 先把用户已有围栏块与行内代码替换为占位符（\u0000CT{n}\u0000），处理完再还原；
   * 2) 开闭标签间内容限定单行（[^\n]*?），行内代码外孤立出现的 `<tag>`（无紧邻闭标签）不会被匹配。
   *
   * @param content 原始 markdown 文本
   * @return 预处理后的文本
   */
  static preprocessCustomTags(content: string): string {
    if (content.length === 0 || content.indexOf('<') < 0 || CustomViewRegistry.tags.size === 0) {
      return content
    }
    const placeholders: Array<string> = []
    let work = content
    // 1. 保护已有围栏代码块（```...```，惰性匹配到闭合围栏）
    work = work.replace(/```[\s\S]*?```/g, (m: string) => {
      placeholders.push(m)
      return `\u0000CT${placeholders.length - 1}\u0000`
    })
    // 2. 保护行内代码（`...`，单行）
    work = work.replace(/`[^`\n]*`/g, (m: string) => {
      placeholders.push(m)
      return `\u0000CT${placeholders.length - 1}\u0000`
    })
    // 3. 已注册标签原文 → 围栏块载体
    CustomViewRegistry.tags.forEach((tag: string) => {
      if (work.indexOf(`<${tag}`) < 0) {
        return
      }
      // 转义 tag 中的正则特殊字符，防止正则注入导致误匹配或语法错误
      const escapedTag = tag.replace(/[.*+?^${}()|[\]\\]/g, (c: string) => '\\' + c)
      // 完整开闭标签（内容限单行）或自闭合
      const pattern = new RegExp(
        `<${escapedTag}(\\s[^>]*?)?>([^\\n]*?)</${escapedTag}\\s*>|<${escapedTag}(\\s[^>]*?)?/>`,
        'g'
      )
      work = work.replace(pattern, (m: string) => {
        return `\n\`\`\`\n${m}\n\`\`\`\n`
      })
    })
    // 4. 还原占位符
    work = work.replace(/\u0000CT(\d+)\u0000/g, (_m: string, idx: string) => {
      const saved = placeholders[Number(idx)]
      return saved !== undefined ? saved : ''
    })
    return work
  }

  /**
   * 从 HtmlBlock 原文解析自定义标签（仅解析第一个开标签）
   * 支持单引号/双引号/无引号属性值、自闭合与未闭合（流式输出中）形式
   *
   * @param literal HtmlBlock 原文
   * @return 解析结果；不是合法开标签时返回 undefined
   */
  static parseTagLiteral(literal: string | undefined): ParsedCustomTag | undefined {
    if (literal === undefined || literal.length === 0) {
      return undefined
    }
    const n = literal.length
    let i = 0
    // 跳过前导空白
    while (i < n && CustomViewRegistry.isWhitespace(literal[i])) {
      i++
    }
    // 必须以 '<' + 标签名首字母开头，'/' 开头的闭标签不处理
    if (i >= n || literal[i] !== '<') {
      return undefined
    }
    i++
    if (i >= n || literal[i] === '/' || literal[i] === '!' || literal[i] === '?') {
      return undefined
    }
    // 解析标签名
    const tagStart = i
    while (i < n && !CustomViewRegistry.isWhitespace(literal[i]) && literal[i] !== '>' && literal[i] !== '/') {
      i++
    }
    const tag = literal.substring(tagStart, i)
    if (tag.length === 0 || !/[a-zA-Z]/.test(tag[0])) {
      return undefined
    }
    const result = new ParsedCustomTag()
    result.tag = tag.toLowerCase()
    // 解析属性直到开标签结束
    let selfClosing = false
    while (i < n) {
      while (i < n && CustomViewRegistry.isWhitespace(literal[i])) {
        i++
      }
      if (i >= n) {
        return undefined
      }
      const c = literal[i]
      if (c === '>') {
        i++
        break
      }
      if (c === '/') {
        // 自闭合：'/' 后必须紧跟 '>'
        i++
        if (i < n && literal[i] === '>') {
          i++
          selfClosing = true
          break
        }
        return undefined
      }
      // 属性名
      const nameStart = i
      while (i < n && literal[i] !== '=' && literal[i] !== '>' && !CustomViewRegistry.isWhitespace(literal[i])) {
        i++
      }
      const attrName = literal.substring(nameStart, i)
      if (attrName.length === 0) {
        return undefined
      }
      let attrValue = ''
      // 跳过 '=' 前空白
      while (i < n && CustomViewRegistry.isWhitespace(literal[i])) {
        i++
      }
      if (i < n && literal[i] === '=') {
        i++
        while (i < n && CustomViewRegistry.isWhitespace(literal[i])) {
          i++
        }
        if (i >= n) {
          return undefined
        }
        if (literal[i] === '\'' || literal[i] === '"') {
          // 引号值：引号内任意字符（含空白与'>'）均属于属性值
          const quote = literal[i]
          i++
          const valStart = i
          while (i < n && literal[i] !== quote) {
            i++
          }
          if (i >= n) {
            return undefined
          }
          attrValue = literal.substring(valStart, i)
          i++
        } else {
          // 无引号值：到空白或'>'结束
          const valStart = i
          while (i < n && !CustomViewRegistry.isWhitespace(literal[i]) && literal[i] !== '>') {
            i++
          }
          attrValue = literal.substring(valStart, i)
        }
      }
      result.attrs[attrName] = CustomViewRegistry.decodeHtmlEntities(attrValue)
    }
    if (selfClosing) {
      return result
    }
    // 查找匹配的闭标签；流式输出未闭合时内容取开标签后的剩余文本
    const closeToken = `</${result.tag}`
    const closeIdx = literal.toLowerCase().indexOf(closeToken, i)
    if (closeIdx < 0) {
      result.content = CustomViewRegistry.decodeHtmlEntities(literal.substring(i))
    } else {
      result.content = CustomViewRegistry.decodeHtmlEntities(literal.substring(i, closeIdx))
    }
    return result
  }

  private static isWhitespace(c: string): boolean {
    return c === ' ' || c === '\t' || c === '\n' || c === '\r' || c === '\f'
  }

  /**
   * 解码常用HTML实体（&amp; 最后处理，避免二次解码）
   */
  private static decodeHtmlEntities(s: string): string {
    if (s.indexOf('&') < 0) {
      return s
    }
    return s
      .replace(/&lt;/g, '<')
      .replace(/&gt;/g, '>')
      .replace(/&quot;/g, '"')
      .replace(/&apos;/g, '\'')
      .replace(/&#39;/g, '\'')
      .replace(/&nbsp;/g, ' ')
      .replace(/&amp;/g, '&')
  }
}
