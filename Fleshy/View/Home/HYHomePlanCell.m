//
//  HYHomePlanCell.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/26.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYHomePlanCell.h"

@interface HYHomePlanCell ()

@property (nonatomic, strong) UIView *radiusBgView;
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
    self.backgroundColor = kTableBackgroundColor;
    
    [self.contentView addSubview:self.radiusBgView];
    [self.radiusBgView addSubview:self.titleLabel];
    [self.radiusBgView addSubview:self.timeLabel];
    [self.radiusBgView addSubview:self.descLabel];
}

- (void)initCellLayout {
    [self.radiusBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.radiusBgView.mas_top).offset(10);
        make.left.equalTo(self.radiusBgView.mas_left).offset(20);
        make.height.mas_equalTo(35);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.radiusBgView.mas_top).offset(10);
        make.right.equalTo(self.radiusBgView.mas_right).offset(-20);
        make.height.mas_equalTo(35);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.radiusBgView.mas_left).offset(20);
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
- (UIView *)radiusBgView {
    if (!_radiusBgView) {
        _radiusBgView = [[UIView alloc] init];
        _radiusBgView.backgroundColor = [UIColor whiteColor];
        _radiusBgView.layer.cornerRadius = 10;
    }
    return _radiusBgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kTextSizeMedium];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = kTitleColor;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = kDescColor;
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
    }
    return _descLabel;
}

- (void)setCellData:(HYPlan *)cellData {
    _cellData = cellData;
    
    self.titleLabel.text = cellData.planName;
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@", [cellData.startTime stringWithFormat:@"HH:mm"], [cellData.endTime stringWithFormat:@"HH:mm"]];
    self.descLabel.text = [NSString stringWithFormat:@"计划共持续%ld天，每天持续%ld分钟", cellData.durationDays, cellData.durationTime];
}

@end
