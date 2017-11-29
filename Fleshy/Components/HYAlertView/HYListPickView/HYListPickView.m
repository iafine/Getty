//
//  HYListPickView.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/28.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYListPickView.h"

@interface HYListPickView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HYListPickView

- (instancetype)initDatePickerView:(NSString *)title dataArray:(NSArray *)dataArray {
    self = [super initWithFrame:kScreenBounds];
    if (self) {
        // 初始化基础控件
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.dataArray = dataArray;
        self.titleLabel.text = title;
        [self addSubview:self.tableView];
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    CGRect newFrame = CGRectMake(0, kScreenHeight, kScreenWidth, self.dataArray.count * 50 + 35);
    self.tableView.frame = newFrame;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

- (void)show {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.tableView.frame = CGRectMake(0, (kScreenHeight - CGRectGetHeight(self.tableView.frame)), kScreenWidth, CGRectGetHeight(self.tableView.frame));
    } completion:^(BOOL finished){
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.tableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, CGRectGetHeight(self.tableView.frame));
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 50;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HYListPickViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HYListPickViewCell"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:kTextSizeMedium];
        cell.textLabel.textColor = kTitleColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    if ([self.delegate respondsToSelector:@selector(listPicker:didSelectdRow:)]) {
        [self.delegate listPicker:self didSelectdRow:[self.dataArray objectAtIndex:indexPath.row]];
    }
    [self dismiss];
}

#pragma mark - Setter and Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.tableHeaderView = self.titleLabel;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:kTextSizeExtraSmall];
        _titleLabel.textColor = kTitleColor;
    }
    return _titleLabel;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

@end

