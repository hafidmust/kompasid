//
//  LiveReportSection.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 09/08/25.
//

import SwiftUI

struct LiveReportSection: View {
    let liveReport: LiveReport
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(height: 250)
                    .overlay(
                        VStack {
                            Image(systemName: "person.3.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            Text("Kampanye Photo")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    )
                
                Text(liveReport.reportType)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.red)
                    .cornerRadius(4)
                    .padding(.top, 16)
                    .padding(.leading, 16)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(liveReport.mainArticle.category)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.red)
                
                Text(liveReport.mainArticle.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .lineLimit(3)
                
                Text(liveReport.mainArticle.publishedTime)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(Array(liveReport.relatedArticles.enumerated()), id: \.offset) { index, article in
                    HStack(alignment: .top, spacing: 12) {
                        VStack(spacing: 0) {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 8, height: 8)
                            
                            if index < liveReport.relatedArticles.count - 1 {
                                Rectangle()
                                    .fill(Color.red.opacity(0.3))
                                    .frame(width: 2, height: 40)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(article.title)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black)
                                .lineLimit(3)
                            
                            Text(article.publishedTime)
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            HStack {
                Text(liveReport.moreReports.label)
                    .font(.system(size: 14, weight: .semibold))
                
                Button(action: {  }) {
                    Text(liveReport.moreReports.count)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.red)
                        .cornerRadius(24)
                }
                Spacer()
                
                Button(action: {  }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            VStack(spacing: 0) {
                ForEach(Array(liveReport.featuredArticles.enumerated()), id: \.offset) { index, article in
                    VStack(spacing: 0) {
                        if index > 0 {
                            Divider()
                                .background(Color.gray.opacity(0.3))
                                .padding(.horizontal, 16)
                        }
                        
                        FeaturedArticleRow(article: article)
                    }
                }
            }
            .padding(.top, 16)
        }
    }
}

struct FeaturedArticleRow: View {
    let article: FeaturedArticle
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(3)
            }
            
            Spacer()
            
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 60)
                .cornerRadius(4)
                .overlay(
                    Image(systemName: "person.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    LiveReportSection(liveReport: LiveReport(
        reportType: "Reportase Langsung",
        mainArticle: MainArticle(
            category: "Kampanye Pamungkas Anies, Prabowo, dan Ganjar",
            title: "Di Jakarta, Prabowo Tinggalkan Lokasi Kampanye Akbar di GBK",
            publishedTime: "1 menit lalu"
        ),
        relatedArticles: [
            RelatedArticle(
                title: "Megawati Bernyanyi dan Berjoget saat Kampanye Ganjar-Mahfud di Semarang",
                publishedTime: "5 menit lalu"
            ),
            RelatedArticle(
                title: "Gibran Harap Semua Pendukung di GBK Coblos No 2 di TPS",
                publishedTime: "15 menit lalu"
            )
        ],
        moreReports: MoreReports(
            label: "Lihat laporan lainnya",
            count: "5+"
        ),
        featuredArticles: [
            FeaturedArticle(title: "Presiden Minta 'Bola Panas' Kadin Jangan Dilempar ke Dirinya"),
            FeaturedArticle(title: "Presiden Minta 'Bola Panas' Kadin Jangan Dilempar ke Dirinya"),
            FeaturedArticle(title: "Presiden Minta 'Bola Panas' Kadin Jangan Dilempar ke Dirinya")
        ]
    ))
    .previewLayout(.sizeThatFits)
} 
