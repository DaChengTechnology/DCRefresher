//
//  DCRefresherComponent.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/14.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import Foundation

public class DCRefresherComponent :UIView{
    
    ///父控件(father control)
    weak var scrollView:UIScrollView?
    ///回调对象(callback object)
    private var refreshingTarget:Any? = nil
    ///回调方法(callback fuction)
    private var refreshingAction:Selector? = nil
    
    ///回调闭包(callback closure)
    private var callBack :DCRefreshCallBack? = nil
    
    ///状态(control state)
    var state:DCRefresherState = .normal
    
    ///拖拽百分比(pulling percent)
    var pullingPercent:CGFloat = 0
    
    ///自动透明度(auto change alpha)
    public var isAutomaticallyChangeAlpha:Bool = false
    
    ///是否滑到部分就开始刷新 位置通过postionRefresh设置(If you slide to part, you start to refresh your position through the postionRefresh setting)
    var isscrolledMidRefresh:Bool = false
    
    ///滑动到指定位置刷新 和边缘的距离
    var postionRefresh:CGFloat = 0
    
    
    //MARK: -初始化(initializer)
    public override init(frame: CGRect) {
        super.init(frame: frame)
        print("1")
        prepare()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    func prepare() {
        backgroundColor = UIColor.clear
        isscrolledMidRefresh = false
        pullingPercent = 0
    }
    
    public override func layoutSubviews() {
        //placeSubViews()
        super.layoutSubviews()
    }
    
    func placeSubViews() {}
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let s = newSuperview as? UIScrollView {
            if s.kvo == nil {
                s.kvo = DCKVOMenager()
                s.kvo?.addObservers(scrollView: s)
                scrollView = s
            }
            placeSubViews()
        }
    }
    
    
    
    //MARK:公用方法(public fuction)
    ///设置刷新的回调方法(Set Refresh callback function)
    public func setRefreshing( target:Any, selector:Selector) {
        refreshingTarget = target
        refreshingAction = selector
    }
    
    ///设置回调闭包(set callback closure)
    public func setCallBackClosure(closure:@escaping DCRefreshCallBack) {
        self.callBack = closure
    }
    
    ///设置状态(set state)
    public func setState(state:DCRefresherState) {
        self.state = state
    }
    
    ///清空页面(clear view)
    public func clear() {
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
    
    ///执行刷新(execute refresh)
    func executeRefreshingCallback() {
        if (refreshingTarget != nil) && (refreshingAction != nil) {
            performSelector(onMainThread: refreshingAction!, with: refreshingTarget, waitUntilDone: true)
        }else{
            DispatchQueue.main.async {
                self.callBack!()
            }
        }
    }
    
    ///应用透明度(apply alpha)
    func applyAlpha() {
        if alpha > 1.0 {
            self.layer.opacity = Float(1)
        }else{
            self.layer.opacity = Float(alpha)
        }
    }
    
    public func setMidRefresh(refresh:Bool, distance:CGFloat){
        
    }
}
