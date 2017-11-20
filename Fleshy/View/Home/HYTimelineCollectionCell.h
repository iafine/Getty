//
//  HYTimelineCollectionCell.h
//  Fleshy
//
//  Created by Hyyy on 2017/10/26.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYPerformance;
@interface HYTimelineCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIView *radiusBgView;

+ (NSString *)cellID;

@property (nonatomic, strong) HYPerformance *cellData;

@end
