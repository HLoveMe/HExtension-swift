//
//  twoViewcontroller.swift
//  HExtension
//
//  Created by space on 16/1/8.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class twoViewcontroller: UITableViewController {
    var dataArray:[person] = [person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let arr:[[String:Any]] = [[ //person
                                        "name":"ZZH" ,
                                        "address":"湖北",
                                         "aaa":["1231","1313"],
                                        "photos":[ //photo
                                            ["name":"photo1",
                                                "width":23,
                                                "height":24
                                            ]
                                            ,
                                            [ //photo
                                                "name":"photo2",
                                                "width":110,
                                                "height":120
                                            ]
                                        ]
                                        ]
                                        ,
                                        [  //person
                                            "name":"ZM",
                                            "address":"四川",
                                            "one":["name":"ZZH","width":100]
                                        ]
                                    ]

        
       dataArray = person.modelsWithArray(modelArray: arr as [[String : AnyObject]]) as! [person]
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let model = dataArray[(indexPath as NSIndexPath).row]
        var str = model.name! + model.address!
        if let _ = model.photos{
            str += "photo Name : " + (model.photos?.last?.name!)!
        }
        
        if let _ = model.one{
            str += "  onePhotoName:" + model.one!.name!
        }
        
        cell!.textLabel?.text = str
        return cell!
    }
    
    
}
