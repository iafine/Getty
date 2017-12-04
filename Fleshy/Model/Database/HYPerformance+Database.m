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
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO fleshy_performance ("
                               "plan_id, "
                               "perform_date"
                               ") VALUES (%ld, '%@');",
                               performance.planId,
                               [performance.performDate stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
        [tempArray addObject:insertSql];
    }
    
    [[HYDBManager sharedInstance] executeSqlList:tempArray block:^(BOOL isSuccess, NSString *message) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) block(isSuccess, message);
        });
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
            performance.isDelete = [rs boolForColumn:@"perform_is_delete"];
            [tempArrray addObject:performance];
        }
        [rs close];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(isSuccess, tempArrray, message);
        });
    }];
}

+ (void)database_queryPerformances:(NSInteger)planId block:(void (^)(BOOL, NSArray<HYPerformance *> *, NSArray<HYPerformance *> *, NSString *))block {

    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM fleshy_performance WHERE plan_id = %ld ORDER BY perform_date ASC;", planId];
    [[HYDBManager sharedInstance] executeQuerySQL:querySql block:^(BOOL isSuccess, FMResultSet *rs, NSString *message) {
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *performArray = [NSMutableArray array];
        while (rs.next) {
            HYPerformance *performance = [[HYPerformance alloc] init];
            performance.performanceId = [rs intForColumn:@"perform_id"];
            performance.planId = [rs intForColumn:@"plan_id"];
            performance.isPerform = [rs boolForColumn:@"is_perform"];
            performance.performDate = [NSDate dateWithString:[rs stringForColumn:@"perform_date"] format:@"yyyy-MM-dd HH:mm:ss"];
            performance.isDelete = [rs boolForColumn:@"perform_is_delete"];
            [array addObject:performance];
            if (performance.isPerform) {
                [performArray addObject:performance];
            }
        }
        [rs close];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(isSuccess, array.copy, performArray.copy, message);
        });
    }];
}

+ (void)database_deletePerformances:(NSInteger)planId block:(void (^)(BOOL, NSString *))block {
    NSString *updateSql = [NSString stringWithFormat:@"UPDATE fleshy_performance SET perform_is_delete = 1 WHERE plan_id = %ld;", planId];
    [[HYDBManager sharedInstance] executeUpdateSQL:updateSql block:^(BOOL isSuccess, NSString *message) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(isSuccess, message);
        });
    }];
}

+ (void)database_updatePerformances:(NSArray<HYPerformance *> *)performances block:(void (^)(BOOL, NSString *))block {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (HYPerformance *performance in performances) {
        NSString *insertSql = [NSString stringWithFormat:@"UPDATE fleshy_performance SET "
                               "perform_date='%@', "
                               "is_perform=%d, "
                               "perform_is_delete=%d "
                               "WHERE perform_id=%ld;",
                               [performance.performDate stringWithFormat:@"yyyy-MM-dd HH:mm:ss"],
                               performance.isPerform,
                               performance.isDelete,
                               performance.performanceId];
        [tempArray addObject:insertSql];
    }
    
    [[HYDBManager sharedInstance] executeSqlList:tempArray block:^(BOOL isSuccess, NSString *message) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) block(isSuccess, message);
        });
    }];
}
@end
