//
//  CLMPHUD.swift
//  TestDemo
//
//  Created by fuyongYU on 2018/5/22.
//  Copyright © 2018年 YeMaoZi. All rights reserved.
//

import UIKit
import MBProgressHUD

class CLMPHUD: NSObject {
    
    /// 转菊花
    public static func showHUD(view:UIView,text:String? = "加载中") {
        //HUD加在哪一个试图上,就会屏蔽哪一个试图的用户交互
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate //设置为菊花样式
        hud.label.text = text
        hud.isSquare = true
        //      hud.bezelView.color = UIColor.lightGray //HUD的底色
        //      hud.contentColor = UIColor.white //菊花的颜色
        //转菊花的时候整个页面设置为不可用
        
    }
    
    /// 只显示文字
    public static func showHUDText(_ view:UIView ,_ text:String ,  _ afterDelay:TimeInterval)  {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text = text
        hud.isSquare = false
        hud.minShowTime = 0.5
        hud.hide(animated: true, afterDelay: afterDelay)
    }
    
    
    /// 隐藏HUD
    public static func dissmissHUD(_ view: UIView?)  {
        if   let view = view{
            MBProgressHUD.hide(for: view, animated: true)
        }else{
            MBProgressHUD.hide(for: (UIApplication.shared.keyWindow)!, animated: true)
        }
        
    }
    
    /// 转自定义的图片
    public static func showHUDImageArray(_ view: UIView , text: String? = "加载中...",imageArr: [ UIImage ])  {
        //此处需要自己放对应的图片,放外面传
//        let imageArr : [UIImage] = [UIImage(named: "HUD1")!,
//                                    UIImage(named: "HUD2")!,
//                                    UIImage(named: "HUD3")!,
//                                    UIImage(named: "HUD4")!,
//                                    UIImage(named: "HUD5")!,
//                                    UIImage(named: "HUD6")!]
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.minShowTime = 0.5
        hud.mode = .customView
        let imageCustomView =  UIImageView()
        imageCustomView.animationImages = imageArr
        imageCustomView.animationRepeatCount = 0
        imageCustomView.animationDuration = TimeInterval((CGFloat)(imageArr.count + 1)/10.0)
        imageCustomView.startAnimating()
        hud.customView = imageCustomView
        hud.isSquare = true
        hud.label.text = text
        //这里还可以设置文字的颜色,文字的字体,hud的背景色等等
    }
    
    
    
    
}
