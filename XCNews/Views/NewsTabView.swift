//
//  NewTabView.swift
//  XCNews
//
//  Created by henry on 2023/2/22.
//

import SwiftUI

struct NewsTabView: View {
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .onAppear{
                    Task.init {
                        await articleNewsVM.loadArticles()
                    }
                }
                .navigationTitle(articleNewsVM.selectedCategory.text)
        }
    }
    
    @ViewBuilder
    private var overlayView:some View {
        switch articleNewsVM.phase{
        case .empty: ProgressView()
        case .success(let articles) where articles.isEmpty: EmptyPlaceHolderView(text: "No Articles", image: nil)
        case .failure(let error): RetryView(text: error.localizedDescription) {
            // Refresh the newsAPI
        }
        default: EmptyView()
        }
    }
    
    private var articles:[Article] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        } else {
            return []
        }
    }
}



struct NewsTabView_Previews: PreviewProvider {
    @StateObject static var articleBookmarkViewModel = ArticleBookmarkViewModel.shared
    static var previews: some View {
        NewsTabView(articleNewsVM: ArticleNewsViewModel(articles: Article.previewData)).environmentObject(articleBookmarkViewModel)
    }
}
