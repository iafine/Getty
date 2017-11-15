//
//  HYDBManager.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/10.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDBManager : NSObject

@property (nonatomic, strong) FMDatabase *db;   // 数据库
@property (nonatomic, strong) FMDatabaseQueue *dbQueue; //数据库队列

+ (instancetype)sharedInstance;

/**
 插入操作
 */
- (void)executeInsetSQL:(NSString *)sqlString block:(void(^)(BOOL isSuccess, NSString *message))block;

/**
 删除操作
 */
- (void)executeDeleteSQL:(NSString *)sqlString block:(void(^)(BOOL isSuccess, NSString *message))block;

/**
 更新操作
 */
- (void)executeUpdateSQL:(NSString *)sqlString block:(void (^)(BOOL, NSString *))block;

/**
 查询操作
 */
- (void)executeQuerySQL:(NSString *)sqlString block:(void(^)(BOOL isSuccess, FMResultSet *rs, NSString *message))block;

/**
 批量处理SQL语句 (不使用事务)
 */
- (void)executeSqlList:(NSArray *)sqlList db:(FMDatabase *)db block:(void(^)(BOOL isSuccess, NSString *message))block;

@end
