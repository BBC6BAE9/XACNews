//
//  ArticleNewsViewModel.swift
//  XCANews
//
//  Created by Alfian Losari on 6/27/21.
//

import SwiftUI

enum DataFetchPhase<T> {
    
    case empty
    case success(T)
    case failure(Error)
}

struct FetchTaskToken: Equatable {
    var category: Category
    var token: Date
}

fileprivate let dataFormatter = DateFormatter()

@MainActor
class ArticleNewsViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken {
        didSet{
            if oldValue.category != fetchTaskToken.category {
                selectedMenuItemId = MenuItem.category(fetchTaskToken.category).id
            }
        }
    }
    @AppStorage("item_selection") var selectedMenuItemId:MenuItem.ID?

    
    private let newsAPI = NewsAPI.shared
    var lastRefreshedDateText:String {
        dataFormatter.timeStyle = .short
        return "Last refreshed at: \(dataFormatter.string(from: fetchTaskToken.token))"
    }
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
    }
    
    func loadArticles() async {
        if Task.isCancelled { return }
        phase = .empty
        do {
            let articles = try await newsAPI.fetch(from: fetchTaskToken.category)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
}
