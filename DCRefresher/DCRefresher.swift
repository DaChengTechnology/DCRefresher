//
//  DCRefresher.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/14.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import Foundation
public enum DCRefresherState {
    ///普通状态(nomal state)
    case normal
    ///将要刷新(will refresh state)
    case willRefresh
    ///正在刷新(refreshing state)
    case refreshing
    ///刷新完成(refreshed state)
    case refreshed
    ///没有更多(no more state)
    case noMore
}

public typealias DCRefreshCallBack = () -> Void
