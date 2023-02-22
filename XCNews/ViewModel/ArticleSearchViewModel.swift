//
//  ArticleSearchViewModel.swift
//  XCNews
//
//  Created by henry on 2023/2/22.
//

import Foundation

@MainActor
class ArticlesSearchViewModel: ObservableObject {
    
    @Published var phase:DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    private let newsApi = NewsAPI.shared
    
    func searchArticle() async {
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsApi.search(for: searchQuery)
            phase = .success(articles)
        } catch {
            phase = .failure(error)
        }
    }
}
