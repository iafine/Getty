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
    ///
    /// - Parameter indexPath: indexPath
    func handleSelectedRow(indexPath: IndexPath)
}

class InsertPlanView: UIView {

    let tableView: UITableView = {
        
        let tableView = UITableView (frame: CGRect.zero, style: .grouped)
        tableView.separatorColor = Constant.Color.kTableBackgroundColor
        tableView.backgroundColor = Constant.Color.kTableBackgroundColor
        
        return tableView
    }()
    
    var delegate: InsertPlanViewDelegate?
    
    let titleArray: NSArray = ["计划标题", "开始时间", "结束时间", "持续次数", "提醒选项(默认每天提醒，点击修改 )"]
    
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
}

extension InsertPlanView: UITableViewDelegate {
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

extension InsertPlanView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return InsertPlanCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellStyle: InsertPlanCellStyle = indexPath.section == 0 ? .edit : .label
        let cell = InsertPlanCell.cellWithTableView(tableView: tableView, style: cellStyle)
        return cell
    }
}
