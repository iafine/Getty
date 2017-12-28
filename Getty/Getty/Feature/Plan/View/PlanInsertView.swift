//
//  InsertPlanView.swift
//  Getty
//
//  Created by Hyyy on 2017/12/13.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

protocol InsertPlanViewDelegate: class {
    
    /// 选中cell事件
    func handleSelectedRow(indexPath: IndexPath)
    
    /// 标题修改事件
    func handlePlanNameDidSelected(planName: String)
    
}

class PlanInsertView: UIView {

    let tableView: UITableView = {
        
        let tableView = UITableView (frame: CGRect.zero, style: .grouped)
        tableView.separatorColor = Constant.Color.kTableBackgroundColor
        tableView.backgroundColor = Constant.Color.kTableBackgroundColor
        
        return tableView
    }()
    
    weak var delegate: InsertPlanViewDelegate?
    
    let titleArray: NSArray = ["计划标题", "开始时间", "结束时间", "持续次数", "提醒选项(默认每天提醒，点击修改 )"]
    
    var insertPlan: Plan = Plan()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        addSubview(tableView)
        
        initSubViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViewLayout() {
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func reloadData(plan: Plan) {
        insertPlan = plan
        tableView.reloadData()
    }
}

extension PlanInsertView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView (frame: CGRect (x: 0, y: 0, width: Constant.Size.kScreenWidth, height: 44))

        let headerLabel = UILabel (frame: CGRect (x: 20, y: 15, width: Constant.Size.kScreenWidth - 40, height: 20))
        headerLabel.textColor = Constant.Color.kDescColor
        headerLabel.font = Constant.Font.kFontTiny
        headerLabel.text = titleArray.object(at: section) as? String

        headerView.addSubview(headerLabel)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.handleSelectedRow(indexPath: indexPath)
    }
}

extension PlanInsertView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PlanInsertCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellStyle: InsertPlanCellStyle = indexPath.section == 0 ? .edit : .label
        let cell = PlanInsertCell.cellWithTableView(tableView: tableView, style: cellStyle)
        
        switch indexPath.section {
        case 0:
            cell.textField.addTarget(self, action: #selector(textFieldDidChanged(textField:)), for: .editingChanged)
            if self.insertPlan.planName.count == 0 {
                cell.textField.text = ""
            } else {
                cell.textField.text = self.insertPlan.planName
            }
    
        case 1:
            cell.titleLabel.text = self.insertPlan.startDate == nil ? "请选择" : Date.string(from: self.insertPlan.startDate, format: "HH:mm")
            
        case 2:
            cell.titleLabel.text = self.insertPlan.endDate == nil ? "请选择" : Date.string(from: self.insertPlan.endDate, format: "HH:mm")
            
        case 3:
            cell.titleLabel.text = self.insertPlan.durationTimes == 0 ? "请选择" :  String (format: "%d次", self.insertPlan.durationTimes)
            
        case 4:
            cell.titleLabel.text = self.insertPlan.notificationWeeks.count == 0 ? "请选择" : self.insertPlan.weeksFormat()
            
        default:
            cell.titleLabel.text = ""
        }
        
        return cell
    }
    
    @objc func textFieldDidChanged(textField: UITextField) {
        insertPlan.planName = textField.text!
        
        delegate?.handlePlanNameDidSelected(planName: insertPlan.planName)
    }
}

