//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI
import UserNotifications
@main
struct PomodoroApp: App {
    @StateObject var notificationManager = NotificationManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
                .preferredColorScheme(.light)
        }
    }
}
