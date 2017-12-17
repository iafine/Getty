//
//  ListAlertView.swift
//  Getty
//
//  Created by Hyyy on 2017/12/15.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

class ListAlertView: UIView {

    let tableView: UITableView = {
        
        let tableView = UITableView (frame: CGRect.zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    let titleLabel: UILabel = {
        
        let label = UILabel (frame: CGRect (x: 0,
                                            y: 0,
                                            width: Constant.Size.kScreenWidth,
                                            height: 35))
        label.textAlignment = .center
        label.font = Constant.Font.kFontSmall
        label.textColor = Constant.Color.kTitleColor
        label.text = "请选择持续次数"
        
        return label
    }()
    
    let titleArray: NSArray = ["15次", "30次", "60次", "90次"]

    
    init() {
        super.init(frame: Constant.Size.kScreenBounds)
        
        backgroundColor = UIColor (red: 0, green: 0, blue: 0, alpha: 0)
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = titleLabel

        let tableViewFrame = CGRect (x: 0,
                                     y: Constant.Size.kScreenHeight,
                                     width: Constant.Size.kScreenWidth,
                                     height: CGFloat(titleArray.count * 50 + 35))
        tableView.frame = tableViewFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.backgroundColor = UIColor (red: 0, green: 0, blue: 0, alpha: 0.3)
            self.tableView.frame = CGRect (x: 0,
                                           y: (Constant.Size.kScreenHeight - self.tableView.frame.height),
                                           width: Constant.Size.kScreenWidth,
                                           height: self.tableView.frame.height)
        }) { (finished) in
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.tableView.frame = CGRect (x: 0,
                                           y: Constant.Size.kScreenHeight,
                                           width: Constant.Size.kScreenWidth,
                                           height: self.tableView.frame.height)
            self.backgroundColor = UIColor (red: 0, green: 0, blue: 0, alpha: 0)
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
}

extension ListAlertView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView (frame: CGRect (x: 0, y: 0, width: Constant.Size.kScreenWidth, height: 10))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        dismiss()
    }
}

extension ListAlertView: UITableViewDataSource {
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "ListAlertViewCell")
        if (cell == nil) {
            cell = UITableViewCell (style: .default, reuseIdentifier: "ListAlertViewCell")
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.font = Constant.Font.kFontMedium
            cell?.textLabel?.textColor = Constant.Color.kTitleColor
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.text = titleArray.object(at: indexPath.row) as? String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return []
    }
}
