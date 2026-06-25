import { CodeBlockTheme } from "../theme/CodeBlockTheme"

/**
 * 代码标题栏
 *
 * @param codeText 代码内容
 * @param language 代码类型
 * @param codeBlockTheme 代码样式
 * @param codeCopyCallback 复制点击事件
 * @param codeFullScreenCallback 全屏点击事件
 */
@Builder
export function codeLine(
  codeText: string,
  language: string | undefined,
  codeBlockTheme: CodeBlockTheme,
  codeCopyCallback: ((code: string) => void) | undefined,
  codeFullScreenCallback: ((code: string, language: string | undefined) => void) | undefined
) {
  Row() {
    if (codeText.trim().length > 0) {
      Row() {
        Text(language ?? codeBlockTheme.codeBlockTypeText)
          .fontFamily(codeBlockTheme.codeBlockTypeTextFontFamily ?? codeBlockTheme.codeBlockTextFontFamily)
          .fontSize(codeBlockTheme.codeBlockTypeTextFontSize ?? codeBlockTheme.codeBlockTextFontSize)
          .fontWeight(codeBlockTheme.codeBlockTypeTextFontWeight ?? codeBlockTheme.codeBlockTextFontWeight)
          .fontStyle(codeBlockTheme.codeBlockTypeTextFontStyle ?? codeBlockTheme.codeBlockTextFontStyle)
          .fontColor(codeBlockTheme.codeBlockTypeTextFontColor ?? codeBlockTheme.codeBlockTextFontColor)
          .lineHeight(codeBlockTheme.codeBlockTypeTextLineHeight ?? codeBlockTheme.codeBlockTextLineHeight)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
      }
      .width('30%')
      .justifyContent(FlexAlign.Start)
      .margin({ left: codeBlockTheme.codeBlockTypeTextMarginLeft })

      Row() {
        if (codeBlockTheme.codeBlockCopyButtonIsShow) {
          Row() {
            if (codeBlockTheme.codeBlockCopyIcon !== undefined) {
              Image(codeBlockTheme.codeBlockCopyIcon)
                .width(codeBlockTheme.codeBlockCopyIconWidth)
                .height(codeBlockTheme.codeBlockCopyIconHeight)
                .objectFit(ImageFit.Contain)
            }

            Blank()
              .width(codeBlockTheme.codeBlockCopyIconTextSpacing)

            if (codeBlockTheme.codeBlockCopyTextIsShow) {
              Text(codeBlockTheme.codeBlockCopyText)
                .fontFamily(codeBlockTheme.codeBlockCopyTextFontFamily ?? codeBlockTheme.codeBlockTextFontFamily)
                .fontSize(codeBlockTheme.codeBlockCopyTextFontSize ?? codeBlockTheme.codeBlockTextFontSize)
                .fontWeight(codeBlockTheme.codeBlockCopyTextFontWeight ?? codeBlockTheme.codeBlockTextFontWeight)
                .fontStyle(codeBlockTheme.codeBlockCopyTextFontStyle ?? codeBlockTheme.codeBlockTextFontStyle)
                .fontColor(codeBlockTheme.codeBlockCopyTextFontColor ?? codeBlockTheme.codeBlockTextFontColor)
                .lineHeight(codeBlockTheme.codeBlockCopyTextLineHeight ?? codeBlockTheme.codeBlockTextLineHeight)
                .align(Alignment.End)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
          }
          .justifyContent(FlexAlign.End)
          .onClick(() => {
            codeCopyCallback?.(codeText)
          })
        }

        Blank()
          .width(codeBlockTheme.codeBlockCopyFullScreenSpacing)

        if (codeBlockTheme.codeBlockFullScreenButtonIsShow) {
          Row() {
            if (codeBlockTheme.codeBlockFullScreenIcon !== undefined) {
              Image(codeBlockTheme.codeBlockFullScreenIcon)
                .width(codeBlockTheme.codeBlockFullScreenIconWidth)
                .height(codeBlockTheme.codeBlockFullScreenIconHeight)
                .objectFit(ImageFit.Contain)
            }

            Blank()
              .width(codeBlockTheme.codeBlockFullScreenIconTextSpacing)

            if (codeBlockTheme.codeBlockFullScreenTextIsShow) {
              Text(codeBlockTheme.codeBlockFullScreenText)
                .fontFamily(codeBlockTheme.codeBlockFullScreenTextFontFamily ?? codeBlockTheme.codeBlockTextFontFamily)
                .fontSize(codeBlockTheme.codeBlockFullScreenTextFontSize ?? codeBlockTheme.codeBlockTextFontSize)
                .fontWeight(codeBlockTheme.codeBlockFullScreenTextFontWeight ?? codeBlockTheme.codeBlockTextFontWeight)
                .fontStyle(codeBlockTheme.codeBlockFullScreenTextFontStyle ?? codeBlockTheme.codeBlockTextFontStyle)
                .fontColor(codeBlockTheme.codeBlockFullScreenTextFontColor ?? codeBlockTheme.codeBlockTextFontColor)
                .lineHeight(codeBlockTheme.codeBlockFullScreenTextLineHeight ?? codeBlockTheme.codeBlockTextLineHeight)
                .align(Alignment.End)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
          }
          .justifyContent(FlexAlign.End)
          .onClick(() => {
            codeFullScreenCallback?.(codeText, language)
          })
        }
      }
      .width('70%')
      .justifyContent(FlexAlign.End)
    } else {
      Row()
        .width('100%')
        .justifyContent(FlexAlign.Start)
    }
  }
  .margin({
    top: 8.0,
    right: 8.0,
    bottom: codeBlockTheme.codeBlockTitleLayoutMarginBottom
  })
  .alignItems(VerticalAlign.Center)
}