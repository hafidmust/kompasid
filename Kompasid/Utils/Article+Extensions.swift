//
//  Article+Extensions.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 09/08/25.
//

import Foundation
import CoreData

extension Article {
    
    func configure(from articleModel: ArticleModel) {
        self.articleId = Int32(articleModel.id ?? 0)
        self.title = articleModel.title
        self.publishedTime = articleModel.publishedTime
        self.category = articleModel.category
        self.articleDescription = articleModel.description
        self.imageDescription = articleModel.imageDescription
        self.mediaCount = Int32(articleModel.mediaCount ?? 0)
        self.audioURL = articleModel.audioURL
        self.isFavorite = false
        self.isBookmarked = false
        self.bookmarkedDate = nil
        self.uniqueIdentifier = UUID()
    }
    
    func toArticleModel() -> ArticleModel {
        return ArticleModel(
            id: self.articleId > 0 ? Int(self.articleId) : nil,
            title: self.title ?? "",
            publishedTime: self.publishedTime,
            category: self.category,
            description: self.articleDescription,
            imageDescription: self.imageDescription,
            mediaCount: self.mediaCount > 0 ? Int(self.mediaCount) : nil,
            audioURL: self.audioURL
        )
    }
    
}

extension Article {
    convenience init(context: NSManagedObjectContext, from articleModel: ArticleModel) {
        self.init(context: context)
        self.configure(from: articleModel)
    }
}
