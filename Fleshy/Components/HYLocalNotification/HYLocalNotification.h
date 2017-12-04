//
//  HYLocalNotification.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/22.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const HYPlanStartNotificationIdentifier;   // 计划开始通知identifier
extern NSString *const HYPlanEndNotificationIdentifier;     // 计划结束通知identifier

extern NSString *const HYPlanStartCategoryIdentifier;       // 计划开始category的identifier
extern NSString *const HYPlanEndCategoryIdentifier;         // 计划结束category的identifier

extern NSString *const HYPlanConfirmActionIdetifier;        // 计划通知确认identifier
extern NSString *const HYPlanRefuseActionIdentifier;        // 计划通知拒绝identifier
extern NSString *const HYPlanFinishActionIdentifier;        // 计划通知完成identifier

extern NSString *const HYHasRegisterNotifiactionKey;        // 是否已经申请过通知权限缓存key （NO未申请过，YES已经申请过）
extern NSString *const HYRegisterNotificationGrantKey;      // 通知权限用户允许或未允许缓存Key (NO未允许，YES允许)

@interface HYLocalNotification : NSObject

+ (instancetype)sharedInstance;

- (void)registerNotificationCompleteHandler:(void (^)(BOOL granted, NSError *error))completeHandler;

- (void)createLocalNotification:(NSDate *)fireDate
                     alertTitle:(NSString *)alertTitle
                       subTitle:(NSString *)subTitle
                     identifier:(NSString *)identifier
             categoryIdentifier:(NSString *)categoryIdentifier
                      alertBody:(NSString *)alertBody
                          badge:(NSInteger)badge
                       userInfo:(NSDictionary *)userInfo;

@end
