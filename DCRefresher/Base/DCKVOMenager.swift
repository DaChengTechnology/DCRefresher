//
//  DCKVOMenager.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/15.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import Foundation


public class DCKVOMenager: NSObject {
    
    ///需要监听的控件(need listenv control)
    weak var scrollView:UIScrollView?
    ///滑动手势(UIPanGestureRecognizer)
    weak var pan:UIPanGestureRecognizer?
    override init() {
        super.init()
    }
    
    deinit {
        removeObservers()
    }
    
    //MARK: -KVO监听(KVO Listener)
    func addObservers(scrollView:UIScrollView) {
        scrollView.addObserver(self, forKeyPath: DCRefresherKeyPathContentOffset, options: [.new,.old], context: nil)
        scrollView.addObserver(self, forKeyPath: DCRefresherKeyPathContentInset, options: [.new,.old], context: nil)
        scrollView.addObserver(self, forKeyPath: DCRefresherKeyPathContentSize, options: [.new,.old], context: nil)
        self.scrollView = scrollView
        self.pan = self.scrollView?.panGestureRecognizer
        self.pan?.addObserver(self, forKeyPath: DCRefresherKeyPathPanState, options: [.new,.old], context: nil)
    }
    
    func removeObservers() {
        self.scrollView?.removeObserver(self, forKeyPath: DCRefresherKeyPathContentOffset)
        self.scrollView?.removeObserver(self, forKeyPath: DCRefresherKeyPathContentSize)
        self.pan?.removeObserver(self, forKeyPath: DCRefresherKeyPathPanState)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == DCRefresherKeyPathContentOffset {
            scrollViewContentOffsetDidChange(change: change)
        }
        if keyPath == DCRefresherKeyPathContentSize {
            scrollViewContentSizeDidChange(change: change)
        }
        if keyPath == DCRefresherKeyPathPanState {
            scrollViewPanStateDidChange(change: change)
        }
    }
    
    ///位置改变(postion changed)
    func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?){
        var b:Bool = false
        if scrollView?.dc_header?.state == .refreshing {
            b = headerRefreshing()
        }
        if scrollView?.dc_footer?.state == .refreshing {
            b = b && footerRefreshing()
        }
        if b {
            return
        }
        //自动透明度(auto alpha)
        if (scrollView?.dc_header?.state == .normal) || (scrollView?.dc_header?.state == .refreshed) || (scrollView?.dc_header?.state == .noMore) {
            if (scrollView?.dc_header?.isAutomaticallyChangeAlpha)! {
                if (scrollView?.contentOffset.y)! > CGFloat(0) {
                    scrollView?.dc_header?.pullingPercent = (scrollView?.contentOffset.y)! / (scrollView?.dc_header?.frame.height)!
                }
            }
        }
        if (scrollView?.dc_header?.state == .normal) || (scrollView?.dc_header?.state == .refreshed) || (scrollView?.dc_header?.state == .noMore) {
            if (scrollView?.dc_footer?.isAutomaticallyChangeAlpha)! {
                if (scrollView?.contentOffset.y)! < ((scrollView?.frame.height)! - (scrollView?.contentSize.height)!) {
                    scrollView?.dc_footer?.pullingPercent = (CGFloat(0) - ((scrollView?.contentOffset.y)! - ((scrollView?.frame.height)! - (scrollView?.contentSize.height)!))) / (scrollView?.dc_footer?.frame.height)!
                }
            }
        }
        if (scrollView?.isDragging)! {
            if !(scrollView?.dc_header?.isscrolledMidRefresh)! {
                if scrollView?.dc_header?.state == .normal {
                    if (scrollView?.contentOffset.y)! > (scrollView?.dc_header?.frame.height)! {
                        scrollView?.dc_header?.setState(state: .willRefresh)
                    }
                }
                if scrollView?.dc_header?.state == .willRefresh {
                    if (scrollView?.contentOffset.y)! < (scrollView?.dc_header?.frame.height)! {
                        scrollView?.dc_header?.setState(state: .normal)
                    }
                }
            }
            if !(scrollView?.dc_footer?.isscrolledMidRefresh)! {
                if scrollView?.dc_footer?.state == .normal {
                    if (CGFloat(0) - ((scrollView?.contentOffset.y)! - ((scrollView?.frame.height)! - (scrollView?.contentSize.height)!))) > (scrollView?.dc_footer?.frame.height)! {
                        scrollView?.dc_footer?.setState(state: .willRefresh)
                    }
                }
                if scrollView?.dc_footer?.state == .willRefresh {
                    if (CGFloat(0) - ((scrollView?.contentOffset.y)! - ((scrollView?.frame.height)! - (scrollView?.contentSize.height)!))) < (scrollView?.dc_footer?.frame.height)! {
                        scrollView?.dc_footer?.setState(state: .normal)
                    }
                }
            }
        }
    }
    ///大小改变(size changed)
    func scrollViewContentSizeDidChange(change: [NSKeyValueChangeKey : Any]?){}
    ///触摸状态改变(touch state changed)
    func scrollViewPanStateDidChange(change: [NSKeyValueChangeKey : Any]?){}
    
    //控件刷新中
    func headerRefreshing() -> Bool {
        if (scrollView?.dc_header?.isscrolledMidRefresh)! {
            if (scrollView?.dc_header?.isAutomaticallyChangeAlpha)! {
                if (scrollView?.contentOffset.y)! > CGFloat(0) {
                    scrollView?.dc_header?.pullingPercent = (scrollView?.contentOffset.y)! / (scrollView?.dc_header?.frame.height)!
                    return false
                }
            }
        }
        return true
    }
    
    func footerRefreshing() -> Bool {
        if (scrollView?.dc_footer?.isscrolledMidRefresh)! {
            if (scrollView?.dc_footer?.isAutomaticallyChangeAlpha)! {
                if (scrollView?.contentOffset.y)! < ((scrollView?.frame.height)! - (scrollView?.contentSize.height)!) {
                    scrollView?.dc_footer?.pullingPercent = (CGFloat(0) - ((scrollView?.contentOffset.y)! - ((scrollView?.frame.height)! - (scrollView?.contentSize.height)!))) / (scrollView?.dc_footer?.frame.height)!
                    return false
                }
            }
        }
        return true
    }
    
}
