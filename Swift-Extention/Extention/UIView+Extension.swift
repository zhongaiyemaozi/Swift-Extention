//
//  CLUIView+Extension.swift
//  TestDemo
//
//  Created by fuyongYU on 2018/5/22.
//  Copyright © 2018年 YeMaoZi. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 一次添加多个子控件
    func addSubViews(subviews:[UIView]) {
        for view in subviews {
            addSubview(view)
        }
    }
    
    /// 找到当前控件所在的控制器
    func getCurrentViewController() -> UIViewController? {
        var nextResponder = next
        repeat {
            let isVC = nextResponder?.isKind(of: UIViewController.self)
            if isVC != nil {
                return nextResponder as? UIViewController
            }
            nextResponder = nextResponder?.next
        }while (nextResponder != nil)
        return nil
    }
    
    /// 生成UIView的一张图片
    func takeSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
