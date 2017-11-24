//
//  HYLocalNotification.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/22.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYLocalNotification.h"
#import <UserNotifications/UserNotifications.h>

NSString *const HYPlanStartNotificationIdentifier = @"HYPlanStartNotificationIdentifier";
NSString *const HYPlanEndNotificationIdentifier = @"HYPlanEndNotificationIdentifier";

NSString *const HYPlanStartCategoryIdentifier = @"HYPlanStartCategoryIdentifier";
NSString *const HYPlanEndCategoryIdentifier = @"HYPlanEndCategoryIdentifier";

NSString *const HYPlanConfirmActionIdetifier = @"HYPlanConfirmActionIdetifier";
NSString *const HYPlanRefuseActionIdentifier = @"HYPlanRefuseActionIdentifier";
NSString *const HYPlanFinishActionIdentifier = @"HYPlanFinishActionIdentifier";

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
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completeHandler) completeHandler(granted, error);
            });
        }];
        
//        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//            NSLog(@"%@",settings);
//        }];
        
        UNNotificationAction *confirmAction = [UNNotificationAction actionWithIdentifier:HYPlanConfirmActionIdetifier title:@"开始计划" options:UNNotificationActionOptionNone];
        UNNotificationAction *refuseAction = [UNNotificationAction actionWithIdentifier:HYPlanRefuseActionIdentifier title:@"取消计划" options:UNNotificationActionOptionDestructive];
        UNNotificationAction *finishAction = [UNNotificationAction actionWithIdentifier:HYPlanFinishActionIdentifier title:@"进行打卡" options:UNNotificationActionOptionDestructive];
        
        UNNotificationCategory *startCategory = [UNNotificationCategory categoryWithIdentifier:HYPlanStartCategoryIdentifier actions:@[confirmAction, refuseAction] intentIdentifiers:@[HYPlanStartNotificationIdentifier] options:UNNotificationCategoryOptionCustomDismissAction];
        UNNotificationCategory *endCategory = [UNNotificationCategory categoryWithIdentifier:HYPlanEndCategoryIdentifier actions:@[finishAction] intentIdentifiers:@[HYPlanEndNotificationIdentifier] options:UNNotificationCategoryOptionCustomDismissAction];
        
        [center setNotificationCategories:[NSSet setWithArray:@[startCategory, endCategory]]];
    }
}

+ (void)createLocalNotification:(NSDate *)fireDate alertTitle:(NSString *)alertTitle subTitle:(NSString *)subTitle identifier:(NSString *)identifier categoryIdentifier:(NSString *)categoryIdentifier alertBody:(NSString *)alertBody badge:(NSInteger)badge userInfo:(NSDictionary *)userInfo {
    if (@available(iOS 10.0, *)) {
        // 高于iOS10版本
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = alertTitle;
        content.body = alertBody;
        content.subtitle = subTitle;
        content.badge = [NSNumber numberWithInteger:badge];
        content.sound = [UNNotificationSound defaultSound];
        content.categoryIdentifier = categoryIdentifier;

        // 设置触发日期
//        NSDateComponents *components = [self componentsEveryDayWithDate:fireDate];
//        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];

        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:(fireDate.minute + fireDate.hour + 60) repeats:YES];
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        
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
