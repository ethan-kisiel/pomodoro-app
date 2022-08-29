//
//  HMSPicker.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI

struct HMSPicker: View {
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int

    var body: some View {
        GeometryReader
        { geometry in
            HStack(spacing: 0)
            {
                //MARK: Hours
                Picker("Hours", selection: _hours)
                {
                    ForEach(0..<23)
                    { digit in
                        Text("\(digit) h")
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3, height: geometry.size.height, alignment: .center)
                .compositingGroup()
                .clipped()
                
                //MARK: Minutes
                Picker("Minutes", selection: _minutes)
                {
                    ForEach(0..<60)
                    { digit in
                        Text("\(digit) m")
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3, height: geometry.size.height, alignment: .center)
                .compositingGroup()
                .clipped()
                
                //MARK: Seconds
                Picker("Seconds", selection: _seconds)
                {
                    ForEach(0..<60)
                    { digit in
                        Text("\(digit) s")
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3, height: geometry.size.height, alignment: .center)
                .compositingGroup()
                .clipped()
                
            }
        }
    }
}

struct HMSPicker_Previews: PreviewProvider {
    static var previews: some View {
        Text("No Preview")
        //HMSPicker()
    }
}
