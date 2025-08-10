//
//  BreakingNews.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 05/08/25.
//

struct BreakingNews: Codable {
    let headline: String
    let subheadline: String
    let publishedTime: String
    let articles: [ArticleNews]
    let source: String
    
    enum CodingKeys: String, CodingKey {
        case headline
        case subheadline
        case publishedTime = "published_time"
        case articles
        case source
    }
}

struct ArticleNews: Codable {
    let title: String
    let publishedTime: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case publishedTime = "published_time"
    }
}
