//
//  StoriesTabView.swift
//  travel schedule
//
//  Created by user on 24.06.2025.
//

import SwiftUI

struct StoriesTabView: View {
    let stories: [StoryScreen]
    @Binding var currentStoryIndex: Int

    var body: some View {
        ZStack {
            TabView(selection: $currentStoryIndex) {
                ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                    StoryView(story: story)
                        .tag(index)
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HalfScreenTapGesture(
                onLeftTap: {previousStoryTap()},
                onRightTap: {nextStoryTap()}
            )
        }
    }
    
    func nextStoryTap() {
        currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
    }
    
    func previousStoryTap() {
        currentStoryIndex = max(currentStoryIndex - 1, 0)
    }
}


#Preview {
    struct StoriesTabViewPreviewWrapper: View {
        @State private var currentStoryIndex = 0
        
        var body: some View {
            StoriesTabView(
                stories: [
                    StoryScreen(
                        title: "Story 1",
                        description: "Description 1",
                        image: Image("firstImage1")
                    ),
                    StoryScreen(
                        title: "Story 2",
                        description: "Description 2",
                        image: Image("firstImage2")
                    )
                ],
                currentStoryIndex: $currentStoryIndex
            )
        }
    }
    
    return StoriesTabViewPreviewWrapper()
}
