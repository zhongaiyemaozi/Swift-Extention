//
//  UIColor+Extensions.swift
//  WeiBo
//
//  Created by 夜猫子 on 2017/4/2.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

import UIKit

extension UIColor {
    
    var red: CGFloat {
        get {
            var red: CGFloat = 0
            self.getRed(&red, green: nil, blue: nil, alpha: nil)
            return red
        }
    }
    
    var green: CGFloat {
        get {
            var green: CGFloat = 0
            self.getRed(nil, green: &green, blue: nil, alpha: nil)
            return green
        }
    }
    
    var blue: CGFloat {
        get {
            var blue: CGFloat = 0
            self.getRed(nil, green: nil, blue: &blue, alpha: nil)
            return blue
        }
    }
    
    var alpha: CGFloat {
        get {
            var alpha: CGFloat = 0
            self.getRed(nil, green: nil, blue: nil, alpha: &alpha)
            return alpha
        }
    }
    
    func transition(to color: UIColor, progress: CGFloat) -> UIColor {
        let red = self.red + (color.red - self.red) * progress
        let green = self.green + (color.green - self.green) * progress
        let blue = self.blue + (color.blue - self.blue) * progress
        let alpha = self.alpha + (color.alpha - self.alpha) * progress
        let resultColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return resultColor
    }
    
    /// 颜色的遍历构造器
    ///
    /// - Parameters:
    ///   - red: 红色
    ///   - green: 绿色
    ///   - blue: 蓝色
    /// - Returns: 合成色
    class func cl_rgbColor(red: CGFloat,
                        green: CGFloat,
                        blue: CGFloat) -> UIColor {
        
        let red = red / 255.0
        let green = green / 255.0
        let blue = blue / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    //随机颜色
    class func cl_randomColor () -> UIColor {
        let r = arc4random() % 255
        let g = arc4random() % 255
        let b = arc4random() % 255
        
        let red = CGFloat(r)/255.0
        let green = CGFloat(g)/255.0
        let blue = CGFloat(b)/255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    /// 使用十六进制数字生成颜色
    ///
    /// - Parameter hex: hex，格式 0xFFEEDD
    /// - Returns: UIColor
    class func cl_colorWithHex(hex:u_int) -> UIColor {
        
        let red:u_int = u_int((hex & 0xFF0000) >> 16)
        let green:u_int = u_int((hex & 0x00FF00) >> 8)
        let blue:u_int = (u_int(hex & 0x0000FF))
        return cl_rgbColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue))
    }
    
    /// 根据RGB值创建颜色
    class  func RGB(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat ,_ alpha:CGFloat = 1) -> UIColor {
        //处理数值
        if red > 255.0 || red < 0 || green > 255.0 || green < 0  || blue > 255.0 || blue < 0 || alpha > 1 || alpha < 0 {
            //颜色设置错误弹窗，可删除
            CLPRAlert.showAlert1((UIApplication.shared.keyWindow?.rootViewController)!, title: "颜色设置错误", message: nil, alertTitle: "确定", style: UIAlertActionStyle.cancel, confirmCallback: nil)
            return UIColor.white
        }else{
            return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
        }
    }
    
    
    
    /// 根据十六进制文字创建颜色
    class  func hexString(_ hexString:String,_ alpha:CGFloat = 1 ) -> UIColor {
        //处理数值
        var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let length = (cString as NSString).length
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){//错误处理
            return UIColor.white
        }
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        //字符串截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0 //存储转换后的数值
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
    
    
}

extension Int {
    
    var rgbColor: UIColor {
        return self.rgbColor(alpha: 1)
    }
    
    @available(iOS 10.0, *)
    var p3Color: UIColor {
        return self.p3Color(alpha: 1)
    }
    
    func rgbColor(alpha: CGFloat) -> UIColor {
        let red = CGFloat(self >> 16) / 255.0
        let green = CGFloat((self >> 8) & 0xFF) / 255.0
        let blue = CGFloat(self & 0xFF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    @available(iOS 10.0, *)
    func p3Color(alpha: CGFloat) -> UIColor {
        let red = CGFloat(self >> 16) / 255.0
        let green = CGFloat((self >> 8) & 0xFF) / 255.0
        let blue = CGFloat(self & 0xFF) / 255.0
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
    }
    
}




