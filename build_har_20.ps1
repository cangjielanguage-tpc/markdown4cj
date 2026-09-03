<#
.SYNOPSIS
  下载子模块源码 -> 批量打包子模块 HAR -> 编译 markdown_arkui 模块。
  （兼容 API 20 版本：不修改子模块的 compatibleSdkVersion，保持仓库默认值 6.0.0(20)）

.DESCRIPTION
  流程（按顺序）：
    1. 依据 .gitmodules 下载 4 个子模块（prism4cj / codeformat4cj / markdown4cj / formula4cj）
    2. 依次打包子模块 HAR 并复制到根项目 markdown_arkui\har 目录：
         modules\prism4cj      -> prism_hybrid.har
         modules\codeformat4cj -> codeformat_hybrid.har
         modules\markdown4cj   -> markdown_parser_hybrid.har
         modules\formula4cj    -> formula_hybrid.har
    3. 在根项目编译 markdown_arkui 模块（assembleHar）

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har_20.ps1
  # 完整流程

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har_20.ps1 -Only prism4cj,formula4cj
  # 第 2 步只打包指定模块（第 1 步仍作用于全部 4 个子模块）

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har_20.ps1 -Clean
  # 打包前删除各模块的旧 build 目录

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har_20.ps1 -DevEcoTools 'C:\DevEco\tools' -CangjieSdkRoot 'C:\compat-sdk\compatibility'
  # 显式指定 DevEco Studio 工具目录与兼容性 SDK 路径（不指定时按 环境变量 -> 项目同级目录 自动探测）
#>

param(
    # 只打包指定的子模块（prism4cj / codeformat4cj / markdown4cj / formula4cj），为空则全部打包
    [string[]]$Only = @(),
    # 打包前删除各模块的旧 build 目录
    [switch]$Clean,
    # 跳过步骤1（清理并重新下载子模块），用于子模块已就绪时的快速打包
    [switch]$SkipDownload,
    # 构建模式
    [ValidateSet('debug', 'release')]
    [string]$BuildMode = 'release',
    # DevEco Studio 的 tools 目录（含 node/ohpm/hvigor）。
    # 不指定时依次尝试：环境变量 DEVECO_TOOLS_HOME -> 项目根上级目录中形如
    # 'DevEco Studio*' 的安装目录下的 tools -> 环境变量 DEVECO_SDK_HOME 推导
    [string]$DevEcoTools = '',
    # 兼容性 SDK 的 compatibility 根目录（含 build-tools/api）。
    # 不指定时依次尝试：环境变量 DEVECO_CANGJIE_PATH -> 项目根上级目录中的
    # compatibility-sdk-* 目录下的 compatibility
    [string]$CangjieSdkRoot = ''
)

$ErrorActionPreference = 'Stop'

$ProjectRoot  = $PSScriptRoot
$HarOutputDir = Join-Path $ProjectRoot 'markdown_arkui\har'

# ---------------- 工具链路径自动探测（不再写死本地路径） ----------------
# 优先级：脚本参数 > 环境变量 > 项目根各级祖先目录中的常见安装布局
# （典型布局：项目与 DevEco Studio 安装目录、兼容性 SDK 目录位于同一磁盘根下，
#   例如 D:\DevecoStudio_Code_x.y.z\<项目> 与 D:\DevecoStudio_x.y.z\DevEco Studio）

# 收集用于搜索的祖先目录（项目根的父目录起，向上最多 3 级）
function Get-SearchBases {
    param([string]$Root)
    $bases = @()
    $dir = Split-Path $Root
    for ($i = 0; $i -lt 3 -and $dir; $i++) {
        $bases += $dir
        $dir = Split-Path $dir
    }
    return $bases | Select-Object -Unique
}

# 提取项目根名称中的版本号（如 6.1.1），用于候选路径排序——
# 同名版本号的安装目录优先，避免多版本共存时误选旧版本工具链。
$VersionHint = if ($ProjectRoot -match '(\d+\.\d+(?:\.\d+)?)') { $Matches[1] } else { '' }

function Sort-ByVersionHint {
    param([string[]]$Paths)
    if (-not $VersionHint) { return $Paths }
    return @($Paths | Sort-Object { $_ -like "*$VersionHint*" } -Descending)
}

# 探测 DevEco Studio 的 tools 目录
function Resolve-DevEcoTools {
    param([string]$Explicit)
    if ($Explicit -and (Test-Path (Join-Path $Explicit 'hvigor\bin\hvigorw.bat'))) { return $Explicit }

    # 1) 环境变量 DEVECO_TOOLS_HOME
    $fromEnv = $env:DEVECO_TOOLS_HOME
    if ($fromEnv -and (Test-Path (Join-Path $fromEnv 'hvigor\bin\hvigorw.bat'))) { return $fromEnv }

    # 2) 由 DEVECO_SDK_HOME（<安装根>\sdk）推导：<安装根>\tools
    if ($env:DEVECO_SDK_HOME) {
        $guess = Join-Path (Split-Path $env:DEVECO_SDK_HOME) 'tools'
        if (Test-Path (Join-Path $guess 'hvigor\bin\hvigorw.bat')) { return $guess }
    }

    # 3) 祖先目录自身或其下 'DevEco*' 目录中的 'DevEco Studio*' 安装目录
    foreach ($base in Get-SearchBases -Root $ProjectRoot) {
        $roots = Sort-ByVersionHint -Paths @(@($base) + @(Get-ChildItem $base -Directory -Filter 'DevEco*' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName))
        foreach ($r in $roots) {
            $studios = Sort-ByVersionHint -Paths @(Get-ChildItem $r -Directory -Filter 'DevEco Studio*' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName)
            foreach ($s in $studios) {
                $guess = Join-Path $s 'tools'
                if (Test-Path (Join-Path $guess 'hvigor\bin\hvigorw.bat')) { return $guess }
            }
        }
    }
    return $null
}

# 探测兼容性 SDK 的 compatibility 目录
function Resolve-CangjieSdkRoot {
    param([string]$Explicit)
    $marker = Join-Path 'build-tools\tools\hvigor\cangjie-build-support'
    if ($Explicit -and (Test-Path (Join-Path $Explicit $marker))) { return $Explicit }

    # 1) 环境变量 DEVECO_CANGJIE_PATH
    $fromEnv = $env:DEVECO_CANGJIE_PATH
    if ($fromEnv -and (Test-Path (Join-Path $fromEnv $marker))) { return $fromEnv }

    # 2) 祖先目录自身或其下 'DevEco*' 目录中的 'compatibility-sdk-*' 目录
    foreach ($base in Get-SearchBases -Root $ProjectRoot) {
        $roots = Sort-ByVersionHint -Paths @(@($base) + @(Get-ChildItem $base -Directory -Filter 'DevEco*' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName))
        foreach ($r in $roots) {
            $sdks = Sort-ByVersionHint -Paths @(Get-ChildItem $r -Directory -Filter 'compatibility-sdk-*' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName)
            foreach ($sdkDir in $sdks) {
                $guess = Join-Path $sdkDir 'compatibility'
                if (Test-Path (Join-Path $guess $marker)) { return $guess }
            }
        }
    }
    return $null
}

$DevEcoTools  = Resolve-DevEcoTools -Explicit $DevEcoTools
if (-not $DevEcoTools) {
    throw '未找到 DevEco Studio tools 目录。请通过 -DevEcoTools 参数或 DEVECO_TOOLS_HOME 环境变量指定（目录内应含 hvigor\bin\hvigorw.bat）。'
}
$CangjieSdkRoot = Resolve-CangjieSdkRoot -Explicit $CangjieSdkRoot
if (-not $CangjieSdkRoot) {
    throw '未找到兼容性 SDK（compatibility 目录）。请通过 -CangjieSdkRoot 参数或 DEVECO_CANGJIE_PATH 环境变量指定（目录内应含 build-tools\tools\hvigor\cangjie-build-support）。'
}
Write-Host "DevEco tools : $DevEcoTools"
Write-Host "Cangjie SDK  : $CangjieSdkRoot"

$NodeHome    = Join-Path $DevEcoTools 'node'
$OhpmBin     = Join-Path $DevEcoTools 'ohpm\bin'
$Hvigorw     = Join-Path $DevEcoTools 'hvigor\bin\hvigorw.bat'

foreach ($tool in @((Join-Path $NodeHome 'node.exe'), (Join-Path $OhpmBin 'ohpm.bat'), $Hvigorw)) {
    if (-not (Test-Path $tool)) {
        Write-Host "找不到工具: $tool，请检查 DevEcoTools 路径（-DevEcoTools 参数 / DEVECO_TOOLS_HOME 环境变量）" -ForegroundColor Red
        exit 1
    }
}

# ---------------- 子模块清单（与 .gitmodules 对应） ----------------
$Submodules = @(
    @{ Name = 'prism4cj';      Path = 'modules/prism4cj' },
    @{ Name = 'codeformat4cj'; Path = 'modules/codeformat4cj' },
    @{ Name = 'markdown4cj';   Path = 'modules/markdown4cj' },
    @{ Name = 'formula4cj';    Path = 'modules/formula4cj' }
)

# 清理上一轮可能残留的构建进程（hvigorw/node.exe）。
# 残留进程会持有子模块目录句柄，导致删除/克隆失败。
function Stop-StaleBuildProcesses {
    $stale = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue | Where-Object {
        $_.ProcessId -ne $PID -and
        $_.Name -match '^(node|cmd)\.exe$' -and
        $_.CommandLine -match 'hvigorw\.bat|hvigor\\bin|ohpm\\bin|cangjie-build-support'
    }
    foreach ($p in $stale) {
        Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
    }
    if ($stale) {
        Write-Host ("已清理 {0} 个遗留构建进程" -f @($stale).Count) -ForegroundColor DarkYellow
    }
}
Stop-StaleBuildProcesses

# ---------------- 步骤1：从零依据 .gitmodules 下载子模块 ----------------
# 从零流程（默认）：无论子模块是否已存在，先删除旧目录与克隆元数据，再全新下载。
# 仅当显式传入 -SkipDownload 时才跳过本步骤（用于子模块已就绪的快速打包）。
if ($SkipDownload) {
    Write-Host '>>> -SkipDownload 已指定，跳过子模块清理与下载' -ForegroundColor Yellow
}
else {
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw '未找到 git 命令，无法下载子模块'
}

# git 习惯把进度/警告写到 stderr，而本脚本 $ErrorActionPreference = 'Stop'，
# PS5.1 会把原生命令的 stderr 输出包装成 NativeCommandError 直接中断脚本。
# 该包装函数临时切到 Continue 并吞掉合并后的输出流，只以退出码判断成败。
function Invoke-GitQuiet {
    param([string[]]$GitArgs)
    $prevEap = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        & git @GitArgs 2>&1 | Out-Null
    } finally {
        $ErrorActionPreference = $prevEap
    }
    if ($LASTEXITCODE -ne 0) {
        throw ("git {0} 失败（退出码 {1}），请检查网络或仓库访问权限" -f ($GitArgs -join ' '), $LASTEXITCODE)
    }
}

# hvigorw / ohpm / curl 等会把 WARN、下载进度写到 stderr，
# $ErrorActionPreference='Stop' 时会被 PS5.1 包装成 NativeCommandError 中断脚本，
# 即使构建本身成功也会被误判为失败。该包装函数临时切到 Continue，
# 正常透传输出（写入日志），仅以退出码判断成败。
function Invoke-NativeTool {
    param([string]$ToolPath, [string[]]$ToolArgs)
    $prevEap = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        & $ToolPath @ToolArgs
    } finally {
        $ErrorActionPreference = $prevEap
    }
    if ($LASTEXITCODE -ne 0) {
        throw ("{0} 执行失败（退出码 {1}）" -f (Split-Path $ToolPath -Leaf), $LASTEXITCODE)
    }
}

# 清空目录内容（带重试与兜底）：
# 文件被其他进程短暂持有时，PowerShell 的 Remove-Item 会直接失败；
# 多重试几轮，最后用 node 的 fs.rmSync（带 maxRetries）兜底。
function Clear-DirectoryContent {
    param([string]$Dir)
    for ($i = 1; $i -le 5; $i++) {
        Get-ChildItem $Dir -Force -ErrorAction SilentlyContinue |
            Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        if ((Get-ChildItem $Dir -Force -ErrorAction SilentlyContinue | Measure-Object).Count -eq 0) {
            return
        }
        Start-Sleep -Seconds 2
    }
    # fs.rmSync 支持对占用文件的重试删除（处理 Windows 文件锁）
    $env:DIR_TO_CLEAR = $Dir
    try {
        & (Join-Path $NodeHome 'node.exe') -e "const p=process.env.DIR_TO_CLEAR;const fs=require('fs');const items=fs.readdirSync(p);for(const it of items){fs.rmSync(p+'\\\\'+it,{recursive:true,force:true,maxRetries:5,retryDelay:1000})}"
    } finally {
        Remove-Item Env:DIR_TO_CLEAR -ErrorAction SilentlyContinue
    }
    $left = (Get-ChildItem $Dir -Force -ErrorAction SilentlyContinue | Measure-Object).Count
    if ($left -gt 0) {
        throw "无法清空目录（仍有 $left 项，可能被其他程序占用）: $Dir"
    }
}

Push-Location $ProjectRoot
try {
    foreach ($sm in $Submodules) {
        $smDir = Join-Path $ProjectRoot $sm.Path
        if (Test-Path $smDir) {
            Write-Host "  清理已有子模块: $($sm.Path)"
            # deinit 清除 .git/config 中的注册项
            Invoke-GitQuiet -GitArgs @('submodule', 'deinit', '-f', '--', $sm.Path)
            try {
                Remove-Item $smDir -Recurse -Force -ErrorAction Stop
            }
            catch {
                # 目录被其他进程（如 IDE）持有句柄时无法删除目录本身，
                # 改为清空目录内容；重新克隆时 git 会复用该空目录，效果等同。
                Write-Host "  目录被占用，改为清空内容: $smDir" -ForegroundColor DarkYellow
                Clear-DirectoryContent -Dir $smDir
            }
        }
        # 删除 .git\modules 下的克隆元数据，确保下一步从网络全新克隆（真正的从零）
        $gitModulesDir = Join-Path $ProjectRoot (".git\modules\" + ($sm.Path -replace '/', '\'))
        if (Test-Path $gitModulesDir) {
            Remove-Item $gitModulesDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }

    Write-Host ''
    Write-Host '>>> 下载子模块（浅克隆，按 .gitmodules 中声明的分支）...'
    # .gitmodules 已声明 shallow = true；update --init 完成注册、克隆并检出主仓库记录的提交
    Invoke-GitQuiet -GitArgs (@('submodule', 'update', '--init', '--depth', '1') + ($Submodules | ForEach-Object { $_.Path }))
    Write-Host '>>> 子模块下载完成'
}
finally {
    Pop-Location
}
}

# ---------------- 环境变量 ----------------
$env:NODE_HOME = $NodeHome
$env:PATH = "$NodeHome;$OhpmBin;$env:PATH"
# 强制覆盖：残留的错误值（如指向 sdk\default）会导致 hvigor 扫描不到
# toolchains/ets/js/native/previewer 组件，报 00303168 SDK component missing
$env:DEVECO_SDK_HOME = Join-Path (Split-Path $DevEcoTools) 'sdk'

# hvigor 用户目录重定向到项目目录内（默认 ~/.hvigor）。
# hvigorw 依据环境变量 HVIGOR_USER_HOME 定位用户缓存目录，
# 构建工作区（project_caches\<hash>\workspace）也落在其下；
# 重定向后受限环境下创建 cangjie-build-support 符号链接不再因权限失败。
$env:HVIGOR_USER_HOME = Join-Path $ProjectRoot '.hvigor_home'

# hvigorw 首跑会安装 pnpm，npm 缓存若指向不可写目录（如全局 D:\nodejs\node_cache）
# 会因权限失败，这里重定向到项目目录内。
$env:npm_config_cache = Join-Path $ProjectRoot '.npm_cache'

# ---------------- 仓颉环境变量 ----------------
# 仓颉构建插件定位：hvigorw 依据 DEVECO_CANGJIE_PATH 将
# <该路径>\build-tools\tools\hvigor\cangjie-build-support 链接进构建工作区的
# node_modules\@ohos，hvigor-ohos-plugin 运行时 require 它来注入
# cangjieOptions schema 并注册仓颉构建任务（CangjiePreBuild/CompileCangjie 等）。
# 不设置该变量时命令行打包会因 build-profile.json5 中 cangjieOptions
# 无法通过 schema 校验而失败（IDE 构建时由 DevEco 自动注入，故 IDE 内正常）。
$env:DEVECO_CANGJIE_PATH = $CangjieSdkRoot

# ---------------- 仓颉构建插件副本（绕过受限环境的符号链接限制） ----------------
# hvigorw 会把 cangjie-build-support 以符号链接挂到构建工作区 node_modules\@ohos，
# 并校验：链接目标一致且 package.json 版本 == hvigorw 自身版本（6.24.2），
# 否则删除重建。受限环境下重建符号链接会 EPERM。
# 对策：将插件复制到项目内并把版本号改成与 hvigor 一致，
# 用 CANGJIE_BUILD_SUPPORT_PATH 指向副本（该变量优先级最高），
# 再预建 junction；hvigorw 校验通过后直接跳过，不再创建链接。
$HvigorVersion = (Get-Content (Join-Path $DevEcoTools 'hvigor\hvigor\package.json') -Raw | ConvertFrom-Json).version
$PluginSrc  = Join-Path $env:DEVECO_CANGJIE_PATH 'build-tools\tools\hvigor\cangjie-build-support'
$PluginCopy = Join-Path $ProjectRoot '.hvigor_home\cangjie-build-support'
if (-not (Test-Path (Join-Path $PluginCopy 'package.json'))) {
    Copy-Item $PluginSrc $PluginCopy -Recurse -Force
}
$PluginPkgPath = Join-Path $PluginCopy 'package.json'
$PluginPkg = Get-Content $PluginPkgPath -Raw
$PluginPkg = $PluginPkg -replace '"version"\s*:\s*"[^"]*"', ('"version": "{0}"' -f $HvigorVersion)
# 用 .NET API 写无 BOM 的 UTF-8（Set-Content -Encoding UTF8 在 PS5.1 下会写 BOM，
# BOM 会导致 hvigor 的 ParseJsonFile（JSON.parse）解析失败）
[System.IO.File]::WriteAllText($PluginPkgPath, $PluginPkg)
$env:CANGJIE_BUILD_SUPPORT_PATH = $PluginCopy

# 在所有已生成的构建工作区中预建（或纠正）cangjie-build-support junction
function Set-CangjieLink {
    $workspaces = Get-ChildItem (Join-Path $env:HVIGOR_USER_HOME 'project_caches') -Directory -ErrorAction SilentlyContinue
    foreach ($w in $workspaces) {
        $ohosDir = Join-Path $w.FullName 'workspace\node_modules\@ohos'
        if (-not (Test-Path $ohosDir)) { continue }
        $link = Join-Path $ohosDir 'cangjie-build-support'
        $item = Get-Item $link -Force -ErrorAction SilentlyContinue
        # Get-Item 返回的 Target 带尾部反斜杠，去掉后再比较
        $curTarget = if ($item) { "$($item.Target | Select-Object -First 1)".TrimEnd('\') } else { $null }
        if ($item -and ($item.LinkType -ne 'Junction' -or $curTarget -ne $PluginCopy)) {
            # 只删 junction 本身：.NET 的 Directory.Delete 会跟随链接枚举目标目录而被拦截，
            # node 的 fs.rmSync 对链接只删链接本身、不跟随。
            # 注意：node -e 的脚本后追加的参数不会进 process.argv，须经环境变量传递。
            $env:LINK_TO_REMOVE = $link
            & (Join-Path $NodeHome 'node.exe') -e "require('fs').rmSync(process.env.LINK_TO_REMOVE, { force: true })"
            Remove-Item Env:LINK_TO_REMOVE -ErrorAction SilentlyContinue
            $item = $null
        }
        if (-not $item) {
            New-Item -ItemType Junction -Path $link -Target $PluginCopy | Out-Null
        }
    }
}
Set-CangjieLink

# cjpm.toml 中存在 Windows 宿主目标 [target.x86_64-w64-mingw32.bin-dependencies]，
# 引用 ${X86_64_LIBS} / ${X86_64_MACRO_LIBS} / ${X86_64_KIT_LIBS}。
# 兼容性 SDK 没有 x86_64-w64-mingw32 目录，这三个变量未设置时
# cjpm 会回退到不存在的默认路径导致 CompileCangjie 失败。
# 打 HAR 只编译 OHOS 目标，这里把它们指向 SDK 中真实存在的目录以通过校验。
$CangjieApiLib = Join-Path $CangjieSdkRoot 'api\lib\linux_ohos_x86_64_cjnative'
if (Test-Path $CangjieApiLib) {
    $env:X86_64_LIBS       = Join-Path $CangjieApiLib 'ohos'
    $env:X86_64_MACRO_LIBS = Join-Path $CangjieApiLib 'c_wrapper_mock'
    $env:X86_64_KIT_LIBS   = Join-Path $CangjieApiLib 'kit'
    # AddApiDependencies 任务可能向 cjpm.toml 追加该变量，同样指向存在的目录
    $llvmDir = Join-Path $CangjieSdkRoot 'build-tools\third_party\llvm'
    if (Test-Path $llvmDir) {
        $env:X86_64_WIN_TPC_MACRO_LIBS = $llvmDir
    }
}

# ---------------- 打包目标 ----------------
$BuildTargets = @(
    @{ Submodule = 'prism4cj';      Module = 'prism_hybrid' },
    @{ Submodule = 'codeformat4cj'; Module = 'codeformat_hybrid' },
    @{ Submodule = 'markdown4cj';   Module = 'markdown_parser_hybrid' },
    @{ Submodule = 'formula4cj';    Module = 'formula_hybrid' }
)

if ($Only.Count -gt 0) {
    $BuildTargets = @($BuildTargets | Where-Object { $Only -contains $_.Submodule })
    if ($BuildTargets.Count -eq 0) {
        Write-Host "-Only 指定的模块均无效，可选值: prism4cj, codeformat4cj, markdown4cj, formula4cj" -ForegroundColor Red
        exit 1
    }
}

if (-not (Test-Path $HarOutputDir)) {
    New-Item -ItemType Directory -Path $HarOutputDir | Out-Null
}

$success = @()
$failed  = @()

foreach ($t in $BuildTargets) {
    $submodule  = $t.Submodule
    $moduleName = $t.Module
    $subDir     = Join-Path $ProjectRoot "modules\$submodule"

    Write-Host ''
    Write-Host "========== 打包 $submodule -> $moduleName.har ==========" -ForegroundColor Cyan

    if (-not (Test-Path $subDir)) {
        Write-Host "子模块目录不存在: $subDir（请先执行 git submodule update --init）" -ForegroundColor Red
        $failed += $moduleName
        continue
    }

    Push-Location $subDir
    try {
        # 清理旧产物
        if ($Clean) {
            $buildDir = Join-Path $subDir "$moduleName\build"
            if (Test-Path $buildDir) {
                Write-Host "清理 $moduleName\build ..."
                Remove-Item $buildDir -Recurse -Force
            }
        }

        # 1. 安装依赖
        Write-Host ">>> ohpm install"
        Invoke-NativeTool -ToolPath "$OhpmBin\ohpm.bat" -ToolArgs @('install')

        # 2. 打包 HAR（命令格式参照官方文档：
        #    hvigorw assembleHar --mode module -p product=default -p module=<ModuleName>@default -p buildMode=release --no-daemon）
        Write-Host ">>> hvigorw assembleHar ($moduleName, $BuildMode)"
        Invoke-NativeTool -ToolPath $Hvigorw -ToolArgs @('assembleHar', '--mode', 'module', '-p', 'product=default', '-p', "module=$moduleName@default", '-p', "buildMode=$BuildMode", '--no-daemon')

        # 3. 复制 HAR 到根项目
        $harFile = Join-Path $subDir "$moduleName\build\default\outputs\default\$moduleName.har"
        if (-not (Test-Path $harFile)) { throw "未找到构建产物: $harFile" }
        Copy-Item $harFile $HarOutputDir -Force
        Write-Host "已复制: $moduleName.har -> $HarOutputDir" -ForegroundColor Green
        $success += $moduleName
    }
    catch {
        Write-Host "打包 $submodule 失败: $($_.Exception.Message)" -ForegroundColor Red
        $failed += $moduleName
    }
    finally {
        Pop-Location
    }
}

Write-Host ''
Write-Host "========== 子模块打包结果 ==========" -ForegroundColor Cyan
Write-Host ("成功: {0}" -f ($success -join ', ')) -ForegroundColor Green
if ($failed.Count -gt 0) {
    Write-Host ("失败: {0}" -f ($failed -join ', ')) -ForegroundColor Red
    exit 1
}

# ---------------- 步骤3：编译根项目 markdown_arkui 模块 ----------------
# markdown_arkui 依赖上一步复制到 markdown_arkui\har 目录的 4 个 HAR
# （见 markdown_arkui\oh-package.json5 中的 dependencies）。
Write-Host ''
Write-Host '========== 编译 markdown_arkui 模块 ==========' -ForegroundColor Cyan
Push-Location $ProjectRoot
try {
    # 根项目安装依赖（建立 oh_modules 并链接本地 HAR）
    Write-Host '>>> ohpm install (根项目)'
    Invoke-NativeTool -ToolPath "$OhpmBin\ohpm.bat" -ToolArgs @('install')

    Write-Host ">>> hvigorw assembleHar (markdown_arkui, $BuildMode)"
    Invoke-NativeTool -ToolPath $Hvigorw -ToolArgs @('assembleHar', '--mode', 'module', '-p', 'product=default', '-p', 'module=markdown_arkui@default', '-p', "buildMode=$BuildMode", '--no-daemon')

    $rootHar = Join-Path $ProjectRoot 'markdown_arkui\build\default\outputs\default\markdown_arkui.har'
    if (Test-Path $rootHar) {
        Write-Host "markdown_arkui.har 已生成: $rootHar" -ForegroundColor Green
    } else {
        throw '构建完成但未找到产物: markdown_arkui.har'
    }
}
catch {
    Write-Host "编译 markdown_arkui 失败: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
finally {
    Pop-Location
}

# ---------------- 清理构建产生的临时缓存目录 ----------------
# hvigor 在用户目录缓存不可写时会把缓存降级落到项目根目录的 .hvigor_local，
# 每次打包结束后删除，避免残留在项目里。
$HvigorLocalCache = Join-Path $ProjectRoot '.hvigor_local'
if (Test-Path $HvigorLocalCache) {
    Remove-Item $HvigorLocalCache -Recurse -Force -ErrorAction SilentlyContinue
    if (-not (Test-Path $HvigorLocalCache)) {
        Write-Host "已清理临时缓存目录 .hvigor_local" -ForegroundColor DarkGray
    }
}

Write-Host ''
Write-Host '========== 全部完成 ==========' -ForegroundColor Green
