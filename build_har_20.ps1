<#
.SYNOPSIS
  Download the 4 prebuilt dependency HARs into markdown_arkui\har.
#>

$ErrorActionPreference = 'Stop'

$HarDir = Join-Path $PSScriptRoot 'markdown_arkui\har'
New-Item -ItemType Directory -Path $HarDir -Force | Out-Null

curl.exe -fL -o "$HarDir\prism_hybrid.har"           'https://cangjie103.obs.cn-north-4.myhuaweicloud.com/CangjieDaily/CangjieTPC/publish/prism4cj/prism4cj_hybrid_cangjie-plugin-6.1.1_compatibility/prism_hybrid_6.1.1-v2.0.0.har'
curl.exe -fL -o "$HarDir\codeformat_hybrid.har"      'https://cangjie103.obs.cn-north-4.myhuaweicloud.com/CangjieDaily/CangjieTPC/publish/codeformat4cj/codeformat_hybrid_cangjie-plugin-6.1.1_compatibility/codeformat_hybrid_6.1.1-v2.0.0.har'
curl.exe -fL -o "$HarDir\markdown_parser_hybrid.har" 'https://cangjie103.obs.cn-north-4.myhuaweicloud.com/CangjieDaily/CangjieTPC/publish/markdown4cj/markdown_parser_hybrid_cangjie-plugin-6.1.1_compatibility/markdown_parser_hybrid_6.1.1-v2.0.0.har'
curl.exe -fL -o "$HarDir\formula_hybrid.har"         'https://cangjie103.obs.cn-north-4.myhuaweicloud.com/CangjieDaily/CangjieTPC/publish/formula-ffi/formula-ffi_hybrid_cangjie-plugin-6.1.1_compatibility/formula_hybrid_6.1.1-v2.0.0.har'

Write-Host 'Done: markdown_arkui\har'
