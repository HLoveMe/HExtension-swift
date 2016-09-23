//
//  newsModel.swift
//  HExtension
//
//  Created by space on 16/1/8.
//  Copyright © 2016年 Space. All rights reserved.
//

class newsModel: KeyValueModel {
    var ID:Int = 0
    var title:String?
    var mediatype:Int = 0
    var type:String?
    var time:String?
    var indexdetail:String?
    var smallpic:String?
    var replycount:Int = 0
    var pagecount:Int = 0
    var jumppage:Int = 0
    var lasttime:String?
    var updatetime:String?
    var coverimages:[String]?
    var newstype:Int = 0
    var urls:[String]?
    var imgUrls:[String]? {
        get{
            if self.urls != nil {
                
            }else{
                let range =  indexdetail!.range(of: "http://")
                let str = indexdetail!.substring(from: (range?.lowerBound)!)
                self.urls = str.components(separatedBy: ",")
            }
            return urls
        }
        
    }
    
    override func propertyNameInDictionary() -> [String : String]? {
        return ["ID":"id"]
    }
    
}
