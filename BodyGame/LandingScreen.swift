//
//  LandingScreen.swift
//  BodyGame
//
//  Created by Calista Kalleya on 30/04/24.
//

import SwiftUI

struct LandingScreen: View {
    @State private var offsetX: CGFloat = 0
    @Binding var isSlide:Bool
    let buttonWidth: CGFloat = UIScreen.main.bounds.width - 40  // Sesuaikan lebar sesuai dengan layar
    let buttonHeight: CGFloat = 50
    let buttonOffsetThreshold: CGFloat = 60  // Ambang batas untuk mengaktifkan aksi setelah geser
    
    var body: some View {
        ZStack {
            // Latar belakang dari gambar "Loading Page"
            Image("Loading Page")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            // Tempatkan slider button di bagian bawah
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: buttonHeight / 10)
                            .stroke(Color.purple, lineWidth: 6)
                            .background(Color.purple)
                            .padding(.leading,48)
                            .padding(.trailing, 16)
                            .frame(width: buttonWidth, height: buttonHeight)
                            .background(Color.clear)
                        
                        HStack {
                            Spacer().frame(width: 60)
                            Image(systemName: "arrow.right")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                                .offset(x:offsetX)
                                .gesture(
                                    DragGesture(minimumDistance: 100 ,coordinateSpace: .local)
                                        .onChanged{value in
                                            self.offsetX = max(0, min(buttonWidth, -50, value.translation.width + offsetX))
                                            
                                        }
                                        .onEnded {value in
                                            if abs(value.translation.width) >
                                                buttonOffsetThreshold {
                                                isSlide = true
                                                self.offsetX = buttonWidth - 50
                                            } else {
                                                self.offsetX = 3
                                            }
                                            
                                        }
                                    )
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 65)  // Memberikan padding di bawah slider button
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var isSlide:Bool = false
        var body: some View {
            LandingScreen(isSlide: $isSlide)
        }
    }
    return PreviewWrapper()
}
