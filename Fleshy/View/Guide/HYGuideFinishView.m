//
//  HYGuideFinishView.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/9.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYGuideFinishView.h"
#import "HYPlan.h"

NSString *const HYGuideFinishBtnEvent = @"HYGuideFinishBtnEvent";

// tableView标示
static NSString *const kTableViewIdentify = @"HYGuideFinishTableCell";

@interface HYGuideFinishView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, strong) UIButton *finishBtn;

// 数据源
@property (nonatomic, strong) HYPlan *plan;

@end

@implementation HYGuideFinishView

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
    [self addSubview:self.titleLabel];
    [self addSubview:self.tipLabel];
    [self addSubview:self.tableView];
    [self addSubview:self.finishBtn];
}

- (void)initLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(15);
        make.height.mas_equalTo(@44);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(@30);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(20);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.finishBtn.mas_top).offset(5);
    }];
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
}

#pragma mark - Public Methods
- (void)refreshView {
    self.finishBtn.backgroundColor = kMainColor;
}

- (void)reloadData:(HYPlan *)plan {
    self.plan = plan;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 60;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kTableViewIdentify];
        cell.textLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = self.plan.planName;
    }else if (indexPath.row == 1) {
        cell.detailTextLabel.text = [self.plan.startTime stringWithFormat:@"HH:mm"];
    }else if (indexPath.row == 2) {
        cell.detailTextLabel.text = [self.plan.endTime stringWithFormat:@"HH:mm"];
    }else if (indexPath.row == 3) {
        cell.detailTextLabel.text = [self.plan.endTime hy_timeintervalWithBeforeDate:self.plan.startTime];
    }else if (indexPath.row == 4) {
        cell.detailTextLabel.text = [self.plan stringDuration];
    }else {
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Events
- (void)clickedFinishBtnHandler {
    [self hy_routerEventWithName:HYGuideFinishBtnEvent userInfo:nil];
}

#pragma mark - Setter and Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kTextSizeLarge weight:UIFontWeightBold];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.text = @"恭喜您";
    }
    return _titleLabel;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        _tipLabel.textColor = kDeepGrayColor;
        _tipLabel.adjustsFontSizeToFitWidth = YES;
        _tipLabel.text = @"计划已制定，点击完成开启一条新征程吧";
    }
    return _tipLabel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray =@[@"计划名称", @"计划开始时间", @"计划结束时间", @"计划每天持续时间", @"计划持续天数"];
    }
    return _dataArray;
}

- (UIButton *)finishBtn {
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishBtn.backgroundColor = kMainColor;
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:kTextSizeBig];
        _finishBtn.layer.cornerRadius = 20;
        _finishBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_finishBtn addTarget:self action:@selector(clickedFinishBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}

@end
