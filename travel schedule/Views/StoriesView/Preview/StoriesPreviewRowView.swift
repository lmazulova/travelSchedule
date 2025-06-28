//
//  StoriesRow.swift
//  travel schedule
//
//  Created by user on 22.06.2025.
//


import SwiftUI

private extension CGFloat {
    static let storiesRowHeight: CGFloat = 140
    static let storiesRowWidth: CGFloat = 92
    static let storiesLineWidth: CGFloat = 4
    static let storiesImageRadius: CGFloat = 16
}

struct StoriesPreviewRowView: View {
    private let description: String
    private let imageView: Image
    private let isSeen: Bool
    
    init(story: Story, isSeen: Bool) {
        description = story.storiesScreens[0].description
        imageView = story.storiesScreens[0].image
        self.isSeen = isSeen
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            imageView
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: StoryConstants.rowWidth, height: StoryConstants.rowHeight)
                .clipShape(RoundedRectangle(cornerRadius: .storiesImageRadius))
                .overlay(
                    // От радиуса изображения нужно отнять половину ширины линии, чтобы углы изображения и обводки совпадали.
                    RoundedRectangle(cornerRadius: .storiesImageRadius - .storiesLineWidth/2)
                        .stroke(isSeen ? Color.clear : Color.customBlue, lineWidth: .storiesLineWidth)
                        .frame(width: .storiesRowWidth - .storiesLineWidth, height: .storiesRowHeight - .storiesLineWidth)
                )
                .opacity(isSeen ? 0.5 : 1.0)
                .animation(.easeInOut, value: isSeen)
            
            Text(description)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.white)
                .padding(.init(top: 0, leading: 8, bottom: 12, trailing: 8))
                .lineLimit(3)
        }
        .frame(width: StoryConstants.rowWidth, height: StoryConstants.rowHeight)
    }
}

#Preview {
    HStack(spacing: 12) {
        StoriesPreviewRowView(story: .story1, isSeen: false)
        StoriesPreviewRowView(story: .story1, isSeen: true)
    }
    .padding()
    .background(Color.gray.opacity(0.2))
}
