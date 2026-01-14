/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights resvered.
 */
package ohos_app_cangjie_entry

import kit.AbilityKit.*
import kit.ArkUI.*

public var uiAbilityContext: ?UIAbilityContext = None

class MainAbility <: UIAbility {
    public init() {
        super()
        registerSelf()
    }

    public override func onCreate(want: Want, launchParam: LaunchParam): Unit {
        uiAbilityContext = context
        match (launchParam.launchReason) {
            case LaunchReason.StartAbility => ()
            case _ => ()
        }
    }

    public override func onWindowStageCreate(windowStage: WindowStage): Unit {
        windowStage.loadContent("Index")
    }
}

public func getUIAbilityContext(): Context {
    uiAbilityContext.getOrThrow()
}