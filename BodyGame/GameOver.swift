//
//  GameOver.swift
//  BodyGame
//
//  Created by Calista Kalleya on 29/04/24.
//

import SwiftUI

struct GameOverView: View {
    // Starting vertical offset for the crown
    // This should be adjusted based on the size of the view and crown
    @State private var crownOffset: CGFloat = -350
    @Binding var score:Int
    
    var body: some View {
        ZStack {
            // Your game over background image
            Image("game_over")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            HStack {
                Text(String(score))
                    .font(.largeTitle)
                    .bold()
            }
            .position(CGPoint(x: UIScreen.main.bounds.size.width/2, y: 200))
            // The crown image
            Image("Crown")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 100)
                .offset(y: crownOffset)
                .onAppear {
                    // Trigger the animation when the view appears
                    withAnimation(.easeInOut(duration: 3)) {
                        // This value should be adjusted so the crown stops at the head
                        crownOffset = 0
                    }
                }
        }
    }
}

#Preview {
    struct PreviewWrapper:View {
        @State private var score = 0
        var body: some View {
            GameOverView(score: $score)
        }
    }
    return PreviewWrapper()
}

