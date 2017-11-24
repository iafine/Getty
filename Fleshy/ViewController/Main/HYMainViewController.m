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
    
    // 如果还没有制定过计划，显示计划引导页面
    [HYPlan database_queryAllPlan:^(BOOL isSuccess, NSArray<HYPlan *> *array, NSString *message) {
        [self addChildViewController:self.homeNavVC];
        [self.view addSubview:self.homeNavVC.view];

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

- (void)testDBMethod {
    // 测试数据库
    NSString *deleteSql = @"DELETE FROM fleshy_plan;";
    [[HYDBManager sharedInstance] executeDeleteSQL:deleteSql block:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            // 生成批量数据库
            NSMutableArray *sqlList = [NSMutableArray array];
            for (int i=0; i < 10000; i++) {
                NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO fleshy_plan (plan_name, plan_start_time, plan_end_time, plan_create_time, plan_duration_time, plan_duration_days) VALUES ('test_plan_%d', '2017-11-24 12:00:00', '2017-11-24 12:00:00', '2017-11-24 12:00:00', 80, 60);", i];
                [sqlList addObject:insertSql];
            }
            [[HYDBManager sharedInstance] executeSqlList:sqlList block:^(BOOL isSuccess, NSString *message) {
                if (isSuccess) {
                    // 查询数据库
                    NSString *querySql = @"SELECT * FROM fleshy_plan;";
                    [[HYDBManager sharedInstance] executeQuerySQL:querySql block:^(BOOL isSuccess, FMResultSet *rs, NSString *message) {
                        while (rs.next) {
                            NSString *planName = [rs stringForColumn:@"plan_name"];
                            NSLog(@"计划名称：%@", planName);
                        }
                        [rs close];
                        
                        NSString *querySql2 = @"SELECT * FROM fleshy_plan WHERE plan_id = 300;";
                        [[HYDBManager sharedInstance] executeQuerySQL:querySql2 block:^(BOOL isSuccess, FMResultSet *rs, NSString *message) {
                            while (rs.next) {
                                NSString *planName = [rs stringForColumn:@"plan_name"];
                                NSLog(@"第二次查询，计划名称：%@", planName);
                            }
                            [rs close];
                        }];
                    }];
                }
            }];
        }
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
        _guideNavVC = [[UINavigationController alloc] initWithRootViewController:[HYGuideViewController new]];
    }
    return _guideNavVC;
}

@end
