//
//  CLInterest.swift
//  TestDemo
//
//  Created by fuyongYU on 2018/5/22.
//  Copyright © 2018年 YeMaoZi. All rights reserved.
//

import UIKit

class CLInterest: NSObject {
    
    var age : NSInteger = 0
    
    /// 单例的写法，其实就是一个静态闭包立即执行的结果
    static let shared : CLInterest = {
       let shared = CLInterest()
        return shared
    }()
    
    
}
