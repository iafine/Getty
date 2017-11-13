//
//  HYDatabaseManager+Plan.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/13.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYDatabaseManager+Plan.h"
#import "HYPlan.h"

@implementation HYDatabaseManager (Plan)


/**
 create table fleshy_plan(
    plan_id INTEGER,
    plan_name TEXT NOT NULL,
    plan_start_time TEXT NOT NULL,
    plan_end_time TEXT NOT NULL,
    plan_create_time TEXT NOT NULL,
    plan_duration_time INTEGER NOT NULL,
    plan_duration_days INTEGER NOT NULL,
    PRIMARY KEY (plan_id)
 );
 */
- (void)database_createPlanTable {
    NSString *tableSql = @"create table fleshy_plan("
                            "plan_id INTEGER,"
                            "plan_name TEXT NOT NULL,"
                            "plan_start_time TEXT NOT NULL,"
                            "plan_end_time TEXT NOT NULL,"
                            "plan_create_time TEXT NOT NULL,"
                            "plan_duration_time INTEGER NOT NULL,"
                            "plan_duration_days INTEGER NOT NULL,"
                            "PRIMARY KEY (plan_id)"
                        ");";
    
    [self createTable:tableSql];
}


/**
 INSERT INTO fleshy_plan (plan_name, plan_start_time, plan_end_time, plan_create_time, plan_duration_time, plan_duration_days) VALUES ('test_name', '2017-11-13 11:00:00', '2017-11-13 12:00:00', '2017-11-13 11:00:00', 60, 15);
 */
- (void)database_insertPlan:(HYPlan *)plan {
    
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO fleshy_plan (plan_name, plan_start_time, plan_end_time, plan_create_time, plan_duration_time, plan_duration_days) VALUES (%@, %@, %@, %@, %ld , %ld);", plan.planName, plan.startTime, plan.endTime, plan.createDate, plan.durationTime, plan.durationType];
    
    [self executeSql:insertSql];
}

@end
