//
//  SideBarContentView.swift
//  XCANews
//
//  Created by henry on 2023/2/25.
//

import SwiftUI

struct SideBarContentView: View {
    
    @Binding var selectedMenuItemId:MenuItem.ID?
    private var selection:Binding<MenuItem.ID?>{
        Binding {
            selectedMenuItemId ?? MenuItem.category(.general).id
        } set: { newValue in
            if let menuItem = newValue {
                selectedMenuItemId = menuItem
            }
        }
    }
    var body: some View {
        NavigationView {
            List(selection: $selectedMenuItemId){
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
        NavigationLink(destination: viewForMenuItem(item), tag: item.id, selection: $selectedMenuItemId) {
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
        SideBarContentView(selectedMenuItemId: .constant(nil))
    }
}
