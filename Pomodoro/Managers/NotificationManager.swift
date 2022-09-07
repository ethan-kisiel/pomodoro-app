//
//  NotificationHandler.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 9/1/22.
//

import Foundation
import UserNotifications
import NotificationCenter


class NotificationManager: ObservableObject
{
    let notificationCenter = UNUserNotificationCenter.current()
    var pendingNotifications: [String] = []
    
    func requestAuthorization() async throws
    {
        try await notificationCenter
            .requestAuthorization(options: [.alert, .sound, .badge])
    }
    
    let endFocusNotification: UNMutableNotificationContent
    let endBreakNotification: UNMutableNotificationContent
    init()
    {
        endFocusNotification = UNMutableNotificationContent()
        endFocusNotification.title = "Focus Time has Ended"
        endFocusNotification.body = "Please return to the app to continue."
        endFocusNotification.sound = UNNotificationSound.default
        
        endBreakNotification = UNMutableNotificationContent()
        endBreakNotification.title = "Break Time has Ended"
        endBreakNotification.body = "Please return to the app to continue."
        endBreakNotification.sound = UNNotificationSound.default
    }
    
    func createTrigger(_ seconds: Double) -> UNTimeIntervalNotificationTrigger
    {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        return trigger
    }
    
    func scheduleNotification(isEndFocusNotification: Bool, seconds: Int)
    {
        
        let dSeconds = Double(seconds)
        
        let identifier = UUID().uuidString
        let content = isEndFocusNotification ? endFocusNotification : endBreakNotification
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: createTrigger(dSeconds))
        
        notificationCenter.add(request)
        {(error) in
            if error == nil
            {
                self.pendingNotifications.append(identifier)
            }
            else
            {
                print(error?.localizedDescription)
            }
        }
    }
    
    func cancelNotifications()
    {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: pendingNotifications)
    }
}
