//
//  SearchTabView.swift
//  XCNews
//
//  Created by henry on 2023/2/22.
//

import SwiftUI

struct SearchTabView: View {
    
    @StateObject var searchVM = ArticlesSearchViewModel()
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                
                .navigationTitle("Search")
        }
        .searchable(text: $searchVM.searchQuery){
            suggestionsView
        }
        .onChange(of: searchVM.searchQuery){ newValue in
            if newValue.isEmpty{
                searchVM.phase = .empty
            }
        }
        .onSubmit(of: .search, search)
    }
    
    private var articles:[Article]{
        if case .success(let articles) = searchVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var overlayView:some View{
        switch searchVM.phase {
        case .empty:
            if !searchVM.searchQuery.isEmpty {
                ProgressView()
            } else {
                EmptyPlaceHolderView(text: "Type your query to search from NewsAPI", image: Image(systemName: "magnifyingglass"))
            }
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceHolderView(text: "No search result found", image: Image(systemName: "magnifyingglass"))
            
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var suggestionsView:some View {
        ForEach(["Swift", "Covid-19", "BTC", "PS5", "iOS15"], id:\.self) { text in
            Button {
                searchVM.searchQuery = text
            } label: {
                Text(text)
            }
        }
    }
    
    private func search()  {
        Task {
            await searchVM.searchArticle()
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    @StateObject var searchVM = ArticleBookmarkViewModel.shared
    static var previews: some View {
        SearchTabView()
    }
}
