//
//  HYPerformance.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/13.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYPerformance : NSObject

@property (nonatomic, assign) NSInteger performanceId;

@property (nonatomic, assign) NSInteger planId;

@property (nonatomic, assign) BOOL isPerform;

@property (nonatomic, copy) NSDate *performDate;

@property (nonatomic, assign) BOOL isDelete;

@end
