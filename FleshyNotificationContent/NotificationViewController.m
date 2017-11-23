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

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveNotification:(UNNotification *)notification {
    if ([notification.request.content.categoryIdentifier isEqualToString:@"HYPlanStartCategoryIdentifier"]) {
        self.view.backgroundColor = [UIColor orangeColor];
    }else {
        self.view.backgroundColor = [UIColor darkGrayColor];
    }
    self.label.text = notification.request.content.body;
}

@end
