//
//  BreakView.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI

struct BreakView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    let scenePhase: ScenePhase
    
    @AppStorage("enteredBackground") var enteredBackground: Double = Date().timeIntervalSinceReferenceDate
    
    @AppStorage("enteredForeground") var enteredForeground: Double = Date().timeIntervalSinceReferenceDate
    
    // isPaused: var for pausing the timer
    @State var isPaused: Bool = false
    
    // helps determine if the scene was just inactive going into foreground
    @State var wasBackground = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var seconds: Int
    @Binding var showView: ShowView
    
    // determines whether or not to start playing the notification sound
    @State var soundIsPlaying: Bool = false
    
    var body: some View {
        Spacer()
        // TODO: this can/needs to be abstracted
        HStack
        {
            Image(systemName:"xmark.circle.fill")
                .foregroundColor(.red)
                .onTapGesture
                {
                    SoundManager.shared.playSound(soundName: "button-press")
                    showView = .create
                }
            Text("Break")
                .dynamicTypeSize(.xxxLarge)
                .fontWeight(.bold)
                .padding(8)
                .frame(height: UIScreen.main.bounds.height * 0.044)
            
            Image(systemName: isPaused ? "play.circle.fill" : "pause.circle.fill")
                .foregroundColor(.blue)
                .onTapGesture {
                    isPaused.toggle()
                    SoundManager.shared.playSound(soundName: "button-press")
                }
        }
        VStack
        {
            TimerView(totalSeconds: seconds)
                .frame(height: UIScreen.main.bounds.height * 0.766)
                .onReceive(timer)
            { _ in

                if seconds > 0 && !isPaused
                {
                    seconds -= 1
                }
                else if !isPaused
                {
                    SoundManager.shared.stopSound()
                    showView = .focus
                }
                
                if seconds <= 30 && !soundIsPlaying
                {
                    SoundManager.shared.playSound(soundName: "return-to-focus")
                    soundIsPlaying.toggle()
                }
            }
            .onChange(of: scenePhase)
            { phase in
                if phase == .background
                {
                    notificationManager.scheduleNotification(isEndFocusNotification: false, seconds: seconds)
                    wasBackground = true
                    enteredBackground = Date().timeIntervalSinceReferenceDate
                }
                if phase == .active && wasBackground
                {
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
        VStack
        {
            Button(action: {
                SoundManager.shared.stopSound()
                SoundManager.shared.playSound(soundName: "button-press")
                showView = .focus
            })
            {
                Text("Return to Focus")
                    .frame(maxWidth: .infinity)
            }.softButtonStyle(RoundedRectangle(cornerRadius: 10))
            Spacer()
        }.padding(8)
    }
}

struct BreakView_Previews: PreviewProvider {
    static var previews: some View {
        Text("No preview")
        //BreakView(seconds: 0)
    }
}
