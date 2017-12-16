//
//  DatePickerAlertView.swift
//  Getty
//
//  Created by Hyyy on 2017/12/15.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

class DatePickerAlertView: UIView {
    
    /// 弹框尺寸定义
    static let kContentHeight: CGFloat = 260
    
    let contentView: UIView = {
        
        let view = UIView (frame: CGRect (x: 0, y: (Constant.Size.kScreenHeight + kContentHeight), width: Constant.Size.kScreenWidth, height: kContentHeight))
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    let pickerView: UIDatePicker = {
        
        let pickerView = UIDatePicker (frame: CGRect (x: 0, y: 60, width: Constant.Size.kScreenWidth, height: (kContentHeight - 60)))
        pickerView.datePickerMode = .time
        pickerView.addTarget(self, action: #selector(pickerViewValueDidChanged), for: .valueChanged)
        
        return pickerView
    }()
    
    let titleLabel: UILabel = {
        
        let label = UILabel (frame: CGRect (x: 70, y: 5, width: Constant.Size.kScreenWidth - 140, height: 40))
        label.textAlignment = .center
        label.textColor = Constant.Color.kTitleColor
        label.font = Constant.Font.kFontSmall
        
        return label
    }()
    
    let cancelButton: UIButton = {
        
        let button = UIButton (type: .custom)
        button.frame = CGRect (x: 5, y: 5, width: 60, height: 40)
        button.setTitle("取消", for: .normal)
        button.setTitleColor(Constant.Color.kTitleColor, for: .normal)
        button.titleLabel?.font = Constant.Font.kFontSmall
        button.addTarget(self, action: #selector(handleCancelButtonEvent), for: .touchUpInside)
        
        return button
    }()
    
    let finishButton: UIButton = {
        
        let button = UIButton (type: .custom)
        button.frame = CGRect (x: (Constant.Size.kScreenWidth - 60 - 5), y: 5, width: 60, height: 40)
        button.setTitle("确定", for: .normal)
        button.setTitleColor(Constant.Color.kMainColor, for: .normal)
        button.titleLabel?.font = Constant.Font.kFontSmall
        button.addTarget(self, action: #selector(handleFinishButtonEvent), for: .touchUpInside)
        
        return button
    }()
    
    @objc func pickerViewValueDidChanged() {
        
    }
    
    @objc func handleCancelButtonEvent() {
        dismiss()
    }
    
    @objc func handleFinishButtonEvent() {
        dismiss()
    }
    
    init() {
        super.init(frame: Constant.Size.kScreenBounds)
        
        backgroundColor = UIColor (red: 0, green: 0, blue: 0, alpha: 0)
        addSubview(contentView)
        
        contentView.addSubview(cancelButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(finishButton)
        contentView.addSubview(pickerView)
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
            self.contentView.frame = CGRect (x: 0, y: (Constant.Size.kScreenHeight - DatePickerAlertView.kContentHeight), width: Constant.Size.kScreenWidth, height: DatePickerAlertView.kContentHeight)
        }) { (finished) in
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.contentView.frame = CGRect (x: 0, y: (Constant.Size.kScreenHeight + DatePickerAlertView.kContentHeight), width: Constant.Size.kScreenWidth, height: DatePickerAlertView.kContentHeight)
            self.backgroundColor = UIColor (red: 0, green: 0, blue: 0, alpha: 0)
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
}
