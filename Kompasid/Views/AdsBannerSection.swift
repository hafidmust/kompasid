//
//  AdsBannerSection.swift
//  Kompasid
//
//  Created by Hafid Ali Mustaqim on 08/08/25.
//

import SwiftUI

struct AdsBannerSection: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("img_ads_banner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
    }
}

#Preview {
    AdsBannerSection()
        .previewLayout(.sizeThatFits)
} 