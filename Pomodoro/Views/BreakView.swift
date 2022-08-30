//
//  BreakView.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI

struct BreakView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var seconds: Int
    @Binding var showView: ShowView
    
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
                if seconds <= 30
                {
                    SoundManager.shared.playSound(soundName: "return-to-focus")
                }
                if seconds <= 0
                {
                    SoundManager.shared.stopSound()
                    showView = .focus
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
