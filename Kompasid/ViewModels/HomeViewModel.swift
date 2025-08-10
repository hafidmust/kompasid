//
//  HomeViewModel.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 08/08/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var breakingNews: BreakingNews?
    @Published var liveReport: LiveReport?
    @Published var iframeCampaign: IframeCampaign?
    @Published var hotTopics: HotTopics?
    @Published var ponData: PONData?
    @Published var kabinetData: KabinetData?
    @Published var articles: ArticleList?
    @Published var bookmarkedArticles: [Article] = []
    @Published var isLoading = false
    
    private let coreDataService = ArticleCoreDataService()

    func loadAllData() {
        isLoading = true
        breakingNews = JSONDataService.shared.getBreakingNews()
        liveReport = JSONDataService.shared.getLiveReport()
        iframeCampaign = JSONDataService.shared.getIframeCampaign()
        hotTopics = JSONDataService.shared.getHotTopics()
        ponData = JSONDataService.shared.getPONData()
        kabinetData = JSONDataService.shared.getKabinetData()
        articles = JSONDataService.shared.getArticles()
        loadBookmarkedArticles()
        isLoading = false
    }
    
    func loadBookmarkedArticles() {
        bookmarkedArticles = coreDataService.getBookmarkedArticles()
    }
    
    func toggleBookmark(for articleModel: ArticleModel) {
        _ = coreDataService.toggleBookmark(for: articleModel)
        loadBookmarkedArticles()
    }
    
    func isArticleBookmarked(title: String) -> Bool {
        return coreDataService.isArticleBookmarked(title: title)
    }
}
