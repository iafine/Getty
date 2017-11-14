//
//  HYDBManager.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/10.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDBManager : NSObject

@property (nonatomic, strong) FMDatabaseQueue *dbQueue; //数据库队列

+ (instancetype)sharedInstance;

/**
 批量处理SQL语句
 */
- (void)executeSqlList:(NSArray *)sqlList db:(FMDatabase *)db block:(void(^)(BOOL isSuccess, NSString *message))block;

@end
