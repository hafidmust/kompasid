//
//  ArticleDetailView.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 10/08/25.
//

import SwiftUI

struct ArticleDetailView: View {
    let articleModel: ArticleModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Rectangle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(height: 250)
                    .overlay(
                        VStack {
                            Image(systemName: "newspaper.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            Text("Article Image")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    )
                
                VStack(alignment: .leading, spacing: 16) {
                    if let category = articleModel.category {
                        Text(category)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue)
                            .cornerRadius(6)
                    }
                    
                    Text(articleModel.title)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                    
                    if let publishedTime = articleModel.publishedTime {
                        Text(publishedTime)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    if let description = articleModel.description {
                        Text(description)
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    }
                    
                    if let imageDescription = articleModel.imageDescription {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Keterangan Gambar:")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Text(imageDescription)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .italic()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    if let mediaCount = articleModel.mediaCount, mediaCount > 0 {
                        HStack {
                            Image(systemName: "photo")
                                .foregroundColor(.blue)
                            Text("\(mediaCount) media")
                                .font(.system(size: 14))
                                .foregroundColor(.blue)
                        }
                    }
                    
                    if articleModel.audioURL != nil {
                        AudioPlayerView(articleModel: articleModel)
                            .padding(.top, 16)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Konten Artikel")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text("Ini adalah placeholder untuk konten artikel. Dalam implementasi nyata, konten artikel akan ditampilkan di sini dengan formatting yang sesuai.")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .lineLimit(nil)
                        
                        Text("Konten dapat berupa teks panjang dengan beberapa paragraf, gambar, video, atau media lainnya yang terkait dengan artikel ini.")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .lineLimit(nil)
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle("Detail Artikel")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    Button(action: {
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.blue)
                    }
                    
                    Button(action: {
                        homeViewModel.toggleBookmark(for: articleModel)
                    }) {
                        Image(systemName: homeViewModel.isArticleBookmarked(title: articleModel.title) ? "bookmark.fill" : "bookmark")
                            .foregroundColor(homeViewModel.isArticleBookmarked(title: articleModel.title) ? .blue : .gray)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        ArticleDetailView(
            articleModel: ArticleModel(
                id: nil,
                title: "Kabar Duka Pendaki di Puncak Carstensz, Ancaman Mematikan akibat Hipotermia",
                publishedTime: "2 jam yang lalu",
                category: "Berita Utama",
                description: "Serangan hipotermia menjadi salah satu ancaman yang mesti diwaspadai saat melakukan pendakian gunung. Kondisi cuaca ekstrem di ketinggian dapat menyebabkan penurunan suhu tubuh yang berbahaya.",
                imageDescription: "Pendaki dalam cuaca bersalju di puncak gunung dengan peralatan lengkap",
                mediaCount: 5,
                audioURL: nil
            )
        )
        .environmentObject(HomeViewModel())
    }
}
