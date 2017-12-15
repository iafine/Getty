//
//  InsertPlanCell.swift
//  Getty
//
//  Created by Hyyy on 2017/12/14.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

enum InsertPlanCellStyle: Int {
    case label
    case edit
}

class InsertPlanCell: UITableViewCell {
    
    let textField: UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textAlignment = .left
        textField.font = Constant.Font.kFontSmall
        textField.textColor = Constant.Color.kTitleColor
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .valueChanged)
        textField.placeholder = "请输入标题"
        
        return textField
    }()
    
    let titleLabel: UILabel = {
        
        let label = UILabel()
        label.font = Constant.Font.kFontSmall
        label.textColor = Constant.Color.kTitleColor
        label.text = "请选择时间"
        
        return label
    }()
    
    var cellStyle: InsertPlanCellStyle = .label
    
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
        return 44
    }
    
    /// 初始化Cell
    ///
    /// - Parameter tableView: tableView
    /// - Returns: cell
    class func cellWithTableView(tableView: UITableView, style: InsertPlanCellStyle) -> InsertPlanCell {
        
        var cell: InsertPlanCell? = tableView.dequeueReusableCell(withIdentifier: InsertPlanCell.cellID()) as? InsertPlanCell
        if (cell == nil) {
            cell = InsertPlanCell()
            
            cell?.cellStyle = style
            cell?.initCellUI()
            cell?.initCellLayout()
        }
        return cell!
    }
    
    func initCellUI() {
        if (cellStyle == .edit) {
            contentView.addSubview(textField)
        } else {
            contentView.addSubview(titleLabel)
        }
    }
    
    func initCellLayout() {
        if (cellStyle == .edit) {
            textField.snp.makeConstraints({ (make) in
                make.top.equalTo(contentView.snp.top)
                make.left.equalTo(contentView.snp.left).offset(20)
                make.right.equalTo(contentView.snp.right).offset(-20)
                make.bottom.equalTo(contentView.snp.bottom)
            })
        } else {
            titleLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(contentView.snp.top)
                make.left.equalTo(contentView.snp.left).offset(20)
                make.right.equalTo(contentView.snp.right).offset(-20)
                make.bottom.equalTo(contentView.snp.bottom)
            })
        }
    }
    
    @objc func textFieldDidChanged() {
    }
}
