//
//  HYPlan+Database.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/14.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPlan.h"

@interface HYPlan (Database)

+ (void)databasae_insertPlan:(HYPlan *)plan block:(void(^)(BOOL isSuccess, NSString *message))block;

+ (void)database_queryPlan:(NSString *)planName block:(void(^)(BOOL isSuccess, HYPlan *plan, NSString *message))block;

+ (void)database_queryAllPlan:(void(^)(BOOL isSuccess, NSArray<HYPlan *> *array, NSString *message))block;

@end
