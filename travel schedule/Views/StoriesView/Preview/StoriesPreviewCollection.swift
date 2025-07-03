//
//  StoriesCollection.swift
//  travel schedule
//
//  Created by user on 22.06.2025.
//

import SwiftUI

enum StoryConstants {
    static let rowHeight: CGFloat = 140
    static let rowWidth: CGFloat = 92
}

struct StoriesPreviewCollection: View {
    @EnvironmentObject var viewedStories: ViewedStoriesStore
    @State private var selectedStories: Story? = nil
    
    private let stories: [Story] = [.story1, .story2, .story3, .story4, .story5, .story6, .story7, .story8, .story9]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(stories) { stories in
                    StoriesPreviewRowView(story: stories, isSeen: viewedStories.isViewed(stories.id))
                        .onTapGesture {
                            selectedStories = stories
                        }
                }
            }
        }
        .frame(height: StoryConstants.rowHeight)
        .fullScreenCover(item: $selectedStories){ stories in
            StoriesView(stories: stories.storiesScreens)
                .onDisappear {
                    viewedStories.markAsViewed(stories.id)
                }
        }
    }
}

#Preview {
    StoriesPreviewCollection()
        .environmentObject(ViewedStoriesStore())
}
