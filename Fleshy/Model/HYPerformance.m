//
//  HYPerformance.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/13.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPerformance.h"

@implementation HYPerformance

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ ",@{
                                               @"performanceId" : @(_performanceId),
                                               @"planId" : @(_planId),
                                               @"isPerform" : @(_isPerform),
                                               @"performDate" : _performDate
                                               }];
}

@end
