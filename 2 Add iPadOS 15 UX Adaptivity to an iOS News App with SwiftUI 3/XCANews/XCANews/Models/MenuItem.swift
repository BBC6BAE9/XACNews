//
//  MenuItems.swift
//  XCANews
//
//  Created by henry on 2023/2/25.
//

import Foundation

enum MenuItem:CaseIterable{
    
    static var allCases: [MenuItem]{
        return [.search, .saved] + Category.menuItems
    }
    
    case search
    case saved
    case category(Category)
    
    var text:String{
        switch self {
        case .search:
            return "Search"
        case .saved:
            return "Saved"
        case .category(let category):
            return category.text
        }
    }
    
    var systemImage:String {
        switch self {
        case .search:
            return "magnifyingglass"
        case .saved:
            return "bookmark"
        case .category(let category):
            return category.systemImage
        }
    }
}

extension MenuItem:Identifiable {
    var id:String{
        switch self {
        case .search:
            return "search"
        case .saved:
            return "saved"
        case .category(let category):
            return category.rawValue
        }
    }
}

extension Category {
    static var menuItems:[MenuItem]{
        allCases.map {.category($0)}
    }
}
