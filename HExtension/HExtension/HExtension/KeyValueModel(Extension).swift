
//
//  KeyValueModel(Extendion).swift
//  HExtension
//
//  Created by 朱子豪 on 16/4/1.
//  Copyright © 2016年 Space. All rights reserved.
//

import Foundation
extension KeyValueModel {
    /**
      实现默认代理
     - returns:
     */
     func propertyNameInDictionary() -> [String : String]? { return ["":""] }

    /**
     GET直接网络请求
     - parameter urlString:  网址
     - parameter option:     网络返回必须是字典数据  给用户  option   返回 （字典或者数组）
     - parameter complement: 得到模型数据（主线程）
     */
    class func GETModelsWithUrl(urlString:String,option:([String:AnyObject])->AnyObject,complement:([KeyValueModel]?)->()){
        let url = NSURL.init(string: urlString)
        if let _ = url {
            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, _, _) -> Void in
                var dic:Dictionary<String,AnyObject>? = nil
                do{
                    dic = (try NSJSONSerialization.JSONObjectWithData(data!, options: [.AllowFragments,.MutableContainers])) as? Dictionary<String,AnyObject>
                }catch{print("\(error)");complement(nil)}
                let values = option(dic!)
                if "\(Mirror(reflecting: values).subjectType)".containsString("Array"){
                    var arr:[KeyValueModel] = [KeyValueModel]()
                    let valueArr = values as! [[String:AnyObject]]
                    for one in valueArr {
                        let model = self.modelWithDictionary(one)
                        arr.append(model)
                    }
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        complement(arr)
                    })
                    
                }else if("\(Mirror(reflecting: values).subjectType)".containsString("Dictionary")){
                    let model = self.modelWithDictionary(values as! [String : AnyObject])
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        complement([model])
                    })
                }else{
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        complement([])
                    })
                }
            }).resume()
        }
    }
    /**
     POST直接网络请求
     - parameter urlString:  网址
     - parameter option:     网络返回必须是字典数据  给用户  option   返回 （字典或者数组）
     - parameter complement: 得到模型数据(在主线程)
     */
    class func POSTModelsWithUrl(urlString:String,argumentDic:[String:String],option:([String:AnyObject])->AnyObject,complement:(([KeyValueModel]?)->())){
        var body:String = ""
        argumentDic.enumerateKeysAndObjects { (key, Value, index) -> () in
            if(index == argumentDic.count - 1 ){
                body  +=  (key + "=" + Value)
            }else{
                body += (key + "=" + Value + "&")
            }
        }
        
        body = body.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.controlCharacterSet())!
        
        
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest.init(URL: url!)
        request.HTTPMethod = "POST"
        request.timeoutInterval = 20
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, _, _) -> Void in
            var dic:Dictionary<String,AnyObject>? = nil
            do{
                dic = (try NSJSONSerialization.JSONObjectWithData(data!, options: [.AllowFragments,.MutableContainers])) as? Dictionary<String,AnyObject>
            }catch{print("\(error)");complement(nil)}
            let values = option(dic!)
            if "\(Mirror(reflecting: values).subjectType)".containsString("Array"){
                var arr:[KeyValueModel] = [KeyValueModel]()
                let valueArr = values as! [[String:AnyObject]]
                for one in valueArr {
                    let model = self.modelWithDictionary(one)
                    arr.append(model)
                }
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    complement(arr)
                })
                
            }else if("\(Mirror(reflecting: values).subjectType)".containsString("Dictionary")){
                let model = self.modelWithDictionary(values as! [String : AnyObject])
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    complement([model])
                })
            }else{
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    complement([])
                })
            }
            }.resume()
        
    }
}