//
//  DCAnimateFooter.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/15.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import Foundation

public class DCAnimateFooter: DCRefresherFooter {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        onNormal()
    }
    
    //MARK: 重写父类方法(overide super fuction)
    public override func setState(state: DCRefresherState) {
        if (self.state == .normal) && (state == .willRefresh) {
            onNormalToWillRefresh()
        }
        if (self.state == .willRefresh) && (state == .normal) {
            onWillRefreshToNormal()
        }
        if (self.state == .willRefresh) && (state == .refreshing) {
            onWillRefreshToRefreshing()
        }
        if (self.state == .normal) && (state == .refreshing) {
            onNormalToRefreshing()
        }
        if (self.state == .refreshing) && (state == .normal) {
            onRefreshingToNormal()
        }
        if (self.state == .refreshing) && (state == .refreshed) {
            onRefreshingToRefreshed()
        }
        if (self.state == .refreshing) && (state == .noMore){
            onRefreshingToNoMore()
        }
        if (self.state == .refreshed) && (state == .normal) {
            onRefreshedToNormal()
        }
        super.setState(state: state)
    }
    
    ///普通布局(normal layout)
    func onNormal() {
        
    }
    
    ///动画函数(animation function)
    func onNormalToWillRefresh() {
        
    }
    
    func onWillRefreshToNormal() {
        
    }
    
    func onWillRefreshToRefreshing() {
        executeRefreshingCallback()
    }
    
    func onNormalToRefreshing() {
        
    }
    
    func onRefreshingToRefreshed() {
        
    }
    
    func onRefreshingToNormal() {
        
    }
    
    func onRefreshingToNoMore() {
        
    }
    
    func onRefreshedToNormal() {
        
    }
}
