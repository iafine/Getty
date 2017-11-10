//
//  HYDatabaseManager.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/10.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYDatabaseManager.h"


@interface HYDatabaseManager ()

@end

@implementation HYDatabaseManager

+ (instancetype)sharedInstance {
    static HYDatabaseManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HYDatabaseManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 进行初始化操作
    }
    return self;
}

@end
