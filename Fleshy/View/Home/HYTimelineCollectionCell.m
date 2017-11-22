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

@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UIView *seperatorView;
@property (nonatomic, strong) UILabel *descLabel;

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
    
    [self.radiusBgView addSubview:self.startTimeLabel];
    [self.radiusBgView addSubview:self.seperatorView];
    [self.radiusBgView addSubview:self.endTimeLabel];
    [self.radiusBgView addSubview:self.descLabel];
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
    [self.startTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.seperatorView.mas_top).offset(-35);
        make.centerX.equalTo(self.radiusBgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    [self.seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.radiusBgView.mas_centerX);
        make.centerY.equalTo(self.radiusBgView.mas_centerY).offset(-35);
        make.size.mas_equalTo(CGSizeMake(1, 180));
    }];
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seperatorView.mas_bottom).offset(35);
        make.centerX.equalTo(self.radiusBgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.radiusBgView.mas_left).offset(15);
        make.right.equalTo(self.radiusBgView.mas_right).offset(-15);
        make.bottom.equalTo(self.radiusBgView.mas_bottom).offset(-35);
        make.height.mas_equalTo(35);
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
        _dateLabel.textColor = kDeepGrayColor;
    }
    return _dateLabel;
}

- (UILabel *)weekLabel {
    if (!_weekLabel) {
        _weekLabel = [[UILabel alloc] init];
        _weekLabel.font = [UIFont systemFontOfSize:kTextSizeHuge weight:UIFontWeightHeavy];
        _weekLabel.textColor = kBlackColor;
    }
    return _weekLabel;
}

- (UIView *)radiusBgView {
    if (!_radiusBgView) {
        _radiusBgView = [[UIView alloc] init];
        _radiusBgView.backgroundColor = kMainColor;
        _radiusBgView.layer.cornerRadius = 10;
        _radiusBgView.layer.borderWidth = 0.5;
        _radiusBgView.layer.masksToBounds = YES;
        _radiusBgView.userInteractionEnabled = YES;
    }
    return _radiusBgView;
}

- (UILabel *)startTimeLabel {
    if (!_startTimeLabel) {
        _startTimeLabel = [[UILabel alloc] init];
        _startTimeLabel.font = [UIFont systemFontOfSize:kTextSizeHuge];
        _startTimeLabel.textAlignment = NSTextAlignmentCenter;
        _startTimeLabel.textColor = [UIColor whiteColor];
    }
    return _startTimeLabel;
}

- (UILabel *)endTimeLabel {
    if (!_endTimeLabel) {
        _endTimeLabel = [[UILabel alloc] init];
        _endTimeLabel.font = [UIFont systemFontOfSize:kTextSizeHuge];
        _endTimeLabel.textAlignment = NSTextAlignmentCenter;
        _endTimeLabel.textColor = [UIColor whiteColor];
    }
    return _endTimeLabel;
}

- (UIView *)seperatorView {
    if (!_seperatorView) {
        _seperatorView = [[UIView alloc] init];
        _seperatorView.backgroundColor = [UIColor whiteColor];
        _seperatorView.layer.cornerRadius = 0.5;
    }
    return _seperatorView;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        _descLabel.textColor = [UIColor whiteColor];
        _descLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _descLabel;
}

- (void)setCellData:(HYPerformance *)cellData {
    _cellData = cellData;

    self.dateLabel.text = [cellData.performDate stringWithFormat:@"MM月dd日"];
    if ([cellData.performDate isToday]) {
        // 如果是今天的计划
        self.weekLabel.text = @"今天";
        self.radiusBgView.backgroundColor = kMainColor;
        self.radiusBgView.layer.borderColor = kMainColor.CGColor;
    } else if ([cellData.performDate hy_isBeforeToday]) {
        // 如果是之前的计划
        self.weekLabel.text = [cellData.performDate hy_stringWeekday];
        self.radiusBgView.backgroundColor = kBgGrayColor;
        self.radiusBgView.layer.borderColor = kBgGrayColor.CGColor;
    } else {
        // 如果是之后的计划
        self.weekLabel.text = [cellData.performDate hy_stringWeekday];
        self.radiusBgView.backgroundColor = kMainColor;
        self.radiusBgView.layer.borderColor = kMainColor.CGColor;
    }
    
    [HYPlan database_queryPlanWithPerformanceId:cellData.performanceId block:^(BOOL isSuccess, HYPlan *plan, NSString *message) {
        self.startTimeLabel.text = [plan.startTime stringWithFormat:@"HH:mm"];
        self.endTimeLabel.text = [plan.endTime stringWithFormat:@"HH:mm"];
        if ([cellData.performDate isToday]) {
            self.descLabel.text = [NSString stringWithFormat:@"距离开始还有%@，共持续%@", [cellData.performDate hy_timeintervalWithBeforeDate:[NSDate new]], [plan.endTime hy_timeintervalWithBeforeDate:plan.startTime]];
        }else if ([cellData.performDate hy_isBeforeToday]) {
            self.descLabel.text = cellData.isPerform ? @"已完成" : @"未完成";
        }else {
            self.descLabel.text = @"暂未开放";
        }
    }];
}

@end
