//
//  HYGuideChooseTimeView.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/30.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYGuideChooseTimeView.h"

NSString *const HYGuideChooseTimeNextEvent = @"HYGuideChooseTimeNextEvent";

// tableView标示
static NSString *const kTableViewIdentify = @"HYGuideChooseTableCell";

@interface HYGuideChooseTimeView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

// 计划名称
@property (nonatomic, strong) UITextField *nameField;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation HYGuideChooseTimeView

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
    [self addSubview:self.nextBtn];
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
        make.bottom.equalTo(self.nextBtn.mas_top).offset(5);
    }];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
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
    
    if (indexPath.row == 0) {
        // 计划名称
        [self openEditNameAlert];
    }
}

#pragma mark - Public Methods
- (void)refreshView {
    self.nextBtn.backgroundColor = kMainColor;
}

#pragma mark - Events
- (void)clickedNextBtnHandler {
    [self hy_routerEventWithName:HYGuideChooseTimeNextEvent userInfo:nil];
}

- (void)openEditNameAlert {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.borderStyle = UITextBorderStyleNone;
        textField.placeholder = @"请输入一个满意的名称";
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *finishAction = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:finishAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - Setter and Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kTextSizeLarge weight:UIFontWeightBold];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.text = @"制定计划";
    }
    return _titleLabel;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        _tipLabel.textColor = kDeepGrayColor;
        _tipLabel.adjustsFontSizeToFitWidth = YES;
        _tipLabel.text = @"一滴滴的坚持努力，才造就最后的蜕变";
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
        _dataArray =@[@"计划名称", @"开始时间", @"结束时间", @"持续时间"];
    }
    return _dataArray;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.backgroundColor = kMainColor;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:kTextSizeBig];
        _nextBtn.layer.cornerRadius = 20;
        _nextBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_nextBtn addTarget:self action:@selector(clickedNextBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

@end
