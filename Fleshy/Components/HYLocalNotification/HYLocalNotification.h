//
//  HYLocalNotification.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/22.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYLocalNotification : NSObject

+ (void)registerNotificationCompleteHandler:(void(^)(BOOL granted, NSError *error))completeHandler;

+ (void)createLocalNotification:(NSDate *)fireDate alertTitle:(NSString *)alertTitle alertBody:(NSString *)alertBody repeatInterval:(NSCalendarUnit)repeatInterval userInfo:(NSDictionary *)userInfo;

@end
