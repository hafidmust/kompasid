//
//  LiveReport.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 04/08/25.
//


struct LiveReport: Codable {
    let reportType: String
    let mainArticle: MainArticle
    let relatedArticles: [RelatedArticle]
    let moreReports: MoreReports
    let featuredArticles: [FeaturedArticle]
    
    enum CodingKeys: String, CodingKey {
        case reportType = "report_type"
        case mainArticle = "main_article"
        case relatedArticles = "related_articles"
        case moreReports = "more_reports"
        case featuredArticles = "featured_articles"
    }
}

struct MainArticle: Codable {
    let category: String
    let title: String
    let publishedTime: String
    
    enum CodingKeys: String, CodingKey {
        case category
        case title
        case publishedTime = "published_time"
    }
}

struct RelatedArticle: Codable {
    let title: String
    let publishedTime: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case publishedTime = "published_time"
    }
}

struct MoreReports: Codable {
    let label: String
    let count: String
}

struct FeaturedArticle: Codable {
    let title: String
}
