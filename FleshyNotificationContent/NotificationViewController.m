//
//  NotificationViewController.m
//  FleshyNotificationContent
//
//  Created by Hyyy on 2017/11/23.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>


@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *titleLabel;

@property IBOutlet UILabel *descLabel;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveNotification:(UNNotification *)notification {
    NSString *categoryIdentifier = notification.request.content.categoryIdentifier;
    
    if ([categoryIdentifier isEqualToString:@"HYPlanStartCategoryIdentifier"]) {
        // 开始计划通知
        self.titleLabel.text = @"开始计划啦";
        self.descLabel.text = @"点击下方开始，则开始计划；点击下方拒绝操作，很遗憾，您放弃了该计划，同时会影响计划的统计。";
    }else {
        // 结束计划通知
        self.titleLabel.text = @"恭喜您";
        self.descLabel.text = @"又完成了计划，每一天的坚持，都离成功又近了一步，加油！";
    }
}

- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption))completion {
    if ([response.actionIdentifier isEqualToString:@"HYPlanConfirmActionIdetifier"]) {
        // 点击开始计划按钮
        self.titleLabel.text = @"准备开始";
        self.descLabel.text = @"您已开启计划，将会给您5分钟的等待时间，请做好准备！";
    }else if ([response.actionIdentifier isEqualToString:@"HYPlanRefuseActionIdentifier"]) {
        // 点击拒绝计划按钮
        self.titleLabel.text = @"很遗憾";
        self.descLabel.text = @"您今天没有开始计划，将会影响您整个计划周期的圆满度，为了美好的一天，请明天及时做好准备，开始计划。";
    }else if ([response.actionIdentifier isEqualToString:@"HYPlanFinishActionIdentifier"]) {
        // 点击打卡按钮
        self.titleLabel.text = @"打卡成功";
        self.descLabel.text = @"恭喜您，圆满完成了今天的计划，已打卡成功，可以休息一下，奖励奖励自己。";
    }else {
        
    }
    completion(UNNotificationContentExtensionResponseOptionDismissAndForwardAction);
}

@end
