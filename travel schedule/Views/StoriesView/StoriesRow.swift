//
//  StoriesRow.swift
//  travel schedule
//
//  Created by user on 22.06.2025.
//


import SwiftUI

struct StoriesRow: View {
    private let rowHeight: Double = 140
    private let rowWidth: Double = 92
    private let description: String
    private let imageView: Image
    private let isSeen: Bool = true
    
    init(story: Story) {
        description = story.description
        imageView = story.image
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            imageView
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: StoryConstants.rowWidth, height: StoryConstants.rowHeight)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isSeen ? Color.clear : Color.customBlue, lineWidth: 4)
                )
                .opacity(isSeen ? 0.5 : 1.0)
            
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
    let story = Story(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage1"))
    StoriesRow(story: story)
}
