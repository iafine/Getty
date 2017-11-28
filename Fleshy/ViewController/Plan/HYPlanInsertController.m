//
//  HYPlanInsertController.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/28.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPlanInsertController.h"
#import "HYPlanInsertCell.h"
#import "HYDatePickerView.h"

@interface HYPlanInsertController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *placeholderArray;

@end

@implementation HYPlanInsertController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"添加";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickedSaveBtnHandler)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickedBackBtnHandler)];
    
    [self.view addSubview:self.tableView];
    [self layoutSubViews];
}

- (void)layoutSubViews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return self.placeholderArray.count;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    HYPlanInsertCell *cell = [HYPlanInsertCell cellWithTableView:tableView cellStyle:(indexPath.section == 0 ? HYPlanInsertCellStyleEdit : HYPLanInsertCellStyleLabel)];
    if (indexPath.section == 0) {
        cell.textField.placeholder = [self.placeholderArray objectAtIndex:indexPath.section];
    }else {
        cell.titleLabel.text = [self.placeholderArray objectAtIndex:indexPath.section];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, kScreenWidth-40, 20)];
    headerLabel.textColor = kDescColor;
    headerLabel.font = [UIFont systemFontOfSize:kTextSizeTiny];
    headerLabel.text = [self.titleArray objectAtIndex:section];
    [headerView addSubview:headerLabel];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HYDatePickerView *datePicker = [[HYDatePickerView alloc] initDatePickerView];
    [datePicker show];
}

#pragma mark - Events
- (void)clickedBackBtnHandler {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickedSaveBtnHandler {
    
}

#pragma mark - Setter and Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = kTableBackgroundColor;
        _tableView.backgroundColor = kTableBackgroundColor;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"标题", @"每天开始时间", @"每天结束时间", @"持续天数"];
    }
    return _titleArray;
}

- (NSArray *)placeholderArray {
    if (!_placeholderArray) {
        _placeholderArray = @[@"输入标题", @"选择开始时间", @"选择结束时间", @"选择持续天数"];
    }
    return _placeholderArray;
}

@end
