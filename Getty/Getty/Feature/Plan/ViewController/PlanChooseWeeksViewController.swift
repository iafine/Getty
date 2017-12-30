//
//  ChooseNotificationTimeViewController.swift
//  Getty
//
//  Created by Hyyy on 2017/12/16.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

struct WeekStruct {
    var title: String
    var value: String
}

class PlanChooseWeeksViewController: UIViewController {

    let tableView: UITableView = {
        
        let tableView = UITableView (frame: CGRect (x: 0,
                                                    y: 64,
                                                    width: Constant.Size.kScreenWidth,
                                                    height: Constant.Size.kScreenHeight - 64),
                                     style: .grouped)
        tableView.separatorColor = Constant.Color.kTableBackgroundColor
        tableView.backgroundColor = Constant.Color.kTableBackgroundColor
        
        return tableView
    }()
    
    var dataArray: NSMutableArray = NSMutableArray()
    
    let titleArray: NSArray = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"]
    
    var valueArray: NSArray = NSArray()
    
    var weeksString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "选择时间"
        
        // 组织数据
        valueArray = weeksString.components(separatedBy: ",") as NSArray
        for index in 0...6 {
            let title = titleArray.object(at: index) as! String
            let value = valueArray.object(at: index) as! String
            let weekStruct = WeekStruct(title: title, value: value)
            self.dataArray.add(weekStruct)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
    }
}

extension PlanChooseWeeksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView (frame: CGRect (x: 0, y: 0, width: Constant.Size.kScreenWidth, height: 10))
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var weekStruct: WeekStruct = dataArray.object(at: indexPath.row) as! WeekStruct
        if weekStruct.value.count == 0 {
            weekStruct.value = weekStruct.title
        } else {
            weekStruct.value = ""
        }
        dataArray.replaceObject(at: indexPath.row, with: weekStruct)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension PlanChooseWeeksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ChooseNotificationTimeCell")
        if (cell == nil) {
            cell = UITableViewCell (style: .default, reuseIdentifier: "ChooseNotificationTimeCell")
            cell?.textLabel?.font = Constant.Font.kFontSmall
            cell?.textLabel?.textColor = Constant.Color.kTitleColor
        }
        
        let weekStruct: WeekStruct = dataArray.object(at: indexPath.row) as! WeekStruct
        cell?.textLabel?.text = weekStruct.title
        if weekStruct.value.count == 0 {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
        
        return cell!
    }
}

