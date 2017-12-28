//
//  ChooseNotificationTimeViewController.swift
//  Getty
//
//  Created by Hyyy on 2017/12/16.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

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
    
    let titleArray: NSArray = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
    
    let selectedArray: NSMutableArray = [1, 0, 1, 0, 1, 0, 1]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "选择时间"
        
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
        
        let selectedValue = selectedArray.object(at: indexPath.row) as? Int
        if (selectedValue == 0) {
            selectedArray.replaceObject(at: indexPath.row, with: 1)
        } else {
            selectedArray.replaceObject(at: indexPath.row, with: 0)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension PlanChooseWeeksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
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
        cell?.textLabel?.text = titleArray.object(at: indexPath.row) as? String
        
        let selectedValue = selectedArray.object(at: indexPath.row) as? Int
        if (selectedValue == 0) {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
        
        return cell!
    }
}

