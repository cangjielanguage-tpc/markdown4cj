export interface Delta {
  content?: string
  reasoning_content?: string | null
  role?: string
}

export interface Choice {
  index: number
  delta: Delta
  finish_reason?: string | null
}

export interface Usage {
  prompt_tokens: number
  completion_tokens: number
  total_tokens: number
}

export interface ChatCompletionChunk {
  id: string
  object: string
  created: number
  model: string
  choices: Choice[]
  system_fingerprint?: string
  usage?: Usage
}
