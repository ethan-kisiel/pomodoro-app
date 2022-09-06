//
//  CreatePomodoroView.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI
import Neumorphic
func getSeconds(_ hours: Int, _ minutes: Int, _ seconds: Int) -> Int
{
    var seconds = seconds
    seconds += minutes * 60
    seconds += (hours * 60) * 60
    return seconds
}

struct CreatePomodoroView: View {
    @Binding var focusSeconds: Int
    @Binding var breakSeconds: Int
    @Binding var showView: ShowView
    
    @State var dFocusHours = 0
    @State var dFocusMinutes = 0
    @State var dFocusSeconds = 0
    
    @State var dBreakHours = 0
    @State var dBreakMinutes = 0
    @State var dBreakSeconds = 0
    
    @State var showFocusPicker = false
    @State var showBreakPicker = false
    
    var body: some View {
        
        VStack
        {
            Text("Focus Time")
                .dynamicTypeSize(.large)
                .fontWeight(.bold)
                .onTapGesture
                {
                    showFocusPicker.toggle()
                }
            if showFocusPicker
            {
                HMSPicker(hours: $dFocusHours, minutes: $dFocusMinutes, seconds: $dFocusSeconds)
            }
            Text("Break Time")
                .dynamicTypeSize(.large)
                .fontWeight(.bold)
                .onTapGesture
                {
                    showBreakPicker.toggle()
                }
            if showBreakPicker
            {
                HMSPicker(hours: $dBreakHours, minutes: $dBreakMinutes, seconds: $dBreakSeconds)
            }
            
            Spacer()
            Button(action: {
                SoundManager.shared.playSound(soundName: "button-press")
                focusSeconds = getSeconds(dFocusHours, dFocusMinutes, dFocusSeconds)
                breakSeconds = getSeconds(dBreakHours, dBreakMinutes, dBreakSeconds)
                showView = .focus
            })
            {
                Text("Start Pomodoro")
            }.softButtonStyle(RoundedRectangle(cornerRadius: 10))
            Spacer()
        }

        Spacer()
    }
}

struct CreatePomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        //CreatePomodoroView()
        Text("No Preview")
    }
}
