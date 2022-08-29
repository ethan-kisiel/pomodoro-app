//
//  CreatePomodoroView.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI
import Neumorphic

struct CreatePomodoroView: View {
    @State var hours = 0
    @State var minutes = 0
    @State var seconds = 0
    var body: some View {
        HMSPicker(hours: $hours, minutes: $minutes, seconds: $seconds)
        
        Button(action: {SoundManager.shared.playSound(soundName: "button-press")})
        {
            Text("Play Sound")
        }.softButtonStyle(RoundedRectangle(cornerRadius: 10))
        Spacer()
            .navigationTitle("Create Pomodoro")
    }
}

struct CreatePomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePomodoroView()
    }
}
