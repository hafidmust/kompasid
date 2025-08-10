//
//  MainTabView.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 10/08/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Beranda")
                }
                .tag(0)
            
            EPaperView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "book.pages.fill" : "book.pages")
                    Text("ePaper")
                }
                .tag(1)
            
            TTSView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "grid.circle.fill" : "grid.circle")
                    Text("TTS")
                }
                .tag(2)
            
            BooksView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "book.closed.fill" : "book.closed")
                    Text("Buku")
                }
                .tag(3)
            
            AccountView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                    Text("Akun")
                }
                .tag(4)
        }
        .accentColor(.blue)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            appearance.shadowColor = UIColor.systemGray5
            
            let selectedColor = UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1.0)
            appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: selectedColor,
                .font: UIFont.systemFont(ofSize: 10, weight: .medium)
            ]
            
            let normalColor = UIColor.systemGray
            appearance.stackedLayoutAppearance.normal.iconColor = normalColor
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: normalColor,
                .font: UIFont.systemFont(ofSize: 10, weight: .regular)
            ]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
            UITabBar.appearance().tintColor = selectedColor
            UITabBar.appearance().unselectedItemTintColor = normalColor
        }
    }
}

#Preview {
    MainTabView()
}