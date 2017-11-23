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

@interface HYLocalNotification : NSObject

+ (void)registerNotificationCompleteHandler:(void (^)(BOOL granted, NSError *error))completeHandler;

+ (void)createLocalNotification:(NSDate *)fireDate
                     alertTitle:(NSString *)alertTitle
                       subTitle:(NSString *)subTitle
                     identifier:(NSString *)identifier
             categoryIdentifier:(NSString *)categoryIdentifier
                      alertBody:(NSString *)alertBody
                          badge:(NSInteger)badge
                       userInfo:(NSDictionary *)userInfo;

@end
