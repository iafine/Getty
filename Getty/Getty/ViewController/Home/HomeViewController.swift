//
//  HomeViewController.swift
//  Getty
//
//  Created by Hyyy on 2017/12/12.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView: HomeView = {
        
        let view = HomeView (frame: CGRect (x: 0, y: 64, width: Constant.Size.kScreenWidth, height: Constant.Size.kScreenHeight - 64))
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Getty"
        navigationItem.rightBarButtonItem = UIBarButtonItem (image: UIImage (named: "setting"), style: .plain, target: self, action: #selector(handleRightBarButtonEvent))
        
        view.addSubview(homeView)
    }
    
    @objc func handleRightBarButtonEvent() {
    }
}
