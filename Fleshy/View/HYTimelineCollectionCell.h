//
//  HYTimelineCollectionCell.h
//  Fleshy
//
//  Created by Hyyy on 2017/10/26.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYTimelineCollectionCell : UICollectionViewCell

+ (NSString *)cellID;

@property (nonatomic, strong) NSDictionary *cellData;

@end
