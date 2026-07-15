### HTML缩进代码块

<pre>
// 弹窗提示函数
function showMessage(content) {
    // 缩进2个空格，格式完全保留
    if (content && typeof content === "string") {
        alert(`提示：${content}`);
    } else {
        alert("请输入有效文本！");
    }
}

// 调用示例
showMessage("pre 标签保留所有格式");
</pre>