//
//  HYPlanEditController.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/28.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPlanEditController.h"
#import "HYPlanEditCell.h"
#import "HYDatePickerView.h"
#import "HYListPickView.h"

@interface HYPlanEditController ()<UITableViewDelegate, UITableViewDataSource, HYDatePickerViewDelegate, HYPlanEditCellDelegate, HYListPickViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *placeholderArray;

@end

@implementation HYPlanEditController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initNavigationItem];
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

- (void)initNavigationItem {
    if (self.operateType == HYPlanDetailOperateInsert) {
        // 添加页面
        self.navigationItem.title = @"添加";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickedSaveBtnHandler)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStyleDone target:self action:@selector(clickedBackBtnHandler)];
    }else {
        // 编辑页面
        self.navigationItem.title = self.plan.planName;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更新" style:UIBarButtonItemStylePlain target:self action:@selector(clickedUpdateBtnHandler)];
    }
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
    HYPlanEditCell *cell = [HYPlanEditCell cellWithTableView:tableView cellStyle:(indexPath.section == 0 ? HYPlanEditCellStyleEdit : HYPlanEditCellStyleLabel)];
    cell.delegate = self;
    if (indexPath.section == 0) {
        if (self.plan.planName.length) {
            cell.textField.text = self.plan.planName;
        }else {
            cell.textField.placeholder = [self.placeholderArray objectAtIndex:indexPath.section];
        }
    }else if (indexPath.section == 1) {
        cell.titleLabel.text = self.plan.startTime ? [self.plan.startTime stringWithFormat:@"HH:mm"] : [self.placeholderArray objectAtIndex:indexPath.section];
    }else if (indexPath.section == 2) {
        cell.titleLabel.text = self.plan.endTime ? [self.plan.endTime stringWithFormat:@"HH:mm"] : [self.placeholderArray objectAtIndex:indexPath.section];
    }else if (indexPath.section == 3) {
        cell.titleLabel.text = self.plan.durationDays > 0 ? [NSString stringWithFormat:@"%ld天", self.plan.durationDays] : [self.placeholderArray objectAtIndex:indexPath.section];
    }else {
        
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
    
    if (indexPath.section == 1) {
        HYDatePickerView *datePicker = [[HYDatePickerView alloc] initDatePickerView];
        datePicker.tag = 1001;
        datePicker.delegate = self;
        [datePicker show];
    }else if (indexPath.section == 2) {
        // 先判断开始时间有没有选中
        if (self.plan.startTime) {
            HYDatePickerView *datePicker = [[HYDatePickerView alloc] initDatePickerView];
            datePicker.tag = 1002;
            datePicker.delegate = self;
            [datePicker show];
        }else {
            [UIView hy_showToast:@"提示" message:@"请先选择开始时间"];
        }
    }else if (indexPath.section == 3) {
        HYListPickView *listPicker = [[HYListPickView alloc] initDatePickerView:@"请选择持续时间" dataArray:@[@"15天", @"30天", @"45天", @"60天"]];
        listPicker.delegate = self;
        [listPicker show];
    }else {
        
    }
}

#pragma mark - HYDatePickerViewDelegate
- (void)datePicker:(HYDatePickerView *)pickerView didSelectdDate:(NSDate *)date {
    if (pickerView.tag == 1001) {
        // 开始时间
        self.plan.startTime = date;
    }else {
        // 如果结束时间小于开始时间，弹出提示
        if ([date earlierDate:self.plan.startTime] == date) {
            [UIView hy_showToast:@"提示" message:@"结束时间必须大于开始时间"];
            return;
        }
        self.plan.endTime = date;
    }
    [self.tableView reloadData];
}

#pragma mark - HYListPickViewDelegate
- (void)listPicker:(HYListPickView *)pickerView didSelectdRow:(NSString *)rowString {
    if ([@"15天" isEqualToString:rowString]) {
        self.plan.durationDays = 15;
    }else if ([@"30天" isEqualToString:rowString]) {
        self.plan.durationDays = 30;
    }else if ([@"45天" isEqualToString:rowString]) {
        self.plan.durationDays = 45;
    }else if ([@"60天" isEqualToString:rowString]) {
        self.plan.durationDays = 60;
    }else {
        
    }
    [self.tableView reloadData];
}

#pragma mark - HYPlanEditCellDelegate
- (void)textFieldDidChange:(UITextField *)textField {
    self.plan.planName = textField.text;
}

#pragma mark - Events
- (void)clickedBackBtnHandler {
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickedSaveBtnHandler {
    // 计划名称不匹配
    if (self.plan.planName.length == 0) {
        [UIView hy_showToast:@"提示" message:@"计划名称不能为空"];
        return;
    }
    // 开始时间不匹配
    if (self.plan.startTime == nil) {
        [UIView hy_showToast:@"提示" message:@"开始时间不能为空"];
        return;
    }
    // 结束时间不匹配
    if (self.plan.endTime == nil) {
        [UIView hy_showToast:@"提示" message:@"结束时间不能为空"];
        return;
    }
    // 持续时间不匹配
    if (self.plan.durationDays == 0) {
        [UIView hy_showToast:@"提示" message:@"持续时间不能为空"];
        return;
    }
    [self generatePlanData];
}

- (void)clickedUpdateBtnHandler {
    // 计划名称不匹配
    if (self.plan.planName.length == 0) {
        [UIView hy_showToast:@"提示" message:@"计划名称不能为空"];
        return;
    }
    // 开始时间不匹配
    if (self.plan.startTime == nil) {
        [UIView hy_showToast:@"提示" message:@"开始时间不能为空"];
        return;
    }
    // 结束时间不匹配
    if (self.plan.endTime == nil) {
        [UIView hy_showToast:@"提示" message:@"结束时间不能为空"];
        return;
    }
    // 持续时间不匹配
    if (self.plan.durationDays == 0) {
        [UIView hy_showToast:@"提示" message:@"持续时间不能为空"];
        return;
    }
    [self updatePlanDate];
}

#pragma mark - Private Methods
- (void)generatePlanData {
    // 生成一条计划数据，然后创建多条执行数据与之对应
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // 获取每天持续时间
    self.plan.durationTime = [self.plan.endTime hy_minutesIntervalWithBeforeDate:self.plan.startTime];
    
    [HYPlan databasae_insertPlan:self.plan block:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            // 查询该条数据
            [HYPlan database_queryPlan:self.plan.planName block:^(BOOL isSuccess, HYPlan *plan, NSString *message) {
                if (isSuccess) {
                    // 插入成功，创建执行数据集
                    NSMutableArray *array = [NSMutableArray array];
                    for (int i=1; i<=plan.durationDays; i++) {
                        HYPerformance *performance = [[HYPerformance alloc] init];
                        performance.planId = plan.planId;
                        performance.performDate = [plan.startTime dateByAddingDays:i];
                        [array addObject:performance];
                    }
                    [HYPerformance database_insertPerformances:array block:^(BOOL isSuccess, NSString *message) {
                        [hud hideAnimated:YES];
                        if (isSuccess) {
                            // 生成计划通知
                            
                            [self clickedBackBtnHandler];
                        }else {
                            [UIView hy_showToast:@"提示" message:@"生成执行数据失败，请返回重新操作"];
                        }
                    }];
                }else {
                    [hud hideAnimated:YES];
                    [UIView hy_showToast:@"提示" message:@"生成计划数据失败，请返回重新操作"];
                }
            }];
        }else {
            [hud hideAnimated:YES];
            [UIView hy_showToast:@"提示" message:@"生成计划数据失败，请返回重新操作"];
        }
    }];
}

- (void)updatePlanDate {
    // 生成一条计划数据，然后创建多条执行数据与之对应
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // 获取每天持续时间
    self.plan.durationTime = [self.plan.endTime hy_minutesIntervalWithBeforeDate:self.plan.startTime];
    
    [HYPlan database_updatePlan:self.plan block:^(BOOL isSuccess, NSString *message) {
        [hud hideAnimated:YES];
        if (isSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
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

- (HYPlan *)plan {
    if (!_plan) {
        _plan = [[HYPlan alloc] init];
    }
    return _plan;
}

@end
