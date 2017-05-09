//
//  ViewController.swift
//  Rush
//
//  Created by qingfeng hou on 2017/5/4.
//  Copyright © 2017年 letv. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var printScreen: UITextView!
    @IBOutlet weak var canculateBtn: UIButton!
    @IBOutlet weak var loseText: UITextField!
    @IBOutlet weak var balanceText: UITextField!
    
    @IBOutlet weak var winText: UITextField!
    @IBOutlet weak var oddsTableView: UITableView!
    var odds:[[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebSpider().getOdds { (result) in
            self.odds = result
            DispatchQueue.main.async {
                self.oddsTableView.reloadData()
            }
        }
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        let win = Double(winText.text!)
        let balance = Double(balanceText.text!)
        let lose = Double(loseText.text!)
        let textArray:[Double] = [win ?? 0.0, balance ?? 0.0, lose ?? 0.0]
        
        let test = Algorithem()
        let out:[String] = test.work(data: textArray)
        var str:String = ""
        out.forEach { (result) in
            str += result
        }
        
        printScreen.text = str
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.odds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        var str:String = String(indexPath.row)
        str += ".\t\t"
        for odd in self.odds[indexPath.row]{
            str += String(odd) + "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"
        }
        cell?.textLabel?.text = str
        str = ""
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let textArray:[UITextField] = [winText, balanceText, loseText]
        
        var index = 0
        for odd in self.odds[indexPath.row]{
            textArray[index].text = odd
            index += 1
        }
        
        let data = self.odds[indexPath.row].map { (result) -> Double in
            return Double(result)!
        }
        
        let test = Algorithem()
        let out:[String] = test.work(data: data)
        var str:String = ""
        out.forEach { (result) in
            str += result
        }
        
        printScreen.text = str
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
}

