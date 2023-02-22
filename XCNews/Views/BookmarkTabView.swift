//
//  BookmarkTabView.swift
//  XCNews
//
//  Created by henry on 2023/2/22.
//

import SwiftUI

struct BookmarkTabView: View {
    @EnvironmentObject var articleBookMarkVM :ArticleBookmarkViewModel
    @State var searchText:String = ""
    
    var body: some View {
        let articles = self.articles
        NavigationView {
            ArticleListView(articles: articles)
                .overlay {
                    overlayView(isEmpty: articles.isEmpty)
                } 
                .navigationTitle("Saved Articles")
        }
        .searchable(text: $searchText)
    }
    
    private var articles:[Article] {
        if searchText.isEmpty {
            return articleBookMarkVM.bookmarks
        } else {
            return articleBookMarkVM.bookmarks.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.descriptionText.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty:Bool) -> some View {
        if (isEmpty) {
            EmptyPlaceHolderView(text: "No saved articles", image: Image(systemName: "bookmark"))
        }
    }
}

struct BookmarkTabView_Previews: PreviewProvider {
    @State static var articleBookMarkVM = ArticleBookmarkViewModel.shared
    static var previews: some View {
        BookmarkTabView().environmentObject(articleBookMarkVM)
    }
}
