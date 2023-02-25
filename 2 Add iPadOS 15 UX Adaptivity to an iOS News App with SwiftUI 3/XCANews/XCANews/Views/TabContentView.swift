//
//  TabContentView.swift
//  XCANews
//
//  Created by henry on 2023/2/25.
//

import SwiftUI

struct TabContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                NewsTabView()
            }
            .tabItem {
                Label("News", systemImage: "newspaper")
            }
            
            NavigationView {
                SearchTabView()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            NavigationView {
                BookmarkTabView()
            }
            .tabItem {
                Label("Saved", systemImage: "bookmark")
            }
        }
    }
}

struct TabContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabContentView()
    }
}
