//
//  DCNormalHeader.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/15.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import Foundation

open class DCNormalHeader:DCRefresherHeader {
    
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
        if scrollView?.contentInset.top != 0 {
            scrollView?.contentInset.top = 0
        }
        if (scrollView?.isDragging)! {
            return
        }
        if (self.scrollView?.contentOffset.y)! > CGFloat(0) {
            self.scrollView?.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    ///即将刷新(will refresh layout)
    open func onWillRefresh() {
        if scrollView?.contentInset.top != 0 {
            scrollView?.contentInset.top = 0
        }
    }
    
    ///正在刷新(refreshing layout)
    open func onRefreshing() {
        if !self.isscrolledMidRefresh {
            var inset = scrollView?.contentInset
            inset?.top = self.frame.height
            scrollView?.contentInset = inset!
        }
        executeRefreshingCallback()
    }
    
    ///刷新完成(refreshed layout)
    open func onRefreshed() {
        if scrollView?.contentInset.top != 0 {
            scrollView?.contentInset.top = 0
        }
        if (scrollView?.isDragging)! {
            return
        }
        if !self.isscrolledMidRefresh {
            scrollView?.setContentOffset(CGPoint(x: 0, y: 0-self.frame.height), animated: false)
        }
        let time:TimeInterval = 3
        DispatchQueue.main.asyncAfter(deadline: .now()+time) {
            if (self.scrollView?.contentOffset.y)! < CGFloat(0) {
                self.scrollView?.setContentOffset(CGPoint(x:0, y:0), animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self.setState(state: .normal)
                })
            }
        }
    }
    
    ///没有更多(nomore layout)
    open func onNoMore() {
        if scrollView?.contentInset.top != 0 {
            scrollView?.contentInset.top = 0
        }
        if (scrollView?.isDragging)! {
            return
        }
        if !self.isscrolledMidRefresh {
            scrollView?.setContentOffset(CGPoint(x: 0, y: 0-self.frame.height), animated: false)
        }
        let time:TimeInterval = 3
        DispatchQueue.main.asyncAfter(deadline: .now()+time) {
            if (self.scrollView?.contentOffset.y)! > CGFloat(0) {
                self.scrollView?.setContentOffset(CGPoint(x:0, y:0), animated: true)
            }
        }
    }
    
}
