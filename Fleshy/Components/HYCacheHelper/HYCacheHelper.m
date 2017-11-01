//
//  HYCacheHelper.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/1.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYCacheHelper.h"
#import "YYCache.h"

static NSString *const kHYCacheKey = @"kHYCacheKey";

static YYCache *_yycache;

@implementation HYCacheHelper

#pragma mark - Public Methods
+ (void)initialize {
    _yycache = [YYCache cacheWithName:kHYCacheKey];
}

+ (void)setCacheValue:(id)value cacheKey:(NSString *)cacheKey cacheType:(HYCacheType)cacheType {
    if (HYCacheDisk == cacheType) {
        // 设置磁盘缓存
        [_yycache.diskCache setObject:value forKey:cacheKey];
    }else {
        // 设置内存缓存
        [_yycache.memoryCache setObject:value forKey:cacheKey];
    }
}

+ (id)cacheValueForKey:(NSString *)cacheKey cacheType:(HYCacheType)cacheType {
    if (HYCacheDisk == cacheType) {
        // 读取磁盘缓存
        return [_yycache.diskCache objectForKey:cacheKey];
    }else {
        return [_yycache.memoryCache objectForKey:cacheKey];
    }
}

@end
