//
//  Categry.swift
//  XCNews
//
//  Created by henry on 2023/2/21.
//

import Foundation

enum Category:String, CaseIterable {
    case general
    case bussiness
    case technology
    case entertainment
    case sports
    case science
    case health
    
    var text:String{
        if self == .general{
            return "Top Headline"
        }
        return rawValue.capitalized
    }
}

extension Category:Identifiable {
    var id: Self { self }
}
