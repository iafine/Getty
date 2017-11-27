//
//  HYHomeViewController.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/27.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYHomeViewController.h"
#import "HYHomePlanCell.h"
#import "HYPerformance+Database.h"
#import "HYPlanDetailController.h"
#import "HYHomePushAnimator.h"

@interface HYHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation HYHomeViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Fleshy";
    
    [self.view addSubview:self.tableView];
    [self layoutSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [HYHomePlanCell cellHeight];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    HYHomePlanCell *cell = [HYHomePlanCell cellWithTableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Private Methods
- (void)refreshData {
//    [self.view hy_showLoading];
//    [HYPerformance database_queryThreeDaysFromNowPerformances:^(BOOL isSuccess, NSArray<HYPerformance *> *array, NSString *message) {
//        [self.view hy_hideLoading];
//        if (array.count > 0) {
//            // 刷新数据
//            self.dataArray = array;
//            [self.collectionView reloadData];
//
//            // 滚动到今天的位置
//            if (self.dataArray.count > 4) {
//                NSInteger index = self.dataArray.count - 4;
//                [self.collectionView hy_scrollToIndex:index animated:NO];
//            }
//        }
//    }];
}

#pragma mark - Setter and Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

@end
