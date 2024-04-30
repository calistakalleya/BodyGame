//
//  ContentView.swift
//  BodyGame
//
//  Created by Calista Kalleya on 29/04/24.
//

import SwiftUI

struct ContentView: View {
    @State var isSlide:Bool = false
    var body: some View {
        if isSlide {
//            GamePlay()
            GamePlayView()
        } else {
            LandingScreen(isSlide: $isSlide)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


