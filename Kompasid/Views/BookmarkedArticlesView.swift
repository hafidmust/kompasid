//
//  BookmarkedArticlesView.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 06/08/25.
//

import SwiftUI

struct BookmarkedArticlesView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Text("Baca Nanti")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.kompasBlue,
                        Color.kompasLightBlue
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
                if viewModel.bookmarkedArticles.isEmpty {
                    EmptyBookmarksView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(Array(viewModel.bookmarkedArticles.enumerated()), id: \.element.objectID) { index, article in
                                BookmarkedArticleCard(article: article)
                                    .environmentObject(viewModel)
                                
                                if index < viewModel.bookmarkedArticles.count - 1 {
                                    Divider()
                                        .background(Color.gray.opacity(0.3))
                                        .padding(.horizontal, 16)
                                }
                            }
                        }
                        .padding(.top, 16)
                    }
                }
            }
        .onAppear {
            viewModel.loadBookmarkedArticles()
        }
    }
}

struct EmptyBookmarksView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            
            Image(systemName: "bookmark")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("Belum Ada Artikel Tersimpan")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.gray)
            
            Text("Artikel yang Anda simpan akan muncul di sini")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct BookmarkedArticleCard: View {
    let article: Article
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationLink(destination: ArticleDetailView(articleModel: article.toArticleModel()).environmentObject(homeViewModel)) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 8) {
                        if let category = article.category {
                            Text(category)
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.blue)
                                .cornerRadius(4)
                        }
                        Text(article.title ?? "")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                        if let description = article.articleDescription {
                            Text(description)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                        }
                        if let bookmarkDate = article.bookmarkedDate {
                            Text("Disimpan \(bookmarkDate, style: .relative)")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                        .overlay(
                            Image(systemName: "newspaper.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        )
                }
                HStack {
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        }
                        
                        Button(action: { 
                            let articleModel = article.toArticleModel()
                            homeViewModel.toggleBookmark(for: articleModel)
                        }) {
                            Image(systemName: "bookmark.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 16))
                        }
                        
                        CompactAudioPlayerButton(articleModel: article.toArticleModel())
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    BookmarkedArticlesView()
}
