//
//  HYLocalNotification.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/22.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYLocalNotification.h"
#import <UserNotifications/UserNotifications.h>

@interface HYLocalNotification ()<UNUserNotificationCenterDelegate>

@end

@implementation HYLocalNotification

+ (void)registerNotification {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
                NSLog(@"注册通知成功");
            } else {
                //点击不允许
                NSLog(@"注册通知失败");
            }
        }];
        //注册推送（同iOS8）
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

+ (void)createLocalNotification:(NSDate *)fireDate alertTitle:(NSString *)alertTitle alertBody:(NSString *)alertBody repeatInterval:(NSCalendarUnit)repeatInterval userInfo:(NSDictionary *)userInfo {
    if (@available(iOS 10.0, *)) {
        // 高于iOS10版本
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = alertTitle;
        content.body = alertBody;
        content.sound = [UNNotificationSound defaultSound];

        // 设置触发日期
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.hour = fireDate.hour;
        components.minute = fireDate.minute;
        
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"HYLocalNotification" content:content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            if (!error) {
                NSLog(@"成功添加推送");
            }else {
                NSLog(@"添加推送失败：%@", error.description);
            }
        }];
    } else {
        // 低于iOS10版本
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = fireDate;
        localNotification.alertTitle = alertTitle;
        localNotification.alertBody = alertBody;
        localNotification.repeatInterval = repeatInterval;
        localNotification.userInfo = userInfo;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

@end
