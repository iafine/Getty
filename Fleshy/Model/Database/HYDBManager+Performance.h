//
//  HYDBManager+Performance.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/13.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYDBManager.h"

@class HYPerformance;
@interface HYDBManager (Performance)

- (void)database_createPerformanceTable;

/**
 新增一条计划数据
 */
- (void)database_insertPerformance:(HYPerformance *)performance;

@end
