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

 @param beforeDate 开始时间
 @return 间隔字符串
 */
- (NSString *)hy_timeintervalWithBeforeDate:(NSDate *)beforeDate;

/**
 获取两个时间之间的间隔，返回分钟

 @param beforeDate 开始时间
 @return 间隔分钟
 */
- (NSInteger)hy_minutesIntervalWithBeforeDate:(NSDate *)beforeDate;

/**
 将秒数归零，替换成一个新的NSDate对象
 */
- (NSDate *)hy_newDateBySecondZero;

@end
