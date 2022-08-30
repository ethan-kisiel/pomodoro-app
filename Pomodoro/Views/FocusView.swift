//
//  FocusView.swift
//  Pomodoro
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI

struct FocusView: View {
    @State var seconds: Int
    var body: some View {
        Text("\(seconds)")
    }
}

struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusView(seconds: 0)
    }
}
