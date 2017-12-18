//
//  PlanCalendarItemCell.swift
//  Getty
//
//  Created by Hyyy on 2017/12/18.
//  Copyright © 2017年 Getty. All rights reserved.
//

import JTAppleCalendar

class PlanCalendarItemCell: JTAppleCell {
    
    let titleLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constant.Font.kFontTiny
        label.textColor = Constant.Color.kDescColor
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
    }
}
