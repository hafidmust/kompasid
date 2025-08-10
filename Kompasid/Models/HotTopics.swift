//
//  HotTopics.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 08/08/25.
//


struct HotTopics: Codable {
    let section: String
    let topics: [Topic]
}

struct Topic: Codable {
    let title: String
    let imageDescription: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageDescription = "image_description"
    }
}