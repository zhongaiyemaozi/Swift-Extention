//
//  CLGlobalCommon.swift
//  TestDemo
//
//  Created by fuyongYU on 2018/5/21.
//  Copyright © 2018年 fuyongYU. All rights reserved.
//

import UIKit

// MARK: - 第三方头文件



// MARK: - 大小类
let CLSCREE_BOUNDS = UIScreen.main.bounds
let CLSCREE_WIDYH = UIScreen.main.bounds.width
let CLSCREE_HEIGHT = UIScreen.main.bounds.height
let CLSCREE_SCALE = UIScreen.main.scale


/// 根据不同机型尺寸的宽度
///
/// - Parameter width: 宽度
/// - Returns: 对应机型尺寸的宽度
func KScaleWidth(width : CGFloat) -> CGFloat {
    
    return (CLSCREE_WIDYH / 375.0) * width
    
}


/// 根据不同机型尺寸的高度
///
/// - Parameter height: 高度
/// - Returns: 对应机型的高度
func KScaleHeight(height : CGFloat) -> CGFloat {
    return (CLSCREE_HEIGHT / 667.0) * height
}


// MARK: - 判断机型
let isIphoneX = UIScreen.main.bounds.width / UIScreen.main.bounds.height < 375.0 / 667.0

/// 与导航栏对下方对齐
let CLTopLayoutGuide = UIApplication.shared.statusBarFrame.size.height + UINavigationController().navigationBar.frame.height


/// 与导航栏上方对齐
let CLBottomLayoutGuide : CGFloat = {
    if isIphoneX {
        return 83
    }else {
        return UITabBarController().tabBar.frame.size.height
    }
}()









