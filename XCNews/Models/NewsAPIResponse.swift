//
//  NewsAPIResponse.swift
//  XCNews
//
//  Created by henry on 2023/2/18.
//

import Foundation

struct NewsAPIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
    
}
