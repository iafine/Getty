//
//  UICollectionView+HYAdd.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/27.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "UICollectionView+HYAdd.h"

@implementation UICollectionView (HYAdd)

- (void)hy_scrollToIndex:(NSInteger)index animated:(BOOL)animated {
    NSInteger sections = [self numberOfSections];
    if (sections < 1)   return;
    NSInteger items = [self numberOfItemsInSection:0];
    if (items < 1) return;
    CGFloat offsetX = index * kScreenWidth;
    [self setContentOffset:CGPointMake(offsetX, 0) animated:animated];
}

@end
