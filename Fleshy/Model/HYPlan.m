//
//  HYPlan.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/9.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPlan.h"

@implementation HYPlan

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ ",@{
                                               @"planId" : @(_planId),
                                               @"planName" : _planName,
                                               @"startTime" : _startTime,
                                               @"endTime" : _endTime,
                                               @"createDate" : _createDate,
                                               @"durationTime" : @(_durationTime),
                                               @"durationDays" : @(_durationDays),
                                               @"isDelete" : @(_isDelete),
                                               }];
}
            
@end
