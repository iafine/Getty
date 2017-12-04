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

NSString *const HYRegisterNotificationGrantKey = @"HYRegisterNotificationGrantKey";
NSString *const HYHasRegisterNotifiactionKey = @"HYHasRegisterNotifiactionKey";

@interface HYLocalNotification ()<UNUserNotificationCenterDelegate>

@end

@implementation HYLocalNotification

+ (instancetype)sharedInstance {
    static HYLocalNotification *localNotification;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        localNotification = [[HYLocalNotification alloc] init];
    });
    return localNotification;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    return self;
}

- (void)registerNotificationCompleteHandler:(void (^)(BOOL, NSError *))completeHandler {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            [HYCacheHelper setCacheValue:@(1) cacheKey:HYHasRegisterNotifiactionKey cacheType:HYCacheDisk];
            if (granted) {
                [HYCacheHelper setCacheValue:@(0) cacheKey:HYRegisterNotificationGrantKey cacheType:HYCacheDisk];
                NSLog(@"注册通知成功");
            }else {
                [HYCacheHelper setCacheValue:@(1) cacheKey:HYRegisterNotificationGrantKey cacheType:HYCacheDisk];
                NSLog(@"注册通知失败，失败原因：%@", error.description);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completeHandler) completeHandler(granted, error);
            });
        }];
        
//        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//            NSLog(@"%@",settings);
//        }];
        
        UNNotificationAction *confirmAction = [UNNotificationAction actionWithIdentifier:HYPlanConfirmActionIdetifier title:@"开始计划" options:UNNotificationActionOptionForeground];
        UNNotificationAction *refuseAction = [UNNotificationAction actionWithIdentifier:HYPlanRefuseActionIdentifier title:@"取消计划" options:UNNotificationActionOptionDestructive | UNNotificationActionOptionForeground];
        UNNotificationAction *finishAction = [UNNotificationAction actionWithIdentifier:HYPlanFinishActionIdentifier title:@"进行打卡" options:UNNotificationActionOptionDestructive | UNNotificationActionOptionForeground];
        
        UNNotificationCategory *startCategory = [UNNotificationCategory categoryWithIdentifier:HYPlanStartCategoryIdentifier actions:@[confirmAction, refuseAction] intentIdentifiers:@[HYPlanStartNotificationIdentifier] options:UNNotificationCategoryOptionCustomDismissAction];
        UNNotificationCategory *endCategory = [UNNotificationCategory categoryWithIdentifier:HYPlanEndCategoryIdentifier actions:@[finishAction] intentIdentifiers:@[HYPlanEndNotificationIdentifier] options:UNNotificationCategoryOptionCustomDismissAction];
        
        [center setNotificationCategories:[NSSet setWithArray:@[startCategory, endCategory]]];
    }
}

- (void)createLocalNotification:(NSDate *)fireDate alertTitle:(NSString *)alertTitle subTitle:(NSString *)subTitle identifier:(NSString *)identifier categoryIdentifier:(NSString *)categoryIdentifier alertBody:(NSString *)alertBody badge:(NSInteger)badge userInfo:(NSDictionary *)userInfo {
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
        NSDateComponents *components = [self componentsEveryDayWithDate:fireDate];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
        
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
    
    // 本地通知Action操作类
    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
    
    if ([categoryIdentifier isEqualToString:HYPlanStartCategoryIdentifier]) {
        // 开始计划category
        if ([response.actionIdentifier isEqualToString:HYPlanConfirmActionIdetifier]) {
            // 开始计划
            NSLog(@"计划开始。。。");
        }else if ([response.actionIdentifier isEqualToString:HYPlanRefuseActionIdentifier]) {
            // 取消计划
            NSLog(@"取消计划。。。");
        }else {
        }
        
    }else if ([categoryIdentifier isEqualToString:HYPlanEndCategoryIdentifier]) {
        // 结束计划category
        if ([response.actionIdentifier isEqualToString:HYPlanFinishActionIdentifier]) {
            // 打卡
            NSLog(@"打卡。。。");
        }
    }else {
    }
    
    completionHandler();
}

#pragma mark - Private Methods
- (NSDateComponents *)componentsEveryDayWithDate:(NSDate *)date {
    
    NSInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    return components;
}

@end
