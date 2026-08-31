<#
.SYNOPSIS
  批量打包 submodule 项目的 HAR，并复制到根项目 markdown_arkui\har 目录。

.DESCRIPTION
  打包目标（子模块 -> HAR 模块）：
    modules\prism4cj      -> prism_hybrid.har
    modules\codeformat4cj -> codeformat_hybrid.har
    modules\markdown4cj   -> markdown_parser_hybrid.har
    modules\formula4cj    -> formula_hybrid.har

  每个子模块依次执行：ohpm install -> hvigorw assembleHar -> 复制 HAR。

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har.ps1
  # 打包全部 4 个模块

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har.ps1 -Only prism4cj,formula4cj
  # 只打包指定模块

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har.ps1 -Clean
  # 先清理旧构建产物再打包
#>

param(
    # 只打包指定的子模块（prism4cj / codeformat4cj / markdown4cj / formula4cj），为空则全部打包
    [string[]]$Only = @(),
    # 打包前删除各模块的旧 build 目录
    [switch]$Clean,
    # 构建模式
    [ValidateSet('debug', 'release')]
    [string]$BuildMode = 'release'
)

$ErrorActionPreference = 'Stop'

$ProjectRoot  = $PSScriptRoot
$HarOutputDir = Join-Path $ProjectRoot 'markdown_arkui\har'

# ---------------- 工具链路径（DevEco Studio 安装路径变化时在此修改） ----------------
$DevEcoTools = 'D:\DevecoStudio_6.1.1\DevEco Studio\tools'
$NodeHome    = Join-Path $DevEcoTools 'node'
$OhpmBin     = Join-Path $DevEcoTools 'ohpm\bin'
$Hvigorw     = Join-Path $DevEcoTools 'hvigor\bin\hvigorw.bat'

foreach ($tool in @((Join-Path $NodeHome 'node.exe'), (Join-Path $OhpmBin 'ohpm.bat'), $Hvigorw)) {
    if (-not (Test-Path $tool)) {
        Write-Host "找不到工具: $tool，请检查脚本顶部的 DevEcoTools 路径配置" -ForegroundColor Red
        exit 1
    }
}

# ---------------- 环境变量 ----------------
$env:NODE_HOME = $NodeHome
$env:PATH = "$NodeHome;$OhpmBin;$env:PATH"
if (-not $env:DEVECO_SDK_HOME) {
    $env:DEVECO_SDK_HOME = Join-Path (Split-Path $DevEcoTools) 'sdk'
}

# ---------------- 仓颉环境变量 ----------------
# cjpm.toml 中存在 Windows 宿主目标 [target.x86_64-w64-mingw32.bin-dependencies]，
# 引用 ${X86_64_LIBS} / ${X86_64_MACRO_LIBS} / ${X86_64_KIT_LIBS}。
# 兼容性 SDK 没有 x86_64-w64-mingw32 目录，这三个变量未设置时
# cjpm 会回退到不存在的默认路径导致 CompileCangjie 失败。
# 打 HAR 只编译 OHOS 目标，这里把它们指向 SDK 中真实存在的目录以通过校验。
$CangjieApiLib = 'D:\DevecoStudio_6.1.1\compatibility-sdk-windows-x64-6.1.1.280\compatibility\api\lib\linux_ohos_x86_64_cjnative'
if (Test-Path $CangjieApiLib) {
    $env:X86_64_LIBS       = Join-Path $CangjieApiLib 'ohos'
    $env:X86_64_MACRO_LIBS = Join-Path $CangjieApiLib 'c_wrapper_mock'
    $env:X86_64_KIT_LIBS   = Join-Path $CangjieApiLib 'kit'
    # AddApiDependencies 任务可能向 cjpm.toml 追加该变量，同样指向存在的目录
    $env:X86_64_WIN_TPC_MACRO_LIBS = 'D:\DevecoStudio_6.1.1\compatibility-sdk-windows-x64-6.1.1.280\compatibility\build-tools\third_party\llvm'
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
        & "$OhpmBin\ohpm.bat" install
        if ($LASTEXITCODE -ne 0) { throw "ohpm install 失败" }

        # 2. 打包 HAR（命令格式参照官方文档：
        #    hvigorw assembleHar --mode module -p product=default -p module=<ModuleName>@default -p buildMode=release --no-daemon）
        Write-Host ">>> hvigorw assembleHar ($moduleName, $BuildMode)"
        & $Hvigorw assembleHar --mode module -p product=default -p module="$moduleName@default" -p buildMode=$BuildMode --no-daemon
        if ($LASTEXITCODE -ne 0) { throw "hvigorw assembleHar 失败" }

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
Write-Host "========== 打包结果 ==========" -ForegroundColor Cyan
Write-Host ("成功: {0}" -f ($success -join ', ')) -ForegroundColor Green
if ($failed.Count -gt 0) {
    Write-Host ("失败: {0}" -f ($failed -join ', ')) -ForegroundColor Red
    exit 1
}
