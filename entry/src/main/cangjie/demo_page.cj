package ohos_app_cangjie_entry

import ohos.base.*
import kit.ArkUI.*
import ohos.arkui.state_macro_manage.*
import markdown.components.*

@HybridComponentEntry
@Component
class Demo_page {
    @State
    var mdStr: String = """
### 标题1

# 1级标题

### 标题2

## 2级标题

### 标题3

### 3级标题

### 标题4

#### 4级标题

### 标题5

##### 5级标题

### 标题6

###### 6级标题

### 标题7

### 正常标题

### 标题8

Heading level 1
===============

### 标题9

Heading level 2
---------------

### 标题10

Heading level 1
=

### 标题11

Heading level 2
-

"""

    public func build() {
        Scroll() {
            Column {
                MarkdownComponent(output: mdStr)
            }
        }
        // 设置滚动方法
        .scrollable(ScrollDirection.Vertical)
    }
}
