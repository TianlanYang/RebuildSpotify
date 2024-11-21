//
//  ContentView.swift
//  SwiftfulSwiftUIinPractice
//
//  Created by Jijiyagao on 10/10/24.
//

import SwiftUI
import SwiftfulRouting
import SwiftfulUI

struct ContentView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
        List {
            Button("Open Spotify"){
                router.showScreen(.fullScreenCover){ _ in
                    SpotifyHomeView()
                }
            }
        }
    }
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
