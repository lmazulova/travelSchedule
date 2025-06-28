//
//  ProgressBar.swift
//  travel schedule
//
//  Created by user on 23.06.2025.
//

import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 6
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundColor(.white)

                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundColor(.customBlue)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ProgressBar(numberOfSections: 5, progress: 0.2)
            .frame(height: .progressBarHeight)
            .padding()

        ProgressBar(numberOfSections: 5, progress: 0.5)
            .frame(height: .progressBarHeight)
            .padding()

        ProgressBar(numberOfSections: 5, progress: 0.8)
            .frame(height: .progressBarHeight)
            .padding()
    }
    .background(Color.gray.opacity(0.2))
    .frame(width: 200)
}
