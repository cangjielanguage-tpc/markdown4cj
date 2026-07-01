### 含有数学公式的表格

| 颜色透明度场景     | Alpha通道计算公式                                               | 最终透明度计算（叠加组件opacity）                      | 示例（Alpha=128，opacity=0.5）                |
|-------------|-----------------------------------------------------------|-------------------------------------------|------------------------------------------|
| 纯颜色透明度      | $Alpha_{数值} = (argbNum >> 24) \& 0xFF$                    | $透明度 = Alpha_{数值} / 255$                  | $128/255 ≈ 0.5$                          |
| 组件叠加透明度     | -                                                         | $最终透明度 = (Alpha_{数值}/255) \times opacity$ | $0.5 \times 0.5 = 0.25$                  |
| 6位RGB补Alpha | $ARGB_{补全} = 0xFF000000 \| RGB_{6位}$                      | -                                         | $0xFF000000 \| 0x000000 = 0xFF000000$    |
| 动态计算ARGB    | $ARGB_{动态} = (Alpha << 24) \| (R << 16) \| (G << 8) \| B$ | -                                         | $(80 << 24) \| (255 << 16) = 0x50FF0000$ |

### 含有加粗文本的表格

| ArkTS颜色类型     | 核心特征                                     | 推荐使用场景           | 避坑要点                              |
|---------------|------------------------------------------|------------------|-----------------------------------|
| **ARGB 8位数值** | **包含Alpha通道，格式0xAARRGGBB**               | 动态颜色计算、透明色设置     | 加粗：6位数值直接使用会默认Alpha=0             |
| **RGB 6位数值**  | **无Alpha通道，格式0xRRGGBB**                  | 纯颜色展示（无透明需求）     | 加粗：需手动补Alpha=0xFF转为不透明            |
| **Color枚举**   | **内置预设（如Color.Black/Color.Transparent）** | 固定颜色场景（纯黑/纯白/透明） | 加粗：Color.Transparent等价于0x00000000 |
| **rgba字符串**   | **格式rgba(R,G,B,A)，A为0~1浮点数**             | 可视化配置、低版本兼容      | 加粗：A需×255转为8位Alpha值               |

### 含有斜体文本的表格

| 数值转换场景       | 转换方法                                     | 适用版本      | 注意事项                      |
|--------------|------------------------------------------|-----------|---------------------------|
| Number转Color | *new Color(argbNum)*                     | *API 7+*  | *需确保数值为32位无符号整数*          |
| Color转Number | *colorManager.getColorComponents(color)* | *API 9+*  | *Alpha返回值为0~1浮点数，需×255*   |
| 6位RGB转8位ARGB | *0xFF000000 \| rgbNum*                   | *所有版本*    | *位运算需确保rgbNum在0~0xFFFFFF* |
| 低版本兼容转换      | *Color.rgba(R,G,B,A/255)*                | *API 7-8* | *A为0~255整数，需转为0~1浮点数*     |

### 含有删除线文本的表格

| 错误用法                       | 错误原因                         | 正确用法                    | 效果对比                  |
|----------------------------|------------------------------|-------------------------|-----------------------|
| ~~new Color(0x000000)~~    | ~~6位数值解析为Alpha=0，显示透明黑而非纯黑~~ | new Color(0xFF000000)   | ~~透明黑（显黑）~~ → 纯黑（不透明） |
| ~~Color.rgb(255,0,0,0.5)~~ | ~~rgb方法不支持Alpha参数~~          | Color.rgba(255,0,0,0.5) | ~~编译报错~~ → 半透明红色      |
| ~~直接使用负数数值~~               | ~~负数会被截断为0xFFFFFFFF，显示纯白~~   | 确保数值在0~4294967295范围     | ~~显示纯白~~ → 目标颜色       |
| ~~opacity=0 + 0x00000000~~ | ~~双重透明导致渲染层兜底显黑~~            | 使用Color.Transparent     | ~~显黑~~ → 完全透明         |

### 含有链接文本的表格

| 参考资源            | 链接地址                                                                                                                         | 内容简介             | 适用场景           |
|-----------------|------------------------------------------------------------------------------------------------------------------------------|------------------|----------------|
| ArkTS Color官方文档 | [Color类API](https://developer.harmonyos.com/cn/docs/documentation/doc-references/arkts-color-0000001404061316)               | 详解Color类构造、方法、枚举 | 基础颜色使用         |
| colorManager工具类 | [colorManager API](https://developer.harmonyos.com/cn/docs/documentation/doc-references/arkts-colormanager-0000001404141294) | 颜色通道解析、转换工具      | Color与Number互转 |
| 鸿蒙颜色渲染规则        | [颜色渲染机制](https://developer.harmonyos.com/cn/docs/documentation/doc-guides/arkts-ui-color-render-0000001524231810)            | 透明度、叠加渲染逻辑       | 透明色显黑/显白问题排查   |
| 位运算基础           | [位运算教程](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Expressions_and_Operators#位运算符)                        | JS/ArkTS位运算规则    | 动态计算ARGB数值     |

### 含有内联代码文本的表格

| 开发场景         | 核心代码示例                                   | 代码说明              | 执行效果            |
|--------------|------------------------------------------|-------------------|-----------------|
| 纯黑Color构建    | `const black = new Color(0xFF000000)`    | 8位ARGB数值构建纯黑Color | 组件背景显示纯黑        |
| 完全透明Color构建  | `const transparent = Color.Transparent`  | 使用内置枚举构建透明色       | 组件背景完全透明        |
| Color转Number | `const num = (color.alpha<<24)           | color.red<<16     | color.green<<8  |color.blue` | 手动拆分通道转数值               | 输出0xAARRGGBB格式数值            |
| 6位RGB补Alpha  | `const argb = 0xFF000000                 | 0x00FF00`         | 6位绿色补全Alpha为不透明 | 输出0xFF00FF00（纯绿）|
| 动态调整透明度      | `const dynamicColor = new Color((80<<24) | 0xFF0000)`        | Alpha=80的半透红    | 组件显示19.6%透明的红色           |

### 含有图片的表格

| ArkTS颜色效果      | 效果预览图                                                            | 图片说明                             | 对应数值/代码                                  |
|----------------|------------------------------------------------------------------|----------------------------------|------------------------------------------|
| 纯黑（不透明）        | ![](https://qcdn2.zhaomi.cn/d/ptyGRnnvhwP_vlyRrwOPHhp_mark.png)             | 组件背景设置0xFF000000的渲染效果            | `0xFF000000` / `new Color(0xFF000000)`   |
| 完全透明（兜底显黑）     |![示例图](https://markdown.com.cn/images/blue.jpg) | 0x00000000在黑底父容器下的显示效果           | `0x00000000` / `Color.Transparent`       |
| 半透红（Alpha=128） | ![示例图](https://markdown.com.cn/images/green.jpg)          | Alpha=128的红色在黄色背景上的叠加效果          | `0x80FF0000` / `Color.rgba(255,0,0,0.5)` |
| 6位RGB补Alpha对比  | ![](https://markdown.com.cn/images/i-am-svg.svg)    | 左：0x000000（透明黑） 右：0xFF000000（纯黑） | `0x000000` vs `0xFF000000`               |
| 本地图片-颜色面板      | ![图片名称3](./003.png)                       | 本地assets目录下的颜色配置面板截图             | -                                        |
| 透明度叠加效果        | ![图片名称3](./001.svg)   | Alpha=128 + opacity=0.5的最终渲染效果   | `new Color(0x80000000)` + `opacity:0.5`  |

### 含有html文本的表格

| ArkTS颜色场景     | HTML文本示例（可视化展示）                                                                                                                                                                                                  | HTML说明              | 对应ArkTS代码                                         |
|---------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|---------------------------------------------------|
| 纯黑/纯白对比       | <div style="display:flex;gap:10px;"><div style="width:80px;height:40px;background:#000;color:#fff;">纯黑</div><div style="width:80px;height:40px;background:#fff;border:1px solid #000;color:#000;">纯白</div></div> | 行内Flex布局展示纯黑/纯白色块   | `Color.Black` / `Color.White`                     |
| 透明度渐变展示       | <div style="width:200px;height:40px;background:linear-gradient(to right, rgba(255,0,0,1), rgba(255,0,0,0));"></div>                                                                                              | 红色透明度从1到0的渐变条       | `Color.rgba(255,0,0,1)` → `Color.rgba(255,0,0,0)` |
| ARGB数值解析弹窗    | <button onclick="alert('0x80FF0000 → Alpha=128, Red=255, Green=0, Blue=0')">解析0x80FF0000</button>                                                                                                                | 点击按钮弹窗展示数值通道解析结果    | `const alpha = (0x80FF0000 >>24) & 0xFF`          |
| 6位RGB补Alpha提示 | <p style="color:#f00;font-weight:bold;">注意：6位0x000000需补0xFF → 0xFF000000</p>                                                                                                                                     | 红色加粗提示6位数值补Alpha的规则 | `0xFF000000                                       | 
| 颜色值输入框        | <input type="text" value="0x80FF0000" style="width:150px;padding:4px;border:1px solid #ccc;" placeholder="输入ARGB数值">                                                                                             | 可输入的颜色数值输入框         | `new Color(输入值)`                                  |
| 多版本兼容性标注      | <span style="background:#e6f7ff;color:#1890ff;padding:2px 6px;border-radius:3px;">API 9+</span> <span style="background:#fff7e6;color:#faad14;padding:2px 6px;border-radius:3px;margin-left:5px;">API 7-8</span> | 不同版本兼容性的标签样式        | 低版本用`Color.rgba()`，高版本用`colorManager`             |
| 换行文本说明        | <div>ARGB数值规则：<br>1. AA：透明度(0-255)<br>2. RR：红色(0-255)<br>3. GG：绿色(0-255)<br>4. BB：蓝色(0-255)</div>                                                                                                                | 换行展示ARGB数值的拆解说明     | `(alpha <<24)                                     | 
