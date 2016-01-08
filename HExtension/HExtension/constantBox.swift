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
        for var i = 0 ; i < allK.count ; i++ {
            let value = self[allK[i]]
            option(allK[i],value!,i)
        }
    }
}
