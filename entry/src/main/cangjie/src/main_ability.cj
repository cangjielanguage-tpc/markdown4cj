/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package ohos_app_cangjie_entry

import kit.PerformanceAnalysisKit.Hilog
import kit.AbilityKit.Want
import kit.AbilityKit.UIAbility
import kit.AbilityKit.LaunchParam
import kit.AbilityKit.LaunchReason
import kit.ArkUI.WindowStage

//public var globalAbilityContext: ?AbilityContext = None

class MainAbility <: UIAbility {
    public init() {
        super()
        registerSelf()
    }

    public override func onCreate(want: Want, launchParam: LaunchParam): Unit {
//        globalAbilityContext = context
//        AppLog.info("MainAbility OnCreated.${want.abilityName}")
        match (launchParam.launchReason) {
            case LaunchReason.StartAbility => ()//AppLog.info("START_ABILITY")
            case _ => ()
        }
    }

    public override func onWindowStageCreate(windowStage: WindowStage): Unit {
//        AppLog.info("MainAbility onWindowStageCreate.")
        windowStage.loadContent("Index")
    }
}

//func createAbility(): MainAbility {
//    MainAbility()
//}
//
//public func getGlobalAbilityContext(): AbilityContext {
//    globalAbilityContext.getOrThrow()
//}