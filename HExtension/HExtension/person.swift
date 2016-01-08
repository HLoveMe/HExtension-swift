//
//  person.swift
//  HExtension
//
//  Created by space on 16/1/8.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class person: KeyValueModel {
    var name:String?
    var address:String?
    var photos:[photo]?
}
class photo:KeyValueModel{
    var name:String?
    var width:CGFloat = 0
    var height:CGFloat = 0
}