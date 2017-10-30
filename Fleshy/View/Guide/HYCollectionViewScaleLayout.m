//
//  HYCollectionViewScaleLayout.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/30.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYCollectionViewScaleLayout.h"

static CGFloat const kScale = 1.3;

@implementation HYCollectionViewScaleLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 取出默认的 UICollectionViewLayoutAttributes 数组
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    // 计算当前屏幕的中点X
    CGFloat centerX = self.collectionView.contentOffset.x + 0.5 * self.collectionView.frame.size.width;
    // 遍历数组
    for (UICollectionViewLayoutAttributes *attributes in array) {
        // 屏幕对应的 contentView 区域
        CGRect collctionViewRect;
        collctionViewRect.size = self.collectionView.frame.size;
        collctionViewRect.origin = self.collectionView.contentOffset;
        // 判断 cell 与屏幕区域是否相交,避免计算超出屏幕外的部分，提高性能
        if (!CGRectIntersectsRect(collctionViewRect, attributes.frame)) continue;
        // 计算比例
        CGFloat scale = 1 + (kScale - 1) * (1 - ABS(attributes.center.x - centerX) / (0.5 * self.collectionView.frame.size.width));
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

@end
