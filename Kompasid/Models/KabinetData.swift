//
//  KabinetData.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 03/08/25.
//


struct KabinetData: Codable {
    let section: String
    let articles: [KabinetArticle]
}

struct KabinetArticle: Codable {
    let title: String
    let description: String?
    let imageDescription: String?
    let mediaCount: Int?

    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageDescription = "image_description"
        case mediaCount = "media_count"
    }
}