//
//  HYTimelineCollectionCell.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/26.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYTimelineCollectionCell.h"

@interface HYTimelineCollectionCell ()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *weekLabel;
@property (nonatomic, strong) UIView *radiusBgView;

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
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.weekLabel];
    [self.contentView addSubview:self.radiusBgView];
}

- (void)initLayout {
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(120, 60));
    }];
    [self.radiusBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.weekLabel.mas_bottom).offset(5);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
}

#pragma mark - Public Methods
+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

#pragma mark - Setter and Getter
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:kTextSizeTiny weight:UIFontWeightHeavy];
        _dateLabel.text = @"10月27日";
        _dateLabel.textColor = kDeepGrayColor;
    }
    return _dateLabel;
}

- (UILabel *)weekLabel {
    if (!_weekLabel) {
        _weekLabel = [[UILabel alloc] init];
        _weekLabel.font = [UIFont systemFontOfSize:kTextSizeHuge weight:UIFontWeightHeavy];
        _weekLabel.textColor = kBlackColor;
        _weekLabel.text = @"星期四";
    }
    return _weekLabel;
}

- (UIView *)radiusBgView {
    if (!_radiusBgView) {
        _radiusBgView = [[UIView alloc] init];
        _radiusBgView.layer.cornerRadius = 10;
    }
    return _radiusBgView;
}

- (void)setCellData:(NSDictionary *)cellData {
    _cellData = cellData;
    
    self.radiusBgView.backgroundColor = kRandomColor;
}

@end
