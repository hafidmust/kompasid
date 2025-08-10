//
//  ArticleModel.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 09/08/25.
//

import Foundation

struct ArticleModel: Codable, Identifiable {
    let id: Int?
    let title: String
    let publishedTime: String?
    let category: String?
    let description: String?
    let imageDescription: String?
    let mediaCount: Int?
    let audioURL: String?
    
    var identifiableId: String {
        if let id = id {
            return String(id)
        } else {
            return title
        }
    }
}
