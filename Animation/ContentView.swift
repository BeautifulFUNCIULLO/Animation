//
//  ContentView.swift
//  Animation
//
//  Created by Mirko Pietro Leone on 23/03/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            breath ()
                .tabItem {
                    Label("Breath animation", systemImage: "slowmo")
                }
            SubmitButton_Test()
                .tabItem {
                    Label("Async Button", systemImage: "circle.dotted")
                }
//           
            micro()
                .tabItem {
                    Label("Micro-interactions", systemImage: "timelapse")
                }
        }
        .accentColor(.indigo)
        .onAppear(){
            UITabBar.appearance().barTintColor = .white
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
