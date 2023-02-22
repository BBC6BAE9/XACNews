//
//  ContentView.swift
//  XCNews
//
//  Created by henry on 2023/2/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NewsTabView().tabItem {
                Label("News", systemImage: "newspaper")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
