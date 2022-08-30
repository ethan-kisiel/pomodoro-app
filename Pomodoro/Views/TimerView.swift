//
//  Timer.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/30/22.
//

import SwiftUI
func splitSeconds(_ seconds: Int) -> [Int]
{
    let secondsLeft = seconds % 60
    let minutes = seconds / 60
    let hours = minutes / 60
    let minutesLeft = minutes % 60
    
    return [hours, minutesLeft, secondsLeft]
}

func timeRep(_ time: Int) -> String
{
    if time < 10
    {
        return "0\(time)"
    }
    return "\(time)"
}
struct TimerView: View {
    let totalSeconds: Int
    var body: some View {
        let splitTime = splitSeconds(totalSeconds)
        Text("\(timeRep(splitTime[0]))h : \(timeRep(splitTime[1]))m : \(timeRep(splitTime[2]))s")
            .dynamicTypeSize(.xxxLarge)
            .fontWeight(.bold)
    }
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(totalSeconds: 300)
    }
}
