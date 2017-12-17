//
//  DCNormalFooter.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/15.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import Foundation

public class DCNormalFooter:DCRefresherFooter {
    
    ///上一个状态(last state)
    var oldState:DCRefresherState?
    
    public override func didMoveToSuperview() {
        onNormal()
        oldState = .normal
    }
    
    //MARK: 重写父类方法(overide super fuction)
    public override func setState(state: DCRefresherState) {
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
    func onNormal() {
        if scrollView?.contentInset.bottom != 0 {
            scrollView?.contentInset.bottom = 0
        }
        if (scrollView?.isDragging)! {
            return
        }
        if (scrollView?.frame.height)! > (scrollView?.contentSize.height)! {
            return
        }
        if (scrollView?.contentOffset.y)! < ((scrollView?.contentSize.height)!-(scrollView?.frame.height)!) {
            scrollView?.setContentOffset(CGPoint(x: 0, y: (scrollView?.contentSize.height)!-(scrollView?.frame.height)!), animated: false)
        }
    }
    
    ///即将刷新(will refresh layout)
    func onWillRefresh() {
        if scrollView?.contentInset.bottom != 0 {
            scrollView?.contentInset.bottom = 0
        }
    }
    
    ///正在刷新(refreshing layout)
    func onRefreshing() {
        if (scrollView?.frame.height)! < (scrollView?.contentSize.height)! {
            if !isscrolledMidRefresh {
                scrollView?.setContentOffset(CGPoint(x: 0, y: (scrollView?.contentSize.height)!-(scrollView?.frame.height)!), animated: false)
                scrollView?.contentInset.bottom = frame.height
            }
        }
        executeRefreshingCallback()
    }
    
    ///刷新完成(refreshed layout)
    func onRefreshed() {
        if scrollView?.contentInset.bottom != 0 {
            scrollView?.contentInset.bottom = 0
        }
        if (scrollView?.isDragging)! {
            return
        }
        if (scrollView?.frame.height)! > (scrollView?.contentSize.height)! {
            return
        }
        if !isscrolledMidRefresh {
            if ((scrollView?.contentOffset.y)! < ((scrollView?.contentSize.height)!-(scrollView?.frame.height)!-self.frame.height)) && ((scrollView?.contentOffset.y)! > ((scrollView?.contentSize.height)!-(scrollView?.frame.height)!)) {
                scrollView?.setContentOffset(CGPoint(x: 0, y: (scrollView?.contentSize.height)!-(scrollView?.frame.height)!+self.frame.height), animated: false)
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                self.scrollView?.setContentOffset(CGPoint(x: 0, y: (self.scrollView?.contentSize.height)!-(self.scrollView?.frame.height)!), animated: true)
                self.setState(state: .normal)
            })
        }
    }
    
    ///没有更多(nomore layout)
    func onNoMore() {
        if scrollView?.contentInset.bottom != 0 {
            scrollView?.contentInset.bottom = 0
        }
        if (scrollView?.isDragging)! {
            return
        }
        if (scrollView?.frame.height)! > (scrollView?.contentSize.height)! {
            return
        }
        if !isscrolledMidRefresh {
            if ((scrollView?.contentOffset.y)! < ((scrollView?.contentSize.height)!-(scrollView?.frame.height)!-self.frame.height)) && ((scrollView?.contentOffset.y)! > ((scrollView?.contentSize.height)!-(scrollView?.frame.height)!)) {
                scrollView?.setContentOffset(CGPoint(x: 0, y: (scrollView?.contentSize.height)!-(scrollView?.frame.height)!+self.frame.height), animated: false)
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                self.scrollView?.setContentOffset(CGPoint(x: 0, y: (self.scrollView?.contentSize.height)!-(self.scrollView?.frame.height)!), animated: true)
            })
        }
    }
}
