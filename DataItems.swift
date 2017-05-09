//
//  DataItems.swift
//  Rush
//
//  Created by qingfeng hou on 2017/5/5.
//  Copyright © 2017年 letv. All rights reserved.
//

import Foundation

class DataItems{
    private static let data = DataItems()
    static var shared:DataItems{
        return .data
    }
    
    var spiderUrl = "http://www.310win.com/buy/jingcai.aspx?typeID=105&oddstype=2&date="
    var date = NSDate().customFormatted
    
    private init(){
    }
}
