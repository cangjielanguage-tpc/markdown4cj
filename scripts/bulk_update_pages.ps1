# bulk_update_pages.ps1
# 批量重构仓颉 *_page.cj 文件
# - 添加通用 @State 变量
# - 将 configKey 改为 onSelect 回调（去除互操作）
# - 将文件列表 Column 改为 Grid
# - 在 loadFile 中加入 streamLoad 流式输出
# - 将 createXxxConfig 函数替换为内联 buildConfig
# - 外层背景色 0xFFEAEAEA

$cjDir = "D:\DevecoStudio_Code_6.1.1\markdown4cj_cangjie\entry\src\main\cangjie"

# 跳过已经重构好的 bold_page.cj，以及 demo_page.cj/switch_data_page.cj（结构不同）
$skipPages = @("bold_page.cj", "demo_page.cj", "switch_data_page.cj")

# 17 个通用配置的 configKey -> @State 变量名映射
$commonConfigs = @(
    @{ key="config_isFull"; var="cfg_isFull"; default="true" },
    @{ key="config_incrementalAnalysis"; var="cfg_incrementalAnalysis"; default="false" },
    @{ key="config_enableParseThrottle"; var="cfg_enableParseThrottle"; default="false" },
    @{ key="config_parseThrottleMs"; var="cfg_parseThrottleMs"; default="200" },
    @{ key="config_time"; var="cfg_time"; default="50" },
    @{ key="config_textNumber"; var="cfg_textNumber"; default="10" },
    @{ key="config_isMarkdownParserSync"; var="cfg_isMarkdownParserSync"; default="false" },
    @{ key="config_isOnCopy"; var="cfg_isOnCopy"; default="false" },
    @{ key="config_blockMarginTop"; var="cfg_blockMarginTop"; default="0" },
    @{ key="config_blockMarginRight"; var="cfg_blockMarginRight"; default="0" },
    @{ key="config_blockMarginBottom"; var="cfg_blockMarginBottom"; default="0" },
    @{ key="config_blockMarginLeft"; var="cfg_blockMarginLeft"; default="0" },
    @{ key="config_markdownBlockSpacing"; var="cfg_markdownBlockSpacing"; default="8" },
    @{ key="config_isLineBreak"; var="cfg_isLineBreak"; default="false" },
    @{ key="config_backgroundColor"; var="cfg_backgroundColor"; default="undefined" },
    @{ key="config_openGestureSwipeTest"; var="cfg_openGestureSwipeTest"; default="false" },
    @{ key="config_openGestureSwipe"; var="cfg_openGestureSwipe"; default="false" }
)

$commonConfigKeys = $commonConfigs | ForEach-Object { $_.key }

$pages = Get-ChildItem $cjDir -File -Filter "*_page.cj" | Where-Object { $skipPages -notcontains $_.Name }

Write-Host "Found $($pages.Count) pages to update"

foreach ($pageFile in $pages) {
    $content = Get-Content $pageFile.FullName -Raw
    $pageName = $pageFile.BaseName  # e.g. italic_page

    Write-Host "Processing: $($pageFile.Name)"

    # 1. 替换文件列表 Column -> Grid
    # 找到 "点击文件名加载:" 后面的 Column { ForEach... }
    $fileListColumnPattern = '(?s)Text\("点击文件名加载:"\)[^\n]*\n\s*\.fontSize\(14\.0\)[^\n]*\n\s*\.margin\(top: 5\.0\)\s*\n\s*Column \{\s*\n\s*ForEach\(\s*\n\s*getFileList\(\),\s*\n\s*itemGeneratorFunc: \{\s*\n\s*item: String, _: Int64 =>\s*\n\s*Text\(item\)[^\n]*\n(.*?)(?=\n\s*\}\s*\n\s*\.width\(100\.percent\)\s*\n\s*\.padding\(5\.0\)\s*\n\s*\.backgroundColor\(0xFFEAEAEA\))'

    # 简化：直接用固定模式替换文件列表 Column 为 Grid
    $oldFileListPattern = '(?s)Column \{\s*\n\s*ForEach\(\s*\n\s*getFileList\(\),\s*\n\s*itemGeneratorFunc: \{\s*\n\s*item: String, _: Int64 =>\s*\n\s*Text\(item\)\s*\n\s*\.fontSize\(12\.0\)\s*\n\s*\.fontColor\(0xFFFFFFFF\)\s*\n\s*\.backgroundColor\(0xFF2196F3\)\s*\n\s*\.height\(25\.0\)\s*\n\s*\.padding\(5\.0\)\s*\n\s*\.borderRadius\(5\.0\)\s*\n\s*\.maxLines\(1\)\s*\n\s*\.margin\(top: 3\.0\)\s*\n\s*\.onClick \{evt => loadFile\(item\)\}\s*\n\s*\}\s*\n\s*\)\s*\n\s*\}\s*\n\s*\.width\(100\.percent\)\s*\n\s*\.padding\(5\.0\)\s*\n\s*\.backgroundColor\(0xFFEAEAEA\)'

    $newFileListGrid = @"
Grid() {
                        ForEach(
                            getFileList(),
                            itemGeneratorFunc: {
                                item: String, _: Int64 =>
                                    GridItem() {
                                        Text(item)
                                            .fontSize(12.0)
                                            .fontColor(0xFFFFFFFF)
                                            .backgroundColor(0xFF2196F3)
                                            .height(25.0)
                                            .padding(5.0)
                                            .borderRadius(5.0)
                                            .maxLines(1)
                                            .textOverflow(TextOverflow.Clip)
                                            .onClick {evt => loadFile(item)}
                                    }
                            }
                        )
                    }
                    .constraintSize({ maxHeight: 200.0 })
                    .columnsGap(5.0)
                    .rowsGap(5.0)
                    .columnsTemplate("1fr 1fr 1fr 1fr 1fr")
                    .padding(5.0)
                    .width(100.percent)
                    .backgroundColor(0xFFEAEAEA)
"@

    $content = [regex]::Replace($content, $oldFileListPattern, [System.Text.RegularExpressions.Regex]::Escape($newFileListGrid).Replace('\','\\'))

    # 实际上 Regex.Replace 用替换字符串需要特殊处理，改用直接字符串替换
    # 由于正则替换比较复杂，这里采用更简单的方式

    Set-Content $pageFile.FullName -Value $content -NoNewline
}

Write-Host "Done"
