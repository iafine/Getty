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
#import "HYPlanInsertController.h"

@interface HYHomeViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, DZNEmptyDataSetSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *plusBtn;

@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation HYHomeViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Fleshy";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStyleDone target:self action:@selector(clickedBackBtnHandler)];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.plusBtn];
    [self layoutSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 查询计划表数据
    [HYPlan database_queryAllPlan:^(BOOL isSuccess, NSArray<HYPlan *> *array, NSString *message) {
        if (array.count > 0) {
            self.dataArray = array.copy;
            [self.tableView reloadData];
        }
    }];
}

- (void)layoutSubViews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self.plusBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-44);
        make.size.mas_equalTo(CGSizeMake(60, 60));
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
    return [HYHomePlanCell cellHeight];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    HYHomePlanCell *cell = [HYHomePlanCell cellWithTableView:tableView];
    cell.cellData = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"选中");
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(velocity.y > 0) {
        // 上滑取消加号按钮显示
        if (self.plusBtn.alpha != 0) {
            CGRect newFrame = CGRectMake(CGRectGetMinX(self.plusBtn.frame), CGRectGetMinY(self.plusBtn.frame) + 120, CGRectGetWidth(self.plusBtn.frame), CGRectGetHeight(self.plusBtn.frame));
            [UIView animateWithDuration:0.15 animations:^{
                self.plusBtn.frame = newFrame;
                self.plusBtn.alpha = 0;
            } completion:^(BOOL finished) {
                
            }];
        }
    }else {
        // 下滑显示按钮加号
        if (self.plusBtn.alpha == 0) {
            CGRect newFrame = CGRectMake(CGRectGetMinX(self.plusBtn.frame), CGRectGetMinY(self.plusBtn.frame) - 120, CGRectGetWidth(self.plusBtn.frame), CGRectGetHeight(self.plusBtn.frame));
            [UIView animateWithDuration:0.15 animations:^{
                self.plusBtn.frame = newFrame;
                self.plusBtn.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"还没有创建过计划";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:kTextSizeMedium],
                                 NSForegroundColorAttributeName:kTitleColor
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"点击下方+号按钮，来快速创建一个计划吧，开启一段新的体验！";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:kTextSizeSlightSmall],
                                 NSForegroundColorAttributeName:kDescColor,
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - Events
- (void)clickedBackBtnHandler {
    
}

- (void)touchedDownPlusBtnHandler {
    CGFloat scale = 0.9;
    [UIView animateWithDuration:0.15 animations:^{
        self.plusBtn.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}

- (void)clickedPlusBtnHandler {
    [UIView animateWithDuration:0.15 animations:^{
        self.plusBtn.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 执行动作响应，注册通知
        UINavigationController *insertNav = [[UINavigationController alloc] initWithRootViewController:[HYPlanInsertController new]];
        [self presentViewController:insertNav animated:YES completion:nil];
    }];
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
        _tableView.emptyDataSetSource = self;
        _tableView.backgroundColor = kTableBackgroundColor;
        _tableView.separatorColor = kTableBackgroundColor;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIButton *)plusBtn {
    if (!_plusBtn) {
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn setTitle:@"+" forState:UIControlStateNormal];
        [_plusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _plusBtn.titleLabel.font = [UIFont systemFontOfSize:50 weight:UIFontWeightThin];
        _plusBtn.backgroundColor = kMainColor;
        _plusBtn.layer.cornerRadius = 30;
        _plusBtn.layer.shadowOpacity = 0.5;
        _plusBtn.layer.shadowColor = kMainColor.CGColor;
        _plusBtn.layer.shadowOffset = CGSizeMake(0, 0);
        [_plusBtn addTarget:self action:@selector(touchedDownPlusBtnHandler) forControlEvents:UIControlEventTouchDown];
        [_plusBtn addTarget:self action:@selector(clickedPlusBtnHandler) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        _plusBtn.contentEdgeInsets = UIEdgeInsetsMake(-8, 0, 0, 0);
    }
    return _plusBtn;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

@end
