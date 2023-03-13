//
//  XCANewsMacApp.swift
//  XCANewsMac
//
//  Created by henry on 2023/3/4.
//

import SwiftUI

@main
struct XCANewsMacApp: App {
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
        .commands {
            SidebarCommands()
        }
    }
}
