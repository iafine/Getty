//
//  HYDBManager+Performance.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/13.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYDBManager+Performance.h"
#import "HYPerformance.h"

@implementation HYDBManager (Performance)

- (void)database_createPerformanceTable {
    /*
     create table fleshy_performance(
     perform_id INTEGER AUTO_INCREMENT,
     plan_id INTEGER NOT NULL,
     isPerform INTEGER NOT NULL,
     perform_date TEXT NOT NULL,
     PRIMARY KEY (perform_id),
     FOREIGN KEY (plan_id) REFERENCES fleshy_plan(plan_id)
     );
     */
    NSString *tableSql = @"CREATE TABLE IF NOT EXISTS fleshy_performance("
                            "perform_id INTEGER,"
                            "plan_id INTEGER NOT NULL,"
                            "isPerform INTEGER NOT NULL,"
                            "perform_date TEXT,"
                            "PRIMARY KEY (perform_id),"
                            "FOREIGN KEY (plan_id) REFERENCES fleshy_plan(plan_id)"
                        ");";
//    [self executeUpdateSql:tableSql];
}

- (void)database_insertPerformance:(HYPerformance *)performance {
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO fleshy_performance (plan_id, isPerform, perform_date) VALUES (%ld, %d, '%@');", performance.planId, 0, [performance.performDate stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
    
//    [self executeSql:insertSql];
}

@end
