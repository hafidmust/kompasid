//
//  AudioPlayerView.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 10/08/25.
//

import SwiftUI

struct AudioPlayerView: View {
    let articleModel: ArticleModel
    @StateObject private var audioManager = AudioPlayerManager.shared
    
    var body: some View {
        if let audioURL = articleModel.audioURL {
            VStack(spacing: 12) {
                HStack {
                    Image(systemName: "waveform")
                        .foregroundColor(.blue)
                        .font(.system(size: 16))
                    
                    Text("Audio Artikel")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                
                VStack(spacing: 8) {
                    if audioManager.duration > 0 {
                        ProgressView(value: audioManager.currentTime, total: audioManager.duration)
                            .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                            .scaleEffect(y: 2)
                    } else {
                        ProgressView(value: 0.0)
                            .progressViewStyle(LinearProgressViewStyle(tint: .gray))
                            .scaleEffect(y: 2)
                    }
                    
                    HStack {
                        Text(formatTime(audioManager.currentTime))
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text(formatTime(audioManager.duration))
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                HStack(spacing: 24) {
                    Spacer()
                    
                    Button(action: {
                        let newTime = max(0, audioManager.currentTime - 10)
                        audioManager.seek(to: newTime)
                    }) {
                        Image(systemName: "gobackward.10")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                    }
                    .disabled(!audioManager.isCurrentAudio(urlString: audioURL))
                    
                    Button(action: {
                        if audioManager.isLoading {
                            return
                        }
                        audioManager.playAudio(from: audioURL, title: articleModel.title)
                    }) {
                        ZStack {
                            Circle()
                                .fill(audioManager.isLoading ? Color.gray : Color.blue)
                                .frame(width: 50, height: 50)
                            
                            if audioManager.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            } else if audioManager.isCurrentlyPlaying(urlString: audioURL) {
                                Image(systemName: "pause.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                            } else {
                                Image(systemName: "play.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                            }
                        }
                    }
                    .disabled(audioManager.isLoading)
                    
                    Button(action: {
                        let newTime = min(audioManager.duration, audioManager.currentTime + 10)
                        audioManager.seek(to: newTime)
                    }) {
                        Image(systemName: "goforward.10")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                    }
                    .disabled(!audioManager.isCurrentAudio(urlString: audioURL))
                    
                    Spacer()
                }
                
                if audioManager.isCurrentAudio(urlString: audioURL) && audioManager.currentArticleTitle != nil {
                    HStack {
                        Image(systemName: "speaker.wave.2")
                            .foregroundColor(.blue)
                            .font(.system(size: 12))
                        
                        Text("Sedang memutar")
                            .font(.system(size: 12))
                            .foregroundColor(.blue)
                        
                        Spacer()
                    }
                }
            }
            .padding(16)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
        }
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

struct CompactAudioPlayerButton: View {
    let articleModel: ArticleModel
    @StateObject private var audioManager = AudioPlayerManager.shared
    
    private var isThisAudioCurrent: Bool {
        guard let audioURL = articleModel.audioURL else { return false }
        return audioManager.isCurrentAudio(urlString: audioURL)
    }
    
    private var isThisAudioPlaying: Bool {
        guard let audioURL = articleModel.audioURL else { return false }
        return audioManager.isCurrentlyPlaying(urlString: audioURL)
    }
    
    private var isThisAudioLoading: Bool {
        guard let audioURL = articleModel.audioURL else { return false }
        return audioManager.isLoading && audioManager.isCurrentAudio(urlString: audioURL)
    }
    
    var body: some View {
        if let audioURL = articleModel.audioURL {
            Button(action: {
                if audioManager.isLoading && !isThisAudioCurrent {
                    return
                }
                audioManager.playAudio(from: audioURL, title: articleModel.title)
            }) {
                ZStack {
                    Circle()
                        .fill(isThisAudioCurrent ? Color.blue.opacity(0.2) : Color.blue.opacity(0.1))
                        .frame(width: 32, height: 32)
                    
                    if isThisAudioLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(0.6)
                    } else if isThisAudioPlaying {
                        Image(systemName: "pause.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 12))
                    } else if isThisAudioCurrent {
                        Image(systemName: "play.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 12))
                    } else {
                        Image(systemName: "headphones")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                }
            }
            .disabled(audioManager.isLoading && !isThisAudioCurrent)
        } else {
            Button(action: {}) {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "headphones")
                            .foregroundColor(.gray.opacity(0.5))
                            .font(.system(size: 14))
                    )
            }
            .disabled(true)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        AudioPlayerView(
            articleModel: ArticleModel(
                id: nil,
                title: "Sample Article",
                publishedTime: nil,
                category: nil,
                description: nil,
                imageDescription: nil,
                mediaCount: nil,
                audioURL: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
            )
        )
        
        CompactAudioPlayerButton(
            articleModel: ArticleModel(
                id: nil,
                title: "Sample Article",
                publishedTime: nil,
                category: nil,
                description: nil,
                imageDescription: nil,
                mediaCount: nil,
                audioURL: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
            )
        )
    }
    .padding()
}