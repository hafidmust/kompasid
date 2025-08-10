//
//  HomeView.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 03/08/25.
//

import SwiftUI


struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showingBookmarks = false
    @State private var selectedCategory: NewsCategory = .beritaUtama
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Image("kompasid_logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 35)
                        .clipped()
                    
                    Spacer()
                    
                    Button(action: {}) {
                        ZStack {
                            Image(systemName: "bell")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)
                            
                            Circle()
                                .fill(Color.orange)
                                .frame(width: 8, height: 8)
                                .offset(x: 6, y: -6)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 16)
                .background(Color.kompasBlue)
                TopNavigationView(selectedCategory: $selectedCategory)
                
                ScrollView {
                    VStack(spacing: 0) {
                        switch selectedCategory {
                        case .beritaUtama:
                            BeritaUtamaContent(viewModel: viewModel)
                        case .terbaru:
                            TerbaruContent(viewModel: viewModel)
                        case .pilihanku:
                            PilihanKuContent(viewModel: viewModel)
                        case .bebas:
                            BebasContent(viewModel: viewModel)
                        }
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingBookmarks = true }) {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.loadAllData() }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showingBookmarks) {
                BookmarkedArticlesView()
            }
        }
        .onAppear {
            viewModel.loadAllData()
        }
    }
}


struct BeritaUtamaContent: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if let breakingNews = viewModel.breakingNews {
                BreakingNewsSection(breakingNews: breakingNews)
            }
            
            if let liveReport = viewModel.liveReport {
                LiveReportSection(liveReport: liveReport)
            }
            
            if let iframeCampaign = viewModel.iframeCampaign {
                IframeCampaignSection(iframeCampaign: iframeCampaign)
            }
            
            if let hotTopics = viewModel.hotTopics {
                HotTopicsSection(hotTopics: hotTopics)
            }
            
            if let kabinetData = viewModel.kabinetData {
                ArticleSection(
                    sectionTitle: kabinetData.section,
                    articles: kabinetData.articles.map { $0.toArticleItem() }
                )
                .environmentObject(viewModel)
            }
            
            if let ponData = viewModel.ponData {
                ArticleSection(
                    sectionTitle: ponData.section,
                    articles: ponData.articles.map { $0.toArticleItem() }
                )
                .environmentObject(viewModel)
            }
            
            AdsBannerSection()
            
            if let articles = viewModel.articles {
                ArticlesSection(articles: articles.articles)
                    .environmentObject(viewModel)
            }
        }
    }
}

struct TerbaruContent: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if let articles = viewModel.articles {
                ArticlesSection(articles: articles.articles)
                    .environmentObject(viewModel)
            }
            
            if let breakingNews = viewModel.breakingNews {
                BreakingNewsSection(breakingNews: breakingNews)
            }
            
            if let liveReport = viewModel.liveReport {
                LiveReportSection(liveReport: liveReport)
            }
        }
    }
}

struct PilihanKuContent: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            if !viewModel.bookmarkedArticles.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Artikel Tersimpan Anda")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                        NavigationLink(destination: BookmarkedArticlesView()) {
                            Text("Lihat Semua")
                                .font(.system(size: 14))
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Array(viewModel.bookmarkedArticles.prefix(5)), id: \.objectID) { article in
                                BookmarkPreviewCard(article: article)
                                    .environmentObject(viewModel)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            } else {
                EmptyStateView(
                    icon: "heart",
                    title: "Belum Ada Pilihan",
                    description: "Simpan artikel favorit Anda untuk muncul di sini"
                )
            }
            
            if let articles = viewModel.articles {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Rekomendasi untuk Anda")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                    
                    ArticlesSection(articles: Array(articles.articles.prefix(3)))
                        .environmentObject(viewModel)
                }
            }
        }
        .padding(.top, 16)
    }
}

struct BebasContent: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "lock.open")
                        .foregroundColor(.green)
                    Text("Artikel Bebas Akses")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                Text("Artikel ini dapat dibaca tanpa berlangganan")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
            }
            
            if let articles = viewModel.articles {
                let freeArticles = articles.articles.filter { _ in 
                    Bool.random()
                }
                
                if !freeArticles.isEmpty {
                    ArticlesSection(articles: freeArticles)
                        .environmentObject(viewModel)
                } else {
                    ArticlesSection(articles: Array(articles.articles.prefix(2)))
                        .environmentObject(viewModel)
                }
            }
        }
        .padding(.top, 16)
    }
}


struct BookmarkPreviewCard: View {
    let article: Article
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationLink(destination: ArticleDetailView(articleModel: article.toArticleModel()).environmentObject(homeViewModel)) {
            VStack(alignment: .leading, spacing: 8) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 100)
                    .cornerRadius(8)
                    .overlay(
                        Image(systemName: "newspaper.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    )
                
                Text(article.title ?? "")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .frame(width: 150, alignment: .leading)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct EmptyStateView: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(.gray)
            
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
            
            Text(description)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .padding(.vertical, 40)
    }
}
