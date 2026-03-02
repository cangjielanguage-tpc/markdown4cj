/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
import { http } from '@kit.NetworkKit';
import { JSON } from '@kit.ArkTS';
import { ChatCompletionChunk } from '../model/ChatCompletionChunk';
import util from '@ohos.util'
import { ChatCompletion } from '../model/CharCompletion';

export enum Role {
  I = "user",
  AI = "assistant",
  System = "system"
}

export function roleToString(role: Role): string {
  return role
}

export const HARD_CODE_DATA = `理财平台的**稳定性**是投资者最关心的核心要素之一，尤其对于新手而言，平台的稳定性直接关系到资金安全、收益兑现与操作体验。在命理学中，稳定性可类比为“印星稳固、官杀有制、财星流通”，若平台缺乏这些特质，容易出现资金冻结、兑付困难、暴雷等问题。

以下从**金融监管、运营模式、产品结构、用户行为**等角度，系统分析影响理财平台稳定性的关键因素，并结合命理格局进行适配建议。

---

## 📊 一、影响理财平台稳定性的六大核心因素

| 影响因素 | 说明 | 对稳定性的影响 | 命理对应 |
|----------|------|----------------|----------|
| **监管合规性** | 是否受证监会、银保监会等监管机构监管 | 合规性强，平台更稳定 | 命中官杀有制者，平台更可控 |
| **资金托管机制** | 是否由银行托管，资金是否可查、可追溯 | 银行托管可防止资金挪用 | 命中印星旺者，适合资金透明平台 |
| **产品结构与风险控制** | 是否有风险控制机制（如分散投资、止损机制） | 结构清晰、风控完善，收益更稳定 | 命中七杀旺者，需平台有风控 |
| **平台运营模式** | 是否为“资金池”运作、是否自融、是否期限错配 | 资金池、自融模式风险高 | 命中比劫旺者，易受平台暴雷影响 |
| **历史兑付记录** | 过往是否有兑付问题、逾期、跑路情况 | 有不良记录的平台稳定性差 | 命中财星弱者，应避开高风险平台 |
| **用户评价与市场反馈** | 用户投诉、第三方平台评价（如黑猫投诉、知乎） | 负面反馈多，平台稳定性存疑 | 命中食伤旺者，宜参考他人经验 |

---

## 🧠 二、不同命格人群对平台稳定性的适配建议

| 命格特征 | 推荐关注点 | 原因说明 |
|----------|--------------|------------|
| **身强财旺** | 关注平台合规性、流动性 | 可尝试中高风险产品，但需平台合规 |
| **身弱财旺** | 关注资金托管、赎回机制 | 应选择银行、货币基金等低风险平台 |
| **命带印星** | 关注平台资质、监管机构 | 适合选择银行、基金公司等正规平台 |
| **命带食伤** | 关注平台学习资源、操作便捷性 | 可选择基金公司APP，学习投资 |
| **命带官杀** | 关注平台合规性、产品稳定性 | 适合银行、保险类稳健平台 |
| **命带比劫** | 关注平台口碑、用户评价 | 宜参考他人经验，避免踩雷 |

---

## 📈 三、平台稳定性评估模型（金融视角）

| 维度 | 高稳定性特征 | 低稳定性特征 |
|------|----------------|----------------|
| **监管机构** | 受证监会、银保监会监管 | 无明确监管机构 |
| **资金托管** | 由银行托管，资金可查 | 平台自营账户，资金不透明 |
| **产品类型** | 货币基金、债券基金、银行理财 | P2P、虚拟货币、私募 |
| **兑付记录** | 历史兑付正常，无逾期 | 有兑付问题、跑路记录 |
| **运营模式** | 产品结构清晰，无期限错配 | 资金池运作、自融模式 |
| **用户反馈** | 正面评价多，投诉少 | 投诉多，负面新闻频出 |

---

## 🧭 四、如何判断平台是否稳定？

| 判断方式 | 说明 |
|----------|------|
| **查看平台官网“合规披露”信息** | 查看是否具备金融牌照、合作银行、监管信息 |
| **登录证监会官网查询基金销售资质** | 查询平台是否具备基金销售资格 |
| **查看国家企业信用信息公示系统** | 查询平台公司是否正规、有无行政处罚 |
| **查看第三方平台评价（如黑猫投诉、知乎）** | 了解用户真实反馈，避免踩雷 |
| **关注平台历史兑付记录** | 是否有逾期、跑路、兑付问题 |

---

## 📌 五、总结建议

| 建议 | 说明 |
|------|------|
| **优先选择持牌平台** | 如银行、基金公司、证券公司等 |
| **关注资金是否银行托管** | 避免资金被平台挪用 |
| **不盲目追求高收益** | 新手应以稳定性为第一考量 |
| **多查第三方平台评价** | 避免选择有负面新闻的平台 |
| **结合命格选择平台** | 根据自身命理特点选择合适的理财方式 |

---

如您希望结合八字进行个性化理财平台稳定性评估与推荐，欢迎提供完整个人信息（出生年月日时、性别、出生地），以便进行更精准的命理推演与理财建议。`

export class LLM {
  private history: string = ''
  private url: string;
  private key: string;
  private model: string;
  private memory: boolean;


  constructor(
  url: string,
  key: string,
  model: string,
  memory: boolean = false
  ) {
  this.url = url;
  this.key = key;
  this.model = model;
  this.memory = memory;
}

  private encode(role: Role, content: string): string {
    return JSON.stringify({
      role: roleToString(role),
      content: content
    })
  }

  public async send(input: string, httpRequest: http.HttpRequest, stream: boolean) {
    const message = this.encode(Role.I, input)
    const content = `{"model":"${this.model}","messages":[${this.history}${message}],"stream":${stream}}`
    console.info('LLM content:' + content)
    if (this.memory) {
      this.history += `${message},`
    }
    const options: http.HttpRequestOptions = {
      method: http.RequestMethod.POST,
      header: {
        Authorization: `Bearer ${this.key}`,
        "Content-Type": "application/json",
        Accept: stream? "text/event-stream" : "application/json"
      },
      extraData: content
    }

    await httpRequest.requestInStream(this.url, options)
  }

  private parse(text: string, stream: boolean = false): string {
    if (stream) {
      const obj = JSON.parse(text) as ChatCompletionChunk
      if (!obj.choices || obj.choices.length === 0) return ""
      return obj.choices[0].delta?.content ?? ""
    } else {
      const obj = JSON.parse(text) as ChatCompletion
      if (!obj.choices || obj.choices.length === 0) return ""
      return obj.choices[0].message?.content ?? ""
    }
  }
  randInt(min: number, max: number) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }
  public async chat(input: string, task: (chunk: string) => void, stream: boolean = false): Promise<void> {
    let buffer = `${HARD_CODE_DATA}`
    const chunker = () => {
      if (buffer.length > 0) {
        const size = this.randInt(1, 3)
        const output = buffer.substring(0, Math.min(buffer.length, size));
        buffer = buffer.slice(Math.min(buffer.length, size));
        task(output);
        setTimeout(chunker, 200);
      }
    };
    setTimeout(chunker, 200);
    // let output = ""
    // const INDEX = 6
    // const httpRequest = http.createHttp()
    // httpRequest.on('dataReceive', (data: ArrayBuffer) => {
    //   const decoder = util.TextDecoder.create("utf-8");
    //   const str = decoder.decodeWithStream(new Uint8Array(data))
    //   const lines = stream ? str.split("\n").filter(l => l.trim().length > 0) : [str];
    //   console.log("LLM dataReceive:" + lines);
    //   for (let line of lines) {
    //     if (!stream || line.length > INDEX && line[INDEX] === "{") {
    //       const json = stream ? line.slice(INDEX) : line
    //       const slice = this.parse(json, stream)
    //       if (this.memory) { output += slice }
    //       task(slice)
    //     }
    //   }
    // })
    // httpRequest.on('dataEnd', () => {
    //   console.info('No more data in response, data receive end')
    //   if (this.memory) {
    //     this.history += `${this.encode(Role.AI, output)},`
    //   }
    // })
    // await this.send(input, httpRequest, stream)
  }

  public preset(memory: Array<[Role, string]>): void {
    this.reset()
    for (let memo of memory) {
      this.history += `${this.encode(memo[0], memo[1])},`
    }
  }

  public reset(): void {
    this.history = ''
  }
}
