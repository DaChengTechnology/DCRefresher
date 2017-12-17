//
//  DCDefualtHeader.swift
//  DCRefresher
//
//  Created by dacheng on 2017/12/16.
//  Copyright © 2017年 dacheng. All rights reserved.
//

import Foundation

public class DCDefualtHeader:DCNormalHeader{
    
    override func onNormal() {
        super.onNormal()
        if oldState == .willRefresh {
            let v = self.viewWithTag(1)
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                v?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            }, completion: { (_) in
                
            })
            let label = self.viewWithTag(2) as? UILabel
            label?.text = "下拉刷新"
            return
        }
        self.clear()
        let str = "下拉刷新" as NSString
        let s = str.size(withAttributes: [.font:UIFont.systemFont(ofSize: 17)])
        let rect = self.frame
        let imageView = UIImageView(frame: CGRect(x: (rect.width-s.width-35)/2, y: (rect.height-30)/2, width: 30, height: 30))
        let path = Bundle.init(path: (Bundle.init(identifier: "fightsport.com.DCRefresher")?.path(forResource: "DCRefresh", ofType: "bundle"))!)?.path(forResource: "down", ofType: "png")
        let image = UIImage(contentsOfFile: path!)
        imageView.image = image
        imageView.tag = 1
        self.addSubview(imageView)
        let label = UILabel(frame: CGRect(x: (rect.width-s.width-35)/2+35, y: (rect.height-s.height)/2, width: s.width, height: s.height))
        label.tag = 2
        label.text = str as String
        label.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(label)
    }
    
    override func onWillRefresh() {
        if oldState == .normal {
            let v = self.viewWithTag(1)
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                v?.transform = CGAffineTransform(rotationAngle: CGFloat(-1*Double.pi))
            }, completion: { (_) in
                
            })
            let label = self.viewWithTag(2) as? UILabel
            label?.text = "释放刷新"
            return
        }
        self.clear()
        let str = "释放刷新" as NSString
        let s = str.size(withAttributes: [.font:UIFont.systemFont(ofSize: 17)])
        let rect = self.frame
        let imageView = UIImageView(frame: CGRect(x: (rect.width-s.width-35)/2, y: (rect.height-30)/2, width: 30, height: 30))
        let path = Bundle.init(path: (Bundle.init(identifier: "fightsport.com.DCRefresher")?.path(forResource: "DCRefresh", ofType: "bundle"))!)?.path(forResource: "down", ofType: "png")
        let image = UIImage(contentsOfFile: path!)
        imageView.image = image
        imageView.tag = 1
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat(-1*Double.pi))
        }) { (_) in
            
        }
        self.addSubview(imageView)
        let label = UILabel(frame: CGRect(x: (rect.width-s.width-35)/2+35, y: (rect.height-s.height)/2, width: s.width, height: s.height))
        label.tag = 2
        label.text = str as String
        label.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(label)
        super.onWillRefresh()
    }
    
    override func onRefreshing() {
        self.clear()
        let str = "正在刷新中..." as NSString
        let s = str.size(withAttributes: [.font:UIFont.systemFont(ofSize: 17)])
        let size = self.bounds.size
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect(x: (size.width-s.width-35)/2, y: (size.height-30)/2, width: 30, height: 30)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        let label = UILabel(frame: CGRect(x: (size.width-s.width-35)/2+35, y: (size.height-s.height)/2, width: s.width, height: s.height))
        label.text = str as String
        label.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(label)
        super.onRefreshing()
    }
    
    override func onRefreshed() {
        self.clear()
        let str = "刷新完成" as NSString
        let s = str.size(withAttributes: [.font:UIFont.systemFont(ofSize: 17)])
        let rect = self.frame
        let imageView = UIImageView(frame: CGRect(x: (rect.width-s.width-35)/2, y: (rect.height-30)/2, width: 30, height: 30))
        let path = Bundle.init(path: (Bundle.init(identifier: "fightsport.com.DCRefresher")?.path(forResource: "DCRefresh", ofType: "bundle"))!)?.path(forResource: "complete", ofType: "png")
        let image = UIImage(contentsOfFile: path!)
        imageView.image = image
        imageView.tag = 1
        self.addSubview(imageView)
        let label = UILabel(frame: CGRect(x: (rect.width-s.width-35)/2+35, y: (rect.height-s.height)/2, width: s.width, height: s.height))
        label.tag = 2
        label.text = str as String
        label.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(label)
        super.onRefreshed()
    }
    
    override func onNoMore() {
        self.clear()
        let str = "没有更多了" as NSString
        let s = str.size(withAttributes: [.font:UIFont.systemFont(ofSize: 17)])
        let rect = self.frame
        let label = UILabel(frame: CGRect(x: (rect.width-s.width)/2, y: (rect.height-s.height)/2, width: s.width, height: s.height))
        label.text = str as String
        label.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(label)
        super.onNoMore()
    }
    
}
