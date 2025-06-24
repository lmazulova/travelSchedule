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
    @State private var selectedStories: Stories? = nil
    
    private let stories: [Stories] = [.stories1, .stories2, .stories3, .stories4, .stories5, .stories6, .stories7, .stories8, .stories9]
    
//    init(stories: [Story]) {
//        self.stories = stories
//    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(stories) { stories in
                    StoriesPreviewRow(story: stories, isSeen: viewedStories.isViewed(stories.id))
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
}
