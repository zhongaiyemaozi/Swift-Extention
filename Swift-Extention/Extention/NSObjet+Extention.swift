//
//  CLNSObjet+Extention.swift
//  TestDemo
//
//  Created by fuyongYU on 2018/5/28.
//  Copyright © 2018年 YeMaoZi. All rights reserved.
//

import UIKit

extension NSObject {
    
    static var className: String {
        get {
            return String(describing: self)
        }
    }
    
}

