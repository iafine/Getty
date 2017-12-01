//
//  NSDate+HYAdd.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/9.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HYAdd)

/**
 获取两个时间之间的间隔
 */
- (NSString *)hy_timeintervalWithBeforeDate:(NSDate *)beforeDate;

/**
 获取两个时间之间的间隔，返回分钟
 */
- (NSInteger)hy_minutesIntervalWithBeforeDate:(NSDate *)beforeDate;

/**
 获取两个事件之间的间隔，返回天数
 */
- (NSInteger)hy_daysIntervalWithBeforeDate:(NSDate *)beforeDate;

/**
 将秒数归零，替换成一个新的NSDate对象
 */
- (NSDate *)hy_newDateBySecondZero;

/**
 返回星期字符串
 */
- (NSString *)hy_stringWeekday;

/**
 是否是今天之前的时间
 */
- (BOOL)hy_isBeforeToday;

/**
 是否是今天之后的时间
 */
- (BOOL)hy_isAfterToday;

/**
 是否是同一天
 */
- (BOOL)hy_isSameDay:(NSDate *)date;

@end
