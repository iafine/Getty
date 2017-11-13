//
//  HYDatabaseManager.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/10.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

// 数据库名称
extern NSString *const HYDatabaseName;

@interface HYDatabaseManager : NSObject

@property (nonatomic, strong) FMDatabase *dateBase; // 数据库

@property (nonatomic, strong) FMDatabaseQueue *dbQueue; //数据库队列

+ (instancetype)sharedInstance;

/**
 打开数据库
 */
- (void)openDatabase;

/**
 关闭数据库
 */
- (void)closeDatabase;

/**
 创建数据表
 */
- (void)createTable:(NSString *)sqlString;

/**
 删除数据表
 */
- (void)deleteTable:(NSString *)tableName;

- (void)executeSql:(NSString *)sql;

- (void)executeUpdateSql:(NSString *)updateSql;

@end
