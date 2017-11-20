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

@property (nonatomic, strong) UILabel *titileLabel;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UILabel *durationLabel;

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
    [self.radiusBgView addSubview:self.titileLabel];
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
    [self.titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.radiusBgView.mas_top).offset(15);
        make.left.equalTo(self.radiusBgView.mas_left).offset(15);
        make.right.equalTo(self.radiusBgView.mas_right).offset(-15);
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
        _radiusBgView.layer.cornerRadius = 10;
        _radiusBgView.layer.borderWidth = 0.5;
        _radiusBgView.layer.borderColor = kBorderGrayColor.CGColor;
        _radiusBgView.layer.masksToBounds = YES;
        _radiusBgView.userInteractionEnabled = YES;
    }
    return _radiusBgView;
}

- (UILabel *)titileLabel {
    if (!_titileLabel) {
        _titileLabel = [[UILabel alloc] init];
        _titileLabel.font = [UIFont systemFontOfSize:kTextSizeHuge weight:UIFontWeightBold];
        _titileLabel.textAlignment = NSTextAlignmentCenter;
        _titileLabel.textColor = [UIColor whiteColor];
    }
    return _titileLabel;
}

- (UILabel *)startTimeLabel {
    if (!_startTimeLabel) {
        _startTimeLabel = [[UILabel alloc] init];
        _startTimeLabel.font = [UIFont systemFontOfSize:kTextSizeMedium];
    }
    return _startTimeLabel;
}

- (UILabel *)endTimeLabel {
    if (!_endTimeLabel) {
        _endTimeLabel = [[UILabel alloc] init];
        _endTimeLabel.font = [UIFont systemFontOfSize:kTextSizeMedium];
    }
    return _endTimeLabel;
}

- (UILabel *)durationLabel {
    if (!_durationLabel)  {
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.font = [UIFont systemFontOfSize:kTextSizeSmall];
    }
    return _durationLabel;
}

- (void)setCellData:(HYPerformance *)cellData {
    _cellData = cellData;
    
    self.radiusBgView.backgroundColor = kRandomColor;
    self.dateLabel.text = [cellData.performDate stringWithFormat:@"MM月dd日"];
    if ([cellData.performDate isToday]) {
        self.weekLabel.text = @"今天";
    }else {
        self.weekLabel.text = [cellData.performDate hy_stringWeekday];
    }
    
    [HYPlan database_queryPlanWithPerformanceId:cellData.performanceId block:^(BOOL isSuccess, HYPlan *plan, NSString *message) {
//        self.titileLabel.text = plan.planName;
    }];
}

@end
