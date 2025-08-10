//
//  BooksView.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 10/08/25.
//

import SwiftUI

struct BooksView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "books.vertical")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("Perpustakaan Digital")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Koleksi buku dan majalah digital\nKompas untuk bacaan lengkap")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                
                VStack(spacing: 16) {
                    BookCategoryCard(
                        title: "Buku Kompas",
                        description: "Koleksi buku terbitan Kompas",
                        icon: "book.closed",
                        color: .blue
                    )
                    
                    BookCategoryCard(
                        title: "Majalah",
                        description: "Majalah mingguan dan bulanan",
                        icon: "magazine",
                        color: .green
                    )
                    
                    BookCategoryCard(
                        title: "Laporan Khusus",
                        description: "Investigasi dan laporan mendalam",
                        icon: "doc.text.magnifyingglass",
                        color: .orange
                    )
                }
                .padding(.horizontal, 20)
                
                Text("Segera Hadir")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .cornerRadius(20)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Buku")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct BookCategoryCard: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(color.opacity(0.1))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

#Preview {
    BooksView()
}