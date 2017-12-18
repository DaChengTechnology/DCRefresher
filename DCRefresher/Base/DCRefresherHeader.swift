//
//  DCRefresherHeader.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/14.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import UIKit

public class DCRefresherHeader: DCRefresherComponent {
    
    var scrollViewOriginalInset:UIEdgeInsets?

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override public func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    public init(target:Any, selector:Selector)  {
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        prepare()
        self.setRefreshing(target: target, selector: selector)
    }
    
    public init(closure:@escaping DCRefreshCallBack) {
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        prepare()
        self.setCallBackClosure {
            closure()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    ///设置高度(set height)
    override func prepare() {
        super.prepare()
        var rect = frame
        rect.size = CGSize(width: frame.width, height: DCRefresherHeaderHeight)
        self.frame = rect
    }
    
    ///设置位置(set postion)
    override func placeSubViews() {
        super.placeSubViews()
        var rect = frame
        rect.origin.y = -frame.height
        rect.size = CGSize(width: (scrollView?.bounds.width)!, height: frame.height)
        self.frame = rect
    }
    
    ///确认安全边界(make sure safe edges)
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        scrollViewOriginalInset = scrollView?.scrollIndicatorInsets
        if (scrollViewOriginalInset?.top)! <= self.frame.height {
            scrollViewOriginalInset?.top = frame.height+40
            scrollView?.scrollIndicatorInsets = scrollViewOriginalInset!
        }
    }
    
    
}
