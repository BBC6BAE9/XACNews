//
//  ContentView.swift
//  XCANewsMac
//
//  Created by henry on 2023/3/4.
//

import SwiftUI

struct ContentView: View {
    
    @SceneStorage("item_selection") private var selectedMenuItemId: MenuItem.ID?
    private var selection:Binding<MenuItem.ID?>{
        Binding{
            selectedMenuItemId ?? MenuItem.category(.general).id
        } set: { newValue in
            if let newValue = newValue{
                selectedMenuItemId = newValue
                
            }
        }
    }
     
    var body: some View {
        NavigationView {
            SidebarListView(selection: selection)
                .toolbar {
                    ToolbarItem(placement: .navigation){
                        Button(action: toggleSidebar) {
                            Image(systemName: "sidebar.left")
                        }
                    }
                }
        }
        .frame(minWidth: 1000, minHeight: 386)
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?
            .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
