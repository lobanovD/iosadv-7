//
//  LocalNotificationsService.swift
//  iosadv-8
//
//  Created by Dmitrii Lobanov on 18.06.2022.
//

import Foundation
import UserNotifications
import UIKit

class LocalNotificationsService {
    
    // Метод запроса разрешений на показ уведомлений
    class func requestPermissions() {
        let notifyCenter = UNUserNotificationCenter.current()
        
        notifyCenter.requestAuthorization(options: [.provisional, .badge, .sound]) { granted, error in
            
            if granted {
                notifyCenter.getNotificationSettings { settings in
                    print(settings)
                    
                    // Подключение уведомлений по расписанию
                    if !UserDefaults.standard.bool(forKey: "notificationWithTimeSetted") {
                        LocalNotificationsService.setNotifyWithDate()
                        UserDefaults.standard.set(true, forKey: "notificationWithTimeSetted")
                    }
                }
            } else {
                print(error)
            }
        }
        
        
    }
    
    // Метод установки уведомлений по расписанию (каждый день в 19:00)
    
    class func setNotifyWithDate() {
        
        let notifyCenter = UNUserNotificationCenter.current()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.sound = .default
        DispatchQueue.main.async {
            content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        }
        
        content.title = "Посмотрите последние обновления"
        
        let request = UNNotificationRequest(identifier: "123",
                                            content: content, trigger: trigger)
        
        notifyCenter.add(request) { error in
            print(error)
        }
    }
}
