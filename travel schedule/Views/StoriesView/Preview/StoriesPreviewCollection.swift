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
    @StateObject var viewedStories = ViewedStoriesStore()
    
    private let stories: [Stories] = [.stories1, .stories2, .stories3, .stories4, .stories5, .stories6, .stories7, .stories8, .stories9]
    
//    init(stories: [Story]) {
//        self.stories = stories
//    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(stories) { story in
//                  мне кажется force unwrap здесь не критичен, т.к. у нас захардкоженные данные
                    let firstScreen = story.storiesScreens.first!
                    StoriesPreviewRow(story: firstScreen, isSeen: viewedStories.isViewed(firstScreen.id))
                }
            }
        }
        .frame(height: StoryConstants.rowHeight)
    }
}


#Preview {
    StoriesPreviewCollection()
}
