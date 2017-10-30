//
//  HYGuideChooseTimeView.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/30.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYGuideChooseTimeView.h"
#import "HYGuideCTHeaderCell.h"
#import "HYCollectionViewScaleLayout.h"

@interface HYGuideChooseTimeView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionHeaderView;

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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 顶部居中
    CGFloat offsetX = (self.collectionHeaderView.collectionViewLayout.collectionViewContentSize.width - CGRectGetWidth(self.collectionHeaderView.frame))/2;
    [self.collectionHeaderView setContentOffset:CGPointMake(offsetX, 0)];
}

- (void)initUI {
    [self addSubview:self.collectionHeaderView];
    [self.collectionHeaderView setContentInset:UIEdgeInsetsMake(0, (CGRectGetWidth(self.collectionHeaderView.frame) - 200)/2, 0, (CGRectGetWidth(self.collectionHeaderView.frame) - 200)/2)];
}

- (void)initLayout {
    [self.collectionHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@180);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYGuideCTHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HYGuideCTHeaderCell cellID] forIndexPath:indexPath];
    cell.cellData = [NSDictionary dictionary];
    if (indexPath.row == 1) {
        cell.backgroundColor = kMaleColor;
    }
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
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 0, 20, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(200, 120);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - Setter and Getter
- (UICollectionView *)collectionHeaderView {
    if (!_collectionHeaderView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionHeaderView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionHeaderView.delegate = self;
        _collectionHeaderView.dataSource = self;
        _collectionHeaderView.backgroundColor = kBgGrayColor;
        _collectionHeaderView.showsHorizontalScrollIndicator = NO;
        [_collectionHeaderView registerClass:[HYGuideCTHeaderCell class] forCellWithReuseIdentifier:[HYGuideCTHeaderCell cellID]];
    }
    return _collectionHeaderView;
}

@end
