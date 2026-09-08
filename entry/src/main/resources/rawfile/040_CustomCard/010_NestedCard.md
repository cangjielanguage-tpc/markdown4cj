## 嵌套卡片测试

### 1. 图片嵌在加粗中（单独成段）
**![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800)**

### 2. 加粗内图文混合
前文 **加粗文字 ![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800) 加粗尾巴** 后文

### 3. 图片嵌在外层链接中（外层链接描述非Custom）
[图片说明 ![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800)](https://www.baidu.com)

### 4. 同一容器两张卡
**![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800) 分隔 ![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800)**

### 5. 表格单元格内嵌套
| 列一 | 列二 |
| --- | --- |
| 普通文本 | **![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800)** |
| **前 图 ![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800) 后** | 保留原样 ![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800) |

### 6. 顶层卡片（回归，确保原有行为不变）
![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800)

普通图片应保持普通图片：![normal](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800)

### 7. 标题内嵌卡片
### 标题文字 **![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800) 尾部文字**

### 8. 深层嵌套（加粗+斜体）
***![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800)***

### 9. 顶层与嵌套卡片混合
![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800) 中间文字 **嵌套 ![Custom](https://gips2.baidu.com/it/u=1651586290,17201034&fm=3028&app=3028&f=JPEG&fmt=auto&q=100&size=f600_800) 结束**
