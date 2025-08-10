//
//  AccountView.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 10/08/25.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Akun")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
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
                
                ScrollView {
                    VStack(spacing: 0) {
                        VStack(spacing: 16) {
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 60, height: 60)
                                    
                                    Text("H")
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("hafidalimustaqim13")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.black)
                                    
                                    Text("Tidak Berlangganan")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                            }
                            
                            Button(action: {
                            }) {
                                Text("Perbarui Langganan")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(Color.green)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(20)
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        
                        VStack(spacing: 0) {
                            AccountMenuItem(
                                icon: "person.circle.fill",
                                iconColor: .blue,
                                title: "Kelola Akun",
                                description: "Lihat dan atur akun, status langganan, serta rubrik pilihan Anda."
                            )
                            
                            NavigationLink(destination: BookmarkedArticlesView()) {
                                HStack(alignment: .top, spacing: 16) {
                                                    Image(systemName: "bookmark.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.blue)
                                        .frame(width: 24, height: 24)
                                        .padding(.top, 2)
                                    
                                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Baca Nanti")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text("Daftar artikel yang Anda simpan untuk dibaca nanti.")
                                            .font(.system(size: 14))
                                            .foregroundColor(.gray)
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 16)
                                .background(Color.white)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .padding(.leading, 56)
                                .background(Color.white)
                            
                            AccountMenuItem(
                                icon: "gift.fill",
                                iconColor: .orange,
                                title: "Reward",
                                description: "Lihat berbagai reward yang dapat Anda gunakan."
                            )
                            
                            AccountMenuItem(
                                icon: "gearshape.fill",
                                iconColor: .blue,
                                title: "Pengaturan",
                                description: "Atur fitur untuk akun Anda."
                            )
                            
                            AccountMenuItem(
                                icon: "phone.fill",
                                iconColor: .blue,
                                title: "Hubungi Kami",
                                description: "Sampaikan kendala, kritik, dan saran Anda ke Tim Kompas.id."
                            )
                            
                            AccountMenuItem(
                                icon: "questionmark.circle.fill",
                                iconColor: .blue,
                                title: "Tanya Jawab",
                                description: "Temukan jawaban dari pertanyaan Anda seputar Kompas.id."
                            )
                            
                            AccountMenuItem(
                                icon: "info.circle.fill",
                                iconColor: .blue,
                                title: "Tentang Aplikasi",
                                description: "Lihat informasi lengkap tentang aplikasi Kompas.id."
                            )
                            
                            AccountMenuItem(
                                icon: "calendar.circle.fill",
                                iconColor: .blue,
                                title: "Tentang Harian Kompas",
                                description: "Lihat profil lengkap Harian Kompas.",
                                showDivider: false
                            )
                        }
                        .padding(.top, 24)
                    }
                    .padding(.bottom, 24)
                }
                .background(Color(UIColor.systemGroupedBackground))
                .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    struct AccountMenuItem: View {
        let icon: String
        let iconColor: Color
        let title: String
        let description: String
        var showDivider: Bool = true
        var action: (() -> Void)? = nil
        
        var body: some View {
            Button(action: action ?? {}) {
                HStack(alignment: .top, spacing: 16) {
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(iconColor)
                        .frame(width: 24, height: 24)
                        .padding(.top, 2)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                        
                        Text(description)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Color.white)
            }
            .buttonStyle(PlainButtonStyle())
            
            if showDivider {
                Divider()
                    .padding(.leading, 56)
                    .background(Color.white)
            }
        }
    }
}

#Preview {
    AccountView()
}
