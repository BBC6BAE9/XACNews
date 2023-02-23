//
//  ArticleNewsViewModel.swift
//  XCNews
//
//  Created by henry on 2023/2/22.
//

import SwiftUI

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

@MainActor
// TODO: 这个是什么意思？
class ArticleNewsViewModel : ObservableObject{
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var selectedCategory:Category
    private let newsAPI = NewsAPI.shared
    
    init(articles:[Article]? = nil, selectedCategory:Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.selectedCategory = selectedCategory
    }
    
    
    func loadArticles() async {
//        phase = .success(Article.previewData)
        phase = .empty
        do {
            let articles = try await newsAPI.fetch(from: selectedCategory)
            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
    }
}
