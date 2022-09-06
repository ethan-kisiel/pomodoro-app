//
//  HMPicker.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 9/6/22.
//

import SwiftUI

struct HMPicker: View {
    @Binding var hours: Int
    @Binding var minutes: Int

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
                .frame(width: geometry.size.width / 2, height: geometry.size.height, alignment: .center)
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
                .frame(width: geometry.size.width / 2, height: geometry.size.height, alignment: .center)
                .compositingGroup()
                .clipped()
            }
        }
    }
}

struct HMPicker_Previews: PreviewProvider {
    static var previews: some View {
        //HMPicker()
        Text("No Preview")
    }
}
