//
//  GamePlay.swift
//  BodyGame
//
//  Created by Calista Kalleya on 30/04/24.
//

//import SwiftUI
//
//struct GamePlay: View {
//    @State private var position = CGPoint(x: 100, y: 100)
//    @State private var score = 0
//    @State private var tapSpeed = 1.0
//    @State private var imageIndex = 0
//    @State private var timeRemaining = 5.0
//    @State private var gameIsActive = true
//    
//    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
//
//    let imageNames = ["Iklan 1", "Iklan 2", "Iklan 3", "Iklan 4", "Iklan 5", "Iklan 6"]
//    let backgroundImageName = "LB"
//
//    var body: some View {
//        ZStack {
//            Image(backgroundImageName)
//                .resizable()
//                .edgesIgnoringSafeArea(.all)
//                .scaledToFill()
//            
//            if gameIsActive {
//                VStack {
//                    Text("\(score)")
//                        .font(.largeTitle)
//                        .foregroundColor(.black)
//                        .padding(.top, 50)
//                    
//                    Spacer()
//                
//                
//                    Image(imageNames[imageIndex])
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 200, height: 200)
//                        .clipped()
//                        .cornerRadius(20)
//                        .overlay(
//                            Button(action: {
//                                score += 1
//                                tapSpeed *= 0.9
//                                imageIndex = (imageIndex + 1) % imageNames.count
//                                changePosition()
//                                timeRemaining = 5.0
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                                    .font(.largeTitle)
//                                    .foregroundColor(.red)
//                            },
//                            alignment: .topTrailing
//                        )
//                        .position(position)
//                        .animation(.easeInOut(duration: tapSpeed), value: position)
//                
//                
//
//                // Timer as a cylindrical progress bar
//                    ProgressView(value: timeRemaining, total: 5.0)
//                    .progressViewStyle(LinearProgressViewStyle())
//                    .frame(width: 300, height: 20)
//                    .padding()
//                }
//            } else {
//                // Navigate to GameOverView when game ends
//                GameOverView(score: $score)
//            }
//        }
//        .onAppear {
//            changePosition()
//        }
//        .onReceive(timer) { _ in
//            if timeRemaining > 0 {
//                timeRemaining -= 0.1
//            } else {
//                gameIsActive = false
//                timer.upstream.connect().cancel()
//            }
//        }
//    }
//    
//    private func changePosition() {
//        let newX = CGFloat.random(in: 100...UIScreen.main.bounds.width - 100)
//        let newY = CGFloat.random(in: 100...UIScreen.main.bounds.height - 200)
//        position = CGPoint(x: newX, y: newY)
//    }
//}
//
//#Preview {
//    GamePlay()
//}

import SwiftUI

struct GamePlay: View {
    @State private var position = CGPoint(x: 100, y: 100)
    @State private var score = 0
    @State private var imageIndex = 0
    @State private var timeRemaining = 5.0
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
                                imageIndex = (imageIndex + 1) % imageNames.count
                                changePosition()
                                timeRemaining = 5.0
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.red)
                            }
                            .offset(x: CGFloat.random(in: -10...10), y: CGFloat.random(in: -10...10)) // Menambahkan offset acak pada tombol X
                            .animation(Animation.easeInOut(duration: 0.2).repeatForever(autoreverses: true)) // Animasi berulang untuk membuat tombol X bergerak
                        )
                        .position(position)
                
                    // Timer as a cylindrical progress bar
                    ProgressView(value: timeRemaining, total: 5.0)
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
            startTimer()
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
    
    private func startTimer() {
        // Mengatur perubahan posisi tombol X secara acak setiap 0.5 detik
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            let newX = CGFloat.random(in: 0...UIScreen.main.bounds.width)
            let newY = CGFloat.random(in: 0...UIScreen.main.bounds.height)
            position = CGPoint(x: newX, y: newY)
        }
        
        // Menghentikan permainan setelah 5 detik
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            gameIsActive = false
        }
    }
}

struct GamePlay_Previews: PreviewProvider {
    static var previews: some View {
        GamePlay()
    }
}
