//
//  GamePlay.swift
//  BodyGame
//
//  Created by Calista Kalleya on 30/04/24.
//

import SwiftUI

struct GamePlayView: View {
    @State private var xButtonPosition = CGPoint(x: 72, y: 200)
    @State var score = 0
    @State var status = true
    @State var trigger = true
    @State private var isPopupVisible = true
    @State private var xButtonTaps = [false, false, false]
    @State private var gameIsActive = true
    @State private var imageIndex = 0
    @State private var timeRemaining = 3.0
    @State private var tapSpeed = 1.0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let imageNames = ["Iklan 1", "Iklan 2", "Iklan 3", "Iklan 4"]
    let backgroundImageName = "LB"


    private func changePosition() {
        let newX = CGFloat.random(in: 100...UIScreen.main.bounds.width - 100)
        let newY = CGFloat.random(in: 100...UIScreen.main.bounds.height - 200)
        xButtonPosition = CGPoint(x: newX, y: newY)
    }
    
    var body: some View {
        ZStack {
            Image("Background Judi")
            
            //Untuk iklan 1 - Judi
            if status {
                Color.secondary
                Image("Iklan Judi")
                    .resizable()
                    .scaledToFit()
                    .opacity(trigger ? 1 : 0)
                    .frame(width: 350)
                    .animation(.easeOut(duration: 0.5), value: trigger)
            }
            
            Spacer()
            
            if status {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .opacity(trigger ? 1 : 0)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
                    .position(x: xButtonPosition.x, y: xButtonPosition.y)
                    .onTapGesture {
                        if score < 6 {
                            let newX = CGFloat.random(in: 72...345)
                            let newY = CGFloat.random(in: 200...650)
                            self.xButtonPosition = CGPoint(x: newX, y: newY)
                            score += 1
                        } else {
                            withAnimation(.easeOut(duration: 0.5)){
                                trigger = false
                            } completion: {
                                status = false
                            }
                        }
                    }
            }
            
            //Untuk iklan 2 - Bayi
            // Popup Window
            if isPopupVisible {
                ZStack {
                    Color.secondary
                    Image("Iklan Bayi No Eyes")
                    XButtonView(index: 0, isTapped: $xButtonTaps[0])
                        .position(x: 160, y: 362)
                        .onTapGesture {
                            xButtonTaps[0] = true
                            score += 1
                            changePosition()
                        }
                    XButtonView(index: 1, isTapped: $xButtonTaps[1])
                        .position(x: 238, y: 345)
                        .onTapGesture {
                            xButtonTaps[1] = true
                            score += 1
                            changePosition()
                        }
                    XButtonView(index: 2, isTapped: $xButtonTaps[2])
                        .position(x: 200, y: 511)
                        .onTapGesture {
                            xButtonTaps[2] = true
                            score += 1
                            changePosition()
                        }
                }
                .onChange(of: xButtonTaps) { newValue in
                    if newValue.allSatisfy({ $0 }) {
                        isPopupVisible = false
                        score += 1
                    }
                }
            }
            //X nya yang berubah banyak dan berpindah pindah
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
                    .animation(Animation.easeInOut(duration: 0.2).repeatForever(autoreverses: true))
            
            )
            if gameIsActive {
                VStack {
                    Text("\(score)")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding(.top, 100)
                    
                    Spacer()
                    
                    ProgressView(value: timeRemaining, total: 3.0)
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(width: 300, height: 20)
                        .padding()
                        .onAppear {
                            changePosition()
                        }
                        .foregroundColor(.blue)
                        .opacity(0.8)
                        .background(.white)
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 0.1
                            } else {
                                gameIsActive = false
                                timer.upstream.connect().cancel()
                            }
                        }
                }
            } else {
                // Navigate to GameOverView when game ends
                GameOverView(score: $score)
            }
        }
    }
}

struct GamePlayView_Previews: PreviewProvider {
    static var previews: some View {
        GamePlayView()
    }
}


//import SwiftUI
//
//struct GamePlay: View {
//    @State private var position = CGPoint(x: 100, y: 100)
//    @State private var score = 0
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
//                    Image(imageNames[imageIndex])
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 200, height: 200)
//                        .clipped()
//                        .cornerRadius(20)
//                        .overlay(
//                            Button(action: {
//                                score += 1
//                                imageIndex = (imageIndex + 1) % imageNames.count
//                                changePosition()
//                                timeRemaining = 5.0
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                                    .font(.largeTitle)
//                                    .foregroundColor(.red)
//                            }
//                            .offset(x: CGFloat.random(in: -10...10), y: CGFloat.random(in: -10...10)) // Menambahkan offset acak pada tombol X
//                            .animation(Animation.easeInOut(duration: 0.2).repeatForever(autoreverses: true)) // Animasi berulang untuk membuat tombol X bergerak
//                        )
//                        .position(position)
//                
//                    // Timer as a cylindrical progress bar
//                    ProgressView(value: timeRemaining, total: 5.0)
//                        .progressViewStyle(LinearProgressViewStyle())
//                        .frame(width: 300, height: 20)
//                        .padding()
//                }
//            } else {
//                // Navigate to GameOverView when game ends
//                GameOverView(score: $score)
//            }
//        }
//        .onAppear {
//            startTimer()
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
//    
//    private func startTimer() {
//        // Mengatur perubahan posisi tombol X secara acak setiap 0.5 detik
//        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
//            let newX = CGFloat.random(in: 0...UIScreen.main.bounds.width)
//            let newY = CGFloat.random(in: 0...UIScreen.main.bounds.height)
//            position = CGPoint(x: newX, y: newY)
//        }
//        
//        // Menghentikan permainan setelah 5 detik
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            gameIsActive = false
//        }
//    }
//}
//
//struct GamePlay_Previews: PreviewProvider {
//    static var previews: some View {
//        GamePlay()
//    }
//}
