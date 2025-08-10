//
//  PONData.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 09/08/25.
//


struct PONData: Codable {
    let section: String
    let articles: [PONArticle]
}

struct PONArticle: Codable {
    let title: String
    let label: String?
    let description: String?
    let imageDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case label
        case description
        case imageDescription = "image_description"
    }
}