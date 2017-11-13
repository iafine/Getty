//
//  HYPlan.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/9.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 持续时间类型
 - HYDurationNone: 持续0天
 - HYDurationFifteen: 持续15天
 - HYDurationThirty: 持续30天
 - HYDurationSixty: 持续60天
 */
typedef NS_ENUM(NSUInteger, HYDurationType) {
    HYDurationNone,
    HYDurationFifteen,
    HYDurationThirty,
    HYDurationSixty,
};

@interface HYPlan : NSObject

@property (nonatomic, copy) NSString *planId;
@property (nonatomic, copy) NSString *planName;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic, assign) NSInteger durationTime;
@property (nonatomic, assign) HYDurationType durationType;

/**
 获取持续时间字符串
 */
- (NSString *)stringDuration;

@end
