//
//  HYCacheHelper.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/1.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 缓存类型

 - HYCacheMemory: 内存缓存
 - HYCacheDisk: 磁盘缓存
 */
typedef NS_ENUM(NSUInteger, HYCacheType) {
    HYCacheMemory,
    HYCacheDisk,
};

@interface HYCacheHelper : NSObject

/**
 设置缓存

 @param value 缓存值
 @param cacheKey 缓存key
 @param cacheType 缓存类型
 */
+ (void)setCacheValue:(id)value cacheKey:(NSString *)cacheKey cacheType:(HYCacheType)cacheType;

/**
 读取缓存值

 @param cacheKey 缓存key
 @return 缓存值
 */
+ (id)cacheValueForKey:(NSString *)cacheKey cacheType:(HYCacheType)cacheType;

@end
