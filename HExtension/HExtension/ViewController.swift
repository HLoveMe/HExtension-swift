//
//  ViewController.swift
//  HExtension
//
//  Created by space on 16/1/8.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit
class HHHHH:KeyValueModel{
    var name:String?
    var urls:[String]?
}


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var photos:[photo]?
    
    lazy var tableView:UITableView = {
        var tableView = UITableView.init(frame:self.view.bounds, style:.plain)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    lazy var titles:[String] = ["基本使用","嵌套（返回的json 数据包含其他Model）","序列化","自带请求网络数据","模型转为字典"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "HExtension"
        view.addSubview(tableView)
        print("\(person())")

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let ID:String = "ID"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: ID)
            
        }
        cell?.textLabel?.text = titles[(indexPath as NSIndexPath).row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = (indexPath as NSIndexPath).row
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
            self.navigationController?.pushViewController(fiveViewController(), animated: true)
            return
        }
        
    }
}

