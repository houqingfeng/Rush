//
//  Foundation.swift
//  Rush
//
//  Created by qingfeng hou on 2017/5/5.
//  Copyright © 2017年 letv. All rights reserved.
//

import Foundation

extension DateFormatter {
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat =  dateFormat
    }
}

extension NSDate {
    public struct Formatter {
        static let custom = DateFormatter(dateFormat: "yyyy-M-dd")
    }
    
    public var customFormatted: String {
        return Formatter.custom.string(from: self as Date)
    }
}
