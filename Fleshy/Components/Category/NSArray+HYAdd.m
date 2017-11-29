//
//  NSArray+HYAdd.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/29.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "NSArray+HYAdd.h"

@implementation NSArray (HYAdd)

- (NSArray *)hy_removeObjectAtIndex:(NSInteger)index {
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self];
    [tempArray removeObjectAtIndex:index];

    return tempArray.copy;
}

@end
