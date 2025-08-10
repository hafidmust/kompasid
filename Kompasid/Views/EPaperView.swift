//
//  EPaperView.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 10/08/25.
//

import SwiftUI

struct EPaperView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "book.pages")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("ePaper")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Baca koran digital Kompas\ndengan pengalaman yang interaktif")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                
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
            .navigationTitle("ePaper")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    EPaperView()
}