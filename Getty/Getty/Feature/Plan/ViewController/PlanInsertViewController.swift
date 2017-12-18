//
//  PlanInsertViewController.swift
//  Getty
//
//  Created by Hyyy on 2017/12/13.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

class PlanInsertViewController: UIViewController {

    let insertView: PlanInsertView = {
        
        let view = PlanInsertView (frame: CGRect (x: 0,
                                                  y: 64,
                                                  width: Constant.Size.kScreenWidth,
                                                  height: Constant.Size.kScreenHeight - 64))
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "添加"
        navigationItem.leftBarButtonItem = UIBarButtonItem (image: UIImage (named: "close"), style: .done, target: self, action: #selector(handleCloseButtonEvent))
        navigationItem.rightBarButtonItem = UIBarButtonItem (title: "完成", style: .done, target: self, action: #selector(handleFinishButtonEvent))
        
        insertView.delegate = self
        
        view.addSubview(insertView)
    }
    
    @objc func handleCloseButtonEvent() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleFinishButtonEvent() {
        dismiss(animated: true, completion: nil)
    }
}

extension PlanInsertViewController: InsertPlanViewDelegate {
    func handleSelectedRow(indexPath: IndexPath) {
        if (indexPath.section == 1 || indexPath.section == 2) {
            let datePicker = DatePickerAlertView ()
            datePicker.show()
        } else if (indexPath.section == 3) {
            let listPicker = ListAlertView()
            listPicker.show()
        } else if (indexPath.section == 4) {
            let chooseTimeVC = PlanChooseWeeksViewController()
            navigationController?.pushViewController(chooseTimeVC, animated: true)
        }
    }
}
