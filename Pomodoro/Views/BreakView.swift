//
//  BreakView.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI

struct BreakView: View {
    @State var seconds: Int
    @Binding var showView: ShowView
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BreakView_Previews: PreviewProvider {
    static var previews: some View {
        Text("No preview")
        //BreakView(seconds: 0)
    }
}
