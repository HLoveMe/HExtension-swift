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
        let arr:[[String:AnyObject]] = [[ //person
                                        "name":"ZZH",
                                        "address":"湖北",
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

        
       dataArray = person.modelsWithArray(arr) as! [person]
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let model = dataArray[indexPath.row]
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
