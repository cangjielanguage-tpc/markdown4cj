/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.hilog.Hilog

public var globalAbilityContext: ?AbilityContext = None

class MainAbility <: Ability {
    public init() {
        super()
        registerSelf()
    }

    public override func onCreate(want: Want, launchParam: LaunchParam): Unit {
        globalAbilityContext = context
        AppLog.info("MainAbility OnCreated.${want.abilityName}")
        match (launchParam.launchReason) {
            case LaunchReason.START_ABILITY => AppLog.info("START_ABILITY")
            case _ => ()
        }
    }

    public override func onWindowStageCreate(windowStage: WindowStage): Unit {
        AppLog.info("MainAbility onWindowStageCreate.")
        // 1.获取应用主窗口。
        let windowClass = windowStage.getMainWindow()
        let top = windowClass.getWindowAvoidArea(AvoidAreaType.TYPE_SYSTEM).topRect.height
        Hilog.error(1,"1","----------------top:${top}")
        windowClass.setWindowLayoutFullScreen(true)
        windowStage.loadContent("IndexPage")
    }
}

func createAbility(): MainAbility {
    MainAbility()
}

public func getGlobalAbilityContext(): AbilityContext {
    globalAbilityContext.getOrThrow()
}