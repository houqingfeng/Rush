//
//  WebSpider.swift
//  Rush
//
//  Created by qingfeng hou on 2017/5/5.
//  Copyright © 2017年 letv. All rights reserved.
//

import Foundation
import FinalStepNetwork
import Moya
import Result
import Alamofire

struct WebHttpTarget:FSTargetType {
    
    public var cache: FSHttpCachePolicy{
        return .sysUseProtocolCachePolicy
    }
    
    public var baseURL: URL{
        return URL(string:self.setUrl)!
    }
    
    /// uesed cache data or not
    public var isUseCache: Bool{
        return false;
    }
    
    var headers: [String : Any]{
        return self.setHeaders
    }
    
    var timeout: Double{
        return 20.0
    }
    
    var returnMain: Bool{
        return self.setMain
    }
    
    public var path:String{
        return self.setPath
    }
    
    public var method: Moya.Method {
        get{ return self.setMethod }
    }
    
    public var parameters: [String: Any]? {
        return self.setPramaters
    }
    
    public var task: Task {
        return .request
    }
    
    public var sampleData: Data{
        return "Hello".data(using: String.Encoding.utf8)!
    }
    
    var setUrl:String
    var setPath:String
    var setHeaders:[String:Any]
    var setPramaters:[String:Any]
    var setMethod:Moya.Method
    var setMain:Bool = false
    
    init() {
        setUrl = ""
        setPath = ""
        setHeaders = [:]
        setPramaters = [:]
        setMethod = .get
    }
}

class WebSpider {
    typealias callback = ([[String]]) -> ()
    
    func requestWeb(callback:@escaping (String)->()){
        let client:FSHttpClient = FSHttpClient<WebHttpTarget>()
        var target:WebHttpTarget = WebHttpTarget()
        target.setUrl = "http://www.310win.com"
        target.setPath = "buy/jingcai.aspx"
        target.setPramaters["typeID"] = "105"
        target.setPramaters["oddstype"] = "2"
        target.setPramaters["date"] = DataItems.shared.date
        _ = client.requestWithTarget(target: target, successBlock: { (web:String?) in
            callback(web!)
        }) { (error) in
            callback(error.localizedDescription)
        }
    }
    
    func getOdds(back: @escaping callback){
        self.requestWeb { (web) in
            var result:[[String]] = []
            let pattern = "[0-9]\\.[0-9][0-9]|[0-9][0-9]\\.[0-9][0-9]";
            let regular = try! NSRegularExpression(pattern: pattern, options:.caseInsensitive)
            let results = regular.matches(in: web,
                                     options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                       range: NSRange(location: 0,
                                                      length  : web.characters.count))
            
            var index = 0
            let nstring:NSString = NSString(string: web)
            while(index < results.count){
                if index < 4{
                    index += 1
                    continue
                }
                
                var location = 0
                var singleOdds:[String] = []
                while (location < 3){
                    if(index >= results.count ){
                        break
                    }

                    let odds = String(nstring.substring(with: results[index].range))
                    singleOdds.append(odds!)
                    location += 1
                    index += 1
                }
                
                result.append(singleOdds)
            }
            
            back(result)
        }
    }
}
