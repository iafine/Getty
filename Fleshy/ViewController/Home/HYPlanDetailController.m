//
//  HYPlanDetailController.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/20.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPlanDetailController.h"

@interface HYPlanDetailController ()

@end

@implementation HYPlanDetailController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = self.bgColor;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

@end
