//
//  HYDatabaseManager+Plan.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/13.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYDatabaseManager.h"

@class HYPlan;
@interface HYDatabaseManager (Plan)

/**
 创建计划数据表
 */
- (void)database_createPlanTable;

/**
 新增一条计划数据
 */
- (void)database_insertPlan:(HYPlan *)plan;

@end
