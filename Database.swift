//
//  Database.swift
//  Rush
//
//  Created by qingfeng hou on 2017/5/5.
//  Copyright © 2017年 letv. All rights reserved.
//

import Foundation
import FinalStepDatabase
import SQLite

class Database {
    var db:FSDatabase? = nil
    var win:[Double] = []
    var balance:[Double] = []
    var lose:[Double] = []
    var outcome:[Int64] = []
    
    
    func createDB() {
        let path = NSHomeDirectory() + "/Documents"
        print(path)
    }
    
    func open(){
        let docsurl = try! FileManager.default.url(for:.documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false)
        
        let myurl = docsurl.appendingPathComponent("data.db")
        let index = myurl.absoluteString.index(myurl.absoluteString.startIndex, offsetBy: 7)
        let subStr = myurl.absoluteString.substring(from: index)
        
        let app = NSURL(fileURLWithPath: Bundle.main.resourcePath!).appendingPathComponent("data.db")
        do{
            if !FileManager.default.fileExists(atPath: subStr){
                try FileManager.default.copyItem(at: app!, to: myurl)
            }
        } catch{
            print(error)
        }
        
        do{
            self.db = try FSDatabase(subStr)
        } catch{
            print(error)
        }
        
        do{
            let data = try self.db?.executeQuery("select * from RawData")
            if data != nil {
                for item in data!{
                    self.win.append(item["win"] as! Double)
                    self.balance.append(item["balance"] as! Double)
                    self.lose.append(item["lose"] as! Double)
                    self.outcome.append(item["outcome"] as! Int64)
                }
            }
        } catch{
            print(error)
        }
    }
}
