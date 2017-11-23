//
//  HYMainViewController.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/10.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYMainViewController.h"
#import "HYHomeViewController.h"
#import "HYGuideViewController.h"
#import "HYPlan+Database.h"

@interface HYMainViewController ()

@property (nonatomic, strong) UINavigationController *homeNavVC;
@property (nonatomic, strong) UINavigationController *guideNavVC;

@end

@implementation HYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册通知
    [HYLocalNotification registerNotificationCompleteHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"当前线程是否是主线程：%d", [[NSThread currentThread] isMainThread]);
        if (granted) {
            // 打开主页
            [self addFleshyPage];
        }else {
            // 打开权限提示页面
            [self addNotAllowNotificationPage];
        }
    }];
}

#pragma mark - Private Methods
- (void)addFleshyPage {
    [self addChildViewController:self.homeNavVC];
    [self.view addSubview:self.homeNavVC.view];
    
    // 如果还没有制定过计划，显示计划引导页面
    [HYPlan database_queryAllPlan:^(BOOL isSuccess, NSArray<HYPlan *> *array, NSString *message) {
        if (array.count == 0) {
            [self addChildViewController:self.guideNavVC];
            [self.view addSubview:self.guideNavVC.view];
        }
    }];
}

- (void)addNotAllowNotificationPage {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您没有允许显示通知，会影响App功能。请前往设置页开启此功能。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *finishAction = [UIAlertAction actionWithTitle:@"前往设置页面" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 跳转到APP设置页
        [[UIApplication sharedExtensionApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
            
        }];
    }];
    [alertVC addAction:finishAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - Setter and Getter
- (UINavigationController *)homeNavVC {
    if (!_homeNavVC) {
        _homeNavVC = [[UINavigationController alloc] initWithRootViewController:[HYHomeViewController new]];
    }
    return _homeNavVC;
}

- (UINavigationController *)guideNavVC {
    if (!_guideNavVC) {
        _guideNavVC = [[UINavigationController alloc] initWithRootViewController:[HYGuideViewController new]];
    }
    return _guideNavVC;
}

@end
