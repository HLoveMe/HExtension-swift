//
//  thereViewController.swift
//  HExtension
//
//  Created by space on 16/1/8.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class thereViewController: UIViewController {

    @IBOutlet var lab: UILabel!
    var data:NSData?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func arch(sender: UIButton) {
        let dic = ["name":"ZZH","width":375,"height":667]
        let img = photo.modelWithDictionary(dic)
        data = NSKeyedArchiver.archivedDataWithRootObject(img)
    }
    
    @IBAction func unArch(sender: UIButton) {
        let img = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as? photo
        let str = "\(img!.name)" + "\(img!.width)" + "\(img!.height)"
        lab.text = str
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
