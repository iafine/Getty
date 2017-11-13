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

/**
 删除一条计划数据
 */
- (void)database_deletaPlanWithPlanId:(NSInteger)planId;

/**
 更新一条计划数据
 */
- (void)database_updatePlan:(HYPlan *)plan;

/**
 获取所有的计划数据
 */
- (NSArray<HYPlan *> *)database_queryAllPlans;

/**
 根据计划名称获取计划数据
 */
- (HYPlan *)database_queryPlanWithPlanName:(NSString *)planName;

@end
