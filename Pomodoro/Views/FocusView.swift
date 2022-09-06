//
//  FocusView.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI

struct FocusView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    var scenePhase: ScenePhase
    @AppStorage("enteredBackground") var enteredBackground: Double = Date().timeIntervalSinceReferenceDate
    
    @AppStorage("enteredForeground") var enteredForeground: Double = Date().timeIntervalSinceReferenceDate
    
    // helps determine if the scene was just inactive going into foreground
    @State var wasBackground = false
    
    // App storage vars for entered background and entered forground
    // environment var scene phase for capturing background change
    
    // notifications for sound fx
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var seconds: Int
    @Binding var showView: ShowView

    @State var notificationID: String = ""
    var body: some View {
        ZStack(alignment: .trailing)
        {
            Spacer()
            Image(systemName:"xmark.circle.fill")
                .foregroundColor(.red)
                .onTapGesture
                {
                    SoundManager.shared.playSound(soundName: "button-press")
                    showView = .create
                }
        }
        Spacer()
        VStack
        {
            TimerView(totalSeconds: seconds)
                .onReceive(timer)
            { _ in
                if seconds < 3
                {
                    SoundManager.shared.playSound(soundName: "begin-break")
                }
                if seconds > 0
                {
                    seconds -= 1
                }
                else
                {
                    SoundManager.shared.stopSound()
                    showView = .endFocus
                }
            }
            .onChange(of: scenePhase)
            { phase in
                if phase == .background
                {
                    notificationID = notificationManager.scheduleNotification(isEndFocusNotification: true, seconds: seconds)
                    wasBackground = true
                    enteredBackground = Date().timeIntervalSinceReferenceDate
                }
                if phase == .active && wasBackground
                {
                    if notificationID != ""
                    {
                        notificationManager.cancelNotification(notificationID)
                    }
                    wasBackground = false
                    enteredForeground = Date().timeIntervalSinceReferenceDate
                    seconds -= Int((enteredForeground - enteredBackground))
                    if seconds < 0
                    {
                        seconds = 0
                    }
                }
 
            }
        }
        Spacer()
    }
}

struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        Text("No Preview")
        //FocusView(seconds: 0)
    }
}
