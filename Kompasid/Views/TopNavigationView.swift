//
//  TopNavigationView.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 10/08/25.
//

import SwiftUI

enum NewsCategory: String, CaseIterable {
    case beritaUtama = "BERITA UTAMA"
    case terbaru = "TERBARU"
    case pilihanku = "PILIHANKU"
    case bebas = "BEBAS"
}

struct TopNavigationView: View {
    @Binding var selectedCategory: NewsCategory
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(NewsCategory.allCases, id: \.self) { category in
                        CategoryTab(
                            category: category,
                            isSelected: selectedCategory == category
                        ) {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.top, 12)
                .padding(.bottom, 8)
                
                HStack(spacing: 0) {
                    ForEach(NewsCategory.allCases, id: \.self) { category in
                        Rectangle()
                            .fill(selectedCategory == category ? Color.green : Color.clear)
                            .frame(height: 3)
                    }
                }
            }
            .background(
                Color.kompasBlue
            )
        }
    }
}

struct CategoryTab: View {
    let category: NewsCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(category.rawValue)
                    .font(.system(size: 14, weight: isSelected ? .bold : .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 4)
            .padding(.vertical, 8)
            .background(Color.clear)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CompactTopNavigationView: View {
    @Binding var selectedCategory: NewsCategory
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(NewsCategory.allCases, id: \.self) { category in
                    CompactCategoryTab(
                        category: category,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
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
    }
}

struct CompactCategoryTab: View {
    let category: NewsCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Text(category.rawValue)
                    .font(.system(size: 13, weight: isSelected ? .bold : .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Rectangle()
                    .fill(isSelected ? Color.green : Color.clear)
                    .frame(height: 2)
                    .frame(minWidth: 40)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack {
        TopNavigationView(selectedCategory: .constant(.beritaUtama))
        
        Spacer()
            .frame(height: 20)
        
        CompactTopNavigationView(selectedCategory: .constant(.terbaru))
        
        Spacer()
    }
}
