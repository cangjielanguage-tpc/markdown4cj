#!/usr/bin/env bash
# =============================================================================
# build_har_20.sh —— Linux / macOS 版本（对应 Windows 的 build_har_20.ps1）
# （兼容 API 20 版本：不修改子模块的 compatibleSdkVersion，保持仓库默认值 6.0.0(20)）
#
# 流程（按顺序）：
#   1. 依据 .gitmodules 下载 4 个子模块（prism4cj / codeformat4cj / markdown4cj / formula4cj）
#   2. 依次打包子模块 HAR 并复制到根项目 markdown_arkui/har 目录：
#        modules/prism4cj      -> prism_hybrid.har
#        modules/codeformat4cj -> codeformat_hybrid.har
#        modules/markdown4cj   -> markdown_parser_hybrid.har
#        modules/formula4cj    -> formula_hybrid.har
#   3. 在根项目编译 markdown_arkui 模块（assembleHar）
#
# 用法：
#   bash build_har_20.sh                                # 完整流程
#   bash build_har_20.sh --only prism4cj,formula4cj     # 第 2 步只打包指定模块
#   bash build_har_20.sh --clean                        # 打包前删除各模块的旧 build 目录
#   bash build_har_20.sh --skip-download                # 子模块已就绪时跳过清理与下载
#   bash build_har_20.sh --build-mode debug             # 构建模式（默认 release）
#   bash build_har_20.sh --deveco-tools /opt/deveco/tools \
#                        --cangjie-sdk-root /opt/compat-sdk/compatibility
#       # 显式指定工具链路径（不指定时按 环境变量 -> 祖先目录 自动探测）
# =============================================================================

set -euo pipefail

info() { printf '\033[1;36m%s\033[0m\n' "$*"; }
ok()   { printf '\033[1;32m%s\033[0m\n' "$*"; }
warn() { printf '\033[0;33m%s\033[0m\n' "$*"; }
err()  { printf '\033[1;31m%s\033[0m\n' "$*" >&2; }
fail() { err "$*"; exit 1; }

usage() {
    cat <<'EOF'
用法: bash build_har_20.sh [选项]
  --only <列表>            只打包指定子模块（逗号分隔: prism4cj,codeformat4cj,markdown4cj,formula4cj）
  --clean                  打包前删除各模块的旧 build 目录
  --skip-download          跳过步骤1（清理并重新下载子模块）
  --build-mode <mode>      构建模式: debug | release（默认 release）
  --deveco-tools <dir>     DevEco Studio 的 tools 目录（含 node/ohpm/hvigor）
  --cangjie-sdk-root <dir> 兼容性 SDK 的 compatibility 根目录（含 build-tools/api）
  -h, --help               显示本帮助
EOF
}

# ---------------- 参数解析 ----------------
ONLY=()
CLEAN=0
SKIP_DOWNLOAD=0
BUILD_MODE='release'
ARG_DEVECO_TOOLS=''
ARG_CANGJIE_SDK_ROOT=''

while [ $# -gt 0 ]; do
    case "$1" in
        --only)             shift; [ $# -gt 0 ] || fail '--only 需要参数'; IFS=',' read -r -a ONLY <<< "$1" ;;
        --clean)            CLEAN=1 ;;
        --skip-download)    SKIP_DOWNLOAD=1 ;;
        --build-mode)       shift; [ $# -gt 0 ] || fail '--build-mode 需要参数'; BUILD_MODE="$1" ;;
        --deveco-tools)     shift; [ $# -gt 0 ] || fail '--deveco-tools 需要参数'; ARG_DEVECO_TOOLS="$1" ;;
        --cangjie-sdk-root) shift; [ $# -gt 0 ] || fail '--cangjie-sdk-root 需要参数'; ARG_CANGJIE_SDK_ROOT="$1" ;;
        -h|--help)          usage; exit 0 ;;
        *)                  fail "未知参数: $1（--help 查看用法）" ;;
    esac
    shift
done

case "$BUILD_MODE" in
    debug|release) ;;
    *) fail "--build-mode 只支持 debug / release，当前: $BUILD_MODE" ;;
esac

PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"
HAR_OUTPUT_DIR="$PROJECT_ROOT/markdown_arkui/har"

# ---------------- 工具链路径自动探测（不写死本地路径） ----------------
# 优先级：脚本参数 > 环境变量 > 项目根各级祖先目录中的常见安装布局

# 提取项目根名称中的版本号（如 6.1.1），用于候选路径排序——
# 同名版本号的安装目录优先，避免多版本共存时误选旧版本工具链。
VERSION_HINT="$(printf '%s' "$PROJECT_ROOT" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -n 1 || true)"

# 含版本号的候选排前面，其余保持原顺序
sort_hint() {
    local all matched rest
    all="$(cat)"
    if [ -z "$VERSION_HINT" ]; then printf '%s\n' "$all"; return; fi
    matched="$(printf '%s\n' "$all" | grep -F "$VERSION_HINT" || true)"
    rest="$(printf '%s\n' "$all" | grep -vF "$VERSION_HINT" || true)"
    [ -n "$matched" ] && printf '%s\n' "$matched"
    [ -n "$rest" ] && printf '%s\n' "$rest"
    return 0
}

# 项目根向上最多 3 级祖先目录
get_search_bases() {
    local dir i parent
    dir="$(dirname "$PROJECT_ROOT")"
    i=0
    while [ $i -lt 3 ] && [ -n "$dir" ] && [ "$dir" != "/" ]; do
        printf '%s\n' "$dir"
        parent="$(dirname "$dir")"
        [ "$parent" = "$dir" ] && break
        dir="$parent"
        i=$((i + 1))
    done
}

# 探测 DevEco Studio 的 tools 目录
resolve_deveco_tools() {
    local explicit="$1"
    local marker='hvigor/bin/hvigorw'
    if [ -n "$explicit" ] && [ -f "$explicit/$marker" ]; then printf '%s' "$explicit"; return 0; fi

    # 1) 环境变量 DEVECO_TOOLS_HOME
    if [ -n "${DEVECO_TOOLS_HOME:-}" ] && [ -f "$DEVECO_TOOLS_HOME/$marker" ]; then
        printf '%s' "$DEVECO_TOOLS_HOME"; return 0
    fi

    # 2) 由 DEVECO_SDK_HOME（<安装根>/sdk）推导：<安装根>/tools
    if [ -n "${DEVECO_SDK_HOME:-}" ]; then
        local guess; guess="$(dirname "$DEVECO_SDK_HOME")/tools"
        if [ -f "$guess/$marker" ]; then printf '%s' "$guess"; return 0; fi
    fi

    # 3) 祖先目录自身或其下 'DevEco*' 目录中的 'DevEco Studio*' 安装目录
    local base r s roots studios
    for base in $(get_search_bases); do
        roots="$( { printf '%s\n' "$base"; find "$base" -maxdepth 1 -mindepth 1 -type d -name 'DevEco*' 2>/dev/null; } | sort_hint )"
        while IFS= read -r r; do
            [ -n "$r" ] || continue
            [ -d "$r" ] || continue
            studios="$(find "$r" -maxdepth 1 -mindepth 1 -type d -name 'DevEco Studio*' 2>/dev/null | sort_hint)"
            while IFS= read -r s; do
                [ -n "$s" ] || continue
                if [ -f "$s/tools/$marker" ]; then printf '%s' "$s/tools"; return 0; fi
            done <<< "$studios"
        done <<< "$roots"
    done
    return 1
}

# 探测兼容性 SDK 的 compatibility 目录
resolve_cangjie_sdk_root() {
    local explicit="$1"
    local marker='build-tools/tools/hvigor/cangjie-build-support'
    if [ -n "$explicit" ] && [ -d "$explicit/$marker" ]; then printf '%s' "$explicit"; return 0; fi

    # 1) 环境变量 DEVECO_CANGJIE_PATH
    if [ -n "${DEVECO_CANGJIE_PATH:-}" ] && [ -d "$DEVECO_CANGJIE_PATH/$marker" ]; then
        printf '%s' "$DEVECO_CANGJIE_PATH"; return 0
    fi

    # 2) 祖先目录自身或其下 'DevEco*' 目录中的 'compatibility-sdk-*' 目录
    local base r sdk_dir roots sdks
    for base in $(get_search_bases); do
        roots="$( { printf '%s\n' "$base"; find "$base" -maxdepth 1 -mindepth 1 -type d -name 'DevEco*' 2>/dev/null; } | sort_hint )"
        while IFS= read -r r; do
            [ -n "$r" ] || continue
            [ -d "$r" ] || continue
            sdks="$(find "$r" -maxdepth 1 -mindepth 1 -type d -name 'compatibility-sdk-*' 2>/dev/null | sort_hint)"
            while IFS= read -r sdk_dir; do
                [ -n "$sdk_dir" ] || continue
                if [ -d "$sdk_dir/compatibility/$marker" ]; then printf '%s' "$sdk_dir/compatibility"; return 0; fi
            done <<< "$sdks"
        done <<< "$roots"
    done
    return 1
}

DEVECO_TOOLS="$(resolve_deveco_tools "$ARG_DEVECO_TOOLS")" \
    || fail '未找到 DevEco Studio tools 目录。请通过 --deveco-tools 参数或 DEVECO_TOOLS_HOME 环境变量指定（目录内应含 hvigor/bin/hvigorw）。'
CANGJIE_SDK_ROOT="$(resolve_cangjie_sdk_root "$ARG_CANGJIE_SDK_ROOT")" \
    || fail '未找到兼容性 SDK（compatibility 目录）。请通过 --cangjie-sdk-root 参数或 DEVECO_CANGJIE_PATH 环境变量指定（目录内应含 build-tools/tools/hvigor/cangjie-build-support）。'

echo "DevEco tools : $DEVECO_TOOLS"
echo "Cangjie SDK  : $CANGJIE_SDK_ROOT"

NODE_HOME="$DEVECO_TOOLS/node"
NODE_BIN="$NODE_HOME/bin/node"
OHPM="$DEVECO_TOOLS/ohpm/bin/ohpm"
HVIGORW="$DEVECO_TOOLS/hvigor/bin/hvigorw"

for tool in "$NODE_BIN" "$OHPM" "$HVIGORW"; do
    [ -f "$tool" ] || fail "找不到工具: $tool，请检查工具链路径（--deveco-tools 参数 / DEVECO_TOOLS_HOME 环境变量）"
    [ -x "$tool" ] || chmod +x "$tool" 2>/dev/null || true
done
command -v perl >/dev/null 2>&1 || fail '未找到 perl 命令（修改 json5/package.json 需要）'
command -v git  >/dev/null 2>&1 || fail '未找到 git 命令，无法下载子模块'

# ---------------- 子模块清单（与 .gitmodules 对应） ----------------
SUBMODULES=(prism4cj codeformat4cj markdown4cj formula4cj)

# 子模块 -> 打包模块名
module_of() {
    case "$1" in
        prism4cj)      echo 'prism_hybrid' ;;
        codeformat4cj) echo 'codeformat_hybrid' ;;
        markdown4cj)   echo 'markdown_parser_hybrid' ;;
        formula4cj)    echo 'formula_hybrid' ;;
        *) return 1 ;;
    esac
}

# 清理上一轮可能残留的构建进程（hvigorw/ohpm 等），避免占用文件
stop_stale_build_processes() {
    command -v pgrep >/dev/null 2>&1 || return 0
    local pids pid n=0
    pids="$(pgrep -f 'hvigor/bin/hvigorw|cangjie-build-support' 2>/dev/null || true)"
    for pid in $pids; do
        [ "$pid" = "$$" ] && continue
        kill -9 "$pid" 2>/dev/null || true
        n=$((n + 1))
    done
    [ $n -gt 0 ] && warn "已清理 $n 个遗留构建进程"
    return 0
}
stop_stale_build_processes

# ---------------- 步骤1：从零依据 .gitmodules 下载子模块 ----------------
# 从零流程（默认）：无论子模块是否已存在，先删除旧目录与克隆元数据，再全新下载。
# 仅当显式传入 --skip-download 时才跳过本步骤（用于子模块已就绪的快速打包）。
if [ "$SKIP_DOWNLOAD" = 1 ]; then
    warn '>>> --skip-download 已指定，跳过子模块清理与下载'
else
    for sm in "${SUBMODULES[@]}"; do
        sm_dir="$PROJECT_ROOT/modules/$sm"
        if [ -d "$sm_dir" ]; then
            echo "  清理已有子模块: modules/$sm"
            # deinit 清除 .git/config 中的注册项（未注册时忽略失败）
            git -C "$PROJECT_ROOT" submodule deinit -f -- "modules/$sm" >/dev/null 2>&1 || true
            rm -rf "$sm_dir"
        fi
        # 删除 .git/modules 下的克隆元数据，确保下一步从网络全新克隆（真正的从零）
        git_meta="$PROJECT_ROOT/.git/modules/modules/$sm"
        [ -d "$git_meta" ] && rm -rf "$git_meta"
    done

    echo ''
    echo '>>> 下载子模块（浅克隆，按 .gitmodules 中声明的分支）...'
    sm_paths=()
    for sm in "${SUBMODULES[@]}"; do sm_paths+=("modules/$sm"); done
    # .gitmodules 已声明 shallow = true；update --init 完成注册、克隆并检出主仓库记录的提交
    git -C "$PROJECT_ROOT" submodule update --init --depth 1 "${sm_paths[@]}" \
        || fail 'git submodule update 失败，请检查网络或仓库访问权限'
    echo '>>> 子模块下载完成'
fi

# ---------------- 环境变量 ----------------
export NODE_HOME
export PATH="$NODE_HOME/bin:$DEVECO_TOOLS/ohpm/bin:$PATH"
# 强制覆盖：残留的错误值（如指向 sdk/default）会导致 hvigor 扫描不到
# toolchains/ets/js/native/previewer 组件，报 00303168 SDK component missing
export DEVECO_SDK_HOME="$(dirname "$DEVECO_TOOLS")/sdk"

# hvigor 用户目录重定向到项目目录内（默认 ~/.hvigor），
# 受限环境下避免写用户目录失败。
export HVIGOR_USER_HOME="$PROJECT_ROOT/.hvigor_home"

# hvigorw 首跑会安装 pnpm，npm 缓存重定向到项目目录内，避免全局缓存权限问题。
export npm_config_cache="$PROJECT_ROOT/.npm_cache"

# ---------------- 仓颉环境变量 ----------------
# 仓颉构建插件定位：hvigorw 依据 DEVECO_CANGJIE_PATH 将
# <该路径>/build-tools/tools/hvigor/cangjie-build-support 链接进构建工作区的
# node_modules/@ohos。不设置该变量时命令行打包会因 build-profile.json5 中
# cangjieOptions 无法通过 schema 校验而失败（IDE 构建时由 DevEco 自动注入）。
export DEVECO_CANGJIE_PATH="$CANGJIE_SDK_ROOT"

# ---------------- 仓颉构建插件副本（绕过符号链接版本校验） ----------------
# hvigorw 会把 cangjie-build-support 以符号链接挂到构建工作区 node_modules/@ohos，
# 并校验：链接目标一致且 package.json 版本 == hvigorw 自身版本，否则删除重建。
# 对策：将插件复制到项目内并把版本号改成与 hvigor 一致，
# 用 CANGJIE_BUILD_SUPPORT_PATH 指向副本（该变量优先级最高），再预建符号链接；
# hvigorw 校验通过后直接跳过，不再重建链接。
HVIGOR_VERSION="$("$NODE_BIN" -e 'console.log(require(process.argv[1]).version)' "$DEVECO_TOOLS/hvigor/hvigor/package.json")"
PLUGIN_SRC="$DEVECO_CANGJIE_PATH/build-tools/tools/hvigor/cangjie-build-support"
PLUGIN_COPY="$PROJECT_ROOT/.hvigor_home/cangjie-build-support"
if [ ! -f "$PLUGIN_COPY/package.json" ]; then
    rm -rf "$PLUGIN_COPY"
    mkdir -p "$PROJECT_ROOT/.hvigor_home"
    cp -R "$PLUGIN_SRC" "$PLUGIN_COPY"
fi
perl -i -pe "s/\"version\"\\s*:\\s*\"[^\"]*\"/\"version\": \"$HVIGOR_VERSION\"/" "$PLUGIN_COPY/package.json"
export CANGJIE_BUILD_SUPPORT_PATH="$PLUGIN_COPY"

# 在所有已生成的构建工作区中预建（或纠正）cangjie-build-support 符号链接
setup_cangjie_links() {
    local ws link cur
    for ws in "$HVIGOR_USER_HOME"/project_caches/*/workspace/node_modules/@ohos; do
        [ -d "$ws" ] || continue
        link="$ws/cangjie-build-support"
        if [ -e "$link" ] || [ -L "$link" ]; then
            cur="$(readlink "$link" 2>/dev/null || true)"
            if [ "$cur" = "$PLUGIN_COPY" ]; then continue; fi
            rm -rf "$link"
        fi
        ln -s "$PLUGIN_COPY" "$link"
    done
}
setup_cangjie_links

# cjpm.toml 中存在宿主目标 [target.x86_64-w64-mingw32.bin-dependencies]，
# 引用 ${X86_64_LIBS} / ${X86_64_MACRO_LIBS} / ${X86_64_KIT_LIBS}。
# 兼容性 SDK 没有 x86_64-w64-mingw32 目录，这三个变量未设置时
# cjpm 会回退到不存在的默认路径导致 CompileCangjie 失败。
# 打 HAR 只编译 OHOS 目标，这里把它们指向 SDK 中真实存在的目录以通过校验。
CANGJIE_API_LIB="$CANGJIE_SDK_ROOT/api/lib/linux_ohos_x86_64_cjnative"
if [ -d "$CANGJIE_API_LIB" ]; then
    export X86_64_LIBS="$CANGJIE_API_LIB/ohos"
    export X86_64_MACRO_LIBS="$CANGJIE_API_LIB/c_wrapper_mock"
    export X86_64_KIT_LIBS="$CANGJIE_API_LIB/kit"
    # AddApiDependencies 任务可能向 cjpm.toml 追加该变量，同样指向存在的目录
    llvm_dir="$CANGJIE_SDK_ROOT/build-tools/third_party/llvm"
    [ -d "$llvm_dir" ] && export X86_64_WIN_TPC_MACRO_LIBS="$llvm_dir"
fi

# ---------------- 打包目标 ----------------
BUILD_SUBMODULES=("${SUBMODULES[@]}")
if [ ${#ONLY[@]} -gt 0 ]; then
    BUILD_SUBMODULES=()
    for o in "${ONLY[@]}"; do
        if module_of "$o" >/dev/null; then
            BUILD_SUBMODULES+=("$o")
        else
            fail "--only 指定的模块无效: $o，可选值: prism4cj, codeformat4cj, markdown4cj, formula4cj"
        fi
    done
    [ ${#BUILD_SUBMODULES[@]} -gt 0 ] || fail '--only 未指定任何有效模块'
fi

mkdir -p "$HAR_OUTPUT_DIR"

SUCCESS=()
FAILED=()

# 单个子模块的打包过程（在子 shell 中运行，失败不影响后续模块）
build_one() {
    local sm="$1" module="$2" sub_dir="$3"
    cd "$sub_dir"

    # 清理旧产物
    if [ "$CLEAN" = 1 ] && [ -d "$module/build" ]; then
        echo "清理 $module/build ..."
        rm -rf "$module/build"
    fi

    # 1. 安装依赖
    echo '>>> ohpm install'
    "$OHPM" install

    # 2. 打包 HAR（命令格式参照官方文档：
    #    hvigorw assembleHar --mode module -p product=default -p module=<ModuleName>@default -p buildMode=release --no-daemon）
    echo ">>> hvigorw assembleHar ($module, $BUILD_MODE)"
    "$HVIGORW" assembleHar --mode module -p product=default -p "module=$module@default" -p "buildMode=$BUILD_MODE" --no-daemon

    # 3. 复制 HAR 到根项目
    local har_file="$module/build/default/outputs/default/$module.har"
    [ -f "$har_file" ] || fail "未找到构建产物: $har_file"
    cp -f "$har_file" "$HAR_OUTPUT_DIR/"
    ok "已复制: $module.har -> $HAR_OUTPUT_DIR"
}

for sm in "${BUILD_SUBMODULES[@]}"; do
    module="$(module_of "$sm")"
    sub_dir="$PROJECT_ROOT/modules/$sm"

    echo ''
    info "========== 打包 $sm -> $module.har =========="

    if [ ! -d "$sub_dir" ]; then
        err "子模块目录不存在: $sub_dir（请先执行 git submodule update --init）"
        FAILED+=("$module")
        continue
    fi

    if ( build_one "$sm" "$module" "$sub_dir" ); then
        SUCCESS+=("$module")
    else
        err "打包 $sm 失败"
        FAILED+=("$module")
    fi
done

echo ''
info '========== 子模块打包结果 =========='
if [ ${#SUCCESS[@]} -gt 0 ]; then
    ok "成功: ${SUCCESS[*]}"
else
    ok '成功: （无）'
fi
if [ ${#FAILED[@]} -gt 0 ]; then
    err "失败: ${FAILED[*]}"
    exit 1
fi

# ---------------- 步骤2：编译根项目 markdown_arkui 模块 ----------------
# markdown_arkui 依赖上一步复制到 markdown_arkui/har 目录的 4 个 HAR
# （见 markdown_arkui/oh-package.json5 中的 dependencies）。
echo ''
info '========== 编译 markdown_arkui 模块 =========='
build_root() {
    cd "$PROJECT_ROOT"

    # 根项目安装依赖（建立 oh_modules 并链接本地 HAR）
    echo '>>> ohpm install (根项目)'
    "$OHPM" install

    echo ">>> hvigorw assembleHar (markdown_arkui, $BUILD_MODE)"
    "$HVIGORW" assembleHar --mode module -p product=default -p module=markdown_arkui@default -p "buildMode=$BUILD_MODE" --no-daemon

    local root_har='markdown_arkui/build/default/outputs/default/markdown_arkui.har'
    [ -f "$root_har" ] || fail '构建完成但未找到产物: markdown_arkui.har'
    ok "markdown_arkui.har 已生成: $PROJECT_ROOT/$root_har"
}
build_root || fail '编译 markdown_arkui 失败'

# ---------------- 清理构建产生的临时缓存目录 ----------------
# hvigor 在用户目录缓存不可写时会把缓存降级落到项目根目录的 .hvigor_local，
# 每次打包结束后删除，避免残留在项目里。
if [ -d "$PROJECT_ROOT/.hvigor_local" ]; then
    rm -rf "$PROJECT_ROOT/.hvigor_local" 2>/dev/null || true
    [ ! -d "$PROJECT_ROOT/.hvigor_local" ] && echo '已清理临时缓存目录 .hvigor_local'
fi

echo ''
ok '========== 全部完成 =========='
