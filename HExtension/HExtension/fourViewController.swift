//
//  fourViewController.swift
//  HExtension
//
//  Created by space on 16/1/8.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class fourViewController: UITableViewController {
    lazy var dataArr:[focusimg] = [focusimg]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt0-p1-s30-l0.json"
        
        /**使用自带网络请求*/
        
        focusimg.GETModelsWithUrl(urlStr, option: { (diction) -> AnyObject in
            let result=diction["result"] as! NSDictionary
            return result["focusimg"]!
            }) { (models) -> () in
            self.dataArr = models as! [focusimg]
            self.tableView.reloadData()
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return  self.dataArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let ID:String = "ID"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: ID)
            
        }
        let model =  self.dataArr[indexPath.row] as focusimg
        cell!.textLabel!.text = "\(model.title!)"
        return cell!
    }

}
