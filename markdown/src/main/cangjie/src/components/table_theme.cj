/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */
package markdown.components

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

/**
 * 表格主题类
 */
public class TableTheme {
    /**
     * 表格内容内边距
     */
    protected var tableCellPadding: Float64 = 4.0

    /**
     * 表格边框颜色
     */
    protected var tableBorderColor: Color = Color(0xFF000000)

    /**
     * 表格边框宽度
     */
    protected var tableBorderWidth: Float64 = 1.0

    /**
     * 表格奇数行背景色
     */
    protected var tableOddRowBackgroundColor: Color = Color(0xFFFFFFFF)

    /**
     * 表格偶数行背景色
     */
    protected var tableEvenRowBackgroundColor: Color = Color(0xFFE0E0E0)

    /**
     * 表格头背景色
     */
    protected var tableHeaderRowBackgroundColor: Color = Color(0xFFFFFFFF)

    protected init(builder: TableThemeBuilder) {
        this.tableCellPadding = builder.tableCellPadding
        this.tableBorderColor = builder.tableBorderColor
        this.tableBorderWidth = builder.tableBorderWidth
        this.tableOddRowBackgroundColor = builder.tableOddRowBackgroundColor
        this.tableEvenRowBackgroundColor = builder.tableEvenRowBackgroundColor
        this.tableHeaderRowBackgroundColor = builder.tableHeaderRowBackgroundColor
    }

    /**
     * 创建Theme对象
     */
    public static func create(): TableTheme {
        return emptyBuilder().build()
    }

    /**
     * 创建一个空的builder对象
     */
    public static func emptyBuilder(): TableThemeBuilder {
        return TableThemeBuilder()
    }

    /**
     * 创建一个带有默认值的builder对象
     */
    public func asBuilder(): TableThemeBuilder {
        return TableThemeBuilder()
            .setTableCellPadding(tableCellPadding)
            .setTableBorderColor(tableBorderColor)
            .setTableBorderWidth(tableBorderWidth)
            .setTableOddRowBackgroundColor(tableOddRowBackgroundColor)
            .setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor)
            .setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor)
    }
}

public class TableThemeBuilder {
    /**
     * 表格内容内边距
     */
    var tableCellPadding: Float64 = 4.0

    /**
     * 表格边框颜色
     */
    var tableBorderColor: Color = Color(0xFF000000)

    /**
     * 表格边框宽度
     */
    var tableBorderWidth: Float64 = 1.0

    /**
     * 表格奇数行背景色
     */
    var tableOddRowBackgroundColor: Color = Color(0xFFFFFFFF)

    /**
     * 表格偶数行背景色
     */
    var tableEvenRowBackgroundColor: Color = Color(0xFFE0E0E0)

    /**
     * 表格头背景色
     */
    var tableHeaderRowBackgroundColor: Color = Color(0xFFFFFFFF)

    /**
     * 设置表格内容内边距
     */
    public func setTableCellPadding(tableCellPadding: Float64): TableThemeBuilder {
        this.tableCellPadding = tableCellPadding
        return this
    }

    /**
     * 设置表格边框颜色
     */
    public func setTableBorderColor(tableBorderColor: Color): TableThemeBuilder {
        this.tableBorderColor = tableBorderColor
        return this
    }

    /**
     * 设置表格边框宽度
     */
    public func setTableBorderWidth(tableBorderWidth: Float64): TableThemeBuilder {
        this.tableBorderWidth = tableBorderWidth
        return this
    }

    /**
     * 设置表格奇数行背景色
     */
    public func setTableOddRowBackgroundColor(tableOddRowBackgroundColor: Color): TableThemeBuilder {
        this.tableOddRowBackgroundColor = tableOddRowBackgroundColor
        return this
    }

    /**
     * 设置表格偶数行背景色
     */
    public func setTableEvenRowBackgroundColor(tableEvenRowBackgroundColor: Color): TableThemeBuilder {
        this.tableEvenRowBackgroundColor = tableEvenRowBackgroundColor
        return this
    }

    /**
     * 设置表格头背景色
     */
    public func setTableHeaderRowBackgroundColor(tableHeaderRowBackgroundColor: Color): TableThemeBuilder {
        this.tableHeaderRowBackgroundColor = tableHeaderRowBackgroundColor
        return this
    }

    /**
     * 构建 TableTheme 实例
     */
    public func build(): TableTheme {
        return TableTheme(this)
    }
}
