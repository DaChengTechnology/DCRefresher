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
    
    ///是否KVO(is it have KVO listener)
    var isKVO:Bool = false
    
    ///状态(control state)
    var state:DCRefresherState = .normal
    
    ///拖拽百分比(pulling percent)
    var pullingPercent:CGFloat{
        get{
            return self.pullingPercent
        }
        set(v){
            if v > CGFloat(1) {
                self.pullingPercent = 1
            }else{
                self.pullingPercent = v
            }
            if isAutomaticallyChangeAlpha {
                if state == .refreshing {
                    return
                }
            }
        }
    }
    
    ///自动透明度(auto change alpha)
    var isAutomaticallyChangeAlpha:Bool {
        get{
            return self.isAutomaticallyChangeAlpha
        }
        set(v){
            self.isAutomaticallyChangeAlpha = v
            if state == .refreshing {
                return
            }
            if v {
                self.alpha = pullingPercent
            }else{
                self.alpha = 1
            }
        }
    }
    
    ///是否滑到部分就开始刷新 位置通过postionRefresh设置(If you slide to part, you start to refresh your position through the postionRefresh setting)
    var isscrolledMidRefresh:Bool = false
    
    ///滑动到指定位置刷新 范围0-1 如果为footer 值为0.2 scrollview滑动到(contentSize.height+contentOffset.y-frame.height)/contentSize.height<=0.2的时候触发刷新操作(Slide to the specified location to refresh the range 0-1 if the footer value is 0.2 scrollview sliding to (contentSize. Height +contentOffset. Y -frame.height)/contentSize. Height <= 0.2, trigger the refresh operation)
    var postionRefresh:CGFloat = 0
    
    
    //MARK: -初始化(initializer)
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        prepare()
    }
    
    func prepare() {
        autoresizingMask = .flexibleWidth
        backgroundColor = UIColor.clear
        pullingPercent = 0
        isAutomaticallyChangeAlpha = false
    }
    
    public override func layoutSubviews() {
        placeSubViews()
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
    
    ///执行刷新
    func executeRefreshingCallback() {
        if (refreshingTarget != nil) && (refreshingAction != nil) {
            performSelector(onMainThread: refreshingAction!, with: refreshingTarget, waitUntilDone: true)
        }else{
            DispatchQueue.main.async {
                self.callBack!()
            }
        }
    }
}
