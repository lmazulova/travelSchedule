//
//  StoriesRow.swift
//  travel schedule
//
//  Created by user on 22.06.2025.
//


import SwiftUI

struct StoriesPreviewRow: View {
    private let rowHeight: Double = 140
    private let rowWidth: Double = 92
    private let lineWidth: Double = 4
    private let description: String
    private let imageView: Image
    private let isSeen: Bool
    private let imageRadius: CGFloat = 16
    
    init(story: Stories, isSeen: Bool) {
        //мне кажется force unwrap здесь не критичен, т.к. у нас захардкоженные данные
        let firstScreen = story.storiesScreens.first!
        description = firstScreen.description
        imageView = firstScreen.image
        self.isSeen = isSeen
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            imageView
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: StoryConstants.rowWidth, height: StoryConstants.rowHeight)
                .clipShape(RoundedRectangle(cornerRadius: imageRadius))
                .overlay(
                    // От радиуса изображения нужно отнять половину ширины линии, чтобы углы изображения и обводки совпадали.
                    RoundedRectangle(cornerRadius: imageRadius - lineWidth/2)
                        .stroke(isSeen ? Color.clear : Color.customBlue, lineWidth: lineWidth)
                        .frame(width: rowWidth - lineWidth, height: rowHeight - lineWidth)
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
//    let story = StoriesScreen(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage1"))
//    StoriesPreviewRow(story: story, isSeen: true)
//    StoriesPreviewRow(story: story, isSeen: false)
}
