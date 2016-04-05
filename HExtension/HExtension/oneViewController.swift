//
//  oneViewController.swift
//  HExtension
//
//  Created by space on 16/1/8.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class oneViewController: UITableViewController {
    var dataArray:[newsModel] = [newsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt0-p1-s30-l1.json")
          NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, _, _) -> Void in
            var dic:[String:AnyObject]? = nil
            do{
               dic = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String : AnyObject]
            }catch{
                print("\(error)")
            }
            let  result = dic!["result"] as! NSDictionary
            let  dicArray = result["newslist"] as! NSArray
            
            
/**解析*/
            self.dataArray = newsModel.modelsWithArray(dicArray as! [[String : AnyObject]]) as! [newsModel]
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                  self.tableView.reloadData()
            })
          
        }.resume()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID:String = "ID"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: ID)
            
        }
        cell!.textLabel?.text = dataArray[indexPath.row].title
        
        return cell!
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let one = self.dataArray[indexPath.row]
        let dic = one.dictionary()
        print(dic);
    }
}
