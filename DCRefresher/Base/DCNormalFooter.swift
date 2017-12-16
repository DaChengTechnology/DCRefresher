//
//  DCNormalFooter.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/15.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import Foundation

public class DCNormalFooter:DCRefresherFooter {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        onNormal()
    }
    
    //MARK: 重写父类方法(overide super fuction)
    public override func setState(state: DCRefresherState) {
        switch state {
        case .normal:
            onNormal()
        case .willRefresh:
            onWillRefresh()
        case .refreshing:
            onRefreshing()
        case .refreshed:
            onRefreshed()
        case .noMore:
            onNoMore()
        }
        super.setState(state: state)
    }
    
    ///普通布局(normal layout)
    func onNormal() {
        
    }
    
    ///即将刷新(will refresh layout)
    func onWillRefresh() {
        
    }
    
    ///正在刷新(refreshing layout)
    func onRefreshing() {
        executeRefreshingCallback()
    }
    
    ///刷新完成(refreshed layout)
    func onRefreshed() {
        
    }
    
    ///没有更多(nomore layout)
    func onNoMore() {
        
    }
}
