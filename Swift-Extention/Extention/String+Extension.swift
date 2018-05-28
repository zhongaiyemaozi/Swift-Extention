//
//  CLString+String.swift
//  TestDemo
//
//  Created by fuyongYU on 2018/5/28.
//  Copyright © 2018年 YeMaoZi. All rights reserved.
//

import UIKit

extension String {
    
    static func convert(fromJSON object: Any) -> String? {
        if JSONSerialization.isValidJSONObject(object) {
            if let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
                return String.init(data: data, encoding: .utf8)
            }
        }
        return nil
    }
    
    var length: Int {
        get {
            return self.count
        }
    }
    
    var firstPinyinLetter: String {
        get {
            return self.toPinyin().substring(to: 1)
        }
    }
    
    func toPinyin() -> String {
        let str = NSMutableString(string: self)
        CFStringTransform(str as CFMutableString, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(str as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        let pinyin = str.capitalized
        return pinyin
    }
    
    var base64EncodedString: String? {
        get {
            let data = self.data(using: .utf8)
            return data?.base64EncodedString()
        }
    }
    
    var base64DecodedString: String? {
        get {
            if let data = Data(base64Encoded: self) {
                return String(data: data, encoding: .utf8)
            }
            return nil
        }
    }
    
    func toJsonObject() -> Any? {
        if let data = self.data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        }
        return nil
    }
    
    func substring(from: Int) -> String {
        return self.substring(from: from, length: self.length - from)
    }
    
    func substring(to: Int) -> String {
        return self.substring(from: 0, length: to)
    }
    
    func substring(with range: NSRange) -> String {
        return self.substring(from: range.location, length: range.length)
    }
    
    func substring(from: Int, length: Int) -> String {
        let str = self as NSString
        var from = from
        if from < 0 {
            from = 0
        } else if from >= self.length {
            from = self.length - 1
        }
        var length = length
        if from + length > self.length {
            length = self.length - from
        }
        return str.substring(with: NSMakeRange(from, length))
    }
    
    func matches(_ regularExpression: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: self)
    }
    
    func boundingRect(with size: CGSize,
                      options: NSStringDrawingOptions,
                      attributes: [NSAttributedStringKey: Any]?,
                      context: NSStringDrawingContext?) -> CGRect {
        let str = self as NSString
        return str.boundingRect(with: size,
                                options: options,
                                attributes: attributes,
                                context: context)
    }
    
}

