//
//  Article.swift
//  XCNews
//
//  Created by henry on 2023/2/18.
//

import Foundation
// 知识点：5 min ago 时间戳转化技巧
fileprivate let relativeDataFormatter = RelativeDateTimeFormatter()
struct Article {
    let source:Source
    
    let title:String
    let url:String
    let publishedAt: Date
    let author:String?
    let description:String?
    let urlToImage:String?
    
    var authorText: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var captionText:String{
        "\(source.name)·\(relativeDataFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
}

extension Article:Codable{}
extension Article:Equatable{}
extension Article:Identifiable{
    var id: String {url}
}
extension Article{
    static var previewData:[Article] {
        let preViewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: preViewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        let apiResponse  = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)
        return apiResponse.articles ?? []
    }
}

struct Source {
    let name:String
}

// Codable协议是Swift 4中引入的，用于序列化和反序列化数据，可以将对象或结构体编码为JSON、Plist或其他格式的数据，也可以将编码后的数据解码为对象或结构体。一个遵循Codable协议的类型可以自动实现编码和解码功能，只需要声明Codable协议，并在属性上标记相应的编解码属性即可。
extension Source:Codable{}
extension Source:Equatable{}

