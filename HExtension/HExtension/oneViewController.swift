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
        let url = URL(string: "http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm1-c0-nt0-p1-s30-l1.json")
          URLSession.shared.dataTask(with: url!, completionHandler: { (data, _, _) -> Void in
            var dic:[String:AnyObject]? = nil
            do{
               dic = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : AnyObject]
            }catch{
                print("\(error)")
            }
            let  result = dic!["result"] as! NSDictionary
            let  dicArray = result["newslist"] as! NSArray
            
            
/**解析*/
            self.dataArray = newsModel.modelsWithArray(modelArray: dicArray as! [[String : AnyObject]]) as! [newsModel]
            DispatchQueue.main.sync(execute: { () -> Void in
                  self.tableView.reloadData()
            })
          
        }) .resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID:String = "ID"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: ID)
            
        }
        cell!.textLabel?.text = dataArray[(indexPath as NSIndexPath).row].title
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let one = self.dataArray[(indexPath as NSIndexPath).row]
        let dic = one.dictionary()
        print(dic);
    }
}
