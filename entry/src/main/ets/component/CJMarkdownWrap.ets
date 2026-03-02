/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
import {
  CJMarkdown,
  MarkdownConfiguration,
  MarkdownPlugin,
  MarkdownTheme,
  MarkdownScroller
} from '@cangjie-tpc/markdown_hybrid'
import hilog from '@ohos.hilog'
import { promptAction } from '@kit.ArkUI'

const SIZE: number = 36
const MARGIN: number = SIZE * 2 + 25

@Component
export struct CJMarkdownWrap {
  @Prop
  input: string
  @State
  scroller?: MarkdownScroller = undefined

  setScroller(): MarkdownScroller {
    if (this.scroller === undefined) {
      this.scroller = new MarkdownScroller()
    }
    return this.scroller
  }

  setPlugin(): MarkdownPlugin {
    let plugin: MarkdownPlugin = new MarkdownPlugin();
    plugin.setIsImageStylePlugin(true);
    plugin.setIsImageSlidePlugin(true);
    plugin.setIsImageTextMixPlugin(true);
    plugin.setIsImageCollectPlugin(true);
    plugin.setIsTablePlugin(true);
    plugin.setIsLatexMathPlugin(true);
    plugin.setIsStrikethroughPlugin(true);
    plugin.setIsImageStylePlugin(true);
    plugin.setIsTaskListPlugin(true);
    return plugin;
  }

  setConfiguration(): MarkdownConfiguration {
    let config: MarkdownConfiguration = new MarkdownConfiguration();
    let theme: MarkdownTheme = new MarkdownTheme();
    //TODO: theme
    theme.setImageMaximumWidth(1); //缩放比例
    theme.setIsOnCopy(false);
    theme.setIsMarkdownParserSync(true)
    /**
     * 保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
     * Contain = 0,
     * 保持宽高比进行缩小或者放大，使得图片恰好完全显示在显示边界内。
     Cover = 1,
     * 不保持宽高比进行放大缩小，使得图片充满显示边界。
     Fill = 2
     * */
    theme.setImageFitType(1)
    theme.setTableOddRowBackgroundColor(0XFFFFFFFF); //背景色
    theme.setTableEvenRowBackgroundColor(0XFFFFFFFF);
    config.setMarkdownTheme(theme);
    config.setLinkCallback(url => {
      // console.log(TAG_NAME, `link callback:${url}`);
      // ChatH5Util.openUrl(getContext(), url);
      hilog.error(1, "1", `---url:${url}`)
      promptAction.showToast({
        message: url,
        duration: 2000
      });
    });
    config.setTextCopyCallback(txt => {
      // console.log(TAG_NAME, `copy callback:${txt}`);
      hilog.error(1, "1", `---txt:${txt}`)
      promptAction.showToast({
        message: txt,
        duration: 2000
      });
    });
    config.setImageCallback((url: string, imgList: Array<string>) => {
      hilog.error(1, "1", `---url:${url},imgList:${imgList}`)
      promptAction.showToast({
        message: url,
        duration: 2000
      });
      // console.log(TAG_NAME, `image callback:${url}, imgList:${JSON.stringify(imgList)}`);
      // let imagesUrlList: Array<IPhotoListItem> = new Array();
      // let index: number = 0;
      // imgList.forEach((_url, idx) => {
      //   imagesUrlList.push({
      //     imageUrl: _url,
      //     imageType: EImageType.IMAGE
      //   });
      //   if(_url === url) {
      //     index = idx;
      //   }
      // })
      // this.openImagePreview(imagesUrlList, url, index);
    });

    return config;
  }

  imageCallback(url: string, urlList: Array<string>): void {
    hilog.error(1, "1", `---url:${url},urlList:${urlList}`)
    promptAction.showToast({
      message: url,
      duration: 2000
    });
  }

  isText() {
    return this.input.length <= 60
  }

  build() {
    CJMarkdown({
      content: this.input,
      config: this.setConfiguration(),
      plugin: this.setPlugin(),
      listScroller: this.setScroller()
    })
    .constraintSize({ maxHeight: '150%' })
    .width("90%")
  }
}
