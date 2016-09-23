
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
    class func GETModelsWithUrl(urlString:String,option:@escaping ([String:AnyObject])->AnyObject,complement:@escaping ([KeyValueModel]?)->()){
        let url = NSURL.init(string: urlString)
        if let _ = url {
            URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, _, _) -> Void in
                var dic:Dictionary<String,AnyObject>? = nil
                do{
                    dic = (try JSONSerialization.jsonObject(with: data!, options: [.allowFragments,.mutableContainers])) as? Dictionary<String,AnyObject>
                }catch{print("\(error)");complement(nil)}
                let values = option(dic!)
                if "\(Mirror.init(reflecting: values).subjectType)".contains("Array"){
                    var arr:[KeyValueModel] = [KeyValueModel]()
                    let valueArr = values as! [[String:AnyObject]]
                    for one in valueArr {
                        let model = self.modelWithDictionary(diction: one)
                        arr.append(model)
                    }

                    DispatchQueue.main.sync(execute: { () -> Void in
                        complement(arr)
                    })
                    
                }else if("\(Mirror.init(reflecting: values).subjectType)".contains("Dictionary")){
                    let model = self.modelWithDictionary(diction: values as! [String : AnyObject])
                    DispatchQueue.main.sync(execute: { () -> Void in
                        complement([model])
                    })
                }else{
                    DispatchQueue.main.sync(execute: { () -> Void in
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
    class func POSTModelsWithUrl(urlString:String,argumentDic:[String:String],option:@escaping ([String:AnyObject])->AnyObject,complement:@escaping (([KeyValueModel]?)->())){
        var body:String = ""
        argumentDic.enumerateKeysAndObjects { (key, Value, index) -> () in
            if(index == argumentDic.count - 1 ){
                body  +=  (key + "=" + Value)
            }else{
                body += (key + "=" + Value + "&")
            }
        }
        
        body=body.addingPercentEncoding(withAllowedCharacters: CharacterSet.controlCharacters)!
        
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest.init(url: url! as URL)
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, _, _) -> Void in
            var dic:Dictionary<String,AnyObject>? = nil
            do{
                dic = (try JSONSerialization.jsonObject(with: data!, options: [.allowFragments,.mutableContainers])) as? Dictionary<String,AnyObject>
            }catch{print("\(error)");complement(nil)}
            let values = option(dic!)
            if "\(Mirror.init(reflecting: values).subjectType)".contains("Array"){
                var arr:[KeyValueModel] = [KeyValueModel]()
                let valueArr = values as! [[String:AnyObject]]
                for one in valueArr {
                    let model = self.modelWithDictionary(diction: one)
                    arr.append(model)
                }
                DispatchQueue.main.sync(execute: { () -> Void in
                    complement(arr)
                })
                
                
            }else if("\(Mirror.init(reflecting: values).subjectType)".contains("Dictionary")){
                let model = self.modelWithDictionary(diction: values as! [String : AnyObject])
                DispatchQueue.main.sync(execute: { () -> Void in
                    complement([model])
                })
            }else{
                DispatchQueue.main.sync(execute: { () -> Void in
                    complement([])
                })
            }
            }.resume()
        
    }
}
