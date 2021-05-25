//
//  PushNotification.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 14/05/21.
//

import Foundation
import UserNotifications

struct PushNotification {
    
    static let `default` = PushNotification()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    let title = ""
    let body = ""
  
    func new(title: String, body: String, scheduledFor date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        let calendar = Calendar.current
        
        var dateComponents = DateComponents()
        dateComponents.calendar = calendar
        
        dateComponents.year = calendar.component(.year, from: date)
        dateComponents.day = calendar.component(.day, from: date)
        dateComponents.hour = calendar.component(.hour, from: date)
        dateComponents.minute = calendar.component(.minute, from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request)
    }
}
