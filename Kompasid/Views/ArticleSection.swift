//
//  ArticleSection.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 04/08/25.
//

import SwiftUI

struct ArticleSection: View {
    let sectionTitle: String
    let articles: [ArticleItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(sectionTitle)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.blue)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.blue)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(height: 250)
                    .overlay(
                        VStack {
                            Image(systemName: "person.3.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            Text("Article Photo")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    )
                
                if let firstArticle = articles.first, let label = firstArticle.label {
                    Text(label)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(4)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                }
            }
            
            VStack(spacing: 0) {
                ForEach(Array(articles.enumerated()), id: \.offset) { index, article in
                    ArticleRow(article: article)
                    
                    if index < articles.count - 1 {
                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .padding(.horizontal, 16)
                    }
                }
            }        }
    }
}

struct ArticleRow: View {
    let article: ArticleItem
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationLink(destination: ArticleDetailView(articleModel: article.toArticleModel()).environmentObject(homeViewModel)) {
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                if let description = article.description {
                    Text(description)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                HStack {
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: {  }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        }
                        
                        Button(action: { 
                            homeViewModel.toggleBookmark(for: article.toArticleModel())
                        }) {
                            Image(systemName: homeViewModel.isArticleBookmarked(title: article.title) ? "bookmark.fill" : "bookmark")
                                .foregroundColor(homeViewModel.isArticleBookmarked(title: article.title) ? .blue : .gray)
                                .font(.system(size: 16))
                        }
                        
                        CompactAudioPlayerButton(articleModel: article.toArticleModel())
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ArticleItem {
    let title: String
    let description: String?
    let label: String?
    let imageDescription: String?
    let mediaCount: Int?
    
    func toArticleModel() -> ArticleModel {
        let audioURL: String?
        if title.contains("PON") || title.contains("Atlet") {
            audioURL = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3"
        } else if title.contains("Kabinet") || title.contains("Prabowo") {
            audioURL = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3"
        } else if title.contains("Wasit") || title.contains("Final") {
            audioURL = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3"
        } else {
            audioURL = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3"
        }
        
        return ArticleModel(
            id: nil,
            title: title,
            publishedTime: nil,
            category: label,
            description: description,
            imageDescription: imageDescription,
            mediaCount: mediaCount,
            audioURL: audioURL
        )
    }
}

extension PONArticle {
    func toArticleItem() -> ArticleItem {
        return ArticleItem(
            title: title,
            description: description,
            label: label,
            imageDescription: imageDescription,
            mediaCount: nil
        )
    }
}

extension KabinetArticle {
    func toArticleItem() -> ArticleItem {
        return ArticleItem(
            title: title,
            description: description,
            label: nil,
            imageDescription: imageDescription,
            mediaCount: mediaCount
        )
    }
}

#Preview {
    VStack(spacing: 0) {
        // PON Section Preview
        ArticleSection(
            sectionTitle: "PON Aceh–Sumut 2024",
            articles: [
                ArticleItem(
                    title: "Atlet Muda Paling Dirugikan dari Indikasi Kecurangan PON",
                    description: "Dua belas kasus pembunuhan dan analisis data oleh Tim Jurnalisme Data Harian Kompas.",
                    label: "Eksklusif",
                    imageDescription: "Punggung atlet dengan kaus hijau mengangkat tangan di stadion penuh penonton",
                    mediaCount: nil
                ),
                ArticleItem(
                    title: "Jaminan Wasit Berkualitas Tumbuhkan Semangat Jatim–Jabar di Final",
                    description: nil,
                    label: nil,
                    imageDescription: nil,
                    mediaCount: nil
                ),
                ArticleItem(
                    title: "Kontroversi di PON Aceh Mencoreng Sepak Bola Indonesia, Bagaimana Itu Terjadi?",
                    description: nil,
                    label: nil,
                    imageDescription: nil,
                    mediaCount: nil
                )
            ]
        )
        
        // Kabinet Section Preview
        ArticleSection(
            sectionTitle: "Kabinet Prabowo",
            articles: [
                ArticleItem(
                    title: "Kandidat Menteri Prabowo, Profesional yang Sekaligus Kader Parpol",
                    description: "Dua belas kasus pembunuhan dan analisis data oleh Tim Jurnalisme Data Harian Kompas.",
                    label: nil,
                    imageDescription: "Foto resmi jajaran menteri berdiri di Istana Negara",
                    mediaCount: 10
                ),
                ArticleItem(
                    title: "Koalisi Supergemuk; Kabinet 'Zaken' Bukan, Ya?",
                    description: nil,
                    label: nil,
                    imageDescription: nil,
                    mediaCount: nil
                ),
                ArticleItem(
                    title: "Walau Tanpa Partisipasi Publik, DPR Bakal Sahkan Tiga RUU Kilat Kamis Esok",
                    description: nil,
                    label: nil,
                    imageDescription: nil,
                    mediaCount: nil
                )
            ]
        )
    }
    .previewLayout(.sizeThatFits)
} 
