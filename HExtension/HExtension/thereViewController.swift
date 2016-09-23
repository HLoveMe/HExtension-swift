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
    var data:Data?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func arch(_ sender: UIButton) {
        let dic = ["name":"ZZH","width":375,"height":667] as [String : Any]
        let img = photo.modelWithDictionary(diction: dic as [String : AnyObject])
        data = NSKeyedArchiver.archivedData(withRootObject: img)
    }
    
    @IBAction func unArch(_ sender: UIButton) {
        let img = NSKeyedUnarchiver.unarchiveObject(with: data!) as? photo
        let str = "\(img!.name)" + "\(img!.width)" + "\(img!.height)"
        lab.text = str
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
