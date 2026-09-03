<#
.SYNOPSIS
  Download submodule sources -> fix compatibleSdkVersion -> build submodule HARs -> build markdown_arkui module.

.DESCRIPTION
  Flow (in order):
    1. Download 4 submodules per .gitmodules (prism4cj / codeformat4cj / markdown4cj / formula4cj)
    2. Set compatibleSdkVersion to 5.0.3(15) in every build-profile.json5 (root project + all submodules)
    3. Build submodule HARs one by one and copy them into markdown_arkui\har:
         modules\prism4cj      -> prism_hybrid.har
         modules\codeformat4cj -> codeformat_hybrid.har
         modules\markdown4cj   -> markdown_parser_hybrid.har
         modules\formula4cj    -> formula_hybrid.har
    4. Build the markdown_arkui module of the root project (assembleHar)

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har_15.ps1
  # Full flow

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har_15.ps1 -Only prism4cj,formula4cj
  # Step 3 builds only the given modules (steps 1/2 still apply to all 4 submodules)

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har_15.ps1 -Clean
  # Delete each module's old build directory before building

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har_15.ps1 -SkipDownload
  # Skip step 1 (clean + re-download) when the submodules are already in place

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\build_har_15.ps1 -DevEcoTools 'C:\DevEco\tools' -CangjieSdkRoot 'C:\compat-sdk\compatibility'
  # Explicitly specify the DevEco Studio tools dir and compatibility SDK root
  # (otherwise: env vars -> sibling directories of the project root are auto-detected)
#>

param(
    # Only build the given submodules (prism4cj / codeformat4cj / markdown4cj / formula4cj); empty means all
    [string[]]$Only = @(),
    # Delete each module's old build directory before building
    [switch]$Clean,
    # Skip step 1 (clean + re-download of submodules); for fast rebuilds when sources are ready
    [switch]$SkipDownload,
    # Build mode
    [ValidateSet('debug', 'release')]
    [string]$BuildMode = 'release',
    # DevEco Studio tools directory (contains node/ohpm/hvigor).
    # If omitted, try in order: env var DEVECO_TOOLS_HOME -> directories named 'DevEco Studio*'
    # under ancestor dirs of the project root -> derived from env var DEVECO_SDK_HOME
    [string]$DevEcoTools = '',
    # Compatibility SDK root (the 'compatibility' directory containing build-tools/api).
    # If omitted, try in order: env var DEVECO_CANGJIE_PATH -> 'compatibility-sdk-*'
    # directories under ancestor dirs of the project root
    [string]$CangjieSdkRoot = ''
)

$ErrorActionPreference = 'Stop'

$ProjectRoot  = $PSScriptRoot
$HarOutputDir = Join-Path $ProjectRoot 'markdown_arkui\har'

# ---------------- Step 0: manual path setup (optional, interactive) ----------------
# When running in an interactive console, first give the user a chance to type
# the toolchain paths manually. Leaving the input blank skips the question and
# falls back to env vars + auto-detection below.
function Ask-ToolPath {
    param([string]$PromptText, [string]$MarkerPath, [string]$MarkerDesc)
    for ($i = 0; $i -lt 3; $i++) {
        $inputPath = Read-Host $PromptText
        if (-not $inputPath) { return '' }   # user skipped -> auto-detect later
        $inputPath = $inputPath.Trim().Trim('"').Trim("'")
        if (Test-Path (Join-Path $inputPath $MarkerPath)) { return $inputPath }
        Write-Host "  Invalid path ($MarkerDesc not found under it): $inputPath" -ForegroundColor Yellow
    }
    Write-Host '  Too many invalid inputs; falling back to auto-detection.' -ForegroundColor Yellow
    return ''
}

$isInteractive = [Environment]::UserInteractive -and ($Host.Name -eq 'ConsoleHost') -and (-not [Console]::IsInputRedirected)
if ($isInteractive) {
    Write-Host ''
    Write-Host '================ Toolchain path setup ================' -ForegroundColor Cyan
    Write-Host 'You can specify the install paths manually below.'
    Write-Host 'Leave blank and press Enter to let the script auto-detect them.'
    if (-not $DevEcoTools) {
        $DevEcoTools = Ask-ToolPath `
            -PromptText 'DevEco Studio tools dir (e.g. C:\Program Files\Huawei\DevEco Studio\tools)' `
            -MarkerPath 'hvigor\bin\hvigorw.bat' `
            -MarkerDesc 'hvigor\bin\hvigorw.bat'
    }
    if (-not $CangjieSdkRoot) {
        $CangjieSdkRoot = Ask-ToolPath `
            -PromptText 'Compatibility SDK root (the compatibility dir)' `
            -MarkerPath 'build-tools\tools\hvigor\cangjie-build-support' `
            -MarkerDesc 'build-tools\tools\hvigor\cangjie-build-support'
    }
}

# ---------------- Toolchain auto-detection (no hardcoded local paths) ----------------
# Priority: script parameters > env vars > common install layouts under ancestor directories
# (typical layout: the project, the DevEco Studio install dir and the compatibility SDK dir
#   share the same drive root, e.g. D:\DevecoStudio_Code_x.y.z\<project> and
#   D:\DevecoStudio_x.y.z\DevEco Studio)

# Collect directories used for searching:
#   - up to 5 ancestor levels above the project root
#   - common install locations (Program Files, LOCALAPPDATA\Programs, user profile)
#   - roots of all fixed drives (covers DevEco installed directly at a drive root)
function Get-SearchBases {
    param([string]$Root)
    $bases = @()
    $dir = Split-Path $Root
    for ($i = 0; $i -lt 5 -and $dir; $i++) {
        $bases += $dir
        $dir = Split-Path $dir
    }
    foreach ($p in @($env:ProgramFiles, ${env:ProgramFiles(x86)}, (Join-Path $env:LOCALAPPDATA 'Programs'), $env:USERPROFILE)) {
        if ($p -and (Test-Path $p)) { $bases += $p }
    }
    $bases += @(Get-PSDrive -PSProvider FileSystem -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -match '^[A-Za-z]$' } | Select-Object -ExpandProperty Root)
    return $bases | Select-Object -Unique
}

# Extract the version hint (e.g. 6.1.1) from the project root name so candidate paths
# whose name matches the version are preferred when multiple versions coexist.
$VersionHint = if ($ProjectRoot -match '(\d+\.\d+(?:\.\d+)?)') { $Matches[1] } else { '' }

function Sort-ByVersionHint {
    param([string[]]$Paths)
    if (-not $VersionHint) { return $Paths }
    return @($Paths | Sort-Object { $_ -like "*$VersionHint*" } -Descending)
}

# Detect the DevEco Studio tools directory
function Resolve-DevEcoTools {
    param([string]$Explicit)
    if ($Explicit -and (Test-Path (Join-Path $Explicit 'hvigor\bin\hvigorw.bat'))) { return $Explicit }

    # 1) env var DEVECO_TOOLS_HOME
    $fromEnv = $env:DEVECO_TOOLS_HOME
    if ($fromEnv -and (Test-Path (Join-Path $fromEnv 'hvigor\bin\hvigorw.bat'))) { return $fromEnv }

    # 2) derive from DEVECO_SDK_HOME (<install root>\sdk) -> <install root>\tools
    if ($env:DEVECO_SDK_HOME) {
        $guess = Join-Path (Split-Path $env:DEVECO_SDK_HOME) 'tools'
        if (Test-Path (Join-Path $guess 'hvigor\bin\hvigorw.bat')) { return $guess }
    }

    # 2.5) locate hvigorw(.bat) on PATH and derive the tools dir from it
    foreach ($cmdName in @('hvigorw.bat', 'hvigorw')) {
        $cmd = Get-Command $cmdName -ErrorAction SilentlyContinue
        if ($cmd -and $cmd.Path -and (Test-Path $cmd.Path)) {
            # <tools>\hvigor\bin\hvigorw.bat -> <tools>
            $guess = Split-Path (Split-Path (Split-Path $cmd.Path -Parent) -Parent) -Parent
            if (Test-Path (Join-Path $guess 'hvigor\bin\hvigorw.bat')) { return $guess }
        }
    }

    # 3) 'DevEco Studio*' install dirs inside each search base (or its 'DevEco*'/Huawei* dirs)
    foreach ($base in Get-SearchBases -Root $ProjectRoot) {
        $roots = Sort-ByVersionHint -Paths @(@($base) + @(Get-ChildItem $base -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like 'DevEco*' -or $_.Name -like 'Huawei*' } | Select-Object -ExpandProperty FullName))
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

# Detect the compatibility SDK 'compatibility' directory
function Resolve-CangjieSdkRoot {
    param([string]$Explicit)
    $marker = Join-Path 'build-tools\tools\hvigor\cangjie-build-support'
    if ($Explicit -and (Test-Path (Join-Path $Explicit $marker))) { return $Explicit }

    # 1) env var DEVECO_CANGJIE_PATH
    $fromEnv = $env:DEVECO_CANGJIE_PATH
    if ($fromEnv -and (Test-Path (Join-Path $fromEnv $marker))) { return $fromEnv }

    # 2) 'compatibility-sdk-*' dirs inside each search base (or its 'DevEco*'/Huawei* dirs)
    foreach ($base in Get-SearchBases -Root $ProjectRoot) {
        $roots = Sort-ByVersionHint -Paths @(@($base) + @(Get-ChildItem $base -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like 'DevEco*' -or $_.Name -like 'Huawei*' } | Select-Object -ExpandProperty FullName))
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
    throw 'DevEco Studio tools directory not found. Specify it via -DevEcoTools or DEVECO_TOOLS_HOME (the directory must contain hvigor\bin\hvigorw.bat).'
}
$CangjieSdkRoot = Resolve-CangjieSdkRoot -Explicit $CangjieSdkRoot
if (-not $CangjieSdkRoot) {
    throw 'Compatibility SDK (compatibility directory) not found. Specify it via -CangjieSdkRoot or DEVECO_CANGJIE_PATH (the directory must contain build-tools\tools\hvigor\cangjie-build-support).'
}
Write-Host "DevEco tools : $DevEcoTools"
Write-Host "Cangjie SDK  : $CangjieSdkRoot"

$NodeHome    = Join-Path $DevEcoTools 'node'
$OhpmBin     = Join-Path $DevEcoTools 'ohpm\bin'
$Hvigorw     = Join-Path $DevEcoTools 'hvigor\bin\hvigorw.bat'

foreach ($tool in @((Join-Path $NodeHome 'node.exe'), (Join-Path $OhpmBin 'ohpm.bat'), $Hvigorw)) {
    if (-not (Test-Path $tool)) {
        Write-Host "Tool not found: $tool. Check the DevEcoTools path (-DevEcoTools param / DEVECO_TOOLS_HOME env var)" -ForegroundColor Red
        exit 1
    }
}

# ---------------- Submodule list (matches .gitmodules) ----------------
$Submodules = @(
    @{ Name = 'prism4cj';      Path = 'modules/prism4cj' },
    @{ Name = 'codeformat4cj'; Path = 'modules/codeformat4cj' },
    @{ Name = 'markdown4cj';   Path = 'modules/markdown4cj' },
    @{ Name = 'formula4cj';    Path = 'modules/formula4cj' }
)

# Kill build processes (hvigorw/node.exe) left over from a previous run.
# Such processes hold handles on the submodule directories and break delete/clone.
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
        Write-Host ("Killed {0} stale build process(es)" -f @($stale).Count) -ForegroundColor DarkYellow
    }
}
Stop-StaleBuildProcesses

# ---------------- Step 1: download submodules from scratch per .gitmodules ----------------
# From-scratch flow (default): regardless of whether submodules already exist, remove
# the old directories and clone metadata first, then download fresh copies.
# This step is skipped ONLY when -SkipDownload is given (for fast rebuilds).
if ($SkipDownload) {
    Write-Host '>>> -SkipDownload given, skipping submodule clean + download' -ForegroundColor Yellow
}
else {
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'git command not found, cannot download submodules'
}

# git writes progress/warnings to stderr, and with $ErrorActionPreference = 'Stop'
# PS5.1 wraps native stderr into NativeCommandError and aborts the script.
# This wrapper temporarily switches to Continue, streams git output to the console
# (so real errors are visible), and decides success/failure by exit code only.
function Invoke-Git {
    param(
        [string[]]$GitArgs,
        [switch]$AllowFailure
    )
    $prevEap = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        & git @GitArgs 2>&1
    } finally {
        $ErrorActionPreference = $prevEap
    }
    if ($LASTEXITCODE -ne 0) {
        if ($AllowFailure) { return $false }
        Write-Host '----- common causes of the git failure above -----' -ForegroundColor DarkYellow
        Write-Host '  1. No network access to gitcode.com (check network / firewall / DNS)' -ForegroundColor DarkYellow
        Write-Host '  2. HTTP proxy required: git config --global http.proxy http://<proxy>:<port>' -ForegroundColor DarkYellow
        Write-Host '  3. Repository or branch unavailable (URL/branch in .gitmodules)' -ForegroundColor DarkYellow
        Write-Host '  4. Old git version (recommend git 2.20+): git --version' -ForegroundColor DarkYellow
        throw ("git {0} failed (exit code {1})" -f ($GitArgs -join ' '), $LASTEXITCODE)
    }
    return $true
}

# hvigorw / ohpm / curl write WARN lines and download progress to stderr, which
# $ErrorActionPreference='Stop' wraps into NativeCommandError and aborts the script
# even when the build succeeds. This wrapper temporarily switches to Continue,
# passes output through (into the log) and decides by exit code only.
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
        throw ("{0} failed (exit code {1})" -f (Split-Path $ToolPath -Leaf), $LASTEXITCODE)
    }
}

# Clear a directory's contents (with retries and a fallback):
# when files are briefly held by other processes, PowerShell's Remove-Item fails;
# retry a few rounds, then fall back to node's fs.rmSync (with maxRetries).
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
    # fs.rmSync supports retrying on locked files (Windows file locks)
    $env:DIR_TO_CLEAR = $Dir
    try {
        & (Join-Path $NodeHome 'node.exe') -e "const p=process.env.DIR_TO_CLEAR;const fs=require('fs');const items=fs.readdirSync(p);for(const it of items){fs.rmSync(p+'\\\\'+it,{recursive:true,force:true,maxRetries:5,retryDelay:1000})}"
    } finally {
        Remove-Item Env:DIR_TO_CLEAR -ErrorAction SilentlyContinue
    }
    $left = (Get-ChildItem $Dir -Force -ErrorAction SilentlyContinue | Measure-Object).Count
    if ($left -gt 0) {
        throw "Cannot clear directory ($left item(s) left, possibly locked by another program): $Dir"
    }
}

Push-Location $ProjectRoot
try {
    foreach ($sm in $Submodules) {
        $smDir = Join-Path $ProjectRoot $sm.Path
        if (Test-Path $smDir) {
            Write-Host "  Cleaning existing submodule: $($sm.Path)"
            # deinit removes the registration from .git/config
            Invoke-Git -GitArgs @('submodule', 'deinit', '-f', '--', $sm.Path) -AllowFailure | Out-Null
            try {
                Remove-Item $smDir -Recurse -Force -ErrorAction Stop
            }
            catch {
                # When the directory itself is locked by another process (e.g. the IDE),
                # it cannot be removed; clear its contents instead. git reuses the empty
                # directory when cloning again, with the same effect.
                Write-Host "  Directory is locked, clearing its contents instead: $smDir" -ForegroundColor DarkYellow
                Clear-DirectoryContent -Dir $smDir
            }
        }
        # Remove the clone metadata under .git\modules so the next step performs a
        # fresh clone from the network (true from-scratch)
        $gitModulesDir = Join-Path $ProjectRoot (".git\modules\" + ($sm.Path -replace '/', '\'))
        if (Test-Path $gitModulesDir) {
            Remove-Item $gitModulesDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }

    Write-Host ''
    Write-Host '>>> Downloading submodules one by one (shallow clone, branches declared in .gitmodules)...'
    # .gitmodules already declares shallow = true; update --init registers, clones and
    # checks out the commit recorded by the main repository. Download module by module
    # so a failure points exactly at the problematic repo, and retry with a full clone
    # when the shallow clone fails (some servers reject depth=1 requests).
    foreach ($sm in $Submodules) {
        Write-Host "  --- $($sm.Path) ---"
        Invoke-Git -GitArgs @('submodule', 'sync', '--', $sm.Path) -AllowFailure | Out-Null
        $ok = Invoke-Git -GitArgs @('submodule', 'update', '--init', '--depth', '1', '--', $sm.Path) -AllowFailure
        if (-not $ok) {
            Write-Host "  Shallow clone failed, retrying with a full clone: $($sm.Path)" -ForegroundColor Yellow
            # remove leftover shallow clone metadata before the full-clone retry
            $smGitMeta = Join-Path $ProjectRoot (".git\modules\" + ($sm.Path -replace '/', '\'))
            Remove-Item $smGitMeta -Recurse -Force -ErrorAction SilentlyContinue
            Invoke-Git -GitArgs @('submodule', 'update', '--init', '--', $sm.Path)
        }
    }
    Write-Host '>>> Submodules downloaded'
}
finally {
    Pop-Location
}
}

# ---------------- Step 2: unify compatibleSdkVersion to 5.0.3(15) ----------------
# Covers the root project (app.products in the root build-profile.json5) and all 4 submodules
$TargetSdkCompat = '5.0.3(15)'
$profiles = Get-ChildItem $ProjectRoot -Recurse -Filter 'build-profile.json5' -File -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch '\\(oh_modules|build|node_modules|\.git|\.hvigor_home)\\' }
foreach ($pf in $profiles) {
    $text = [System.IO.File]::ReadAllText($pf.FullName)
    if ($text -match '"compatibleSdkVersion"\s*:\s*"[^"]*"') {
        $newText = $text -replace '"compatibleSdkVersion"\s*:\s*"[^"]*"', ('"compatibleSdkVersion": "{0}"' -f $TargetSdkCompat)
        if ($newText -ne $text) {
            [System.IO.File]::WriteAllText($pf.FullName, $newText)
            Write-Host ("  compatibleSdkVersion set to {0}: {1}" -f $TargetSdkCompat, $pf.FullName.Substring($ProjectRoot.Length + 1))
        }
    }
}

# ---------------- Environment variables ----------------
$env:NODE_HOME = $NodeHome
$env:PATH = "$NodeHome;$OhpmBin;$env:PATH"
# Force overwrite: a stale wrong value (e.g. pointing at sdk\default) makes hvigor fail
# to scan the toolchains/ets/js/native/previewer components and report 00303168
# SDK component missing
$env:DEVECO_SDK_HOME = Join-Path (Split-Path $DevEcoTools) 'sdk'

# Redirect the hvigor user home into the project directory (default ~/.hvigor).
# hvigorw locates its user cache via the HVIGOR_USER_HOME env var, and the build
# workspace (project_caches\<hash>\workspace) also lives under it; after the
# redirect, creating the cangjie-build-support symlink no longer fails on
# permissions in restricted environments.
$env:HVIGOR_USER_HOME = Join-Path $ProjectRoot '.hvigor_home'

# The first hvigorw run installs pnpm; if the npm cache points at a non-writable
# directory (e.g. the global D:\nodejs\node_cache) it fails on permissions,
# so redirect it into the project directory.
$env:npm_config_cache = Join-Path $ProjectRoot '.npm_cache'

# ---------------- Cangjie environment variables ----------------
# Locating the Cangjie build plugin: hvigorw links
# <DEVECO_CANGJIE_PATH>\build-tools\tools\hvigor\cangjie-build-support into the build
# workspace's node_modules\@ohos; hvigor-ohos-plugin requires it at runtime to inject
# the cangjieOptions schema and register Cangjie build tasks (CangjiePreBuild /
# CompileCangjie / etc.). Without this variable, command-line builds fail because
# cangjieOptions in build-profile.json5 cannot pass schema validation
# (IDE builds work because DevEco injects it automatically).
$env:DEVECO_CANGJIE_PATH = $CangjieSdkRoot

# ---------------- Cangjie build plugin copy (bypass symlink restriction) ----------------
# hvigorw links cangjie-build-support into the build workspace's node_modules\@ohos
# and validates it: the link target must match and package.json version must equal
# hvigorw's own version (6.24.2), otherwise it deletes and re-creates the link.
# Re-creating symlinks fails with EPERM in restricted environments.
# Countermeasure: copy the plugin into the project, set its version to match hvigor,
# point CANGJIE_BUILD_SUPPORT_PATH at the copy (this variable has the highest
# priority) and pre-create the junctions; hvigorw then validates and skips them.
$HvigorVersion = (Get-Content (Join-Path $DevEcoTools 'hvigor\hvigor\package.json') -Raw | ConvertFrom-Json).version
$PluginSrc  = Join-Path $env:DEVECO_CANGJIE_PATH 'build-tools\tools\hvigor\cangjie-build-support'
$PluginCopy = Join-Path $ProjectRoot '.hvigor_home\cangjie-build-support'
if (-not (Test-Path (Join-Path $PluginCopy 'package.json'))) {
    Copy-Item $PluginSrc $PluginCopy -Recurse -Force
}
$PluginPkgPath = Join-Path $PluginCopy 'package.json'
$PluginPkg = Get-Content $PluginPkgPath -Raw
$PluginPkg = $PluginPkg -replace '"version"\s*:\s*"[^"]*"', ('"version": "{0}"' -f $HvigorVersion)
# Write BOM-less UTF-8 via .NET API (Set-Content -Encoding UTF8 writes a BOM on PS5.1,
# and the BOM breaks hvigor's ParseJsonFile (JSON.parse))
[System.IO.File]::WriteAllText($PluginPkgPath, $PluginPkg)
$env:CANGJIE_BUILD_SUPPORT_PATH = $PluginCopy

# Pre-create (or fix) the cangjie-build-support junction in every existing build workspace
function Set-CangjieLink {
    $workspaces = Get-ChildItem (Join-Path $env:HVIGOR_USER_HOME 'project_caches') -Directory -ErrorAction SilentlyContinue
    foreach ($w in $workspaces) {
        $ohosDir = Join-Path $w.FullName 'workspace\node_modules\@ohos'
        if (-not (Test-Path $ohosDir)) { continue }
        $link = Join-Path $ohosDir 'cangjie-build-support'
        $item = Get-Item $link -Force -ErrorAction SilentlyContinue
        # The Target returned by Get-Item has a trailing backslash; trim it before comparing
        $curTarget = if ($item) { "$($item.Target | Select-Object -First 1)".TrimEnd('\') } else { $null }
        if ($item -and ($item.LinkType -ne 'Junction' -or $curTarget -ne $PluginCopy)) {
            # Remove only the junction itself: .NET Directory.Delete follows the link into the
            # target directory and gets blocked, while node's fs.rmSync removes the link
            # itself without following it. Note: extra args appended to `node -e` do not
            # land in process.argv, so the value must be passed via env var.
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

# cjpm.toml contains the Windows host target [target.x86_64-w64-mingw32.bin-dependencies],
# which references ${X86_64_LIBS} / ${X86_64_MACRO_LIBS} / ${X86_64_KIT_LIBS}.
# The compatibility SDK has no x86_64-w64-mingw32 directory; when these variables are
# unset, cjpm falls back to non-existent default paths and CompileCangjie fails.
# HAR builds compile the OHOS target only, so point them at directories that actually
# exist in the SDK to pass validation.
$CangjieApiLib = Join-Path $CangjieSdkRoot 'api\lib\linux_ohos_x86_64_cjnative'
if (Test-Path $CangjieApiLib) {
    $env:X86_64_LIBS       = Join-Path $CangjieApiLib 'ohos'
    $env:X86_64_MACRO_LIBS = Join-Path $CangjieApiLib 'c_wrapper_mock'
    $env:X86_64_KIT_LIBS   = Join-Path $CangjieApiLib 'kit'
    # The AddApiDependencies task may append this variable to cjpm.toml; point it at
    # an existing directory too
    $llvmDir = Join-Path $CangjieSdkRoot 'build-tools\third_party\llvm'
    if (Test-Path $llvmDir) {
        $env:X86_64_WIN_TPC_MACRO_LIBS = $llvmDir
    }
}

# ---------------- Build targets ----------------
$BuildTargets = @(
    @{ Submodule = 'prism4cj';      Module = 'prism_hybrid' },
    @{ Submodule = 'codeformat4cj'; Module = 'codeformat_hybrid' },
    @{ Submodule = 'markdown4cj';   Module = 'markdown_parser_hybrid' },
    @{ Submodule = 'formula4cj';    Module = 'formula_hybrid' }
)

if ($Only.Count -gt 0) {
    $BuildTargets = @($BuildTargets | Where-Object { $Only -contains $_.Submodule })
    if ($BuildTargets.Count -eq 0) {
        Write-Host "-Only values are all invalid; allowed values: prism4cj, codeformat4cj, markdown4cj, formula4cj" -ForegroundColor Red
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
    Write-Host "========== Building $submodule -> $moduleName.har ==========" -ForegroundColor Cyan

    if (-not (Test-Path $subDir)) {
        Write-Host "Submodule directory not found: $subDir (run git submodule update --init first)" -ForegroundColor Red
        $failed += $moduleName
        continue
    }

    Push-Location $subDir
    try {
        # Clean old artifacts
        if ($Clean) {
            $buildDir = Join-Path $subDir "$moduleName\build"
            if (Test-Path $buildDir) {
                Write-Host "Cleaning $moduleName\build ..."
                Remove-Item $buildDir -Recurse -Force
            }
        }

        # 1. Install dependencies
        Write-Host ">>> ohpm install"
        Invoke-NativeTool -ToolPath "$OhpmBin\ohpm.bat" -ToolArgs @('install')

        # 2. Build the HAR (command form from the official docs:
        #    hvigorw assembleHar --mode module -p product=default -p module=<ModuleName>@default -p buildMode=release --no-daemon)
        Write-Host ">>> hvigorw assembleHar ($moduleName, $BuildMode)"
        Invoke-NativeTool -ToolPath $Hvigorw -ToolArgs @('assembleHar', '--mode', 'module', '-p', 'product=default', '-p', "module=$moduleName@default", '-p', "buildMode=$BuildMode", '--no-daemon')

        # 3. Copy the HAR into the root project
        $harFile = Join-Path $subDir "$moduleName\build\default\outputs\default\$moduleName.har"
        if (-not (Test-Path $harFile)) { throw "Build artifact not found: $harFile" }
        Copy-Item $harFile $HarOutputDir -Force
        Write-Host "Copied: $moduleName.har -> $HarOutputDir" -ForegroundColor Green
        $success += $moduleName
    }
    catch {
        Write-Host "Failed to build $submodule : $($_.Exception.Message)" -ForegroundColor Red
        $failed += $moduleName
    }
    finally {
        Pop-Location
    }
}

Write-Host ''
Write-Host "========== Submodule build results ==========" -ForegroundColor Cyan
Write-Host ("Succeeded: {0}" -f ($success -join ', ')) -ForegroundColor Green
if ($failed.Count -gt 0) {
    Write-Host ("Failed: {0}" -f ($failed -join ', ')) -ForegroundColor Red
    exit 1
}

# ---------------- Step 4: build the root project markdown_arkui module ----------------
# markdown_arkui depends on the 4 HARs copied into markdown_arkui\har in step 3
# (see dependencies in markdown_arkui\oh-package.json5).
Write-Host ''
Write-Host '========== Building markdown_arkui module ==========' -ForegroundColor Cyan
Push-Location $ProjectRoot
try {
    # Install root project dependencies (creates oh_modules and links the local HARs)
    Write-Host '>>> ohpm install (root project)'
    Invoke-NativeTool -ToolPath "$OhpmBin\ohpm.bat" -ToolArgs @('install')

    Write-Host ">>> hvigorw assembleHar (markdown_arkui, $BuildMode)"
    Invoke-NativeTool -ToolPath $Hvigorw -ToolArgs @('assembleHar', '--mode', 'module', '-p', 'product=default', '-p', 'module=markdown_arkui@default', '-p', "buildMode=$BuildMode", '--no-daemon')

    $rootHar = Join-Path $ProjectRoot 'markdown_arkui\build\default\outputs\default\markdown_arkui.har'
    if (Test-Path $rootHar) {
        Write-Host "markdown_arkui.har generated: $rootHar" -ForegroundColor Green
    } else {
        throw 'Build finished but artifact not found: markdown_arkui.har'
    }
}
catch {
    Write-Host "Failed to build markdown_arkui: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
finally {
    Pop-Location
}

# ---------------- Clean up temporary cache directories created by the build ----------------
# When the hvigor user-dir cache is not writable, hvigor degrades its cache into
# .hvigor_local under the project root; remove it after each build so nothing is
# left behind in the project.
$HvigorLocalCache = Join-Path $ProjectRoot '.hvigor_local'
if (Test-Path $HvigorLocalCache) {
    Remove-Item $HvigorLocalCache -Recurse -Force -ErrorAction SilentlyContinue
    if (-not (Test-Path $HvigorLocalCache)) {
        Write-Host "Removed temporary cache directory .hvigor_local" -ForegroundColor DarkGray
    }
}

Write-Host ''
Write-Host '========== All done ==========' -ForegroundColor Green
