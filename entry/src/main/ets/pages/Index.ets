/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
import { CJMarkdown, MarkdownConfiguration} from '@cangjie-tpc/markdown_hybrid'

@Entry
@Component
struct DemoPage {
  /**
   * 顶部导航栏高度
   */
  @StorageProp('safeTop') safeTop: number = 0
  /**
   * md文本
   */
  @State message: string = '### 标题1\n' +
    '\n' +
    '# 1级标题\n' +
    '\n' +
    '### 标题2\n' +
    '\n' +
    '## 2级标题\n' +
    '\n' +
    '### 标题3\n' +
    '\n' +
    '### 3级标题\n' +
    '\n' +
    '### 标题4\n' +
    '\n' +
    '#### 4级标题\n' +
    '\n' +
    '### 标题5\n' +
    '\n' +
    '##### 5级标题\n' +
    '\n' +
    '### 标题6\n' +
    '\n' +
    '###### 6级标题\n' +
    '\n' +
    '### 标题7\n' +
    '\n' +
    '### 正常标题\n' +
    '\n' +
    '### 标题8\n' +
    '\n' +
    'Heading level 1\n' +
    '===============\n' +
    '\n' +
    '### 标题9\n' +
    '\n' +
    'Heading level 2\n' +
    '---------------\n' +
    '\n' +
    '### 标题10\n' +
    '\n' +
    'Heading level 1\n' +
    '=\n' +
    '\n' +
    '### 标题11\n' +
    '\n' +
    'Heading level 2\n' +
    '-\n';

  build() {
    Column() {
      Column() {
        CJMarkdown({
          content: this.message,
          config: new MarkdownConfiguration()
        })
      }
    }
    .padding({ left: 10, right: 10, top: this.safeTop })
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}