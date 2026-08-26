import { CodeBlockTheme } from "../theme/CodeBlockTheme"

/**
 * 代码标题栏组件
 *
 * @param codeText 代码内容
 * @param info 代码类型（空字符串表示未指定）
 * @param codeBlockTheme 代码样式
 * @param codeCopyCallback 复制点击事件
 * @param codeFullScreenCallback 全屏点击事件
 * @param showTypeText 是否显示代码块类型文本（组合代码块列表已用Tab展示，传false避免重复）
 */
@Component
export struct CodeTitleComponent {
  @Prop codeText: string = "" // 代码内容
  @Prop info: string = "" // 代码类型
  @Prop showTypeText: boolean = true // 是否显示代码块类型文本
  @ObjectLink codeBlockTheme: CodeBlockTheme // 代码样式
  codeCopyCallback?: (code: string) => void // 复制点击事件
  codeFullScreenCallback?: (code: string, language: string | undefined) => void // 全屏点击事件

  build() {
    Row() {
      Text(this.info.length > 0 ? this.info : this.codeBlockTheme.codeBlockTypeText)
        .fontFamily(this.codeBlockTheme.codeBlockTypeTextFontFamily ?? this.codeBlockTheme.codeBlockTextFontFamily)
        .fontSize(this.codeBlockTheme.codeBlockTypeTextFontSize ?? this.codeBlockTheme.codeBlockTextFontSize)
        .fontWeight(this.codeBlockTheme.codeBlockTypeTextFontWeight ?? this.codeBlockTheme.codeBlockTextFontWeight)
        .fontStyle(this.codeBlockTheme.codeBlockTypeTextFontStyle ?? this.codeBlockTheme.codeBlockTextFontStyle)
        .fontColor(this.codeBlockTheme.codeBlockTypeTextFontColor ?? this.codeBlockTheme.codeBlockTextFontColor)
        .lineHeight(this.codeBlockTheme.codeBlockTypeTextLineHeight ?? this.codeBlockTheme.codeBlockTextLineHeight)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .width('30%')
        .margin({ left: this.codeBlockTheme.codeBlockTypeTextMarginLeft })
        .visibility(this.showTypeText && this.codeText.trim().length > 0 ? Visibility.Visible : Visibility.None)

      Blank()
        .layoutWeight(1)

      // 复制按钮（始终创建，用visibility控制显隐）
      Row() {
        Image(this.codeBlockTheme.codeBlockCopyIcon)
          .width(this.copyIconWidth())
          .height(this.copyIconHeight())
          .objectFit(ImageFit.Contain)
          .visibility(this.codeBlockTheme.codeBlockCopyIcon !== undefined ? Visibility.Visible : Visibility.None)

        Blank()
          .width(this.codeBlockTheme.codeBlockCopyIconTextSpacing)
          .visibility(this.codeBlockTheme.codeBlockCopyIcon !== undefined && this.codeBlockTheme.codeBlockCopyTextIsShow ? Visibility.Visible : Visibility.None)

        Text(this.codeBlockTheme.codeBlockCopyText)
          .fontFamily(this.codeBlockTheme.codeBlockCopyTextFontFamily ?? this.codeBlockTheme.codeBlockTextFontFamily)
          .fontSize(this.codeBlockTheme.codeBlockCopyTextFontSize ?? this.codeBlockTheme.codeBlockTextFontSize)
          .fontWeight(this.codeBlockTheme.codeBlockCopyTextFontWeight ?? this.codeBlockTheme.codeBlockTextFontWeight)
          .fontStyle(this.codeBlockTheme.codeBlockCopyTextFontStyle ?? this.codeBlockTheme.codeBlockTextFontStyle)
          .fontColor(this.codeBlockTheme.codeBlockCopyTextFontColor ?? this.codeBlockTheme.codeBlockTextFontColor)
          .lineHeight(this.codeBlockTheme.codeBlockCopyTextLineHeight ?? this.codeBlockTheme.codeBlockTextLineHeight)
          .align(Alignment.End)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .visibility(this.codeBlockTheme.codeBlockCopyTextIsShow ? Visibility.Visible : Visibility.None)
      }
      .justifyContent(FlexAlign.End)
      .onClick(() => {
        this.codeCopyCallback?.(this.codeText)
      })
      .visibility(this.codeBlockTheme.codeBlockCopyButtonIsShow ? Visibility.Visible : Visibility.None)

      Blank()
        .width(this.codeBlockTheme.codeBlockCopyFullScreenSpacing)
        .visibility(this.codeBlockTheme.codeBlockCopyButtonIsShow && this.codeBlockTheme.codeBlockFullScreenButtonIsShow ? Visibility.Visible : Visibility.None)

      // 全屏按钮（始终创建，用visibility控制显隐）
      Row() {
        Image(this.codeBlockTheme.codeBlockFullScreenIcon)
          .width(this.fullScreenIconWidth())
          .height(this.fullScreenIconHeight())
          .objectFit(ImageFit.Contain)
          .visibility(this.codeBlockTheme.codeBlockFullScreenIcon !== undefined ? Visibility.Visible : Visibility.None)

        Blank()
          .width(this.codeBlockTheme.codeBlockFullScreenIconTextSpacing)
          .visibility(this.codeBlockTheme.codeBlockFullScreenIcon !== undefined && this.codeBlockTheme.codeBlockFullScreenTextIsShow ? Visibility.Visible : Visibility.None)

        Text(this.codeBlockTheme.codeBlockFullScreenText)
          .fontFamily(this.codeBlockTheme.codeBlockFullScreenTextFontFamily ?? this.codeBlockTheme.codeBlockTextFontFamily)
          .fontSize(this.codeBlockTheme.codeBlockFullScreenTextFontSize ?? this.codeBlockTheme.codeBlockTextFontSize)
          .fontWeight(this.codeBlockTheme.codeBlockFullScreenTextFontWeight ?? this.codeBlockTheme.codeBlockTextFontWeight)
          .fontStyle(this.codeBlockTheme.codeBlockFullScreenTextFontStyle ?? this.codeBlockTheme.codeBlockTextFontStyle)
          .fontColor(this.codeBlockTheme.codeBlockFullScreenTextFontColor ?? this.codeBlockTheme.codeBlockTextFontColor)
          .lineHeight(this.codeBlockTheme.codeBlockFullScreenTextLineHeight ?? this.codeBlockTheme.codeBlockTextLineHeight)
          .align(Alignment.End)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .visibility(this.codeBlockTheme.codeBlockFullScreenTextIsShow ? Visibility.Visible : Visibility.None)
      }
      .justifyContent(FlexAlign.End)
      .onClick(() => {
        this.codeFullScreenCallback?.(this.codeText, this.info.length > 0 ? this.info : undefined)
      })
      .visibility(this.codeBlockTheme.codeBlockFullScreenButtonIsShow ? Visibility.Visible : Visibility.None)
    }
    .margin({
      top: 8.0,
      right: 8.0,
      bottom: this.codeBlockTheme.codeBlockTitleLayoutMarginBottom
    })
    .alignItems(VerticalAlign.Center)
  }

  /**
   * 复制图标宽度：负数/0 会触发 Image 回退到原图尺寸导致图标异常放大，这里兜底为默认 24.0
   */
  private copyIconWidth(): Length {
    const w = this.codeBlockTheme.codeBlockCopyIconWidth
    if (typeof w === 'number') {
      return w > 0 ? w : 24.0
    }
    return w
  }
  /**
   * 复制图标高度：负数/0 兜底为默认 24.0
   */
  private copyIconHeight(): Length {
    const h = this.codeBlockTheme.codeBlockCopyIconHeight
    if (typeof h === 'number') {
      return h > 0 ? h : 24.0
    }
    return h
  }
  /**
   * 全屏图标宽度：负数/0 兜底为默认 24.0
   */
  private fullScreenIconWidth(): Length {
    const w = this.codeBlockTheme.codeBlockFullScreenIconWidth
    if (typeof w === 'number') {
      return w > 0 ? w : 24.0
    }
    return w
  }
  /**
   * 全屏图标高度：负数/0 兜底为默认 24.0
   */
  private fullScreenIconHeight(): Length {
    const h = this.codeBlockTheme.codeBlockFullScreenIconHeight
    if (typeof h === 'number') {
      return h > 0 ? h : 24.0
    }
    return h
  }
}
