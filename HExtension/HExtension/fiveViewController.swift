//
//  fiveViewController.swift
//  HExtension
//
//  Created by 朱子豪 on 16/4/5.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class fiveViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         *  var name:String?
         var address:String?
         var aaa:[NSNumber]?
         var photos:[photo]?
         var one:photo?
         */
        let per = person()
        per.name  = "ZZH"
        per.address = "湖北仙桃"
        per.aaa = [NSNumber.init(value: 11 as Int),NSNumber.init(value: 11 as Int16)]
        
        let one = photo()
        one.name = "photo1"
        one.width = 10
        one.height = 10;
        per.one = one
        let dic = per.dictionary()
        
        
        let nums = dic["aaa"] as! [NSNumber]
        print("\(nums[0])")
        
    }
}
