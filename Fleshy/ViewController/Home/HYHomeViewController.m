//
//  HYHomeViewController.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/27.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYHomeViewController.h"
#import "HYTimelineCollectionCell.h"
#import "HYPerformance+Database.h"
#import "HYTopAlertView.h"

@interface HYHomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation HYHomeViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kPageBgColor;
    
    [self.view addSubview:self.collectionView];
    
    // 滚动到最后一个item
//    [self.collectionView hy_scrollToHorizontalEnd:NO];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:HYPlanInitialSuccessNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self refreshData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self refreshData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYTimelineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HYTimelineCollectionCell cellID] forIndexPath:indexPath];
    cell.cellData = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        return nil;
    }else {
        return nil;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [UIView hy_showToast:@"提示" message:@"计划名称不合规。"];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 15);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth - 30, kScreenHeight - 80);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

#pragma mark - Private Methods
- (void)refreshData {
    [self.view hy_showLoading];
    [HYPerformance database_queryAllPerformance:^(BOOL isSuccess, NSArray<HYPerformance *> *array, NSString *message) {
        [self.view hy_hideLoading];
        if (array.count > 0) {
            // 刷新数据
            self.dataArray = array;
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - Setter and Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:kScreenBounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[HYTimelineCollectionCell class] forCellWithReuseIdentifier:[HYTimelineCollectionCell cellID]];
    }
    return _collectionView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

@end
