//
//  HYHomePlanCell.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/26.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYHomePlanCell.h"

@interface HYHomePlanCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation HYHomePlanCell

#pragma mark - LifeCycle
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    // 修改cell类型为定义类型
    HYHomePlanCell *cell = [tableView dequeueReusableCellWithIdentifier:[HYHomePlanCell ID]];
    if (cell == nil){
        cell = [[HYHomePlanCell alloc] init];
        
        // 初始化
        [cell initCellUI];
        [cell initCellLayout];
    }
    return cell;
}

/**
 *  初始化视图
 */
- (void)initCellUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.descLabel];
}

- (void)initCellLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.height.mas_equalTo(35);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.mas_equalTo(35);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.height.mas_equalTo(70);
    }];
}

#pragma mark - Public Methods
+ (NSString *)ID{
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight{
    return 140;
}

#pragma mark - Setter and Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kTextSizeMedium];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = kTitleColor;
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = @"测试标题";
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = kDescColor;
        _timeLabel.text = @"9:00-10:00";
    }
    return _timeLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.textColor = kDescColor;
        _descLabel.numberOfLines = 0;
        _descLabel.text = @"计划持续60天，每天持续1小时30分钟";
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

- (void)setCellData:(NSDictionary *)cellData {
    _cellData = cellData;

//    self.dateLabel.text = [cellData.performDate stringWithFormat:@"MM月dd日"];
//    if ([cellData.performDate isToday]) {
//        // 如果是今天的计划
//        self.weekLabel.text = @"今天";
//        self.radiusBgView.backgroundColor = kMainColor;
//        self.radiusBgView.layer.borderColor = kMainColor.CGColor;
//    } else if ([cellData.performDate hy_isBeforeToday]) {
//        // 如果是之前的计划
//        self.weekLabel.text = [cellData.performDate hy_stringWeekday];
//        self.radiusBgView.backgroundColor = kBgGrayColor;
//        self.radiusBgView.layer.borderColor = kBgGrayColor.CGColor;
//    } else {
//        // 如果是之后的计划
//        self.weekLabel.text = [cellData.performDate hy_stringWeekday];
//        self.radiusBgView.backgroundColor = kMainColor;
//        self.radiusBgView.layer.borderColor = kMainColor.CGColor;
//    }
//
//    [HYPlan database_queryPlanWithPerformanceId:cellData.performanceId block:^(BOOL isSuccess, HYPlan *plan, NSString *message) {
//        self.startTimeLabel.text = [plan.startTime stringWithFormat:@"HH:mm"];
//        self.endTimeLabel.text = [plan.endTime stringWithFormat:@"HH:mm"];
//        if ([cellData.performDate isToday]) {
//            self.descLabel.text = [NSString stringWithFormat:@"距离开始还有%@，共持续%@", [cellData.performDate hy_timeintervalWithBeforeDate:[NSDate new]], [plan.endTime hy_timeintervalWithBeforeDate:plan.startTime]];
//        }else if ([cellData.performDate hy_isBeforeToday]) {
//            self.descLabel.text = cellData.isPerform ? @"已完成" : @"未完成";
//        }else {
//            self.descLabel.text = @"暂未开放";
//        }
//    }];
}

@end
