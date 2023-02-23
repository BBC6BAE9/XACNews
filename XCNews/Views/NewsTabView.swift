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
                .refreshable {
//                    loadTask()
                }
                .task(id: articleNewsVM.selectedCategory, loadTask)
                .onAppear{
//                    loadTask()
                }
                .navigationTitle(articleNewsVM.selectedCategory.text)
                .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var overlayView:some View {
        switch articleNewsVM.phase{
        case .empty: ProgressView()
        case .success(let articles) where articles.isEmpty: EmptyPlaceHolderView(text: "No Articles", image: nil)
        case .failure(let error): RetryView(text: error.localizedDescription) {
//            loadTask()
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
    
    private func loadTask() async{
        await articleNewsVM.loadArticles()
    }
    
    private var menu:some View {
        Menu {
            Picker("Category", selection: $articleNewsVM.selectedCategory){
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }
    }
}



struct NewsTabView_Previews: PreviewProvider {
    @StateObject static var articleBookmarkViewModel = ArticleBookmarkViewModel.shared
    static var previews: some View {
        NewsTabView(articleNewsVM: ArticleNewsViewModel(articles: Article.previewData)).environmentObject(articleBookmarkViewModel)
    }
}
