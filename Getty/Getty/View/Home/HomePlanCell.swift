//
//  HomePlanCell.swift
//  Getty
//
//  Created by Hyyy on 2017/12/13.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

class HomePlanCell: UITableViewCell {

    let radiusBackgroundView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let titleLabel: UIView = {
        
        let label = UILabel()
        label.font = Constant.Font.kFontMedium
        label.textAlignment = .left
        label.textColor = Constant.Color.kTitleColor
        label.numberOfLines = 0
        label.text = "测试标题"
        
        return label
    }()
    
    let timeLabel: UIView = {
        
        let label = UILabel()
        label.font = Constant.Font.kFontSmall
        label.textAlignment = .right
        label.textColor = Constant.Color.kDescColor
        label.text = "21:00 - 22:00"
        
        return label
    }()
    
    let descLabel: UIView = {
        
        let label = UILabel()
        label.font = Constant.Font.kFontSmall
        label.textAlignment = .left
        label.textColor = Constant.Color.kDescColor
        label.numberOfLines = 0
        label.text = "计划持续共持续120次，每次执行60分钟。"
        
        return label
    }()
    
    /// Cell ID
    ///
    /// - Returns: String
    class func cellID() -> String {
        return String(describing: self)
    }
    
    /// Cell Height
    ///
    /// - Returns: Height
    class func cellHeight() -> CGFloat {
        return 140
    }
    
    /// 初始化Cell
    ///
    /// - Parameter tableView: tableView
    /// - Returns: cell
    class func cellWithTableView(tableView: UITableView) -> HomePlanCell {
        
        var cell: HomePlanCell? = tableView.dequeueReusableCell(withIdentifier: HomePlanCell.cellID()) as? HomePlanCell
        if (cell == nil) {
            cell = HomePlanCell()
            
            cell?.initCellUI()
            cell?.initCellLayout()
        }
        return cell!
    }
    
    func initCellUI() {
        
        selectionStyle = .none
        backgroundColor = Constant.Color.kTableBackgroundColor
        
        contentView.addSubview(radiusBackgroundView)
        radiusBackgroundView.addSubview(titleLabel)
        radiusBackgroundView.addSubview(timeLabel)
        radiusBackgroundView.addSubview(descLabel)
    }
    
    func initCellLayout() {
        radiusBackgroundView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.top.equalTo(contentView.snp.top).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(radiusBackgroundView.snp.top).offset(10)
            make.left.equalTo(radiusBackgroundView.snp.left).offset(20)
            make.height.equalTo(35)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(radiusBackgroundView.snp.top).offset(10)
            make.right.equalTo(radiusBackgroundView.snp.right).offset(-20)
            make.height.equalTo(35)
        }
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(radiusBackgroundView.snp.left).offset(20)
            make.height.equalTo(70)
        }
    }
}
