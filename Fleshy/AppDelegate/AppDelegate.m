//
//  AppDelegate.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/25.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "HYMainViewController.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window.rootViewController = [HYHomeViewController new];
    self.window.rootViewController = [[HYMainViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    // 设置通知代理
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    // 设置键盘相关
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    // 设置基本导航栏属性
    [UINavigationBar hy_basicAppearance];
    
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

#pragma mark - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {    
    NSLog(@"前台收到本地通知:{\n title:%@,\n subtitle:%@,\n body：%@,\n badge:%@,\n sound:%@,\n userinfo:%@\n}",
          notification.request.content.title,
          notification.request.content.subtitle,
          notification.request.content.body,
          notification.request.content.badge,
          notification.request.content.sound,
          notification.request.content.userInfo);
    completionHandler(UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionSound |
                      UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"后台收到本地通知:{\n title:%@,\n subtitle:%@,\n body：%@,\n badge:%@,\n sound:%@,\n userinfo:%@\n}",
          response.notification.request.content.title,
          response.notification.request.content.subtitle,
          response.notification.request.content.body,
          response.notification.request.content.badge,
          response.notification.request.content.sound,
          response.notification.request.content.userInfo);
    completionHandler();
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
