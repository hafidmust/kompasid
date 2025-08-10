//
//  JSONDataServices.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 04/08/25.
//

import Foundation

class JSONDataService {
    static let shared = JSONDataService()

    private init() {}

    func getBreakingNews() -> BreakingNews? {
        return loadJSON(filename: "breaking_news")
    }
    
    func getLiveReport() -> LiveReport? {
        return loadJSON(filename: "live_report")
    }
    
    func getIframeCampaign() -> IframeCampaign? {
        return loadJSON(filename: "iframe_campaign")
    }
    
    func getHotTopics() -> HotTopics? {
        return loadJSON(filename: "hot_topics")
    }
    
    func getPONData() -> PONData? {
        return loadJSON(filename: "pon_aceh_sumut")
    }
    
    func getKabinetData() -> KabinetData? {
        return loadJSON(filename: "kabinet")
    }
    
    func getArticles() -> ArticleList? {
        return loadJSON(filename: "articles")
    }

    private func loadJSON<T: Decodable>(filename: String) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("File \(filename) not found")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error decoding \(filename): \(error)")
            return nil
        }
    }
}
