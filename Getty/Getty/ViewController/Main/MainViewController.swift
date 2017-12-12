//
//  MainViewController.swift
//  Getty
//
//  Created by Hyyy on 2017/12/12.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let notificationGuideVC = NotificationGuideViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addChildViewController(notificationGuideVC)
        view.addSubview(notificationGuideVC.view)
    }
}
