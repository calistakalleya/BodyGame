//
//  XButtonView.swift
//  BodyGame
//
//  Created by Calista Kalleya on 30/04/24.
//

import SwiftUI

struct XButtonView: View {
    let index: Int
    @Binding var isTapped: Bool
    
    var body: some View {
        Text("**X**")
            .font(.system(.title, design: .rounded))
            .padding()
            .foregroundColor(isTapped ? Color.white : Color.black)
            .cornerRadius(2)
            .onTapGesture {
                self.isTapped.toggle()
                if self.isTapped {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        self.isTapped = false
                    }
                }
            }
    }
}
