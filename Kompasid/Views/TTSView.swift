//
//  TTSView.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 10/08/25.
//

import SwiftUI

struct TTSView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "waveform.and.mic")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("Teka-Teki Silang")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                
                Text("-")
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
            .navigationTitle("TTS")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.blue)
                .frame(width: 20)
            
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Spacer()
        }
    }
}

#Preview {
    TTSView()
}
