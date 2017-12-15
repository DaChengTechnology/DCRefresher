//
//  UIScrollView+DCReflesher.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/14.
//  Copyright © 2017年 dacheng. All rights reserved.
//
private var headerkey = "header"
private var footerkey = "footer"
private var kvokey = "footer"
extension UIScrollView {
    ///下拉刷新控件(pull down control)
    public var dc_header:DCRefresherHeader?{
        get{
            return objc_getAssociatedObject(self, &headerkey) as? DCRefresherHeader
        }
        set(newValue) {
            if newValue == nil {
                dc_header?.removeFromSuperview()
            }else{
                self.addSubview(newValue!)
            }
            objc_setAssociatedObject(self, &headerkey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.dc_header == nil) && (self.dc_footer == nil) {
                self.kvo = nil
            }
        }
    }
    
    ///上拉更多控件(pull up control)
    public var dc_footer:DCRefresherFooter?{
        get{
            return objc_getAssociatedObject(self, &footerkey) as? DCRefresherFooter
        }
        set(newValue) {
            if newValue == nil {
                dc_footer?.removeFromSuperview()
            }else{
                self.addSubview(newValue!)
            }
            objc_setAssociatedObject(self, &footerkey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.dc_header == nil) && (self.dc_footer == nil) {
                self.kvo = nil
            }
        }
    }
    
    ///KVO管理器(KVO Menager)
    public var kvo:DCKVOMenager?{
        get{
            return objc_getAssociatedObject(self, &kvokey) as? DCKVOMenager
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kvokey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
