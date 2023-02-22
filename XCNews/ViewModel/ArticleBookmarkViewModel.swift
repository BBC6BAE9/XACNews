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
    
    /// 是否已经被收藏
    func isBookmark(for article:Article) -> Bool {
        bookmarks.first { article.id == $0.id } != nil
    }
    
    func addBookmark(for article:Article) {
        guard !isBookmark(for: article) else {
            return
        }
        bookmarks.insert(article, at: 0)
    }
    
    func removeBookmark(for article:Article) {
        guard let index = bookmarks.firstIndex(where: {$0.id == article.id}) else {
            return
        }
        bookmarks.remove(at: index)
    }
}
