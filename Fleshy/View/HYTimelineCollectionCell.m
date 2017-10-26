//
//  HYTimelineCollectionCell.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/26.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYTimelineCollectionCell.h"

@interface HYTimelineCollectionCell ()

@end

@implementation HYTimelineCollectionCell

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initLayout];
    }
    return self;
}

- (void)initUI {
}

- (void)initLayout {
}

#pragma mark - Public Methods
+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

#pragma mark - Setter and Getter

@end
