//
//  NotificationManager.swift
//  Getty
//
//  Created by Hyyy on 2017/12/12.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit
import UserNotifications

@available(iOS 10.0, *)
class NotificationManager: NSObject {
    
    static let manager = NotificationManager()
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    /// 注册本地通知
    ///
    /// - Parameter completeHandler: 完成回调
    func registerLocalNotificationCompleteHandler(completeHandler: @escaping (Bool, Error?) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .sound, .alert]) { (granted, error) in
            UserDefaults.standard.set(true, forKey: Constant.Cache.kHasRegisterdNotificationKey)
            if granted {
                print("注册本地通知成功")
            } else {
                print("注册本地通知失败")
            }
            DispatchQueue.main.async {
                completeHandler(granted, error)
            }
        }
        
        let confirmAction = UNNotificationAction (identifier: Constant.Notification.Action.kPlanConfirmAction,
                                                  title: "开始计划",
                                                  options: .foreground)
        let refuseAction = UNNotificationAction (identifier: Constant.Notification.Action.kPlanRefuseAction,
                                                 title: "取消计划",
                                                 options: [.foreground, .destructive])
        let finishAction = UNNotificationAction (identifier: Constant.Notification.Action.kPlanFinishAction,
                                                 title: "进行打卡",
                                                 options: [.foreground, .destructive])
        
        let startCategory = UNNotificationCategory (identifier: Constant.Notification.Category.kPlanStartCategory,
                                                    actions: [confirmAction, refuseAction],
                                                    intentIdentifiers: [Constant.Notification.kPlanStartIdentifier],
                                                    options: .customDismissAction)
        let endCategory = UNNotificationCategory (identifier: Constant.Notification.Category.kPlanEndCategory,
                                                  actions: [finishAction],
                                                  intentIdentifiers: [Constant.Notification.kPlanEndIdentifier],
                                                  options: .customDismissAction)
        
        center .setNotificationCategories([startCategory, endCategory])
    }
    
    /// 创建一个本地通知
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - body: 内容
    ///   - subTitle: 子标题
    ///   - badge: 红点
    ///   - identifier: 标识符
    ///   - categoryIdentifier: 类别标识符
    ///   - fireDate: 触发时间
    func createLocalNotification(title: String,
                                 body: String,
                                 subTitle: String,
                                 badge: Int,
                                 identifier: String,
                                 categoryIdentifier: String,
                                 fireDate: Date) {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        // 设置通知内容
        content.title = title
        content.body = body
        content.subtitle = subTitle
        content.badge = NSNumber.init(value: badge)
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = categoryIdentifier
        
        // 设置触发日期
        let components = NSCalendar.current.dateComponents([.hour, .minute], from: fireDate)
        let trigger = UNCalendarNotificationTrigger (dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest (identifier: identifier, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if !(error != nil) {
                print("添加本地推送成功")
            } else {
                print("添加本地推送失败")
            }
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}
