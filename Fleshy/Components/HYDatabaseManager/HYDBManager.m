//
//  HYDBManager.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/10.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYDBManager.h"
#import "HYDBDefine.h"

NSString *const HYDatabaseName = @"fleshy.sqlite";

@interface HYDBManager ()

@end

@implementation HYDBManager

+ (void)load {
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [HYDBManager sharedInstance];
         [[NSNotificationCenter defaultCenter] removeObserver:observer];
     }];
}

+ (instancetype)sharedInstance {
    static HYDBManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HYDBManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSFileManager * fmManger = [NSFileManager defaultManager];
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * dbPath = [NSString stringWithFormat:@"%@/%@",[paths count] > 0 ? paths.firstObject : nil, HY_DB_NAME];
        if (![fmManger fileExistsAtPath:dbPath]) {
            [fmManger createFileAtPath:dbPath contents:nil attributes:nil];
        }
        
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [self updateDBVersion];
    }
    return self;
}

- (void)updateDBVersion {
    //执行数据库更新
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [self getCurrentDbVersion:db withBlock:^(BOOL isSuccess, int version) {
            if (isSuccess && (HY_DB_VERSION > version || HY_DB_VERSION == 0)) {
                // 如果本地数据库版本需要升级
                [self executeSqlList:[self tableSqlArray] db:db block:^(BOOL isSuccess, NSString *message) {
                    if (isSuccess) {
                        // 设置新的数据库版本号
                        [self setNewDbVersionWithDB:db withBlock:^(BOOL isSuccess) {
                            if (isSuccess) {
                                NSLog(@"数据库新版本成功设置");
                            }
                        }];
                    }
                }];
            }
        }];
        
    }];
}

-(void)setNewDbVersionWithDB:(FMDatabase *)db withBlock:(void(^)(BOOL isSuccess))block {
    NSString *sql = [NSString stringWithFormat:@"PRAGMA user_version = %ld",(long)HY_DB_VERSION];
    BOOL isSuccess = [db executeUpdate:sql];
    if ([db hadError]) {
        NSLog(@"get db version error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    block(isSuccess);
}

- (void)getCurrentDbVersion:(FMDatabase *)db withBlock:(void(^)(BOOL isSuccess,int version))block{
    NSString * sql = [NSString stringWithFormat:@"PRAGMA user_version"];
    FMResultSet * rs = [db executeQuery:sql];
    int nVersion = 0;
    while ([rs next]) {
        nVersion = [rs intForColumn:@"user_version"];
    }
    [rs close];
    if ([db hadError]) {
        NSLog(@"get db version error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        block(NO,-1);
        return;
    }
    block(YES,nVersion);
}

#pragma mark - Public Methods
- (void)executeInsetSQL:(NSString *)sqlString block:(void (^)(BOOL, NSString *))block {
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        BOOL isSuccess = [db executeUpdate:sqlString];
        if ([db hadError]) {
            block(NO, [db lastErrorMessage]);
            NSLog(@"executeSQL error %d:  %@",[db lastErrorCode],[db lastErrorMessage]);
        }else{
            block(isSuccess, nil);
        }
    }];
}

- (void)executeDeleteSQL:(NSString *)sqlString block:(void (^)(BOOL, NSString *))block {
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        BOOL isSuccess = [db executeUpdate:sqlString];
        if ([db hadError]) {
            block(NO, [db lastErrorMessage]);
            NSLog(@"executeSQL error %d:  %@",[db lastErrorCode],[db lastErrorMessage]);
        }else{
            block(isSuccess, nil);
        }
    }];
}

- (void)executeUpdateSQL:(NSString *)sqlString block:(void (^)(BOOL, NSString *))block {
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        BOOL isSuccess = [db executeUpdate:sqlString];
        if ([db hadError]) {
            block(NO, [db lastErrorMessage]);
            NSLog(@"executeSQL error %d:  %@",[db lastErrorCode],[db lastErrorMessage]);
        }else{
            block(isSuccess, nil);
        }
    }];
}

- (void)executeQuerySQL:(NSString *)sqlString block:(void (^)(BOOL, FMResultSet *, NSString *))block {
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        FMResultSet *rs = [db executeQuery:sqlString];
        if ([db hadError]) {
            block(NO, rs, [db lastErrorMessage]);
            NSLog(@"executeSQL error %d:  %@",[db lastErrorCode],[db lastErrorMessage]);
        }else {
            block(YES, rs, nil);
        }
    }];
}

- (void)executeSqlList:(NSArray *)sqlList db:(FMDatabase *)db block:(void(^)(BOOL isSuccess, NSString *message))block {
    __block BOOL isSuccess = NO;
    for (NSString * sqlString in sqlList) {
        isSuccess = [db executeUpdate:sqlString];
        if ([db hadError]) {
            block(isSuccess,[db lastErrorMessage]);
            NSLog(@"executeSQLList error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            break;
        }
    }
    block(isSuccess,nil);
}

#pragma mark - Private Methods
- (NSArray *)tableSqlArray {
    NSMutableArray *mutableArray = [NSMutableArray array];
    [mutableArray addObject:HY_CREATE_PALN];
    [mutableArray addObject:HY_CREATE_PERFORMANCE];
    return mutableArray.copy;
}

@end
