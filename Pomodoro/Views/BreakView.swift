//
//  BreakView.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI

struct BreakView: View {
    let scenePhase: ScenePhase
    
    @AppStorage("enteredBackground") var enteredBackground: Double = Date().timeIntervalSinceReferenceDate
    
    @AppStorage("enteredForeground") var enteredForeground: Double = Date().timeIntervalSinceReferenceDate
    
    // helps determine if the scene was just inactive going into foreground
    @State var wasBackground = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var seconds: Int
    @Binding var showView: ShowView
    
    // determines whether or not to start playing the notification sound
    @State var soundIsPlaying: Bool = false
    
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
                seconds -= 1
                if seconds <= 30 && !soundIsPlaying
                {
                    SoundManager.shared.playSound(soundName: "return-to-focus")
                    soundIsPlaying = true
                }
                if seconds <= 0
                {
                    SoundManager.shared.stopSound()
                    soundIsPlaying = false
                    showView = .focus
                }
            }
            .onChange(of: scenePhase)
            { phase in
                if phase == .background
                {
                    wasBackground = true
                    enteredBackground = Date().timeIntervalSinceReferenceDate
                }
                if phase == .active && wasBackground
                {
                    wasBackground = false
                    enteredForeground = Date().timeIntervalSinceReferenceDate
                    seconds -= Int((enteredForeground - enteredBackground))
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
            }.softButtonStyle(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct BreakView_Previews: PreviewProvider {
    static var previews: some View {
        Text("No preview")
        //BreakView(seconds: 0)
    }
}
