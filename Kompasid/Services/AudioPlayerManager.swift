//
//  AudioPlayerManager.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 10/08/25.
//

import Foundation
import AVFoundation
import Combine

class AudioPlayerManager: NSObject, ObservableObject {
    static let shared = AudioPlayerManager()
    
    private var audioPlayer: AVAudioPlayer?
    private var currentURL: String?
    
    @Published var isPlaying = false
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    @Published var isLoading = false
    @Published var currentArticleTitle: String?
    
    private var timer: Timer?
    
    private override init() {
        super.init()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
    
    func playAudio(from urlString: String, title: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid audio URL: \(urlString)")
            return
        }
        
        if currentURL == urlString && audioPlayer != nil {
            if isPlaying {
                pause()
            } else {
                resume()
            }
            return
        }
        
        stop()
        
        currentURL = urlString
        currentArticleTitle = title
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    print("Error downloading audio: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No audio data received")
                    return
                }
                
                do {
                    self?.audioPlayer = try AVAudioPlayer(data: data)
                    self?.audioPlayer?.delegate = self
                    self?.audioPlayer?.prepareToPlay()
                    
                    self?.duration = self?.audioPlayer?.duration ?? 0
                    self?.audioPlayer?.play()
                    self?.isPlaying = true
                    self?.startTimer()
                } catch {
                    print("Error creating audio player: \(error)")
                }
            }
        }.resume()
    }
    
    func pause() {
        audioPlayer?.pause()
        isPlaying = false
        stopTimer()
    }
    
    func resume() {
        audioPlayer?.play()
        isPlaying = true
        startTimer()
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlaying = false
        currentTime = 0
        currentURL = nil
        currentArticleTitle = nil
        stopTimer()
    }
    
    func seek(to time: TimeInterval) {
        audioPlayer?.currentTime = time
        currentTime = time
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.audioPlayer else { return }
            self.currentTime = player.currentTime
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func isCurrentlyPlaying(urlString: String) -> Bool {
        guard let currentURL = currentURL else { return false }
        return currentURL == urlString && isPlaying
    }
    
    func isCurrentAudio(urlString: String) -> Bool {
        guard let currentURL = currentURL else { return false }
        return currentURL == urlString
    }
}

extension AudioPlayerManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            self.isPlaying = false
            self.currentTime = 0
            self.stopTimer()
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        DispatchQueue.main.async {
            print("Audio player decode error: \(error?.localizedDescription ?? "Unknown error")")
            self.stop()
        }
    }
}