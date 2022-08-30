//
//  ContentView.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI
enum ShowView
{
    case create
    case focus
    case endFocus
}
struct ContentView: View {
    @State var whichView: ShowView = .create
    @State var focusSeconds: Int = 0
    @State var breakSeconds: Int = 0
    
    var body: some View {
        switch whichView {
        case .create:
            CreatePomodoroView(focusSeconds: $focusSeconds, breakSeconds: $breakSeconds, showView: $whichView)
        case .focus:
            FocusView(seconds: focusSeconds)
        case .endFocus:
            BreakView(seconds: breakSeconds)
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
