//
//  messageInfo.swift
//  2_1IOS项目
//
//  Created by space on 15/12/30.
//  Copyright © 2015年 Space. All rights reserved.
//

    /**对一个属性的封装 */
    //   var  XXOO:String

import Foundation
class messageInfo {
    var name:String            //XXOO
    var value:Any              //nil        (nil)
    var valueType:String       //String
    var isOptional:Bool = false
    var isModelArray:Bool       //是否是模型数组
    var arrarModelName:String!  //数组里面类的名字
    var isBasicNumber:Bool = false      ///**暂时还没解决Int? Double? 等等基本数字类型可选型的问题*/
    lazy var basicNumber:[String] = {["Int","Double","Float"]}()
    init(name:String,value:Any){
        self.name = name
        self.value = value
        let a = Mirror(reflecting: value)
        self.valueType = "\(a.subjectType)".getTypeName()
        self.isModelArray = self.valueType.containsString("Array")
        if self.isModelArray {
            self.arrarModelName = "\(a.subjectType)".getClassName()
            let FoundationClassName = ["string","nsurl","int","double","float"]
            if FoundationClassName.contains(self.arrarModelName.lowercaseString){
                self.isModelArray = false
            }
        }
        self.isBasicNumber = isBasicNumber(valueType)
        if !self.isBasicNumber {self.isOptional = a.isOptional()}
    }
    func isBasicNumber(proName:String)->Bool{
        return basicNumber.contains { (one) -> Bool in
            return one.containsString(proName)
        }
    }
    
}
extension Mirror{
    func isOptional()->Bool{
        switch self.displayStyle! {
        case Mirror.DisplayStyle.Optional:
            return true
        default:
            return false
        }
    }
}
extension String{
    func getTypeName()->String{
        let a = self as  NSString
        let range = a.rangeOfString("Optional<")
        if range.length == 0 {return self}
        let b = a.substringFromIndex(range.location + range.length) as NSString
        return b.substringToIndex(b.length-1)
    }
    func getClassName() ->String{
         ////Optional<Array<photo>>  ---->photo
        var name = self.substringFromIndex(self.startIndex.advancedBy(15))
        name = name.substringToIndex(name.endIndex.advancedBy(-2))
        return name
    }
}