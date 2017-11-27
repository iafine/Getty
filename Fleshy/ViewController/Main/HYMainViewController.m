//
//  HYMainViewController.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/10.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYMainViewController.h"
#import "HYHomeViewController.h"
#import "HYGuideNotificationController.h"
#import "HYPlan+Database.h"

@interface HYMainViewController ()

@property (nonatomic, strong) UINavigationController *homeNavVC;
@property (nonatomic, strong) UINavigationController *guideNavVC;

@end

@implementation HYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 如果没有申请过通知权限，那么显示通知开启引导页面
    BOOL isRegister = [HYCacheHelper cacheValueForKey:HYHasRegisterNotifiactionKey cacheType:HYCacheDisk];
    if (isRegister) {
        // 如果还没有同意通知权限，那么显示通知开启引导页面
        [HYLocalNotification registerNotificationCompleteHandler:^(BOOL granted, NSError *error) {
            if (granted) {
                [self addFleshyPage];
            }else {
                [self addNotAllowNotificationPage];
            }
        }];
    }else {
        [self addNotAllowNotificationPage];
    }
}

#pragma mark - Private Methods
- (void)addFleshyPage {
    [self addChildViewController:self.homeNavVC];
    [self.view addSubview:self.homeNavVC.view];
    
    // 如果还没有制定过计划，显示计划引导页面
//    [HYPlan database_queryAllPlan:^(BOOL isSuccess, NSArray<HYPlan *> *array, NSString *message) {
//        if (array.count == 0) {
//            [self addChildViewController:self.guideNavVC];
//            [self.view addSubview:self.guideNavVC.view];
//        }
//    }];
}

- (void)addNotAllowNotificationPage {
    [self addChildViewController:self.guideNavVC];
    [self.view addSubview:self.guideNavVC.view];
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您没有允许显示通知，会影响App功能。请前往设置页开启此功能。" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *finishAction = [UIAlertAction actionWithTitle:@"前往设置页面" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        // 跳转到APP设置页
//        [[UIApplication sharedExtensionApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
//
//        }];
//    }];
//    [alertVC addAction:finishAction];
//    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)testDBMethod {
    // 测试数据库
    NSString *querySql1 = @"SELECT * FROM fleshy_plan WHERE plan_id = 101;";
    [[HYDBManager sharedInstance] executeQuerySQL:querySql1 block:^(BOOL isSuccess, FMResultSet *rs, NSString *message) {
        while (rs.next) {
            NSString *planName = [rs stringForColumn:@"plan_name"];
            NSLog(@"第二次查询，计划名称：%@", planName);
        }
        [rs close];
    }];
    NSString *querySql2 = @"SELECT * FROM fleshy_plan WHERE plan_id = 300;";
    [[HYDBManager sharedInstance] executeQuerySQL:querySql2 block:^(BOOL isSuccess, FMResultSet *rs, NSString *message) {
        while (rs.next) {
            NSString *planName = [rs stringForColumn:@"plan_name"];
            NSLog(@"第二次查询，计划名称：%@", planName);
        }
        [rs close];
    }];
    NSString *querySql3 = @"SELECT * FROM fleshy_plan WHERE plan_id = 309;";
    [[HYDBManager sharedInstance] executeQuerySQL:querySql3 block:^(BOOL isSuccess, FMResultSet *rs, NSString *message) {
        while (rs.next) {
            NSString *planName = [rs stringForColumn:@"plan_name"];
            NSLog(@"第二次查询，计划名称：%@", planName);
        }
        [rs close];
    }];
    NSString *querySql4 = @"SELECT * FROM fleshy_plan WHERE plan_id = 409;";
    [[HYDBManager sharedInstance] executeQuerySQL:querySql4 block:^(BOOL isSuccess, FMResultSet *rs, NSString *message) {
        while (rs.next) {
            NSString *planName = [rs stringForColumn:@"plan_name"];
            NSLog(@"第二次查询，计划名称：%@", planName);
        }
        [rs close];
    }];
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
        _guideNavVC = [[UINavigationController alloc] initWithRootViewController:[HYGuideNotificationController new]];
    }
    return _guideNavVC;
}

@end
