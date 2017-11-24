//
//  HYPerformance+Database.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/14.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPerformance+Database.h"
#import "HYDBManager.h"

@implementation HYPerformance (Database)

+ (void)database_insertPerformances:(NSArray<HYPerformance *> *)performances block:(void (^)(BOOL, NSString *))block {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (HYPerformance *performance in performances) {
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO fleshy_performance (plan_id, is_perform, perform_date) VALUES (%ld, %d, '%@');", performance.planId, performance.isPerform, [performance.performDate stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
        [tempArray addObject:insertSql];
    }
    
    [[HYDBManager sharedInstance] executeSqlList:tempArray block:^(BOOL isSuccess, NSString *message) {
        if (block) block(isSuccess, message);
    }];
}

+ (void)database_queryAllPerformance:(void (^)(BOOL, NSArray<HYPerformance *> *, NSString *))block {
    NSString *querySql = @"SELECT * FROM fleshy_performance;";
    [[HYDBManager sharedInstance] executeQuerySQL:querySql block:^(BOOL isSuccess, FMResultSet *rs, NSString *message) {
        NSMutableArray *tempArrray = [NSMutableArray array];
        while (rs.next) {
            HYPerformance *performance = [[HYPerformance alloc] init];
            performance.performanceId = [rs intForColumn:@"perform_id"];
            performance.planId = [rs intForColumn:@"plan_id"];
            performance.isPerform = [rs boolForColumn:@"is_perform"];
            performance.performDate = [NSDate dateWithString:[rs stringForColumn:@"perform_date"] format:@"yyyy-MM-dd HH:mm:ss"];
            [tempArrray addObject:performance];
        }
        [rs close];
        block(isSuccess, tempArrray, message);
    }];
}

+ (void)database_queryThreeDaysFromNowPerformances:(void (^)(BOOL, NSArray<HYPerformance *> *, NSString *))block {
    NSString *threeDate = [[[NSDate new] dateByAddingDays:3] stringWithFormat:@"yyyy-MM-dd"];
    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM fleshy_performance WHERE perform_id <= (SELECT perform_id FROM fleshy_performance WHERE perform_date like '%@%%') ORDER BY perform_date ASC;", threeDate];
    [[HYDBManager sharedInstance] executeQuerySQL:querySql block:^(BOOL isSuccess, FMResultSet *rs, NSString *message) {
        NSMutableArray *tempArrray = [NSMutableArray array];
        while (rs.next) {
            HYPerformance *performance = [[HYPerformance alloc] init];
            performance.performanceId = [rs intForColumn:@"perform_id"];
            performance.planId = [rs intForColumn:@"plan_id"];
            performance.isPerform = [rs boolForColumn:@"is_perform"];
            performance.performDate = [NSDate dateWithString:[rs stringForColumn:@"perform_date"] format:@"yyyy-MM-dd HH:mm:ss"];
            [tempArrray addObject:performance];
        }
        [rs close];
        block(isSuccess, tempArrray, message);
    }];
}

@end
