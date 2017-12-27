//
//  AppDelegate.swift
//  Getty
//
//  Created by Hyyy on 2017/12/12.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow (frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = MainViewController ()
        window?.makeKeyAndVisible()
    
        themeAppearance()
        keyboardManager()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    func themeAppearance() {
        
        UINavigationBar.appearance().barTintColor = UIColor.white   // 设置导航栏背景颜色
        UINavigationBar.appearance().tintColor = Constant.Color.kTitleColor // 设置导航栏左右按钮文字颜色
        UINavigationBar.appearance().shadowImage = UIImage()    // 去掉导航栏底部阴影线
        UINavigationBar.appearance().backIndicatorImage = UIImage (named: "back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage (named: "back")

        // 定制导航栏title字体
        let textAttributes = [NSAttributedStringKey.font : Constant.Font.kFontMedium,
                              NSAttributedStringKey.foregroundColor : Constant.Color.kTitleColor]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        

        // UIBarButtonItem
        let buttonTextAttributes = [NSAttributedStringKey.font : Constant.Font.kFontSmall,
                                    NSAttributedStringKey.foregroundColor : Constant.Color.kTitleColor]
        UIBarButtonItem.appearance().setTitleTextAttributes(buttonTextAttributes, for: .normal)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-100, 0), for: .default)
        
        // UITextField
        UITextField.appearance().tintColor = Constant.Color.kMainColor
    }
    
    func keyboardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
}

