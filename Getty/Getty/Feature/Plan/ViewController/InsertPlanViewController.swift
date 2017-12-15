//
//  InsertPlanViewController.swift
//  Getty
//
//  Created by Hyyy on 2017/12/13.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

class InsertPlanViewController: UIViewController {

    let insertView: InsertPlanView = {
        
        let view = InsertPlanView (frame: CGRect (x: 0,
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
        
        view.addSubview(insertView)
    }
    
    @objc func handleCloseButtonEvent() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleFinishButtonEvent() {
        dismiss(animated: true, completion: nil)
    }
}
