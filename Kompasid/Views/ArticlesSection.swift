//
//  ArticlesSection.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 05/08/25.
//

import SwiftUI
import UIKit

struct ArticlesSection: View {
    let articles: [ArticleKompas]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(Array(articles.enumerated()), id: \.offset) { index, article in
                if index == 0 {
                    FeaturedArticleCard(article: article)
                } else {
                    ArticleCard(article: article)
                }
            }
        }
        .padding(.vertical, 16)
    }
}

struct ShareSheet: View {
    let article: ArticleKompas
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { isPresented = false }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Bagikan")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                Color.clear
                    .frame(width: 24, height: 24)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
            VStack(spacing: 0) {
                Spacer()
                
                // Article Preview Card
                VStack(spacing: 16) {
                    HStack {
                        Spacer()
                        Text("KOMPAS.id")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                    }
                    
                    ZStack {
                        Image(systemName: "megaphone.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                    }
                    .frame(height: 80)
                    
                    Text("ARTIKEL OPINI")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                    
                    Text(article.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                    
                    Text("Baca selengkapnya di Kompas.id")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 12) {
                        Button(action: {}) {
                            HStack(spacing: 8) {
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 16))
                                Text("DAPATKAN DI Google Play")
                                    .font(.system(size: 10, weight: .medium))
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        
                        Button(action: {}) {
                            HStack(spacing: 8) {
                                Image(systemName: "apple.logo")
                                    .font(.system(size: 16))
                                Text("Download di App Store")
                                    .font(.system(size: 10, weight: .medium))
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                .padding(.horizontal, 20)
                
                Spacer()
                
                VStack(spacing: 20) {
                    HStack(spacing: 40) {
                        ShareOption(icon: "link", title: "Salin Tautan"){
                            UIPasteboard.general.string = "https://kompas.id"
                            isPresented = false
                        }
                        ShareOption(icon: "message.fill", title: "WhatsApp"){
                            let whatsappURL = URL(string: "https://wa.me/?text=https://kompas.id")!
                            UIApplication.shared.open(whatsappURL)
                        }
                        ShareOption(icon: "camera.fill", title: "Instagram Stories"){
                            let instagramURL = URL(string: "https://www.instagram.com/share?url=https://kompas.id")!
                            UIApplication.shared.open(instagramURL)
                        }
                        ShareOption(icon: "square.and.arrow.up", title: "Bagikan via..."){
                            
                        }
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .background(Color(red: 0.96, green: 0.94, blue: 0.90)) // Beige background
    }
}

struct ShareOption: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Button(action: action) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    )
            }
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
    }
}

struct FeaturedArticleCard: View {
    let article: ArticleKompas
    @State private var showShareSheet = false
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationLink(destination: ArticleDetailView(articleModel: article.toArticleModel()).environmentObject(homeViewModel)) {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        VStack {
                            Image(systemName: "mountain.2.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            Text("Mountain Photo")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    )
                
                VStack(spacing: 12) {
                    Text(article.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                    
                    if let description = article.description {
                        Text(description)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .lineLimit(3)
                            .multilineTextAlignment(.center)
                    }
                    
                    HStack {
                        Spacer()
                        
                        HStack(spacing: 16) {
                            Button(action: { showShareSheet = true }) {
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
            .background(Color.white)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(article: article, isPresented: $showShareSheet)
        }
    }
}

struct ArticleCard: View {
    let article: ArticleKompas
    @State private var showShareSheet = false
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationLink(destination: ArticleDetailView(articleModel: article.toArticleModel()).environmentObject(homeViewModel)) {
            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    if let label = article.label {
                        Text(label)
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.blue)
                            .cornerRadius(4)
                    }
                    
                    Text(article.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    
                    
                }
                
                Spacer()
                
                VStack(spacing: 8) {
                    Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(8)
                                    .overlay(
                                        Image(systemName: getIconForArticle(article.title))
                                            .font(.system(size: 24))
                                            .foregroundColor(.white)
                                    )
                    
                    HStack(spacing: 8) {
                        Button(action: { showShareSheet = true }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        }
                        
                        Button(action: { 
                            homeViewModel.toggleBookmark(for: article.toArticleModel())
                        }) {
                            Image(systemName: homeViewModel.isArticleBookmarked(title: article.title) ? "bookmark.fill" : "bookmark")
                                .foregroundColor(homeViewModel.isArticleBookmarked(title: article.title) ? .blue : .gray)
                                .font(.system(size: 14))
                        }
                        
                        CompactAudioPlayerButton(articleModel: article.toArticleModel())
                    }
                }
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.white)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(article: article, isPresented: $showShareSheet)
        }
    }
    
    private func getIconForArticle(_ title: String) -> String {
        if title.contains("Delta Airlines") || title.contains("Pesawat") {
            return "airplane"
        } else if title.contains("Pertamina") {
            return "building.2.fill"
        } else if title.contains("Gempa") {
            return "waveform.path.ecg"
        } else {
            return "newspaper.fill"
        }
    }
}

#Preview {
    ArticlesSection(articles: [
        ArticleKompas(
            title: "Kabar Duka Pendaki di Puncak Carstensz, Ancaman Mematikan akibat Hipotermia",
            description: "Serangan hipotermia menjadi salah satu ancaman yang mesti diwaspadai saat melakukan pendakian gunung.",
            imageDescription: "Pendaki dalam cuaca bersalju di puncak gunung",
            label: nil,
            audioURL: nil
        ),
        ArticleKompas(
            title: "Delta Airlines Terbalik Saat Mendarat, 18 Orang Terluka",
            description: nil,
            imageDescription: "Pesawat di landasan bersalju dengan kendaraan evakuasi",
            label: nil,
            audioURL: nil
        ),
        ArticleKompas(
            title: "Pertamina Akan Maksimalkan Pemanfaatan Minyak Mentah Dalam Negeri",
            description: nil,
            imageDescription: "Sejumlah petugas Pertamina berfoto di kilang atau lokasi operasional",
            label: nil,
            audioURL: nil
        ),
        ArticleKompas(
            title: "Lokasi Dua Gempa di Selatan Jabar Berdekatan, Warga Diminta Waspada",
            description: nil,
            imageDescription: "Pemandangan alam saat senja dengan langit berwarna oranye",
            label: "Bebas Akses",
            audioURL: nil
        )
    ])
    .background(Color.gray.opacity(0.1))
    .previewLayout(.sizeThatFits)
} 
