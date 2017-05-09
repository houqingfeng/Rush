//
//  Algorithem.swift
//  Rush
//
//  Created by qingfeng hou on 2017/5/5.
//  Copyright © 2017年 letv. All rights reserved.
//

import Foundation

class Algorithem {
    
    var win3:Int = 0
    var win1:Int = 0
    var win0:Int = 0
    var balance3:Int = 0
    var balance1:Int = 0
    var balance0:Int = 0
    var lose3:Int = 0
    var lose1:Int = 0
    var lose0:Int = 0
    
    
    let db = Database()
    
    init() {
        self.db.open()
    }
    
    func work(data:[Double]) -> [String]{
        
        for index in 0...2{
            switch index {
            case 0:
                self.algorithem(raw: db.win,
                                waitValue: data[index],
                                predict3: &win3,
                                predict1: &win1,
                                predict0: &win0)
            case 1:
                self.algorithem(raw: db.balance,
                                waitValue: data[index],
                                predict3: &balance3,
                                predict1: &balance1,
                                predict0: &balance0)
            case 2:
                self.algorithem(raw: db.lose,
                                waitValue: data[index],
                                predict3: &lose3,
                                predict1: &lose1,
                                predict0: &lose0)
            default:
                break
            }
        }
        
        var sum = win3 + win1 + win0
        var odds:Double = Double(win3) / Double(sum) * 100.0
        
        let win3Str:String = String(format: "%.2f", data[0]) + "\t\t" + String(3) + "\t\t" + String(win3) + "\t\t" + String(sum) + "\t\t" + String(format: "%.2f", odds)  + "%\n"
        odds = Double(win1) / Double(sum) * 100.0
        let win1Str:String = String(format: "%.2f", data[0]) + "\t\t" + String(1) + "\t\t" + String(win1) + "\t\t" + String(sum) + "\t\t"  + String(format: "%.2f", odds) + "%\n"
        odds = Double(win0) / Double(sum) * 100.0
        let win0Str:String = String(format: "%.2f", data[0]) + "\t\t" + String(0) + "\t\t" + String(win0) + "\t\t" + String(sum) + "\t\t"  + String(format: "%.2f", odds) + "%\n\n"
        
        sum = balance3 + balance1 + balance0
        odds = Double(balance3) / Double(sum) * 100.0
        let balance3Str:String = String(format: "%.2f", data[1]) + "\t\t" + String(3) + "\t\t" + String(balance3) + "\t\t" + String(sum) + "\t\t"  + String(format: "%.2f", odds) + "%\n"
        odds = Double(balance1) / Double(sum) * 100.0
        let balance1Str:String = String(format: "%.2f", data[1]) + "\t\t" + String(1) + "\t\t" + String(balance1) + "\t\t" + String(sum) + "\t\t"  + String(format: "%.2f", odds) + "%\n"
        odds = Double(balance0) / Double(sum) * 100.0
        let balance0Str:String = String(format: "%.2f", data[1]) + "\t\t" + String(0) + "\t\t" + String(balance0) + "\t\t" + String(sum) + "\t\t"  + String(format: "%.2f", odds) + "%\n\n"
        
        sum = lose3 + lose1 + lose0
        odds = Double(lose3) / Double(sum) * 100.0
        let lose3Str:String = String(format: "%.2f", data[2]) + "\t\t" + String(3) + "\t\t" + String(lose3) + "\t\t" + String(sum) + "\t\t"  + String(format: "%.2f", odds) + "%\n"
        odds = Double(lose1) / Double(sum) * 100.0
        let lose1Str:String = String(format: "%.2f", data[2]) + "\t\t" + String(1) + "\t\t" + String(lose1) + "\t\t" + String(sum) + "\t\t"  + String(format: "%.2f", odds) + "%\n"
        odds = Double(lose0) / Double(sum) * 100.0
        let lose0Str:String = String(format: "%.2f", data[2]) + "\t\t" + String(0) + "\t\t" + String(lose0) + "\t\t" + String(sum) + "\t\t"  + String(format: "%.2f", odds) + "%\n\n"
        
        sum += balance3 + balance1 + balance0 + win3 + win1 + win0
        let sum3 = win3 + balance3 + lose3
        let sum1 = win1 + balance1 + lose1
        let sum0 = win0 + balance0 + lose0
        
        odds = Double(sum3) / Double(sum) * 100.0
        let sum3Str:String = String(3) + "\t\t" + String(format: "%.2f", odds) + "%\n"
        odds = Double(sum1) / Double(sum) * 100.0
        let sum1Str:String = String(1) + "\t\t" + String(format: "%.2f", odds) + "%\n"
        odds = Double(sum0) / Double(sum) * 100.0
        let sum0Str:String = String(0) + "\t\t" + String(format: "%.2f", odds) + "%\n"

        
        return [win3Str, win1Str, win0Str, balance3Str, balance1Str, balance0Str, lose3Str, lose1Str, lose0Str, sum3Str, sum1Str, sum0Str]
    }
    
    
    
    private func getOut(data:Int, array:[Int]) -> Int{
        for i in 0..<array.count{
            if array[i] == data{
                if i == 0{
                    return 3
                } else if i == 1 {
                    return 1
                } else {
                    return 0
                }
            }
        }
        return 0
    }
    
    func algorithem(raw:[Double],
                    waitValue:Double,
                    predict3:inout Int,
                    predict1:inout Int,
                    predict0:inout Int) {
        
        for index in 0..<raw.count {
            if raw[index] == waitValue {
                switch self.db.outcome[index] {
                case 0:
                    predict0 += 1
                case 1:
                    predict1 += 1
                case 3:
                    predict3 += 1
                default:
                    break
                }
            }
        }
    }
}
