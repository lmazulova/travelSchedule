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

struct StoriesCollection: View {
    private let stories: [Story] = [
        Story(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage1")),
        Story(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage1")),
        Story(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage1")),
        Story(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage1")),
        Story(title: "Sample Story", description: "This is a sample story description for view.", image: Image("firstImage1"))
    ]
    
//    init(stories: [Story]) {
//        self.stories = stories
//    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(stories) { story in
                    StoriesRow(story: story)
                }
            }
        }
        .frame(height: StoryConstants.rowHeight)
    }
}


#Preview {
    StoriesCollection()
}
