//
//  FocusView.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI

struct FocusView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var seconds: Int
    @Binding var showView: ShowView
    var body: some View {
        TimerView(totalSeconds: seconds)
            .onReceive(timer)
        { _ in
            seconds -= 1
            if seconds <= 0
            {
                SoundManager.shared.playSound(soundName: "begin-break")
                showView = .endFocus
            }
        }
    }
}

struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        Text("No Preview")
        //FocusView(seconds: 0)
    }
}
