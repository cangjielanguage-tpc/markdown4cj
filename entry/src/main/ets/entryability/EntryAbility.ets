import { AbilityConstant, ConfigurationConstant, UIAbility, Want, Configuration } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { resourceManager } from '@kit.LocalizationKit';

const DOMAIN = 0x0000;

export let baseManager: resourceManager.ResourceManager | null = null

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
    // 初始化时缓存当前设备的颜色模式
    AppStorage.setOrCreate('currentColorMode', this.context.config.colorMode)
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    let context = this.context;
    baseManager = context.resourceManager;
    windowStage.loadContent('pages/IndexPage', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      // 开启全屏沉浸式导航模式
      const win = windowStage.getMainWindowSync()
      win.setWindowLayoutFullScreen(true)
      // 获取顶部规避区域，并记录到 AppStorage 中
      const top = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect
      AppStorage.setOrCreate<number>('safeTop', px2vp(top.height))
      // 获取底部规避区域，并记录到 AppStorage 中
      const bottom = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).bottomRect
      AppStorage.setOrCreate<number>('safeBottom', px2vp(bottom.height))
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }

  onConfigurationUpdate(newConfig: Configuration): void {
    // 获取变更后的颜色模式
    let newColorMode = newConfig.colorMode
    // 可选：比较当前存储的模式，避免重复更新
    let currentColorMode = AppStorage.get<ConfigurationConstant.ColorMode>('currentColorMode')
    if (newColorMode !== currentColorMode) {
      AppStorage.setOrCreate('currentColorMode', newColorMode)
    }
  }
}