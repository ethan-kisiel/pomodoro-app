//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI
enum Route: Hashable
{
    case create
}
@main
struct PomodoroApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack
            {
                CreatePomodoroView()
                    .navigationDestination(for: Route.self)
                { route in
                    switch route
                    {
                        case .create : CreatePomodoroView()
                    }
                }
            }
                
            
        }
    }
}
