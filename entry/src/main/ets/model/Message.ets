/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */

/**
 * 消息发送对象枚举
 */
export enum Who {
  /**
   * 消息对象是AI
   */
  You = "You",
  /**
   * 消息对象是自己
   */
  Me = "Me"
}

/**
 * 通过消息发送对象设置头像
 */
export function getIcon(who: Who): Resource {
  switch (who) {
    case Who.Me:
      return $r('app.media.me')
    case Who.You:
      return $r('app.media.you')
  }
}

/**
 * 消息文本对象
 */
@Observed
export class MessageContent {
  /**
   * 消息文本
   */
  content: string = ''

  constructor(content: string) {
    this.content = content
  }
}

/**
 * 消息对象
 */
@Observed
export class Message {
  /**
   * 消息文本对象
   */
  content: MessageContent = new MessageContent('')
  /**
   * 消息发送对象枚举
   */
  who: Who = Who.You
  /**
   * 时间戳
   */
  time: string = ''

  constructor(content: MessageContent, who: Who, time: string) {
    this.content = content
    this.who = who
    this.time = time
  }
}
