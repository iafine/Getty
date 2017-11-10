//
//  HYPlan.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/9.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPlan.h"

@implementation HYPlan

- (NSString *)stringDuration {
    switch (self.durationType) {
        case HYDurationNone:
            return @"";
        
        case HYDurationFifteen:
            return @"15天";
            
        case HYDurationThirty:
            return @"30天";
            
        case HYDurationSixty:
            return @"60天";
    }
}

@end
