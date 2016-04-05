//
//  constantBox.swift
//
//
//  Created by space on 15/12/21.
//  Copyright © 2015年 Space. All rights reserved.
//

import UIKit
/**Dictionary*/
extension Dictionary {
    /**得到所有键 数组*/
    func  allKeys() ->[Key]{
        var array = [Key]()
        var  gener = self.keys.generate()
        while let key = gener.next() {
            array.append(key)
        }
        return array;
    }
    /**遍历字典*/
    func enumerateKeysAndObjects(option:(Key,Value,Int)->()){
        let allK = self.allKeys()
        for i in 0  ..< allK.count  {
            let value = self[allK[i]]
            option(allK[i],value!,i)
        }
    }
}

extension Array{
    func enumerateKeysAndObjects(option:(Element,Int)->()){
        for i in 0  ..< self.count  {
            option(self[i],i)
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
    func getWholeClassName()->String{
        var ClassName = "\(NSBundle.mainBundle().infoDictionary!["CFBundleName"]!)"
        ClassName.appendContentsOf("." + self)
        return ClassName
    }
}