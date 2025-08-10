//
//  BreakingNewsSection.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 03/08/25.
//

import SwiftUI


struct BreakingNewsSection: View {
    let breakingNews: BreakingNews
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                Spacer()
                
                Image("img_breaking_news")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 32)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            VStack(alignment: .center, spacing: 12) {
                Text(breakingNews.headline)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.gray)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    
                
                Text(breakingNews.subheadline)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                
                HStack {
                    Text(breakingNews.publishedTime)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: {  }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        }
                        
                        Button(action: {  }) {
                            Image(systemName: "bookmark")
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        }
                        
                        Button(action: {  }) {
                            Image(systemName: "headphones")
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        }
                    }
                }
                .padding(.horizontal, 16)
                
                Rectangle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        VStack {
                            Image(systemName: "handcuffs")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                            Text("Illustration Placeholder")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    )
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
            }
            .padding(.bottom, 16)
            
            LazyVStack(spacing: 0) {
                ForEach(breakingNews.articles, id: \.title) { article in
                    VStack(spacing: 0) {
                        RelatedArticleRow(article: article)
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.horizontal, 16)
                    }
                }
            }
        }
    }
}

struct RelatedArticleRow: View {
    let article: ArticleNews
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Text(article.publishedTime)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack {
                Spacer()
                HStack(spacing: 16) {
                    Button(action: {  }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                    
                    Button(action: {  }) {
                        Image(systemName: "bookmark")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                    
                    Button(action: {  }) {
                        Image(systemName: "headphones")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                }
            }
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    BreakingNewsSection(breakingNews: BreakingNews(
        headline: "Breaking News: Presiden Jokowi Umumkan Kabinet Baru",
        subheadline: "Kabinet Indonesia Maju akan dilantik minggu depan dengan 34 menteri baru",
        publishedTime: "2 jam yang lalu",
        articles: [
            ArticleNews(
                title: "Jokowi: Kabinet Baru Fokus pada Ekonomi dan Digitalisasi",
                publishedTime: "1 jam yang lalu"
            ),
            ArticleNews(
                title: "Menteri Keuangan Baru Berjanji Stabilkan Rupiah",
                publishedTime: "45 menit yang lalu"
            ),
            ArticleNews(
                title: "Menteri Pendidikan Siapkan Program Merdeka Belajar 2.0",
                publishedTime: "30 menit yang lalu"
            )
        ],
        source: "Kompas.id"
    ))
    .previewLayout(.sizeThatFits)
}
