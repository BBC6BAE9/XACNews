//
//  ArticleBookmarkViewModel.swift
//  XCNews
//
//  Created by henry on 2023/2/22.
//

import SwiftUI

@MainActor
class ArticleBookmarkViewModel: ObservableObject{
    @Published private(set) var bookmarks:[Article] = []
    
    private let bookmarksStore = PlistDataStore<[Article]>(fileName: "bookmarks")
    
    static let shared = ArticleBookmarkViewModel()
    private init() {
        Task {
            await load()
        }
    }
    
    private func load() async{
        bookmarks = await bookmarksStore.load() ?? []
    }
    func isBookmark(for article:Article) -> Bool {
        bookmarks.first { article.id == $0.id } != nil
    }
    
    func addBookmark(for article:Article) {
        guard !isBookmark(for: article) else {
            return
        }
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    }
    
    func removeBookmark(for article:Article) {
        guard let index = bookmarks.firstIndex(where: {$0.id == article.id}) else {
            return
        } 
        bookmarks.remove(at: index)
    }
    
    private func bookmarkUpdated() {
        let boookmarks = self.bookmarks
        Task {
            await bookmarksStore.save(_:boookmarks)
        }
    }
}
 
