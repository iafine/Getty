//
//  HYPerformance+Database.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/14.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPerformance.h"

@interface HYPerformance (Database)

+ (void)database_insertPerformances:(NSArray<HYPerformance *> *)performances block:(void(^)(BOOL isSuccess, NSString *message))block;

+ (void)database_queryAllPerformance:(void(^)(BOOL isSuccess, NSArray<HYPerformance *> *array, NSString *message))block;

@end
