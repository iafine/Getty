//
//  HYPerformance.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/13.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYPerformance : NSObject

@property (nonatomic, copy) NSString *performanceId;

@property (nonatomic, copy) NSString *planId;

@property (nonatomic, assign) BOOL isPerform;

@property (nonatomic, copy) NSDate *performDate;

@end
