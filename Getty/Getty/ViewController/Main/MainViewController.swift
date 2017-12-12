//
//  MainViewController.swift
//  Getty
//
//  Created by Hyyy on 2017/12/12.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let guideNavVC: UINavigationController = {
        return UINavigationController (rootViewController: NotificationGuideViewController())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let hasRegisterdNotification = UserDefaults.standard.bool(forKey: Constant.Cache.kHasRegisterdNotificationKey)
        if (hasRegisterdNotification) {
            // 如果还没有同意通知权限，那么显示通知开启引导页面
            NotificationManager.manager.registerLocalNotificationCompleteHandler(completeHandler: { (granted, error) in
                if (!granted) {
                    self.addNotAllowNotificationPage()
                }
            })
        } else {
            addNotAllowNotificationPage()
        }
    }
    
    func addNotAllowNotificationPage() {
        addChildViewController(guideNavVC)
        view.addSubview(guideNavVC.view)
    }
}
