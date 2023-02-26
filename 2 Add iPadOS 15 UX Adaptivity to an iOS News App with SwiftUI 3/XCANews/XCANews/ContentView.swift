//
//  ContentView.swift
//  XCANews
//
//  Created by Alfian Losari on 6/27/21.
//

import SwiftUI

struct ContentView: View {
    
    
    @Environment(\.horizontalSizeClass) private var horizentalSizeClass
    @AppStorage("item_selection") var selectedMenuItemId:MenuItem.ID?

    var body: some View {
          
        switch horizentalSizeClass {
        case .regular:
            SideBarContentView(selectedMenuItemId: $selectedMenuItemId)
        default:
            TabContentView(selectedMenuItemId: $selectedMenuItemId)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
