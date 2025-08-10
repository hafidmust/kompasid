//
//  HotTopicsSection.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 05/08/25.
//

import SwiftUI

struct HotTopicsSection: View {
    let hotTopics: HotTopics
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 4, height: 24)
                
                Text(hotTopics.section)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.leading, 12)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            VStack(spacing: 8) {
                ForEach(Array(hotTopics.topics.enumerated()), id: \.offset) { index, topic in
                    TopicCard(topic: topic)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}

struct TopicCard: View {
    let topic: Topic
    
    var body: some View {
        Button(action: {
        }) {
            HStack(spacing: 12) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: getIconForTopic(topic.title))
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    )
                
                Text(topic.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 16)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func getIconForTopic(_ title: String) -> String {
        switch title {
        case "Kunjungan Paus":
            return "person.fill"
        case "Kabinet Prabowo":
            return "person.3.fill"
        case "PON 2024":
            return "sportscourt.fill"
        case "Pilkada 2024":
            return "checkmark.circle.fill"
        case "Macet Puncak":
            return "car.fill"
        default:
            return "newspaper.fill"
        }
    }
}

#Preview {
    HotTopicsSection(hotTopics: HotTopics(
        section: "Topik Hangat",
        topics: [
            Topic(title: "Kunjungan Paus", imageDescription: "Paus Fransiskus melambaikan tangan"),
            Topic(title: "Kabinet Prabowo", imageDescription: "Prabowo Subianto bersama pejabat lainnya"),
            Topic(title: "PON 2024", imageDescription: "Logo dan maskot PON 2024"),
            Topic(title: "Pilkada 2024", imageDescription: "Ilustrasi Pilkada dengan kotak suara"),
            Topic(title: "Macet Puncak", imageDescription: "Kemacetan kendaraan di jalur Puncak")
        ]
    ))
    .background(Color.gray.opacity(0.1))
    .previewLayout(.sizeThatFits)
} 
