//
//  GamePlayView.swift
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
                    .animation(.easeOut(duration: 0.5), value: trigger)            }
            
            Spacer()
            
            if status {
                    
                Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .opacity(trigger ? 1 : 0)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                
                        .position(x: xButtonPosition.x, y: xButtonPosition.y)
                        .onTapGesture {
                            if score < 5 {
                                let newX = CGFloat.random(in: 72...345)
                                let newY = CGFloat.random(in: 200...650)
                                self.xButtonPosition = CGPoint(x: newX, y: newY)
                                score += 1
                                
                                print("Good Luck Next Time")
                            } else {
                                withAnimation(.easeOut(duration: 0.5)){
                                    trigger = false
                                } completion: {
                                    status = false
                                }
                                print("You Did It")
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
//                        .onTapGesture {
//                            xButtonTaps[0] = true
//                            print(xButtonTaps[0])
//                        }
                    XButtonView(index: 1, isTapped: $xButtonTaps[1])
                        .position(x: 238, y: 345)
                    XButtonView(index: 2, isTapped: $xButtonTaps[2])
                        .position(x: 196, y: 511)
//                        .onTapGesture {
//                            score += 1
//                            print(score)
//                        }
                }
                .onChange(of: xButtonTaps) {
                    if xButtonTaps.allSatisfy({ $0 }) {
                        isPopupVisible = false
                    }
                }
            }
        }
    }
}

#Preview {
    GamePlayView()
}
