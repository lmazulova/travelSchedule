//
//  FullScreenStoryView.swift
//  travel schedule
//
//  Created by user on 23.06.2025.
//

import SwiftUI

struct StoryView: View {
    private let story: StoriesScreen = StoriesScreen(title: "Sample Story", description: "This is a sample story description for view. This is a sample story description for view.", image: Image("firstImage1"))
    var body: some View {
        ZStack {
            Color.blackUniversal
                .ignoresSafeArea()
            story.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .overlay {
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
                .padding(.top, 7)
                .padding(.bottom, 17)
        }
    }
}

#Preview {
    StoryView()
}
