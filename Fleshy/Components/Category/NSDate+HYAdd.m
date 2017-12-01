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
    NSInteger minutes = [self hy_minutesIntervalWithBeforeDate:beforeDate];
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

- (NSInteger)hy_minutesIntervalWithBeforeDate:(NSDate *)beforeDate {
    NSTimeInterval timeInterval = [self timeIntervalSinceDate:beforeDate];
    
    return timeInterval / 60;
}

- (NSInteger)hy_daysIntervalWithBeforeDate:(NSDate *)beforeDate {
    NSDate *newCurrentDate = [NSDate dateWithString:[self stringWithFormat:@"yyyy-MM-dd 00:00:00"] format:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *newBeforeDate = [NSDate dateWithString:[beforeDate stringWithFormat:@"yyyy-MM-dd 00:00:00"] format:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval timeInterval = [newCurrentDate timeIntervalSinceDate:newBeforeDate];
    return timeInterval / (60 * 60 * 24);
}

- (NSDate *)hy_newDateBySecondZero {
    NSString *date = [self stringWithFormat:@"yyyy-MM-dd"];
    NSString *hour = [self stringWithFormat:@"HH"];
    NSString *minutes = [self stringWithFormat:@"mm"];
    NSString *newDateStr = [NSString stringWithFormat:@"%@ %@:%@:00", date, hour, minutes];
    return [NSDate dateWithString:newDateStr format:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)hy_stringWeekday {
    switch (self.weekday) {
        case 1:
            return @"星期天";
            
        case 2:
            return @"星期一";
            
        case 3:
            return @"星期二";
            
        case 4:
            return @"星期三";
            
        case 5:
            return @"星期四";
            
        case 6:
            return @"星期五";
            
        case 7:
            return @"星期六";
            
        default:
            return @"";
    }
}

- (BOOL)hy_isBeforeToday {
    NSComparisonResult result = [self hy_compareDate:self dateB:[NSDate date]];
    return (result == NSOrderedDescending ? NO : YES);
}

- (BOOL)hy_isAfterToday {
    NSComparisonResult result = [self hy_compareDate:self dateB:[NSDate date]];
    return (result == NSOrderedDescending ? YES : NO);
}

- (BOOL)hy_isSameDay:(NSDate *)date {
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    if ( (int)(([self timeIntervalSince1970] + timezoneFix)/(24*3600)) - (int)(([date timeIntervalSince1970] + timezoneFix)/(24*3600)) == 0) {
        return YES;
    }
    return NO;
}

#pragma mark - Private Methods
- (NSComparisonResult)hy_compareDate:(NSDate *)dateA dateB:(NSDate *)dateB {
    NSString *dateString = [dateA stringWithFormat:@"yyyy-MM-dd"];
    NSString *nowDateString = [dateB stringWithFormat:@"yyyy-MM-dd"];
    
    NSDate *finalDateA = [NSDate dateWithString:dateString format:@"yyyy-MM-dd"];
    NSDate *finalDateB = [NSDate dateWithString:nowDateString format:@"yyyy-MM-dd"];

    NSComparisonResult result = [finalDateA compare:finalDateB];
    
    return result;
}

@end
