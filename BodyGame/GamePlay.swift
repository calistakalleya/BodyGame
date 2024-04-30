//
//  GamePlay.swift
//  BodyGame
//
//  Created by Calista Kalleya on 30/04/24.
//

import SwiftUI

struct GamePlay: View {
    @State private var position = CGPoint(x: 100, y: 100)
    @State private var score = 0
    @State private var tapSpeed = 1.0
    @State private var imageIndex = 0
    @State private var timeRemaining = 3.0
    @State private var gameIsActive = true
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    let imageNames = ["Iklan 1", "Iklan 2", "Iklan 3", "Iklan 4", "Iklan 5", "Iklan 6"]
    let backgroundImageName = "LB"

    var body: some View {
        ZStack {
            Image(backgroundImageName)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
            if gameIsActive {
                VStack {
                    Text("\(score)")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding(.top, 50)
                    
                    Spacer()
                
                
                    Image(imageNames[imageIndex])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(20)
                        .overlay(
                            Button(action: {
                                score += 1
                                tapSpeed *= 0.9
                                imageIndex = (imageIndex + 1) % imageNames.count
                                changePosition()
                                timeRemaining = 3.0
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            },
                            alignment: .topTrailing
                        )
                        .position(position)
                        .animation(.easeInOut(duration: tapSpeed), value: position)
                
                

                // Timer as a cylindrical progress bar
                    ProgressView(value: timeRemaining, total: 3.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(width: 300, height: 20)
                    .padding()
                }
            } else {
                // Navigate to GameOverView when game ends
                GameOverView(score: $score)
            }
        }
        .onAppear {
            changePosition()
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 0.1
            } else {
                gameIsActive = false
                timer.upstream.connect().cancel()
            }
        }
    }
    
    private func changePosition() {
        let newX = CGFloat.random(in: 100...UIScreen.main.bounds.width - 100)
        let newY = CGFloat.random(in: 100...UIScreen.main.bounds.height - 200)
        position = CGPoint(x: newX, y: newY)
    }
}

#Preview {
    GamePlay()
}
