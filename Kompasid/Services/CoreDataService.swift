//
//  CoreDataService.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 09/08/25.
//

import CoreData
import Foundation

protocol ArticleCoreDataServiceProtocol {
    func saveArticle(_ articleModel: ArticleModel) -> Bool
    func getAllSavedArticles() -> [Article]
    func getSavedArticle(by id: Int) -> Article?
    func getSavedArticle(byTitle title: String) -> Article?
    func deleteArticle(by id: Int) -> Bool
    func toggleFavorite(articleId: Int) -> Bool
    func getFavoriteArticles() -> [Article]
    func isArticleSaved(id: Int) -> Bool
    func isArticleFavorite(id: Int) -> Bool
    func clearAllArticles() -> Bool
    
    func bookmarkArticle(_ articleModel: ArticleModel) -> Bool
    func unbookmarkArticle(byTitle title: String) -> Bool
    func toggleBookmark(for articleModel: ArticleModel) -> Bool
    func getBookmarkedArticles() -> [Article]
    func isArticleBookmarked(title: String) -> Bool
    func clearAllBookmarks() -> Bool
}

class ArticleCoreDataService: ArticleCoreDataServiceProtocol {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataStack.shared.context) {
        self.context = context
    }
    
    func saveArticle(_ articleModel: ArticleModel) -> Bool {
        if getSavedArticle(byTitle: articleModel.title) != nil {
            print("Article with title '\(articleModel.title)' already exists")
            return false
        }
        
        let article = Article(context: context, from: articleModel)
        
        do {
            try context.save()
            print("Article saved successfully: \(articleModel.title)")
            return true
        } catch {
            print("Failed to save article: \(error)")
            context.rollback()
            return false
        }
    }
    
    func getAllSavedArticles() -> [Article] {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Article.articleId, ascending: false)
        ]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch articles: \(error)")
            return []
        }
    }
    
    func getSavedArticle(by id: Int) -> Article? {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "articleId == %d", id)
        request.fetchLimit = 1
        
        do {
            let articles = try context.fetch(request)
            return articles.first
        } catch {
            print("Failed to fetch article by id: \(error)")
            return nil
        }
    }
    
    func getSavedArticle(byTitle title: String) -> Article? {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)
        request.fetchLimit = 1
        
        do {
            let articles = try context.fetch(request)
            return articles.first
        } catch {
            print("Failed to fetch article by title: \(error)")
            return nil
        }
    }
    
    func deleteArticle(by id: Int) -> Bool {
        guard let article = getSavedArticle(by: id) else {
            print("Article with id \(id) not found")
            return false
        }
        
        context.delete(article)
        
        do {
            try context.save()
            print("Article deleted successfully")
            return true
        } catch {
            print("Failed to delete article: \(error)")
            context.rollback()
            return false
        }
    }
    
    func toggleFavorite(articleId: Int) -> Bool {
        guard let article = getSavedArticle(by: articleId) else {
            print("Article with id \(articleId) not found")
            return false
        }
        
        article.isFavorite.toggle()
        
        do {
            try context.save()
            print("Favorite status toggled for article: \(String(describing: article.title))")
            return true
        } catch {
            print("Failed to toggle favorite: \(error)")
            context.rollback()
            return false
        }
    }
    
    func getFavoriteArticles() -> [Article] {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == YES")
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Article.articleId, ascending: false)
        ]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch favorite articles: \(error)")
            return []
        }
    }
    
    func isArticleSaved(id: Int) -> Bool {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "articleId == %d", id)
        request.fetchLimit = 1
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Failed to check if article is saved: \(error)")
            return false
        }
    }
    
    func isArticleFavorite(id: Int) -> Bool {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "articleId == %d AND isFavorite == YES", id)
        request.fetchLimit = 1
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Failed to check if article is favorite: \(error)")
            return false
        }
    }
    
    func clearAllArticles() -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = Article.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("All articles cleared successfully")
            return true
        } catch {
            print("Failed to clear all articles: \(error)")
            return false
        }
    }
    
    func bookmarkArticle(_ articleModel: ArticleModel) -> Bool {
        if let existingArticle = getSavedArticle(byTitle: articleModel.title) {
            existingArticle.isBookmarked = true
            existingArticle.bookmarkedDate = Date()
        } else {
            let article = Article(context: context, from: articleModel)
            article.isBookmarked = true
            article.bookmarkedDate = Date()
        }
        
        do {
            try context.save()
            print("Article bookmarked successfully: \(articleModel.title)")
            return true
        } catch {
            print("Failed to bookmark article: \(error)")
            context.rollback()
            return false
        }
    }
    
    func unbookmarkArticle(byTitle title: String) -> Bool {
        guard let article = getSavedArticle(byTitle: title) else {
            print("Article with title '\(title)' not found")
            return false
        }
        
        article.isBookmarked = false
        article.bookmarkedDate = nil
        
        do {
            try context.save()
            print("Article unbookmarked successfully")
            return true
        } catch {
            print("Failed to unbookmark article: \(error)")
            context.rollback()
            return false
        }
    }
    
    func toggleBookmark(for articleModel: ArticleModel) -> Bool {
        if let existingArticle = getSavedArticle(byTitle: articleModel.title) {
            existingArticle.isBookmarked.toggle()
            if existingArticle.isBookmarked {
                existingArticle.bookmarkedDate = Date()
            } else {
                existingArticle.bookmarkedDate = nil
            }
            
            do {
                try context.save()
                print("Bookmark status toggled for article: \(String(describing: existingArticle.title))")
                return true
            } catch {
                print("Failed to toggle bookmark: \(error)")
                context.rollback()
                return false
            }
        } else {
            return bookmarkArticle(articleModel)
        }
    }
    
    func getBookmarkedArticles() -> [Article] {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "isBookmarked == YES")
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Article.bookmarkedDate, ascending: false)
        ]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch bookmarked articles: \(error)")
            return []
        }
    }
    
    func isArticleBookmarked(title: String) -> Bool {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@ AND isBookmarked == YES", title)
        request.fetchLimit = 1
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Failed to check if article is bookmarked: \(error)")
            return false
        }
    }
    
    func clearAllBookmarks() -> Bool {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        request.predicate = NSPredicate(format: "isBookmarked == YES")
        
        do {
            let bookmarkedArticles = try context.fetch(request)
            for article in bookmarkedArticles {
                article.isBookmarked = false
                article.bookmarkedDate = nil
            }
            
            try context.save()
            print("All bookmarks cleared successfully")
            return true
        } catch {
            print("Failed to clear all bookmarks: \(error)")
            context.rollback()
            return false
        }
    }
}
