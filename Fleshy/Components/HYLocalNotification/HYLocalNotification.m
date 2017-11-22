//
//  HYLocalNotification.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/22.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYLocalNotification.h"
#import <UserNotifications/UserNotifications.h>

@interface HYLocalNotification ()

@end

@implementation HYLocalNotification

+ (void)registerNotificationCompleteHandler:(void (^)(BOOL, NSError *))completeHandler {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"注册通知成功");
            }else {
                NSLog(@"注册通知失败，失败原因：%@", error.description);
            }
            if (completeHandler) completeHandler(granted, error);
        }];
        
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            NSLog(@"%@",settings);
        }];
        
//        UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:actionFiveMin title:@"5分钟后" options:UNNotificationActionOptionNone];
//
//        UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:actionHalfAnHour title:@"半小时后" options:UNNotificationActionOptionNone];
//        UNNotificationAction *action3 = [UNNotificationAction actionWithIdentifier:actionOneHour title:@"1小时后" options:UNNotificationActionOptionNone];
//        UNNotificationAction *action4 = [UNNotificationAction actionWithIdentifier:actionStop title:@"停止" options:UNNotificationActionOptionNone];
//
//
//        UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:categryLaterIdf actions:@[action1, action2,action3, action4] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
//
//
//        UNNotificationCategory *stopCategory = [UNNotificationCategory categoryWithIdentifier:categryStopIdf actions:@[action4] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
//
//        [center setNotificationCategories:[NSSet setWithArray:@[category,stopCategory]]];
    }
}

+ (void)createLocalNotification:(NSDate *)fireDate alertTitle:(NSString *)alertTitle subTitle:(NSString *)subTitle alertBody:(NSString *)alertBody badge:(NSInteger)badge userInfo:(NSDictionary *)userInfo {
    if (@available(iOS 10.0, *)) {
        // 高于iOS10版本
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = alertTitle;
        content.body = alertBody;
        content.subtitle = subTitle;
        content.badge = [NSNumber numberWithInteger:badge];
        content.sound = [UNNotificationSound defaultSound];

        // 设置触发日期
//        NSDateComponents *components = [self componentsEveryDayWithDate:fireDate];
//        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60 repeats:YES];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"HYLocalNotification" content:content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
            if (!error) {
                NSLog(@"成功添加推送");
            }else {
                NSLog(@"添加推送失败：%@", error.description);
            }
        }];
    }
}

#pragma mark - Private Methods
+ (NSDateComponents *)componentsEveryDayWithDate:(NSDate *)date {
    
    NSInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    return components;
}

@end
