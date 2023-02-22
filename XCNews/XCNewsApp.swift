//
//  XCNewsApp.swift
//  XCNews
//
//  Created by henry on 2023/2/18.
//

import SwiftUI

@main
struct XCNewsApp: App {
    @StateObject var articleBookmaekVM = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(articleBookmaekVM)
        }
    }
}
