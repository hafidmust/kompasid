//
//  IframeCampaignSection.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 07/08/25.
//

import SwiftUI
import SafariServices

struct IframeCampaignSection: View {
    let iframeCampaign: IframeCampaign
    @State private var showingSafari = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Nama Widget")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {
                    showingSafari = true
                }) {
                    Text("Lihat Selengkapnya")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            Button(action: {
                showingSafari = true
            }) {
                VStack(spacing: 16) {
                    VStack(spacing: 4) {
                        HStack(spacing: 0) {
                            Text("Hitung")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text("Cepat")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Text("LITBANG KOMPAS")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 12, height: 12)
                        
                        Text("166")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("HARI")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.yellow)
                    }
                    
                    Text("Nantikan Hitung Cepat Pilpres dan Pileg 2024, segera hadir 14 Februari 2024.")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                .background(Color.blue)
                .cornerRadius(12)
                .padding(.bottom, 16)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $showingSafari) {
            SafariView(url: URL(string: iframeCampaign.url) ?? URL(string: "https://www.kompas.id/")!)
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}

#Preview {
    IframeCampaignSection(iframeCampaign: IframeCampaign(url: "https://www.kompas.id/"))
        .previewLayout(.sizeThatFits)
} 
