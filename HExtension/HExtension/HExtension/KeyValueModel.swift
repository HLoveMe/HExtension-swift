//
//  KeyValueModel.swift
//  2_1IOS项目
//
//  Created by space on 15/12/29.
//  Copyright © 2015年 Space. All rights reserved.
/**  swift 版的赋值
    注意：已经实现了序列化  不要实现任何构造器
    1：对于Int Double  Float 不要使用可选值   如果使用为了使程序不崩溃   就不会赋值操作
     2：  func propertyNameInDictionary()->[String:String]?   返回 属性名和字典名不同的对应关系
*/
//

import Foundation
protocol modelPruotocol:NSObjectProtocol{
    /**之前的:之后的*/
    func propertyNameInDictionary()->[String:String]?
//    func classInArray()->[String:String]?
}
class KeyValueModel: NSObject ,NSCoding,modelPruotocol{
    /**得到反射*/
    
    lazy var mirror:Mirror =  Mirror(reflecting:self)
    
    required override init() {super.init()}
    func encodeWithCoder(aCoder: NSCoder) {
        for child  in mirror.children {
            let name  = child.label!
            let value = self.valueForKey(name)
            aCoder.encodeObject(value, forKey: name)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        for child  in mirror.children {
            let name  = child.label!
            let value = aDecoder.decodeObjectForKey(name)
            self.setValue(value, forKeyPath: name)
        }
        
    }
}
extension KeyValueModel{
    func properties(option:(messageInfo)->()){
        func enumerate(mir:Mirror){
            if  "\(mir.subjectType)" == "KeyValueModel"{return}
            let superMir = mir.superclassMirror()
            if let _ = superMir{
                enumerate(superMir!)
            }
            for one in  mir.children{
                let propertyName:String = one.label!
                let value = one.value
                let msg = messageInfo.init(name: propertyName, value: value)
                option(msg)
            }
        }
        enumerate(mirror)
        
    }
    /**返回一个新的对象*/
   private func modelWithDic(dic:[String:AnyObject])->KeyValueModel{
        return (self.dynamicType as  KeyValueModel.Type).modelWithDictionary(dic)
    }
    /**对象数组*/
   private func modelWithArray(array:[[String:AnyObject]])->[KeyValueModel]{
        return (self.dynamicType as  KeyValueModel.Type).modelsWithArray(array)
    }
}

extension KeyValueModel{
    /**字典数组得到 ------》模型*/
    class func modelsWithArray(modelArray:[[String:AnyObject]]) ->[KeyValueModel]{
        var models = [KeyValueModel]()
        for one in modelArray {
            let model = modelWithDictionary(one)
            models.append(model)
        }
        return models
    }
     /**字典------》模型*/
    class func modelWithDictionary( var  diction:[String:AnyObject]) ->Self{
        let model = self.init()
        /**得到[propertyName:key]*/
        let exchageDic = model.propertyNameInDictionary()
        func setValue(msg:messageInfo,dicProperName:String){
            if var value = diction[dicProperName] {
                if msg.isModelArray {
                    /**模型数组*/
                    if let className = msg.arrarModelName{
                        var arr = [AnyObject]()
                        let clazz = objc_getClass(className.getWholeClassName())
                        if let _ = clazz {
                            let oneModel = (clazz as! KeyValueModel.Type).init()
                            for one in (diction[dicProperName] as? [[String:AnyObject]]!)! {
                                arr.append(oneModel.modelWithDic(one))
                            }
                            model.setValue(arr , forKeyPath:msg.name)
                        }else{
                            /**如果是属性为  [String]   className== String 会报错*/
                            let kModel = ( NSClassFromString(className) as! KeyValueModel.Type).init()
                            for one in (diction[dicProperName] as? [[String:AnyObject]]!)! {
                                arr.append(kModel.modelWithDic(one))
                            }
                            model.setValue(arr , forKeyPath:msg.name)
                        }
                        model.setValue(arr , forKeyPath:msg.name)
                    }else{
                        model.setValue(value, forKeyPath:msg.name)
                    }
                }else{
                    /**普通属性*/
                    if(!msg.isFoundation){
                        var className = msg.valueType
                        className = className.getWholeClassName()
                        if value is [String:AnyObject]{
                            value =  (NSClassFromString(className)?.modelWithDictionary(value as! [String : AnyObject]))!
                        }
                    }
                    model.setValue(value, forKeyPath:msg.name)
                }
                
            }
        }
        
        /**便利所有属性*/
        model.properties { (msg:messageInfo) -> () in
            var dicPropertyName = msg.name
            if let name = exchageDic![msg.name] {dicPropertyName = name}
            if msg.isOptional{
                /**可选型*/
                if (msg.isBasicNumber){/**Int Double float 类型直接跳过 还没有解决*/}
                else{
                    setValue(msg, dicProperName: dicPropertyName)
                }
            }else{
                setValue(msg, dicProperName: dicPropertyName)
            }
        }
        return model
    }
}
extension KeyValueModel {
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
extension KeyValueModel{
    func propertyNameInDictionary() -> [String : String]? { return ["":""] }
}

