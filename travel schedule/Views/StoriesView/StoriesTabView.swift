//
//  StoriesTabView.swift
//  travel schedule
//
//  Created by user on 24.06.2025.
//

import SwiftUI

struct StoriesTabView: View {
    let stories: [StoriesScreen]
    @Binding var currentStoryIndex: Int

    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                StoryView(story: story)
                    .onTapGesture {
                        didTapStory()
                    }
                    .tag(index)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }

    func didTapStory() {
        currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
    }
}
