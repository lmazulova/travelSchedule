//
//  FullScreenStoryView.swift
//  travel schedule
//
//  Created by user on 23.06.2025.
//

import SwiftUI

struct StoryView: View {
    let story: StoryScreen
    
    var body: some View {
        ZStack {
            backgroundView
            imageView
        }
    }
    
    private var backgroundView: some View {
        Color.blackUniversal
            .ignoresSafeArea()
    }
    
    private var imageView: some View {
        story.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .overlay(overlayView)
            .padding(.top, 7)
            .padding(.bottom, 17)
    }
    
    private var overlayView: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                Text(story.title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(Color.white)
                Text(story.description)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(Color.white)
            }
            .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
        }
    }
}

#Preview {
    StoryView(
        story: StoryScreen(
            title: "Sample Story",
            description: "This is a sample description for the story. It should be visible at the bottom of the image.",
            image: Image("firstImage1")
        )
    )
}
