//
//  DCNormalFooter.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/15.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import Foundation

open class DCNormalFooter:DCRefresherFooter {
    
    ///上一个状态(last state)
    open var oldState:DCRefresherState?
    
    open override func didMoveToSuperview() {
        onNormal()
        oldState = .normal
    }
    
    //MARK: 重写父类方法(overide super fuction)
    open override func setState(state: DCRefresherState) {
        oldState = state
        super.setState(state: state)
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
    }
    
    ///普通布局(normal layout)
    open func onNormal() {
        if scrollView?.contentInset.bottom != 0 {
            scrollView?.contentInset.bottom = 0
        }
        if (scrollView?.isDragging)! {
            return
        }
        if (scrollView?.frame.height)! > (scrollView?.contentSize.height)! {
            return
        }
        if (scrollView?.contentOffset.y)! > ((scrollView?.contentSize.height)!-(scrollView?.frame.height)!) {
            scrollView?.setContentOffset(CGPoint(x: 0, y: (scrollView?.contentSize.height)!), animated: false)
        }
    }
    
    ///即将刷新(will refresh layout)
    open func onWillRefresh() {
        if scrollView?.contentInset.bottom != 0 {
            scrollView?.contentInset.bottom = 0
        }
    }
    
    ///正在刷新(refreshing layout)
    open func onRefreshing() {
        if (scrollView?.frame.height)! < (scrollView?.contentSize.height)! {
            if !isscrolledMidRefresh {
                scrollView?.contentInset.bottom = frame.height
            }
        }
        executeRefreshingCallback()
    }
    
    ///刷新完成(refreshed layout)
    open func onRefreshed() {
        if scrollView?.contentInset.bottom != 0 {
            scrollView?.contentInset.bottom = 0
        }
        DispatchQueue.main.async {
            self.setState(state: .normal)
        }
    }
    
    ///没有更多(nomore layout)
    open func onNoMore() {
        if scrollView?.contentInset.bottom != 0 {
            scrollView?.contentInset.bottom = 0
        }
        if (scrollView?.isDragging)! {
            return
        }
        if (scrollView?.frame.height)! > (scrollView?.contentSize.height)! {
            return
        }
        
    }
}
