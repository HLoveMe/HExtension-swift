//
//  ViewController.swift
//  HExtension
//
//  Created by space on 16/1/8.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var photos:[photo]?
    
    lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame:self.view.bounds, style:.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    lazy var titles:[String] = ["基本使用","嵌套（返回的json 数据包含其他Model）","序列化","自带请求网络数据"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HExtension"
        view.addSubview(tableView)
               
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return titles.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let ID:String = "ID"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: ID)
            
        }
        cell?.textLabel?.text = titles[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row
        switch index {
        case 0:
            self.navigationController?.pushViewController(oneViewController(), animated: true)
            return
        case 1:
            self.navigationController?.pushViewController(twoViewcontroller(), animated: true)

            return
        case 2:
            self.navigationController?.pushViewController(thereViewController(), animated: true)
            return
        case 3:
             self.navigationController?.pushViewController(fourViewController(), animated: true)
            return
        default:
            return
        }
        
    }
}

