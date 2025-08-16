[toc]
### 测试音频插件

![](https://qncdn.n.cn/so/upfile/8bb2e56621119eff26b21cdf90ad849f.mp3)


### 测试视频插件

*  Open the file.
*  Find the following code block on line 21:

   ![](https://psd.n.cn/aiso-vod/prod/image_video/202506/GwvyRjShNMe.mp4)

*  Update the title to match the name of your website.


## 测试组合代码块列表插件-列表（有序、无序、任务）

- 无序列表1-1
    - 无序列表1-1-1
    - 无序列表1-1-2
    - 无序列表1-1-3
    - 无序列表1-1-4
    - 无序列表1-1-5
    - 无序列表1-1-6
- 无序列表1-2
    1. 有序列表1-2-1
    2. 有序列表1-2-2
    3. 有序列表1-2-3
    4. 有序列表1-2-4
    5. 有序列表1-2-5
    6. 有序列表1-2-6
- 无序列表1-3
    - 无序列表1-3-1
    - [ ] 任务列表1-3-2
    - [x] 任务列表1-3-3
    - 无序列表1-3-4
    - [ ] 任务列表1-3-5
    - 无序列表1-3-6
- 无序列表1-4
    - [ ] 任务列表1-4-1
    - [x] 任务列表1-4-2
    - [ ] 任务列表1-4-3
    - [ ] 任务列表1-4-4
    - [x] 任务列表1-4-5
    - [x] 任务列表1-4-6
## 测试组合代码块列表插件-组合代码块
```python []
print "你好力扣"
```
```groovy []
implementation "ru.noties:markwon-image-loader:\${markwonVersion}"
implementation "ru.noties:markwon-syntax-highlight:\${markwonVersion}"
implementation "ru.noties:markwon-view:\${markwonVersion}"
```
```html []
<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==" alt="Red dot" />
<img src='data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" x="0px" y="0px" viewBox="0 0 100 100" width="15" height="15" class="icon outbound"><path fill="currentColor" d="M18.8,85.1h56l0,0c2.2,0,4-1.8,4-4v-32h-8v28h-48v-48h28v-8h-32l0,0c-2.2,0-4,1.8-4,4v56C14.8,83.3,16.6,85.1,18.8,85.1z"></path> <polygon fill="currentColor" points="45.7,48.7 51.3,54.3 77.2,28.5 77.2,37.2 85.2,37.2 85.2,14.9 62.8,14.9 62.8,22.9 71.5,22.9"></polygon></svg>' >
```
```json []
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}
```

##  测试脚注插件
这是另一个段落，也有一个脚注[^2]。

##  测试HTML插件

<div style="color: red;">
  这段文本用 HTML 样式设置为红色，但内部**无法使用 Markdown 粗体**
</div>
这段文本在 HTML 外，**可以正常使用 Markdown 粗体**

### 测试表格插件

*  Open the file.
*  Find the following code block on line 21:

   | abc | def |
      | --- | --- |
   | abc | def |
   | abc | def |

*  Update the title to match the name of your website.

### 测试删除线插件
~~这部分文本会显示删除线~~

## 测试连接自动加载插件-setIsLinkifyPlugin

https://www.58pic.com/newpic/72291467.html


## 测试设置链接块状化插件-setIsLinkViewPlugin

[图片001](https://www.58pic.com/newpic/72291467.html)

## 测试数学公式插件
---

段落中数学公式 $a+b=c$

---

段落中数学公式 \[a+b=c\]


## 测试图片样式插件
网络图片

1111![](https://qcdn2.zhaomi.cn/d/ptyGRnnvhwP_vlyRrwOPHhp_mark.png)1111

本地rawfile图片

![图片名称3](./001.svg)

网络样式图片

![image.png](https://pic.lingkou.xyz/1697707152-SaQbJz-image.png){:width=100}

本地样式rawfile图片

1111 ![图片名称3](./001.svg){:width=200}

### 测试设置图片幻灯片（Banner）插件

*  Open the file.
*  Find the following code block on line 21:

   <![图片名称1](https://pic.leetcode-cn.com/1614477066-YeEeWg-file_1614477068523),![图片名称2](https://pic.leetcode-cn.com/1614477066-byZRdJ-file_1614477068721),![图片名称3](https://pic.leetcode-cn.com/1614477066-olRayu-file_1614477068738)>

*  Update the title to match the name of your website.

<![图片名称1](https://pic.leetcode-cn.com/1614477066-YeEeWg-file_1614477068523),![图片名称2](https://pic.leetcode-cn.com/1614477066-byZRdJ-file_1614477068721),![图片名称3](https://pic.leetcode-cn.com/1614477066-olRayu-file_1614477068738)>
### 测试设置图片视频url集合列表插件

- 无序列表1-1
    - 无序列表1-1-1
      ![image.png](https://pic.lingkou.xyz/1697707152-SaQbJz-image.png){:width=100}{:height=200}{:align="left"}{:style="border-radius: 50px"}
    - 无序列表1-1-2
- 无序列表1-2
    1. 有序列表1-2-1
       ![image.png](https://pic.lingkou.xyz/1697707152-SaQbJz-image.png){:width=100}{:height=200}{:align="left"}{:style="border-radius: 50px"}
    2. 有序列表1-2-2
- 无序列表1-3
    - 无序列表1-3-1
    - [ ] 任务列表1-3-2
      ![image.png](https://pic.lingkou.xyz/1697707152-SaQbJz-image.png){:width=100}{:height=200}{:align="left"}{:style="border-radius: 50px"}
    - [x] 任务列表1-3-3
    - 无序列表1-3-4
    - [ ] 任务列表1-3-5
    - 无序列表1-3-6
### 测试设置TOC插件

# heading1

## heading2

### heading3

#### heading4

##### heading5

###### heading6

# heading1

## heading2

### heading3

#### heading4

##### heading5

###### heading6

# heading1

## heading2

### heading3

#### heading4

##### heading5

###### heading6
## 脚注内容

[^1]: 这是第一个脚注的内容。
[^2]: 这是第二个脚注的内容，你可以在这里详细解释某个概念或者给出相关的参考资料。