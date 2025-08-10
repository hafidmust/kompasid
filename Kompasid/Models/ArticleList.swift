//
//  ArticleList.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 09/08/25.
//


struct ArticleList: Codable {
    let articles: [ArticleKompas]
}

struct ArticleKompas: Codable {
    let title: String
    let description: String?
    let imageDescription: String?
    let label: String?
    let audioURL: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageDescription = "image_description"
        case label
        case audioURL = "audio_url"
    }
    
    func toArticleModel() -> ArticleModel {
        return ArticleModel(
            id: nil,
            title: title,
            publishedTime: nil,
            category: label,
            description: description,
            imageDescription: imageDescription,
            mediaCount: nil,
            audioURL: audioURL
        )
    }
}
