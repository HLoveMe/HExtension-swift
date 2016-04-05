//
//  messageInfo.swift
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
    var isArray:Bool = false;
    var isModelArray:Bool = false      //是否是模型数组
    var arrarModelName:String!  //数组里面类的名字
    var isBasicNumber:Bool = false      ///**暂时还没解决Int? Double? 等等基本数字类型可选型的问题*/
    var isFoundation:Bool = true   //如果是类 是否为系统类
    private lazy var basicNumber:[String] = {["Int","Double","Float","CGFloat","long"]}()
    init(name:String,value:Any){
        self.name = name
        self.value = value
        let a = Mirror(reflecting: value)
        self.valueType = "\(a.subjectType)".getTypeName()
        self.isArray = self.valueType.containsString("Array")
        if self.isArray {
             self.arrarModelName = "\(a.subjectType)".getClassName()
            let flag = NSClassFromString(self.arrarModelName.getWholeClassName())?.isSubclassOfClass(KeyValueModel.self)
            if let _ = flag {
                self.isModelArray = true
            }
        }else{
            let one = NSClassFromString("\(self.valueType)".getWholeClassName())
            if let _ = one{
                if one!.isSubclassOfClass(KeyValueModel.self){
                    self.isFoundation = false
                }
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
