//
//  UICollectionView+HYAdd.h
//  Fleshy
//
//  Created by Hyyy on 2017/10/27.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (HYAdd)

/**
 水平滚动，滚动到index位置 (适用于首页效果)
 */
- (void)hy_scrollToIndex:(NSInteger)index animated:(BOOL)animated;

@end
