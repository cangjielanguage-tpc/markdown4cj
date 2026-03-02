/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
export enum Who {
  You = "You",
  Me = "Me"
}

export function getIcon(who: Who): Resource {
  switch (who) {
    case Who.Me:
      return $r('app.media.me')
    case Who.You:
      return $r('app.media.you')
  }
}

@Observed
export class MessageContent {
  content: string = ''

  constructor(content: string) {
    this.content = content
  }
}


@Observed
export class Message {
  content: MessageContent = new MessageContent('')
  who: Who = Who.You
  time: string = ''

  constructor(content: MessageContent, who: Who, time: string) {
    this.content = content
    this.who = who
    this.time = time
  }
}
