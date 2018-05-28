//
//  CLLog.swift
//  TestDemo
//
//  Created by fuyongYU on 2018/5/28.
//  Copyright © 2018年 YeMaoZi. All rights reserved.
//

import UIKit

// MARK: - Log
class Log: NSObject,NSCoding {
    enum Level: String {
        case verbose
        case debug
        case info
        case warning
        case error
    }
    
    /// Print verbose log (white)
    ///
    /// - parameter log: log content string
    public class func v(_ log: Any?, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
        let info = formatInfo(fileName: fileName, function: function, lineNumber: lineNumber)
        self.addLog(log, info: info, level: Log.Level.verbose)
    }
    /// Print debug log (blue)
    ///
    /// - parameter log: log content string
    public class func d(_ log: Any?, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
        let info = formatInfo(fileName: fileName, function: function, lineNumber: lineNumber)
        self.addLog(log, info: info, level: Log.Level.debug)
    }
    /// Print info log (green)
    ///
    /// - parameter log: log content string
    public class func i(_ log: Any?, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
        let info = formatInfo(fileName: fileName, function: function, lineNumber: lineNumber)
        self.addLog(log, info: info, level: Log.Level.info)
    }
    /// Print warning log (yellow)
    ///
    /// - parameter log: log content string
    public class func w(_ log: Any?, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
        let info = formatInfo(fileName: fileName, function: function, lineNumber: lineNumber)
        self.addLog(log, info: info, level: Log.Level.warning)
    }
    /// Print error log (red)
    ///
    /// - parameter log: log content string
    public class func e(_ log: Any?, fileName: String = #file, function: String = #function, lineNumber: Int = #line) {
        let info = formatInfo(fileName: fileName, function: function, lineNumber: lineNumber)
        self.addLog(log, info: info, level: Log.Level.error)
    }
    
    /// Emoji mark of verbose logs, default is ✉️
    public var verboseMark: String = "✉️"
    
    /// Emoji mark of debug logs, default is 🌐
    public var debugMark: String = "🌐"
    
    /// Emoji mark of info logs, default is 📟
    public var infoMark: String = "📟"
    
    /// Emoji mark of warning logs, default is ⚠️
    public var warningMark: String = "⚠️"
    
    /// Emoji mark of error logs, default is ❌
    public var errorMark: String = "❌"
    
    private class func addLog(_ log: Any?, info: String, level: Log.Level) {
        let log = Log(info: info, log: log, level: level)
        print("\(log.mark(for: log.level))\(log.info)", log.log, separator: "", terminator: "\n")
    }
    
    fileprivate func mark(for level: Log.Level) -> String {
        switch level {
        case .verbose:  return verboseMark
        case .debug:    return debugMark
        case .info:     return infoMark
        case .warning:  return warningMark
        case .error:    return errorMark
        }
    }
    
    private class func formatInfo(fileName: String, function: String, lineNumber: Int) -> String {
        
        let className = (fileName as NSString).pathComponents.last!.replacingOccurrences(of: "swift", with: "")
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let date = fmt.string(from: Date())
        let text = date + " " + className + function + " [line " + String(lineNumber) + "]:\n"
        
        return text
    }
    
    var info: String
    var log: String
    var level: Log.Level
    init(info: String, log: Any?, level: Log.Level) {
        self.info = info
        self.level = level
        guard let log = log else {
            self.log = ""
            return
        }
        self.log = String.init(describing: log)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.info = aDecoder.decodeObject(forKey: "info") as! String
        self.log = aDecoder.decodeObject(forKey: "log") as! String
        let levelString = aDecoder.decodeObject(forKey: "level") as! String
        self.level = Level.init(rawValue: levelString)!
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.info, forKey: "info")
        aCoder.encode(self.log, forKey: "log")
        aCoder.encode(self.level.rawValue, forKey: "level")
    }
    
    
}
