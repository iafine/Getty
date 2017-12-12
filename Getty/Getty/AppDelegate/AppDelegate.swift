//
//  AppDelegate.swift
//  Getty
//
//  Created by Hyyy on 2017/12/12.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow (frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = MainViewController ()
        window?.makeKeyAndVisible()
    
        themeAppearance()
        
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
        
//        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];    // 设置导航栏背景颜色
//        [[UINavigationBar appearance] setTintColor:kTitleColor];    // 设置导航栏左右按钮tint颜色
//        [[UINavigationBar appearance] setShadowImage:[UIImage new]];    // 去掉导航栏底部阴影线
//
//        NSDictionary *textAttributes =  @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:kTextSizeMedium],
//            NSForegroundColorAttributeName : kTitleColor };
//        [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];   // 定制导航栏title字体
//
//        [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back"]];
//        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
//
//        // UIBarButtonItem的也放在这里
//        NSDictionary *buttonTextAttributes =  @{ NSFontAttributeName : [UIFont systemFontOfSize:kTextSizeSmall],
//            NSForegroundColorAttributeName : kTitleColor };
//        [[UIBarButtonItem appearance] setTitleTextAttributes:buttonTextAttributes forState:UIControlStateNormal];
//        //隐藏返回按钮的文字
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100, 0) forBarMetrics:UIBarMetricsDefault];
//
//        // UITextField的也放在这里
//        [[UITextField appearance] setTintColor:kMainColor];
    }
}

