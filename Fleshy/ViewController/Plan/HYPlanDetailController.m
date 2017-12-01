//
//  HYPlanDetailController.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/30.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPlanDetailController.h"
#import "FSCalendar.h"

@interface HYPlanDetailController ()<FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *performArray;  // 全部的执行数据
@property (nonatomic, copy) NSArray *hasPerfromArray;    // 已经完成的执行数据

@property (nonatomic, copy) NSArray *titleArray;    // 标题数组
@property (nonatomic, assign) NSInteger totalDays;  // 总天数
@property (nonatomic, assign) NSInteger hasPerformDays; // 已完成天数
@property (nonatomic, assign) NSInteger restDays;   // 剩余天数

@end

@implementation HYPlanDetailController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"总览";
    
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

- (void)viewWillAppear:(BOOL)animated {
    // 查询执行表与之相关的所有数据
    [HYPerformance database_queryPerformances:self.plan.planId block:^(BOOL isSuccess, NSArray<HYPerformance *> *array, NSArray<HYPerformance *> *performArray, NSString *message) {
        if (array.count > 0) {
            self.performArray = array;
            self.hasPerfromArray = performArray;
            
            // 计算总天数、已完成天数、剩余天数
            self.totalDays = self.performArray.count;
            self.hasPerformDays = self.hasPerfromArray.count;
            NSDate *lastDate = [(HYPerformance *)[self.performArray lastObject] performDate];
            self.restDays = [lastDate hy_daysIntervalWithBeforeDate:[NSDate new]];
            
            [self.calendar reloadData];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        cell.textLabel.textColor = kTitleColor;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        cell.detailTextLabel.textColor = kDescColor;
    }
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld天", self.totalDays];
    }else if (indexPath.row == 1) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld天", self.hasPerformDays];
    }else if (indexPath.row == 2) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld天", self.restDays];
    }else {
        cell.detailTextLabel.text = @"";
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - FSCalendarDataSource
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    HYPerformance *performance = [self.performArray firstObject];
    return performance.performDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    HYPerformance *performance = [self.performArray lastObject];
    return performance.performDate;
}

#pragma mark - FSCalendarDelegateAppearance
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date {
    for (HYPerformance *performance in self.hasPerfromArray) {
        if ([performance.performDate hy_isSameDay:date]) {
            return kMainColor;
        }
    }
    return nil;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    for (HYPerformance *performance in self.hasPerfromArray) {
        if ([performance.performDate hy_isSameDay:date]) {
            return [UIColor whiteColor];
        }
    }
    return nil;
}

#pragma mark - FSCalendarDelegate
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    return NO;
}

#pragma mark - Setter and Getter
- (FSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 320)];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.backgroundColor = [UIColor whiteColor];
        _calendar.appearance.headerDateFormat = @"yyyy-MM";
        _calendar.appearance.headerTitleColor = kTitleColor;
        _calendar.appearance.headerMinimumDissolvedAlpha = 0;
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
        _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
        _calendar.appearance.weekdayTextColor = kTitleColor;
        _calendar.appearance.headerTitleColor = kTitleColor;
        _calendar.appearance.selectionColor = kDescColor;
        _calendar.appearance.titleDefaultColor = kTitleColor;
        _calendar.headerHeight = 60;
        _calendar.allowsSelection = YES;
    }
    return _calendar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kTableBackgroundColor;
        _tableView.separatorColor = kTableBackgroundColor;
        _tableView.tableHeaderView = self.calendar;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)performArray {
    if (!_performArray) {
        _performArray = [NSArray array];
    }
    return _performArray;
}

- (NSArray *)hasPerfromArray {
    if (!_hasPerfromArray) {
        _hasPerfromArray = [NSArray array];
    }
    return _hasPerfromArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"总天数", @"已完成天数", @"剩余天数"];
    }
    return _titleArray;
}

@end
