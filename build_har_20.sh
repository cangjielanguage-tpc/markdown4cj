#!/usr/bin/env bash
# 下载 4 个预编译依赖 HAR 到 markdown_arkui/har 目录
set -e

HAR_DIR="$(cd "$(dirname "$0")" && pwd)/markdown_arkui/har"
mkdir -p "$HAR_DIR"

curl -fL -o "$HAR_DIR/prism_hybrid.har"           'https://cangjie103.obs.cn-north-4.myhuaweicloud.com/CangjieDaily/CangjieTPC/publish/prism4cj/prism4cj_hybrid_cangjie-plugin-6.1.1_compatibility/prism_hybrid_6.1.1-v2.0.0.har'
curl -fL -o "$HAR_DIR/codeformat_hybrid.har"      'https://cangjie103.obs.cn-north-4.myhuaweicloud.com/CangjieDaily/CangjieTPC/publish/codeformat4cj/codeformat_hybrid_cangjie-plugin-6.1.1_compatibility/codeformat_hybrid_6.1.1-v2.0.0.har'
curl -fL -o "$HAR_DIR/markdown_parser_hybrid.har" 'https://cangjie103.obs.cn-north-4.myhuaweicloud.com/CangjieDaily/CangjieTPC/publish/markdown4cj/markdown_parser_hybrid_cangjie-plugin-6.1.1_compatibility/markdown_parser_hybrid_6.1.1-v2.0.0.har'
curl -fL -o "$HAR_DIR/formula_hybrid.har"         'https://cangjie103.obs.cn-north-4.myhuaweicloud.com/CangjieDaily/CangjieTPC/publish/formula-ffi/formula-ffi_hybrid_cangjie-plugin-6.1.1_compatibility/formula_hybrid_6.1.1-v2.0.0.har'

echo 'Done: markdown_arkui/har'
