//
//  NSDate+HYAdd.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/9.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "NSDate+HYAdd.h"

@implementation NSDate (HYAdd)

- (NSString *)hy_timeintervalWithBeforeDate:(NSDate *)beforeDate {
    NSTimeInterval timeInterval = [self timeIntervalSinceDate:beforeDate];
    
    NSInteger minutes = timeInterval / 60;
    if (minutes < 60) {
        return [NSString stringWithFormat:@"%ld分钟", minutes];
    }else {
        NSInteger hour = minutes / 60;
        NSInteger restMinutes = minutes % 60;
        if (minutes % 60 == 0) {
            return [NSString stringWithFormat:@"%ld小时", hour];
        }else {
            return [NSString stringWithFormat:@"%ld小时%ld分钟", hour, restMinutes];
        }
    }
}

@end
