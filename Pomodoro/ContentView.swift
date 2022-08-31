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
    @Environment(\.scenePhase) var scenePhase
    @State var whichView: ShowView = .create
    @State var focusSeconds: Int = 0
    @State var breakSeconds: Int = 0
    
    var body: some View {
        switch whichView {
        case .create:
            CreatePomodoroView(focusSeconds: $focusSeconds, breakSeconds: $breakSeconds, showView: $whichView)
        case .focus:
            FocusView(scenePhase: scenePhase, seconds: focusSeconds, showView: $whichView)
      
        case .endFocus:
            BreakView(seconds: breakSeconds, showView: $whichView)
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
