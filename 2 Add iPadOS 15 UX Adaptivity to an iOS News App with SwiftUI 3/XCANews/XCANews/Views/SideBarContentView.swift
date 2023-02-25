//
//  SideBarContentView.swift
//  XCANews
//
//  Created by henry on 2023/2/25.
//

import SwiftUI

struct SideBarContentView: View {
    var body: some View {
        NavigationView {
            List{
                ForEach([MenuItem.saved, MenuItem.search]) {
                    navigationLinkForMenuItem($0)
                }
                
                Section {
                    ForEach(Category.menuItems){
                        navigationLinkForMenuItem($0)
                    }
                } header: {
                    Text("Categories")
                }
            }.listStyle(.sidebar)
        }
    }
    
    private func navigationLinkForMenuItem(_ item: MenuItem) -> some View{
        NavigationLink(destination: viewForMenuItem(item)) {
            Label(item.text, systemImage: item.systemImage)
        }
    }
    
    @ViewBuilder
    private func viewForMenuItem(_ item: MenuItem) -> some View{
        switch item {
        case .search:
            SearchTabView()
        case .saved:
            BookmarkTabView()
        case .category(let category):
            NewsTabView(category: category)
        }
    }
}

struct SideBarContentView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarContentView()
    }
}
