/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
export interface Message {
  role: string
  content: string
}

export interface Choice {
  index: number
  message: Message
  finish_reason?: string | null
}

export interface Usage {
  prompt_tokens: number
  completion_tokens: number
  total_tokens: number
}

export interface ChatCompletion {
  id: string
  object: string
  created: number
  model: string
  choices: Choice[]
  system_fingerprint?: string
  usage: Usage
}
