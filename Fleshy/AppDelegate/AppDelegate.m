//
//  AppDelegate.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/25.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "AppDelegate.h"
#import "HYMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window.rootViewController = [HYHomeViewController new];
    self.window.rootViewController = [[HYMainViewController alloc] init];
    
    // 设置基本导航栏属性
    [UINavigationBar hy_basicAppearance];
    
    [self.window makeKeyAndVisible];
    
    [[HYDatabaseManager sharedInstance] openDatabase];
    [[HYDatabaseManager sharedInstance] closeDatabase];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Setter and Getter
- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:kScreenBounds];
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}

@end
