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

@end
