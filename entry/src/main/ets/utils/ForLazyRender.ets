/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
 */
// ArkTS 版实现
export class GeneralDataSource<T> implements IDataSource {
  private data: Array<T> = []
  private listener?: DataChangeListener

  constructor() {
    // this.data = data
  }

  public totalCount(): number {
    return this.data.length
  }

  public getData(index: number): T {
    return this.data[index]
  }

  public registerDataChangeListener(listener: DataChangeListener): void {
    this.listener = listener
  }

  public unregisterDataChangeListener(listener: DataChangeListener): void {
    if (this.listener === listener) {
      this.listener = undefined
    }
  }

  public append(item: T): void {
    this.data.splice(this.data.length, 0, item)
    this.listener?.onDataReloaded()
  }

  reload() {
    this.listener?.onDataChange(this.data.length - 1)
  }

  public get(index: number): T {
    if (index < 0) {
      return this.data[this.data.length + index]
    } else {
      return this.data[index]
    }
  }

  public set(index: number, item: T): void {
    if (index < 0) {
      this.data[this.data.length + index] = item
    } else {
      this.data[index] = item
    }
    this.listener?.onDataReloaded()
  }
}
