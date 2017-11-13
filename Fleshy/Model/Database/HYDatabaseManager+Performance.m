//
//  HYDatabaseManager+Performance.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/13.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYDatabaseManager+Performance.h"

@implementation HYDatabaseManager (Performance)

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
    NSString *tableSql = @"create table fleshy_performance("
                            "perform_id INTEGER AUTO_INCREMENT,"
                            "plan_id INTEGER NOT NULL,"
                            "isPerform INTEGER NOT NULL,"
                            "perform_date TEXT NOT NULL,"
                            "PRIMARY KEY (perform_id),"
                            "FOREIGN KEY (plan_id) REFERENCES fleshy_plan(plan_id)"
                        ");";
    [self createTable:tableSql];
}

@end
