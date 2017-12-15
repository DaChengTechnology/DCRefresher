//
//  DCRefresher.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/14.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import Foundation
public enum DCRefresherState {
    case normal
    case willRefresh
    case refreshing
    case refreshed
    case noMore
}

public typealias DCRefreshCallBack = () -> Void
