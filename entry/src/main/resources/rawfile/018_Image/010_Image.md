# 图片----测试图片拉伸，md文本需要设置固定宽高，不设置，代码自己计算宽高

## 测试图片语法
图片语法主要分为两类,一类是markdown Image语法,一类是html图片语法

### markdown-图片语法--网络图片
分为带样式图片和默认不带样式图片.网络图片和本地图片(默认路径是rawfile根目录)。其中样式主要包含：{:width=200}{:height=200}{:border-radius=0}{:style="border-radius: 180px"},均默认单位走vp，和cangjieUI一致

不带样式，默认

![无法加载时显示此文本](https://picsum.photos/id/64/500/960)

加载失败--显示空白，不显示图标

![无法加载时显示此文本](https://id/64/500/960)

带样式-无单位
---与本地图片计算方式不一样,效果不同,没有拉伸
{:width=200}{:height=200}{:border-radius=0}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:width=200}{:height=200}{:border-radius=0}

{:width=200}{:height=200}{:border-radius=90}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:width=200}{:height=200}{:border-radius=90}

{:width=200}{:height=200}{:border-radius=180}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:width=200}{:height=200}{:border-radius=180}

带样式-vp-不识别走默认-{:width=200vp}{:height=200vp}{:border-radius=90vp}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:width=200vp}{:height=200vp}{:border-radius=90vp}

带样式-px-不识别走默认-{:width=200px}{:height=200px}{:border-radius=180px}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:width=200px}{:height=200px}{:border-radius=180px}

带样式-百分比-宽高支持,圆角不支持-{:width=50%}{:height=50%}{:border-radius=180%}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:width=50%}{:height=50%}{:border-radius=180%}

带style样式-无单位
{:style="width：200;height:200;border-radius:180"}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:style="width：200;height:200;border-radius:180"}

{:style="width：200"}{:style="height:200"}{:style="border-radius:180"}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:style="width：200"}{:style="height:200"}{:style="border-radius:180"}

{:style="width：400"}{:style="height:400"}{:style="border-radius:90"}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:style="width：400"}{:style="height:400"}{:style="border-radius:90"}

{:style="width：800"}{:style="height:600"}{:style="border-radius:0"}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:style="width：800"}{:style="height:600"}{:style="border-radius:0"}

带style样式-单位px-{:style="width：200px"}{:style="height:200px"}{:style="border-radius:180px"}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:style="width：200px"}{:style="height:200px"}{:style="border-radius:180px"}

带style样式-单位vp-{:style="width：200vp"}{:style="height:200vp"}{:style="border-radius:180vp"}
{:style="width：200vp"}{:style="height:200vp"}{:style="border-radius:180vp"}

![无法加载时显示此文本](https://picsum.photos/id/64/500/960){:style="width：200vp"}{:style="height:200vp"}{:style="border-radius:180vp"}











