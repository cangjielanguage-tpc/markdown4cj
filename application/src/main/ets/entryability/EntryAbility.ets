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
    AppStorage.setOrCreate('currentColorMode', this.context.config.colorMode)
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    let context = this.context;
    baseManager = context.resourceManager;
    // Set up full screen and safe area BEFORE loadContent so pages get correct safeTop
    const win = windowStage.getMainWindowSync()
    AppStorage.setOrCreate('windowClass', win)
    win.setWindowLayoutFullScreen(true)
    const top = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect
    AppStorage.setOrCreate<number>('safeTop', px2vp(top.height))
    const bottom = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).bottomRect
    AppStorage.setOrCreate<number>('safeBottom', px2vp(bottom.height))
    windowStage.loadContent('pages/IndexPage', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }

  onConfigurationUpdate(newConfig: Configuration): void {
    let newColorMode = newConfig.colorMode
    let currentColorMode = AppStorage.get<ConfigurationConstant.ColorMode>('currentColorMode')
    if (newColorMode !== currentColorMode) {
      AppStorage.setOrCreate('currentColorMode', newColorMode)
    }
  }
}
